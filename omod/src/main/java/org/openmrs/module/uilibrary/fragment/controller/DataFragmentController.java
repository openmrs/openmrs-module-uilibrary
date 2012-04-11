/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
package org.openmrs.module.uilibrary.fragment.controller;

import java.util.ArrayList;
import java.util.List;

import org.openmrs.Encounter;
import org.openmrs.Obs;
import org.openmrs.api.context.Context;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * Fragment whose actions let you fetch pieces of OpenMRS data as JSON
 */
public class DataFragmentController {
	
	/**
	 * Fetches a simplified version of an encounter object
	 */
	public SimpleObject getEncounter(UiUtils ui, @RequestParam("encounterId") Encounter enc) {
		SimpleObject ret = buildEncounter(ui, enc);
		List<SimpleObject> obs = new ArrayList<SimpleObject>();
		for (Obs o : enc.getObs()) {
			SimpleObject simple = new SimpleObject();
			simple.put("concept", o.getConcept().getName().getName());
			simple.put("value", o.getValueAsString(Context.getLocale()));
			obs.add(simple);
		}
		ret.put("obs", obs);
		return ret;
	}
	
	/**
	 * Search for encounter by string
	 */
	public List<SimpleObject> findEncounters(UiUtils ui, @RequestParam("term") String term) {
		List<SimpleObject> ret = new ArrayList<SimpleObject>();
		for (Encounter e : Context.getEncounterService().getEncounters(term, 0, 100, false)) {
			ret.add(buildEncounter(ui, e));
		}
		return ret;
	}

	private SimpleObject buildEncounter(UiUtils ui, Encounter enc) {
    	return SimpleObject.fromObject(enc, ui, "encounterId", "encounterDatetime", "encounterType", "location");
    }
	
}
