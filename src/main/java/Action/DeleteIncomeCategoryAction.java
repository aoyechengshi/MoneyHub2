package Action;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import Exception.UserBusinessException;
import Exception.UserSystemException;
import Logic.CategoryDisplayiLogic;
import Logic.DeleteIncomeCategoryLogic;
import Logic.IncomeCategoryLogic;
import entity.Category;
import entity.Income;

public class DeleteIncomeCategoryAction implements ActionIF {
	@Override
	public String execute(HttpServletRequest request) {
		String page = "Set.jsp";
		try {
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("userId") == null) {
				return "Logins.jsp";
			}

			int userId = (Integer) session.getAttribute("userId");
			String categoryId = request.getParameter("incomeCategoryId");

			DeleteIncomeCategoryLogic deleteIncomeCategoryLogic = new DeleteIncomeCategoryLogic();
			deleteIncomeCategoryLogic.deleteIncomeCategory(userId, categoryId);

			CategoryDisplayiLogic logic = new CategoryDisplayiLogic();
			ArrayList<Category> fixedCategories = logic.CategoryDisplayKoteihi(userId);
			ArrayList<Category> variableCategories = logic.CategoryDisplayHendouhi(userId);
			IncomeCategoryLogic incomeCategoryLogic = new IncomeCategoryLogic();
			ArrayList<Income> incomeCategoryList = incomeCategoryLogic.IncomeCategory(userId);

			request.setAttribute("fixedCategories", fixedCategories);
			request.setAttribute("variableCategories", variableCategories);
			request.setAttribute("incomeCategoryList", incomeCategoryList);
			request.setAttribute("openModal", "incomeModal");

		} catch (UserBusinessException e) {
			request.setAttribute("errorMessage", e.getMessage());
		} catch (UserSystemException e) {
			request.setAttribute("errorMessage", e.getMessage());
		}
		return page;
	}
}
