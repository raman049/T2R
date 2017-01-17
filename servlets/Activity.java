package servlets;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.swing.JPanel;
import javax.swing.Timer;

public class Activity implements ActionListener, MouseListener, KeyListener {
	public static Activity activity;
	FrameClass jframe;
	int HEIGHT, WIDTH;
	int xMotion, score, highScore, finalScore;
	Rectangle Recatangleboat;
	public boolean gameOver, started;
	public Render render;
	public Random random;
	public BufferedImage waterIma, boatSteadyIma, boatLeftIma, boatRightIma, boatForwardIma, drum1Ima;

	public void ActivityMethod() {
		jframe = new FrameClass();
		HEIGHT = jframe.getHeight();
		WIDTH = jframe.getWidth();
		Timer timer = new Timer(20, this);
		Recatangleboat = new Rectangle(jframe.getWidth() / 3, jframe.getHeight() / 2 - 10, 50, 30);
		render = new Render();
		random = new Random();
		jframe.addMouseListener(this);
		jframe.addKeyListener(this);
		jframe.add(render);
		jframe.setVisible(true);
		timer.start();
		try {
			waterIma = ImageIO.read(ResourceLoader.load("images/water.jpg"));
			boatSteadyIma = ImageIO.read(ResourceLoader.load("images/boatSteady.png"));
			drum1Ima = ImageIO.read(ResourceLoader.load("images/drum1.png"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void Repaint(Graphics g) {
		g.drawImage(waterIma, 0, 0, WIDTH, HEIGHT, null);
		g.drawImage(boatSteadyIma, WIDTH / 2 - WIDTH / 10, HEIGHT - HEIGHT / 3, WIDTH / 5, HEIGHT / 5, null);
		g.drawImage(drum1Ima, WIDTH / 2 - WIDTH / 10, HEIGHT / 6 - HEIGHT / 5, WIDTH / 5, HEIGHT / 5, null);
		g.setColor(new Color(255, 0, 0));
		g.fillRect(10, 10, 20, 10);
		g.fillRect(40, 10, 20, 10);
		g.fillRect(70, 10, 20, 10);
		g.fillRect(100, 10, 20, 10);
		g.fillRect(WIDTH - 30, 10, 20, 10);
		g.fillRect(WIDTH - 60, 10, 20, 10);
		g.fillRect(WIDTH - 90, 10, 20, 10);
		g.fillRect(WIDTH - 120, 10, 20, 10);
		g.setFont(new Font("Comic Sans MS", 1, 25));
		g.setColor(new Color(255, 0, 0));
		g.drawString("High Score: ", WIDTH / 2 - 100, HEIGHT / 7);
		g.setFont(new Font("Comic Sans MS", 2, WIDTH / 7));
		g.setColor(new Color(255, 255, 0));
		g.drawString("Tap to Start", WIDTH / 2 - 100, HEIGHT / 2 - 50);
		if (!gameOver && started){
			System.out.println("started and not gameover");
		}

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

	public void keyReleased(KeyEvent e) {

	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub

	}

	public void row() {
		System.out.println("row()");
		if (gameOver) {
			xMotion = 0;
			score = 0;
			System.out.println("gameover");
			gameOver = false;
		}
		if (!started) {
			started = true;
		}
		 else if (!gameOver) {
			score = 1 + score;
			if (xMotion > 0) {
				xMotion = 0;
			}
			xMotion -= 5;
		}
//		if (highScore < score) {
//			highScore = score;
//			try {
//				HighScore.updateHiScore(score);
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//
//		}
	//	finalScore = score;
	}
	
	

	@Override
	public void keyTyped(KeyEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void keyPressed(KeyEvent e) {
		// TODO Auto-generated method stub
		if (e.getKeyCode() == KeyEvent.VK_SPACE) {
			System.out.println("vk space");
		}
	}

	@Override
	public void mouseClicked(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub
		row();

	}

	@Override
	public void mouseReleased(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void mouseEntered(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void mouseExited(MouseEvent e) {
		// TODO Auto-generated method stub

	}

}
