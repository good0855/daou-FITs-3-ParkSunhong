package example.view;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;


public class BookView extends Application {
    @Override
    public void start(Stage stage) throws Exception {
        // 화면 구성
        // Stage - Scene - Parent(Layout Manager)
        Parent root = null;

        FXMLLoader loader = new FXMLLoader(getClass().getResource("/bookmybatis.fxml"));


        try {
            root = loader.load();
        } catch (Exception e) {
            System.out.println("error");
            e.printStackTrace();
        }

        Scene scene = new Scene(root);
        stage.setScene(scene);
        stage.setTitle("Book Search MVC");

        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}