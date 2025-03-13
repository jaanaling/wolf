import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolf_survival/src/core/utils/app_icon.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';

class MaskWidhget extends StatelessWidget {
  final Screen screen;
  final VoidCallback setState;
  const MaskWidhget({super.key, required this.screen, required this.setState});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(child:  Container(
            color: Colors.black.withOpacity(0.7799999833106995),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                Gap(10),
                TextWithBorder(
                  screen.text,
                  textAlign: TextAlign.center,
                 fontSize: 22,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -(MediaQuery.of(context).size.height * 0.05),
          child: AppIcon(
            asset: IconProvider.masq.buildImageUrl(),
            width: MediaQuery.of(context).size.width * 0.986,
            height: MediaQuery.of(context).size.height * 0.63,
          ),
        ),
        Positioned(
          bottom: -(MediaQuery.of(context).size.height * 0.08 ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 104),
            child: AppButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool(screen.code, true);
                setState();
              },
              style: ButtonColors.purple,
              text: "Woof!",
              isRound: false,
            ),
          ),
        ),
      ],
    );
  }
}

enum Screen {
  Notes(
    "📖 Survivor’s Diary\n"
        "Howdy, partner! Want to keep track of your survival adventures? Write down everything here so you don’t forget whether you were *building a shelter* or just chasing your own tail! 🐺\n"
        "🔹 'I‘m drink water' – Hydration is key, good job!\n"
        "Take notes, stay alive, and maybe even sound smart doing it!",
    "isNotes",
  ),

  Trip(
    "🏕️ "
        "Well, well, look who’s starting their journey! The sun’s up – what’s your move?\n"
        "🔥 Build a fire? Smart – unless you enjoy cold nights and raw food.\n"
        "🏠 Make a shelter? Unless you like cuddling with raccoons, this is a solid choice.\n"
        "💧 Find water? You *could* drink cactus juice… or just be reasonable and find a stream.\n"
        "Make the right choices, or nature will make them for you! 🌿",
    "isTrip",
  ),

  Resourse(
    "🍖 Your Resources\n"
        "Write down what you’ve got, or risk running out of supplies faster than a rabbit in a wolf pack! 🐺\n"
        "🍗 Food: How many calories are you packing? Enough to last, or just enough to snack?\n"
        "💧 Water: Got enough to stay hydrated, or are you planning on licking morning dew?\n"
        "✏️ Add your resources here and keep track, because ‘hoping for the best’ is not a survival strategy! 🚀",
    "isResourse",
  ),

  Home(
    "🐺 Welcome to Wolf Survival!\n"
        "Sheriff Wolf is here to guide you through the art of survival! 🌵\n"
        "But hold your horses, cowboy – this is *just for reference!* If you ever get lost in the wild, don’t rely on an app… use your brain and paw!\n"
        "Choose your adventure: Calculator, Survivalist’s Diary, or take a Tour!",
    "isHome",
  ),

  Calculator(
    "🧮 Survival Calculator\n"
        "Packing too much? Packing too little? Let’s crunch some numbers!\n"
        "Hit *Calculate* to see how much food and water you’ll need! If you mess up, well… at least you’ll know *exactly* how much you’re missing. 😆",
    "isCalculator",
  );

  final String text;
  final String code;
  const Screen(this.text, this.code);
}
