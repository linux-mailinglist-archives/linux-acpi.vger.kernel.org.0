Return-Path: <linux-acpi+bounces-7910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B2961946
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 23:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDAF1C23033
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 21:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F41D4141;
	Tue, 27 Aug 2024 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIgZ+diQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06531BF329;
	Tue, 27 Aug 2024 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794342; cv=none; b=GgR+aSLPShAHeCj3u5mEO3zR6W8kjvrHxu1DmyZP9PnuoCYCWDtKtN3R3/IZTMIGEq+6xzWtG4kLfFNzZYVzmTr509bzkdksa7xR3LnlNncw36ETnl69H06qHfhgNPtzO2TC9soOyPYldU3a3cyjlNkUfHVDBVbQt6oSR5So7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794342; c=relaxed/simple;
	bh=VdVuzOa4xQiigr1kVsf2HhAJLMDzuQOG906kdRtZLLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjrZPammHwevJn+RVIEbVmQ4Hl5zcjnc29G88ssRVyTwAL4Skq9hmkZmxLfwBaZjzujagwwNuRoYwAvZXXilb+3s8MtG3v84LFnhVU3cUqU0D7qImEQfqiZDFNwgqMAenyCxtpNNU9e3ShSxhm/GzOGMMiT/zwKx9EP0fHzIEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIgZ+diQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724794341; x=1756330341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VdVuzOa4xQiigr1kVsf2HhAJLMDzuQOG906kdRtZLLE=;
  b=iIgZ+diQSJzSuLBdBtDP3aNTk2l9cedWz8OTKMeZVVlOH/xLx373ESCc
   o2cW++bCFh0K5qywcItI9oKEWhNm7elBlynazYtw5cZ8O4VrZC56uqZe4
   LpgyuUJYYmZ8rwj39uIV0866fiKWxzGAW5WmIaF/umhb9G4AirdFh0BAq
   BDWqSpDgGMoaEI25vkyjNTLnhxWdAPCz7OnVd93J5VqQaRxVymxpXRDDq
   v5pB0Kp3dX1nvN9FrZtsrQPYwVzuDrcamTPtnRth7P70KjzMiWu8XwfPW
   qYp8DslE060fe8Fv98pyoGo8DsdmATDo8S09JAWgFznb3qOXL0WJvzblg
   Q==;
X-CSE-ConnectionGUID: mJWmn+WFSdirAyh0HS8Jpw==
X-CSE-MsgGUID: 8I16g1ziQRWsUEZ6smiG+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33872128"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="33872128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:32:21 -0700
X-CSE-ConnectionGUID: 3VdZZa3MQnW+VHfgLQcVWg==
X-CSE-MsgGUID: YYZZ2Kn0SP6K3hJLALdGlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67152953"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2024 14:32:17 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj3nT-000K6E-0K;
	Tue, 27 Aug 2024 21:32:15 +0000
Date: Wed, 28 Aug 2024 05:31:25 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"(maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"(open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 6/8] cpufreq: amd-pstate: Merge
 amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()
Message-ID: <202408280553.k4hXRtZy-lkp@intel.com>
References: <20240826211358.2694603-7-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-7-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge tip/x86/core tip/master linus/master v6.11-rc5 next-20240827]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/x86-amd-Move-amd_get_highest_perf-from-amd-c-to-cppc-c/20240827-051648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240826211358.2694603-7-superm1%40kernel.org
patch subject: [PATCH 6/8] cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240828/202408280553.k4hXRtZy-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280553.k4hXRtZy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280553.k4hXRtZy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:402:38: warning: variable 'highest_perf' is uninitialized when used here [-Wuninitialized]
     402 |         WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
         |                                             ^~~~~~~~~~~~
   include/asm-generic/rwonce.h:61:18: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |                         ^~~
   include/asm-generic/rwonce.h:55:33: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:395:18: note: initialize the variable 'highest_perf' to silence this warning
     395 |         u32 highest_perf;
         |                         ^
         |                          = 0
   1 warning generated.


vim +/highest_perf +402 drivers/cpufreq/amd-pstate.c

ec437d71db77a1 Huang Rui         2021-12-24  391  
e059c184da47e9 Huang Rui         2021-12-24  392  static int cppc_init_perf(struct amd_cpudata *cpudata)
e059c184da47e9 Huang Rui         2021-12-24  393  {
e059c184da47e9 Huang Rui         2021-12-24  394  	struct cppc_perf_caps cppc_perf;
bedadcfb011fef Perry Yuan        2022-08-30  395  	u32 highest_perf;
e059c184da47e9 Huang Rui         2021-12-24  396  
e059c184da47e9 Huang Rui         2021-12-24  397  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
e059c184da47e9 Huang Rui         2021-12-24  398  	if (ret)
e059c184da47e9 Huang Rui         2021-12-24  399  		return ret;
e059c184da47e9 Huang Rui         2021-12-24  400  
347b3754cc9780 Mario Limonciello 2024-08-26  401  	WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
febab20caebac9 Wyes Karny        2023-11-17 @402  	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
e059c184da47e9 Huang Rui         2021-12-24  403  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
e059c184da47e9 Huang Rui         2021-12-24  404  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
e059c184da47e9 Huang Rui         2021-12-24  405  		   cppc_perf.lowest_nonlinear_perf);
e059c184da47e9 Huang Rui         2021-12-24  406  	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
e571a5e2068ef5 Meng Li           2024-01-19  407  	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
febab20caebac9 Wyes Karny        2023-11-17  408  	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
e059c184da47e9 Huang Rui         2021-12-24  409  
2dd6d0ebf74049 Wyes Karny        2023-03-07  410  	if (cppc_state == AMD_PSTATE_ACTIVE)
2dd6d0ebf74049 Wyes Karny        2023-03-07  411  		return 0;
2dd6d0ebf74049 Wyes Karny        2023-03-07  412  
2dd6d0ebf74049 Wyes Karny        2023-03-07  413  	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
2dd6d0ebf74049 Wyes Karny        2023-03-07  414  	if (ret) {
2dd6d0ebf74049 Wyes Karny        2023-03-07  415  		pr_warn("failed to get auto_sel, ret: %d\n", ret);
e059c184da47e9 Huang Rui         2021-12-24  416  		return 0;
e059c184da47e9 Huang Rui         2021-12-24  417  	}
e059c184da47e9 Huang Rui         2021-12-24  418  
2dd6d0ebf74049 Wyes Karny        2023-03-07  419  	ret = cppc_set_auto_sel(cpudata->cpu,
2dd6d0ebf74049 Wyes Karny        2023-03-07  420  			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
2dd6d0ebf74049 Wyes Karny        2023-03-07  421  
2dd6d0ebf74049 Wyes Karny        2023-03-07  422  	if (ret)
2dd6d0ebf74049 Wyes Karny        2023-03-07  423  		pr_warn("failed to set auto_sel, ret: %d\n", ret);
2dd6d0ebf74049 Wyes Karny        2023-03-07  424  
2dd6d0ebf74049 Wyes Karny        2023-03-07  425  	return ret;
2dd6d0ebf74049 Wyes Karny        2023-03-07  426  }
2dd6d0ebf74049 Wyes Karny        2023-03-07  427  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

