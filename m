Return-Path: <linux-acpi+bounces-5876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC758C808E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 07:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB247B2153C
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 05:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA034DDCD;
	Fri, 17 May 2024 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aotaz1h3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E87DDB2;
	Fri, 17 May 2024 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715922775; cv=none; b=VAFoa58YZ/ggZ0Zdr2VHXJsN56nnD3ALqiIHqlC0t5MXruX4cpetGpdjaydJOh0/oFc45e0v6l5vOVxO7mzmqrsNz2hT6jRg2hmLBmkAdo0EQRHIVrkjEUUU5ycxa2t9V+p0lrCuikjgMXV/v5510ewKtmvGg/zhuQDipR5IoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715922775; c=relaxed/simple;
	bh=kiBS0aH330Di4zZ+gpV8po31YLr1t7R4+LdaL7EeF1Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zakh7zTonKupvbQS7nWS1QL7U8PlkFGC45RTVm8USxvAWplC2FzxAKp8/ZqxD2p2pRhMjaReo9wndpJGY3kkZP9OjRaqagOUdfrsC2CnijhAuSktDLa5r2lIsM2TmytNciVWzVxHNNfHNOFrbwQBUiHCPegmxKODvKXHCqEejKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aotaz1h3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715922774; x=1747458774;
  h=date:from:to:cc:subject:message-id;
  bh=kiBS0aH330Di4zZ+gpV8po31YLr1t7R4+LdaL7EeF1Y=;
  b=Aotaz1h34bhSa++vwoO3ZE+keIxE36Sj0mIso/Kbkpr1HBn9hxM0eM/h
   q2wIZiTOjhVaUCIvQTENf7M8ANuA1Ab8+fJkgTEm10lchtH28G1ReL45O
   +h0X97BaXX9RI4ZKDQkI11F6l3KgDHt58jdoyqAurfPHURM59X46+yk1/
   RKV7rvAcCzRPg4RlRl1pfuR3OWbcb5rKMkbBIOnhzXZrSEZTUrmmm3pM/
   hq62WsaAPYBgaPRtDj2P2Wz9PUbDW26t6y0KcWwj7LhjFVzNtYXuXzRtz
   AjqeFCJ7HwUGvdOnjg7yqcd5dn5+/1Qnk7wE1qil32vHA9IT2+WNCqZSc
   w==;
X-CSE-ConnectionGUID: VrYNYxZBSEK5jsO/vmnL9A==
X-CSE-MsgGUID: THjM1BUrS4+ott4x8TnHIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12292768"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="12292768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 22:12:53 -0700
X-CSE-ConnectionGUID: GtT2If2iSTGg1zMN7UtQaQ==
X-CSE-MsgGUID: AabyUUdgQ0Wn2vog/51Iyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="32272004"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 16 May 2024 22:12:48 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7pst-0000FI-1K;
	Fri, 17 May 2024 05:12:27 +0000
Date: Fri, 17 May 2024 13:10:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 eb06f2e32acbd9763bd9081c28ed9b133c3dfc1a
Message-ID: <202405171340.Y8MtvL3f-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: eb06f2e32acbd9763bd9081c28ed9b133c3dfc1a  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 729m

configs tested: 160
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
arc                   randconfig-001-20240517   gcc  
arc                   randconfig-002-20240517   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                      jornada720_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-001-20240517   clang
arm                   randconfig-002-20240517   clang
arm                   randconfig-003-20240517   clang
arm                   randconfig-004-20240517   clang
arm                         s5pv210_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240517   clang
arm64                 randconfig-002-20240517   gcc  
arm64                 randconfig-003-20240517   clang
arm64                 randconfig-004-20240517   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240517   gcc  
csky                  randconfig-002-20240517   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240517   clang
hexagon               randconfig-002-20240517   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240517   clang
i386         buildonly-randconfig-002-20240517   clang
i386         buildonly-randconfig-003-20240517   gcc  
i386         buildonly-randconfig-004-20240517   clang
i386         buildonly-randconfig-005-20240517   clang
i386         buildonly-randconfig-006-20240517   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240517   gcc  
i386                  randconfig-002-20240517   gcc  
i386                  randconfig-003-20240517   gcc  
i386                  randconfig-004-20240517   gcc  
i386                  randconfig-005-20240517   gcc  
i386                  randconfig-006-20240517   gcc  
i386                  randconfig-011-20240517   gcc  
i386                  randconfig-012-20240517   clang
i386                  randconfig-013-20240517   gcc  
i386                  randconfig-014-20240517   gcc  
i386                  randconfig-015-20240517   clang
i386                  randconfig-016-20240517   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240517   gcc  
loongarch             randconfig-002-20240517   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240517   gcc  
nios2                 randconfig-002-20240517   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240517   gcc  
parisc                randconfig-002-20240517   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                      mgcoge_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc               randconfig-001-20240517   clang
powerpc               randconfig-002-20240517   clang
powerpc               randconfig-003-20240517   gcc  
powerpc64             randconfig-001-20240517   gcc  
powerpc64             randconfig-002-20240517   gcc  
powerpc64             randconfig-003-20240517   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240517   clang
riscv                 randconfig-002-20240517   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240517   clang
s390                  randconfig-002-20240517   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240517   gcc  
sh                    randconfig-002-20240517   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240517   gcc  
sparc64               randconfig-002-20240517   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240517   clang
um                    randconfig-002-20240517   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240517   clang
x86_64       buildonly-randconfig-002-20240517   gcc  
x86_64       buildonly-randconfig-003-20240517   clang
x86_64       buildonly-randconfig-005-20240517   gcc  
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240517   gcc  
xtensa                randconfig-002-20240517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

