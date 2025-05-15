Return-Path: <linux-acpi+bounces-13721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D38AAB7CC7
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 06:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9251BA40C7
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 04:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20B825E823;
	Thu, 15 May 2025 04:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Riboq9F1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C377374C4;
	Thu, 15 May 2025 04:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747285081; cv=none; b=rTVOb5Ze0n+8MlZ2NWgkvfsue22xSq+PlaQp0tq7GqU2t4n6gkSSS++EyNpnHSs31zHC98AaUujDgjZ0AC9WqXMFENWwuIaTcnyPo+tBD/hi6RI+BVAeEGtLEiiRYrVn+Q86w3SfPi/JmBHdBV+QVXJeXenwH+QCfDhnxkcsvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747285081; c=relaxed/simple;
	bh=fsAC/m3buADPhgHLIPr+LsI8h0NsPgT9QNJ8A8eS94k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qc9GjW+68UZSyARjnEckkgDRQ4lDuCZjhOvgHiF116WYEy1ZNfqqz/1bX4rID/a0DI1DTsE/9L9/234rYrNX2Y1sDaPvBnagqnfMM6OKDjfGehqrqpuE7ufFNmYuL8Nuek8gz/XRd3baRvfOFP7EyBpS7R22BaP903AYazOnjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Riboq9F1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747285080; x=1778821080;
  h=date:from:to:cc:subject:message-id;
  bh=fsAC/m3buADPhgHLIPr+LsI8h0NsPgT9QNJ8A8eS94k=;
  b=Riboq9F1ebw8UTjD2rgxQcq/32WHrHOpEfqig3zXlOjvaPzPe0x6uyjN
   KUEaCPWbV85DTrLRUkWVkFpneyqKMg+Rxeglj7B9/eQdGD4p//xUAq5VT
   H7Ry5fT92bKB8j263rvMf0/mGydcVX9OeuOScpLe7uisxx+yCs+ja8zhQ
   uO4tN4Ya7+Gd2Cnw6agkRdX9i0mPbyXjdDTUulukmysBqvRllcAbvlKqd
   N6pi3WhXH0mxvnW6OYbleqMow9JJJYAARNITuIJ+pSbIWQEBpxmFEh1Qk
   aqrwwuH+H09me8tVoYKJ+hyy2y8RgVLA3GKjziak+1E5wGE207lhYjAjo
   w==;
X-CSE-ConnectionGUID: yqUiZhnBRLurLfL9JRKFsw==
X-CSE-MsgGUID: PpKQEynkQ0iOIPqIW8DZMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59858146"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="59858146"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 21:57:58 -0700
X-CSE-ConnectionGUID: XBle2j+JTxuA18EZowmLtw==
X-CSE-MsgGUID: WNJ9Di15RVKhr2PEaZdgpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138775460"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 14 May 2025 21:57:57 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFQfK-000HwJ-3C;
	Thu, 15 May 2025 04:57:54 +0000
Date: Thu, 15 May 2025 12:57:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 745dc6b941c2246756c4d331aec9914b906cc598
Message-ID: <202505151233.oyxZWiG7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 745dc6b941c2246756c4d331aec9914b906cc598  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 925m

