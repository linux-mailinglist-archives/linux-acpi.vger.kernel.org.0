Return-Path: <linux-acpi+bounces-18131-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD0BFFD16
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 10:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A8694EB9E8
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD412EC56F;
	Thu, 23 Oct 2025 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP1rpOPs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E436257845;
	Thu, 23 Oct 2025 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207265; cv=none; b=eminiaUmBYVST44fsnQZM7Kfi5Gs5usFEs3BJiRYsDWqfP5+3/XKl14LfG0ZKHWkodmQVx3hhT8/NTPFiMDSmcQNdxjkPrDrMiehB8OV70E44YVKg3QhU2CVsiJAYW8JINW1QDbOQPVkWJNhmoqPAvXsZnDKaAL5q5aRCBYqxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207265; c=relaxed/simple;
	bh=3OQxbWNh2MxWTwsq6xxvugLb1r7K+LFGxtC+qPTE14Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AE4yy2H1RJbXHRtkwFmPnc4x2/n6S1fD9LCj7xmbqodLERm67/Qvwr4BC9qUZXs8bNFPU51FvtBTJYBkgXX6QcPNv2bNtTxqdI4SuXYbEgF/6EikYQTmN+WsPtRsrci/SQ/l+X4HFu2HiKBdAt2pWHkvGvv6K1NgpqD3M7YbiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP1rpOPs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761207263; x=1792743263;
  h=date:from:to:cc:subject:message-id;
  bh=3OQxbWNh2MxWTwsq6xxvugLb1r7K+LFGxtC+qPTE14Q=;
  b=HP1rpOPsq+JY4iarBEEIJ+h8R4bae23Y0Ycis6FMTEYlGEO7Z96kJ2wd
   OzlmfGG/Gin84XRK1QxWU2Q+WEr5CAkknwOQNWtEYdZ2WW2pPuIKENXIP
   ESTPnwxTvR62lB/92afmpziQcBew0oqalVZfVnhogJyJJ8PxL1H2KE+nD
   ynpd/jItD/MikczN0/oSibwBkCM1ieRTNqKpyeQKBSo1Nyi+DPj1NyEKr
   sJRIQXUn3v1bfzuUDHtz+BuSblfKcMWnMPxiTCmk6661lXctH8c+8BdDk
   ZYxe2ffoq+BSzsOqdDDVpBkEbIVBpRNP2f9wWb0yDJ30fp+OlRtT2iFG1
   A==;
X-CSE-ConnectionGUID: Hi8Qe4vITFypx9gQAHlf/Q==
X-CSE-MsgGUID: xAuS321xRGiAqYGUvdqD3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63074137"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="63074137"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:14:22 -0700
X-CSE-ConnectionGUID: 3M350A9wQd+KRcUX4LhxdQ==
X-CSE-MsgGUID: DlUbFtbwTrmJt8AQ1qlW2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184159790"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 23 Oct 2025 01:14:21 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBqSY-000DDB-11;
	Thu, 23 Oct 2025 08:14:15 +0000
Date: Thu, 23 Oct 2025 16:13:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 e98c2fee8597bb96647583fd13b709b4a07488f0
Message-ID: <202510231631.7Qvytthj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: e98c2fee8597bb96647583fd13b709b4a07488f0  Merge branches 'acpi-property' and 'acpica' into fixes

elapsed time: 1345m

