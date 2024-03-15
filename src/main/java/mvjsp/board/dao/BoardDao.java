package mvjsp.board.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;

import mvjsp.board.model.Board;
import mvjsp.jdbc.JdbcUtil;

public class BoardDao {
	private static BoardDao dao = new BoardDao();

	private BoardDao() {
	} // 생성자

	public static BoardDao getInstance() {
		return dao;
	}

	public String getBoardWriter(Connection conn, int num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String writer = null;
		try {
			pstmt = conn.prepareStatement("SELECT writer FROM board WHERE num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				writer = rs.getString("writer");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			JdbcUtil.close(rs, pstmt);
		}

		return writer;
	}

	public ArrayList<Board> selectList(Connection conn) {
		ArrayList<Board> list = new ArrayList<Board>();
		String sql = "select * from board order by num desc";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board board = new Board(rs.getInt("num"), rs.getString("writer"), rs.getString("title"),
						rs.getString("content"), rs.getString("regtime"), rs.getInt("hits"));
				list.add(board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt);
		}

		return list;
	}

	public Board selectOne(Connection conn, int num, boolean inc) {
		Board board = null;
		String sql = "select * from board where num = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new Board(rs.getInt("num"), rs.getString("writer"), rs.getString("title"),
						rs.getString("content"), rs.getString("regtime"), rs.getInt("hits"));

			}
			// hits 수 올리기
			if (inc) {
				pstmt.executeUpdate("update board set hits=hits+1 where num=" + num);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return board;

	}

	public int delete(Connection conn, int num) {
		try (

				PreparedStatement pstmt = conn.prepareStatement("delete from board where num = ?");) {
			pstmt.setInt(1, num);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int insert(Connection conn, Board board) {
	    String sql = "insert into board(num, title, writer, content, regtime, hits) values (SEQ_BOARD.nextval, ?, ?, ?, SYSDATE, 0)";
	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, board.getTitle());
	        pstmt.setString(2, board.getWriter());
	        pstmt.setString(3, board.getContent());
	        return pstmt.executeUpdate();
	    } catch(SQLException e) {
	        e.printStackTrace();
	    }
	    return 0;
	}


	public int update(Connection conn, Board board) {
		String sql = "update board set writer=?, title=?, content=?, regtime=sysdate where num=?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			// 현재 시간 얻기
//	        String curTime = LocalDate.now() + " " + 
//	                         LocalTime.now().toString().substring(0, 8);

			// 쿼리 실행
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, board.getNum());
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

}
