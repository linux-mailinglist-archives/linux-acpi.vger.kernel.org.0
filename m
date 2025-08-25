Return-Path: <linux-acpi+bounces-16057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33536B34FC6
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 01:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F707B2DF2
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D62C0F9E;
	Mon, 25 Aug 2025 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcnZBpQs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E841F4CA4;
	Mon, 25 Aug 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756165329; cv=none; b=jtMWGT3GWY6onjfXopMwoRDCiQG4X9WIwy+15aw3zPbEzkJx9HHFf6v3QCG/4Dp6qkyQbcIiIQL6rDPjdO2IxgJI/k3dkqx3Vv5UvrS1BRAr76U8zcCL5Iu0i9cA72q0xp6SBrHPLTLaNvMCiXW24TwFeOlPjLo5ccK89fEmcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756165329; c=relaxed/simple;
	bh=J367x8GJDZMLTwx8qc/sItzW7eQs4mCr/b+cuY5NxP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXEVRYstGsNSPwXsHACIIU26xvSguihpAfpqTueOevembMoaqlmDkzbTQy6qBWry87MBSLd+9d33VUkAA99SMmx5yxAsI9B8ELw5+W87l0mGn1rAzMHbotjA6bVlAy6/0HtlQr+VC1JKD4I+wF5VTJqAuhxsXouWyUEwqT0iL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcnZBpQs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756165328; x=1787701328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J367x8GJDZMLTwx8qc/sItzW7eQs4mCr/b+cuY5NxP8=;
  b=IcnZBpQsX6O14Z3wbJNKy7JHnZRYRRxjDFANfG/USgbEXbiMDDxWqV9c
   Yb2MMKA0HQ8aNJgO3zqlHPAX33x9LwTAdeKPv7du05Ci0BSNR6ipmZjIv
   qRXqsG6cwYv7WJ/fHvfCzMrGKqGGqxyKA/G9rO+V3sNtnmzHZ99COMRah
   DMxqzxa/Us0Qe1Pc+g2mLWaUzYSL/XAnC1KHlHVyufE0eoe2xjkN3ZAAL
   Uw9+UP4SypRjU/7PMaMIe+u055zg1RUDe32oOz71r3nPwVGts3UMTbAcR
   Zbf045B4G/EqA9SA+v/3q1rBa9MGeniTQ+mGmf+vLQ56eLVqSTdq3KYUP
   w==;
X-CSE-ConnectionGUID: Xig1s7u3Q52ebqwaUiTFDQ==
X-CSE-MsgGUID: alBgCzlvRt+DzeEZOYN1lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="80981788"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="80981788"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:42:07 -0700
X-CSE-ConnectionGUID: ZQLJOKNrSkypbFLo7ru5Gg==
X-CSE-MsgGUID: jg/agINJQwqHtf0ttoLzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169020979"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 25 Aug 2025 16:41:54 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqgoV-000O4R-2c;
	Mon, 25 Aug 2025 23:41:27 +0000
Date: Tue, 26 Aug 2025 07:41:18 +0800
From: kernel test robot <lkp@intel.com>
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
	ray.huang@amd.com, gautham.shenoy@amd.com,
	mario.limonciello@amd.com, perry.yuan@amd.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-tegra@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
	sanjayc@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
Subject: Re: [PATCH v2 1/7] ACPI: CPPC: add perf control read API and clarify
 naming
Message-ID: <202508260711.I7imWLTG-lkp@intel.com>
References: <20250823200121.1320197-2-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823200121.1320197-2-sumitg@nvidia.com>

Hi Sumit,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.17-rc3 next-20250825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-CPPC-add-perf-control-read-API-and-clarify-naming/20250824-040531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250823200121.1320197-2-sumitg%40nvidia.com
patch subject: [PATCH v2 1/7] ACPI: CPPC: add perf control read API and clarify naming
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250826/202508260711.I7imWLTG-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250826/202508260711.I7imWLTG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508260711.I7imWLTG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:524:8: error: call to undeclared function 'cppc_set_perf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     524 |         ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
         |               ^
   drivers/cpufreq/amd-pstate.c:524:8: note: did you mean 'cppc_set_epp'?
   include/acpi/cppc_acpi.h:170:12: note: 'cppc_set_epp' declared here
     170 | extern int cppc_set_epp(int cpu, u64 epp_val);
         |            ^
   1 error generated.


