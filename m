Return-Path: <linux-acpi+bounces-19919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48518CECCB1
	for <lists+linux-acpi@lfdr.de>; Thu, 01 Jan 2026 04:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 843FE3000EA9
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jan 2026 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88320DD48;
	Thu,  1 Jan 2026 03:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTFTw3bj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DB2C181;
	Thu,  1 Jan 2026 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767239369; cv=none; b=Aax5t2fxpqOUv6ulfZ5uu/XeReP3NwXDYZ8pBjTIk6ZckIsRoknIiTITmhBPZGmW7uFKHfTNAFkRhdghwbiwdVb70Zj6MqgLs/Wb7FbR8Xy9MpIlOAFPBJRRMqvYr/484lp2enibqsRunj9LnZSu3j9EJcHpS6QtheXDZtHJnUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767239369; c=relaxed/simple;
	bh=1sTaYu5maZYYp5Tn4/bX5HWP/0gbz500XijtDaG9+bk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rMtMWg9yoX3PDblq1nEXuTZhuYDFdztxZgd+UqSvCg4Z12S/SPxhRhcNsKiTmijZlVEASIrmK+R4+4HNmhg3nDSaFi9B7t0DL4eRMby43LyQky57xBK6FWgo3XW1NKVdCX8M3On5PwmHdr5jJOm4OBkmkS3T7S0UKR6ZtJ+BIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTFTw3bj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767239368; x=1798775368;
  h=date:from:to:cc:subject:message-id;
  bh=1sTaYu5maZYYp5Tn4/bX5HWP/0gbz500XijtDaG9+bk=;
  b=dTFTw3bjrr+u5uqPm4DOJPZOPfQQWjYHja3VegMIiCzRMsBTu59+fBxA
   RsciOjnHs/2zcDduDcqTBUp4qTVAih9Wshr7Y+bzC3B0WcQC0bCso1Fj/
   tgc58Zbh7UarLtCCw5KyYR6/Fu+9bWcUOUxQ+a66Tn+ScK67b+gS3x4md
   Dii78+I86nZJ6Qlfb+altxQp5wo3snO6Dj+4ByLtwlaMM2rWbqLJjqPo8
   peo13/QzxZyVVYDoNFDnzq3+3w0mW0bgwVLHg6aVxgDNeWJZleH2pEwwj
   tFipVkLDhMtRnClXZU3Ut0FybKBaBAR5wDkElIDgtrb63wgbWZCjL+Mj2
   Q==;
X-CSE-ConnectionGUID: sW4BXSkyQlKI8eRi5VAK+w==
X-CSE-MsgGUID: ht6k8RQwTQmPzWWraWxonQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68831903"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68831903"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 19:49:27 -0800
X-CSE-ConnectionGUID: cWBFAkmfS4CxBznvKfVE0g==
X-CSE-MsgGUID: +dZi8eIvSeuOqYddKxAnbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="206605297"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 31 Dec 2025 19:49:25 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vb9gg-000000001eN-3dgM;
	Thu, 01 Jan 2026 03:49:22 +0000
Date: Thu, 01 Jan 2026 11:48:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:pm-runtime-cleanup 23/23]
 drivers/clk/tegra/clk-device.c:178:2: error: incompatible function pointer
 types initializing 'int (*)(struct device *)' with an expression of type
 'void (*)(struct device *)'
Message-ID: <202601011126.sozHuNJ1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-runtime-cleanup
head:   93098b331b83758601e6a4c26bbc773de1bd21cd
commit: 93098b331b83758601e6a4c26bbc773de1bd21cd [23/23] PM: runtime: Change pm_runtime_put() return type to void
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260101/202601011126.sozHuNJ1-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260101/202601011126.sozHuNJ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601011126.sozHuNJ1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/tegra/clk-device.c:178:2: error: incompatible function pointer types initializing 'int (*)(struct device *)' with an expression of type 'void (*)(struct device *)' [-Wincompatible-function-pointer-types]
     178 |         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:345:2: note: expanded from macro 'SET_SYSTEM_SLEEP_PM_OPS'
     345 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:316:12: note: expanded from macro 'SYSTEM_SLEEP_PM_OPS'
     316 |         .resume = pm_sleep_ptr(resume_fn), \
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:474:28: note: expanded from macro 'pm_sleep_ptr'
     474 | #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:27: note: expanded from macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/tegra/clk-device.c:178:2: error: incompatible function pointer types initializing 'int (*)(struct device *)' with an expression of type 'void (*)(struct device *)' [-Wincompatible-function-pointer-types]
     178 |         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:345:2: note: expanded from macro 'SET_SYSTEM_SLEEP_PM_OPS'
     345 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:318:10: note: expanded from macro 'SYSTEM_SLEEP_PM_OPS'
     318 |         .thaw = pm_sleep_ptr(resume_fn), \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:474:28: note: expanded from macro 'pm_sleep_ptr'
     474 | #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:27: note: expanded from macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/tegra/clk-device.c:178:2: error: incompatible function pointer types initializing 'int (*)(struct device *)' with an expression of type 'void (*)(struct device *)' [-Wincompatible-function-pointer-types]
     178 |         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:345:2: note: expanded from macro 'SET_SYSTEM_SLEEP_PM_OPS'
     345 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:320:13: note: expanded from macro 'SYSTEM_SLEEP_PM_OPS'
     320 |         .restore = pm_sleep_ptr(resume_fn),
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:474:28: note: expanded from macro 'pm_sleep_ptr'
     474 | #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:27: note: expanded from macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   3 errors generated.


vim +178 drivers/clk/tegra/clk-device.c

b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  169  
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  170  /*
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  171   * Tegra GENPD driver enables clocks during NOIRQ phase. It can't be done
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  172   * for clocks served by this driver because runtime PM is unavailable in
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  173   * NOIRQ phase. We will keep clocks resumed during suspend to mitigate this
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  174   * problem. In practice this makes no difference from a power management
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  175   * perspective since voltage is kept at a nominal level during suspend anyways.
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  176   */
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  177  static const struct dev_pm_ops tegra_clock_pm = {
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01 @178  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  179  };
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  180  

:::::: The code at line 178 was first introduced by commit
:::::: b1bc04a2ac5b15e0b681228376664671fc2f2017 clk: tegra: Support runtime PM and power domain

:::::: TO: Dmitry Osipenko <digetx@gmail.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

