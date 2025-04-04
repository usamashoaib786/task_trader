import 'dart:math';

class QuoteProvider {
  static final List<String> quotes = [
    "The key to success in trading is following your rules—trust the process and stay the course.Trading in the Zone",
    "Every trade you make is an opportunity to strengthen your discipline and follow your plan. Trading Sardines",
    "The more you follow your trading rules, the more confident you become in your ability to succeed.",
    "Stick to your plan, and follow your rules. You'll be amazed at how often it leads to success.Trading in the Zone",
    "When you follow your rules, you turn uncertainty into opportunity, and that's the foundation of successful trading.Trading in the Zone",
    "A great trader is one who embraces the power of a solid trading plan and sticks to it, even in challenging times.",
    "By following your trading rules, you're setting yourself up for consistency and long-term success.The Art and Science of Technical Analysis",
    "Trading success comes from developing and sticking to a set of rules you believe in. It's about consistency, not perfection.Trade Your Way to Financial Freedom",
    "The market is full of possibilities, but sticking to your plan and following your rules will guide you toward consistent success.Trading for a Living",
    "Every time you follow your rules, you are reinforcing good habits and strengthening your trading skills.",
    "Following your rules is a way to protect your emotional well-being and ensure you're trading with clarity.Trend Following",
    "The true essence of successful trading is not in predicting the market but in following your plan and sticking to your rules. Trading in the Zone",
    "Following your rules with confidence is the key to becoming a consistently successful trader.Trade Like a Stock Market Wizard",
    "By sticking to your plan, you open up the opportunity to learn from both your wins and your losses, which will only improve your future trades.",
    "Successful trading is a journey of following your rules and learning how to adapt when necessary.",
    "You can't control the market, but you can control your actions by sticking to your trading plan and rules.",
    "The best traders are those who follow their rules and stay true to their plans. They know that consistency leads to results.",
    "A plan without rules is a wish. But when you follow your rules, you are investing in your future success.",
    "Sticking to your trading rules isn't about being perfect; it's about being consistent and learning as you go.",
    "Each time you follow your rules, you gain more experience and build the foundation for future success.Trading for a Living",
    "Risk management starts with following your plan, and that's where true trading success begins. Trade Your Way to Financial Freedom",
    "By following your rules, you're creating a framework for success that allows you to focus on what truly matters.",
    "The best traders don't just trade—they follow a plan, stick to their rules, and remain calm in the face of uncertainty.Trading in the Zone",
    "The more you follow your rules, the more you'll feel in control of your trading, no matter what the market is doing.",
    "When you follow your trading plan, you gain clarity, and clarity is the key to making better decisions.",
    "By following your rules, you free yourself from emotional decisions and allow your strategy to work for you.",
    "Success in trading comes from creating a solid set of rules and having the discipline to follow them through thick and thin.",
    "Every rule you follow is a step toward becoming a more skilled and confident trader.",
    "Having a set of rules is not about limiting yourself; it's about giving yourself the freedom to trade with peace of mind.",
    "The key to winning in trading isn't to be perfect, but to follow your rules consistently.",
    "When you follow your rules, you take the guesswork out of trading and let your strategy guide you.Trade Like a Stock Market Wizard",
    "Successful traders know that following their rules is more important than chasing every opportunity.",
    "Staying disciplined and following your rules gives you the confidence to handle the ups and downs of the market.",
    "Your rules serve as a roadmap, helping you navigate through the unpredictable nature of the market with confidence.",
    "When you follow your rules, you create a rhythm in your trading that allows you to take advantage of the opportunities that align with your strategy.",
    "Trading without a plan is like sailing without a compass. Your rules are your guide.",
    "Following your rules isn't about restriction; it's about creating space for your strategy to succeed.Trading in the Zone",
    "Every successful trader follows their rules with patience and discipline, allowing their strategy to unfold naturally.",
    "By following your rules, you take emotions out of the equation and let your plan work for you.",
    "The best traders don't react to the market—they follow their rules and let the market come to them.",
    "Following your rules is an act of self-respect and confidence in your ability to succeed.",
    "Success is not about being right all the time—it's about following your plan and adjusting when necessary.",
    "The market is full of noise, but by following your rules, you can block out distractions and focus on your plan.",
    "The more you trust your rules, the more you can take each trade in stride without second-guessing yourself.",
    "Your rules provide you with a clear path forward, even when the market seems chaotic.",
    "By focusing on following your rules, you empower yourself to make informed decisions and avoid unnecessary risks.",
    "Success in trading is built on a foundation of following your rules, not on chasing the next big opportunity.",
    "The more you follow your rules, the more you'll realize how much control you have over your trading."
        "When you follow your rules, you are positioning yourself for long-term success rather than short-term wins."
        "Trading is a game of strategy, and your rules are your strategy. Follow them, and you'll have a clear path to success."
        "By focusing on your rules, you can create a trading approach that allows you to take advantage of the market without being      distracted by emotions."
        "The road to success in trading is paved with consistency. Stick to your rules, and the results will follow."
        "The road to success in trading is paved with consistency. Stick to your rules, and the results will follow.",
    "Trading without rules is like flying blind. Follow your plan, and you'll navigate the market with confidence.",
    "Following your rules is a way to protect your future while giving yourself the best chance for long-term success.",
    "Trading is about following a process. Stick to your plan, trust your rules, and watch your success grow."
  ];

  static String getRandomQuote() {
    final random = Random();
    return quotes[random.nextInt(quotes.length)];
  }
}
