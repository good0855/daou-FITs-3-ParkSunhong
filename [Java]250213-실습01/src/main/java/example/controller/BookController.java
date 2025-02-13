package example.controller;

import example.service.BookServiceImpl;
import example.vo.BookVO;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.util.converter.IntegerStringConverter;

import java.net.URL;
import java.util.ResourceBundle;


public class BookController implements Initializable {

    private final BookServiceImpl bookSearchServiceImpl = BookServiceImpl.getInstance();

    @FXML
    private TableView<BookVO> tableView;

    @FXML
    private TableColumn<BookVO, String> isbnCol;

    @FXML
    private TableColumn<BookVO, String> titleCol;

    @FXML
    private TableColumn<BookVO, Integer> priceCol;

    @FXML
    private TableColumn<BookVO, String> authorCol;

    @FXML
    private Button addButton;

    @FXML
    private Button searchButton;

    @FXML
    private Button deleteButton;

    @FXML
    private TextField isbnField;

    @FXML
    private TextField titleField;

    @FXML
    private TextField priceField;

    @FXML
    private TextField authorField;

    @FXML
    private TextField searchField;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
//        ObservableList<BookVO> bookList = bookSearchServiceImpl.findAllBooks();

        // 초기 로드 시 일단 로드
        searchAllBook();

        isbnCol.setCellValueFactory(new PropertyValueFactory<>("bisbn"));
        titleCol.setCellValueFactory(new PropertyValueFactory<>("btitle"));
        priceCol.setCellValueFactory(new PropertyValueFactory<>("bprice"));
        authorCol.setCellValueFactory(new PropertyValueFactory<>("bauthor"));

        // 셀 수정 가능하게 설정
        tableView.setEditable(true);
        titleCol.setCellFactory(TextFieldTableCell.forTableColumn());
        priceCol.setCellFactory(TextFieldTableCell.forTableColumn(new IntegerStringConverter()));
        authorCol.setCellFactory(TextFieldTableCell.forTableColumn());

        // 셀 값 수정 이벤트 핸들러 추가
        titleCol.setOnEditCommit(event -> {
            BookVO book = event.getRowValue();
            book.setBtitle(event.getNewValue());
            updateBook(book);
        });

        priceCol.setOnEditCommit(event -> {
            BookVO book = event.getRowValue();
            book.setBprice(event.getNewValue());
            updateBook(book);
        });

        authorCol.setOnEditCommit(event -> {
            BookVO book = event.getRowValue();
            book.setBauthor(event.getNewValue());
            updateBook(book);
        });

        // 책 등록 버튼 클릭 시 추가\
        addButton.setOnMouseClicked(event -> {
            // 각 TextField에서 값을 가져옵니다.
            String isbn = isbnField.getText();
            String title = titleField.getText();
            int price = Integer.parseInt(priceField.getText());  // 가격은 숫자이므로 parse
            String author = authorField.getText();

            System.out.println(isbn);

            // addBook 메서드에 값을 넘겨줍니다.
            addBook(isbn, title, price, author);
            System.out.println("등록 완료");

            // 추가 후 TextField 값 초기화 (선택 사항)
            isbnField.clear();
            titleField.clear();
            priceField.clear();
            authorField.clear();
        });

        // 책 검색 버튼 클릭 시 검색
        searchButton.setOnMouseClicked(event -> {
            String searchInput = searchField.getText();
            searchBookByTitle(searchInput);

        });

        // TODO : alert 로직을 해당 코드블럭에 넣고 deleteBook은 삭제만 수행하도록 하기
        // 책 삭제 버튼 클릭 시 검색
        deleteButton.setOnMouseClicked(event -> {
            deleteBook();
        });

    }

    /*
        전체 책 조회
     */

    private void searchAllBook() {
        ObservableList<BookVO> bookList = bookSearchServiceImpl.findAllBooks();
        tableView.setItems(bookList);
    }

    /*
        책 검색
     */
    private void searchBookByTitle(String title) {
        ObservableList<BookVO> bookList = bookSearchServiceImpl.findBookByTitle(title);

        // Set the items of the tableView to the result
        tableView.setItems(bookList);
    }

    /*
        책 등록
     */
    private void addBook(String bisbn, String btitle, int bprice, String bauthor) {
        // 책 추가
        bookSearchServiceImpl.saveBook(bisbn, btitle, bprice, bauthor);
        // 리프레시
        tableView.refresh();

    }
    /*
        책 수정
     */
    private void updateBook(BookVO book) {
        bookSearchServiceImpl.updateBook(book);  // DB 업데이트 실행
        tableView.refresh();  // 화면 갱신
    }

    /*
        책 삭제
     */
    private void deleteBook() {
        // 선택된 행 가져오기
        BookVO selectedBook = tableView.getSelectionModel().getSelectedItem();

        if (selectedBook != null) {
            // 삭제 확인 알림창
            Alert alert = new Alert(AlertType.CONFIRMATION);
            alert.setTitle("삭제 확인");
            alert.setHeaderText("선택한 책을 삭제하시겠습니까?");
            alert.setContentText("ISBN: " + selectedBook.getBisbn() + "\n제목: " + selectedBook.getBtitle());

            // 확인 버튼 선택 시 삭제 진행
            alert.showAndWait().ifPresent(response -> {
                if (response == ButtonType.OK) {
                    String isbn = selectedBook.getBisbn();
                    bookSearchServiceImpl.removeBook(isbn); // 서비스에서 삭제 실행

                    // 테이블 갱신
                    searchAllBook();
                    System.out.println("삭제 완료: " + isbn);
                }
            });

        } else {
            // 삭제할 책을 선택하지 않은 경우 알림창 띄우기
            Alert alert = new Alert(AlertType.WARNING);
            alert.setTitle("삭제 오류");
            alert.setHeaderText("삭제할 책을 선택하세요.");
            alert.setContentText("삭제할 책을 선택한 후 다시 시도해주세요.");
            alert.showAndWait();
        }
    }
}
