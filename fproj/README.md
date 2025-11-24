# BaiFlix - Flutter Web Streaming Application

A responsive Flutter web application inspired by Netflix, featuring a modern UI with multi-page navigation and content browsing.

## Features

- 🎬 **Multi-page Navigation**: Home, Browse, and Details pages
- 📱 **Responsive Design**: Works seamlessly on desktop, tablet, and mobile devices
- 🎨 **Modern UI**: Netflix-inspired dark theme with smooth animations
- 🎯 **Content Categories**: Trending, Popular, Top Rated, Action, Comedy
- 🔍 **Content Details**: Detailed view for each movie/show
- 🚀 **GitHub Pages Ready**: Configured for easy deployment

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── content.dart         # Content data model and sample data
├── pages/
│   ├── home_page.dart       # Home page with hero section
│   ├── browse_page.dart     # Browse page with categories
│   └── details_page.dart    # Content details page
├── widgets/
│   ├── nav_bar.dart         # Navigation bar component
│   ├── movie_card.dart      # Movie/show card component
│   └── content_row.dart     # Horizontal content row
└── routes/
    └── app_router.dart      # App routing configuration

assets/
└── images/
    ├── posters/             # Movie/show poster images
    └── hero/                # Hero section background images
```

## Setup Instructions

1. **Install Dependencies**

   ```bash
   flutter pub get
   ```

2. **Add Images**

   - Place movie/show poster images in `assets/images/posters/`
   - Place hero background images in `assets/images/hero/`
   - Update image paths in `lib/models/content.dart` to match your image filenames

3. **Run the Application**
   ```bash
   flutter run -d chrome
   ```

## Building for Web

1. **Build the Web App**

   ```bash
   flutter build web
   ```

2. **Deploy to GitHub Pages**
   - The built files will be in `build/web/`
   - Copy these files to your GitHub Pages repository
   - Or use GitHub Actions to automate deployment

## Pages

### Home Page (`/`)

- Hero section featuring trending content
- Multiple content rows (Trending, Popular, Top Rated, etc.)
- Responsive layout

### Browse Page (`/browse`)

- All content organized by categories
- Easy navigation through different genres

### Details Page (`/details/:id`)

- Detailed information about selected content
- Rating, year, genres, description
- Director and cast information (when available)

## Technologies Used

- **Flutter**: UI framework
- **go_router**: Navigation and routing
- **Material Design**: UI components

## Customization

### Adding New Content

Edit `lib/models/content.dart` and add new content to the appropriate lists:

- `ContentData.trending`
- `ContentData.popular`
- `ContentData.topRated`
- `ContentData.action`
- `ContentData.comedy`

### Styling

The app uses a dark theme with red accents. Customize colors in `lib/main.dart`:

```dart
theme: ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.red,
  // ... customize as needed
)
```

## Image Requirements

- **Poster Images**: Recommended size 300x450px (2:3 aspect ratio)
- **Hero Images**: Recommended size 1920x1080px (16:9 aspect ratio)
- **Formats**: JPG, PNG, or WebP

## License

This project is created for educational purposes.
"# BaiFLix" 
