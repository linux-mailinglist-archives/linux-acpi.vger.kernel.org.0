Return-Path: <linux-acpi+bounces-3311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E099384EFF4
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 06:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E4128A065
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 05:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD556B86;
	Fri,  9 Feb 2024 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOHRWBu6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE364F88F;
	Fri,  9 Feb 2024 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707456920; cv=none; b=Gpv38xWLNWc48Ec4UJSB6watLbSJQPmeGkpkNQ823O8n6LQYVcWc5PPQ/3pmC8jY6q3LvGDt8NX7jxAEHV2ug/4UdK8+98wrRIyrQz94DmtEF7RoPgc33Ej9UH0pbEgSvkPJ//D13P5ZhuQIDApiHm9Pw99mMBtVfnTykB2EMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707456920; c=relaxed/simple;
	bh=KhUdmBsyvqeWDNdN1IUYSknTqQGmjH28s7sp44FAXn4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QFsyI0IW2obh6nTWNXt7ckbSq/oPqGi2s16cYfwtsOtcIFWflu28OR4x3YvXgwPhx1kiRidEMGuIDAT+63ZYTdekdn5n1mpDa+O7jgFNUDY9YEdFD4XQLc/jJzGoPlBcGidou5giOlLjpfQwCQwo7qEbI/aWjY/KDWC4SUPl6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOHRWBu6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707456917; x=1738992917;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KhUdmBsyvqeWDNdN1IUYSknTqQGmjH28s7sp44FAXn4=;
  b=hOHRWBu6dfMH435Xfh4w1oS7XnVtaFG7L0FzrckYrxbJuJqeYPebJMH8
   +q4yV8xoUxOirZptbFQOVzgPqWIR2ROXF95LaoLvPzNy00NUPcrrXv8yN
   XG5tYOi3dxoK971QGKua5L9kkbwaWYy2bRBvNsGbnSv95MLERIXBz/cC2
   flDwAx/0HTtmEepmPXf9cJUW7JEnelGGQ+HOsr12zTOMUziFVFb/voUEu
   aQFbGoyMq/c3rpWHFpt5Vat2FTMbiRx752pZlhvzbE4dKgGZ/1+sG2wuh
   U4G45za3GxoPMbhQva9vd/oqrkesdlS5llpXomLA/qF1LU62tGH3thxdO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12453787"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="12453787"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 21:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32650935"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 21:35:15 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYJXc-0004Qg-0T;
	Fri, 09 Feb 2024 05:35:12 +0000
Date: Fri, 9 Feb 2024 13:34:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 74/77] drivers/thermal/thermal_of.c:444:34:
 error: initializing 'struct thermal_zone_device_ops *' with an expression of
 incompatible type 'struct thermal_zone_device_ops'; take the address with &
Message-ID: <202402091355.DUYRncj7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   976b96a64c53e1e3d0fa71c97be2bcbe1a64feb1
commit: c483d4c88bfcd98d7819a722f48edb0adb89c32f [74/77] thermal: core: Store zone ops in struct thermal_zone_device
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240209/202402091355.DUYRncj7-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240209/202402091355.DUYRncj7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402091355.DUYRncj7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/thermal/thermal_of.c:444:34: error: initializing 'struct thermal_zone_device_ops *' with an expression of incompatible type 'struct thermal_zone_device_ops'; take the address with &
           struct thermal_zone_device_ops *ops = tz->ops;
                                           ^     ~~~~~~~
                                                 &
   1 error generated.


vim +444 drivers/thermal/thermal_of.c

3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  432  
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  433  /**
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  434   * thermal_of_zone_unregister - Cleanup the specific allocated ressources
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  435   *
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  436   * This function disables the thermal zone and frees the different
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  437   * ressources allocated specific to the thermal OF.
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  438   *
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  439   * @tz: a pointer to the thermal zone structure
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  440   */
ac614a9b4c35bf Daniel Lezcano 2023-04-04  441  static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  442  {
8fb5b71ed37dbe Daniel Lezcano 2022-08-09  443  	struct thermal_trip *trips = tz->trips;
8fb5b71ed37dbe Daniel Lezcano 2022-08-09 @444  	struct thermal_zone_device_ops *ops = tz->ops;
8fb5b71ed37dbe Daniel Lezcano 2022-08-09  445  
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  446  	thermal_zone_device_disable(tz);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  447  	thermal_zone_device_unregister(tz);
8fb5b71ed37dbe Daniel Lezcano 2022-08-09  448  	kfree(trips);
8fb5b71ed37dbe Daniel Lezcano 2022-08-09  449  	kfree(ops);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  450  }
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  451  

:::::: The code at line 444 was first introduced by commit
:::::: 8fb5b71ed37dbe469eaa930e2ddc93ec9e305f3c thermal/of: Fix free after use in thermal_of_unregister()

:::::: TO: Daniel Lezcano <daniel.lezcano@linaro.org>
:::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

