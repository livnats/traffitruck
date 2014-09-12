package core.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Component;

@Component
public class MongoDAO {

	private final MongoTemplate mongoTemplate;

    @Autowired
    public MongoDAO(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }
    
    public void storeTrucker( Trucker trucker ) {
    	mongoTemplate.insert(trucker);
    }
    
    public List<Trucker> getTruckers() {
    	return mongoTemplate.findAll(Trucker.class);
    }
}