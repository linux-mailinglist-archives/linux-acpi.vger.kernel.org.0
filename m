Return-Path: <linux-acpi+bounces-13631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400CBAAF156
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 05:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB254E296E
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5C1EF080;
	Thu,  8 May 2025 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="am6NsBSJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5F72626;
	Thu,  8 May 2025 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673218; cv=none; b=UOeJ35U728qxYgYkstAHpoSguXowwfqFusMOGhclVxRtjQK+abJlt1jxnGz7bkdGOyplvRXYmlLfHHHGOwmuehKm9/CzV+a7uYf6EcZzHM3KP01OzZMc0rsWiFNjcvBWeTvIUFIooOBfx7XnvDD5iCyj+kiK7CqeDwt8eUQvKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673218; c=relaxed/simple;
	bh=OHTKWIZIcyB8oV8y7MZM2PgWDHVQL9gHZ6gDvU70Zwc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ya8h2kZOpjBOaNChMlnpMt0E4349Zdkc3Fmg/nHd9n8CSic4AKtJgUrfpPuiJN/kKmE0yxOB2duwjrpwyxDGbCSxQ2XPt6TPpCxPf/NhaotacPPdG5qmu5jccS1UwOS7++Gae1exx+827YZHv2e6SquAq6hxPXz8HxQSj2yafSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=am6NsBSJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746673217; x=1778209217;
  h=date:from:to:cc:subject:message-id;
  bh=OHTKWIZIcyB8oV8y7MZM2PgWDHVQL9gHZ6gDvU70Zwc=;
  b=am6NsBSJQrKgVk0zjyqCE6ITB3Xi15iyDP3WDmRPjv37+Z1jiVJrYSNG
   0soUJXJu/VqIVu7r7O4rXCdlDbvqDrHCoZg8W32mFzfau70Iq6qjQnyhL
   ZJmUqgpcqnH8l3qZqUAEtWUtV3BOiQytjJmRgTMgYFKoZbsOL8wlL3rjv
   KiNzERGCZ33HD98t53v/nINIP9JaQAuVsSnM9CqM9DIkxeJ6jie44DTQC
   lQtspHMEozRt6/2BuQqpaqYMA3IeEqhErbJUk7f3sGCw6UMMrPtPmq3Xo
   NOA67cuo5aN349y7hmQOIm0vHT9EDmiOcs9P1fM/MFC9KbqkSazLW7kpq
   w==;
X-CSE-ConnectionGUID: QS5cqKvsRhyqM1/JRwyfyQ==
X-CSE-MsgGUID: i5wSB3TiRsWLFQuZQ9w7xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52248727"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="52248727"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 20:00:16 -0700
X-CSE-ConnectionGUID: OyURjHKEQAO4pcoB6LrjRA==
X-CSE-MsgGUID: lZOFJn90TU2/kgg0I7m7hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="173365338"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 May 2025 20:00:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCrUZ-0009aj-1j;
	Thu, 08 May 2025 03:00:11 +0000
Date: Thu, 08 May 2025 10:59:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 56560905d9e960af08c0b0e4ffe3853c0a97e6d9
Message-ID: <202505081018.JLDsr6fc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 56560905d9e960af08c0b0e4ffe3853c0a97e6d9  Merge branch 'pm-cpufreq-fixes' into fixes

elapsed time: 10794m

