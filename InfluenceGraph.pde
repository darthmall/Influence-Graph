Graph graph;
float scaleBy = 1.0;

ArrayList<Node> highlighted;

void setup() {
  size(1024, 768);
  
  highlighted = new ArrayList<Node>();

  graph = new Graph();

  XMLElement xml = new XMLElement(this, "influence.graphml");
  XMLElement[] children = xml.getChildren();
  
  for (int i = 0; i < children.length; i++) {
    if (children[i].getLocalName().equals("graph")) {
      XMLElement[] data = children[i].getChildren();
    
      for (int j = 0; j < data.length; j++) {
        XMLElement el = data[j];
        
        if (el.getLocalName().equals("node")) {
          parseNode(el);
        } else if (el.getLocalName().equals("edge")) {
          parseEdge(el);
        }
      }
    }
  }
  
  smooth();
}

void draw() {
  background(0);

  highlighted.clear();

  Node over = null;
  Iterator iter = graph.nodes.values().iterator();
  while (iter.hasNext()) {
    over = (Node) iter.next();
    
    if (over.contains((mouseX - (width / 2)) / scaleBy, (mouseY - (height / 2)) / scaleBy)) {
      highlighted.add(over);
      break;
    } else {
      over = null;
    }
  }
  
  translate(width / 2, height / 2);
  scale(scaleBy);

  for (int i = 0; i < graph.edges.size(); i++) {
    Edge e = graph.edges.get(i);
    
    if (e.weight > 0.33) {
      if (over == null) {
        stroke(255, 128);
      } else if (over.id == e.source.id || over.id == e.target.id) {
        stroke(255);
        if (over.id != e.source.id) {
          highlighted.add(e.source);
        } else {
          highlighted.add(e.target);
        }
      } else {
        stroke(255, 64);
      }
      line(e.source.x, e.source.y, e.target.x, e.target.y);
    }
  }
  
  iter = graph.nodes.values().iterator();
  while (iter.hasNext()) {
    Node n = (Node) iter.next();
    
    noStroke();
    
    if (over == null) {
      fill(n.r, n.g, n.b, 128);
    } else if (over.id == n.id) {
      fill(n.r, n.g, n.b);
    } else {
      fill(n.r, n.g, n.b, 64);
    }
    
    ellipse(n.x, n.y, n.nodeSize, n.nodeSize);
  }
  
  textAlign(CENTER);
  fill(255);

  for (int i = 0; i < highlighted.size(); i++) {
    Node n = (Node) highlighted.get(i);
    textSize(n.nodeSize);
    text(n.label, n.x, n.y);
  }
}

void parseNode(XMLElement el) {
  Node n = new Node(el.getInt("id"));
  
  XMLElement[] children = el.getChildren();
  for (int i = 0; i < children.length; i++) {
    n.setAttr(children[i].getString("key"), children[i].getContent());
  }
  
  graph.addNode(n);
}

void parseEdge(XMLElement el) {
  Node source = graph.getNode(el.getInt("source"));
  Node target = graph.getNode(el.getInt("target"));
  Edge e = new Edge(source, target);
  
  XMLElement[] children = el.getChildren();
  for (int i = 0; i < children.length; i++) {
    e.setAttr(children[i].getString("key"), children[i].getContent());
  }
  
  graph.addEdge(e);
}

void keyPressed() {
  if (key == '-') {
    scaleBy -= 0.1;
  } else if (key == '=') {
    scaleBy += 0.1;
  }
}
