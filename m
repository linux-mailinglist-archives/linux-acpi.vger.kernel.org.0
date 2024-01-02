Return-Path: <linux-acpi+bounces-2676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB3182234E
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jan 2024 22:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95F61F23072
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jan 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D4168AD;
	Tue,  2 Jan 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dylfigDy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2453168A8;
	Tue,  2 Jan 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704231492; x=1735767492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SHWODI1YRWWrKC8GkPard7QJ7Ml2YhlQqRFPlo5WVf0=;
  b=dylfigDy/tDPKG2mUudosn3dm0ELowYG3czm8AELRe2y7r0LiiXJT1fn
   NMX5Fe+vro13AUuU0ftlXXHxfTTSRlLmD/6Gmw9M6vZ+nAyjO/r/O5Gsi
   g7mFfXVG09kQKHAvgNLB+SRN660GQsGmT3ITp8Iq37HIbRHqQJ/8aRasw
   PVpRvia8jlRakMbJEYRZay+qkPMABke2a0ccu6Hdzbg3n5jwa8udwQvZu
   kOh1945acvj1Q+ZyuW+o9H62I2BEKrbDUqYgJ8XwxkaapXPSkM6S2Z2xg
   2UyBOYslitqnf79lXQIAy79X1fHlKLSMlGHfH/KUvUUvdWNLf6RpgKqWb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3737810"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3737810"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 13:38:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="783304446"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="783304446"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jan 2024 13:38:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKmSc-000LTU-1P;
	Tue, 02 Jan 2024 21:38:06 +0000
Date: Wed, 3 Jan 2024 05:37:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 157/159]
 drivers/thermal/thermal_core.c:1469:6: warning: variable 'tz_id' set but not
 used
Message-ID: <202401030509.AAQGAhUF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   b8a1fe5b94254945ed28a3f519e8ecd60e288871
commit: f36483a0a8c34a752816bfec1c7d2e693efbce99 [157/159] thermal: netlink: Pass thermal zone pointer to notify routines
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240103/202401030509.AAQGAhUF-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240103/202401030509.AAQGAhUF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401030509.AAQGAhUF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_core.c:1469:6: warning: variable 'tz_id' set but not used [-Wunused-but-set-variable]
           int tz_id;
               ^
   1 warning generated.


vim +/tz_id +1469 drivers/thermal/thermal_core.c

7cefbaf081eb7c drivers/thermal/thermal_core.c Daniel Lezcano    2023-04-19  1462  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1463  /**
a052b5118f13fe drivers/thermal/thermal_core.c Yang Yingliang    2021-05-17  1464   * thermal_zone_device_unregister - removes the registered thermal zone device
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1465   * @tz: the thermal zone device to remove
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1466   */
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1467  void thermal_zone_device_unregister(struct thermal_zone_device *tz)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1468  {
ded2d383b1b441 drivers/thermal/thermal_core.c Zhang Rui         2023-03-30 @1469  	int tz_id;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1470  	struct thermal_cooling_device *cdev;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1471  	struct thermal_zone_device *pos = NULL;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1472  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1473  	if (!tz)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1474  		return;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1475  
a5f785ce608caf drivers/thermal/thermal_core.c Dmitry Osipenko   2020-08-18  1476  	tz_id = tz->id;
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R       2012-09-18  1477  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1478  	mutex_lock(&thermal_list_lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1479  	list_for_each_entry(pos, &thermal_tz_list, node)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1480  		if (pos == tz)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1481  			break;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1482  	if (pos != tz) {
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1483  		/* thermal zone device not found */
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1484  		mutex_unlock(&thermal_list_lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1485  		return;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1486  	}
b38aa87f67931e drivers/thermal/thermal_core.c Rafael J. Wysocki 2023-12-08  1487  
b38aa87f67931e drivers/thermal/thermal_core.c Rafael J. Wysocki 2023-12-08  1488  	mutex_lock(&tz->lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1489  	list_del(&tz->node);
b38aa87f67931e drivers/thermal/thermal_core.c Rafael J. Wysocki 2023-12-08  1490  	mutex_unlock(&tz->lock);
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R       2012-09-18  1491  
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R       2012-09-18  1492  	/* Unbind all cdevs associated with 'this' thermal zone */
ded2d383b1b441 drivers/thermal/thermal_core.c Zhang Rui         2023-03-30  1493  	list_for_each_entry(cdev, &thermal_cdev_list, node)
ded2d383b1b441 drivers/thermal/thermal_core.c Zhang Rui         2023-03-30  1494  		if (tz->ops->unbind)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1495  			tz->ops->unbind(tz, cdev);
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R       2012-09-18  1496  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1497  	mutex_unlock(&thermal_list_lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1498  
163b00cde7cf22 drivers/thermal/thermal_core.c Wei Wang          2019-11-12  1499  	cancel_delayed_work_sync(&tz->poll_queue);
b1569e99c795bf drivers/thermal/thermal_sys.c  Matthew Garrett   2008-12-03  1500  
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino       2015-02-26  1501  	thermal_set_governor(tz, NULL);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1502  
e68b16abd91dca drivers/thermal/thermal.c      Zhang Rui         2008-04-21  1503  	thermal_remove_hwmon_sysfs(tz);
5a5b7d8d541684 drivers/thermal/thermal_core.c keliu             2022-05-27  1504  	ida_free(&thermal_tz_ida, tz->id);
b31ef8285b19ec drivers/thermal/thermal_core.c Matthew Wilcox    2016-12-21  1505  	ida_destroy(&tz->ida);
30b2ae07d3d60a drivers/thermal/thermal_core.c Guenter Roeck     2022-11-10  1506  
30b2ae07d3d60a drivers/thermal/thermal_core.c Guenter Roeck     2022-11-10  1507  	device_del(&tz->device);
30b2ae07d3d60a drivers/thermal/thermal_core.c Guenter Roeck     2022-11-10  1508  
3d439b1a2ad36c drivers/thermal/thermal_core.c Daniel Lezcano    2023-04-04  1509  	kfree(tz->tzp);
3d439b1a2ad36c drivers/thermal/thermal_core.c Daniel Lezcano    2023-04-04  1510  
30b2ae07d3d60a drivers/thermal/thermal_core.c Guenter Roeck     2022-11-10  1511  	put_device(&tz->device);
55cdf0a283b876 drivers/thermal/thermal_core.c Daniel Lezcano    2020-07-06  1512  
f36483a0a8c34a drivers/thermal/thermal_core.c Rafael J. Wysocki 2023-12-15  1513  	thermal_notify_tz_delete(tz);
4649620d9404d3 drivers/thermal/thermal_core.c Rafael J. Wysocki 2023-12-08  1514  
4649620d9404d3 drivers/thermal/thermal_core.c Rafael J. Wysocki 2023-12-08  1515  	wait_for_completion(&tz->removal);
4649620d9404d3 drivers/thermal/thermal_core.c Rafael J. Wysocki 2023-12-08  1516  	kfree(tz);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1517  }
910cb1e34d2fb8 drivers/thermal/thermal_core.c Eduardo Valentin  2013-04-23  1518  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-17  1519  

:::::: The code at line 1469 was first introduced by commit
:::::: ded2d383b1b441f380552897791ffb85a1377f08 thermal/core: Remove thermal_bind_params structure

:::::: TO: Zhang Rui <rui.zhang@intel.com>
:::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

