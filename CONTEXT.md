# MotoMeet Flutter Application

## Project Overview

MotoMeet is a mobile application designed for off-road enthusiasts to create, share, and discover routes for various outdoor activities including motorcycling, hiking, cycling, and more. The app emphasizes social features like groups and events to build a community of outdoor adventurers.

## Tech Stack

- **Framework**: Flutter
- **State Management**: Riverpod
- **Database**: Isar (local NoSQL database)
- **API Communication**: Custom HTTP client
- **Authentication**: JWT-based
- **Navigation**: Custom route generator
- **Maps**: Integration with mapping services for route tracking and visualization
- **Local Storage**: Shared Preferences for user settings and tokens

## Application Architecture

### Core Architecture

The application follows a service-oriented architecture with:

1. **Models**: Data structures that represent the domain entities
2. **Services**: Business logic and data operations
3. **Providers**: State management using Riverpod
4. **UI Components**: Screens and widgets
5. **Routing**: Custom route generation and navigation

### Data Flow

```
UI Components <-> Providers <-> Services <-> Local Database (Isar) / Remote API
```

## Project Structure

lib/
```
│   main.dart
│   
├───models
│       activity.dart
│       enum.dart
│       event.dart
│       geoLocationInfo.dart
│       group.dart
│       mapMarker.dart
│       newRoute.dart
│       notification.dart
│       route.dart
│       route.g.dart
│       subscriber.dart
│       tempmodel
│       userModel.dart
│       userModel.g.dart
│       
├───providers
│       activity_provider.dart
│       create_event_provider.dart
│       events_provider.dart
│       event_details_provider.dart
│       event_participants_provider.dart
│       home_screen_provider.dart
│       routes_provider.dart
│       
├───routing
│       InitialRoute.dart
│       routeGenerator.dart
│       routes.dart
│       
├───screens
│       create_event_screen.dart
│       eventDeailesScreen.dart
│       event_details_screen.dart
│       homeScreen.dart
│       loginScreen.dart
│       mapScreen.dart
│       routeDetailsScreen.dart
│       saveRouteScreen.dart
│       singupScreen.dart
│       step1.dart
│       userProfileScreen.dart
│       
├───services
│   │   activity_service.dart
│   │   authService.dart
│   │   bottomSheetServices.dart
│   │   distanceFormatter.dart
│   │   events_service.dart
│   │   httpClient.dart
│   │   loctionService.dart
│   │   MapMarkerService.dart
│   │   routeService.dart
│   │   service_locator.dart
│   │   userService.dart
│   │   
│   └───isar
│           isar_activity.dart
│           isar_geo_location.dart
│           isar_initializer.dart
│           isar_reposetory.dart
│           isar_repository.dart
│           isar_user_info.dart
│           reposetory_provider.dart
│           repository_provider.dart
│           
├───utilities
│       apiEndPoints.dart
│       appIcons.dart
│       assetLoader.dart
│       duration_formatter.dart
│       isarConverters.dart
│       
└───widgets
    │   bottomNavigation.dart
    │   customTextFromField.dart
    │   dropdown.dart
    │   event_card.dart
    │   event_item_form.dart
    │   event_participant_list.dart
    │   event_stages_list.dart
    │   event_stage_form.dart
    │   expandableFAB.dart
    │   ExpandablePanel.dart
    │   loading_indicator.dart
    │   mapButtons.dart
    │   route_card.dart
    │   selecetMapProvider.dart
    │   wayPointBottomSheet.dart
    │   
    └───dialogs
            chooseRouteTypeDialog.dart
            confirmation_dialog.dart
            stopRoutedialog.dart

```

## Key Data Models

### UserInfo

The primary user model that contains:
- Basic information (username, name, email, contact details)
- Profile attributes (bio, profile picture)
- Statistics (total distance)
- Authentication data (token)
- Relationships to other entities (followers, groups, events)

### RouteModel

Represents a tracked route with:
- Route metadata (name, description, difficulty level, type)
- Geographic data (coordinates, waypoints, elevation)
- Statistics (distance, duration, average speed)
- User association (creator)
- Media attachments (photos, videos)
- Reviews and ratings

### GroupModel

Community group structure:
- Group details (name, description, image)
- Membership information
- Associated routes and events
- Discussion and activity feed

### EventModel

Represents organized activities:
- Event details (title, description, date/time)
- Location information
- Participant management
- Associated routes
- Equipment requirements
- Stages for multi-day events

