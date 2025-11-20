class AiService {
  // This is a mock AI service. 
  // To make it "real", you would connect this to an API like OpenAI or Gemini.
  
  String getResponse(String input) {
    final String lowerInput = input.toLowerCase();

    if (lowerInput.contains('hello') || lowerInput.contains('hi') || lowerInput.contains('salam')) {
      return "Connection established. SK Hacker is listening. How can I assist you with your operations?";
    }
    
    if (lowerInput.contains('name') || lowerInput.contains('nam')) {
      return "Identity: SK Hacker. \nStatus: Online.\nMission: Provide accurate data.";
    }

    if (lowerInput.contains('hack') || lowerInput.contains('password')) {
      return "ACCESS DENIED. \nProtocol 404: I cannot assist with illegal activities. I am designed for ethical assistance and information retrieval.";
    }

    if (lowerInput.contains('time') || lowerInput.contains('date')) {
      return "Current System Time: ${DateTime.now().toString()}";
    }

    if (lowerInput.contains('code') || lowerInput.contains('program')) {
      return "I can generate code structures. Please specify the language and the function you require.";
    }
    
    if (lowerInput.contains('who made you') || lowerInput.contains('creator')) {
      return "I was initialized by a developer using Flutter technology.";
    }

    // Default responses for unknown queries
    final List<String> defaultResponses = [
      "Analyzing input... Data inconclusive. Please refine your query.",
      "Command not recognized in current database.",
      "Processing... I need more context to provide an accurate answer.",
      "System operational. Please ask a specific question.",
    ];

    return defaultResponses[DateTime.now().second % defaultResponses.length];
  }
}
