package T2R;



import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

public class HighScore {
	static Scanner scanner;

	public static String updateHiScore(int score) throws IOException {
		String Highscore = null;
		String Score = String.valueOf(score);
		PrintWriter output;

		try {
			scanner = new Scanner(new File(".user.txt"));

			String a = scanner.nextLine();

			if (a.length() == 0) { // if file is empty
				output = new PrintWriter(new FileWriter(".user.txt", false));
				// output.write("");
				output.flush();
				output.print(Score);
				Highscore = Score;
			}

			if (Integer.valueOf(Score) >= Integer.valueOf(a)) { // if new high
																// score
				output = new PrintWriter(new FileWriter(".user.txt", false));
				output.flush();
				output.print(Score);
				output.close();
				Highscore = Score;
			}
			if (Integer.valueOf(Score) < Integer.valueOf(a)) { // if high score
																// doesnot
																// change
				// output = new PrintWriter(new FileWriter(".user.txt", false));
				// output.flush();
				// output.print(Score);
				// output.close();
				Highscore = a;
			}

		} catch (Exception e) { // if file is misssing
			output = new PrintWriter(new FileWriter(".user.txt", true));
			// output.write("");
			output.print(Score);
			output.close();
			Highscore = Score;
			// System.out.println("file not found");
		}
		return Highscore;

	}

	public static void main(String[] args) throws IOException {
		// highScore(199000);
		String a = HighScore.updateHiScore(0);
		System.out.println(a);
	}

}
