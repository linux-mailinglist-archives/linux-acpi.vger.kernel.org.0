Return-Path: <linux-acpi+bounces-12987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9DCA86A78
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Apr 2025 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144F97B4355
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Apr 2025 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9613632B;
	Sat, 12 Apr 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3mRnYjP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C3A125D6;
	Sat, 12 Apr 2025 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425444; cv=none; b=Oz075sqZlNGtP+sKXqHfbQlLkW9THd8aYDddqm9liLIlDhPDbki9R9ABu6Rz72wxzZ8GJdQBAGT+LdOScs48Wl+UgjiHswkxqf02iiUbxoxjYEqLpXVqLj4jspiw0d3z0Lg6/wrwtIewiUzei+Hom4zBJ1UB0KPhnViebRxAYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425444; c=relaxed/simple;
	bh=0ayBwoV8AYxDtvLvJrFXVLxv7jWsvYxEm31iguCyoiM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NPuXBp/YHD3FLF/EtxukjITtBPw6u5fFclMvHJtNH7n3BL2l2H+njd0nMsNA9ziceNMVwLyEhRZmicxnr9o12HUrlMB4UrSlElGuuFU0lpICr6UO4/v8xc4yGGajBlRgC3TCStwy8x06ruWVDEiebHuZZXaEAuBf8kfESWRcPLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3mRnYjP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744425443; x=1775961443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0ayBwoV8AYxDtvLvJrFXVLxv7jWsvYxEm31iguCyoiM=;
  b=P3mRnYjPb/ZRJZLOhAiJDvAX0VW2EZ3D3q4zl4Rol70d6d/RL2Wd43aO
   6a7hMovhBh9ckLXSLvQcTXVe5QNqKzFBvr9b9Qf7PUQa7Hw06JrW1u3D0
   rEWiwpWY+8xpD2erXy7un/qVs6LpR5jVOgfN6gUXnIqPCBw7WY7px1wQ1
   TREKaCckqmrdHKVX3tKsbUw4zWSt9Nmu9qhZJvUFeipUFOyWORpOyBVgZ
   EaeUrSPCpC1caWHWubgpS6kZIHUQ7pc5YJgSsNudyo0DHWYu/GK7pXBwz
   qAz5ShUyLwPH/xCwSx/NWDUcxrLPkPBAit7b8mdD3PG/dheYDlOQYscQX
   Q==;
X-CSE-ConnectionGUID: SBzYiBXcQhCnCMhOct8mgA==
X-CSE-MsgGUID: //fZ0ct5RFypymOSyQhS4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="71365411"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="71365411"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 19:37:22 -0700
X-CSE-ConnectionGUID: G1klJNWoTV+dsOP2kz7zZQ==
X-CSE-MsgGUID: QHoBTdAsRqqsBVM55JMGSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129346852"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Apr 2025 19:37:20 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3Qk9-000BWQ-39;
	Sat, 12 Apr 2025 02:37:17 +0000
Date: Sat, 12 Apr 2025 10:36:41 +0800
From: kernel test robot <lkp@intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 44/52]
 drivers/cpuidle/cpuidle-psci.c:437:54: error: expected identifier
Message-ID: <202504121050.dgHmFeWe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   605857f6c52205d83a7963edbdfaaa307ee7bde4
commit: a60e3d71e4d49a9be9fa5fc3cb9c4942e29fd934 [44/52] cpuidle: psci: Transition to the faux device interface
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250412/202504121050.dgHmFeWe-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504121050.dgHmFeWe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504121050.dgHmFeWe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cpuidle/cpuidle-psci.c:437:54: error: expected identifier
     437 | module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);
         |                                                      ^
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
       8 | #define NULL ((void *)0)
         |              ^
>> drivers/cpuidle/cpuidle-psci.c:437:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     437 | module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);
         | ^
         | int
>> drivers/cpuidle/cpuidle-psci.c:437:19: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
     437 | module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);
         |                   ^                                            
         |                                                                void
   3 errors generated.


vim +437 drivers/cpuidle/cpuidle-psci.c

   436	
 > 437	module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

