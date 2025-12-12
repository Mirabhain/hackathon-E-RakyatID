import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/loyalty_viewmodel.dart';
import 'package:mykadprototype/models/loyalty_model.dart';

class LoyaltyRewardsScreen extends StatelessWidget {
  const LoyaltyRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoyaltyViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loyalty Rewards'),
        backgroundColor: const Color(0xFFec4899),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPointsCard(vm.user.loyaltyPoints),
            const SizedBox(height: 32),
            const Text("Earn More Points", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            ...vm.rewardItems.map((item) => _buildRewardItem(item)),

            const SizedBox(height: 32),
            const Text("Redeem Rewards", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            ...vm.redeemItems.map((item) => _buildRedeemItem(context, vm, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard(int points) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFec4899), Color(0xFFf97316)]),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text("Your Points", style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              "$points",
              style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Loyalty Points", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardItem(RewardItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: item.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(item.icon, color: item.color),
        ),
        title: Text(item.title),
        trailing: Text(item.pointsLabel, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildRedeemItem(BuildContext context, LoyaltyViewModel vm, RedeemItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(item.icon, color: const Color(0xFFec4899)),
        title: Text(item.title),
        subtitle: Text(item.requiredPoints),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          int required = int.parse(item.requiredPoints.split(" ")[0]);

          bool success = vm.redeem(required);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                success ? "Redeemed successfully!" : "Not enough points",
              ),
              backgroundColor: success ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
