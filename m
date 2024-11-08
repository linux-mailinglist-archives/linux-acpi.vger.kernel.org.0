Return-Path: <linux-acpi+bounces-9429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E89C133F
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 01:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D40F1F23131
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 00:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7281BD9DA;
	Fri,  8 Nov 2024 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AarGZrLp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C21BD9CB;
	Fri,  8 Nov 2024 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026263; cv=none; b=h07zfNNPidi60TZ0xOlDHV/G/lrq7aAlYMaMnL7VL8E6q+jaPnV8JQebjX0PKcct4AZ4+C7gqP9zJU8/DSZrHkl5r2f056LoZTPSEYZ8k6U1pPfq52WuFVXEnKSPsychPOvPFf9jFTg7s8z7MnbIcDnw2So0p4rkFXjs5MbQQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026263; c=relaxed/simple;
	bh=Xf4Su46mbYWVwRUKNajXZtRItjeJ04IK+43qgWsyuHc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ct+jFPVy4lE+rJKn0OLZJUuwPj8fRk7l/m9JZ4m0iK0bxCytr4MC/u0AQgdocThySUoJ8Vhg2MEiTzRcdlO1s+pQs0i6KyHxXu/SY9m00BXSkMKDJtxzp5PHW9NmMmNEAIO9/FmKViroisW2Qc+itb0Ssblq585yWsyMzA5LZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AarGZrLp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731026261; x=1762562261;
  h=date:from:to:cc:subject:message-id;
  bh=Xf4Su46mbYWVwRUKNajXZtRItjeJ04IK+43qgWsyuHc=;
  b=AarGZrLpXebfzYfKSnidoZB34rSI5tGQRwDmMWDKCsdPZJhdf3Its9e+
   ohXHqjNRCy5Gh0F6E06fyjTyqMzN5yuE50RjMYYGgdGJBSfTvFpR4TgTR
   uN/DRe1G182zHwM0Whn6jb6LHZSZsVfTT6U/294gv9tG8Pon2TaWO+fGe
   KxhQsVmAaKsrJ7RbS+USzTESrtkRy5XMarJ+gS0UxbOHrxXlXrztCgkRa
   QOFZ6LDIPpEjQrj3ITJ0BufDSecCUjfLzjCyzrdOTcWieK/2NqGpKc4+O
   H8knMLqwBvn8Zh3aXB8N85sFkaU4Tx3NS/ueFYD9WRcCkRZeHOk/WQF6c
   g==;
X-CSE-ConnectionGUID: v2tYo6TyRsqS47/PQlKR7A==
X-CSE-MsgGUID: UHsI60TDQd6IoQ7e9/MKJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30673001"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30673001"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 16:37:40 -0800
X-CSE-ConnectionGUID: HU3KaESpRqyJfHkH74xsRQ==
X-CSE-MsgGUID: aJVwvqdrRTucoGAubepDIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85709088"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Nov 2024 16:37:40 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9D0K-000qpO-2U;
	Fri, 08 Nov 2024 00:37:36 +0000
Date: Fri, 08 Nov 2024 08:37:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c0c640fc78059c1f471f0441f791ab4e73ccb369
Message-ID: <202411080814.eqa6tADw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c0c640fc78059c1f471f0441f791ab4e73ccb369  Merge branch 'fixes' into linux-next

elapsed time: 722m

configs tested: 189
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arc                   randconfig-001-20241108    gcc-14.2.0
arc                   randconfig-002-20241108    gcc-14.2.0
arc                           tb10x_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                            mmp2_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v5_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-20
arm                   randconfig-001-20241108    gcc-14.2.0
arm                   randconfig-002-20241108    gcc-14.2.0
arm                   randconfig-003-20241108    gcc-14.2.0
arm                   randconfig-004-20241108    gcc-14.2.0
arm                           sama7_defconfig    gcc-14.2.0
arm                           sunxi_defconfig    clang-20
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241108    gcc-14.2.0
arm64                 randconfig-002-20241108    gcc-14.2.0
arm64                 randconfig-003-20241108    gcc-14.2.0
arm64                 randconfig-004-20241108    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241108    gcc-14.2.0
csky                  randconfig-002-20241108    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241108    gcc-14.2.0
hexagon               randconfig-002-20241108    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241108    clang-19
i386        buildonly-randconfig-002-20241108    clang-19
i386        buildonly-randconfig-003-20241108    clang-19
i386        buildonly-randconfig-004-20241108    clang-19
i386        buildonly-randconfig-005-20241108    clang-19
i386        buildonly-randconfig-006-20241108    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241108    clang-19
i386                  randconfig-002-20241108    clang-19
i386                  randconfig-003-20241108    clang-19
i386                  randconfig-004-20241108    clang-19
i386                  randconfig-005-20241108    clang-19
i386                  randconfig-006-20241108    clang-19
i386                  randconfig-011-20241108    clang-19
i386                  randconfig-012-20241108    clang-19
i386                  randconfig-013-20241108    clang-19
i386                  randconfig-014-20241108    clang-19
i386                  randconfig-015-20241108    clang-19
i386                  randconfig-016-20241108    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20241108    gcc-14.2.0
loongarch             randconfig-002-20241108    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    clang-20
m68k                            q40_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
mips                            gpr_defconfig    clang-20
mips                           ip30_defconfig    gcc-14.2.0
mips                         rt305x_defconfig    clang-20
nios2                         10m50_defconfig    clang-20
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241108    gcc-14.2.0
nios2                 randconfig-002-20241108    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    clang-20
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241108    gcc-14.2.0
parisc                randconfig-002-20241108    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-20
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                      pmac32_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241108    gcc-14.2.0
powerpc               randconfig-002-20241108    gcc-14.2.0
powerpc               randconfig-003-20241108    gcc-14.2.0
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241108    gcc-14.2.0
powerpc64             randconfig-002-20241108    gcc-14.2.0
powerpc64             randconfig-003-20241108    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241108    gcc-14.2.0
riscv                 randconfig-002-20241108    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241108    gcc-14.2.0
s390                  randconfig-002-20241108    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          r7785rp_defconfig    clang-20
sh                    randconfig-001-20241108    gcc-14.2.0
sh                    randconfig-002-20241108    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241108    gcc-14.2.0
sparc64               randconfig-002-20241108    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241108    gcc-14.2.0
um                    randconfig-002-20241108    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241108    clang-19
x86_64      buildonly-randconfig-002-20241108    clang-19
x86_64      buildonly-randconfig-003-20241108    clang-19
x86_64      buildonly-randconfig-004-20241108    clang-19
x86_64      buildonly-randconfig-005-20241108    clang-19
x86_64      buildonly-randconfig-006-20241108    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241108    clang-19
x86_64                randconfig-002-20241108    clang-19
x86_64                randconfig-003-20241108    clang-19
x86_64                randconfig-004-20241108    clang-19
x86_64                randconfig-005-20241108    clang-19
x86_64                randconfig-006-20241108    clang-19
x86_64                randconfig-011-20241108    clang-19
x86_64                randconfig-012-20241108    clang-19
x86_64                randconfig-013-20241108    clang-19
x86_64                randconfig-014-20241108    clang-19
x86_64                randconfig-015-20241108    clang-19
x86_64                randconfig-016-20241108    clang-19
x86_64                randconfig-071-20241108    clang-19
x86_64                randconfig-072-20241108    clang-19
x86_64                randconfig-073-20241108    clang-19
x86_64                randconfig-074-20241108    clang-19
x86_64                randconfig-075-20241108    clang-19
x86_64                randconfig-076-20241108    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241108    gcc-14.2.0
xtensa                randconfig-002-20241108    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

