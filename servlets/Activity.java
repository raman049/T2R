package servlets;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.util.Random;

import javax.swing.JPanel;
import javax.swing.Timer;

public class Activity implements ActionListener {
	public static Activity activity;
	FrameClass jframe;
	int HEIGHT, WIDTH;
	Rectangle boat;
	Boolean gameOver;
	public Render render;
	public Random random;

	public void ActivityMethod() {
		jframe = new FrameClass();
		HEIGHT = jframe.getHeight();
		WIDTH = jframe.getWidth();
		Timer timer = new Timer(20, this);
		boat = new Rectangle(jframe.getWidth() / 3, jframe.getHeight() / 2 - 10, 50, 30);
		render = new Render();
		random = new Random();
		jframe.add(render);
		jframe.setVisible(true);
		jframe.addKeyListener(new KeyAdapter() {
			public void keyTyped(KeyEvent e) {
				if (e.getKeyCode() == KeyEvent.VK_F2) {
					// close frame one.
				}
			}
		});
		;

		timer.start();

	}

	public void Repaint(Graphics g) {
		g.setColor(new Color(153, 204, 255)); // background color
		g.fillRect(0, 0, WIDTH, HEIGHT);
		g.setColor(new Color(153, 204, 255)); // sky color
		g.fillRect(0, 0, WIDTH, HEIGHT / 6);

	}

	public class Render extends JPanel {
		private static final long serialVersionUID = 1L;

		@Override
		protected void paintComponent(Graphics g) {
			super.paintComponent(g);
			Activity.activity.Repaint(g);
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
