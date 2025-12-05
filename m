Return-Path: <linux-acpi+bounces-19459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41434CA9487
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 21:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5559306BD5F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 20:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198B72C2365;
	Fri,  5 Dec 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nN4h9oNo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B529BD82;
	Fri,  5 Dec 2025 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764967224; cv=none; b=Gcn51a7I7Zxy0qH5ntGbss3uY5wKXAFf0WyblGpSslSxAUULFoxjKHKnvb0SB3ufNr88tOdINe0gMoodD+vctw3sWIF/pKQlZEF6imJ5/viTEAJmQV+muM1GlGksKDrck/nyP9RLjZ8TGU1Ho4BKBSc1c+ASNkcjjVtYwIPZLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764967224; c=relaxed/simple;
	bh=uqtzVnHsKXAZKN8K0hdC/i1EofQ0GMrs7OzSRuVDpdw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z8bn8sMK4TEDcU2iE4QtGdhN4yO4o0ttJ2QpSFsVq2TsmKTT4MAUmknEe+0fB/K4t36R91HD4k1PUGSlWxJnlz6EX68AvtDelLxLRNEQZnyFtOM6LVnVO/C793dG0aTeEGxIGX/CPIgQ5j9ji+f3Dr9cVlyxh7Gcp2A+SLJmBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nN4h9oNo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764967222; x=1796503222;
  h=date:from:to:cc:subject:message-id;
  bh=uqtzVnHsKXAZKN8K0hdC/i1EofQ0GMrs7OzSRuVDpdw=;
  b=nN4h9oNol1Dz9c55aCql2bLwwkt63R5bvn+NeIFKtDCGA2So4+Cx/sGs
   Zl4PbCKJACwC/V1E+3qaE/AKdGq03Bq0b28wp2v6V8w4IjuuWXlKgbGay
   Crmn2RN8JMRttduvzFdQLO5mP2iw4aCmuTdMB63WPo07aT+MFgJGiTXoJ
   dp5QdxgESdryrzPmGI28rBQ7KY5HFn4KXyjgWKp89Kiau32qF3S1Uiti2
   /Eft+YM93TEnnxpiAc6SwR4kpu31qsY64YaQOFYm7b1Z1nrX71/EVkmOE
   66MzRd9ViragNrTSABOYP6vr1pjgYa2y1tF4WUkEWNLSlThR2L8AnrWXp
   Q==;
X-CSE-ConnectionGUID: 9a9Fg6FuSquC4pZw0GUOUw==
X-CSE-MsgGUID: a56VfMakTeu48X5pp4b7Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="69599696"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="69599696"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 12:40:21 -0800
X-CSE-ConnectionGUID: rwXa3dlJT/qJq5s+o6EXjg==
X-CSE-MsgGUID: g3Dtv/QuTbKSYD3zOzBosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="195195473"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Dec 2025 12:40:19 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRcbB-00000000FWd-1240;
	Fri, 05 Dec 2025 20:40:17 +0000
Date: Sat, 06 Dec 2025 04:39:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 e37cfe5601cb7a8ff0d0daa822981a9ff3fe94de
Message-ID: <202512060427.m4z8854A-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: e37cfe5601cb7a8ff0d0daa822981a9ff3fe94de  Merge branch 'pm-runtime' into fixes

elapsed time: 1451m

