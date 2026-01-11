Return-Path: <linux-acpi+bounces-20150-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28411D0E00A
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 01:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93D9830145B1
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 00:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33BC78C9C;
	Sun, 11 Jan 2026 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D//K2ucn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19B3BB44;
	Sun, 11 Jan 2026 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768090717; cv=none; b=gBRrXA/sqGovSKDmtoB6EVUCtZ+8ED7TNOc3w0W08gi2I89ekgo+pkTULKX6oGUyWA4+9Mwh0HqNbGQ34Hb4yd1TWvLfL434Ba6YekOW4oEusqhfp0U7qyv7pQq8HtL2JbKnbdivb1MHY3JAKy+23R4E09a1kWeRzCKIp7ppAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768090717; c=relaxed/simple;
	bh=8pyqAD5wmLYtKkRp9TVA19qxxsTOzVLx7FparK+dqm8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mIG26FjNwfezf7H8IRXAPnmAOnu0xWRj5lMLSAOOlITL1nTv4QmS7B9pyzqqiszMpmYtOxtl6aORTHE9mmy2eytoJv1yZGJBi4KxPeAsJjEb/Rj5ZPOL97CDHSqc+nk7q1ahPsvbQhisfDpdtvxw7mhPie1hyo9AznZyUfK5Vaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D//K2ucn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768090715; x=1799626715;
  h=date:from:to:cc:subject:message-id;
  bh=8pyqAD5wmLYtKkRp9TVA19qxxsTOzVLx7FparK+dqm8=;
  b=D//K2ucnHbhAIKwQ3Omd7mZQkL4kbsnYnpoKeoHtJJw+R6KxWClQENIq
   RylJ0okZOce8JcU9PqpBhLBDHenwX8Z2wgQOJbfS7qGRAb7zpDTeKriYb
   BkgqrEl4vj/qifTY6a6Uri9N5QozptFvind6LXLfTjFcTpa1ZOydO6sta
   GyqzHhaUzC/5pwKiIHXW0u5iDtt0ayhSrZ6znUS6NSQd/9DOQMgbDw/qF
   CTghXsVUjiBm7zllBCrrv7e9dnQHw8SVHxBE/ZDmtQFljNly5CRV7SNvj
   Uw1ehTEeUR1q/EDOY38Mm+gMhDG7xWj6G230l1VuA2W8VWX1KpRe0bIzZ
   g==;
X-CSE-ConnectionGUID: Fkj6HDBPSiaD8EIROfL6oQ==
X-CSE-MsgGUID: 9nnwYBKUSqiJ1uybku6S9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11667"; a="71995339"
X-IronPort-AV: E=Sophos;i="6.21,217,1763452800"; 
   d="scan'208";a="71995339"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2026 16:18:35 -0800
X-CSE-ConnectionGUID: PngWW8w0Q7irFH3/JOVwUw==
X-CSE-MsgGUID: KPgGJGLxRSeBsAPQEl1pVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,217,1763452800"; 
   d="scan'208";a="203844058"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Jan 2026 16:18:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vejA6-000000009Me-2DB1;
	Sun, 11 Jan 2026 00:18:30 +0000
Date: Sun, 11 Jan 2026 08:18:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bd5f767a128960227e732b11c6059aaecb102319
Message-ID: <202601110801.WKCatxlR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bd5f767a128960227e732b11c6059aaecb102319  Merge branch 'acpi-driver' into bleeding-edge

elapsed time: 724m

