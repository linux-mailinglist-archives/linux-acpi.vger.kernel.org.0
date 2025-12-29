Return-Path: <linux-acpi+bounces-19878-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A654CE5F7F
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 06:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C2743003F54
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 05:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A3720ADF8;
	Mon, 29 Dec 2025 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqjJaqn/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBCC19E97F;
	Mon, 29 Dec 2025 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766985111; cv=none; b=qjSqaAfHpLHrTk2AmWPio5CAGz+oyJJdKkExgJhhL/cuDnK8wHqXlfIfsX7KG9P2ROkgtj8GBUyrHcdUMDrSnyr293HxpG6tIFJlLUlGRG1QRcJfFJcG6y7iLJJCTCEftRh7dh14yPZUIJijaKpuHXQfic0fPNIVxnM/OQGEyU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766985111; c=relaxed/simple;
	bh=cyDazONphFeU6MzdOTgshzyyI13WywObZm7Omu3DoCI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ix+xmGzpVGlGw0nwzZL0xNibU4af8f6YGA3uZB7e1abt1Rf4FG3xeiXYjA9s5aYftRMWvVeuZp2YhkGRyID1cXT0KjtW0jADPTcffxyjREz9qy0LAqS+tdVMu83+QL8ajwdS7V0RiWwZikE+AoJGIPfBrFSehvtHv1g/Jk70Cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqjJaqn/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766985109; x=1798521109;
  h=date:from:to:cc:subject:message-id;
  bh=cyDazONphFeU6MzdOTgshzyyI13WywObZm7Omu3DoCI=;
  b=eqjJaqn/iei2WgLtqMHuOGHIiGVEznMHMD6heB/O3DtwcQcjAaWX9w/2
   bok7ew6UDd6iwcImrKsMDqHvEm3m0e/wsLL2Bv1YEJuZjJLs5OPkkwFc8
   tFDJIL0BLqVUcNeyIhyYExoHLIWJMJv9jvQ542vXzPNWpqkjrvQr9tuII
   u0624Z4ExgbAB2T0HkO74M6bVB80LpDaqZuceyGq7bEfZU7GYWpDd4dGK
   2qllbun7CnhVwOvuTIIExuoMpafu2tKauyKrJ6WjtZ05Xte4Lt+yMOVV/
   GZyPtzDqzfZ2ly8GhSFF3AzgkGRTqce0pz6Lm86sSl4M6CXrld4I2IU1Z
   g==;
X-CSE-ConnectionGUID: gI/OTsscSuubh4dN4tlk7w==
X-CSE-MsgGUID: DZ1ZipNOQv6i/Bk8ieASyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="80049851"
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="80049851"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 21:11:49 -0800
X-CSE-ConnectionGUID: ypwQwb+aTrKo+V16eRPmww==
X-CSE-MsgGUID: PmORmrT2Qym+ZUQ3Y98gqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="238250501"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 28 Dec 2025 21:11:48 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1va5Xl-000000006xN-1OFt;
	Mon, 29 Dec 2025 05:11:45 +0000
Date: Mon, 29 Dec 2025 13:11:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH UNVERIFIED
 WARNING 0128b2cfd36c3ed57a57dc79f050aec14da61e5f
Message-ID: <202512291329.x82hO2Pq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 0128b2cfd36c3ed57a57dc79f050aec14da61e5f  Merge branch 'acpi-queue' into bleeding-edge

