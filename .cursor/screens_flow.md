- **App Navigation**
  - **Authentication**
    - *Login Screen*
      - Login button: -> Main/Home Screen (upon successful login)
      - Register link: -> Registration Screen
      - Forgot password: -> Password Reset Dialog
      - Social login options: Triggers external authentication flows (e.g., Google, Facebook)
    - *Registration Screen*
      - Register button: -> Main/Home Screen (upon successful registration)
      - Profile picture upload: -> Image Picker Dialog
      - Terms acceptance: Required for registration

  - **Main/Home Screen**
    - *Bottom navigation:*
      - -> Map and Navigation Screen
      - -> Discover Routes Screen
      - -> Profile Screen
      - -> Groups Screen
      - -> Events Screen
      - -> Settings Screen
    - Search: -> Search Dialog/Screen
    - Notifications: -> Notifications Screen/Dialog
    - Recent activity feed: Select item -> Route Detail Screen / Event Detail Screen
    - Upcoming events summary: Select event -> Event Detail Screen
    - Recommended routes carousel: Select route -> Route Detail Screen

  - **Map and Navigation Screen**
    - Start recording: Activates recording controls
    - Stop recording: -> Save Route Dialog (input name, description, privacy settings)
    - View route: -> Route Detail Screen
    - Waypoint marking: -> Waypoint Dialog (add name, description)
    - Save route: -> Save Route Dialog
    - Share: -> Share Bottom Sheet

  - **Discover Routes Screen**
    - Select route: -> Route Detail Screen
    - Search bar: Activates search functionality
    - Filters: -> Filter Dialog/Bottom Sheet (distance, duration, difficulty, etc.)
    - Sort options: -> Sort Options Bottom Sheet (popularity, distance, rating)
    - Map view: Select route -> Route Detail Screen

  - **Route Detail Screen**
    - Start navigation: -> Map and Navigation Screen (route loaded)
    - Save route: -> Confirmation Dialog
    - Create event: -> Event Creation Screen (route pre-selected)
    - View reviews: Scrolls to reviews section / -> Reviews Dialog
    - Download for offline: Initiates download process
    - Share: -> Share Bottom Sheet

  - **Profile Screen**
    - Edit profile: -> Edit Profile Dialog/Screen
    - View activity: Displays Activity Feed
      - Select activity: -> Route Detail Screen / Event Detail Screen
    - View achievements: Displays Achievements Section
    - *Created content tabs:*
      - Routes: Select route -> Route Detail Screen
      - Events: Select event -> Event Detail Screen
      - Groups: Select group -> Group Detail Screen
    - Following/followers: -> Following/Followers List Screen
    - Settings: -> Settings Screen

  - **Groups Screen**
    - Select group: -> Group Detail Screen
    - Create group: -> Group Creation Dialog/Screen
    - Discover groups: Join group -> Confirmation Dialog
    - Search: Activates search functionality
    - Filter: -> Filter Dialog/Bottom Sheet (category, location, etc.)

  - **Group Detail Screen**
    - Join/leave group: -> Confirmation Dialog
    - Post update: -> Post Creation Dialog/Bottom Sheet
    - View members: -> Members List Screen
    - View activity: Displays group activity feed
    - Upcoming events: Select event -> Event Detail Screen
    - Route collection: Select route -> Route Detail Screen
    - Discussion board: Post/Comment -> Reply Dialog

  - **Events Screen**
    - Select event: -> Event Detail Screen
    - Create event: -> Event Creation Screen
    - Filter events: -> Filter Dialog/Bottom Sheet (type, date, location)
    - Calendar view: Select date to filter events
    - My events: Select event -> Event Detail Screen

  - **Event Detail Screen**
    - Join/leave event: -> Confirmation Dialog
    - View participants: -> Participants List Screen
    - View route: -> Route Detail Screen
    - Discussion section: Post/Comment functionality
    - Equipment checklist: Interact with items -> Check Item Dialog
    - Weather forecast: Displays weather information
    - Share: -> Share Bottom Sheet

  - **Route Creation Screen**
    - Draw route: Interactive map for route creation
    - Add waypoints: -> Waypoint Dialog (add points of interest)
    - Metadata form: Input fields (name, description, difficulty)
    - Attach media: -> Image Picker Dialog
    - Preview route: Displays route preview
    - Save route: -> Save Route Dialog (privacy settings)

  - **Settings Screen**
    - Account settings: Edit info -> Edit Dialogs
    - Privacy controls: Toggle settings
    - Notification preferences: Adjust settings
    - Map display preferences: Select map options
    - Data usage settings: Configure offline modes
    - Help and support: -> Help Center Screen
    - About: Displays app information
    - Logout: -> Confirmation Dialog