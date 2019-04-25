class ParticleSystem {
  
  Particle core;
  ArrayList<Particle> particles;

  ParticleSystem() {
    core = new Particle(random(-platformWidth/2, platformWidth/2), 
                        platformOffset, 
                        random(-platformDepth/2, platformDepth/2), 
                        random(255));
    particles = new ArrayList<Particle>();
  }

  void update() {
    if (core != null) {
      core.applyForce(gravity);
      core.update();
      if (core.explode()) {
        for (int i = 0; i < 500; i++) {
          Particle p = new Particle(core.location, core.hue);
          particles.add(p);
        }
        core = null;
      }
    }
    
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.applyForce(gravity);
      p.update();
      if (p.expired()) {
        particles.remove(i);
      }
    }
  }
  
  void display() {
    if (core != null) {
      core.display();
    }
    for (Particle p : particles) {
      p.display();
    }
  }
  
  boolean finished() {
    return (core == null && particles.isEmpty());
  }

  void run() {
    update();
    display();
  }
  
  long numOfParticles() {
    long num = (core != null) ? 1 : 0;
    num += particles.size();
    return num;
  }
}
