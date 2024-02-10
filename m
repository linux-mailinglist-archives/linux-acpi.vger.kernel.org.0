Return-Path: <linux-acpi+bounces-3338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2780850185
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 02:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D42328AFC4
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 01:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3158B20E4;
	Sat, 10 Feb 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNek9FCQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC15692;
	Sat, 10 Feb 2024 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528063; cv=none; b=AjSZPFIFkVagXIBeO1/9SyFlApvr7+0J1DwBAkdENSH0Z40aHiQmOu04XI0Ztk2MTlXd40fHizqX+nHQouxuKA1a+7gqbOX9zU120eP/OFfvDh/MSVU3QsK7A4/KT4rWN8kCPOZa56/4R5NabKZk8j8gNOZgpGRg+6uiiXXsrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528063; c=relaxed/simple;
	bh=XJrQ27eV9oGF61BlR9w7dQbMAxDrcmleDee2HtbIcAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=puDCC58fUoiich5uBAqi5nkUARk4PY7L/aBkAMoCNzEvPUY3XDHqEpDFic7CwiLl5V3jHth9vX+bou2i0+sfET6C9eiEkKkSxbFdA7dc7JcGlAXQXGWg1CRBXuKmWFGxEmFuc9/y31HwUTbGcz/tn/0jZ24lt8oUIsfsiKJli4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNek9FCQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707528060; x=1739064060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XJrQ27eV9oGF61BlR9w7dQbMAxDrcmleDee2HtbIcAU=;
  b=QNek9FCQrN6GKHYgBry+A2x6wtUs53dt8k/smrq39ghS1I6GkpGqxiJG
   ahpt3gYr+yFOJrEBVqCXj3YvXehHMZ8S8kZUbZUJ/05+xi/CaNZLqa6qu
   TZWNoZkF/TrC/irU4T0WvUHHHmSVEk2rI7xX+QLYLNLoqYr/rltEvXl0E
   X5zSEc2kackR9gZDRViNGfp1sSTFxqj003EoPdItvWIQndz6cKBr6shMz
   Wc7cVhRoO7BhJ9qWoer3o3MULL2L1S8p6yaZE1GY/D/yVvOpCCFNTW6UR
   tfel08kdmgUeAml1Yn8iwl/TRdOTfmKk1Nlq0wUZ9qNxqX1Xi5CFNNYVa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1680839"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="1680839"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 17:20:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="25314037"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Feb 2024 17:20:58 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYc35-0005FK-1S;
	Sat, 10 Feb 2024 01:20:55 +0000
Date: Sat, 10 Feb 2024 09:19:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 71/77] drivers/thermal/thermal_of.c:536:15:
 error: incompatible type for argument 1 of 'kfree'
Message-ID: <202402100947.E7EZyIMp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   2bc44535ed4f6a6013ec53b505c4c381e166f0ce
commit: fe0ea8a4d293acaf02031aaaaeb3dcf7f262e5b3 [71/77] thermal: core: Store zone ops in struct thermal_zone_device
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240210/202402100947.E7EZyIMp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402100947.E7EZyIMp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402100947.E7EZyIMp-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/thermal_of.c: In function 'thermal_of_zone_register':
>> drivers/thermal/thermal_of.c:536:15: error: incompatible type for argument 1 of 'kfree'
     536 |         kfree(of_ops);
         |               ^~~~~~
         |               |
         |               struct thermal_zone_device_ops
   In file included from drivers/thermal/thermal_of.c:14:
   include/linux/slab.h:227:24: note: expected 'const void *' but argument is of type 'struct thermal_zone_device_ops'
     227 | void kfree(const void *objp);
         |            ~~~~~~~~~~~~^~~~


vim +/kfree +536 drivers/thermal/thermal_of.c

