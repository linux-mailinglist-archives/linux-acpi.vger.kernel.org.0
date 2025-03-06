Return-Path: <linux-acpi+bounces-11883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99525A541A4
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 05:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE46B3ACA28
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 04:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94619B5B1;
	Thu,  6 Mar 2025 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMIJKo/Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059B19B5B4;
	Thu,  6 Mar 2025 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741235158; cv=none; b=pSLkZW7UIDL2+oksUsT4DyCQfy9dXLrCkhdNYsroKYEBXyYKKxYr6Ja1KfgGL/1JjnI8c7semx/q5dZLcbwg5PdxBquqK4Gg+pQW4pgsArRdlWgE26187xpjnBIi6/lo/MQxlt07daoCMO2t+OA2sngmK+tXL7g52bLT6rXoUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741235158; c=relaxed/simple;
	bh=ZQRetbtMH9PmPOowjjiV/1ueBKUgEylsKtX9cQioFAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aXaSDOmAPOUIYQ2ZiewN2SRobu7yse72rJWMtZPSyyXIs2aFaLz6D0r45WMFkHBwDJ6t+5hsWaNIt9OnymvTB4gbdjjSs/WA8Msn03UOjWVQFvi+M9xC3M9CgFOfi5sjSV7M0uo+jd0Eqnig59cw70VNwqh7QMMIAY/WvPbwJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMIJKo/Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741235157; x=1772771157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZQRetbtMH9PmPOowjjiV/1ueBKUgEylsKtX9cQioFAM=;
  b=DMIJKo/Zqhzv4lMEBuhRagTjkP6u35b05ncmcdW6wD+WV9GPgcb2B0n0
   +lp0mqHxfBCmQvEXcuaNxkpge63a5e8Ie7lBP2bbg+tad8SQLkHPEwPWr
   9M8ie3M8M1G/GVOAJ60SOlMt/C63Ad3B614iD6kgMiiCueH2Lu2Zj+Cj5
   ip0H+2OfX4AL5H62EPsfN+cv9MbWT+hyngveC4iZD8MyMqivIjDdQ+TUt
   /4vEfN4znVmudZeFIjCSYkWFWUA47yNftVv0a3qlGCp36MusmZFL20t1N
   gs0jGYr18Fjr+qcUzXy5EZlsrr+RedzMmwCxTSy65q9wkZhMCOVepjqHQ
   Q==;
X-CSE-ConnectionGUID: qo5cNz1/TA6tqG6aoHEhqQ==
X-CSE-MsgGUID: xK3w0/AbSEGbTX3nNVvpQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41404192"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41404192"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:25:55 -0800
X-CSE-ConnectionGUID: NxSvLMRfR22d2lnayIh4Ng==
X-CSE-MsgGUID: zB/b7RMpQeu8txIbLtduVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="119404636"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 05 Mar 2025 20:25:53 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq2nu-000MWk-1U;
	Thu, 06 Mar 2025 04:25:50 +0000
Date: Thu, 6 Mar 2025 12:24:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jeson Gao <jeson.gao@unisoc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [rafael-pm:bleeding-edge 103/108] drivers/powercap/dtpm_cpu.c:83:29:
 error: implicit declaration of function 'sched_cpu_util'
Message-ID: <202503061203.vRnwilWZ-lkp@intel.com>
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
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20250306/202503061203.vRnwilWZ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503061203.vRnwilWZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061203.vRnwilWZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/powercap/dtpm_cpu.c: In function 'scale_pd_power_uw':
>> drivers/powercap/dtpm_cpu.c:83:29: error: implicit declaration of function 'sched_cpu_util' [-Wimplicit-function-declaration]
      83 |                 sum_util += sched_cpu_util(cpu);
         |                             ^~~~~~~~~~~~~~


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

