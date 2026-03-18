package Action;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import Exception.UserBusinessException;
import Exception.UserSystemException;
import Logic.CategoryDisplayiLogic;
import Logic.DeleteFixedCategoryLogic;
import Logic.IncomeCategoryLogic;
import entity.Category;
import entity.Income;

public class DeleteFixedCategoryAction implements ActionIF {

	@Override
	public String execute(HttpServletRequest request) {
		String page = "Set.jsp";
		try {
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("userId") == null) {
				return "Logins.jsp";
			}

			int userId = (Integer) session.getAttribute("userId");
			int categoryId = Integer.parseInt(request.getParameter("categoryId"));
			String categoryType = request.getParameter("categoryType");

			DeleteFixedCategoryLogic logic = new DeleteFixedCategoryLogic();
			logic.deleteFixedCategory(userId, categoryId);

			CategoryDisplayiLogic displayLogic = new CategoryDisplayiLogic();
			ArrayList<Category> fixedCategories = displayLogic.CategoryDisplayKoteihi(userId);
			ArrayList<Category> variableCategories = displayLogic.CategoryDisplayHendouhi(userId);
			IncomeCategoryLogic incomeCategoryLogic = new IncomeCategoryLogic();
			ArrayList<Income> incomeCategoryList = incomeCategoryLogic.IncomeCategory(userId);

			request.setAttribute("fixedCategories", fixedCategories);
			request.setAttribute("variableCategories", variableCategories);
			request.setAttribute("incomeCategoryList", incomeCategoryList);
			request.setAttribute("openModal", categoryType);

		} catch (UserBusinessException e) {
			request.setAttribute("errorMessage", e.getMessage());
		} catch (UserSystemException e) {
			request.setAttribute("errorMessage", e.getMessage());
		}
		return page;
	}
}
