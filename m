Return-Path: <linux-acpi+bounces-5436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBEC8B43D4
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Apr 2024 04:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EB21C21354
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Apr 2024 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DB239AF4;
	Sat, 27 Apr 2024 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1B3d83y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E338F96;
	Sat, 27 Apr 2024 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714184606; cv=none; b=TVIOCym+dGyKTptPJm2eMqDABANcbGKms9mSkvyHFFBdlxa0XwY3BvtcwaiW3/VPO0iE5HdYOw3UtNCWnHiXWR3dtBZnRA6IMDVhqUrUwvcZNgs6FIWq3irKZ1JwiXSgZJWw3dONikB7TA/nA/1Bs1jAVskwtunFB/BAVg7UXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714184606; c=relaxed/simple;
	bh=s4O1cD6ur+TJfx2wOiGM9x5omp0EZuXF5lklgnxS554=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tgI/6Zg3mAkALAZ5nMRynn2xycYoVjaIblfKjVYr+S7rSFa1fdSd9h3bH4+quj4kFeR1tZDGO3KlVA9WeVcXHUx9MAfEpCLDNApKf2TtTT5C2OXXFQhvS1zxWRXqUE+I6HRj7864ozHnqfK4VLf/O63XbOOdvzEjXKboB4jagsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1B3d83y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714184604; x=1745720604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s4O1cD6ur+TJfx2wOiGM9x5omp0EZuXF5lklgnxS554=;
  b=Y1B3d83y2fk8RZKYRCLOJw281sgytdxKAsyTJQA+v0agx19/cImj9JH0
   tp5/Ds8H54jtDz8cqH+gskFFeAGy9TD9+UOvEmjG+aJN1Nbynf5Z/LLDe
   gNwtZr7UhI58N1w0ggrmD+CsDJfUQxZL554RIHnZk50Knk5dN7hSf5xOA
   kG10jb//kDWUe8kqeVOHWJlZC9nqiH5wSkNFS/uUcyNbICSbSzWhFMOd2
   LKbyPb1+TwBWC4+X5hMdiUZsFkgHiFdAALdsktfHMzYkf4NmtQ067aKe5
   rNgf94SGWISTkSWKIAvicfkNIFuLuDSSJ8reqTwCqHmwb81rvIP5OlIYb
   A==;
X-CSE-ConnectionGUID: 9o0Uy5lBSf6aScjAmuE/7g==
X-CSE-MsgGUID: V5lPW/x9QLClX1pDNhoJLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10096613"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="10096613"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 19:23:23 -0700
X-CSE-ConnectionGUID: i4J2JETuRNmiy5ZLEwkQhQ==
X-CSE-MsgGUID: XjFfGcXoQm6YIfJYzfc2Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="30242470"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 26 Apr 2024 19:23:21 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0Xig-0004Zi-1s;
	Sat, 27 Apr 2024 02:23:18 +0000
Date: Sat, 27 Apr 2024 10:22:54 +0800
From: kernel test robot <lkp@intel.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Li Meng <li.meng@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: [rafael-pm:bleeding-edge 180/186]
 drivers/cpufreq/amd-pstate.c:828:47: warning: variable
 'lowest_nonlinear_freq' set but not used