## Detailed Screen Implementations

### 1. Authentication Screens

#### Login Screen
- **Purpose**: User authentication via email/password
- **Key Components**:
  - Email and password input fields with validation
  - Remember me toggle
  - Login button with loading state
  - Social login options (Google, Facebook)
  - Registration link
  - Password reset functionality
- **Implementation Notes**:
  - Use Form widget with TextFormField for validation
  - Connect to AuthenticationService for API calls
  - Store JWT token in secure storage
  - Handle error states with user-friendly messages

#### Registration Screen
- **Purpose**: New user account creation
- **Key Components**:
  - Personal information fields (name, email, username)
  - Password creation with strength indicator
  - Profile picture upload option
  - Terms and conditions acceptance
  - Registration button with loading state
- **Implementation Notes**:
  - Multi-step registration process for improved UX
  - Image picker integration for profile photos
  - Server-side validation response handling
  - Auto-login after successful registration

### 2. Main/Home Screen

- **Purpose**: Central hub for app navigation and content discovery
- **Key Components**:
  - Bottom navigation bar for primary sections
  - Recent activity feed
  - Upcoming events summary
  - Recommended routes carousel
  - Suggestions for popular routes based on user preferences and community engagement
  - Suggestions for nearby events based on user location
  - Quick search functionality
  - Notification indicator
- **Implementation Notes**:
  - Use TabBarView or PageView for section navigation
  - Implement pull-to-refresh for content updates
  - Lazy loading for feed items with pagination
  - Cache frequently accessed data locally
  - Algorithm for route popularity calculation based on views, ratings, and completions
  - Geolocation-based filtering for nearby event suggestions
  - Scheduled background fetching for updated suggestions
  - Personalized recommendation engine based on user activity history

### 3. Map and Navigation Screen

- **Purpose**: Route tracking, recording, and navigation
- **Key Components**:
  - Interactive map with multiple view types (classic, satellite, topographic)
  - Current location tracking
  - Route recording controls (start, pause, stop)
  - Real-time statistics display (speed, distance, duration)
  - Waypoint marking functionality
  - Route saving and sharing options
- **Implementation Notes**:
  - Integrate with Flutter_map or Google Maps Flutter
  - Implement location services with geolocator package
  - Use ChangeNotifierProvider for real-time tracking state
  - Background location tracking service
  - Battery optimization considerations
  - Offline map caching for remote areas

### 4. Discover Routes Screen

- **Purpose**: Browse, search, and filter available routes
- **Key Components**:
  - Search bar with advanced filters
  - Category selection (activity type, difficulty)
  - Map view for geographic browsing
  - List view with route cards
  - Sort options (popularity, distance, rating)
  - Filter panel (distance, duration, elevation)
- **Implementation Notes**:
  - Implement search delegate for robust searching
  - Use animated filtering transitions
  - Implement location-based sorting
  - Cache search results for offline access
  - Pagination for large result sets

### 5. Route Detail Screen

- **Purpose**: Display comprehensive information about a specific route
- **Key Components**:
  - Route header with key statistics
  - Interactive map showing the route
  - Elevation profile graph
  - Photo gallery
  - Reviews and ratings section
  - Weather information for the route area
  - Download for offline use option
  - Navigation and tracking buttons
- **Implementation Notes**:
  - Use SliverAppBar for collapsible header
  - Implement custom charts for elevation profile
  - Integrate carousel for photo gallery
  - Lazy load reviews with pagination
  - Cache route data for offline viewing

### 6. Profile Screen

- **Purpose**: User profile management and activity display
- **Key Components**:
  - Profile header with user stats
  - Achievement badges
  - Activity feed showing completed routes
  - Created content tabs (routes, events, groups)
  - Following/followers management
  - Settings access
  - Edit profile functionality
- **Implementation Notes**:
  - TabBarView for content organization
  - Implement custom animations for stats
  - Use Hero animations for profile picture transitions
  - Implement pull-to-refresh for activity updates
  - Optimize image loading for performance

### 7. Groups Screen

- **Purpose**: Discover and manage group memberships
- **Key Components**:
  - Joined groups list
  - Discover groups section
  - Create group button
  - Search and filter functionality
  - Group activity notifications
  - Group recommendations
