Return-Path: <linux-acpi+bounces-11906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4751A556D2
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 20:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30627A373E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 19:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2F826B0A9;
	Thu,  6 Mar 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWV9wZLt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E351A0BC9;
	Thu,  6 Mar 2025 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289692; cv=none; b=lHO2YA6AZ2fuPqQsA7Lmmsh7h/6NwhbaunvMS3NE960TH2aE7SraV+liZ0bMBiq6AranHXYL52R81vN0NEqrMZDc+5tO5k8J4rh1DD1IHq+pfyy9lNkbcwdp+fVBGu2Z3K63M4QECnq65TJNZC07/KvpORK+YqqOCNwNpUk+D5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289692; c=relaxed/simple;
	bh=rGTjAwzPN3h7icAYCnpUh+MwWG/3h6W2BXTv9Gg40XY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aBgA4k2k2Y1toKB17UZ9joieKtzmfb1+YBTuhCK5bTvzTcHe0i7/jYRngTMZZtscw3HwIqoKklC3s7BhaS7vDPapzYe+BqwBLFOT+3MtFacDAtaWVDf/ZyfBeJdQ8NBII31Eb5OPiaa0d4OHjn2Jq8Ikw8fq9DuBTjiZIAP4XTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWV9wZLt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741289691; x=1772825691;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rGTjAwzPN3h7icAYCnpUh+MwWG/3h6W2BXTv9Gg40XY=;
  b=dWV9wZLt20rHOBszRTeW6998tyBowZEUhQ+3kAV93smT0RhPh9o1CYUX
   aMc2S04rATBoCVhY5eGk4rH9HLSgSvcjxc7pXyMaPqBS6zx3rmsLqZumb
   spiDcQa/D7Gtkmtnzq5w10e7FWU+wVOQUxMugNA7tAlNw/79pMZ2soSqu
   FwAW+8F6zLUs+nl7TCW0bPpHdqcxipzNVJvYrvddS+JCNN732ca4LAI+5
   4cb9fY60uMcHBZWzPuyoOIXu9VmW/phZRDCynq1K3gdnu2/VHUFIdU3cn
   BqXrA0lylzyosblWcchZlI4gPlZI+HyVrsiQHBhCdvlXzD1w4XgvUR7Sq
   Q==;
X-CSE-ConnectionGUID: hfy9yfWaQdGjbnoOxjt5IA==
X-CSE-MsgGUID: 3eI1rcXYQSSRM6UkgNsVew==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42179371"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42179371"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 11:34:51 -0800
X-CSE-ConnectionGUID: dk5nOdDySbKxeQQCm6MIFw==
X-CSE-MsgGUID: Kt6sRJWCTUiQ1VAM6ZUdqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119629615"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Mar 2025 11:34:49 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqGzV-000NWW-2K;
	Thu, 06 Mar 2025 19:34:45 +0000
Date: Fri, 7 Mar 2025 03:34:13 +0800
From: kernel test robot <lkp@intel.com>
To: Jeson Gao <jeson.gao@unisoc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [rafael-pm:bleeding-edge 103/108] drivers/powercap/dtpm_cpu.c:83:15:
 error: call to undeclared function 'sched_cpu_util'; ISO C99 and later do
 not support implicit function declarations
Message-ID: <202503070326.9hEUez42-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jeson,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   96791086aa226b85fe090573b9e3668ac53d5364
commit: 9144584c375e73a4fef6bde3ce399ad43e011b37 [103/108] PM: EM: Rework the depends on for CONFIG_ENERGY_MODEL
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250307/202503070326.9hEUez42-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503070326.9hEUez42-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503070326.9hEUez42-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/powercap/dtpm_cpu.c:83:15: error: call to undeclared function 'sched_cpu_util'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      83 |                 sum_util += sched_cpu_util(cpu);
         |                             ^
   1 error generated.


vim +/sched_cpu_util +83 drivers/powercap/dtpm_cpu.c

0e8f68d7f04856 Daniel Lezcano   2020-12-08  70  
eb82bace893169 Daniel Lezcano   2021-03-12  71  static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
eb82bace893169 Daniel Lezcano   2021-03-12  72  {
bb4479994945e9 Dietmar Eggemann 2022-06-21  73  	unsigned long max, sum_util = 0;
eb82bace893169 Daniel Lezcano   2021-03-12  74  	int cpu;
eb82bace893169 Daniel Lezcano   2021-03-12  75  
eb82bace893169 Daniel Lezcano   2021-03-12  76  	/*
eb82bace893169 Daniel Lezcano   2021-03-12  77  	 * The capacity is the same for all CPUs belonging to
bb4479994945e9 Dietmar Eggemann 2022-06-21  78  	 * the same perf domain.
eb82bace893169 Daniel Lezcano   2021-03-12  79  	 */
bb4479994945e9 Dietmar Eggemann 2022-06-21  80  	max = arch_scale_cpu_capacity(cpumask_first(pd_mask));
eb82bace893169 Daniel Lezcano   2021-03-12  81  
bb4479994945e9 Dietmar Eggemann 2022-06-21  82  	for_each_cpu_and(cpu, pd_mask, cpu_online_mask)
bb4479994945e9 Dietmar Eggemann 2022-06-21 @83  		sum_util += sched_cpu_util(cpu);
bb4479994945e9 Dietmar Eggemann 2022-06-21  84  
bb4479994945e9 Dietmar Eggemann 2022-06-21  85  	return (power * ((sum_util << 10) / max)) >> 10;
eb82bace893169 Daniel Lezcano   2021-03-12  86  }
eb82bace893169 Daniel Lezcano   2021-03-12  87  

:::::: The code at line 83 was first introduced by commit
:::::: bb4479994945e9170534389a7762eb56149320ac sched, drivers: Remove max param from effective_cpu_util()/sched_cpu_util()

:::::: TO: Dietmar Eggemann <dietmar.eggemann@arm.com>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

