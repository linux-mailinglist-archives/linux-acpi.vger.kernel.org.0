Return-Path: <linux-acpi+bounces-11292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C6FA3AE35
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 02:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8CD174BED
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 00:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB6188915;
	Wed, 19 Feb 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3ly70/L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73861586C8;
	Wed, 19 Feb 2025 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926199; cv=none; b=P9Hpk+I7qLGQs2xR/OFZdkj/iGI9NnJYlNwQ5tWAT3UXqJJ0gb6vvx5KEdTKuhsK1gjHMu4cpVCKAHg3z0K8nXnhhIRe5YfLYMvZunbicg2w84PiTPmdtOVigY2bHBKM9WR5b9Nx4+lwhYFiqfhuhxuyPqYTIY+r1fRo5JhBKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926199; c=relaxed/simple;
	bh=dumTvUndBSryUUDTLTujFZVtVAOLspRBJFBD7RWq3lo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LleBQduWlZfG1IC9qLF8YguRbXDlrFhTPNb6SPIwY4Zrr9jUnY9W5j46+4tRG0TkIUUXuOTIxL86l0K0W906AiKAUP7sJcOwpuhA2ECFS9bjKnZH/X11SB7klI+4x8zXwX6y+qDOkWe87FnIhtOG8Bo0mRtmgIz9xg9Cuh39Aa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3ly70/L; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739926196; x=1771462196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dumTvUndBSryUUDTLTujFZVtVAOLspRBJFBD7RWq3lo=;
  b=K3ly70/LbWwdE6m1uzzZbTBO3Fa1o9ovg5F/6eEbdwkkzViB1khxyy61
   y43hbLPn5tamEMBiDknqtgPEq0N57HFAFnRywiL7zReFBthJ/7aQa2jRQ
   DKQ/IzwKDpBIQkS6k+jpqZZ6R00TW4ou6MSmpyUh1b6Na5EKYAJbn5xxz
   Onmn39toLPEnkFtn/xbRpAfkcGktOs9/En6463LCGC7OgWh00x1X5P/lN
   oSkbX8xR+xksD/TOKKCL5CSqAVwjgXD3cTTX1cnVgf2FKG7MqArL9dnZl
   N70hkY6jcli0R4RBWwZc97D7pCfUnpb9UjulXhmQgUgaiW8bTEZ3usCtF
   Q==;
X-CSE-ConnectionGUID: R1DMhf46R2a9ySq5mrNM8w==
X-CSE-MsgGUID: BoByIpSjRq2eHfiyRTVsAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="52052226"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="52052226"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 16:49:56 -0800
X-CSE-ConnectionGUID: OHctPmUKSpmGPClLPr5O/w==
X-CSE-MsgGUID: mOWMx+9+S2OXrK5WruD0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="115078694"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 18 Feb 2025 16:49:54 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkYHe-00012K-22;
	Wed, 19 Feb 2025 00:49:51 +0000
Date: Wed, 19 Feb 2025 08:49:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [rafael-pm:pm-sleep-testing 5/6] include/linux/device.h:1030:20:
 error: no member named 'smart_suspend' in 'struct dev_pm_info'
Message-ID: <202502190811.rtTycxxZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-sleep-testing
head:   e0d95f1b2b755e2cd05b11dcddabb6cab24a041b
commit: d7aa9525f39c3c2f5520db30b40edb9c8f13774e [5/6] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
config: i386-buildonly-randconfig-004-20250219 (https://download.01.org/0day-ci/archive/20250219/202502190811.rtTycxxZ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502190811.rtTycxxZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502190811.rtTycxxZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
>> include/linux/device.h:1030:20: error: no member named 'smart_suspend' in 'struct dev_pm_info'
    1030 |         return dev->power.smart_suspend;
         |                ~~~~~~~~~~ ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:102: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=654645659
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1264: prepare0] Error 2 shuffle=654645659
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=654645659
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=654645659
   make: Target 'prepare' not remade because of errors.


vim +1030 include/linux/device.h

  1027	
  1028	static inline bool dev_pm_smart_suspend(struct device *dev)
  1029	{
> 1030		return dev->power.smart_suspend;
  1031	}
  1032	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