- **Implementation Notes**:
  - Implement search functionality with filters
  - Use ListView.builder for efficient lists
  - Implement infinite scroll for large group lists
  - Add pull-to-refresh functionality
  - Cache group data for offline viewing

### 8. Group Detail Screen

- **Purpose**: View and interact with a specific group
- **Key Components**:
  - Group header with join/leave functionality
  - Member list with roles
  - Activity feed
  - Upcoming events section
  - Route collection
  - Discussion board
  - Group settings (for admins)
- **Implementation Notes**:
  - Use TabBarView for content sections
  - Implement role-based UI adjustments
  - Real-time updates for discussions
  - Optimize image loading for galleries
  - Implement post creation with rich text editor

### 9. Events Screen

- **Purpose**: Discover, join, and manage events
- **Key Components**:
  - Calendar view for upcoming events
  - Event cards with key information
  - Filters for event types and dates
  - My events section (joined/created)
  - Create event button
  - Event notifications
- **Implementation Notes**:
  - Implement custom calendar widget
  - Use List/GridView for event listings
  - Add animations for state changes
  - Implement date-based filtering
  - Location-based event recommendations

### 10. Event Detail Screen

- **Purpose**: View and manage a specific event
- **Key Components**:
  - Event header with key information
  - Join/leave functionality
  - Participant list
  - Associated route display
  - Discussion section
  - Equipment checklist
  - Weather forecast
  - Stages breakdown (for multi-day events)
  - Share functionality
- **Implementation Notes**:
  - Use ExpandablePanel for sections
  - Implement interactive checklist
  - Add map widget for location preview
  - Real-time participant updates
  - Weather API integration
  - Calendar integration for reminders

### 11. Route Creation Screen

- **Purpose**: Create and edit routes
- **Key Components**:
  - Map for route drawing/editing
  - Route metadata form
  - Point of interest markers
  - Difficulty setting
  - Photo/media attachment
  - Route preview
  - Privacy settings
- **Implementation Notes**:
  - Custom map interaction for route drawing
  - Form validation for metadata
  - Image compression before upload
  - Background upload service
  - Progress indicators for long operations
  - Autosave functionality

### 12. Settings Screen

- **Purpose**: Configure app preferences and user settings
- **Key Components**:
  - Account settings section
  - Privacy controls
  - Notification preferences
  - Map display preferences
  - Data usage settings
  - Help and support access
  - About section
  - Logout functionality
- **Implementation Notes**:
  - Use SwitchListTile for toggles
  - Implement controller for settings persistence
  - Add animations for section expansion
  - Clear visual grouping of related settings
  - Confirmation dialogs for sensitive actions

## API Integration

The application communicates with the MotoMeet backend API for data operations. Key endpoint groups include:

- `/api/auth` - Authentication endpoints (login, register, token refresh)
- `/api/users` - User profile and follow management
- `/api/routes` - Route creation, discovery, and management
- `/api/groups` - Group operations and membership
- `/api/events` - Event creation and participation
- `/api/media` - Media upload and management

## Local Data Persistence

The app uses multiple strategies for local data:

1. **Isar Database** - For complex structured data like user profiles, routes, and offline content
2. **Shared Preferences** - For user settings and session information
3. **Secure Storage** - For sensitive data like authentication tokens
4. **File System** - For cached media and map data

## Performance Considerations

- Lazy loading for list items
- Image caching and compression
- Background processing for uploads
- Efficient state management with Riverpod
- Debouncing for search operations
- Pagination for large data sets
- Optimized map rendering

## Security Implementation

- JWT token management with refresh mechanisms
- Secure storage for sensitive data
- Certificate pinning for API communication
- Input validation and sanitization
- Permission-based UI adaptations
- Biometric authentication option

## Offline Capabilities

- Route caching for offline viewing
- Offline map data
- Queue system for actions performed offline
- Sync mechanisms when connectivity is restored
- Conflict resolution for concurrent changes

## Accessibility Features

- Screen reader compatibility
- Scalable text
- High contrast mode
- Reduced motion option
- Voice command integration (planned)
- Alternative navigation methods

## Testing Approach

- Widget tests for UI components
- Unit tests for services and utilities
- Integration tests for key user flows
- Automated performance testing
- User testing for UX validation

## Future Enhancements

- Advanced route analytics
- AI-powered route recommendations
- Augmented reality navigation
- Community challenges and competitions
- Integration with wearable devices
- Voice-guided navigation
