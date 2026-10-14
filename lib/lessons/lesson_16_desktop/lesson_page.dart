// Урок 16. Создание и релиз десктопного приложения (Windows, macOS, Linux).
// Задание: собрать Flutter приложение под десктоп и сделать релизную сборку.
// Здесь небольшое приложение "Заметки", адаптированное под большой экран:
// боковая навигация (NavigationRail) на широком окне,
// горячие клавиши Ctrl/Cmd + N и Ctrl/Cmd + Delete, разделение на список и детали.
// Как собрать релиз: см. README.md рядом.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Экран урока 16. Открывается из главного меню.
class Lesson16Page extends StatelessWidget {
  const Lesson16Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotesHome();
  }
}

class Note {
  Note(this.title, this.body);
  String title;
  String body;
}

// Интенты для горячих клавиш.
class NewNoteIntent extends Intent {
  const NewNoteIntent();
}

class DeleteNoteIntent extends Intent {
  const DeleteNoteIntent();
}

class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  final _notes = <Note>[
    Note('Добро пожаловать', 'Это десктопное приложение на Flutter.'),
    Note('Горячие клавиши', 'Ctrl/Cmd + N создаёт заметку, Ctrl/Cmd + Delete удаляет.'),
  ];
  int _selected = 0;
  int _section = 0;

  void _add() => setState(() {
        _notes.add(Note('Новая заметка ${_notes.length + 1}', ''));
        _selected = _notes.length - 1;
      });

  void _delete() => setState(() {
        if (_notes.isEmpty) return;
        _notes.removeAt(_selected);
        _selected = (_selected - 1).clamp(0, _notes.isEmpty ? 0 : _notes.length - 1);
      });

  @override
  Widget build(BuildContext context) {
    // Shortcuts + Actions: стандартный способ повесить клавиатурные сочетания.
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyN, control: true): NewNoteIntent(),
        SingleActivator(LogicalKeyboardKey.keyN, meta: true): NewNoteIntent(),
        SingleActivator(LogicalKeyboardKey.delete, control: true): DeleteNoteIntent(),
        SingleActivator(LogicalKeyboardKey.backspace, meta: true): DeleteNoteIntent(),
      },
      child: Actions(
        actions: {
          NewNoteIntent: CallbackAction<NewNoteIntent>(onInvoke: (_) => _add()),
          DeleteNoteIntent: CallbackAction<DeleteNoteIntent>(onInvoke: (_) => _delete()),
        },
        child: Focus(
          autofocus: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 800;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Заметки'),
                  actions: [
                    IconButton(
                      tooltip: 'Новая (Ctrl+N)',
                      onPressed: _add,
                      icon: const Icon(Icons.note_add),
                    ),
                    IconButton(
                      tooltip: 'Удалить',
                      onPressed: _notes.isEmpty ? null : _delete,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
                body: Row(
                  children: [
                    if (wide)
                      NavigationRail(
                        selectedIndex: _section,
                        onDestinationSelected: (i) => setState(() => _section = i),
                        labelType: NavigationRailLabelType.all,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.notes),
                            label: Text('Все'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.info_outline),
                            label: Text('О программе'),
                          ),
                        ],
                      ),
                    Expanded(child: _section == 0 ? _notesView(wide) : const _AboutView()),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _notesView(bool wide) {
    final list = ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (context, i) => ListTile(
        selected: i == _selected,
        title: Text(_notes[i].title),
        subtitle: Text(
          _notes[i].body.isEmpty ? 'Пусто' : _notes[i].body,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () => setState(() => _selected = i),
      ),
    );
    if (_notes.isEmpty) {
      return const Center(child: Text('Нет заметок. Нажмите Ctrl+N'));
    }
    final editor = _NoteEditor(
      key: ObjectKey(_notes[_selected]),
      note: _notes[_selected],
      onChanged: () => setState(() {}),
    );
    // На широком экране список и редактор рядом, на узком только список/редактор.
    if (!wide) return Column(children: [Expanded(child: list), Expanded(child: editor)]);
    return Row(
      children: [
        SizedBox(width: 300, child: list),
        const VerticalDivider(width: 1),
        Expanded(child: editor),
      ],
    );
  }
}

class _NoteEditor extends StatelessWidget {
  const _NoteEditor({super.key, required this.note, required this.onChanged});

  final Note note;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TextFormField(
            initialValue: note.title,
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: const InputDecoration(border: InputBorder.none, hintText: 'Заголовок'),
            onChanged: (v) {
              note.title = v;
              onChanged();
            },
          ),
          Expanded(
            child: TextFormField(
              initialValue: note.body,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(border: InputBorder.none, hintText: 'Текст заметки'),
              onChanged: (v) {
                note.body = v;
                onChanged();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutView extends StatelessWidget {
  const _AboutView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Flutter Desktop: один код для Windows, macOS и Linux'),
    );
  }
}
