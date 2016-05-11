package tools;

/**
 * 生产数据操作层代码
 */
public class GenMain {
	public static void main(String[] args) {
		String configFile = "/generatorConfig.xml";
		try {
			
			String[] tableNames = new String[] { "menu", "org_info", "role", "role_menu","user_info" };
			GenMybatisFiles.gen(configFile, tableNames);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