configs tested: 297
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250430    gcc-14.2.0
arc                   randconfig-002-20250430    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-21
arm                         assabet_defconfig    clang-18
arm                                 defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-21
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-21
arm                         lpc32xx_defconfig    clang-17
arm                         mv78xx0_defconfig    clang-19
arm                       netwinder_defconfig    gcc-14.2.0
arm                           omap1_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    clang-21
arm                   randconfig-001-20250430    gcc-10.5.0
arm                   randconfig-002-20250430    gcc-7.5.0
arm                   randconfig-003-20250430    clang-21
arm                   randconfig-004-20250430    gcc-7.5.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    clang-21
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250430    gcc-5.5.0
arm64                 randconfig-002-20250430    clang-21
arm64                 randconfig-003-20250430    gcc-5.5.0
arm64                 randconfig-004-20250430    gcc-5.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250430    gcc-14.2.0
csky                  randconfig-001-20250503    gcc-8.5.0
csky                  randconfig-002-20250430    gcc-11.5.0
csky                  randconfig-002-20250503    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250430    clang-21
hexagon               randconfig-001-20250503    gcc-8.5.0
hexagon               randconfig-002-20250430    clang-21
hexagon               randconfig-002-20250503    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250501    gcc-12
i386        buildonly-randconfig-001-20250503    clang-20
i386        buildonly-randconfig-001-20250506    gcc-12
i386        buildonly-randconfig-002-20250501    gcc-12
i386        buildonly-randconfig-002-20250503    clang-20
i386        buildonly-randconfig-002-20250506    gcc-12
i386        buildonly-randconfig-003-20250501    clang-20
i386        buildonly-randconfig-003-20250503    clang-20
i386        buildonly-randconfig-003-20250506    gcc-12
i386        buildonly-randconfig-004-20250501    clang-20
i386        buildonly-randconfig-004-20250503    clang-20
i386        buildonly-randconfig-004-20250506    gcc-12
i386        buildonly-randconfig-005-20250501    clang-20
i386        buildonly-randconfig-005-20250503    clang-20
i386        buildonly-randconfig-005-20250506    gcc-12
i386        buildonly-randconfig-006-20250501    clang-20
i386        buildonly-randconfig-006-20250503    clang-20
i386        buildonly-randconfig-006-20250506    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250503    clang-20
i386                  randconfig-001-20250506    gcc-12
i386                  randconfig-002-20250503    clang-20
i386                  randconfig-002-20250506    gcc-12
i386                  randconfig-003-20250503    clang-20
i386                  randconfig-003-20250506    gcc-12
i386                  randconfig-004-20250503    clang-20
i386                  randconfig-004-20250506    gcc-12
i386                  randconfig-005-20250503    clang-20
i386                  randconfig-005-20250506    gcc-12
i386                  randconfig-006-20250503    clang-20
i386                  randconfig-006-20250506    gcc-12
i386                  randconfig-007-20250503    clang-20
i386                  randconfig-007-20250506    gcc-12
i386                  randconfig-011-20250503    clang-20
i386                  randconfig-011-20250506    gcc-12
i386                  randconfig-012-20250503    clang-20
i386                  randconfig-012-20250506    gcc-12
i386                  randconfig-013-20250503    clang-20
i386                  randconfig-013-20250506    gcc-12
i386                  randconfig-014-20250503    clang-20
i386                  randconfig-014-20250506    gcc-12
i386                  randconfig-015-20250503    clang-20
i386                  randconfig-015-20250506    gcc-12
i386                  randconfig-016-20250503    clang-20
i386                  randconfig-016-20250506    gcc-12
i386                  randconfig-017-20250503    clang-20
i386                  randconfig-017-20250506    gcc-12
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250430    gcc-14.2.0
loongarch             randconfig-001-20250503    gcc-8.5.0
loongarch             randconfig-002-20250430    gcc-13.3.0
loongarch             randconfig-002-20250503    gcc-8.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    clang-21
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
mips                      maltaaprp_defconfig    clang-21
mips                         rt305x_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250430    gcc-11.5.0
nios2                 randconfig-001-20250503    gcc-8.5.0
nios2                 randconfig-002-20250430    gcc-9.3.0
nios2                 randconfig-002-20250503    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250430    gcc-14.2.0
parisc                randconfig-001-20250503    gcc-8.5.0
parisc                randconfig-002-20250430    gcc-14.2.0
parisc                randconfig-002-20250503    gcc-8.5.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc                  mpc885_ads_defconfig    clang-21
powerpc               randconfig-001-20250430    clang-21
powerpc               randconfig-001-20250503    gcc-8.5.0
powerpc               randconfig-002-20250430    gcc-9.3.0
powerpc               randconfig-002-20250503    gcc-8.5.0
powerpc               randconfig-003-20250430    gcc-7.5.0
powerpc               randconfig-003-20250503    gcc-8.5.0
powerpc                    socrates_defconfig    clang-21
powerpc64             randconfig-001-20250430    gcc-10.5.0
powerpc64             randconfig-001-20250503    gcc-8.5.0
powerpc64             randconfig-002-20250430    gcc-10.5.0
powerpc64             randconfig-002-20250503    gcc-8.5.0
powerpc64             randconfig-003-20250430    gcc-5.5.0
powerpc64             randconfig-003-20250503    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250501    clang-21
riscv                 randconfig-001-20250503    gcc-10.5.0
riscv                 randconfig-002-20250501    gcc-14.2.0
riscv                 randconfig-002-20250503    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250501    clang-21
s390                  randconfig-001-20250503    gcc-10.5.0
s390                  randconfig-002-20250501    clang-21
s390                  randconfig-002-20250503    gcc-10.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    clang-21
sh                    randconfig-001-20250501    gcc-9.3.0
sh                    randconfig-001-20250503    gcc-10.5.0
sh                    randconfig-002-20250501    gcc-5.5.0
sh                    randconfig-002-20250503    gcc-10.5.0
sh                          rsk7269_defconfig    clang-21
sh                           se7343_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250501    gcc-10.3.0
sparc                 randconfig-001-20250503    gcc-10.5.0
sparc                 randconfig-002-20250501    gcc-8.5.0
sparc                 randconfig-002-20250503    gcc-10.5.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250501    gcc-14.2.0
sparc64               randconfig-001-20250503    gcc-10.5.0
sparc64               randconfig-002-20250501    gcc-8.5.0
sparc64               randconfig-002-20250503    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250501    gcc-11
um                    randconfig-001-20250503    gcc-10.5.0
um                    randconfig-002-20250501    gcc-12
um                    randconfig-002-20250503    gcc-10.5.0
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250501    clang-20
x86_64      buildonly-randconfig-001-20250503    gcc-12
x86_64      buildonly-randconfig-002-20250501    gcc-12
x86_64      buildonly-randconfig-002-20250503    gcc-12
x86_64      buildonly-randconfig-003-20250501    gcc-11
x86_64      buildonly-randconfig-003-20250503    gcc-12
x86_64      buildonly-randconfig-004-20250501    clang-20
x86_64      buildonly-randconfig-004-20250503    gcc-12
x86_64      buildonly-randconfig-005-20250501    gcc-12
x86_64      buildonly-randconfig-005-20250503    gcc-12
x86_64      buildonly-randconfig-006-20250501    gcc-12
x86_64      buildonly-randconfig-006-20250503    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250503    clang-20
x86_64                randconfig-002-20250503    clang-20
x86_64                randconfig-003-20250503    clang-20
x86_64                randconfig-004-20250503    clang-20
x86_64                randconfig-005-20250503    clang-20
x86_64                randconfig-006-20250503    clang-20
x86_64                randconfig-007-20250503    clang-20
x86_64                randconfig-008-20250503    clang-20
x86_64                randconfig-071-20250503    clang-20
x86_64                randconfig-071-20250506    clang-20
x86_64                randconfig-072-20250503    clang-20
x86_64                randconfig-072-20250506    clang-20
x86_64                randconfig-073-20250503    clang-20
x86_64                randconfig-073-20250506    clang-20
x86_64                randconfig-074-20250503    clang-20
x86_64                randconfig-074-20250506    clang-20
x86_64                randconfig-075-20250503    clang-20
x86_64                randconfig-075-20250506    clang-20
x86_64                randconfig-076-20250503    clang-20
x86_64                randconfig-076-20250506    clang-20
x86_64                randconfig-077-20250503    clang-20
x86_64                randconfig-077-20250506    clang-20
x86_64                randconfig-078-20250503    clang-20
x86_64                randconfig-078-20250506    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250501    gcc-14.2.0
xtensa                randconfig-001-20250503    gcc-10.5.0
xtensa                randconfig-002-20250501    gcc-12.4.0
xtensa                randconfig-002-20250503    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

