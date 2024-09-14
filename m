Return-Path: <linux-acpi+bounces-8295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435E9790C3
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C081C282904
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C81CF2B0;
	Sat, 14 Sep 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHqoF4T3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967E77115;
	Sat, 14 Sep 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726316044; cv=none; b=ifmod6R2/Diq+eSP/2JdJ/71Vi6zeBWOi+3ByinqWEuzRJ2Su5fUqRb7A2gj6QO1YMczyfoySG4NcIv0oqtZuEI8DZu0YPOR/7KPDNF0RaEFBRi3znIJ2O4lLNI9CZ11+q+A+x2gTX21t+dnVXSkst87ft6nsczJV6VBbKjCiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726316044; c=relaxed/simple;
	bh=ot9x1hg/d/1uLiT7Q0B6SgyHCzVqHOo4oWuX+Wh2JJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRKVPg7XY6ZboMzVssOvXJKM9i2+IOuxMGGs4sACqsIopSvQ9rNvVmNwe3jAsknQESf8wjA1+Q0Z3ixCm1ByzE6iDK5MwicSrmccNSqQUw+dUcHe4ZsH6L2Ig9pPM3b6rC2+OxTmgDRWEHADSwY8M/GYfkjh02o3FBTk+umktVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHqoF4T3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726316042; x=1757852042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ot9x1hg/d/1uLiT7Q0B6SgyHCzVqHOo4oWuX+Wh2JJ4=;
  b=lHqoF4T3VVJnSQVTvTKonZH5rPDotOnX+yqqr+yEAmJPmdJ+5luvpuvn
   +EWIv/OkMcpmg+1rHL/eicOStYlHKNedVkXlP/mz2IYRA1qU0ztzGiSn/
   2CqrOVbp6WHDpwBDBMTJ6R30SfeVOVQU/S4Kz6L/FrDYCpbNFO7tSmQqp
   Eo8cBNnlTnYnCK4/+g7hY+l1/08rIv0kPqnMUFOdDIQN0prE5IigdRcpT
   7PX1+u+d3edYrb3aSYn4MLvJHLYtaIYCWBVDdChNHC8YuZaUEv9K7YTbm
   gGl4ZsD65SiJs6Ns0l6I6zdNH2T89fPc8TaUqzkUB3qQLjrj2+dRdQJzv
   w==;
X-CSE-ConnectionGUID: dFq6FdO5RMu04H2zcI29uw==
X-CSE-MsgGUID: 0/1u+pGSScC6SrFGjHr5mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="36347227"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="36347227"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 05:14:02 -0700
X-CSE-ConnectionGUID: BAdcNCMdSIuzILkdbxjCLw==
X-CSE-MsgGUID: nNdw04wrQkGXUcH5gwqkww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="68476797"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Sep 2024 05:13:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spRf1-0007ig-2I;
	Sat, 14 Sep 2024 12:13:55 +0000
Date: Sat, 14 Sep 2024 20:13:50 +0800
From: kernel test robot <lkp@intel.com>
To: Jie Zhan <zhanjie9@hisilicon.com>, ionela.voinescu@arm.com,
	beata.michalska@arm.com, wangxiongfeng2@huawei.com,
	viresh.kumar@linaro.org, rafael@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
	zhanjie9@hisilicon.com, jonathan.cameron@huawei.com,
	wanghuiqiang@huawei.com, zhenglifeng1@huawei.com,
	lihuisong@huawei.com, yangyicong@huawei.com, liaochang1@huawei.com,
	zengheng4@huawei.com
Subject: Re: [PATCH v2 3/3] cppc_cpufreq: Remove HiSilicon CPPC workaround
Message-ID: <202409141923.kDxHsCjn-lkp@intel.com>
References: <20240912072231.439332-4-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912072231.439332-4-zhanjie9@hisilicon.com>

Hi Jie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jie-Zhan/cppc_cpufreq-Return-desired-perf-in-get-if-feedback-counters-are-0/20240912-153059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240912072231.439332-4-zhanjie9%40hisilicon.com
patch subject: [PATCH v2 3/3] cppc_cpufreq: Remove HiSilicon CPPC workaround
config: arm64-randconfig-001-20240913 (https://download.01.org/0day-ci/archive/20240914/202409141923.kDxHsCjn-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409141923.kDxHsCjn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409141923.kDxHsCjn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/cppc_cpufreq.c:45:3: warning: unused variable 'fie_disabled' [-Wunused-variable]
   } fie_disabled = FIE_UNSET;
     ^
   1 warning generated.


vim +/fie_disabled +45 drivers/cpufreq/cppc_cpufreq.c

a3f083e04a8766 Zheng Bin     2022-05-21  40  
ae2df912d1a557 Jeremy Linton 2022-09-12  41  static enum {
ae2df912d1a557 Jeremy Linton 2022-09-12  42  	FIE_UNSET = -1,
ae2df912d1a557 Jeremy Linton 2022-09-12  43  	FIE_ENABLED,
ae2df912d1a557 Jeremy Linton 2022-09-12  44  	FIE_DISABLED
ae2df912d1a557 Jeremy Linton 2022-09-12 @45  } fie_disabled = FIE_UNSET;
ae2df912d1a557 Jeremy Linton 2022-09-12  46  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

