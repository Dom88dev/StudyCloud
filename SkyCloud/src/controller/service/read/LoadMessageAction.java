package controller.service.read;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import controller.service.Action;
import model.Message;
import model.Notice;
import persistance.BoardDao;
import persistance.MessageDao;

//쪽지 목록 불러오기
public class LoadMessageAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		JsonObject jobj = new JsonObject();
		MessageDao messageDao = new MessageDao();
		String reciever = "1@a.com";
		System.out.println("reciever : "+ reciever);
		ArrayList<Message> mList = (ArrayList<Message>) messageDao.getMsgList(reciever);
		JsonArray jarrayNList = (JsonArray) new Gson().toJsonTree(mList, new TypeToken<List<Message>>() {
		}.getType());
		jobj.add("msgList", jarrayNList);
		String jsonData = new Gson().toJson(jobj);
		System.out.println("jsonData : "+jsonData);
		return jsonData;
	}

}
