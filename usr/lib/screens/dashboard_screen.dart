import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('HMS Overview 2025', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () {},
            tooltip: 'AI Alerts',
          ),
          const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Real-Time Property Status',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Top Stats Row
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.5,
                  children: const [
                    _StatCard(
                      title: 'Live Occupancy',
                      value: '84%',
                      icon: Icons.hotel,
                      trend: '+2% vs last week',
                      trendUp: true,
                    ),
                    _StatCard(
                      title: 'Mobile Check-ins',
                      value: '142',
                      icon: Icons.phone_android,
                      trend: '65% of arrivals',
                      trendUp: true,
                    ),
                    _StatCard(
                      title: 'AI RevPAR Forecast',
                      value: '\$185',
                      icon: Icons.trending_up,
                      trend: 'Optimized pricing active',
                      trendUp: true,
                    ),
                    _StatCard(
                      title: 'Smart Energy Savings',
                      value: '12%',
                      icon: Icons.eco,
                      trend: 'IoT HVAC active',
                      trendUp: true,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            
            // Main Content Area
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                // Recent Mobile Check-ins
                SizedBox(
                  width: _getResponsiveWidth(context, 400),
                  child: _buildSectionCard(
                    context,
                    title: 'Pending Digital Keys',
                    icon: Icons.key,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: theme.colorScheme.primaryContainer,
                            child: Text('R${301 + index}'),
                          ),
                          title: Text('Guest #${8923 + index}'),
                          subtitle: const Text('Mobile Check-in Complete'),
                          trailing: ElevatedButton(
                            onSize: const Size(80, 36),
                            onPressed: () {},
                            child: const Text('Issue Key'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // AI Insights
                SizedBox(
                  width: _getResponsiveWidth(context, 400),
                  child: _buildSectionCard(
                    context,
                    title: 'AI Operational Insights',
                    icon: Icons.auto_awesome,
                    child: Column(
                      children: [
                        _buildInsightTile(
                          context,
                          'Staffing Optimization',
                          'Predictive model suggests adding 2 housekeeping staff for tomorrow based on early check-out trends.',
                          Icons.people,
                        ),
                        const Divider(),
                        _buildInsightTile(
                          context,
                          'Dynamic Pricing Alert',
                          'Local event detected. Room rates automatically adjusted +15% for the weekend.',
                          Icons.attach_money,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getResponsiveWidth(BuildContext context, double minWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return (screenWidth - 48) / 2; // Split into 2 columns with padding
    }
    return screenWidth - 32; // Full width minus padding
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.domain, color: Colors.white, size: 48),
                SizedBox(height: 8),
                Text(
                  'Cloud PMS 2025',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Centralized Management',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(leading: const Icon(Icons.dashboard), title: const Text('Dashboard'), onTap: () {}),
          ListTile(leading: const Icon(Icons.book_online), title: const Text('Reservations'), onTap: () {}),
          ListTile(leading: const Icon(Icons.meeting_room), title: const Text('Smart Rooms (IoT)'), onTap: () {}),
          ListTile(leading: const Icon(Icons.analytics), title: const Text('AI Analytics'), onTap: () {}),
          ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'), onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, {required String title, required IconData icon, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildInsightTile(BuildContext context, String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.onSecondaryContainer, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String trend;
  final bool trendUp;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.trend,
    required this.trendUp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
              ],
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(
                  trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                  color: trendUp ? Colors.green : Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    trend,
                    style: TextStyle(
                      color: trendUp ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
