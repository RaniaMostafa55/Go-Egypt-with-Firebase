# 🌍 Go Egypt - Tourist Guide App

A mobile application for tourists visiting Egypt to explore landmarks, museums, and attractions across different governorates.

[Watch Demo](https://github.com/user-attachments/assets/07123288-b7c8-44e9-86e3-bcf3c1ebba0c)

## ✨ Features

- **Landmark Exploration** - Discover popular attractions across Egypt
- **Secure Authentication** 🔒
  - Firebase-powered user registration & login
  - Phone number verification (optional)
- **Real-time Favorites** ❤️
  - Add/remove favorites with Firestore sync
  - Persistent favorite items across devices
- **Multi-language Support** 🌐 (English/Arabic)
- **Dark/Light Theme** 🌓
- **User Profile Management** 👤
  - Edit personal information
  - Profile picture upload

## 🔥 Firebase Integration

### Firebase Authentication

- **Secure User Management**  
  Implemented with email/password and optional phone number authentication
- **State Persistence**  
  Maintains user session across app restarts

### Cloud Firestore

```dart
// Sample Favorites Collection Structure
{
  "enName": "Pyramids of Giza",
  "arName": "أهرامات الجيزة",
  "image": "pyramids.jpg",
  "userId": "firebase_uid",  // Reference to authenticated user
  "timestamp": FieldValue.serverTimestamp()
}
```

- **Real-time Sync** 🔄
  Instant updates for favorite items across devices
- **Optimistic UI Updates** ⚡
  Immediate visual feedback for user actions

## 📱 App Demo Video

## 🛠 Key Components

### 🔐 Authentication Flow

#### Sign Up Page

- **Form Validation** ✅
- **International Phone Input** 🌍
- **Success Dialog Feedback** 💬

#### Login Page

- **Email/Password Validation**
- **Error Handling**
- **Password Recovery Flow**

### 🏠 Home Page

```dart
GridView.builder(
  itemCount: places.length,
  itemBuilder: (context, index) => PlaceWidget(
    place: places[index],
    onFavorite: (bool isFavorite) {
      // Firestore real-time update
    },
  ),
)
```

- **Dynamic Content Loading**
- **Real-time Favorite Toggle**
- **Responsive Grid Layout**

### ⭐ Favorites System

```dart
IconButton(
  onPressed: () async {
    setState(() => _isFavorite = !_isFavorite);
    await FirestoreService().toggleFavorite(
      userId: currentUser.uid,
      place: selectedPlace
    );
  },
  icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
)
```

- **Optimistic UI Updates**
- **Batch Write Operations**
- **Offline Support**

## 🗺️ Government & Landmarks

### Government Page

- **Interactive Card List**
- **Image Loading States**

```dart
CachedNetworkImage(
  imageUrl: government.imageUrl,
  placeholder: (_, __) => CircularProgressIndicator(),
  errorWidget: (_, __, ___) => Icon(Icons.error),
)
```

### Landmark Details

- **High-resolution Image Gallery**
- **Location Information**
- **Cultural Context**

## 👤 Profile Management

```dart
Future<void> updateProfile() async {
  final user = FirebaseAuth.instance.currentUser;
  await Firestore.instance
      .collection('users')
      .doc(user.uid)
      .update({'name': newName});
}
```

- **Data Persistence**  
  SharedPreferences + Firestore sync
- **Editable Fields**
  - Name
  - Email
  - Phone Number
  - Profile Picture

## 🚀 Getting Started

To get started with this project, follow these steps:

1. **Clone the repository**:
   ```sh
   git clone https://github.com/RaniaMostafa55/Go-Egypt-with-Firebase.git
   ```
2. **Navigate to the project directory**:
   ```sh
   cd Go-Egypt-with-Firebase
   ```
3. **Install dependencies**:
   ```sh
   flutter pub get
   ```
4. **Run the app**:
   ```sh
   flutter run
   ```
