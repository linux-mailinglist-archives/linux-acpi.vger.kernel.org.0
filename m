Return-Path: <linux-acpi+bounces-16516-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D15EB49D14
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 00:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D61BC53FB
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3AA2E339B;
	Mon,  8 Sep 2025 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USjzCSE6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34892DAFAB;
	Mon,  8 Sep 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371747; cv=none; b=dbJTHfwSqCqs2BwS8mZ+hmipsPmerF4NyWQgS3ft1fDOORX7GSrNSXPSt5ecf56CTXgeoT5FIyfCDF5l2Sb3BUGK1LEGkuKQ+/Lx0frpAH64GzWIBJ51qSUvbasMrl40iSvh9bwj42bc7FJfh9P0HqQlGfaOrG8KWPlt29lb4FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371747; c=relaxed/simple;
	bh=OkCePolY7cDGgdqNxAbs/WJT/52i6H2FhBNbFIBYrM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aOickl96pPLYnpFpWP4mb3yac2aDLLRmzvM3oRfLZYqLisTUMU7ip+ASNAiQicwHcuolH2j2gVB2JmHMSGo2mZzXUMfxsKZxn9vT3WJ+1wAWWL1D4dIxY1cbiBc0tXOKUIpFNa4ctOTuOVK2AJWu7Ez5KQngFcSO2PYnOIuCAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USjzCSE6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757371746; x=1788907746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OkCePolY7cDGgdqNxAbs/WJT/52i6H2FhBNbFIBYrM0=;
  b=USjzCSE6IjIv5Iyl+CRJTjQoUGMtUWfXsArWcDpHcaSe7HfGddy5B6cV
   z7kOOnxAfDJK+RwTn7EVnPTSRHdQjM8/bply2ItUtpwk6BE9SAnIGoo1P
   n6pX3UCXB5x9xrkk8w7CTinE09ReRpPqrRxdS3DKSpICwH2cuno4jATxi
   OoTUtMYiWI23H4INLu5JFURWhgiY0QjOPmmJE/EQ9fqm8ubtv2gN2moYB
   tSk5XmNhwGCvlMpZ6/wugZFz1B4zNUwOl5M46GvAJ6d2VtAmGy4MtQNfT
   +gEbXEWOAtHcj2yPq0j7r1Yzoc5MhSVKOq3iuYDLF7NjHOL8/zYhG0moH
   g==;
X-CSE-ConnectionGUID: L8Wpg5bnSUapQYwZOdMaIA==
X-CSE-MsgGUID: PQk4Hb38STGym5DhMTzQEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70263412"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="70263412"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 15:49:05 -0700
X-CSE-ConnectionGUID: GwM3MuFeSgy63kMLRKY6fg==
X-CSE-MsgGUID: 5colQc8fRuq7YtvESl4UFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="173390149"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Sep 2025 15:49:04 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvkfV-0004DP-2q;
	Mon, 08 Sep 2025 22:49:01 +0000
Date: Tue, 9 Sep 2025 06:48:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org, Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [rafael-pm:bleeding-edge 97/99]
 drivers/cpufreq/intel_pstate.c:1682:70: error: 'cpunum' undeclared
Message-ID: <202509090605.9U0N21IK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f201aa3fccf8e14001fba263e82af41c881498f9
commit: dd08703a10a122a3018e2e4f43d693fffe3120aa [97/99] cpufreq: intel_pstate: Rearrange freq QoS updates using __free()
config: x86_64-buildonly-randconfig-003-20250909 (https://download.01.org/0day-ci/archive/20250909/202509090605.9U0N21IK-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509090605.9U0N21IK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509090605.9U0N21IK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:103,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/barrier.h:5,
                    from include/asm-generic/bitops/generic-non-atomic.h:7,
                    from include/linux/bitops.h:28,
                    from include/linux/kernel.h:23,
                    from drivers/cpufreq/intel_pstate.c:11:
   drivers/cpufreq/intel_pstate.c: In function 'update_cpu_qos_request':
>> drivers/cpufreq/intel_pstate.c:1682:70: error: 'cpunum' undeclared (first use in this function)
    1682 |                 pr_warn("Failed to update freq constraint: CPU%d\n", cpunum);
         |                                                                      ^~~~~~
   include/linux/printk.h:486:33: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:567:9: note: in expansion of macro 'printk'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/cpufreq/intel_pstate.c:1682:17: note: in expansion of macro 'pr_warn'
    1682 |                 pr_warn("Failed to update freq constraint: CPU%d\n", cpunum);
         |                 ^~~~~~~
   drivers/cpufreq/intel_pstate.c:1682:70: note: each undeclared identifier is reported only once for each function it appears in
    1682 |                 pr_warn("Failed to update freq constraint: CPU%d\n", cpunum);
         |                                                                      ^~~~~~
   include/linux/printk.h:486:33: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:567:9: note: in expansion of macro 'printk'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/cpufreq/intel_pstate.c:1682:17: note: in expansion of macro 'pr_warn'
    1682 |                 pr_warn("Failed to update freq constraint: CPU%d\n", cpunum);
         |                 ^~~~~~~


vim +/cpunum +1682 drivers/cpufreq/intel_pstate.c

  1654	
  1655	static void update_cpu_qos_request(int cpu, enum freq_qos_req_type type)
  1656	{
  1657		struct cpudata *cpudata = all_cpu_data[cpu];
  1658		struct freq_qos_request *req;
  1659		unsigned int freq, perf_pct;
  1660	
  1661		struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
  1662		if (!policy)
  1663			return;
  1664	
  1665		req = policy->driver_data;
  1666		if (!req)
  1667			return;
  1668	
  1669		if (hwp_active)
  1670			intel_pstate_get_hwp_cap(cpudata);
  1671	
  1672		if (type == FREQ_QOS_MIN) {
  1673			perf_pct = global.min_perf_pct;
  1674		} else {
  1675			req++;
  1676			perf_pct = global.max_perf_pct;
  1677		}
  1678	
  1679		freq = DIV_ROUND_UP(cpudata->pstate.turbo_freq * perf_pct, 100);
  1680	
  1681		if (freq_qos_update_request(req, freq) < 0)
> 1682			pr_warn("Failed to update freq constraint: CPU%d\n", cpunum);
  1683	}
  1684	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