configs tested: 253
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251022    gcc-13.4.0
arc                   randconfig-001-20251023    gcc-8.5.0
arc                   randconfig-002-20251022    gcc-8.5.0
arc                   randconfig-002-20251023    gcc-8.5.0
arm                              alldefconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          gemini_defconfig    clang-20
arm                           h3600_defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20251022    gcc-11.5.0
arm                   randconfig-001-20251023    gcc-8.5.0
arm                   randconfig-002-20251022    gcc-10.5.0
arm                   randconfig-002-20251023    gcc-8.5.0
arm                   randconfig-003-20251022    gcc-10.5.0
arm                   randconfig-003-20251023    gcc-8.5.0
arm                   randconfig-004-20251022    clang-22
arm                   randconfig-004-20251023    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251022    gcc-9.5.0
arm64                 randconfig-001-20251023    gcc-8.5.0
arm64                 randconfig-002-20251022    clang-18
arm64                 randconfig-002-20251023    gcc-8.5.0
arm64                 randconfig-003-20251022    gcc-10.5.0
arm64                 randconfig-003-20251023    gcc-8.5.0
arm64                 randconfig-004-20251022    gcc-12.5.0
arm64                 randconfig-004-20251023    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251022    gcc-15.1.0
csky                  randconfig-001-20251023    gcc-10.5.0
csky                  randconfig-002-20251022    gcc-11.5.0
csky                  randconfig-002-20251023    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251022    clang-22
hexagon               randconfig-001-20251023    gcc-10.5.0
hexagon               randconfig-002-20251022    clang-22
hexagon               randconfig-002-20251023    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251022    clang-20
i386        buildonly-randconfig-001-20251023    clang-20
i386        buildonly-randconfig-002-20251022    clang-20
i386        buildonly-randconfig-002-20251023    clang-20
i386        buildonly-randconfig-003-20251022    gcc-14
i386        buildonly-randconfig-003-20251023    clang-20
i386        buildonly-randconfig-004-20251022    clang-20
i386        buildonly-randconfig-004-20251023    clang-20
i386        buildonly-randconfig-005-20251022    gcc-12
i386        buildonly-randconfig-005-20251023    clang-20
i386        buildonly-randconfig-006-20251022    gcc-14
i386        buildonly-randconfig-006-20251023    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251023    clang-20
i386                  randconfig-002-20251023    clang-20
i386                  randconfig-003-20251023    clang-20
i386                  randconfig-004-20251023    clang-20
i386                  randconfig-005-20251023    clang-20
i386                  randconfig-006-20251023    clang-20
i386                  randconfig-007-20251023    clang-20
i386                  randconfig-011-20251023    gcc-14
i386                  randconfig-012-20251023    gcc-14
i386                  randconfig-013-20251023    gcc-14
i386                  randconfig-014-20251023    gcc-14
i386                  randconfig-015-20251023    gcc-14
i386                  randconfig-016-20251023    gcc-14
i386                  randconfig-017-20251023    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251022    gcc-12.5.0
loongarch             randconfig-001-20251023    gcc-10.5.0
loongarch             randconfig-002-20251022    gcc-15.1.0
loongarch             randconfig-002-20251023    gcc-10.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251022    gcc-8.5.0
nios2                 randconfig-001-20251023    gcc-10.5.0
nios2                 randconfig-002-20251022    gcc-10.5.0
nios2                 randconfig-002-20251023    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251022    gcc-13.4.0
parisc                randconfig-001-20251023    gcc-10.5.0
parisc                randconfig-002-20251022    gcc-10.5.0
parisc                randconfig-002-20251023    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    clang-22
powerpc                     ep8248e_defconfig    clang-22
powerpc               randconfig-001-20251022    gcc-8.5.0
powerpc               randconfig-001-20251023    gcc-10.5.0
powerpc               randconfig-002-20251022    gcc-8.5.0
powerpc               randconfig-002-20251023    gcc-10.5.0
powerpc               randconfig-003-20251022    gcc-8.5.0
powerpc               randconfig-003-20251023    gcc-10.5.0
powerpc                 xes_mpc85xx_defconfig    clang-22
powerpc64             randconfig-001-20251022    gcc-8.5.0
powerpc64             randconfig-001-20251023    gcc-10.5.0
powerpc64             randconfig-002-20251022    gcc-8.5.0
powerpc64             randconfig-002-20251023    gcc-10.5.0
powerpc64             randconfig-003-20251022    clang-22
powerpc64             randconfig-003-20251023    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251023    gcc-8.5.0
riscv                 randconfig-002-20251023    gcc-14.3.0
riscv                 randconfig-002-20251023    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251023    clang-19
s390                  randconfig-001-20251023    gcc-8.5.0
s390                  randconfig-002-20251023    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.1.0
sh                     magicpanelr2_defconfig    clang-22
sh                            migor_defconfig    clang-22
sh                    randconfig-001-20251023    gcc-15.1.0
sh                    randconfig-001-20251023    gcc-8.5.0
sh                    randconfig-002-20251023    gcc-15.1.0
sh                    randconfig-002-20251023    gcc-8.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251023    gcc-12.5.0
sparc                 randconfig-001-20251023    gcc-8.5.0
sparc                 randconfig-002-20251023    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251023    clang-22
sparc64               randconfig-001-20251023    gcc-8.5.0
sparc64               randconfig-002-20251023    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251023    gcc-13
um                    randconfig-001-20251023    gcc-8.5.0
um                    randconfig-002-20251023    gcc-14
um                    randconfig-002-20251023    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251022    clang-20
x86_64      buildonly-randconfig-001-20251023    gcc-14
x86_64      buildonly-randconfig-002-20251022    gcc-14
x86_64      buildonly-randconfig-002-20251023    gcc-14
x86_64      buildonly-randconfig-003-20251022    gcc-14
x86_64      buildonly-randconfig-003-20251023    gcc-14
x86_64      buildonly-randconfig-004-20251022    clang-20
x86_64      buildonly-randconfig-004-20251023    gcc-14
x86_64      buildonly-randconfig-005-20251022    gcc-14
x86_64      buildonly-randconfig-005-20251023    gcc-14
x86_64      buildonly-randconfig-006-20251022    gcc-14
x86_64      buildonly-randconfig-006-20251023    gcc-14
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251023    clang-20
x86_64                randconfig-002-20251023    clang-20
x86_64                randconfig-003-20251023    clang-20
x86_64                randconfig-004-20251023    clang-20
x86_64                randconfig-005-20251023    clang-20
x86_64                randconfig-006-20251023    clang-20
x86_64                randconfig-007-20251023    clang-20
x86_64                randconfig-008-20251023    clang-20
x86_64                randconfig-071-20251023    clang-20
x86_64                randconfig-072-20251023    clang-20
x86_64                randconfig-073-20251023    clang-20
x86_64                randconfig-074-20251023    clang-20
x86_64                randconfig-075-20251023    clang-20
x86_64                randconfig-076-20251023    clang-20
x86_64                randconfig-077-20251023    clang-20
x86_64                randconfig-078-20251023    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    clang-22
xtensa                randconfig-001-20251023    gcc-8.5.0
xtensa                randconfig-002-20251023    gcc-13.4.0
xtensa                randconfig-002-20251023    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

