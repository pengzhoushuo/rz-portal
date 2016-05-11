package com.xxx.portal.comm;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;


import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jxl.Sheet;
import jxl.Workbook;

public class ExcelFileHelper {
	public final static int ROW_SIZE = 3000;//Excel文件内容最大行数，不建议处理超过此行数的文件
	public final static String  XLS_FILE_PRO_FIX = ".xls";//文件后缀名
	public final static String  XLSX_FILE_PRO_FIX = ".xlsx";//Excel 2007文件后缀名
	public final static String EXCEL_XLS_FILE = "application/vnd.ms-excel";
	public final static String EXCEL_XLSX_FILE_2007 = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";//Excel 2007
	
	/**
	 * <p>Description: 读取xls格式文件<p>
	 * 
	 * @param filePath 文件路径
	 * @return
	 * @throws Exception
	 */
	public  static List<String[]> readFile(String filePath) throws Exception{
		List<String[]> contentArrs = new ArrayList<String[]>();
		FileInputStream fileInStream = null;
		Workbook workbook = null;
		try {
			fileInStream = new FileInputStream(filePath);
			workbook =Workbook.getWorkbook(fileInStream);
			Sheet sheet = workbook.getSheet(0);
			int rows = sheet.getRows();
			int cols = sheet.getColumns();
			if(rows>ROW_SIZE)
				throw new Exception("Excel文件内容超过限制行数,限定行数为："+ROW_SIZE);
			for(int row=0;row<rows;row++){
				if(isEmptyRow(sheet,row))
					continue;
				String[] rowContent = new String[cols];
				for(int col=0;col<cols;col++){
					rowContent[col] = sheet.getCell(col, row).getContents().trim();
				}
				contentArrs.add(rowContent);
			}
		} catch (Exception e) {
			throw e;
		}finally{
			if(workbook!=null){
				workbook.close();
			}
			if(fileInStream != null)
				try {
					fileInStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
		return contentArrs;
	}
	
	/**
	 * <p>Description: 读取xls(Excel 1999-2003)格式文件<p>
	 * @param filePath
	 * @return
	 */
	public static List<String[]> loadXls(String filePath) throws Exception {
		
		if(XLSX_FILE_PRO_FIX.equalsIgnoreCase(getFileProfix(filePath)))
			//Excel 2007处理
			return loadXlsx(filePath);
		
		List<String[]> contentList = new ArrayList<String[]>();
		InputStream input = null;
		try {
			input = new FileInputStream(filePath);
			POIFSFileSystem fs = new POIFSFileSystem(input);
			HSSFWorkbook wb = new HSSFWorkbook(fs);
			HSSFSheet sheet = wb.getSheetAt(0);
			Iterator<Row> rows = sheet.rowIterator();
			while (rows.hasNext()) {
				Row row = rows.next();
				Iterator<Cell> cells = row.cellIterator();
				String[] rowArrs = new String[row.getPhysicalNumberOfCells()];
				int currentCell = 0;
				while (cells.hasNext()) {
					Cell cell = cells.next();
					String cellValue = "";
					switch (cell.getCellType()) {
					case HSSFCell.CELL_TYPE_NUMERIC:
						// 判断当前的cell是否为Date               
					    if (HSSFDateUtil.isCellDateFormatted(cell)) {              
					    	Date date = cell.getDateCellValue();                    
					    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					    	cellValue = sdf.format(date);
					    }else{
					    	cellValue = String.valueOf(((Double) cell.getNumericCellValue()).longValue());
					    }
						break;
					case HSSFCell.CELL_TYPE_STRING:
						cellValue = cell.getStringCellValue();
						break;
					case HSSFCell.CELL_TYPE_BOOLEAN:
						cellValue = String.valueOf(cell.getBooleanCellValue());
						break;
					case HSSFCell.CELL_TYPE_FORMULA:
						try{
							cellValue = String.valueOf(cell.getNumericCellValue());
						}catch(IllegalStateException e){
							cellValue = String.valueOf(cell.getRichStringCellValue());
						}
						break;
					case HSSFCell.CELL_TYPE_BLANK:
						// System.out.println(cell.getStringCellValue());
						break;
					default:
						// System.out.println("unsuported sell type");
						break;
					}
					rowArrs[currentCell] = cellValue;
					currentCell++;
				}
				contentList.add(rowArrs);
			}
		} catch (Exception e) {
			throw e;
		}finally{
			if(input!=null){
				try {
					input.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return contentList;
	}
	
	/**
	 * <p>Description:读取xlsx(Excel 2007)格式文件 <p>
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public static List<String[]> loadXlsx(String filePath) throws Exception {
		List<String[]> contentList = new ArrayList<String[]>();
		InputStream input = null;
		try {
			input = new FileInputStream(filePath);
			XSSFWorkbook xwb = new XSSFWorkbook(input);
			XSSFSheet sheet = xwb.getSheetAt(0);
			Iterator<Row> rows = sheet.rowIterator();
			while (rows.hasNext()) {
				Row row = rows.next();
				Iterator<Cell> cells = row.cellIterator();
				String[] rowArrs = new String[row.getPhysicalNumberOfCells()];
				int currentCell = 0;
				while (cells.hasNext()) {
					Cell cell = cells.next();
					String cellValue = "";
					switch (cell.getCellType()) {
					case HSSFCell.CELL_TYPE_NUMERIC:
						// 判断当前的cell是否为Date               
					    if (HSSFDateUtil.isCellDateFormatted(cell)) {              
					    	Date date = cell.getDateCellValue();                    
					    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					    	cellValue = sdf.format(date);
					    }else{
					    	cellValue = String.valueOf(((Double) cell.getNumericCellValue()).longValue());
					    }
					    break;
					case HSSFCell.CELL_TYPE_STRING:
						cellValue = cell.getStringCellValue();
						break;
					case HSSFCell.CELL_TYPE_BOOLEAN:
						cellValue = String.valueOf(cell.getBooleanCellValue());
						break;
					case HSSFCell.CELL_TYPE_FORMULA:
						try{
							cellValue = String.valueOf(cell.getNumericCellValue());
						}catch(IllegalStateException e){
							cellValue = String.valueOf(cell.getRichStringCellValue());
						}
						break;
					case HSSFCell.CELL_TYPE_BLANK:
						cellValue = cell.getStringCellValue();
						break;
					default:
						// System.out.println("unsuported sell type");
						break;
					}
					rowArrs[currentCell] = cellValue;
					currentCell++;
				}
				contentList.add(rowArrs);
			}
		} catch (Exception e) {
			throw e;
		}finally{
			if(input!=null){
				try {
					input.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return contentList;
	}
	
	private static boolean isEmptyRow(Sheet sheet, int row) {
		boolean flag = true;
		int cols = sheet.getColumns();
		String value = "";
		for (int i = 0; i < cols; i++) {
			String tempValue = sheet.getCell(i, row).getContents().trim();
			value = value + tempValue;
		}
		if (value != null && value.trim().length() > 0) {
			flag = false;
		}
		return flag;
	}
	
	/**
	 * <p>Description: 根据文件MIMETYPE取得后缀名<p>
	 * @param mimeType
	 * @return
	 */
	public static String getProfix(String mimeType){
		String profix = "";
		if(EXCEL_XLS_FILE.equalsIgnoreCase(mimeType)){
			profix = ".xls";
		}else if(EXCEL_XLSX_FILE_2007.equalsIgnoreCase(mimeType)){
			profix = ".xlsx";
		}
		return profix;
	}
	
	public static boolean isExcelFile(String mimeType){
		boolean fileFlag = false;
		if(EXCEL_XLS_FILE.equalsIgnoreCase(mimeType) || EXCEL_XLSX_FILE_2007.equalsIgnoreCase(mimeType)){
			fileFlag = true;
		}
		return fileFlag;
	}
	
	/*
	 * 取得文件后缀名
	 */
	public static String getFileProfix(String filePath){
		return filePath.substring(filePath.lastIndexOf("."));
	}

	
	public static void main(String[] args) {
		try {
			List<String[]> conList = loadXls("D:\\test.xlsx");
			System.out.println("size=:"+conList.size());
			for(String[] conArr : conList){
				for(String con : conArr){
					System.out.print(con+"  ");
				}
				System.out.println();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
