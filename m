Return-Path: <linux-acpi+bounces-5891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 540958C9317
	for <lists+linux-acpi@lfdr.de>; Sun, 19 May 2024 01:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0251C20B26
	for <lists+linux-acpi@lfdr.de>; Sat, 18 May 2024 23:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F026CDBD;
	Sat, 18 May 2024 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrXP8Y4r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7A2BB10;
	Sat, 18 May 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716076702; cv=none; b=Pq6voGlXXn8VXfhaXuDdCeT+ZTqw+91vu1R9eYonRiJ4B0z+AYA4uru/kRPUMikUg6LFjpQ2tLOerklqBKwQX/8g0oXGp7222UX+hH+ulhXGrgrdGqESHUpFAGOhFeNtSf3o0KIE8J8oFmmsk61a6CZTeTWes6DGl8OrgFsoc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716076702; c=relaxed/simple;
	bh=hUuO83VTsg6Q0anihtSJN3ZBuP/mQUktYTTX0keTdOo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RnzuW3aCZdezdGjcpF6Z+UsOh2AHnZF8vjaPoHqJxhLWdAmv4IHLKn+ogmBaTWwUS1n77ACD4b233p0XYCy+uCzmHwplw45cvWibqxzp1xRVE9HQNv5jBIq7ANinxrBf6ind6xuZ0NIR6ju9tzOv7zOwgb1q7WdojfN8tv87woE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrXP8Y4r; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716076700; x=1747612700;
  h=date:from:to:cc:subject:message-id;
  bh=hUuO83VTsg6Q0anihtSJN3ZBuP/mQUktYTTX0keTdOo=;
  b=IrXP8Y4rOTPrqvEvOHevKsBYxkFr5R1YLqagh9MaqXC17um6lqb0vxu0
   pmWvkbcn3mSj2fvcnbmcS3Tso3bAa4wAa0y7p4a4XJd5LSkb+h/YzjE21
   pkF6ACvL2XPUZ3G4baCwy0Hnoga9b52NOus/5ar3pam27A/pxs6Kj+AtR
   9Qc+vlKsWY2p8KEdP3ys6MBfHp/KcyzTlPrGl/slWLuyrS50xXl8ffrrD
   Yd/VZQUzXT5ilLlqX79VmytIVDs2XV71NzCwnuiQGiC4EER75/m7EDP63
   +eVj6O/exv0rut7EUq+FUdE9BxCQ0uByS1QTonsYmYu9/6FpZAp2c241i
   A==;
X-CSE-ConnectionGUID: 7Yvfm2YFReiB/7wN7Xfn6w==
X-CSE-MsgGUID: yzOWMtw1TlKmdOebZHRjvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="12357169"
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="12357169"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 16:58:19 -0700
X-CSE-ConnectionGUID: pb4Z4KcaR/WZD8G7Kalx7Q==
X-CSE-MsgGUID: ZlCB4qoWSzOKMTxMlsg1QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="37068714"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 18 May 2024 16:58:17 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8TwL-0002kk-2J;
	Sat, 18 May 2024 23:58:14 +0000
Date: Sun, 19 May 2024 07:57:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 21a69bf121e949e34af454cceff48889016e4e41
Message-ID: <202405190747.667VFERD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 21a69bf121e949e34af454cceff48889016e4e41  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-161-20240518
    `-- drivers-opp-core.c-_opp_attach_genpd()-warn:missing-unwind-goto
clang_recent_errors
`-- i386-randconfig-141-20240518
    `-- drivers-opp-core.c-_opp_attach_genpd()-warn:missing-unwind-goto

elapsed time: 726m

configs tested: 180
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
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20240518   gcc  
arc                   randconfig-002-20240518   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                      footbridge_defconfig   clang
arm                           omap1_defconfig   gcc  
arm                   randconfig-001-20240518   gcc  
arm                   randconfig-002-20240518   clang
arm                   randconfig-003-20240518   gcc  
arm                   randconfig-004-20240518   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240518   clang
arm64                 randconfig-002-20240518   gcc  
arm64                 randconfig-003-20240518   clang
arm64                 randconfig-004-20240518   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240518   gcc  
csky                  randconfig-002-20240518   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240518   clang
hexagon               randconfig-002-20240518   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240518   gcc  
i386         buildonly-randconfig-002-20240518   gcc  
i386         buildonly-randconfig-003-20240518   gcc  
i386         buildonly-randconfig-004-20240518   clang
i386         buildonly-randconfig-005-20240518   clang
i386         buildonly-randconfig-006-20240518   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240518   clang
i386                  randconfig-002-20240518   clang
i386                  randconfig-003-20240518   gcc  
i386                  randconfig-004-20240518   gcc  
i386                  randconfig-005-20240518   clang
i386                  randconfig-006-20240518   gcc  
i386                  randconfig-011-20240518   gcc  
i386                  randconfig-012-20240518   clang
i386                  randconfig-013-20240518   clang
i386                  randconfig-014-20240518   gcc  
i386                  randconfig-015-20240518   clang
i386                  randconfig-016-20240518   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240518   gcc  
loongarch             randconfig-002-20240518   gcc  
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
nios2                 randconfig-001-20240518   gcc  
nios2                 randconfig-002-20240518   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240518   gcc  
parisc                randconfig-002-20240518   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      pasemi_defconfig   clang
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-001-20240518   clang
powerpc               randconfig-002-20240518   clang
powerpc               randconfig-003-20240518   clang
powerpc                      tqm8xx_defconfig   clang
powerpc64             randconfig-001-20240518   gcc  
powerpc64             randconfig-002-20240518   gcc  
powerpc64             randconfig-003-20240518   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240518   gcc  
riscv                 randconfig-002-20240518   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240518   clang
s390                  randconfig-002-20240518   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240518   gcc  
sh                    randconfig-002-20240518   gcc  
sh                           se7712_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240518   gcc  
sparc64               randconfig-002-20240518   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240518   clang
um                    randconfig-002-20240518   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240518   gcc  
x86_64       buildonly-randconfig-002-20240518   clang
x86_64       buildonly-randconfig-003-20240518   clang
x86_64       buildonly-randconfig-004-20240518   clang
x86_64       buildonly-randconfig-005-20240518   clang
x86_64       buildonly-randconfig-006-20240518   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240518   clang
x86_64                randconfig-002-20240518   clang
x86_64                randconfig-003-20240518   gcc  
x86_64                randconfig-004-20240518   gcc  
x86_64                randconfig-005-20240518   gcc  
x86_64                randconfig-006-20240518   clang
x86_64                randconfig-011-20240518   gcc  
x86_64                randconfig-012-20240518   gcc  
x86_64                randconfig-013-20240518   clang
x86_64                randconfig-014-20240518   gcc  
x86_64                randconfig-015-20240518   clang
x86_64                randconfig-016-20240518   clang
x86_64                randconfig-071-20240518   clang
x86_64                randconfig-072-20240518   clang
x86_64                randconfig-073-20240518   gcc  
x86_64                randconfig-074-20240518   clang
x86_64                randconfig-075-20240518   gcc  
x86_64                randconfig-076-20240518   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240518   gcc  
xtensa                randconfig-002-20240518   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