Unverified Warning (likely false positive, kindly check if interested):

    drivers/acpi/bus.c:297 acpi_run_osc() warn: sizeof(NUMBER)?
    drivers/acpi/bus.c:335 acpi_osc_handshake() warn: sizeof(NUMBER)?

Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-141-20251228
|   |-- drivers-acpi-bus.c-acpi_osc_handshake()-warn:sizeof(NUMBER)
|   `-- drivers-acpi-bus.c-acpi_run_osc()-warn:sizeof(NUMBER)
`-- x86_64-randconfig-161-20251228
    |-- drivers-acpi-bus.c-acpi_osc_handshake()-warn:sizeof(NUMBER)
    `-- drivers-acpi-bus.c-acpi_run_osc()-warn:sizeof(NUMBER)

elapsed time: 1016m

configs tested: 225
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251228    gcc-10.5.0
arc                   randconfig-001-20251229    gcc-8.5.0
arc                   randconfig-002-20251228    gcc-8.5.0
arc                   randconfig-002-20251229    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-22
arm                          collie_defconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                      jornada720_defconfig    clang-22
arm                   milbeaut_m10v_defconfig    gcc-14
arm                        mvebu_v7_defconfig    gcc-14
arm                   randconfig-001-20251228    gcc-8.5.0
arm                   randconfig-001-20251229    gcc-8.5.0
arm                   randconfig-002-20251228    gcc-15.1.0
arm                   randconfig-002-20251229    gcc-8.5.0
arm                   randconfig-003-20251228    clang-22
arm                   randconfig-003-20251229    gcc-8.5.0
arm                   randconfig-004-20251228    gcc-13.4.0
arm                   randconfig-004-20251229    gcc-8.5.0
arm                        realview_defconfig    clang-16
arm                        spear6xx_defconfig    clang-22
arm64                            alldefconfig    gcc-14
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251228    gcc-8.5.0
arm64                 randconfig-002-20251228    clang-22
arm64                 randconfig-003-20251228    clang-22
arm64                 randconfig-004-20251228    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251228    gcc-11.5.0
csky                  randconfig-002-20251228    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251228    clang-22
hexagon               randconfig-002-20251228    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251228    gcc-14
i386        buildonly-randconfig-001-20251229    gcc-14
i386        buildonly-randconfig-002-20251228    clang-20
i386        buildonly-randconfig-002-20251229    gcc-14
i386        buildonly-randconfig-003-20251228    gcc-12
i386        buildonly-randconfig-003-20251229    gcc-14
i386        buildonly-randconfig-004-20251228    clang-20
i386        buildonly-randconfig-004-20251229    gcc-14
i386        buildonly-randconfig-005-20251228    clang-20
i386        buildonly-randconfig-005-20251229    gcc-14
i386        buildonly-randconfig-006-20251228    clang-20
i386        buildonly-randconfig-006-20251229    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251228    gcc-12
i386                  randconfig-002-20251228    clang-20
i386                  randconfig-003-20251228    gcc-14
i386                  randconfig-004-20251228    gcc-14
i386                  randconfig-005-20251228    gcc-14
i386                  randconfig-006-20251228    gcc-14
i386                  randconfig-007-20251228    gcc-14
i386                  randconfig-011-20251229    gcc-14
i386                  randconfig-012-20251229    gcc-14
i386                  randconfig-013-20251229    gcc-14
i386                  randconfig-014-20251229    gcc-14
i386                  randconfig-015-20251229    gcc-14
i386                  randconfig-016-20251229    gcc-14
i386                  randconfig-017-20251229    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251228    clang-22
loongarch             randconfig-002-20251228    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-14
mips                     decstation_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251228    gcc-11.5.0
nios2                 randconfig-002-20251228    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-14
parisc                randconfig-001-20251228    gcc-10.5.0
parisc                randconfig-001-20251229    gcc-12.5.0
parisc                randconfig-002-20251228    gcc-8.5.0
parisc                randconfig-002-20251229    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251228    clang-22
powerpc               randconfig-001-20251229    gcc-12.5.0
powerpc               randconfig-002-20251228    clang-22
powerpc64             randconfig-001-20251228    gcc-15.1.0
powerpc64             randconfig-001-20251229    gcc-12.5.0
powerpc64             randconfig-002-20251228    gcc-8.5.0
powerpc64             randconfig-002-20251229    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251228    clang-22
riscv                 randconfig-002-20251228    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251228    gcc-15.1.0
s390                  randconfig-002-20251228    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251228    gcc-13.4.0
sh                    randconfig-002-20251228    gcc-15.1.0
sh                             shx3_defconfig    gcc-14
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251228    gcc-14.3.0
sparc                 randconfig-001-20251229    gcc-14
sparc                 randconfig-002-20251228    gcc-12.5.0
sparc                 randconfig-002-20251229    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251228    clang-22
sparc64               randconfig-001-20251229    gcc-14
sparc64               randconfig-002-20251228    clang-20
sparc64               randconfig-002-20251229    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251228    clang-22
um                    randconfig-001-20251229    gcc-14
um                    randconfig-002-20251228    clang-22
um                    randconfig-002-20251229    gcc-14
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251228    gcc-14
x86_64      buildonly-randconfig-001-20251229    gcc-14
x86_64      buildonly-randconfig-002-20251228    gcc-14
x86_64      buildonly-randconfig-002-20251229    gcc-14
x86_64      buildonly-randconfig-003-20251228    gcc-14
x86_64      buildonly-randconfig-003-20251229    gcc-14
x86_64      buildonly-randconfig-004-20251228    gcc-14
x86_64      buildonly-randconfig-004-20251229    gcc-14
x86_64      buildonly-randconfig-005-20251228    gcc-14
x86_64      buildonly-randconfig-005-20251229    gcc-14
x86_64      buildonly-randconfig-006-20251228    clang-20
x86_64      buildonly-randconfig-006-20251229    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251228    clang-20
x86_64                randconfig-002-20251228    clang-20
x86_64                randconfig-003-20251228    clang-20
x86_64                randconfig-004-20251228    gcc-14
x86_64                randconfig-005-20251228    clang-20
x86_64                randconfig-006-20251228    gcc-14
x86_64                randconfig-011-20251228    gcc-14
x86_64                randconfig-012-20251228    gcc-14
x86_64                randconfig-013-20251228    clang-20
x86_64                randconfig-014-20251228    clang-20
x86_64                randconfig-015-20251228    clang-20
x86_64                randconfig-016-20251228    gcc-12
x86_64                randconfig-071-20251228    gcc-14
x86_64                randconfig-071-20251229    clang-20
x86_64                randconfig-072-20251229    clang-20
x86_64                randconfig-072-20251229    gcc-14
x86_64                randconfig-073-20251229    clang-20
x86_64                randconfig-073-20251229    gcc-13
x86_64                randconfig-074-20251229    clang-20
x86_64                randconfig-075-20251229    clang-20
x86_64                randconfig-076-20251229    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251228    gcc-10.5.0
xtensa                randconfig-001-20251229    gcc-14
xtensa                randconfig-002-20251228    gcc-8.5.0
xtensa                randconfig-002-20251229    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