configs tested: 222
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250514    gcc-13.3.0
arc                   randconfig-001-20250515    gcc-6.5.0
arc                   randconfig-002-20250514    gcc-14.2.0
arc                   randconfig-002-20250515    gcc-6.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250514    clang-21
arm                   randconfig-001-20250515    gcc-6.5.0
arm                   randconfig-002-20250514    clang-21
arm                   randconfig-002-20250515    gcc-6.5.0
arm                   randconfig-003-20250514    gcc-7.5.0
arm                   randconfig-003-20250515    gcc-6.5.0
arm                   randconfig-004-20250514    gcc-7.5.0
arm                   randconfig-004-20250515    gcc-6.5.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250514    clang-17
arm64                 randconfig-001-20250515    gcc-6.5.0
arm64                 randconfig-002-20250514    gcc-5.5.0
arm64                 randconfig-002-20250515    gcc-6.5.0
arm64                 randconfig-003-20250514    gcc-5.5.0
arm64                 randconfig-003-20250515    gcc-6.5.0
arm64                 randconfig-004-20250514    clang-21
arm64                 randconfig-004-20250515    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250515    clang-21
csky                  randconfig-001-20250515    gcc-14.2.0
csky                  randconfig-002-20250515    clang-21
csky                  randconfig-002-20250515    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250515    clang-16
hexagon               randconfig-001-20250515    clang-21
hexagon               randconfig-002-20250515    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250514    clang-20
i386        buildonly-randconfig-001-20250515    gcc-11
i386        buildonly-randconfig-002-20250514    gcc-12
i386        buildonly-randconfig-002-20250515    gcc-11
i386        buildonly-randconfig-003-20250514    clang-20
i386        buildonly-randconfig-003-20250515    gcc-11
i386        buildonly-randconfig-004-20250514    clang-20
i386        buildonly-randconfig-004-20250515    gcc-11
i386        buildonly-randconfig-005-20250514    gcc-12
i386        buildonly-randconfig-005-20250515    gcc-11
i386        buildonly-randconfig-006-20250514    gcc-12
i386        buildonly-randconfig-006-20250515    gcc-11
i386                                defconfig    clang-20
i386                  randconfig-001-20250515    clang-20
i386                  randconfig-002-20250515    clang-20
i386                  randconfig-003-20250515    clang-20
i386                  randconfig-004-20250515    clang-20
i386                  randconfig-005-20250515    clang-20
i386                  randconfig-006-20250515    clang-20
i386                  randconfig-007-20250515    clang-20
i386                  randconfig-011-20250515    gcc-12
i386                  randconfig-012-20250515    gcc-12
i386                  randconfig-013-20250515    gcc-12
i386                  randconfig-014-20250515    gcc-12
i386                  randconfig-015-20250515    gcc-12
i386                  randconfig-016-20250515    gcc-12
i386                  randconfig-017-20250515    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250515    clang-21
loongarch             randconfig-001-20250515    gcc-12.4.0
loongarch             randconfig-002-20250515    clang-21
loongarch             randconfig-002-20250515    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250515    clang-21
nios2                 randconfig-001-20250515    gcc-12.4.0
nios2                 randconfig-002-20250515    clang-21
nios2                 randconfig-002-20250515    gcc-6.5.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250515    clang-21
parisc                randconfig-001-20250515    gcc-13.3.0
parisc                randconfig-002-20250515    clang-21
parisc                randconfig-002-20250515    gcc-13.3.0
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250515    clang-21
powerpc               randconfig-001-20250515    gcc-8.5.0
powerpc               randconfig-002-20250515    clang-21
powerpc               randconfig-002-20250515    gcc-6.5.0
powerpc               randconfig-003-20250515    clang-21
powerpc64             randconfig-001-20250515    clang-21
powerpc64             randconfig-002-20250515    clang-21
powerpc64             randconfig-002-20250515    gcc-8.5.0
powerpc64             randconfig-003-20250515    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250515    gcc-8.5.0
riscv                 randconfig-001-20250515    gcc-9.3.0
riscv                 randconfig-002-20250515    gcc-14.2.0
riscv                 randconfig-002-20250515    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250515    clang-21
s390                  randconfig-001-20250515    gcc-9.3.0
s390                  randconfig-002-20250515    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250515    gcc-14.2.0
sh                    randconfig-001-20250515    gcc-9.3.0
sh                    randconfig-002-20250515    gcc-10.5.0
sh                    randconfig-002-20250515    gcc-9.3.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250515    gcc-6.5.0
sparc                 randconfig-001-20250515    gcc-9.3.0
sparc                 randconfig-002-20250515    gcc-10.3.0
sparc                 randconfig-002-20250515    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250515    gcc-9.3.0
sparc64               randconfig-002-20250515    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250515    gcc-12
um                    randconfig-001-20250515    gcc-9.3.0
um                    randconfig-002-20250515    clang-21
um                    randconfig-002-20250515    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250514    clang-20
x86_64      buildonly-randconfig-001-20250515    gcc-12
x86_64      buildonly-randconfig-002-20250514    gcc-12
x86_64      buildonly-randconfig-002-20250515    gcc-12
x86_64      buildonly-randconfig-003-20250514    gcc-12
x86_64      buildonly-randconfig-003-20250515    gcc-12
x86_64      buildonly-randconfig-004-20250514    gcc-12
x86_64      buildonly-randconfig-004-20250515    gcc-12
x86_64      buildonly-randconfig-005-20250514    clang-20
x86_64      buildonly-randconfig-005-20250515    gcc-12
x86_64      buildonly-randconfig-006-20250514    gcc-12
x86_64      buildonly-randconfig-006-20250515    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250515    gcc-12
x86_64                randconfig-002-20250515    gcc-12
x86_64                randconfig-003-20250515    gcc-12
x86_64                randconfig-004-20250515    gcc-12
x86_64                randconfig-005-20250515    gcc-12
x86_64                randconfig-006-20250515    gcc-12
x86_64                randconfig-007-20250515    gcc-12
x86_64                randconfig-008-20250515    gcc-12
x86_64                randconfig-071-20250515    clang-20
x86_64                randconfig-072-20250515    clang-20
x86_64                randconfig-073-20250515    clang-20
x86_64                randconfig-074-20250515    clang-20
x86_64                randconfig-075-20250515    clang-20
x86_64                randconfig-076-20250515    clang-20
x86_64                randconfig-077-20250515    clang-20
x86_64                randconfig-078-20250515    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-9.3.0
xtensa                randconfig-002-20250515    gcc-13.3.0
xtensa                randconfig-002-20250515    gcc-9.3.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

