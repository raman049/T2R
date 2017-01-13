

package T2R;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
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
		jframe.add(render);
		jframe.setVisible(true);

	}

	public void Repaint(Graphics g) {
		// g.setFont(new Font("Comic Sans MS", 1, 25));
		g.setColor(new Color(255, 0, 0));
		g.drawString("High Score: ", WIDTH / 2 - 100, HEIGHT / 10);
		try {
			image = ImageIO.read(ResourceLoader.load("T2Rimages/drum1.png"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		g.drawImage(image, WIDTH / 2, HEIGHT / 2, 200, 200, null);

	}

	public class Render extends JPanel {

		private static final long serialVersionUID = 1L;

		protected void paintComponent(Graphics g) {
			super.paintComponent(g);
			Repaint(g);
		}
	}

}
