package core.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@EnableAutoConfiguration
@ComponentScan
public class Example {

	@Autowired
	private MongoDAO dao;
	
    @RequestMapping("/")
    String home() {
        return dao.getTruckers().toString();
    }

    @RequestMapping("/greetings")
    ModelAndView greetings(@RequestParam(value="name", required=false) String name) {
        return new ModelAndView("oded", "mdl", name);
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    @ResponseBody
    public Trucker createTrucker(@ModelAttribute("trucker") Trucker trucker) {
        dao.storeTrucker(trucker);
        return trucker;
    }
    
    public static void main(String[] args) throws Exception {
        SpringApplication.run(Example.class, args);
    }

}