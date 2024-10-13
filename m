Return-Path: <linux-acpi+bounces-8739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D269899B94C
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Oct 2024 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7DD1F21225
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Oct 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDD13DBBE;
	Sun, 13 Oct 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjwZbE4Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1813D50C;
	Sun, 13 Oct 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728820791; cv=none; b=Lwwy9XUsHoS+Ncqe+/YGWMHKoz6zyFXuLaIQdKxhFxV3i3Dp+RdCTS7zK1QgKlIqDK74EGeqwCs+Z1sulBR0NnApNYs257qxhxFOya0CWlmUKhcRIh2UeGgyYwGjxg93+/273DsF6Q1izTpybTzMoZaI/3dCCgIcA7UXcMJPp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728820791; c=relaxed/simple;
	bh=XVbJiYqty3f6n3F+8aixmb82OsLGcT9cp7zc4W2GQmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a3S53PeYHEIPIEVUQ/MaevsX/GolFrW1FHRXrrtUaPcWZeCZG8iJYw3EJieWTVXelZ+7F9uifO28gOuePNJnyT0BDNL+zmLsZSr7QjCbbk//nGAvbBzbn39SILPm/LoCW5PRXtHbcM8EvnGWHF2aEwIoYcwEj5qJsYGbAmPDvzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjwZbE4Q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728820789; x=1760356789;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XVbJiYqty3f6n3F+8aixmb82OsLGcT9cp7zc4W2GQmk=;
  b=XjwZbE4QtCXw2H81PZWtC3j4h+W+WGhSQHwui1C1PbWH8PbnXMQc4RGd
   pIkM1vgLULy3ICvzMMc3oSvvpqhS9q7Bq2ShqJIrnAi4/czkK71zkcBy/
   IIySvLRJ1tWSWgvzsS1yI0G5eo2kYIiKglMInJ6AEtlOEkdz4TfIj2PMW
   5NFtotwXmR3/MkUxNetKiRWFmA8XTPpnjBjI+jFqgWmzyk97mdlQF7jFz
   ES+5bSp2ZPa0uStAJkhGA5E222bs94Kh2UAK3Ma+8wcXvYGwLi8o3REle
   e+5V1ihqu0wVhaw+JYQA3lD9JzQk8YAMsz+07OQ2IMoN1FCdNEtOW5VTh
   Q==;
X-CSE-ConnectionGUID: 0BRx/Zl8Sk69ETu6vM3N7g==
X-CSE-MsgGUID: fe7eYvIrRoSdzy90Jhw5Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39556736"
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="39556736"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 04:59:48 -0700
X-CSE-ConnectionGUID: aUF6A0t4Qs6Ox1QsMgTgJA==
X-CSE-MsgGUID: CQrPwEtEQLKRfu6Obn21kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="108117631"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Oct 2024 04:59:46 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szxGB-000ELl-1k;
	Sun, 13 Oct 2024 11:59:43 +0000
Date: Sun, 13 Oct 2024 19:59:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 158/161]
 drivers/thermal/thermal_sysfs.c:726:17: error: label 'unlock' used but not
 defined
