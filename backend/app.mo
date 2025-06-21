import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Float "mo:base/Float";

actor {

  // Define the Student type
  type Student = {
    id: Text;
    name: Text;
    totalCredits: Nat;
    completedCredits: Nat;
    gpa: Float;
  };

  // Persist student data across upgrades
  stable var studentData: [Student] = [
    { id = "240367BSIT"; name = "Rayshons"; totalCredits = 120; completedCredits = 90; gpa = 3.2 }
  ];

  public func ask(question: Text) : async Text {
    let q = Text.toLowercase(question);

    if (Text.contains(q, #text "time management")) {
      return "Tip: Use a weekly planner. Break big tasks into small parts. Prioritize based on deadlines.";
    } else if (Text.contains(q, #text "career")) {
      return "Explore your passions early. ICT, business, theology, and healthcare are high-demand fields in Kenya!";
    } else if (Text.contains(q, #text "study tips")) {
      return "Study consistently. Use past papers. Teach someone else to master a topic.";
    } else if (Text.contains(q, #text "mental health") or Text.contains(q, #text "stress")) {
      return "It's okay to feel overwhelmed. Talk to someone. Pray. Take short breaks and rest.";
    } else if (Text.contains(q, #text "scholarship")) {
      return "You can explore scholarship opportunities here:\n🔗 https://www.aiu.ac.ke/financial-aid-scholarships/\nAlso check HELB and ask your department.";
    } else if (Text.contains(q, #text "clubs")) {
      return "Join clubs that align with your passion — drama, IT, worship team. Great for growth!";
    } else if (Text.contains(q, #text "faith")) {
      return "Philippians 4:13 - I can do all things through Christ who strengthens me. Keep the faith.";
    } else if (
      Text.contains(q, #text "odel") or
      Text.contains(q, #text "e-learning") or
      Text.contains(q, #text "moodle")
    ) {
      return "To access ODEL:\n1. Visit https://elearning.aiu.ac.ke\n2. Log in using your AIU credentials.\n3. Click on your course to see materials.\nContact ODEL or IT for help.";
    } else if (Text.contains(q, #text "credit completion")) {
      let s = studentData[0];
      let percentage = (Float.fromInt(s.completedCredits) / Float.fromInt(s.totalCredits)) * 100;
      return s.name # ", you have completed " # Nat.toText(s.completedCredits) # "/" # Nat.toText(s.totalCredits) # " credits (" # Float.toText(percentage) # "%). Keep going!";
    } else if (Text.contains(q, #text "gpa projection")) {
      let s = studentData[0];
      let projectedGPA = if (s.completedCredits >= 100) { 3.4 } else { 3.25 };
      return s.name # ", your current GPA is " # Float.toText(s.gpa) # ". Projected GPA upon graduation: " # Float.toText(projectedGPA) # ". Stay focused!";
    } else if (Text.contains(q, #text "performance alert")) {
      let s = studentData[0];
      if (s.gpa < 2.5) {
        return s.name # ", ALERT: Your GPA is below 2.5. Consider seeking academic counseling or tutoring support.";
      } else {
        return s.name # ", you're doing well academically. Keep striving for excellence!";
      }
    } else {
      return "I'm learning! Try asking about GPA, credit completion, time management, ODEL, or scholarships.";
    }
  }
}