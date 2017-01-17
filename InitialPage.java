
package T2R;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.JButton;
import javax.swing.JPanel;


public class InitialPage {

	public BufferedImage image;
	static FrameClass jframe;
	static int HEIGHT;
	static int WIDTH;
	public static Render render;

	InitialPage() {
	}

	public static void main(String[] args) {

		InitialPage a = new InitialPage();
		a.fristPage();

	}

	public void fristPage() {
		jframe = new FrameClass();
		HEIGHT = jframe.getHeight();
		WIDTH = jframe.getWidth();
		render = new Render();
		
		jframe.setVisible(true);
		
		JButton b = new JButton("ROW");
		b.setForeground(new Color(0, 0, 153));
		b.setBackground(Color.BLUE);
		b.setBounds(WIDTH / 2 , HEIGHT -300, 50, 50);
		b.addActionListener(new Action());
		jframe.add(b);
		
		JButton b1 = new JButton("OPTION");
		b1.setForeground(new Color(0, 0, 153));
		b1.setBackground(Color.RED);
		b1.setBounds(WIDTH / 2, HEIGHT / 2+50, 50, 50);
		jframe.add(b1);
		jframe.add(render);
	}
	

	static class Action implements ActionListener {

		@Override
		public void actionPerformed(ActionEvent e) {
			
			MainActivity.ActivityMethod();
		}}
	public void Repaint(Graphics g) {
		// background
		
		g.setColor(new Color(70, 185, 156));
		g.fillRect(0, 0, WIDTH, HEIGHT);
		
		//String
		
		g.setFont(new Font("Comic Sans MS", 1, 30));
		g.setColor(new Color(128, 0, 0));
		g.drawString("High Score: ", WIDTH / 2 - 200, HEIGHT / 2 + 300);
		
		//Images
		
		try {
			image = ImageIO.read(ResourceLoader.load("T2Rimages/drum1.png"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		g.drawImage(image, WIDTH / 2 - 220, HEIGHT / 25, 450, 450, null);
		
		
		try {
			
			
			image = ImageIO.read(ResourceLoader.load("T2Rimages/paddleRight.png"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		g.drawImage(image, WIDTH / 2 - 150, HEIGHT / 4, 300, 300, null);

		try {
			image = ImageIO.read(ResourceLoader.load("T2Rimages/paddleLeft.png"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		g.drawImage(image, WIDTH / 2 - 150, HEIGHT / 4 , 300, 300, null);
		
		
		
		
		
	}

	public class Render extends JPanel {

		private static final long serialVersionUID = 1L;

		protected void paintComponent(Graphics g) {
			super.paintComponent(g);
			Repaint(g);

		}

		
	}

	
}