Message-ID: <202410131909.OG5cXVR5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   c7d553cb161f03e4424c88bddc26fadcbbf4b6d5
commit: db8666152df8b016530452714b0ad8c7f1b37f3c [158/161] thermal: core: Add and use cooling device guard
config: i386-buildonly-randconfig-002-20241013 (https://download.01.org/0day-ci/archive/20241013/202410131909.OG5cXVR5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410131909.OG5cXVR5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131909.OG5cXVR5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/thermal_sysfs.c: In function 'trans_table_show':
>> drivers/thermal/thermal_sysfs.c:726:17: error: label 'unlock' used but not defined
     726 |                 goto unlock;
         |                 ^~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/unlock +726 drivers/thermal/thermal_sysfs.c

8ea229511e06f9 Viresh Kumar      2018-04-02  702  
33e678d47d1f3e Viresh Kumar      2018-04-03  703  static ssize_t trans_table_show(struct device *dev,
33e678d47d1f3e Viresh Kumar      2018-04-03  704  				struct device_attribute *attr, char *buf)
8ea229511e06f9 Viresh Kumar      2018-04-02  705  {
8ea229511e06f9 Viresh Kumar      2018-04-02  706  	struct thermal_cooling_device *cdev = to_cooling_device(dev);
790930f44289c8 Rafael J. Wysocki 2023-03-17  707  	struct cooling_dev_stats *stats;
8ea229511e06f9 Viresh Kumar      2018-04-02  708  	ssize_t len = 0;
8ea229511e06f9 Viresh Kumar      2018-04-02  709  	int i, j;
8ea229511e06f9 Viresh Kumar      2018-04-02  710  
db8666152df8b0 Rafael J. Wysocki 2024-10-11  711  	guard(cooling_dev)(cdev);
790930f44289c8 Rafael J. Wysocki 2023-03-17  712  
790930f44289c8 Rafael J. Wysocki 2023-03-17  713  	stats = cdev->stats;
db8666152df8b0 Rafael J. Wysocki 2024-10-11  714  	if (!stats)
db8666152df8b0 Rafael J. Wysocki 2024-10-11  715  		return -ENODATA;
790930f44289c8 Rafael J. Wysocki 2023-03-17  716  
8ea229511e06f9 Viresh Kumar      2018-04-02  717  	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
8ea229511e06f9 Viresh Kumar      2018-04-02  718  	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
a365105c685cad Viresh Kumar      2022-10-17  719  	for (i = 0; i <= cdev->max_state; i++) {
8ea229511e06f9 Viresh Kumar      2018-04-02  720  		if (len >= PAGE_SIZE)
8ea229511e06f9 Viresh Kumar      2018-04-02  721  			break;
8ea229511e06f9 Viresh Kumar      2018-04-02  722  		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
8ea229511e06f9 Viresh Kumar      2018-04-02  723  	}
790930f44289c8 Rafael J. Wysocki 2023-03-17  724  	if (len >= PAGE_SIZE) {
790930f44289c8 Rafael J. Wysocki 2023-03-17  725  		len = PAGE_SIZE;
790930f44289c8 Rafael J. Wysocki 2023-03-17 @726  		goto unlock;
790930f44289c8 Rafael J. Wysocki 2023-03-17  727  	}
8ea229511e06f9 Viresh Kumar      2018-04-02  728  
8ea229511e06f9 Viresh Kumar      2018-04-02  729  	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
8ea229511e06f9 Viresh Kumar      2018-04-02  730  
a365105c685cad Viresh Kumar      2022-10-17  731  	for (i = 0; i <= cdev->max_state; i++) {
8ea229511e06f9 Viresh Kumar      2018-04-02  732  		if (len >= PAGE_SIZE)
8ea229511e06f9 Viresh Kumar      2018-04-02  733  			break;
8ea229511e06f9 Viresh Kumar      2018-04-02  734  
8ea229511e06f9 Viresh Kumar      2018-04-02  735  		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
8ea229511e06f9 Viresh Kumar      2018-04-02  736  
a365105c685cad Viresh Kumar      2022-10-17  737  		for (j = 0; j <= cdev->max_state; j++) {
8ea229511e06f9 Viresh Kumar      2018-04-02  738  			if (len >= PAGE_SIZE)
8ea229511e06f9 Viresh Kumar      2018-04-02  739  				break;
8ea229511e06f9 Viresh Kumar      2018-04-02  740  			len += snprintf(buf + len, PAGE_SIZE - len, "%8u ",
a365105c685cad Viresh Kumar      2022-10-17  741  				stats->trans_table[i * (cdev->max_state + 1) + j]);
8ea229511e06f9 Viresh Kumar      2018-04-02  742  		}
8ea229511e06f9 Viresh Kumar      2018-04-02  743  		if (len >= PAGE_SIZE)
8ea229511e06f9 Viresh Kumar      2018-04-02  744  			break;
8ea229511e06f9 Viresh Kumar      2018-04-02  745  		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
8ea229511e06f9 Viresh Kumar      2018-04-02  746  	}
8ea229511e06f9 Viresh Kumar      2018-04-02  747  
8ea229511e06f9 Viresh Kumar      2018-04-02  748  	if (len >= PAGE_SIZE) {
8ea229511e06f9 Viresh Kumar      2018-04-02  749  		pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
790930f44289c8 Rafael J. Wysocki 2023-03-17  750  		len = -EFBIG;
8ea229511e06f9 Viresh Kumar      2018-04-02  751  	}
790930f44289c8 Rafael J. Wysocki 2023-03-17  752  
8ea229511e06f9 Viresh Kumar      2018-04-02  753  	return len;
8ea229511e06f9 Viresh Kumar      2018-04-02  754  }
8ea229511e06f9 Viresh Kumar      2018-04-02  755  

:::::: The code at line 726 was first introduced by commit
:::::: 790930f44289c8209c57461b2db499fcc702e0b3 thermal: core: Introduce thermal_cooling_device_update()

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

