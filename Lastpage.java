
package T2R;


import java.awt.Color;
import java.awt.EventQueue;
import java.awt.Font;
import java.awt.Frame;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;




public class Lastpage {

	private JLabel lable;
	static Frame frame;
	static HighScore hiScore;
	static int Height;
	static int Width;
	static Boolean playClip = true;
	static Clip clip;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			@SuppressWarnings("static-access")
			public void run() {
				try {
					Lastpage window = new Lastpage();
					window.frame.setVisible(true);
					clip = AudioSystem.getClip();
					clip.open(AudioSystem.getAudioInputStream(new File("SoundClips/latinHorn.wav")));
					clip.loop(clip.LOOP_CONTINUOUSLY);
					clip.start();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});

	}

	/**
	 * Create the application.
	 */
	public Lastpage() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new FrameClass();
		Height = frame.getHeight();
		Width = frame.getWidth();
		((JFrame) frame).getContentPane().setBackground(new Color(127,255,212));
		((JFrame) frame).getContentPane().setLayout(null);
		frame.setResizable(false);
		
		
		JButton btnNewButton = new JButton("ROW AGAIN");
		btnNewButton.setForeground(new Color(139,0,0));
		btnNewButton.addActionListener(new Action());
		btnNewButton.setBackground(Color.LIGHT_GRAY);
		btnNewButton.setFont(new Font("Comic Sans MS", Font.BOLD, Height / 50));
		btnNewButton.setBounds(Width / 3, Height /2, Height/4, Height / 32);
		((JFrame) frame).getContentPane().add(btnNewButton);
		
		
		JButton newbutton = new JButton("EXIT GAME");
		newbutton.setForeground(new Color(139,0,0));
		newbutton.addActionListener(new Action());
		newbutton.setBackground(Color.LIGHT_GRAY);
		newbutton.setFont(new Font("Comic Sans MS", Font.BOLD, Height / 50));
		newbutton.setBounds(Width / 3, Height / 2+100, Height/4, Height / 32);
		((JFrame) frame).getContentPane().add(newbutton);
		
		//YOUR SCORE
		
		lable = new JLabel();
		lable.setFont(new Font("Comic Sans MS", Font.BOLD, Height / 32));
		lable.setText("Your Score : ");
		lable.setForeground(new Color( 139,0,0));
		lable.setBounds(Width / 3 , Height/2-400  , Width / 2, Height / 2);
		((JFrame) frame).getContentPane().add(lable);
		
		
		// High Score
		String HIscore = "";
		try {
			HIscore = HighScore.updateHiScore(0).toString();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		lable = new JLabel();
		lable.setFont(new Font("Comic Sans MS", Font.BOLD, Height / 32));
		lable.setText("High Score : " + HIscore);
		lable.setForeground(new Color( 139,0,0));
		lable.setBounds(Width / 3 , Height/2-300  , Width / 2, Height / 2);
		((JFrame) frame).getContentPane().add(lable);
	}

	static class Action implements ActionListener {

		@Override
		public void actionPerformed(ActionEvent e) {
			try {
				clip.close();// close music
				Thread.sleep(500);// pause for 900 msec
			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			frame.setVisible(false);
			
		}

	}
}