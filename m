Return-Path: <linux-acpi+bounces-4609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD68896531
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Apr 2024 09:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00538284351
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Apr 2024 07:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3853393;
	Wed,  3 Apr 2024 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGfli6gO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA024B23;
	Wed,  3 Apr 2024 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127580; cv=none; b=N8H0cljV832hgoWOOa++YeUgfZ7kE8dEaLe5DBIIMOQg4sjFHX8ql2871ybfBdM6jedn7gRHPTlbbWhIilUCzjccmJ52x8UlcTK4b3JShWXzs+b8+xVS4ixYg1gFzahM4Ume6V6DIagWhQrKiKS+cXy5T5saCzBF/zxfO35U58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127580; c=relaxed/simple;
	bh=C63E9xFIqmaqyqq61R2hzDE8eqlb46lHuUiLFuY6IEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jdpiWAS78cEO7K8zcxSrL5y3OC0s7nE0gaziJjQN09qZ7NbfDDuJy/xWmUIoaW8fzAZMppaLaMb5Eye8mj2Zzd6NOxGsoYTTG3pFEFxKtIhqCQ+4qTlBLhc42ZBNsQPJjOMhJ7QS7Ljgoz9ff+jgKVmghM59UQ/b+s/ec/xEGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGfli6gO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712127577; x=1743663577;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C63E9xFIqmaqyqq61R2hzDE8eqlb46lHuUiLFuY6IEw=;
  b=SGfli6gO83rmByJtWG2jri7iPoKjmff05JJqPVfzMPLwNTEbo86Xum1/
   szIrh3YfbXgk5KUcLM/+dP93WbHdR5Fv+RzB2HJ09ogt8utJpLZe8nct2
   OzrDal4+e+5/fZKEvvtVJYV9eeKMZdNMbsssk2e36DZ87YYwNe5v/FLpu
   gP9sOZ8dR8r3HbrWUAfD9idyEOtAqNvaVfcc4T/DtLdSEnJahcLI5LAdk
   /o8oyyFfWPZWXB1pEyDKL8XqKgViu0yt0PQ6ftjKDQ04P5WV7ZiukCDCu
   1oHdYfFiGy4ndBOiodClbLIQrhUmoiRWSvJv+0bVIyIIHyLrWeHbkm/37
   Q==;
X-CSE-ConnectionGUID: Pl5JO6dSR5S4O0hwmopfYQ==
X-CSE-MsgGUID: fgWcETS0QCaP+We0gtQ7CQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18496024"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18496024"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 23:59:36 -0700
X-CSE-ConnectionGUID: HmdooRwJQVSKUF9bR/U2HA==
X-CSE-MsgGUID: r4IZeYqkScavXWJcFrl30Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="23027565"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2024 23:59:35 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rruaq-0001xR-1z;
	Wed, 03 Apr 2024 06:59:32 +0000
Date: Wed, 3 Apr 2024 14:58:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:intel_pstate-testing 14/14]
 drivers/cpufreq/intel_pstate.c:3301:undefined reference to
 `arch_rebuild_sched_domains'
Message-ID: <202404031421.nMNiWZMY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git intel_pstate-testing
head:   e35f6a1b27a71e7c8cb1880197e01d93b593cc85
commit: e35f6a1b27a71e7c8cb1880197e01d93b593cc85 [14/14] cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems
config: x86_64-randconfig-014-20240403 (https://download.01.org/0day-ci/archive/20240403/202404031421.nMNiWZMY-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404031421.nMNiWZMY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404031421.nMNiWZMY-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/cpufreq/intel_pstate.o: in function `intel_pstate_register_driver':
>> drivers/cpufreq/intel_pstate.c:3301:(.text+0x409c): undefined reference to `arch_rebuild_sched_domains'


vim +3301 drivers/cpufreq/intel_pstate.c

  3267	
  3268	static int intel_pstate_register_driver(struct cpufreq_driver *driver)
  3269	{
  3270		int ret;
  3271	
  3272		if (driver == &intel_pstate)
  3273			intel_pstate_sysfs_expose_hwp_dynamic_boost();
  3274	
  3275		memset(&global, 0, sizeof(global));
  3276		global.max_perf_pct = 100;
  3277		global.turbo_disabled = turbo_is_disabled();
  3278		global.no_turbo = global.turbo_disabled;
  3279	
  3280		arch_set_max_freq_ratio(global.turbo_disabled);
  3281	
  3282		intel_pstate_driver = driver;
  3283		ret = cpufreq_register_driver(intel_pstate_driver);
  3284		if (ret) {
  3285			intel_pstate_driver_cleanup();
  3286			return ret;
  3287		}
  3288	
  3289		global.min_perf_pct = min_perf_pct_min();
  3290	
  3291		/*
  3292		 * On hybrid systems, use asym capacity instead of ITMT, but because
  3293		 * the capacity of SMT threads is not deterministic even approximately,
  3294		 * do not do that when SMT is in use.
  3295		 */
  3296		if (hwp_is_hybrid && !sched_smt_active()) {
  3297			sched_clear_itmt_support();
  3298	
  3299			hybrid_init_cpu_scaling();
  3300	
> 3301			arch_rebuild_sched_domains();
  3302		}
  3303	
  3304		return 0;
  3305	}
  3306	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

