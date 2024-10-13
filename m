Return-Path: <linux-acpi+bounces-8741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE9499B96A
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Oct 2024 14:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255171F216BC
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Oct 2024 12:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF101428E7;
	Sun, 13 Oct 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUmNVV4z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45413AD05;
	Sun, 13 Oct 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728823250; cv=none; b=KB92ghc1Dbgr06lfOuySPielHGdwlPaWqahJ9wY75gl+IZUDyt2N+9i19aoAJXcMmXvp79LKh4smJBYqIgg8pakFjy2Mj1KlldNht+RsbTvm8UK8EVdu0tSOjLNs0EKfJuWuDV5pxZ8dkEn/UqAbg0DvgO5DnW4MZckv7JcQWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728823250; c=relaxed/simple;
	bh=RLpaMXDfUakxynthv8XolAg1Sclf4muscRuSRMQTz4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hLpeF3eIVsI9YVHWd+hbdNT1ALBVzG60N6vccPk6zoAGM0EmkwxawSZ2q1RyEHBYSts/BFqNi8p8h3D0zhDVx0rcDA4IaLG7u3B0wTDLelLdF3FAVTo4Ut2MG1vQ7mpzSC+EjM4Gz9OHoZk/eMXR/YngS3xwtqGQjH9gRdDHTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUmNVV4z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728823249; x=1760359249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RLpaMXDfUakxynthv8XolAg1Sclf4muscRuSRMQTz4Y=;
  b=FUmNVV4zQQr6of0MBRbgPVIB07WqrkXVUSihnvmFne8lgnCh+flyilsz
   BUF9ovq+TSqrIBIQl4mNBr508wKyrp+zo6v8R7tfLD8zUoIUvMjEbNAZt
   jZhRJBhNFb/bsARJYLLOGyVxAwHZyFNPKASXqARfGzY3Y6TcMT3F7HXN+
   tbtaP0OzuNtX1Dhhr8Cnz5tE2K1SlHL9oesT3eYgcFUWaSWUxbba4nftI
   TGyW0Okiz3WI3qycMYLp76FgGGye5k3Cr3eakm7rfKHZVXOu5SfNlMoSt
   3j7XKHvgBLsQHetzSIRvR2M/ROryPMsnmHgJg1w/0Or+/Te+tpq9pt9Nh
   g==;
X-CSE-ConnectionGUID: 3hSO0Zc6S1G9fMPRrCjP3A==
X-CSE-MsgGUID: a41HN990R4GBohcxxKwWnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31871400"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31871400"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 05:40:49 -0700
X-CSE-ConnectionGUID: 7Rwf/GtbRreGSNd4EmIItw==
X-CSE-MsgGUID: ZgcExqH3SZmq34LLKDBhbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="76978328"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Oct 2024 05:40:46 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szxts-000EMl-0d;
	Sun, 13 Oct 2024 12:40:44 +0000
Date: Sun, 13 Oct 2024 20:40:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 158/161]
 drivers/thermal/thermal_sysfs.c:726:8: error: use of undeclared label
 'unlock'
Message-ID: <202410132024.xuSMJC7v-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20241013 (https://download.01.org/0day-ci/archive/20241013/202410132024.xuSMJC7v-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410132024.xuSMJC7v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410132024.xuSMJC7v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/thermal/thermal_sysfs.c:726:8: error: use of undeclared label 'unlock'
     726 |                 goto unlock;
         |                      ^
   1 error generated.


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