Message-ID: <202404271038.em6nJjzy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   d9e98e7641ce1ef34d0c33dae1f27611bd1cbcf9
commit: 5547c0ebfc2efdab6ee93a7fd4d9c411ad87013e [180/186] cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq
config: i386-buildonly-randconfig-002-20240427 (https://download.01.org/0day-ci/archive/20240427/202404271038.em6nJjzy-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240427/202404271038.em6nJjzy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404271038.em6nJjzy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_cpu_init':
>> drivers/cpufreq/amd-pstate.c:828:47: warning: variable 'lowest_nonlinear_freq' set but not used [-Wunused-but-set-variable]
     828 |         int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
         |                                               ^~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:828:33: warning: variable 'nominal_freq' set but not used [-Wunused-but-set-variable]
     828 |         int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
         |                                 ^~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_epp_cpu_init':
   drivers/cpufreq/amd-pstate.c:1287:47: warning: variable 'lowest_nonlinear_freq' set but not used [-Wunused-but-set-variable]
    1287 |         int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
         |                                               ^~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:1287:33: warning: variable 'nominal_freq' set but not used [-Wunused-but-set-variable]
    1287 |         int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
         |                                 ^~~~~~~~~~~~
--
>> drivers/cpufreq/amd-pstate.c:791: warning: Function parameter or struct member 'cpudata' not described in 'amd_pstate_init_freq'


vim +/lowest_nonlinear_freq +828 drivers/cpufreq/amd-pstate.c

e571a5e2068ef5 Meng Li    2024-01-19  778  
5547c0ebfc2efd Perry Yuan 2024-04-25  779  /**
5547c0ebfc2efd Perry Yuan 2024-04-25  780   * amd_pstate_init_freq: Initialize the max_freq, min_freq,
5547c0ebfc2efd Perry Yuan 2024-04-25  781   *                       nominal_freq and lowest_nonlinear_freq for
5547c0ebfc2efd Perry Yuan 2024-04-25  782   *                       the @cpudata object.
5547c0ebfc2efd Perry Yuan 2024-04-25  783   *
5547c0ebfc2efd Perry Yuan 2024-04-25  784   *  Requires: highest_perf, lowest_perf, nominal_perf and
5547c0ebfc2efd Perry Yuan 2024-04-25  785   *            lowest_nonlinear_perf members of @cpudata to be
5547c0ebfc2efd Perry Yuan 2024-04-25  786   *            initialized.
5547c0ebfc2efd Perry Yuan 2024-04-25  787   *
5547c0ebfc2efd Perry Yuan 2024-04-25  788   *  Returns 0 on success, non-zero value on failure.
5547c0ebfc2efd Perry Yuan 2024-04-25  789   */
5547c0ebfc2efd Perry Yuan 2024-04-25  790  static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
5547c0ebfc2efd Perry Yuan 2024-04-25 @791  {
5547c0ebfc2efd Perry Yuan 2024-04-25  792  	int ret;
5547c0ebfc2efd Perry Yuan 2024-04-25  793  	u32 min_freq;
5547c0ebfc2efd Perry Yuan 2024-04-25  794  	u32 highest_perf, max_freq;
5547c0ebfc2efd Perry Yuan 2024-04-25  795  	u32 nominal_perf, nominal_freq;
5547c0ebfc2efd Perry Yuan 2024-04-25  796  	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
5547c0ebfc2efd Perry Yuan 2024-04-25  797  	u32 boost_ratio, lowest_nonlinear_ratio;
5547c0ebfc2efd Perry Yuan 2024-04-25  798  	struct cppc_perf_caps cppc_perf;
5547c0ebfc2efd Perry Yuan 2024-04-25  799  
5547c0ebfc2efd Perry Yuan 2024-04-25  800  
5547c0ebfc2efd Perry Yuan 2024-04-25  801  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
5547c0ebfc2efd Perry Yuan 2024-04-25  802  	if (ret)
5547c0ebfc2efd Perry Yuan 2024-04-25  803  		return ret;
5547c0ebfc2efd Perry Yuan 2024-04-25  804  
5547c0ebfc2efd Perry Yuan 2024-04-25  805  	min_freq = cppc_perf.lowest_freq * 1000;
5547c0ebfc2efd Perry Yuan 2024-04-25  806  	nominal_freq = cppc_perf.nominal_freq;
5547c0ebfc2efd Perry Yuan 2024-04-25  807  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
5547c0ebfc2efd Perry Yuan 2024-04-25  808  
5547c0ebfc2efd Perry Yuan 2024-04-25  809  	highest_perf = READ_ONCE(cpudata->highest_perf);
5547c0ebfc2efd Perry Yuan 2024-04-25  810  	boost_ratio = div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
5547c0ebfc2efd Perry Yuan 2024-04-25  811  	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
5547c0ebfc2efd Perry Yuan 2024-04-25  812  
5547c0ebfc2efd Perry Yuan 2024-04-25  813  	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
5547c0ebfc2efd Perry Yuan 2024-04-25  814  	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
5547c0ebfc2efd Perry Yuan 2024-04-25  815  					 nominal_perf);
5547c0ebfc2efd Perry Yuan 2024-04-25  816  	lowest_nonlinear_freq = (nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
5547c0ebfc2efd Perry Yuan 2024-04-25  817  
5547c0ebfc2efd Perry Yuan 2024-04-25  818  	WRITE_ONCE(cpudata->min_freq, min_freq);
5547c0ebfc2efd Perry Yuan 2024-04-25  819  	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
5547c0ebfc2efd Perry Yuan 2024-04-25  820  	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
5547c0ebfc2efd Perry Yuan 2024-04-25  821  	WRITE_ONCE(cpudata->max_freq, max_freq);
5547c0ebfc2efd Perry Yuan 2024-04-25  822  
5547c0ebfc2efd Perry Yuan 2024-04-25  823  	return 0;
5547c0ebfc2efd Perry Yuan 2024-04-25  824  }
5547c0ebfc2efd Perry Yuan 2024-04-25  825  
ec437d71db77a1 Huang Rui  2021-12-24  826  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
ec437d71db77a1 Huang Rui  2021-12-24  827  {
ec437d71db77a1 Huang Rui  2021-12-24 @828  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
ec437d71db77a1 Huang Rui  2021-12-24  829  	struct device *dev;
ec437d71db77a1 Huang Rui  2021-12-24  830  	struct amd_cpudata *cpudata;
ec437d71db77a1 Huang Rui  2021-12-24  831  
919f4557696939 Wyes Karny 2022-11-17  832  	/*
919f4557696939 Wyes Karny 2022-11-17  833  	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
919f4557696939 Wyes Karny 2022-11-17  834  	 * which is ideal for initialization process.
919f4557696939 Wyes Karny 2022-11-17  835  	 */
919f4557696939 Wyes Karny 2022-11-17  836  	amd_perf_ctl_reset(policy->cpu);
ec437d71db77a1 Huang Rui  2021-12-24  837  	dev = get_cpu_device(policy->cpu);
ec437d71db77a1 Huang Rui  2021-12-24  838  	if (!dev)
ec437d71db77a1 Huang Rui  2021-12-24  839  		return -ENODEV;
ec437d71db77a1 Huang Rui  2021-12-24  840  
ec437d71db77a1 Huang Rui  2021-12-24  841  	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
ec437d71db77a1 Huang Rui  2021-12-24  842  	if (!cpudata)
ec437d71db77a1 Huang Rui  2021-12-24  843  		return -ENOMEM;
ec437d71db77a1 Huang Rui  2021-12-24  844  
ec437d71db77a1 Huang Rui  2021-12-24  845  	cpudata->cpu = policy->cpu;
ec437d71db77a1 Huang Rui  2021-12-24  846  
f3a052391822b7 Meng Li    2024-01-19  847  	amd_pstate_init_prefcore(cpudata);
f3a052391822b7 Meng Li    2024-01-19  848  
ec437d71db77a1 Huang Rui  2021-12-24  849  	ret = amd_pstate_init_perf(cpudata);
ec437d71db77a1 Huang Rui  2021-12-24  850  	if (ret)
41271016dfa4a0 Huang Rui  2021-12-24  851  		goto free_cpudata1;
ec437d71db77a1 Huang Rui  2021-12-24  852  
5547c0ebfc2efd Perry Yuan 2024-04-25  853  	ret = amd_pstate_init_freq(cpudata);
5547c0ebfc2efd Perry Yuan 2024-04-25  854  	if (ret)
5547c0ebfc2efd Perry Yuan 2024-04-25  855  		goto free_cpudata1;
5547c0ebfc2efd Perry Yuan 2024-04-25  856  
ec437d71db77a1 Huang Rui  2021-12-24  857  	min_freq = amd_get_min_freq(cpudata);
ec437d71db77a1 Huang Rui  2021-12-24  858  	max_freq = amd_get_max_freq(cpudata);
ec437d71db77a1 Huang Rui  2021-12-24  859  	nominal_freq = amd_get_nominal_freq(cpudata);
ec437d71db77a1 Huang Rui  2021-12-24  860  	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
ec437d71db77a1 Huang Rui  2021-12-24  861  
ec437d71db77a1 Huang Rui  2021-12-24  862  	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
ec437d71db77a1 Huang Rui  2021-12-24  863  		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
ec437d71db77a1 Huang Rui  2021-12-24  864  			min_freq, max_freq);
ec437d71db77a1 Huang Rui  2021-12-24  865  		ret = -EINVAL;
41271016dfa4a0 Huang Rui  2021-12-24  866  		goto free_cpudata1;
ec437d71db77a1 Huang Rui  2021-12-24  867  	}
ec437d71db77a1 Huang Rui  2021-12-24  868  
ec437d71db77a1 Huang Rui  2021-12-24  869  	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
ec437d71db77a1 Huang Rui  2021-12-24  870  	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
ec437d71db77a1 Huang Rui  2021-12-24  871  
ec437d71db77a1 Huang Rui  2021-12-24  872  	policy->min = min_freq;
ec437d71db77a1 Huang Rui  2021-12-24  873  	policy->max = max_freq;
ec437d71db77a1 Huang Rui  2021-12-24  874  
ec437d71db77a1 Huang Rui  2021-12-24  875  	policy->cpuinfo.min_freq = min_freq;
ec437d71db77a1 Huang Rui  2021-12-24  876  	policy->cpuinfo.max_freq = max_freq;
ec437d71db77a1 Huang Rui  2021-12-24  877  
ec437d71db77a1 Huang Rui  2021-12-24  878  	/* It will be updated by governor */
ec437d71db77a1 Huang Rui  2021-12-24  879  	policy->cur = policy->cpuinfo.min_freq;
ec437d71db77a1 Huang Rui  2021-12-24  880  
e059c184da47e9 Huang Rui  2021-12-24  881  	if (boot_cpu_has(X86_FEATURE_CPPC))
1d215f0319c206 Huang Rui  2021-12-24  882  		policy->fast_switch_possible = true;
1d215f0319c206 Huang Rui  2021-12-24  883  
41271016dfa4a0 Huang Rui  2021-12-24  884  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
41271016dfa4a0 Huang Rui  2021-12-24  885  				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
41271016dfa4a0 Huang Rui  2021-12-24  886  	if (ret < 0) {
41271016dfa4a0 Huang Rui  2021-12-24  887  		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
41271016dfa4a0 Huang Rui  2021-12-24  888  		goto free_cpudata1;
41271016dfa4a0 Huang Rui  2021-12-24  889  	}
41271016dfa4a0 Huang Rui  2021-12-24  890  
41271016dfa4a0 Huang Rui  2021-12-24  891  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
41271016dfa4a0 Huang Rui  2021-12-24  892  				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
41271016dfa4a0 Huang Rui  2021-12-24  893  	if (ret < 0) {
41271016dfa4a0 Huang Rui  2021-12-24  894  		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
41271016dfa4a0 Huang Rui  2021-12-24  895  		goto free_cpudata2;
41271016dfa4a0 Huang Rui  2021-12-24  896  	}
41271016dfa4a0 Huang Rui  2021-12-24  897  
febab20caebac9 Wyes Karny 2023-11-17  898  	cpudata->max_limit_freq = max_freq;
febab20caebac9 Wyes Karny 2023-11-17  899  	cpudata->min_limit_freq = min_freq;
ec437d71db77a1 Huang Rui  2021-12-24  900  
ec437d71db77a1 Huang Rui  2021-12-24  901  	policy->driver_data = cpudata;
ec437d71db77a1 Huang Rui  2021-12-24  902  
41271016dfa4a0 Huang Rui  2021-12-24  903  	amd_pstate_boost_init(cpudata);
abd61c08ef349a Perry Yuan 2023-01-31  904  	if (!current_pstate_driver->adjust_perf)
abd61c08ef349a Perry Yuan 2023-01-31  905  		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
41271016dfa4a0 Huang Rui  2021-12-24  906  
ec437d71db77a1 Huang Rui  2021-12-24  907  	return 0;
ec437d71db77a1 Huang Rui  2021-12-24  908  
41271016dfa4a0 Huang Rui  2021-12-24  909  free_cpudata2:
41271016dfa4a0 Huang Rui  2021-12-24  910  	freq_qos_remove_request(&cpudata->req[0]);
41271016dfa4a0 Huang Rui  2021-12-24  911  free_cpudata1:
ec437d71db77a1 Huang Rui  2021-12-24  912  	kfree(cpudata);
ec437d71db77a1 Huang Rui  2021-12-24  913  	return ret;
ec437d71db77a1 Huang Rui  2021-12-24  914  }
ec437d71db77a1 Huang Rui  2021-12-24  915  

:::::: The code at line 828 was first introduced by commit
:::::: ec437d71db77a181227bf6d0ac9d4a80e58ecf0f cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors

:::::: TO: Huang Rui <ray.huang@amd.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

