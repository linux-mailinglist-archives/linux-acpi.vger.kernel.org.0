Return-Path: <linux-acpi+bounces-4520-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A30489014F
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Mar 2024 15:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB971F2624B
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Mar 2024 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AEA127B56;
	Thu, 28 Mar 2024 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+ChRLuS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469414294;
	Thu, 28 Mar 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634958; cv=none; b=UG+QxWZS30RyEO73vedQPx49FoJSZxi7WHJUAfl8kv/2OgV9PqsV8eGV+0NATHSHaDHa1EmhXa/jnKh0AlIhhbvghTVVkRURmghe/tct6S0KlwM7q+1nNRIiYccOT2dhqXmEEu+Z9q9tEXr8/d9GE1gW4KGc+/qQ+9Z6y7kGY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634958; c=relaxed/simple;
	bh=9ArBQfi0WbPJGGn9OWD45slXRdspJPNTm1sjms/frXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nmY8Dmz6vm3ghh/XPjmkpQk1DSO/abBU6Fz1Arpvhb2sMrCCYoEcWARpCU4oqlBsMqDkAUCNh4QwI4IvvAxbwS5ai/KBlP1jO48fonJicUxQbOrOYBnX5qYWcuxn+7//PTFKzQUGEJE0YHxevioOZ2JjDzyMrhfTbYLHU4GOYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+ChRLuS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711634956; x=1743170956;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9ArBQfi0WbPJGGn9OWD45slXRdspJPNTm1sjms/frXQ=;
  b=X+ChRLuS6jrpwnLModiwf+FW8VkMuWNRM6nmGu5R8hjmWXEnHUOBLzNn
   eJvgng3EHaHPlYDmn+NF5ryeK19y9chQ2ji8PA91CL4i9YHTBuWTG8DQh
   mhs+kibMkTZJUbGGQIwyXLH1iapxN0UXTBANXW0PP82McQQ/3Jvw5Yb+T
   OnO3PCmXPQt8dJL2QX+V77pJ9iA2TUVDv+4+3fwlsLDsfVbuiCr8SuVUw
   ZNtFvHQeuiIo019HKhocbCYNGZeyk/+G2q6wg2MvKanKtvnA/+v+FBRu8
   oDPlcsc5miGOBuESNIw1UlTYdaR1i034WznPV7rpBibV7URSoENh4B/xI
   Q==;
X-CSE-ConnectionGUID: 5GW9oXwrSHaOOT+jOJZeRw==
X-CSE-MsgGUID: EwqF9WFCSq61UPDNG+sKkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="9745391"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="9745391"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 07:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21126920"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Mar 2024 07:09:09 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpqRH-0002CY-0y;
	Thu, 28 Mar 2024 14:09:07 +0000
Date: Thu, 28 Mar 2024 22:08:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org
Subject: [rafael-pm:intel_pstate-testing 14/14]
 drivers/cpufreq/intel_pstate.c:963:2: error: call to undeclared function
 'arch_set_cpu_capacity'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202403282240.I0XCTxpL-lkp@intel.com>
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
config: i386-defconfig (https://download.01.org/0day-ci/archive/20240328/202403282240.I0XCTxpL-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403282240.I0XCTxpL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403282240.I0XCTxpL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cpufreq/intel_pstate.c:963:2: error: call to undeclared function 'arch_set_cpu_capacity'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     963 |         arch_set_cpu_capacity(cpu->cpu, cap);
         |         ^
   drivers/cpufreq/intel_pstate.c:963:2: note: did you mean 'arch_scale_cpu_capacity'?
   include/linux/sched/topology.h:267:15: note: 'arch_scale_cpu_capacity' declared here
     267 | unsigned long arch_scale_cpu_capacity(int cpu)
         |               ^
   drivers/cpufreq/intel_pstate.c:1008:3: error: call to undeclared function 'arch_set_cpu_capacity'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1008 |                 arch_set_cpu_capacity(max_perf_cpu->cpu, SCHED_CAPACITY_SCALE);
         |                 ^
   drivers/cpufreq/intel_pstate.c:1014:4: error: call to undeclared function 'arch_set_cpu_capacity'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1014 |                         arch_set_cpu_capacity(cpunum, SCHED_CAPACITY_SCALE);
         |                         ^
   drivers/cpufreq/intel_pstate.c:1073:3: error: call to undeclared function 'arch_set_cpu_capacity'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1073 |                 arch_set_cpu_capacity(cpu->cpu, SCHED_CAPACITY_SCALE);
         |                 ^
   drivers/cpufreq/intel_pstate.c:1207:2: error: call to undeclared function 'arch_set_cpu_capacity'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1207 |         arch_set_cpu_capacity(cpu->cpu, SCHED_CAPACITY_SCALE);
         |         ^
   5 errors generated.


vim +/arch_set_cpu_capacity +963 drivers/cpufreq/intel_pstate.c

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

