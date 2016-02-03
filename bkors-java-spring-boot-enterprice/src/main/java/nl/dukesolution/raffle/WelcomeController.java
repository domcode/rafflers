/*
 * Copyright 2012-2014 the original author or authors. Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0 Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under the License.
 */

package nl.dukesolution.raffle;

import nl.dukesolution.raffle.domain.RafflePlayerRepo;

import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class WelcomeController {

    @Autowired
    private RafflePlayerRepo rafflePlayerRepo;

    @RequestMapping("/")
    public String welcome(Map<String, Object> model) {
        if (rafflePlayerRepo.count() > 0) {
            return "welcome";
        }
        return newGame();
    }

    @RequestMapping("/newgame")
    public String newGame() {
        return "upload";
    }

    @RequestMapping(value = "resetgame", method = RequestMethod.POST)
    @Transactional
    public @ResponseBody String resetGame() {
        rafflePlayerRepo.resetGame();
        return "OK";
    }

}