configs tested: 248
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                        nsim_700_defconfig    clang-17
arc                   randconfig-001-20251205    gcc-13.4.0
arc                   randconfig-001-20251206    clang-16
arc                   randconfig-002-20251205    gcc-13.4.0
arc                   randconfig-002-20251206    clang-16
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20251205    gcc-13.4.0
arm                   randconfig-001-20251206    clang-16
arm                   randconfig-002-20251205    gcc-13.4.0
arm                   randconfig-002-20251206    clang-16
arm                   randconfig-003-20251205    gcc-13.4.0
arm                   randconfig-003-20251206    clang-16
arm                   randconfig-004-20251205    gcc-13.4.0
arm                   randconfig-004-20251206    clang-16
arm                             rpc_defconfig    gcc-15.1.0
arm                        spear3xx_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251205    clang-22
arm64                 randconfig-001-20251206    clang-22
arm64                 randconfig-002-20251205    clang-22
arm64                 randconfig-002-20251206    clang-22
arm64                 randconfig-003-20251205    clang-22
arm64                 randconfig-003-20251206    clang-22
arm64                 randconfig-004-20251205    clang-22
arm64                 randconfig-004-20251206    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251205    clang-22
csky                  randconfig-001-20251206    clang-22
csky                  randconfig-002-20251205    clang-22
csky                  randconfig-002-20251206    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251205    clang-22
hexagon               randconfig-001-20251206    gcc-15.1.0
hexagon               randconfig-002-20251205    clang-22
hexagon               randconfig-002-20251206    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251205    gcc-14
i386        buildonly-randconfig-002-20251205    gcc-14
i386        buildonly-randconfig-003-20251205    gcc-14
i386        buildonly-randconfig-004-20251205    gcc-14
i386        buildonly-randconfig-005-20251205    gcc-14
i386        buildonly-randconfig-006-20251205    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251205    clang-20
i386                  randconfig-002-20251205    clang-20
i386                  randconfig-003-20251205    clang-20
i386                  randconfig-004-20251205    clang-20
i386                  randconfig-005-20251205    clang-20
i386                  randconfig-006-20251205    clang-20
i386                  randconfig-007-20251205    clang-20
i386                  randconfig-011-20251205    clang-20
i386                  randconfig-012-20251205    clang-20
i386                  randconfig-013-20251205    clang-20
i386                  randconfig-014-20251205    clang-20
i386                  randconfig-015-20251205    clang-20
i386                  randconfig-016-20251205    clang-20
i386                  randconfig-017-20251205    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251205    clang-22
loongarch             randconfig-001-20251206    gcc-15.1.0
loongarch             randconfig-002-20251205    clang-22
loongarch             randconfig-002-20251206    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-17
mips                         bigsur_defconfig    clang-17
mips                         cobalt_defconfig    gcc-15.1.0
mips                         db1xxx_defconfig    clang-17
mips                          eyeq6_defconfig    clang-17
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251205    clang-22
nios2                 randconfig-001-20251206    gcc-15.1.0
nios2                 randconfig-002-20251205    clang-22
nios2                 randconfig-002-20251206    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251205    clang-22
parisc                randconfig-001-20251206    clang-22
parisc                randconfig-002-20251205    clang-22
parisc                randconfig-002-20251206    clang-22
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   currituck_defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    clang-17
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                      katmai_defconfig    gcc-15.1.0
powerpc                         ps3_defconfig    gcc-15.1.0
powerpc                     rainier_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251205    clang-22
powerpc               randconfig-001-20251206    clang-22
powerpc               randconfig-002-20251205    clang-22
powerpc               randconfig-002-20251206    clang-22
powerpc64             randconfig-001-20251205    clang-22
powerpc64             randconfig-001-20251206    clang-22
powerpc64             randconfig-002-20251205    clang-22
powerpc64             randconfig-002-20251206    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251205    gcc-13.4.0
riscv                 randconfig-001-20251206    clang-22
riscv                 randconfig-002-20251205    gcc-13.4.0
riscv                 randconfig-002-20251206    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251205    gcc-13.4.0
s390                  randconfig-001-20251206    clang-22
s390                  randconfig-002-20251205    gcc-13.4.0
s390                  randconfig-002-20251206    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251205    gcc-13.4.0
sh                    randconfig-001-20251206    clang-22
sh                    randconfig-002-20251205    gcc-13.4.0
sh                    randconfig-002-20251206    clang-22
sh                           se7206_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251205    gcc-14
sparc                 randconfig-001-20251206    gcc-14
sparc                 randconfig-002-20251205    gcc-14
sparc                 randconfig-002-20251206    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251205    gcc-14
sparc64               randconfig-001-20251206    gcc-14
sparc64               randconfig-002-20251205    gcc-14
sparc64               randconfig-002-20251206    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251205    gcc-14
um                    randconfig-001-20251206    gcc-14
um                    randconfig-002-20251205    gcc-14
um                    randconfig-002-20251206    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251205    gcc-14
x86_64      buildonly-randconfig-002-20251205    gcc-14
x86_64      buildonly-randconfig-003-20251205    gcc-14
x86_64      buildonly-randconfig-004-20251205    gcc-14
x86_64      buildonly-randconfig-005-20251205    gcc-14
x86_64      buildonly-randconfig-006-20251205    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251205    clang-20
x86_64                randconfig-002-20251205    clang-20
x86_64                randconfig-003-20251205    clang-20
x86_64                randconfig-004-20251205    clang-20
x86_64                randconfig-005-20251205    clang-20
x86_64                randconfig-006-20251205    clang-20
x86_64                randconfig-011-20251205    clang-20
x86_64                randconfig-012-20251205    clang-20
x86_64                randconfig-013-20251205    clang-20
x86_64                randconfig-014-20251205    clang-20
x86_64                randconfig-015-20251205    clang-20
x86_64                randconfig-016-20251205    clang-20
x86_64                randconfig-071-20251205    gcc-14
x86_64                randconfig-072-20251205    gcc-14
x86_64                randconfig-073-20251205    gcc-14
x86_64                randconfig-074-20251205    gcc-14
x86_64                randconfig-075-20251205    gcc-14
x86_64                randconfig-076-20251205    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251205    gcc-14
xtensa                randconfig-001-20251206    gcc-14
xtensa                randconfig-002-20251205    gcc-14
xtensa                randconfig-002-20251206    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

