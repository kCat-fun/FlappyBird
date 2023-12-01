public class App {
    public int BACE_GAME_SPEED = 4;
    public int gameSpeed;
    private int pageNum;

    private BackgroundStar bgStar;
    protected final Tab[] tabs = new Tab[]{
        new Title(),
        new Game(),
    };

    App() {
        gameSpeed = 4;
        bgStar = new BackgroundStar();
        pageNum = 0;
    }

    public void setup() {
    }

    public void draw() {
        bgStar.draw();
        tabs[pageNum].draw();
    }

    public void mousePressed() {
        tabs[pageNum].mousePressed();
    }

    public void setPage(int n) {
        tabs[pageNum].close();
        pageNum = n;
        tabs[pageNum].setup();
    }
}
