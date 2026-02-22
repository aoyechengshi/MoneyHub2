package Action;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import Exception.UserBusinessException;
import Exception.UserSystemException;
import Logic.AssetsCategoryTotalAmountLogic;
import Logic.CategoryDisplayiLogic;
import Logic.FindAssetsCategoryLogic;
import Logic.IncomeCategoryLogic;
import Logic.InsertAssetsLogic;
import Logic.ShowIncomeLogic;
import Logic.findExpenseLogic;
import entity.Assets;
import entity.Category;
import entity.Expenses;
import entity.Income;

public class InsertAssetsAction implements ActionIF {
	@Override
	public String execute(HttpServletRequest request) {
		String page = "home.jsp";

		try {
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("userId") == null) {
				return "Logins.jsp";
			}

			int userId = (Integer) session.getAttribute("userId");
			String categoryName = request.getParameter("categoryName");
			if (categoryName == null || categoryName.trim().isEmpty()) {
				throw new UserBusinessException("項目名を入力してください。");
			}
			InsertAssetsLogic logic = new InsertAssetsLogic();
			logic.InsertAssets(userId, categoryName);
			//表示用
			AssetsCategoryTotalAmountLogic assetsCategoryTotalAmountLogic = new AssetsCategoryTotalAmountLogic();
			ArrayList<Assets> catgoryTotalAmount = new ArrayList<>();
			catgoryTotalAmount = assetsCategoryTotalAmountLogic.AssetsCategoryTotalAmount(userId);
			FindAssetsCategoryLogic findAssetsCategoryLogic = new FindAssetsCategoryLogic();
			ArrayList<Assets> catgoryName = new ArrayList<>();
			catgoryName = findAssetsCategoryLogic.FindAssetsCategory(userId);

			request.setAttribute("catgoryTotalAmount", catgoryTotalAmount);
			request.setAttribute("catgoryName", catgoryName);
			
			// e002ロジック呼び出し
	        findExpenseLogic findExpenseLogic = new findExpenseLogic();
	        ArrayList<Expenses>expenseList =findExpenseLogic.findExpense(userId);
	        CategoryDisplayiLogic categoryDisplaylogic = new CategoryDisplayiLogic();
	        ArrayList<Category> variableCategories2 = categoryDisplaylogic.CategoryDisplayHendouhi(userId);
	        ArrayList<Category> fixedCategories2 = categoryDisplaylogic.CategoryDisplayKoteihi(userId);
	        ShowIncomeLogic incomeLogic = new ShowIncomeLogic();
			ArrayList<Income> incomeList = incomeLogic.showIncome(userId);
			IncomeCategoryLogic incomeCategoryLogic2 = new IncomeCategoryLogic();
			ArrayList<Income> incomeCategoryList2 =incomeCategoryLogic2.IncomeCategory(userId);

			//e002情報の格納
	        request.setAttribute("variableCategories", variableCategories2);
	        request.setAttribute("fixedCategories", fixedCategories2);
	        request.setAttribute("expenseList",expenseList);
	        request.setAttribute("incomeList", incomeList);
	        request.setAttribute("incomeCategoryList", incomeCategoryList2);

		} catch (UserBusinessException e) {
			request.setAttribute("errorMessage", e.getMessage());
		} catch (UserSystemException e) {
			request.setAttribute("errorMessage", "システムエラーが発生しました");
		}

		return page;
	}
}
