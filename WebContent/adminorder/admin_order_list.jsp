<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="net.order.db.*" %>
<%@ page import="java.util.*" %>
<%
	List orderlist=(List)request.getAttribute("orderlist");
	int ordercount=((Integer)request.getAttribute("ordercount")).intValue();
	int nowpage=((Integer)request.getAttribute("page")).intValue();
	int maxpage=((Integer)request.getAttribute("maxpage")).intValue();
	int startpage=((Integer)request.getAttribute("startpage")).intValue();
	int endpage=((Integer)request.getAttribute("endpage")).intValue();
%>

<html>
<head>
<title>���θ�</title>
</head>
<body>
<table width = "960" cellpacing = "0" cellpadding = "0" border="0" align ="center">
<tr>
<td colspan=2 align = center>
<table border=0 cellspacing =1 cellpadding = 0 width = 80%>
	<tr>
	<td align = right colspan = 10 height = 25 colspan =2 style =font-family:Tahoma; font-size:8pt;>
	��ü �ֹ� �� : <b><%=ordercount  %></b> �� &nbsp;&nbsp;&nbsp;
	</td>
	</tr>
	<tr align=center height=20>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>�ֹ���ȣ</td>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>�ֹ���</td>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>�������</td>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>�ֹ��ݾ�</td>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>�ֹ�����</td>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>�ֹ��Ͻ�</td>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>����/����</td>
	</tr>
	<tr>
	<%for(int i=0; i<orderlist.size();i++) {
		OrderBean order=new OrderBean();
		order=(OrderBean) orderlist.get(i); %>
	<tr align = center height = 20>
	<td style = font-family:Tahoma;font-size:7pt;><%=order.getORDER_TRADE_NUM()%></td>
	<td style = font-family:Tahoma;font-size:8pt;><%=order.getORDER_MEMBER_ID()%></td>
	<td style = font-family:Tahoma;font-size:8pt;><%=order.getORDER_TRADE_TYPE()%></td>
	<td style = font-family:Tahoma;font-size:8pt;><%=order.getORDER_SUM_MONEY()%></td>
	<td style = font-family:Tahoma;font-size:8pt;>
		<%if(order.getORDER_STATUS()==0) { %>
			�ڴ���ߡ� 
		<%}else if(order.getORDER_STATUS() ==1){ %>
			�ڹ߼��غ�� 
		<%}else if(order.getORDER_STATUS() ==2){ %>
			�ڹ߼ۿϷ��
		<%}else if(order.getORDER_STATUS() ==3){ %>
			�ڹ���ߡ� 
		<%}else if(order.getORDER_STATUS() ==4){ %>
			�ڹ�ۿϷ�� 
		<%}else if(order.getORDER_STATUS() ==5){ %>
			���ֹ���ҡ� 
		<%} %>
	</td>
	
	<td style = font-family:Tahoma;font-size:8pt;><%=order.getORDER_DATE()%></td>
	<td style = font-family:Tahoma;font-size:8pt;>
	<a href = "./AdminOrderDetail.ao?num=<%=order.getORDER_NUM() %>">
	Modify</a>/
	<a href = "./AdminOrderDelete.ao?num=<%=order.getORDER_NUM() %>" 
			onclick="return confirm('�����Ͻðڽ��ϱ�??')">Delete</a>
	</td>
	</tr>
	<tr>
		<td style = "background-color:#F0F0F0; height:1px;" colspan = 6>
	</tr>
	<%}  %>
	<tr align=center height=20>
		<td colspan=7 style=font-family:Tahoma; font-size:10pt;>
			<%if(nowpage<=1){ %>[����]&nbsp;
			<%}else{ %>
			<a href = "./AdminOrderList.ao?page=<%=nowpage-1 %>">
			[����]</a>&nbsp;
			<%}%>
			<%for(int a=startpage;a<=endpage;a++) {
				if(a==nowpage){%>[<%=a%>]
				<%}else{ %>
					<a href ="./AdminOrderList.ao?page=<%=a %>">
					[<%=a %>]
					</a> &nbsp;
				<%} %>
			<%} %>
			<%if(nowpage>=maxpage){ %>[����] 
			<%}else{ %>
			<a href ="./AdminOrderList.ao?page=<%=nowpage+1  %>">[����]</a>
			<%} %>	
		</td>
	</tr>
</table>
</td>
</tr>
</table>
</body>
</html>