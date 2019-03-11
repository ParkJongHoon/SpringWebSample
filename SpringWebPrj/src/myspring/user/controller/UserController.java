package myspring.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import myspring.user.service.UserService;
import myspring.user.vo.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	
	@RequestMapping("/getUserList.do")
	public String getUserList(Model model) {
		List<UserVO> userList = userService.getUserList();
		model.addAttribute("userList", userList);
		return "userList";
	}
	
	/*
	@RequestMapping("/getUserList.do")
	public ModelAndView getUserList() {
		return new ModelAndView("userList", "userList", userService.getUserList());
	}
	*/
	/*
	 * @RequestParam과 @PathVariable의 차이
	 * @RequestParam은 get방식으로 받아오는 파라미터
	 * @PathVariable은 post방식으로 오는 파라미
	 */
	
	@RequestMapping("/getUser.do")
	public ModelAndView getUser(@RequestParam String id) {
		UserVO user = userService.getUser(id);
		return new ModelAndView("userInfo", "user", user);
	}
	
	// insertUserForm.do
	@RequestMapping("/insertUserForm.do")
	public ModelAndView insertUserForm() {
		List<String> genderList = new ArrayList<String>();
		genderList.add("남");
		genderList.add("여");
		List<String> cityList = new ArrayList<String>();
		cityList.add("서울");
		cityList.add("부산");
		cityList.add("대구");
		cityList.add("제주");
		Map<String, List<String>> map = new HashMap<>();
		map.put("genderList", genderList);
		map.put("cityList", cityList);
		return new ModelAndView("userInsert", "map", map);
	}
	//insertUser.do
	@RequestMapping("/insertUser.do")
	public String insertUser(@ModelAttribute UserVO user) {
		userService.insertUser(user);
		return "redirect:/getUserList.do";
	}
	
	// updateUserForm.do
	@RequestMapping("/updateUserForm.do")
	public ModelAndView updateUsrForm(@RequestParam String id) {
		UserVO user = userService.getUser(id);
		List<String> genderList = new ArrayList<String>();
		genderList.add("남");
		genderList.add("여");
		List<String> cityList = new ArrayList<String>();
		cityList.add("서울");
		cityList.add("부산");
		cityList.add("대구");
		cityList.add("제주");
		Map<String, Object> map = new HashMap<>();
		map.put("user", user);
		map.put("genderList", genderList);
		map.put("cityList", cityList);
		return new ModelAndView("userUpdate", "map", map);
	}
	
	// updateUser.do
	@RequestMapping("/updateUser.do")
	public String updateUser(@ModelAttribute UserVO user) {
		userService.updateUser(user);
		return "redirect:/getUserList.do";
	}
	
	//deleteUser.do
	@RequestMapping(value="/deleteUser.do/{id}")
	public String deleteUser(@PathVariable String id) {
		userService.deleteUser(id);		
		return "redirect:/getUserList.do";
		
	}
	@ExceptionHandler
	public String handleException(Exception e) {
		return "viewError";
	}
	

	

}
