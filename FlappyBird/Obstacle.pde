public class Obstacle {
    final private int GAP = 250;
    private Planet planet1;
    private Planet planet2;

    Obstacle(int x, int y) {
        planet1 = new Planet(fileIO.planetImages[floor(random(0, 6))], x, y-GAP/2-Planet.SIZE/2);
        planet2 = new Planet(fileIO.planetImages[floor(random(0, 6))], x, y+GAP/2+Planet.SIZE/2);
    }

    public void draw() {
        update();
        planet1.draw();
        planet2.draw();
    }

    private void update() {
        float y = random(150, height-150);
        if (planet1.isEnd()) {
            planet1.setPos(width+Planet.SIZE+Game.OBSTACLE_SPACE, y-GAP/2-Planet.SIZE/2);
            planet2.setPos(width+Planet.SIZE+Game.OBSTACLE_SPACE, y+GAP/2+Planet.SIZE/2);
            planet1.setImage(fileIO.planetImages[floor(random(0, 6))]);
            planet2.setImage(fileIO.planetImages[floor(random(0, 6))]);
        }
    }

    public boolean isHit(PVector pos, int r) {
        return planet1.isHit(pos.x, pos.y, r) || planet2.isHit(pos.x, pos.y, r);
    }
}
