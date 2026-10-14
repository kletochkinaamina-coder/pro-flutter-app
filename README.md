# Pro Flutter: одно приложение по всем урокам

Курс: [Pro Flutter уроки на русском](https://www.udemy.com/course/pro_flutter/) (Udemy), 17 уроков, 5 разделов.

Главный экран это меню с уроками. Каждый урок открывается отдельным экраном, весь код урока лежит в своей папке `lib/lessons/`.

## Запуск

```bash
# 1. Один раз: создать платформенные папки (android, ios, web, windows, macos, linux).
#    lib/, pubspec.yaml и assets/ команда не трогает.
flutter create . --org com.example --project-name pro_flutter_app

# 2. Зависимости и запуск
flutter pub get
flutter run                 # выбрать устройство
flutter run -d chrome       # web
flutter run -d windows      # desktop (windows, macos или linux)

# Проверка кода и тест
dart format lib test
flutter analyze
flutter test
```

Нужен Flutter 3.27 или новее.

## Уроки

| # | Урок | Папка | Что внутри |
|---|------|-------|------------|
| 1 | Установка и создание приложения | `lesson_01_first_app` | Первый экран, точка входа `main` и `runApp` |
| 2 | Структура приложения | `lesson_02_app_structure` | `MaterialApp`, `Scaffold` и все его слоты |
| 3 | Stateless виджеты | `lesson_03_stateless` | Свои виджеты, параметры через конструктор |
| 4 | Stateful виджеты | `lesson_04_stateful` | `State`, `setState`, `initState`, `dispose` |
| 5 | Container и BoxDecoration | `lesson_05_container` | Размеры, отступы, рамка, градиент, тень, круг, картинка |
| 6 | Column и Row | `lesson_06_column_row` | Песочница со всеми параметрами осей |
| 7 | ListView | `lesson_07_listview` | `children`, `builder`, `separated`, `custom`, горизонтальный |
| 8 | GridView | `lesson_08_gridview` | `count`, `extent`, `builder`, `custom` |
| 9 | PageView | `lesson_09_pageview` | `PageController`, `animateToPage`, `jumpToPage` |
| 10 | Stack, Positioned, IndexedStack | `lesson_10_stack` | Слои, карточка с фото, анимация переключения |
| 11 | Изменение шрифта | `lesson_11_fonts` | Свой шрифт из assets, `google_fonts` |
| 12 | Добавление картинок | `lesson_12_images` | `Image.asset`, `network`, `fit`, SVG через `flutter_svg` |
| 13 | Собственная тема | `lesson_13_theme` | `ThemeData`, `TextTheme`, темы кнопок и иконок, тёмная тема. Тема применена ко всему приложению |
| 14 | Маршруты и Navigator | `lesson_14_navigation` | `push`, `pop`, `pushNamed`, результат из `pop` |
| 15 | Передача параметров | `lesson_15_route_params` | Конструктор, `arguments`, `onGenerateRoute`. Генератор маршрутов всего приложения: `lib/app/app_router.dart` |
| 16 | Десктопное приложение | `lesson_16_desktop` | Адаптивный интерфейс, горячие клавиши |
| 17 | Web, Firebase, GitHub Actions | `lesson_17_web_firebase` | Адаптивная страница, деплой |

## Структура

```
lib/
  main.dart               точка входа, тема и маршруты
  app/                    меню, список уроков, генератор маршрутов
  lessons/lesson_NN_*/    код каждого урока (lesson_page.dart)
assets/                   шрифт Lobster (урок 11), картинки (урок 12)
firebase.json             конфиг Firebase Hosting (урок 17)
.github/workflows/        автодеплой web на Firebase (урок 17)
```

## Релизные сборки (уроки 16 и 17)

```bash
flutter build windows --release     # build/windows/x64/runner/Release
flutter build macos --release       # build/macos/Build/Products/Release
flutter build linux --release       # build/linux/x64/release/bundle
flutter build web --release         # build/web
```

Деплой web на Firebase Hosting вручную:

```bash
npm install -g firebase-tools
firebase login
firebase init hosting:github        # привяжет репозиторий и создаст секрет
firebase deploy --only hosting
```

Перед этим впишите id своего проекта в `.firebaserc` и в `.github/workflows/firebase-hosting.yml`.

## Источники

Код написан по темам видео курса и описаниям уроков. Для сверки использован публичный репозиторий автора: https://github.com/sly13/proflutter (ветки `lesson_1` ... `lesson_17`).