configs tested: 326
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                          axs101_defconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260110    clang-22
arc                   randconfig-001-20260110    gcc-13.4.0
arc                   randconfig-001-20260111    clang-22
arc                   randconfig-002-20260110    clang-22
arc                   randconfig-002-20260110    gcc-8.5.0
arc                   randconfig-002-20260111    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-22
arm                           h3600_defconfig    clang-22
arm                           h3600_defconfig    gcc-15.2.0
arm                   milbeaut_m10v_defconfig    clang-22
arm                            mmp2_defconfig    gcc-15.2.0
arm                             pxa_defconfig    clang-22
arm                   randconfig-001-20260110    clang-22
arm                   randconfig-001-20260111    clang-22
arm                   randconfig-002-20260110    clang-22
arm                   randconfig-002-20260110    gcc-12.5.0
arm                   randconfig-002-20260111    clang-22
arm                   randconfig-003-20260110    clang-22
arm                   randconfig-003-20260110    gcc-8.5.0
arm                   randconfig-003-20260111    clang-22
arm                   randconfig-004-20260110    clang-22
arm                   randconfig-004-20260111    clang-22
arm                             rpc_defconfig    clang-22
arm                        shmobile_defconfig    clang-22
arm                           u8500_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260110    gcc-15.2.0
arm64                 randconfig-001-20260111    gcc-12.5.0
arm64                 randconfig-002-20260110    gcc-10.5.0
arm64                 randconfig-002-20260111    gcc-12.5.0
arm64                 randconfig-003-20260110    gcc-12.5.0
arm64                 randconfig-003-20260111    gcc-12.5.0
arm64                 randconfig-004-20260110    gcc-14.3.0
arm64                 randconfig-004-20260111    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260110    gcc-15.2.0
csky                  randconfig-001-20260111    gcc-12.5.0
csky                  randconfig-002-20260110    gcc-15.2.0
csky                  randconfig-002-20260111    gcc-12.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260110    clang-22
hexagon               randconfig-001-20260111    clang-22
hexagon               randconfig-002-20260110    clang-22
hexagon               randconfig-002-20260111    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260110    gcc-14
i386        buildonly-randconfig-001-20260111    clang-20
i386        buildonly-randconfig-002-20260110    gcc-14
i386        buildonly-randconfig-002-20260111    clang-20
i386        buildonly-randconfig-003-20260110    gcc-12
i386        buildonly-randconfig-003-20260111    clang-20
i386        buildonly-randconfig-004-20260110    clang-20
i386        buildonly-randconfig-004-20260111    clang-20
i386        buildonly-randconfig-005-20260110    gcc-14
i386        buildonly-randconfig-005-20260111    clang-20
i386        buildonly-randconfig-006-20260110    gcc-14
i386        buildonly-randconfig-006-20260111    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260110    gcc-14
i386                  randconfig-001-20260111    clang-20
i386                  randconfig-002-20260110    gcc-14
i386                  randconfig-002-20260111    clang-20
i386                  randconfig-003-20260110    gcc-14
i386                  randconfig-003-20260111    clang-20
i386                  randconfig-004-20260110    gcc-14
i386                  randconfig-004-20260111    clang-20
i386                  randconfig-005-20260110    gcc-14
i386                  randconfig-005-20260111    clang-20
i386                  randconfig-006-20260110    gcc-14
i386                  randconfig-006-20260111    clang-20
i386                  randconfig-007-20260110    gcc-14
i386                  randconfig-007-20260111    clang-20
i386                  randconfig-011-20260110    clang-20
i386                  randconfig-011-20260110    gcc-14
i386                  randconfig-011-20260111    clang-20
i386                  randconfig-012-20260110    gcc-14
i386                  randconfig-012-20260111    clang-20
i386                  randconfig-013-20260110    gcc-14
i386                  randconfig-013-20260111    clang-20
i386                  randconfig-014-20260110    clang-20
i386                  randconfig-014-20260110    gcc-14
i386                  randconfig-014-20260111    clang-20
i386                  randconfig-015-20260110    clang-20
i386                  randconfig-015-20260110    gcc-14
i386                  randconfig-015-20260111    clang-20
i386                  randconfig-016-20260110    clang-20
i386                  randconfig-016-20260110    gcc-14
i386                  randconfig-016-20260111    clang-20
i386                  randconfig-017-20260110    clang-20
i386                  randconfig-017-20260110    gcc-14
i386                  randconfig-017-20260111    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260110    clang-22
loongarch             randconfig-001-20260111    clang-22
loongarch             randconfig-002-20260110    clang-22
loongarch             randconfig-002-20260111    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         amcore_defconfig    gcc-15.2.0
m68k                         apollo_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    clang-22
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                        m5307c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                     decstation_defconfig    clang-22
mips                          eyeq6_defconfig    clang-22
mips                           mtx1_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260110    clang-22
nios2                 randconfig-001-20260110    gcc-8.5.0
nios2                 randconfig-001-20260111    clang-22
nios2                 randconfig-002-20260110    clang-22
nios2                 randconfig-002-20260110    gcc-11.5.0
nios2                 randconfig-002-20260111    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
openrisc                  or1klitex_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260110    gcc-14.3.0
parisc                randconfig-001-20260111    clang-22
parisc                randconfig-002-20260110    gcc-14.3.0
parisc                randconfig-002-20260111    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      cm5200_defconfig    clang-22
powerpc                     ep8248e_defconfig    clang-22
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    clang-22
powerpc                       holly_defconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc                 mpc8313_rdb_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    clang-22
powerpc                      ppc44x_defconfig    gcc-15.2.0
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260110    gcc-14.3.0
powerpc               randconfig-001-20260111    clang-22
powerpc               randconfig-002-20260110    gcc-14.3.0
powerpc               randconfig-002-20260111    clang-22
powerpc                      tqm8xx_defconfig    clang-22
powerpc64             randconfig-001-20260110    gcc-14.3.0
powerpc64             randconfig-001-20260111    clang-22
powerpc64             randconfig-002-20260110    gcc-14.3.0
powerpc64             randconfig-002-20260111    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260110    clang-22
riscv                 randconfig-001-20260110    gcc-15.2.0
riscv                 randconfig-001-20260111    gcc-11.5.0
riscv                 randconfig-002-20260110    clang-22
riscv                 randconfig-002-20260110    gcc-15.2.0
riscv                 randconfig-002-20260111    gcc-11.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260110    gcc-15.2.0
s390                  randconfig-001-20260110    gcc-9.5.0
s390                  randconfig-001-20260111    gcc-11.5.0
s390                  randconfig-002-20260110    clang-22
s390                  randconfig-002-20260110    gcc-15.2.0
s390                  randconfig-002-20260111    gcc-11.5.0
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    gcc-15.2.0
sh                            hp6xx_defconfig    gcc-15.2.0
sh                    randconfig-001-20260110    gcc-15.2.0
sh                    randconfig-001-20260111    gcc-11.5.0
sh                    randconfig-002-20260110    gcc-12.5.0
sh                    randconfig-002-20260110    gcc-15.2.0
sh                    randconfig-002-20260111    gcc-11.5.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           se7343_defconfig    clang-22
sh                   secureedge5410_defconfig    gcc-15.2.0
sh                        sh7757lcr_defconfig    clang-22
sh                          urquell_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260110    clang-22
sparc                 randconfig-001-20260110    gcc-14.3.0
sparc                 randconfig-001-20260111    gcc-8.5.0
sparc                 randconfig-002-20260110    clang-22
sparc                 randconfig-002-20260110    gcc-15.2.0
sparc                 randconfig-002-20260111    gcc-8.5.0
sparc64                          alldefconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260110    clang-22
sparc64               randconfig-001-20260111    gcc-8.5.0
sparc64               randconfig-002-20260110    clang-22
sparc64               randconfig-002-20260111    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260110    clang-22
um                    randconfig-001-20260110    gcc-14
um                    randconfig-001-20260111    gcc-8.5.0
um                    randconfig-002-20260110    clang-22
um                    randconfig-002-20260110    gcc-14
um                    randconfig-002-20260111    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260110    gcc-14
x86_64      buildonly-randconfig-001-20260111    clang-20
x86_64      buildonly-randconfig-002-20260110    clang-20
x86_64      buildonly-randconfig-002-20260110    gcc-14
x86_64      buildonly-randconfig-002-20260111    clang-20
x86_64      buildonly-randconfig-003-20260110    clang-20
x86_64      buildonly-randconfig-003-20260110    gcc-14
x86_64      buildonly-randconfig-003-20260111    clang-20
x86_64      buildonly-randconfig-004-20260110    gcc-14
x86_64      buildonly-randconfig-004-20260111    clang-20
x86_64      buildonly-randconfig-005-20260110    gcc-14
x86_64      buildonly-randconfig-005-20260111    clang-20
x86_64      buildonly-randconfig-006-20260110    gcc-14
x86_64      buildonly-randconfig-006-20260111    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260110    clang-20
x86_64                randconfig-001-20260111    gcc-12
x86_64                randconfig-002-20260110    clang-20
x86_64                randconfig-002-20260110    gcc-14
x86_64                randconfig-002-20260111    gcc-12
x86_64                randconfig-003-20260110    clang-20
x86_64                randconfig-003-20260111    gcc-12
x86_64                randconfig-004-20260110    clang-20
x86_64                randconfig-004-20260111    gcc-12
x86_64                randconfig-005-20260110    clang-20
x86_64                randconfig-005-20260110    gcc-14
x86_64                randconfig-005-20260111    gcc-12
x86_64                randconfig-006-20260110    clang-20
x86_64                randconfig-006-20260111    gcc-12
x86_64                randconfig-011-20260110    clang-20
x86_64                randconfig-011-20260111    clang-20
x86_64                randconfig-012-20260110    clang-20
x86_64                randconfig-012-20260110    gcc-14
x86_64                randconfig-012-20260111    clang-20
x86_64                randconfig-013-20260110    clang-20
x86_64                randconfig-013-20260110    gcc-14
x86_64                randconfig-013-20260111    clang-20
x86_64                randconfig-014-20260110    clang-20
x86_64                randconfig-014-20260111    clang-20
x86_64                randconfig-015-20260110    clang-20
x86_64                randconfig-015-20260110    gcc-14
x86_64                randconfig-015-20260111    clang-20
x86_64                randconfig-016-20260110    clang-20
x86_64                randconfig-016-20260111    clang-20
x86_64                randconfig-071-20260110    clang-20
x86_64                randconfig-071-20260111    gcc-14
x86_64                randconfig-072-20260110    clang-20
x86_64                randconfig-072-20260111    gcc-14
x86_64                randconfig-073-20260110    clang-20
x86_64                randconfig-073-20260111    gcc-14
x86_64                randconfig-074-20260110    clang-20
x86_64                randconfig-074-20260111    gcc-14
x86_64                randconfig-075-20260110    clang-20
x86_64                randconfig-075-20260110    gcc-14
x86_64                randconfig-075-20260111    gcc-14
x86_64                randconfig-076-20260110    clang-20
x86_64                randconfig-076-20260110    gcc-14
x86_64                randconfig-076-20260111    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                       common_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260110    clang-22
xtensa                randconfig-001-20260110    gcc-10.5.0
xtensa                randconfig-001-20260111    gcc-8.5.0
xtensa                randconfig-002-20260110    clang-22
xtensa                randconfig-002-20260110    gcc-15.2.0
xtensa                randconfig-002-20260111    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

