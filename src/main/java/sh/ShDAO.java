package sh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ShDAO {

	// 메인 화면에 보여줄 산 리스트 조회 / 한글 , 영문에 따라 case를 별로
	public static List<MountainTO> getMountainList(String lang) {
		List<MountainTO> mtList = new ArrayList<MountainTO>();
		String sql = "";
		if ("eng".equals(lang)) {
			sql = "select mt_id, mt_name_en as mt_name, mt_content_en as mt_content, mt_location_en as mt_location,\r\n"
					+ "	mt_height, mt_trail_img from mountain";
		} else {
			sql = "select mt_id, mt_name, mt_content, mt_location, mt_height, mt_trail_img\r\n"
					+ "	from mountain";
		}

		try (Connection conn = DBUtil.getConnection()) {

			PreparedStatement psmt = conn.prepareStatement(sql);

			ResultSet rs = psmt.executeQuery();

			while (rs.next()) {
				MountainTO mt = new MountainTO();
				mt.setMtId(rs.getInt("mt_id"));
				mt.setMtName(rs.getString("mt_name"));
				mt.setMtContent(rs.getString("mt_content"));
				mt.setMtLocation(rs.getString("mt_location"));
				mt.setMtHeight(rs.getInt("mt_height"));
				mt.setMtTrailImg(rs.getString("mt_trail_img"));

				mtList.add(mt);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mtList;
	}

	// 리뷰 목록에 있는 리뷰들 조회
	public static List<ReviewTO> getReviewList() {
		List<ReviewTO> rvList = new ArrayList<ReviewTO>();
		String sql = "select r.rv_numid as rv_numid, r.rv_title as rv_title, r.rv_content as rv_content, r.rv_img as rv_img"
				+ ", r.rv_nickid as rv_nickid, m.mt_name as mt_name, m.mt_name_en as mt_name_en\r\n"
				+ "	from review r join mountain m on r.mt_id = m.mt_id";
		try (Connection conn = DBUtil.getConnection()) {

			PreparedStatement psmt = conn.prepareStatement(sql);

			ResultSet rs = psmt.executeQuery();

			while (rs.next()) {
				ReviewTO rv = new ReviewTO();
				rv.setRvNumid(rs.getInt("rv_numid"));
				rv.setRvTitle(rs.getString("rv_title"));
				rv.setRvContent(rs.getString("rv_content"));
				rv.setRvImg(rs.getString("rv_img"));
				rv.setRvNickid(rs.getString("rv_nickid"));
				rv.setMtName(rs.getString("mt_name"));
				rv.setMtNameEn(rs.getString("mt_name_en"));
				rvList.add(rv);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return rvList;
	}

	// 폼에서 작성한 리뷰 작성
	public static int insertReview(ReviewTO rv) {
		int result = -1;
		String sql = "insert into review(rv_title, rv_content, rv_nickid, rv_pwd, rv_img, mt_id)\r\n"
				+ "	values(?, ?, ?, ?, ?, ?)";

		try (Connection conn = DBUtil.getConnection()) {
			PreparedStatement psmt = conn.prepareStatement(sql);

			psmt.setString(1, rv.getRvTitle());
			psmt.setString(2, rv.getRvContent());
			psmt.setString(3, rv.getRvNickid());
			psmt.setString(4, rv.getRvPwd());
			psmt.setString(5, rv.getRvImg());
			psmt.setInt(6, rv.getMtId());

			result = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;

	}

	public static ReviewTO getReviewById(int rvNumId) {
		ReviewTO rv = new ReviewTO();
		String sql = "select * from review where rv_numid = ?";

		try (Connection conn = DBUtil.getConnection()) {

			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, rvNumId);

			ResultSet rs = psmt.executeQuery();

			while (rs.next()) {
				rv.setRvNumid(rs.getInt("rv_numId"));
				rv.setRvTitle(rs.getString("rv_title"));
				rv.setRvContent(rs.getString("rv_content"));
				rv.setRvNickid(rs.getString("rv_nickid"));
				rv.setRvPwd(rs.getString("rv_pwd"));
				rv.setRvImg(rs.getString("rv_img"));
				rv.setMtId(rs.getInt("mt_id"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return rv;

	}

	// 리뷰 수정
	public static int updateReview(ReviewTO rv) {
		int result = -1;
		String sql = "update review set rv_title = ?, rv_content = ?, rv_img = ?" + " where rv_numid = ? and rv_pwd = ?";

		try (Connection conn = DBUtil.getConnection()) {

			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, rv.getRvTitle());
			psmt.setString(2, rv.getRvContent());
			psmt.setString(3, rv.getRvImg());
			psmt.setInt(4, rv.getRvNumid());
			psmt.setString(5, rv.getRvPwd());
			
			result = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// 리뷰 삭제
	public static int deleteReview(int rvNumId, String rvPwd) {
		int result = -1;
		String sql = "delete from review where rv_numid = ? and rv_pwd = ?";

		try (Connection conn = DBUtil.getConnection()) {

			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, rvNumId);
			psmt.setString(2, rvPwd);

			result = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
