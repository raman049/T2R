package servlets;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Random;

import javax.swing.JPanel;
import javax.swing.Timer;

public class Activity implements ActionListener {
	public static Activity activity;
	FrameClass jframe;
	int HEIGHT, WIDTH;
	Rectangle Recatangleboat;
	Boolean gameOver;
	public Render render;
	public Random random;

	public void ActivityMethod() {
		jframe = new FrameClass();
		HEIGHT = jframe.getHeight();
		WIDTH = jframe.getWidth();
		Timer timer = new Timer(20, this);
		Recatangleboat = new Rectangle(jframe.getWidth() / 3, jframe.getHeight() / 2 - 10, 50, 30);
		render = new Render();
		random = new Random();
		jframe.add(render);
		jframe.setVisible(true);
		timer.start();

	}

	public void Repaint(Graphics g) {
		g.setFont(new Font("Comic Sans MS", 1, 25));
		g.setColor(new Color(255, 0, 0));
		g.drawString("High Score: ", WIDTH / 2 - 100, HEIGHT / 10);
		g.setFont(new Font("Comic Sans MS", 2, 100));
		g.setColor(new Color(255, 255, 0));
		g.drawString("Tap to Start", WIDTH / 2 - 275, HEIGHT / 2 - 50);
		
//		g.setColor(new Color(153, 204, 255)); // background color
//		g.fillRect(0, 0, 100, 1000);
//		g.setColor(new Color(153, 204, 255)); // sky color
//		g.fillRect(0, 0, WIDTH, HEIGHT / 6);
		
	}

	public class Render extends JPanel {

		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		protected void paintComponent(Graphics g) {
			super.paintComponent(g);
			Repaint(g);			
		}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Activity a = new Activity();
		a.ActivityMethod();

	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		
	}

}
