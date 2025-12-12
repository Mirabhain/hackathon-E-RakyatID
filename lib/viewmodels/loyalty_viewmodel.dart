import 'package:flutter/material.dart';
import '../models/loyalty_model.dart';

class LoyaltyViewModel extends ChangeNotifier {
  UserProfile user;

  LoyaltyViewModel(this.user);

  // Reward list
  List<RewardItem> get rewardItems => [
        RewardItem(
          title: "Share data with services",
          pointsLabel: "+10 points",
          icon: Icons.share,
          color: Colors.blue,
        ),
        RewardItem(
          title: "Complete government forms",
          pointsLabel: "+25 points",
          icon: Icons.description,
          color: Colors.green,
        ),
        RewardItem(
          title: "Use digital signature",
          pointsLabel: "+15 points",
          icon: Icons.edit,
          color: Colors.purple,
        ),
        RewardItem(
          title: "Verify private attributes",
          pointsLabel: "+20 points",
          icon: Icons.verified_user,
          color: Colors.orange,
        ),
      ];

  // Redeem items
  List<RedeemItem> get redeemItems => [
        RedeemItem(
          title: "RM10 eWallet Credit",
          requiredPoints: "500 points",
          icon: Icons.account_balance_wallet,
        ),
        RedeemItem(
          title: "Toll Discount Voucher",
          requiredPoints: "300 points",
          icon: Icons.local_offer,
        ),
      ];

  void addPoints(int value) {
    user.loyaltyPoints += value;
    notifyListeners();
  }

  bool redeem(int required) {
    if (user.loyaltyPoints >= required) {
      user.loyaltyPoints -= required;
      notifyListeners();
      return true;
    }
    return false;
  }
}
