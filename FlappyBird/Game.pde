public class Game implements Tab {
    private Player player;
    private Obstacle[] obstacles;
    final static int OBSTACLE_SPACE = 300;
    private boolean isOver;
    private float hiScore; 
    private float score;

    Game() {
        obstacles = new Obstacle[2];
    }

    public void setup() {
        score = 0.0;
        app.gameSpeed = app.BACE_GAME_SPEED;
        hiScore = float(loadStrings("./data/score.txt")[0]);
        player = new Player(100, height/2.0);
        for (int i=0; i<obstacles.length; i++) {
            obstacles[i] = new Obstacle(width+(Planet.SIZE+Game.OBSTACLE_SPACE) * i+200, floor(random(150, height-150)));
        }
        isOver = false;
    }

    public void close() {
    }

    public void draw() {
        if (!isOver) {
            update();
            player.draw();
        }
        for (Obstacle obstacle : obstacles) {
            obstacle.draw();
        }
        if (isOver) {
            push();
            noStroke();
            fill(255, 170);
            rect(25, 80, width-50, 400);
            fill(0);
            textAlign(LEFT, CENTER);
            textSize(30);
            text("Score   :"+nf(score, 1, 1)+" light year", 50, 150);
            text("Hi Score:"+nf(hiScore, 1, 1)+" light year", 50, 250);
            text("Click to title", 50, 400);
            pop();
        }
        push();
        noStroke();
        fill(255, 170);
        rect(width-175, 20, 150, 30);
        fill(0);
        textAlign(LEFT, CENTER);
        textSize(20);
        text(nf(score, 1, 1)+" ly", width-170+10, 35);
        pop();
    }

    private void update() {
        if(IS_CONTROLLER) {
            app.gameSpeed = max(floor(app.BACE_GAME_SPEED + (keys.getStateBpm()-80)/8.0), 1);
        }
        score += app.gameSpeed/10.0;
        for (Obstacle obstacle : obstacles) {
            if (obstacle.isHit(player.getPos(), fileIO.planeImage.height/2)) {
                isOver = true;
                if(hiScore < score) {
                     saveStrings("./data/score.txt", new String[] {str(score)});   
                     hiScore = score;
                }
            }
        }
    }

    public void mousePressed() {
        if (isOver) {
            app.setPage(0);
        }
    }
}
