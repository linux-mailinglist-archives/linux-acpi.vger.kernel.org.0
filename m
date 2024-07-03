Return-Path: <linux-acpi+bounces-6757-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 076249260C2
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FA5B29C28
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E077176FD3;
	Wed,  3 Jul 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ao1OxWLp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9F173339;
	Wed,  3 Jul 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010667; cv=none; b=nmK4uL+jzrRRIwcjJA6C6RKHqtN1xAtgcl4mqNmXUcYyC0t6S5xYhSagjY+jcWIxxrN1JXIFUMUc3P7tbmh5HRDtp4AqYM3Kf8b83yfUA8otyC0Be8AKaBQd7HDYIzB78ovlZ16p9XhKwnuIxAblNGEMcbuMrdGEnAwaLaN9sd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010667; c=relaxed/simple;
	bh=2jbQ4+bRVEE0MODicf7UTdRBm68QrQUJU5Ei7evh/is=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VUjDpX9xbCiRSiDOo7rtifIYoO+/VsEV3yCD6nhEe6c62/IoLG6B15430bl6eF5AOiQACuvkTAfT0x/2f4mWZGWFbkpUObD7seI/OpUN53oF2jnR1uhspAMK5Wqb6X3o1ILcKxgbRfo8ISLYyI750ESDPd7pOsxOgkI32qjBcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ao1OxWLp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720010664; x=1751546664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2jbQ4+bRVEE0MODicf7UTdRBm68QrQUJU5Ei7evh/is=;
  b=ao1OxWLp8QtEZ8tJ3SJF1+x5lW6GEhL2/hwuoBQcLNO1CD1Ii+xUoQX+
   0SuXFtb/IWwutZQFTP786flzfN0bIii02Q/GZhNZLQuko5HEAvPxlui+x
   Z9VurJcWklnHMxd2gPAReKyrN7uqWjzjCcqxVcLPptdRw6UN15Os3Nm2D
   yPZ+1BFhXSGG7Je98I6GOzIup9z9JOKz4ItabVXmYEUaVpSaNEyRfaJnM
   iDAv0jpvDIwdR4oyWkcddfOymTDVFcRG+WGXGSvYTAzOCA/0yIliwEpbW
   KQF7lWJQE93vt6XXP0twbUuAAHgzRp+UrsH/DW3ZYCk5mI57u5CWg80rd
   A==;
X-CSE-ConnectionGUID: oylho2bpS/SsgjCzntlgBQ==
X-CSE-MsgGUID: uX8Qbjy+SDWfgsdxZfbz7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17355632"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17355632"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 05:44:24 -0700
X-CSE-ConnectionGUID: 2eTjDtrCTTqOSAiWUY7d2g==
X-CSE-MsgGUID: N6sVDhVbRwyrM7jh6o/jvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46668790"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2024 05:44:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOzLP-000PiP-1O;
	Wed, 03 Jul 2024 12:44:19 +0000
Date: Wed, 3 Jul 2024 20:43:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [rafael-pm:bleeding-edge 136/137]
 drivers/thermal/uniphier_thermal.c:269:13: warning: unused variable 'i'
Message-ID: <202407032000.Lvc01b58-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   afefac1395033609973da997224eceaece6dadf5
commit: 9b418d5c9b5a55f320ee2fef00825ec9a8cf582f [136/137] thermal: uniphier: Use thermal_zone_for_each_trip() for walking trip points
config: i386-buildonly-randconfig-002-20240703 (https://download.01.org/0day-ci/archive/20240703/202407032000.Lvc01b58-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240703/202407032000.Lvc01b58-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407032000.Lvc01b58-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/uniphier_thermal.c: In function 'uniphier_tm_probe':
>> drivers/thermal/uniphier_thermal.c:269:13: warning: unused variable 'i' [-Wunused-variable]
     269 |         int i, ret, irq;
         |             ^


vim +/i +269 drivers/thermal/uniphier_thermal.c

   261	
   262	static int uniphier_tm_probe(struct platform_device *pdev)
   263	{
   264		struct trip_walk_data twd = { .crit_temp = INT_MAX, .index = 0 };
   265		struct device *dev = &pdev->dev;
   266		struct regmap *regmap;
   267		struct device_node *parent;
   268		struct uniphier_tm_dev *tdev;
 > 269		int i, ret, irq;
   270	
   271		tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
   272		if (!tdev)
   273			return -ENOMEM;
   274		tdev->dev = dev;
   275	
   276		tdev->data = of_device_get_match_data(dev);
   277		if (WARN_ON(!tdev->data))
   278			return -EINVAL;
   279	
   280		irq = platform_get_irq(pdev, 0);
   281		if (irq < 0)
   282			return irq;
   283	
   284		/* get regmap from syscon node */
   285		parent = of_get_parent(dev->of_node); /* parent should be syscon node */
   286		regmap = syscon_node_to_regmap(parent);
   287		of_node_put(parent);
   288		if (IS_ERR(regmap)) {
   289			dev_err(dev, "failed to get regmap (error %ld)\n",
   290				PTR_ERR(regmap));
   291			return PTR_ERR(regmap);
   292		}
   293		tdev->regmap = regmap;
   294	
   295		ret = uniphier_tm_initialize_sensor(tdev);
   296		if (ret) {
   297			dev_err(dev, "failed to initialize sensor\n");
   298			return ret;
   299		}
   300	
   301		ret = devm_request_threaded_irq(dev, irq, uniphier_tm_alarm_irq,
   302						uniphier_tm_alarm_irq_thread,
   303						0, "thermal", tdev);
   304		if (ret)
   305			return ret;
   306	
   307		platform_set_drvdata(pdev, tdev);
   308	
   309		tdev->tz_dev = devm_thermal_of_zone_register(dev, 0, tdev,
   310							     &uniphier_of_thermal_ops);
   311		if (IS_ERR(tdev->tz_dev)) {
   312			dev_err(dev, "failed to register sensor device\n");
   313			return PTR_ERR(tdev->tz_dev);
   314		}
   315	
   316		/* set alert temperatures */
   317		twd.tdev = tdev;
   318		thermal_zone_for_each_trip(tdev->tz_dev, uniphier_tm_trip_walk_cb, &twd);
   319	
   320		if (twd.crit_temp > CRITICAL_TEMP_LIMIT) {
   321			dev_err(dev, "critical trip is over limit(>%d), or not set\n",
   322				CRITICAL_TEMP_LIMIT);
   323			return -EINVAL;
   324		}
   325	
   326		uniphier_tm_enable_sensor(tdev);
   327	
   328		return 0;
   329	}
   330	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