vim +/cppc_set_perf +524 drivers/cpufreq/amd-pstate.c

e059c184da47e9 Huang Rui         2021-12-24  480  
77fbea69b0ffad Mario Limonciello 2024-12-09  481  static int shmem_update_perf(struct cpufreq_policy *policy, u8 min_perf,
555bbe67a622b2 Dhananjay Ugwekar 2025-02-05  482  			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
e059c184da47e9 Huang Rui         2021-12-24  483  {
77fbea69b0ffad Mario Limonciello 2024-12-09  484  	struct amd_cpudata *cpudata = policy->driver_data;
e059c184da47e9 Huang Rui         2021-12-24  485  	struct cppc_perf_ctrls perf_ctrls;
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  486  	u64 value, prev;
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  487  	int ret;
e059c184da47e9 Huang Rui         2021-12-24  488  
fff395796917ac Mario Limonciello 2024-12-09  489  	if (cppc_state == AMD_PSTATE_ACTIVE) {
77fbea69b0ffad Mario Limonciello 2024-12-09  490  		int ret = shmem_set_epp(policy, epp);
fff395796917ac Mario Limonciello 2024-12-09  491  
fff395796917ac Mario Limonciello 2024-12-09  492  		if (ret)
fff395796917ac Mario Limonciello 2024-12-09  493  			return ret;
fff395796917ac Mario Limonciello 2024-12-09  494  	}
fff395796917ac Mario Limonciello 2024-12-09  495  
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  496  	value = prev = READ_ONCE(cpudata->cppc_req_cached);
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  497  
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  498  	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  499  		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  500  	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  501  	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  502  	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  503  	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  504  
77fbea69b0ffad Mario Limonciello 2024-12-09  505  	if (trace_amd_pstate_epp_perf_enabled()) {
77fbea69b0ffad Mario Limonciello 2024-12-09  506  		union perf_cached perf = READ_ONCE(cpudata->perf);
77fbea69b0ffad Mario Limonciello 2024-12-09  507  
77fbea69b0ffad Mario Limonciello 2024-12-09  508  		trace_amd_pstate_epp_perf(cpudata->cpu,
77fbea69b0ffad Mario Limonciello 2024-12-09  509  					  perf.highest_perf,
77fbea69b0ffad Mario Limonciello 2024-12-09  510  					  epp,
77fbea69b0ffad Mario Limonciello 2024-12-09  511  					  min_perf,
77fbea69b0ffad Mario Limonciello 2024-12-09  512  					  max_perf,
77fbea69b0ffad Mario Limonciello 2024-12-09  513  					  policy->boost_enabled,
77fbea69b0ffad Mario Limonciello 2024-12-09  514  					  value != prev);
77fbea69b0ffad Mario Limonciello 2024-12-09  515  	}
77fbea69b0ffad Mario Limonciello 2024-12-09  516  
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  517  	if (value == prev)
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  518  		return 0;
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  519  
e059c184da47e9 Huang Rui         2021-12-24  520  	perf_ctrls.max_perf = max_perf;
e059c184da47e9 Huang Rui         2021-12-24  521  	perf_ctrls.min_perf = min_perf;
e059c184da47e9 Huang Rui         2021-12-24  522  	perf_ctrls.desired_perf = des_perf;
e059c184da47e9 Huang Rui         2021-12-24  523  
9f5daa2f2f6ddd Mario Limonciello 2024-12-09 @524  	ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  525  	if (ret)
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  526  		return ret;
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  527  
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  528  	WRITE_ONCE(cpudata->cppc_req_cached, value);
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  529  
9f5daa2f2f6ddd Mario Limonciello 2024-12-09  530  	return 0;
e059c184da47e9 Huang Rui         2021-12-24  531  }
e059c184da47e9 Huang Rui         2021-12-24  532  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

