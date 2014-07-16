package com.vxie.debut.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/score")
public class ScoreController extends AbstractController {

    @RequestMapping(value = "/list")
    public String list() {
        return "score/list";
    }
}
