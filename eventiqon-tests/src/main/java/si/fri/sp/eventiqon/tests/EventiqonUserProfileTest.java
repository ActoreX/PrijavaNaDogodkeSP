package si.fri.sp.eventiqon.tests;

import java.util.logging.Level;

import org.openqa.selenium.By;
import org.openqa.selenium.Capabilities;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.browserlaunchers.locators.GoogleChromeLocator;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.logging.LogEntry;
import org.openqa.selenium.logging.LogType;
import org.openqa.selenium.logging.LoggingPreferences;
import org.openqa.selenium.phantomjs.PhantomJSDriver;
import org.openqa.selenium.phantomjs.PhantomJSDriverService;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.thoughtworks.selenium.Selenium;

import org.openqa.selenium.chrome.ChromeDriver;

public class EventiqonUserProfileTest {

	private WebDriver driver; 
	String appURL = "http://localhost:60264";

	@BeforeClass
	public void testInit() {
		/*DesiredCapabilities caps = new DesiredCapabilities();
		caps.setCapability(PhantomJSDriverService.PHANTOMJS_EXECUTABLE_PATH_PROPERTY, "C://phantomjs.exe");
		caps.setCapability("takesScreenshot", true);
		String userAgent = "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.41 Safari/535.1";
		caps.setCapability("phantomjs.page.settings.userAgent", userAgent);
		*/driver = new FirefoxDriver();
		
	}
	
	
	
	@Test
	public void preveriTitleStrani() {
		driver.navigate().to(appURL + "/UserProfile");
		String getTitle = driver.getTitle();
		Assert.assertEquals(getTitle, "UserPanel - Eventiqon!");
	}
	
	@Test
	public void spremeniOsebnePodatke() {
		driver.navigate().to(appURL + "/UserProfile");
		String eposta = driver.findElement(By.id("eposta")).getText();
		System.out.println(eposta);
		String epostaNova = "novaEposta" + System.currentTimeMillis() + "email.com" ;
		System.out.println(epostaNova);
		int numOfLogs = driver.manage().logs().get(LogType.BROWSER).getAll().size();
		driver.findElement(By.id("eposta")).sendKeys(epostaNova);
		
		System.out.println(driver.findElement(By.id("spremeniOsebnePodatke")).getText());
		
		
		JavascriptExecutor js;
		if (driver instanceof JavascriptExecutor) {
		    js = (JavascriptExecutor)driver;
		    js.executeScript("$('#spremeniOsebnePodatke').click();");
		    System.out.println("tdada");
		}
		
		
	
		driver.navigate().refresh();
		String epostaTrenutna = driver.findElement(By.id("eposta")).getText();
		Assert.assertEquals(epostaTrenutna, epostaNova);
	}
	
	
	@AfterClass
	public void testTearDown() {
		driver.quit();
	}
}
