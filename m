Return-Path: <linux-acpi+bounces-4522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B696890408
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Mar 2024 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA4C1F24DCB
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Mar 2024 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4DE130E46;
	Thu, 28 Mar 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lz6E1std"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998012FB21;
	Thu, 28 Mar 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641377; cv=none; b=p+MlynZCS8ddvEjf11fIHK8/bWSUBMOYSyZtWAkFTcE9h38pS0wkzU1LY3TmPjTpX+eWc9xP0JWrxcW2LRkMXKqoJ1+6ZQ/+/TWvmlnSkKZD7GoGRjmdSz3zUwC0gWvHLsbLBhNaFfQ1kfiw8nAjuHcrvuDiEZhGiY274SzO3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641377; c=relaxed/simple;
	bh=vwbLly6I3GZ7CR+wbxee82E1xfeIapoUlYJbYTZbNwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TJIuDXno+qwlrMX+AuOp1X5JhIqV+gaTSNkc57avZ7zWCznM8mfQ3XqkNlG6Yux601C3MLYUoxfjn/n2jb+jyyl55jBGLths870igMXJCk97X9hQ8Hm67Dwut1fjdYAVfZyxUkmL1Q20cwkK84TRYz84G5++VqoYp5IGP9M3DsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lz6E1std; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711641374; x=1743177374;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vwbLly6I3GZ7CR+wbxee82E1xfeIapoUlYJbYTZbNwI=;
  b=Lz6E1stdZLG2rMDF6JsRD62OivbCXKF5vy0si+dWonjvnLVMnfm6ftmA
   z4PghJhCtqNqnjgRR1ziTsHszN0Aafw+aw2Z840fWRVROdSbfN8nqV2DE
   d2YooslIIAp/34HfImwk48e4b9huDAAQG1t20+mQmkhKG5ASxgNzKWHvE
   iLm2hGt8bdksU7lf8CmVT6Suw36VUP15xoUWw9Ob/E68tk5hoPyMcliZB
   0miH7kHE/EqzSSFxCKrlawwEVrdApbpXhEoIyAAQTEfDZZ5OXGE18026R
   oWacZF8kB+r1kiNtf/uHl/VYSh6gkzD21CSET8rq/4pMiQoGU69kdd+KC
   A==;
X-CSE-ConnectionGUID: x8zpC0RCRFGWZDbPW0/iDw==
X-CSE-MsgGUID: FM10o1N8T6ain6AS3pMV2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17946717"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17946717"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 08:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21388148"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Mar 2024 08:56:13 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rps6s-0002Hy-1G;
	Thu, 28 Mar 2024 15:56:10 +0000
Date: Thu, 28 Mar 2024 23:55:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:intel_pstate-testing 14/14]
 drivers/cpufreq/intel_pstate.c:963:2: error: implicit declaration of
 function 'arch_set_cpu_capacity'; did you mean 'arch_scale_cpu_capacity'?
Message-ID: <202403282334.VfY1MU72-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git intel_pstate-testing
head:   16303764deedb814defe7e69712edec6a09b50ad
commit: 16303764deedb814defe7e69712edec6a09b50ad [14/14] cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems
config: x86_64-randconfig-161-20240328 (https://download.01.org/0day-ci/archive/20240328/202403282334.VfY1MU72-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403282334.VfY1MU72-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403282334.VfY1MU72-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cpufreq/intel_pstate.c: In function 'hybrid_set_cpu_capacity':
>> drivers/cpufreq/intel_pstate.c:963:2: error: implicit declaration of function 'arch_set_cpu_capacity'; did you mean 'arch_scale_cpu_capacity'? [-Werror=implicit-function-declaration]
     963 |  arch_set_cpu_capacity(cpu->cpu, cap);
         |  ^~~~~~~~~~~~~~~~~~~~~
         |  arch_scale_cpu_capacity
   cc1: some warnings being treated as errors


vim +963 drivers/cpufreq/intel_pstate.c

   957	
   958	static void hybrid_set_cpu_capacity(struct cpudata *cpu)
   959	{
   960		u64 cap = div_u64((u64)SCHED_CAPACITY_SCALE * cpu->capacity_perf,
   961				  hybrid_max_perf_cpu->capacity_perf);
   962	
 > 963		arch_set_cpu_capacity(cpu->cpu, cap);
   964	}
   965	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

