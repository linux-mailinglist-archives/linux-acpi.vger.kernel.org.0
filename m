Return-Path: <linux-acpi+bounces-19921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB33CED5A6
	for <lists+linux-acpi@lfdr.de>; Thu, 01 Jan 2026 22:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F4D93004F2E
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jan 2026 21:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127522F5487;
	Thu,  1 Jan 2026 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjdRhzbf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10229A9FE;
	Thu,  1 Jan 2026 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767301856; cv=none; b=cLcEywQN7uvZNx5h8dsVOcmn0EI+Mz2RE3Zw/vRUu7ecqF7lx7E5uhQ/ErlXMmkZMdf4x+5o7+cmi49Wyaxcq745duno3RjU7j8HxHat2FPvhu4QT+eWy3izadCd26kNn6tSI+p+iNcxzsV6vYPCW3MpB98ZnejIooNzqdyqfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767301856; c=relaxed/simple;
	bh=86Ln23Vif1EKGE44X2NHTBz/d6s9wpGgmLDrlpyXVVI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G0XbKSNJ0sEearNiCLTY4x8i3Yju815uf/T2JQlBeroN4FstXOxbMYAnRP4x6LvHZ6SV094uaPsk5ROQOi9gjZ8MfvEZiA9AuuxEaSZ0f0s6m+DMXSrkKM0OAsHRnGeRkdbe49/2QcQxHeCwFHO6w6NHtsBmTfwI2bW+AUJZvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjdRhzbf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767301854; x=1798837854;
  h=date:from:to:cc:subject:message-id;
  bh=86Ln23Vif1EKGE44X2NHTBz/d6s9wpGgmLDrlpyXVVI=;
  b=OjdRhzbfSe+TtHxpCcex+/2BW13/1G/kEmfk1vQ5+0ETADfgRUzv/WaP
   h+RFMhSX6WgYvEZ2gLtqVhcJgcRNkDK+WoQSFHdkzdtBz199a4SvBN673
   36g/unBtA+nUy1BloQ2E8INZhvi5miw7J26mEgeopxrQxbnjOLegvY4Iu
   H0e4nH7VXIrVll74HphNSK91QWV50/xTSOVk+0cehJ7O5zC8OnA34Z0M1
   6QBvgu+ZG4sPn/e7lb/E33J7E746NcN/bf5JkpQ8WQQ82xO1qi85GTs/L
   prNzQedy/YGImskfqAtH0c+Lykl7g8PS4HmuWrWh2GZFVPyGE8spabzoq
   A==;
X-CSE-ConnectionGUID: x+xhttWXSf6dYg9hCJeC6A==
X-CSE-MsgGUID: 2KdzsfeURiGpJASXzolgMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68887518"
X-IronPort-AV: E=Sophos;i="6.21,195,1763452800"; 
   d="scan'208";a="68887518"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2026 13:10:50 -0800
X-CSE-ConnectionGUID: QzA3NkI2T5W/gNTprPAskQ==
X-CSE-MsgGUID: RR9UNWXKTPuHI4wrKaUowA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,195,1763452800"; 
   d="scan'208";a="200914602"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 01 Jan 2026 13:10:49 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vbPwT-00000000225-3kPY;
	Thu, 01 Jan 2026 21:10:45 +0000
Date: Fri, 02 Jan 2026 05:10:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:pm-runtime-cleanup 24/25]
 drivers/clk/tegra/clk-device.c:178:2: error: expected function body after
 function declarator
Message-ID: <202601020507.LzWANVpm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-runtime-cleanup
head:   e853e6ed1e01eb6846357d4692bf6131e218837e
commit: a7e9532f30c77611ad48560b165326ce96e6e8dc [24/25] clk: tegra: Discard pm_runtime_put() return value
config: arm-defconfig (https://download.01.org/0day-ci/archive/20260102/202601020507.LzWANVpm-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260102/202601020507.LzWANVpm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601020507.LzWANVpm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/tegra/clk-device.c:178:2: error: expected function body after function declarator
     178 |         return pm_runtime_resume_and_get(dev);
         |         ^
>> drivers/clk/tegra/clk-device.c:179:1: error: extraneous closing brace ('}')
     179 | }
         | ^
>> drivers/clk/tegra/clk-device.c:188:26: error: use of undeclared identifier 'tegra_clock_suspend'
     188 |         SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, tegra_clock_resume)
         |                                 ^~~~~~~~~~~~~~~~~~~
>> drivers/clk/tegra/clk-device.c:188:26: error: use of undeclared identifier 'tegra_clock_suspend'
     188 |         SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, tegra_clock_resume)
         |                                 ^~~~~~~~~~~~~~~~~~~
>> drivers/clk/tegra/clk-device.c:188:26: error: use of undeclared identifier 'tegra_clock_suspend'
     188 |         SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, tegra_clock_resume)
         |                                 ^~~~~~~~~~~~~~~~~~~
   5 errors generated.


vim +178 drivers/clk/tegra/clk-device.c

   169	
   170	/*
   171	 * Tegra GENPD driver enables clocks during NOIRQ phase. It can't be done
   172	 * for clocks served by this driver because runtime PM is unavailable in
   173	 * NOIRQ phase. We will keep clocks resumed during suspend to mitigate this
   174	 * problem. In practice this makes no difference from a power management
   175	 * perspective since voltage is kept at a nominal level during suspend anyways.
   176	 */
   177	static inline int tegra_clock_suspend(struct device *dev)
 > 178		return pm_runtime_resume_and_get(dev);
 > 179	}
   180	
   181	static inline int tegra_clock_resume(struct device *dev)
   182	{
   183		pm_runtime_put(dev);
   184		return 0;
   185	}
   186	
   187	static const struct dev_pm_ops tegra_clock_pm = {
 > 188		SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, tegra_clock_resume)
   189	};
   190	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