3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  449  
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  450  /**
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  451   * thermal_of_zone_register - Register a thermal zone with device node
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  452   * sensor
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  453   *
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  454   * The thermal_of_zone_register() parses a device tree given a device
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  455   * node sensor and identifier. It searches for the thermal zone
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  456   * associated to the couple sensor/id and retrieves all the thermal
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  457   * zone properties and registers new thermal zone with those
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  458   * properties.
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  459   *
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  460   * @sensor: A device node pointer corresponding to the sensor in the device tree
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  461   * @id: An integer as sensor identifier
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  462   * @data: A private data to be stored in the thermal zone dedicated private area
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  463   * @ops: A set of thermal sensor ops
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  464   *
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  465   * Return: a valid thermal zone structure pointer on success.
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  466   * 	- EINVAL: if the device tree thermal description is malformed
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  467   *	- ENOMEM: if one structure can not be allocated
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  468   *	- Other negative errors are returned by the underlying called functions
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  469   */
ac614a9b4c35bf Daniel Lezcano    2023-04-04  470  static struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  471  							    const struct thermal_zone_device_ops *ops)
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  472  {
fe0ea8a4d293ac Rafael J. Wysocki 2024-02-09  473  	struct thermal_zone_device_ops of_ops = *ops;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  474  	struct thermal_zone_device *tz;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  475  	struct thermal_trip *trips;
ac4436a5b20e0e Ahmad Fatoum      2023-07-08  476  	struct thermal_zone_params tzp = {};
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  477  	struct device_node *np;
62e79e38b257a5 Fabio Estevam     2023-11-29  478  	const char *action;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  479  	int delay, pdelay;
990efe2b4813ff Rafael J. Wysocki 2024-02-08  480  	int ntrips;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  481  	int ret;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  482  
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  483  	np = of_thermal_zone_find(sensor, id);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  484  	if (IS_ERR(np)) {
9d6792df07367a Daniel Lezcano    2022-08-09  485  		if (PTR_ERR(np) != -ENODEV)
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  486  			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
7ef2f023c2c77a Ido Schimmel      2022-10-20  487  		ret = PTR_ERR(np);
7ef2f023c2c77a Ido Schimmel      2022-10-20  488  		goto out_kfree_of_ops;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  489  	}
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  490  
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  491  	trips = thermal_of_trips_init(np, &ntrips);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  492  	if (IS_ERR(trips)) {
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  493  		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
7ef2f023c2c77a Ido Schimmel      2022-10-20  494  		ret = PTR_ERR(trips);
7ef2f023c2c77a Ido Schimmel      2022-10-20  495  		goto out_kfree_of_ops;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  496  	}
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  497  
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  498  	ret = thermal_of_monitor_init(np, &delay, &pdelay);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  499  	if (ret) {
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  500  		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  501  		goto out_kfree_trips;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  502  	}
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  503  
ac4436a5b20e0e Ahmad Fatoum      2023-07-08  504  	thermal_of_parameters_init(np, &tzp);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  505  
fe0ea8a4d293ac Rafael J. Wysocki 2024-02-09  506  	of_ops.bind = thermal_of_bind;
fe0ea8a4d293ac Rafael J. Wysocki 2024-02-09  507  	of_ops.unbind = thermal_of_unbind;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  508  
62e79e38b257a5 Fabio Estevam     2023-11-29  509  	ret = of_property_read_string(np, "critical-action", &action);
62e79e38b257a5 Fabio Estevam     2023-11-29  510  	if (!ret)
fe0ea8a4d293ac Rafael J. Wysocki 2024-02-09  511  		if (!of_ops.critical && !strcasecmp(action, "reboot"))
fe0ea8a4d293ac Rafael J. Wysocki 2024-02-09  512  			of_ops.critical = thermal_zone_device_critical_reboot;
62e79e38b257a5 Fabio Estevam     2023-11-29  513  
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  514  	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
fe0ea8a4d293ac Rafael J. Wysocki 2024-02-09  515  						     data, &of_ops, &tzp,
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  516  						     pdelay, delay);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  517  	if (IS_ERR(tz)) {
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  518  		ret = PTR_ERR(tz);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  519  		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
ac4436a5b20e0e Ahmad Fatoum      2023-07-08  520  		goto out_kfree_trips;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  521  	}
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  522  
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  523  	ret = thermal_zone_device_enable(tz);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  524  	if (ret) {
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  525  		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  526  		       tz->type, tz->id, ret);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  527  		thermal_of_zone_unregister(tz);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  528  		return ERR_PTR(ret);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  529  	}
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  530  
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  531  	return tz;
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  532  
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  533  out_kfree_trips:
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  534  	kfree(trips);
7ef2f023c2c77a Ido Schimmel      2022-10-20  535  out_kfree_of_ops:
7ef2f023c2c77a Ido Schimmel      2022-10-20 @536  	kfree(of_ops);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  537  
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  538  	return ERR_PTR(ret);
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  539  }
3fd6d6e2b4e80f Daniel Lezcano    2022-08-05  540  

:::::: The code at line 536 was first introduced by commit
:::::: 7ef2f023c2c77a452ba5d0c9b1ad04a5a895d553 thermal/of: Fix memory leak on thermal_of_zone_register() failure

:::::: TO: Ido Schimmel <idosch@nvidia.com>
:::::: CC: Daniel Lezcano <daniel.lezcano@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

