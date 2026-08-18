-- seoulhiking db script

-- 프로젝트 스키마 ( 테이블 모음 )
CREATE SCHEMA sh
 DEFAULT CHARACTER SET utf8mb4 
DEFAULT COLLATE utf8mb4_general_ci;

-- 만들어진 프로젝트 스키마 사용
use sh;


-- 산 테이블 ( 한 / 영 변경 용도 en 컬럼 추가)
create table mountain (
   mt_id int auto_increment,
    mt_img varchar(200) not null,
    mt_name varchar(20) not null,
    mt_content varchar(1000) not null,
    mt_location varchar(100) not null,
    mt_height int not null,
    mt_name_en varchar(40) not null,
    mt_content_en varchar(1500) not null,
    mt_location_en varchar(200) not null,
    mt_trail_img varchar(200) not null,
    primary key (mt_id)
);

-- 리뷰 테이블
create table review (
   rv_numid int auto_increment,
   rv_title varchar(100) not null,
    rv_content varchar(1000),
    rv_nickid varchar(10) not null,
   rv_pwd varchar(10) not null,
    rv_img varchar(200),
    mt_id int,
    primary key(rv_numid),
    foreign key (mt_id) references mountain(mt_id)
    );

-- 산 데이터 삽입 (mt_img 포함)
insert into mountain(
    mt_img, mt_name, mt_content, mt_location, mt_height,
    mt_name_en, mt_content_en, mt_location_en, mt_trail_img)
values
    ('bukhansan.jpg', '북한산', '서울 북쪽에 있는 화강암 봉우리로 이루어진 국립공원. 백운대, 인수봉 등 명소가 있다. [ 백운대탐방지원센터 → 북한산 하루재 → 백운봉암문 → 북한산 백운대 ]', '서울특별시 강북구·도봉구·은평구 일대', 836,
     'Bukhansan', 'A granite-peaked national park in northern Seoul, home to Baegundae and Insubong peaks. [ Baegundae Trail Support Center → Bukhansan Harujae → Baegunbong Rock Gate → Bukhansan Baegundae ]', 'Gangbuk-gu, Dobong-gu, Eunpyeong-gu, Seoul', 'bukhansan_route.jpg'),
    ('gwanaksan.jpg', '관악산', '서울 남쪽을 대표하는 화강암 산으로, 정상 연주대에서는 서울 도심과 수도권 남부를 한눈에 조망할 수 있다. [ 아차산어울림광장 → 아차산휴게소 → 관악산 정상 ]', '서울특별시 관악구·금천구 일대', 632,
     'Gwanaksan', 'A granite mountain in southern Seoul. From its peak, Yeonjudae, hikers get a sweeping view of downtown Seoul and the southern metropolitan area. [ Achasan Eoullim Square → Achasan Rest Area → Achasan Summit ]', 'Gwanak-gu, Geumcheon-gu, Seoul', 'gwanaksan_route.jpg'),
    ('achasan.jpg', '아차산', '한강과 서울 시내를 조망할 수 있는 산으로 고구려 유적이 남아있다. [ 건설환경종합연구소 → 학바위 → 깔딱고개 → 아차산 정상 ]', '서울특별시 광진구 일대', 287,
     'Achasan', 'A mountain offering scenic views of the Han River and downtown Seoul, home to remaining Goguryeo-era historical relics. [ Construction & Environment Research Institute → Hakbawi → Ttakttalgogae Pass → Gwanaksan Summit ]', 'Gwangjin-gu, Seoul', 'achasan_route.jpg'),
    ('inwangsan.jpg', '인왕산', '기암괴석과 서울 성곽이 어우러진 산으로 도심 조망이 뛰어나다. [ 사직근린공원 → 황학정 → 인왕산 등산로 입구 → 인왕산 범바위 → 인왕산 정상 ]', '서울특별시 종로구·서대문구 일대', 338,
     'Inwangsan', 'Known for its unique rock formations and city wall trail with great views of downtown Seoul. [ Sajik Neighborhood Park → Hwanghakjeong → Inwangsan Trail Entrance → Inwangsan Beombawi → Inwangsan Summit ]', 'Jongno-gu, Seodaemun-gu, Seoul', 'inwangsan_route.jpg'),
    ('namsan.jpg', '남산', '서울타워로 유명한 도심 속 산으로 케이블카로도 오를 수 있다. [ 남산공원 입구 → 백범광장 → 남산팔각정 ]', '서울특별시 중구·용산구 일대', 262,
     'Namsan', 'A downtown mountain famous for N Seoul Tower, accessible by cable car. [ Namsan Park Entrance → Baekbeom Square → Namsan Palgakjeong ]', 'Jung-gu, Yongsan-gu, Seoul', 'namsan_route.jpg');

-- 산 목록 조회 ( 영문일 경우)
select mt_id, mt_img, mt_name_en as mt_name, mt_content_en as mt_content, mt_location_en as mt_location,
   mt_height, mt_trail_img from mountain;

-- 산 목록 조회 ( 한글일 경우 )
select mt_id, mt_img, mt_name, mt_content, mt_location, mt_height, mt_trail_img
   from mountain;

-- 리뷰 조회
select r.rv_numid as rv_numid, r.rv_title as rv_title, r.rv_content as rv_content, 
   r.rv_img as rv_img, r.rv_nickid as rv_nickid, m.mt_name as mt_name, m.mt_name_en as mt_name_en
    from review r join mountain m on r.mt_id = m.mt_id;

-- 리뷰 작성 
insert into review(rv_title, rv_content, rv_nickid, rv_pwd, rv_img, mt_id)
   values('제목', '내용', '별명', '1234', 'image/jpg', 1);

-- 수정 폼에 데이터를 채울 리뷰 조회
select * from
   review where rv_numid = 1;

-- 해당하는 리뷰 수정
update review set 
   rv_title  = '제목 변경',
    rv_content = '내용 변경',
    rv_img = 'good.jpg'
    where rv_numid = 1;
    
-- 리뷰 삭제
delete from review where rv_numid = 1;

drop table review;
drop table mountain;