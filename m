Return-Path: <linux-acpi+bounces-10824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB9A1C516
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jan 2025 20:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9220167E07
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jan 2025 19:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412017C210;
	Sat, 25 Jan 2025 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br4V/rPf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06089CA4E;
	Sat, 25 Jan 2025 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737835003; cv=none; b=FP7Y4+hSz7+ZODPcy5gWIF7tYEklAmqslFQ/1yrNT2WcGX+Y5B32L1Sy1HUFr5fCY4cWatN22/ztDlqxKLRv+ynreEBW3Uej3LpFZ0R5WlLmhwXuKEvR1M4pyOfEYBPkJsHmLhRV7De85hzpoN6gOJjjLwjwfmF2IRlbsP6aqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737835003; c=relaxed/simple;
	bh=V0T0PmaWPHqLU5NRtWXSFgj+ugTj4KlW7Q+07UrocfI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jzHE9eqtN1oordiSDzSaAIDiJydKl4vblNqtSwud0D041DDQoMDI2qcUp2+BEON4nwgAJXzlBshyLHMXuW+TS4Y7AgGRxutOPn0Gjuxobg1gxRpCsAPWz+HHoRbtb8rAUlFihf+bWNylkHHAcGwj5sNXZzOzDLvhIUhAo5gixbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br4V/rPf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737835002; x=1769371002;
  h=date:from:to:cc:subject:message-id;
  bh=V0T0PmaWPHqLU5NRtWXSFgj+ugTj4KlW7Q+07UrocfI=;
  b=Br4V/rPfBGbGts9vIb/v/RsGjeesblQHTcojJQ5rRf3f1ilI2meidJI5
   LvhZ2HvwJsA3ninWVDPCiRso2IWIOOmED/PRPrtrzouTzktAiOfrCiCTX
   pStIkOPr0jNUlo5R1uaN9blkqvMahMw0yeerWAvoBBOIfHQh+KtPC1T+W
   iXTtTvYobl303YgTTaRuVHgVBnydj4a8B5oUnWXF198uP7Vgc2kht1EOj
   2hrxHUGqPSitroiU4GCIfwDkSNj50ijkOjlwOXlJNx9aGvyYQzu1fgxDQ
   ozw5g2NEhymq/8/RHo6mBpAtnyW/T2bqSdDWQIWiJRKA1kBqW6lHSYQLJ
   w==;
X-CSE-ConnectionGUID: pfvRNVp5TviHN4yht7rgdA==
X-CSE-MsgGUID: 5RfpMv78TwelqWOIwT5/NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="42006876"
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="42006876"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 11:56:41 -0800
X-CSE-ConnectionGUID: CpJtE2Z+RRmW/bCzp2eNaA==
X-CSE-MsgGUID: FBqFFs21TgqHJFSYy2Mjbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="131362960"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 25 Jan 2025 11:56:39 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tbmGj-000eAT-01;
	Sat, 25 Jan 2025 19:56:37 +0000
Date: Sun, 26 Jan 2025 03:55:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d0fb2a5dea57ea2b654c2e6665a5d101af0b111e
Message-ID: <202501260337.bZTx9oeE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d0fb2a5dea57ea2b654c2e6665a5d101af0b111e  Merge branch 'acpi-x86' into bleeding-edge

Unverified Warning (likely false positive, kindly check if interested):

    drivers/cpufreq/cpufreq.c:1580:4-25: opportunity for str_enable_disable(policy -> boost_enabled)

Warning ids grouped by kconfigs:

recent_errors
`-- loongarch-randconfig-r061-20250125
    `-- drivers-cpufreq-cpufreq.c:opportunity-for-str_enable_disable(policy-boost_enabled)

elapsed time: 1445m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250125    gcc-13.2.0
arc                   randconfig-002-20250125    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-20
arm                         at91_dt_defconfig    clang-20
arm                          collie_defconfig    gcc-14.2.0
arm                   randconfig-001-20250125    gcc-14.2.0
arm                   randconfig-002-20250125    gcc-14.2.0
arm                   randconfig-003-20250125    clang-18
arm                   randconfig-004-20250125    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250125    gcc-14.2.0
arm64                 randconfig-002-20250125    gcc-14.2.0
arm64                 randconfig-003-20250125    gcc-14.2.0
arm64                 randconfig-004-20250125    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250125    gcc-14.2.0
csky                  randconfig-002-20250125    gcc-14.2.0
hexagon                          alldefconfig    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250125    clang-20
hexagon               randconfig-002-20250125    clang-20
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250125    gcc-12
i386        buildonly-randconfig-002-20250125    clang-19
i386        buildonly-randconfig-003-20250125    gcc-12
i386        buildonly-randconfig-004-20250125    clang-19
i386        buildonly-randconfig-005-20250125    clang-19
i386        buildonly-randconfig-006-20250125    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250125    gcc-14.2.0
loongarch             randconfig-002-20250125    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250125    gcc-14.2.0
nios2                 randconfig-002-20250125    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250125    gcc-14.2.0
parisc                randconfig-002-20250125    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     asp8347_defconfig    clang-20
powerpc               randconfig-001-20250125    clang-18
powerpc               randconfig-002-20250125    gcc-14.2.0
powerpc               randconfig-003-20250125    gcc-14.2.0
powerpc64             randconfig-001-20250125    gcc-14.2.0
powerpc64             randconfig-002-20250125    clang-20
powerpc64             randconfig-003-20250125    clang-16
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                    nommu_k210_defconfig    clang-15
riscv                 randconfig-001-20250125    gcc-14.2.0
riscv                 randconfig-002-20250125    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250125    clang-19
s390                  randconfig-002-20250125    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250125    gcc-14.2.0
sh                    randconfig-002-20250125    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250125    gcc-14.2.0
sparc                 randconfig-002-20250125    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250125    gcc-14.2.0
sparc64               randconfig-002-20250125    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250125    clang-20
um                    randconfig-002-20250125    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250125    clang-19
x86_64      buildonly-randconfig-002-20250125    gcc-11
x86_64      buildonly-randconfig-003-20250125    clang-19
x86_64      buildonly-randconfig-004-20250125    gcc-12
x86_64      buildonly-randconfig-005-20250125    clang-19
x86_64      buildonly-randconfig-006-20250125    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250125    gcc-14.2.0
xtensa                randconfig-002-20250125    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

