package com.vxie.debut.action;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/feedback")
public class FeedbackController extends AbstractController {

    @RequestMapping(value = "/list/{headId}")
    public String list(ModelMap map, @PathVariable String headId) {
        map.put("headId", headId);
        return "feedback/list";
    }
}
