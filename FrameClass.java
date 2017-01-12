package T2R;

import javax.swing.JFrame;

@SuppressWarnings("serial")
public class FrameClass extends JFrame {

	public FrameClass() {
		setTitle("T2R");
		setSize(1080/2,1920/2);
		setResizable(true);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setVisible(true);
	}
}