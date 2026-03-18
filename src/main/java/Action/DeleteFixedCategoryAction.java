package Action;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import Exception.UserBusinessException;
import Exception.UserSystemException;
import Logic.CategoryDisplayiLogic;
import Logic.DeleteFixedCategoryLogic;
import Logic.IncomeCategoryLogic;
import Logic.ShowIncomeLogic;
import Logic.findExpenseLogic;
import entity.Category;
import entity.Expenses;
import entity.Income;

public class DeleteFixedCategoryAction implements ActionIF {

	@Override
	public String execute(HttpServletRequest request) {
		try {
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("userId") == null) {
				return "Logins.jsp";
			}

			int userId = (Integer) session.getAttribute("userId");
			int categoryId = Integer.parseInt(request.getParameter("categoryId"));
			String categoryType = request.getParameter("categoryType");
			String returnPage = request.getParameter("returnPage");
			boolean toHome = "home.jsp".equals(returnPage);

			DeleteFixedCategoryLogic logic = new DeleteFixedCategoryLogic();
			logic.deleteFixedCategory(userId, categoryId);

			if (toHome) {
				return loadHomeData(request, userId, categoryType);
			} else {
				return loadSetData(request, userId, categoryType);
			}

		} catch (UserBusinessException e) {
			request.setAttribute("errorMessage", e.getMessage());
		} catch (UserSystemException e) {
			request.setAttribute("errorMessage", e.getMessage());
		}

		// エラー時: returnPage に応じてデータをロードして返す
		try {
			HttpSession session = request.getSession(false);
			int userId = (Integer) session.getAttribute("userId");
			String returnPage = request.getParameter("returnPage");
			String categoryType = request.getParameter("categoryType");
			boolean toHome = "home.jsp".equals(returnPage);
			if (toHome) {
				return loadHomeData(request, userId, categoryType);
			} else {
				return loadSetData(request, userId, categoryType);
			}
		} catch (Exception ex) {
			return "Set.jsp";
		}
	}

	private String loadSetData(HttpServletRequest request, int userId, String categoryType)
			throws UserBusinessException, UserSystemException {
		CategoryDisplayiLogic displayLogic = new CategoryDisplayiLogic();
		ArrayList<Category> fixedCategories = displayLogic.CategoryDisplayKoteihi(userId);
		ArrayList<Category> variableCategories = displayLogic.CategoryDisplayHendouhi(userId);
		IncomeCategoryLogic incomeCategoryLogic = new IncomeCategoryLogic();
		ArrayList<Income> incomeCategoryList = incomeCategoryLogic.IncomeCategory(userId);

		request.setAttribute("fixedCategories", fixedCategories);
		request.setAttribute("variableCategories", variableCategories);
		request.setAttribute("incomeCategoryList", incomeCategoryList);
		request.setAttribute("openModal", categoryType);
		return "Set.jsp";
	}

	private String loadHomeData(HttpServletRequest request, int userId, String categoryType)
			throws UserBusinessException, UserSystemException {
		CategoryDisplayiLogic displayLogic = new CategoryDisplayiLogic();
		ArrayList<Category> fixedCategories = displayLogic.CategoryDisplayKoteihi(userId);
		ArrayList<Category> variableCategories = displayLogic.CategoryDisplayHendouhi(userId);
		IncomeCategoryLogic incomeCategoryLogic = new IncomeCategoryLogic();
		ArrayList<Income> incomeCategoryList = incomeCategoryLogic.IncomeCategory(userId);
		findExpenseLogic expenseLogic = new findExpenseLogic();
		ArrayList<Expenses> expenseList = expenseLogic.findExpense(userId);
		ShowIncomeLogic incomeLogic = new ShowIncomeLogic();
		ArrayList<Income> incomeList = incomeLogic.showIncome(userId);

		request.setAttribute("fixedCategories", fixedCategories);
		request.setAttribute("variableCategories", variableCategories);
		request.setAttribute("incomeCategoryList", incomeCategoryList);
		request.setAttribute("expenseList", expenseList);
		request.setAttribute("incomeList", incomeList);
		request.setAttribute("openModal", categoryType);
		return "home.jsp";
	}
}
