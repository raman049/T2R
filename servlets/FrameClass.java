package servlets;

import javax.swing.JFrame;

@SuppressWarnings("serial")
public class FrameClass extends JFrame {

	public FrameClass() {
		setTitle("VOGEL");
		setSize( 1080 / 2, 1920 / 2);
		setResizable(false);
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);
		setVisible(true);
	}

//	public static void main(String[] args) {
//		FrameClass f = new FrameClass();
//		f.show(true);
//	}
}
