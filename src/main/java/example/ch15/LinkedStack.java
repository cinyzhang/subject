package example.ch15;

public class LinkedStack<T> {
  private static class Node<V>{
      V item;
      Node<V> next;
      Node(){item=null;next=null;}
      Node(V item,Node<V> next){this.item =item; this.next=next;}
      boolean end(){return item==null&&next==null;}
  }
  private Node<T> top = new Node<>();
  public void push(T item){
      top=new Node(item,top);
  }
  public T pop(){
      T result = top.item;
      if(!top.end()) top = top.next;
      return result;
  }

    public static void main(String[] args) {
        LinkedStack<String> lss = new LinkedStack<>();
        for(String s:"i love you".split(" ")){
            lss.push(s);
        }
        String s;
        while((s=lss.pop())!=null){
            System.out.println(s);
        }
    }

}
