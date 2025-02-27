 

// -------------- Route Screen --------------
class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  // Keys to identify each section
  final GlobalKey _detailsKey = GlobalKey();
  final GlobalKey _weatherKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _mediaKey = GlobalKey();

  // Store the top offsets for each section (we’ll calculate after the layout)
  final List<double> _sectionOffsets = [0, 0, 0, 0];

  // Adjust this if you want to account for pinned heights (AppBar, Tab bar).
  // The pinned SliverAppBar collapses, so we only have a pinned 50px tab bar
  // once scrolled. This example approximates, but you can tweak as desired.
  final double _pinOffset = 50.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _tabController = TabController(length: 4, vsync: this);

    // Once the layout is rendered, measure and store each section's offset
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateSectionOffsets();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Calculate the Y-offset for each section by using context
  void _calculateSectionOffsets() {
    _sectionOffsets[0] = _getOffsetForKey(_detailsKey);
    _sectionOffsets[1] = _getOffsetForKey(_weatherKey);
    _sectionOffsets[2] = _getOffsetForKey(_reviewsKey);
    _sectionOffsets[3] = _getOffsetForKey(_mediaKey);
  }

  double _getOffsetForKey(GlobalKey key) {
    final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return 0;
    // Convert the box's local offset to the global coordinate system
    final position = box.localToGlobal(Offset.zero);
    // Then we add the current scroll offset so we have a stable reference.
    // For pinned bars, you might subtract their heights from this value.
    return position.dy + _scrollController.offset;
  }

  // Listener for the ScrollController
  void _onScroll() {
    final currentOffset = _scrollController.offset + _pinOffset;

    // Determine which section is visible
    // (This logic can be refined to handle partial overlaps.)
    for (int i = 0; i < _sectionOffsets.length; i++) {
      final start = _sectionOffsets[i];
      final end = (i == _sectionOffsets.length - 1)
          ? double.infinity
          : _sectionOffsets[i + 1] - 1;

      if (currentOffset >= start && currentOffset < end) {
        if (_tabController.index != i) {
          _tabController.animateTo(i);
        }
        break;
      }
    }
  }

  // Called when user taps on a tab
  void _onTabTapped(int index) {
    // Smoothly scroll to the chosen section
    _scrollController.animateTo(
      _sectionOffsets[index] - _pinOffset, 
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 1) Pinned Hero Image
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Scenic Mountain Route',
                style: TextStyle(color: Colors.white),
              ),
              background: Image.network(
                'https://via.placeholder.com/800x400.png?text=Hero+Image',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // share logic
                },
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_outline),
                onPressed: () {
                  // bookmark logic
                },
              ),
            ],
          ),

          // 2) Pinned Tab Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabHeaderDelegate(
              TabBar(
                controller: _tabController,
                onTap: _onTabTapped,
                // Make tabs fit the screen width
                tabs: const [
                  Tab(text: 'Details'),
                  Tab(text: 'Weather'),
                  Tab(text: 'Reviews'),
                  Tab(text: 'Media'),
                ],
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
              ),
            ),
          ),

          // 3) Four continuous sections (one scroll)
          _buildDetailsSection(),
          _buildWeatherSection(),
          _buildReviewsSection(),
          _buildMediaSection(),

          // Optional bottom space
          SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      // Optional FAB for "Start Route" or any main action
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Start route logic
        },
        icon: const Icon(Icons.navigation),
        label: const Text('Start Route'),
      ),
    );
  }

  // SECTION: DETAILS
  Widget _buildDetailsSection() {
    return SliverToBoxAdapter(
      key: _detailsKey,
      child: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Route Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Hardcoded info about region, route type, difficulty.\n'
              '• Points of interest: waterfalls, scenic lookouts, etc.\n'
              '• Family/child-friendly or not.\n'
              '• Loop or one-way route.\n'
              '• Elevation profile, approximate length.',
            ),
            const SizedBox(height: 16),
            Container(
              height: 120,
              color: Colors.blueGrey[200],
              alignment: Alignment.center,
              child: const Text('Placeholder for Miniature Map/Elevation Graph'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // External nav logic
              },
              icon: const Icon(Icons.map),
              label: const Text('Open in External Map'),
            ),
          ],
        ),
      ),
    );
  }

  // SECTION: WEATHER
  Widget _buildWeatherSection() {
    return SliverToBoxAdapter(
      key: _weatherKey,
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '5-Day Weather Forecast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (int i = 1; i <= 5; i++)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: const Icon(Icons.wb_sunny),
                  title: Text('Day $i: Sunny, 24°C'),
                  subtitle: const Text('Wind: 5km/h, Humidity: 60%'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // SECTION: REVIEWS
  Widget _buildReviewsSection() {
    return SliverToBoxAdapter(
      key: _reviewsKey,
      child: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildReviewCard('John Doe', 4, 'Beautiful route, somewhat challenging.'),
            _buildReviewCard('Jane Smith', 5, 'Perfect for a family weekend.'),
            _buildReviewCard('Maxwell', 3, 'Muddy in spots, but worth it.'),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('See All Reviews'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(String user, int rating, String text) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(child: Text(user[0])),
        title: Text('$user — ${'⭐' * rating}'),
        subtitle: Text(text),
      ),
    );
  }

  // SECTION: MEDIA
  Widget _buildMediaSection() {
    return SliverToBoxAdapter(
      key: _mediaKey,
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Photos & Videos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(6, (index) {
                return Container(
                  width: 100,
                  height: 80,
                  color: Colors.blueGrey[300],
                  alignment: Alignment.center,
                  child: Text('Media ${index + 1}'),
                );
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // open camera/gallery logic
              },
              icon: const Icon(Icons.file_upload),
              label: const Text('Upload Your Photos'),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------- SliverPersistentHeader Delegate --------------
// This builds a pinned area of fixed height with a TabBar widget.
class _SliverTabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabHeaderDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // Tab bar background
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabHeaderDelegate oldDelegate) {
    return false;
  }
}
