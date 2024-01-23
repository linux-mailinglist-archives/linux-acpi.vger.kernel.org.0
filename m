Return-Path: <linux-acpi+bounces-2983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A098385FF
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jan 2024 04:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD74228699C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jan 2024 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA910F1;
	Tue, 23 Jan 2024 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3Dhunne"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5001FC8;
	Tue, 23 Jan 2024 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705980506; cv=none; b=swJVZAoiQJUj4jaZdqZfg135HUmdmWryEQ3QZvbiWubwfe9IUukoMo7CcQSNyyS2SC9CeszjaEy8NpzV9Y4ueKvJ8uEh+l3xpe2abEC2L0n84RFP2w4hjd+OOKiD9p/mzQZeMBESXbpW0mCCWoMAXtGYpqjeIaD0ZCwvvunGGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705980506; c=relaxed/simple;
	bh=l7wfLVvCGP0+ecx1a4qU9SbMv8+iuyp7Pu55QwpeJsg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SU0xpVR+vEstmewHnl6B8QYAUQO6APcY5PWsVwW55K3hTnP9+Gfq2zdD/f6HV1DTjpbXmKzaQTdOmGBMRa88JyxK5MeMYv9q1mf3hMWn7EclkV4GQVeCAhiYxNO304eKbNumGiE8oSC/vP53hDzmn9da41WD80Imb5091K6wlvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3Dhunne; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705980503; x=1737516503;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l7wfLVvCGP0+ecx1a4qU9SbMv8+iuyp7Pu55QwpeJsg=;
  b=k3DhunnekM0i1OWlQwm3OLNi92Rk2OcRbiN2Xb6NeRDfOMxXBJEdwDbV
   MLoMAE9EyUOnweDw7I1jB8zVGk5vgwPbfMlzWgrDtG5vlrdxHw6EKm3VK
   hYlSEWsslOamyiipgmfZfqLL3BeAzziJu/KBD3BxOz7py+QZF+pSaDgoa
   38Z1m7xcbTSErXV/S2s21nNpsoQVJxO4VcNJXXDG92ycmrlWhfD/6bEb+
   BxxX+zu3rBa3cpvLAHRf5jgarLodJ7H9Tja05kcG9fMulZXa0yy07K4o3
   5TjebWB6+I3luuerENZfBiaCPGKzto983YyAew9k67eRleGfWNlbSMMGH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1292116"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1292116"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 19:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="34257552"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Jan 2024 19:28:21 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rS7SU-00079E-1D;
	Tue, 23 Jan 2024 03:28:18 +0000
Date: Tue, 23 Jan 2024 11:28:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [rafael-pm:bleeding-edge 5/6] drivers/base/power/runtime.c:1815:24:
 warning: increment of a boolean expression
Message-ID: <202401231130.9tnv8Gds-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f890729ea3ca4d549b4e2414c42e932163814f09
commit: 5d872146e7f55e15c26d0a5600b155ee54bfdee6 [5/6] PM: sleep: Use bool for all 1-bit fields in struct dev_pm_info
config: i386-buildonly-randconfig-004-20240123 (https://download.01.org/0day-ci/archive/20240123/202401231130.9tnv8Gds-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240123/202401231130.9tnv8Gds-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401231130.9tnv8Gds-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/base/power/runtime.c: In function 'pm_runtime_new_link':
>> drivers/base/power/runtime.c:1815:24: warning: increment of a boolean expression [-Wbool-operation]
    1815 |  dev->power.links_count++;
         |                        ^~
   drivers/base/power/runtime.c: In function 'pm_runtime_drop_link_count':
>> drivers/base/power/runtime.c:1823:24: warning: decrement of a boolean expression [-Wbool-operation]
    1823 |  dev->power.links_count--;
         |                        ^~


vim +1815 drivers/base/power/runtime.c

21d5c57b3726166 Rafael J. Wysocki 2016-10-30  1811  
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1812  void pm_runtime_new_link(struct device *dev)
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1813  {
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1814  	spin_lock_irq(&dev->power.lock);
baa8809f60971d1 Rafael J. Wysocki 2016-10-30 @1815  	dev->power.links_count++;
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1816  	spin_unlock_irq(&dev->power.lock);
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1817  }
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1818  
e0e398e204634db Rafael J. Wysocki 2020-10-21  1819  static void pm_runtime_drop_link_count(struct device *dev)
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1820  {
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1821  	spin_lock_irq(&dev->power.lock);
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1822  	WARN_ON(dev->power.links_count == 0);
baa8809f60971d1 Rafael J. Wysocki 2016-10-30 @1823  	dev->power.links_count--;
baa8809f60971d1 Rafael J. Wysocki 2016-10-30  1824  	spin_unlock_irq(&dev->power.lock);
e0e398e204634db Rafael J. Wysocki 2020-10-21  1825  }
e0e398e204634db Rafael J. Wysocki 2020-10-21  1826  

:::::: The code at line 1815 was first introduced by commit
:::::: baa8809f60971d10220dfe79248f54b2b265f003 PM / runtime: Optimize the use of device links

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

