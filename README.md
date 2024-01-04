### MVC게시판(Spring Framwork, MyBatis, Oracle, tiles)

#### 1. 구현된 기능
- 게시판
  - 글 상세
  - 글 등록 - jsp(front) 및 서버(back)에서 글제목 길이, 글내용 길이 제한, 파일2개 첨부 기능
  - 글 삭제
  - 글 수정 - jsp(front) 및 서버(back)에서 글제목 길이, 글내용 길이 제한
- 회원
  - 로그인 - jsp(front) 및 서버(back)에서 아이디 및 패스워드의 길이 제한
  - 로그아웃 
  - 회원가입 - jsp(front) 및 서버(back)에서 아이디, 패스워드, 이름, 이메일 길이 제한 / 서버(back)에서 패스워드 단방향 암호화 후 db(oracle)에 저장

#### 2. 추가해야할 기능
- 답글 기능
 
#### 3.SQL
  1-1.board.xml
  
  	<select id="selectAllBoardList" parameterType="Map" resultMap="boardResult">
	     	select * 
	     	from(
	     	select rownum rn, x.*
	     	from(
	         select * from t_board 
	         <where>
		         articleType = #{articleType}
		         <if test='title != null and title!=""'>
		         and title like '%'||#{title}||'%'
		         </if>
		         <if test="content != null and content!=''">
		         and content like '%'||#{content}||'%'
		         </if>
		         <if test="id != null and id != ''">
		         and id like '%'||#{id}||'%'
		         </if>
	        </where>  
	          order by writeDate desc
	          ) x
	          )
	          <where>
	          	rn <![CDATA[>]]> #{param1} and rn <![CDATA[<=]]> #{param2}
	          </where>	 	
	</select>


	<select id="selectArticle" parameterType="int" resultType="boardVo">
        	select * from t_board
         	<where>
	         	articleNO = #{articleNO}
        	</where>  	 	
	</select> 


 	 <delete id="deleteArticle"  parameterType="int">
		   delete from t_board
		   where
		   articleNO = #{articleNO}
	 </delete>


  	<insert id="insertArticle"  parameterType="boardVo">
		 insert into t_board(articleNO, title, 
		 <if test="content!=null">
		 content, 
		 </if>
		 id, 
		 <if test='fileName_1!=null'>
		 fileName_1,
		 </if>
		 <if test='fileName_2!=null'> 
		 fileName_2,
		 </if> 
		 articleType)
		 values(no_seq.nextval, #{title}, 
		 <if test="content!=null">
		 #{content, jdbcType=VARCHAR}, 
		 </if>
		 #{id},
		 <if test='fileName_1!=null'>
		 #{fileName_1},
		 </if>
		 <if test='fileName_2!=null'> 
		 #{fileName_2},
		 </if> 
		 #{articleType}) 
	</insert>


  	<update id="updateArticle"  parameterType="boardVo">
	     update t_board
	     <set>
		     title=#{title}, content=#{content},
		     <if test="fileName_1!=null">
		     	fileName_1=#{fileName_1}, 
		     </if>
		     <if test="fileName_2!=null">
		     	fileName_2=#{fileName_2},
		     </if>
		 </set>   
	     where
	     articleNO=#{articleNO}
   	</update>

   1-2.memebr.xml
   	
    <select id="getLoginMember" resultType="memberVo" parameterType="memberVo">
  		select * from t_member	
  		where id=#{id}		
  	</select>


    <select id="checkIsMember" parameterType="memberVo" resultType="memberVo">
		 select * from t_member	
		where id=#{id}      
	</select>


  	<insert id="insertMember"  parameterType="memberVo">
  		insert into t_member(id,pwd, name, email)
  		values(#{id}, #{pwd}, #{name}, #{email})      
	</insert>   
