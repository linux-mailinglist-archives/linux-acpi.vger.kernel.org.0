Return-Path: <linux-acpi+bounces-4988-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF48A3AC4
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Apr 2024 05:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AC91C22CEB
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Apr 2024 03:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C4F199B0;
	Sat, 13 Apr 2024 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmRmgKPu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500D1BDCD;
	Sat, 13 Apr 2024 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979899; cv=none; b=OHmvSjjucgmZovI95wk2EaqRRUUKYmb80jhH6RKn0HPTLdQBZEZl9HnkOZs0gigGEf+nWdaKHfhzHhU+twKnT7Dg075p4JbIG1EWcZMuuCZef3PREP0aBhzvQHwSpnP2ZrJSyO2k5mHnJfNlCabaNf2JnJJTBhUQ18IwuoHoZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979899; c=relaxed/simple;
	bh=2Y3d18tWZk8W3Xv9C8xq8guEZynXeCFEYI/QaTo+5bQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OTafcqFdyJpxpn0h9rl0eXOQreoJfOb6CgLfhPTOKFvX4kuuo4Bp72g1bW8f2p+ilDW0ztDrut1VH+ISZH2Kxcx26LrhzW91CYnkK+zthUukxaLTiiqXqYojk7woEMBIoHnJBa2epJZhbBGCGnGRV6n3jIoKmsVFm33/CZJLuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmRmgKPu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712979898; x=1744515898;
  h=date:from:to:cc:subject:message-id;
  bh=2Y3d18tWZk8W3Xv9C8xq8guEZynXeCFEYI/QaTo+5bQ=;
  b=SmRmgKPuaSAUjAlAw6xGD20LRSoa6PDm0vJ/2fGXU0EKzHzd1Dm9F9d7
   2FnyFIY1LuDxHtFwUhiL7sNHZd1Rcm7E5nWjFooPJuP2I+ddP5xmw7ZRA
   GKhrViUJncK3Kg4UVLJQOefIywwxQuExp6Cu53IwhhWSdopadJifNrU+J
   hUpt8XIMZjiXZb9JZu569n67o0zCRcahRd5W4kA3LYHUdYe+nGQylgpA9
   LlSkjhr5Xu0Jf/NEp36OXGPKskquJXe4IAG7IRToRdGZerx9s8vESrAFb
   4Loxx7XxY09Dtn8UzLyIWMulyOtjkoyiy2Trow0Z6k9U2DHsnXgfwZeJ/
   Q==;
X-CSE-ConnectionGUID: +Tx1jlO3SGiCrNYphRulnA==
X-CSE-MsgGUID: 99CyY2cdSOaCxLw1CH7dDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12294834"
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="12294834"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 20:44:58 -0700
X-CSE-ConnectionGUID: 3KiEOu9gRC+tyNDFl/vGLA==
X-CSE-MsgGUID: R3l5J5hTSIaAXQIeGJX3Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="52362005"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 12 Apr 2024 20:44:56 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvUJx-0001do-10;
	Sat, 13 Apr 2024 03:44:53 +0000
Date: Sat, 13 Apr 2024 11:43:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bb01190ed522c30fcf1f0e5312fa2726c84d6535
Message-ID: <202404131125.yWEobpT5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bb01190ed522c30fcf1f0e5312fa2726c84d6535  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 911m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240412   gcc  
arc                   randconfig-001-20240413   gcc  
arc                   randconfig-002-20240412   gcc  
arc                   randconfig-002-20240413   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240412   gcc  
arm                   randconfig-001-20240413   clang
arm                   randconfig-002-20240412   clang
arm                   randconfig-003-20240412   clang
arm                   randconfig-004-20240412   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240412   gcc  
arm64                 randconfig-002-20240412   gcc  
arm64                 randconfig-003-20240412   clang
arm64                 randconfig-004-20240412   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240412   gcc  
csky                  randconfig-002-20240412   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240412   clang
hexagon               randconfig-002-20240412   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240412   gcc  
i386         buildonly-randconfig-001-20240413   gcc  
i386         buildonly-randconfig-002-20240412   clang
i386         buildonly-randconfig-002-20240413   gcc  
i386         buildonly-randconfig-003-20240412   gcc  
i386         buildonly-randconfig-003-20240413   clang
i386         buildonly-randconfig-004-20240412   gcc  
i386         buildonly-randconfig-004-20240413   clang
i386         buildonly-randconfig-005-20240412   gcc  
i386         buildonly-randconfig-005-20240413   clang
i386         buildonly-randconfig-006-20240412   gcc  
i386         buildonly-randconfig-006-20240413   clang
i386                                defconfig   clang
i386                  randconfig-001-20240412   clang
i386                  randconfig-001-20240413   clang
i386                  randconfig-002-20240412   gcc  
i386                  randconfig-002-20240413   gcc  
i386                  randconfig-003-20240413   clang
i386                  randconfig-004-20240413   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240412   gcc  
loongarch             randconfig-002-20240412   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240412   gcc  
nios2                 randconfig-002-20240412   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240412   gcc  
parisc                randconfig-002-20240412   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240412   clang
powerpc               randconfig-002-20240412   clang
powerpc               randconfig-003-20240412   gcc  
powerpc64             randconfig-001-20240412   gcc  
powerpc64             randconfig-002-20240412   gcc  
powerpc64             randconfig-003-20240412   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240412   clang
riscv                 randconfig-002-20240412   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240412   gcc  
s390                  randconfig-002-20240412   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240412   gcc  
sh                    randconfig-002-20240412   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240412   gcc  
sparc64               randconfig-002-20240412   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240412   clang
um                    randconfig-002-20240412   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240413   gcc  
x86_64       buildonly-randconfig-002-20240413   gcc  
x86_64       buildonly-randconfig-003-20240413   gcc  
x86_64       buildonly-randconfig-004-20240413   gcc  
x86_64       buildonly-randconfig-005-20240413   gcc  
x86_64       buildonly-randconfig-006-20240413   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240413   gcc  
x86_64                randconfig-002-20240413   gcc  
x86_64                randconfig-003-20240413   gcc  
x86_64                randconfig-004-20240413   gcc  
x86_64                randconfig-005-20240413   gcc  
x86_64                randconfig-006-20240413   gcc  
x86_64                randconfig-011-20240413   clang
x86_64                randconfig-012-20240413   clang
x86_64                randconfig-013-20240413   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240412   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

