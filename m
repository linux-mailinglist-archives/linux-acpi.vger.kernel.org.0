Return-Path: <linux-acpi+bounces-15087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05CCB00442
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 15:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBF11899225
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1125B272E72;
	Thu, 10 Jul 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOLObvEb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BD1272E6F;
	Thu, 10 Jul 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155295; cv=none; b=nz72OMebGUQJZXfOM5BqoDqNvaXFWY2JDirxYz5nxNFSIldImxWQow454JZAvjIKNuW+7Rqd4SzbHJ5vYvdXdGKHFaAmTqY8Ok3TX7Kt0M8GBmVwGNHYkgoDs11Mn8Fycvs1gPa0KiNLTPKd+aMcYcr28USV5P2AraMw7Dc8U7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155295; c=relaxed/simple;
	bh=PMSc5VdNaPPWTuQloHYgEhdjqguJGLH5ofLPlh3TagY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RpYT5/DEPuDBcdS55MtChnVC0bviTjNsI5k/QkzvPINW3BhxLVaih0CB7p7I9xOxW6N1pRPl6W+s1coqnnsA9gDrfMiuf3Jf3usEhEMxO75phPAjCvH4VuVJjU4OawuPuDBxqn3op15ijQSY5lRC4YlP3Iwt3+xq4m1hkatAQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOLObvEb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752155293; x=1783691293;
  h=date:from:to:cc:subject:message-id;
  bh=PMSc5VdNaPPWTuQloHYgEhdjqguJGLH5ofLPlh3TagY=;
  b=IOLObvEbfe/HvsctmUOsocWcG9xPwr+PC8AGXerLzXb0Z7pXaOrXPRiI
   w32Ku5rfQRTnf4haqnTK9jxW+Ap7naIoVl7j3ibgLLt+Wxu2LzUS/xmJk
   MxWYSdelJaCEDsQhq3t8rdQI8iwVCIwUcYazyYPm2p9aNIQtq+U7isQDq
   kPaHrDZn3zGmSzFivJau7q3Wbapfx9iBdrMqnmFhr3H3wOFIfudoHGbWa
   rG2N35pJz8WWfATggAVFLlaZoC+vgJJzmJA+4QoD1oL45eVRhCyfLf9o6
   s5rf8omXLayJvTlmn5KCDowyeLpe2YpRwuKTYYsASrVM8PMETJx19Gd0m
   g==;
X-CSE-ConnectionGUID: 4EKrtgAmSFysRa0VQO1a2g==
X-CSE-MsgGUID: yUeLL+JIQficE6222ihDxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57047230"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="57047230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:48:12 -0700
X-CSE-ConnectionGUID: UIlU+8pqTnyIr30Q6OHvZw==
X-CSE-MsgGUID: Cbm40NHHS0O+YzgNDnufyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156194202"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Jul 2025 06:48:10 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZrdA-00055P-1N;
	Thu, 10 Jul 2025 13:48:08 +0000
Date: Thu, 10 Jul 2025 21:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 62f8261c6e4955a8d85e779dc32977ad4c6733f3
Message-ID: <202507102135.Z8ggJeLD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 62f8261c6e4955a8d85e779dc32977ad4c6733f3  Merge branch 'pm-sleep-fixes' into fixes

elapsed time: 978m

configs tested: 222
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250710    clang-21
arc                   randconfig-001-20250710    gcc-15.1.0
arc                   randconfig-002-20250710    clang-21
arc                   randconfig-002-20250710    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                       multi_v4t_defconfig    gcc-15.1.0
arm                   randconfig-001-20250710    clang-21
arm                   randconfig-001-20250710    gcc-8.5.0
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250710    clang-21
arm                   randconfig-004-20250710    gcc-8.5.0
arm                           sama7_defconfig    gcc-15.1.0
arm                        spear6xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250710    clang-21
arm64                 randconfig-003-20250710    gcc-8.5.0
arm64                 randconfig-004-20250710    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250710    clang-21
hexagon               randconfig-001-20250710    gcc-15.1.0
hexagon               randconfig-002-20250710    clang-21
hexagon               randconfig-002-20250710    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250710    clang-20
i386        buildonly-randconfig-001-20250710    gcc-12
i386        buildonly-randconfig-002-20250710    clang-20
i386        buildonly-randconfig-002-20250710    gcc-12
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-004-20250710    clang-20
i386        buildonly-randconfig-004-20250710    gcc-11
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-006-20250710    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250710    gcc-12
i386                  randconfig-002-20250710    gcc-12
i386                  randconfig-003-20250710    gcc-12
i386                  randconfig-004-20250710    gcc-12
i386                  randconfig-005-20250710    gcc-12
i386                  randconfig-006-20250710    gcc-12
i386                  randconfig-007-20250710    gcc-12
i386                  randconfig-011-20250710    clang-20
i386                  randconfig-012-20250710    clang-20
i386                  randconfig-013-20250710    clang-20
i386                  randconfig-014-20250710    clang-20
i386                  randconfig-015-20250710    clang-20
i386                  randconfig-016-20250710    clang-20
i386                  randconfig-017-20250710    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250710    gcc-14.3.0
loongarch             randconfig-001-20250710    gcc-15.1.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250710    gcc-15.1.0
nios2                 randconfig-001-20250710    gcc-9.3.0
nios2                 randconfig-002-20250710    gcc-12.4.0
nios2                 randconfig-002-20250710    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-8.5.0
parisc                randconfig-002-20250710    gcc-15.1.0
parisc                randconfig-002-20250710    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250710    gcc-12.4.0
powerpc               randconfig-001-20250710    gcc-15.1.0
powerpc               randconfig-002-20250710    gcc-15.1.0
powerpc               randconfig-002-20250710    gcc-9.3.0
powerpc               randconfig-003-20250710    gcc-15.1.0
powerpc               randconfig-003-20250710    gcc-8.5.0
powerpc64             randconfig-001-20250710    gcc-11.5.0
powerpc64             randconfig-001-20250710    gcc-15.1.0
powerpc64             randconfig-002-20250710    clang-17
powerpc64             randconfig-002-20250710    gcc-15.1.0
powerpc64             randconfig-003-20250710    gcc-14.3.0
powerpc64             randconfig-003-20250710    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250710    gcc-12.4.0
riscv                 randconfig-001-20250710    gcc-15.1.0
riscv                 randconfig-002-20250710    gcc-10.5.0
riscv                 randconfig-002-20250710    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250710    gcc-12.4.0
s390                  randconfig-001-20250710    gcc-14.3.0
s390                  randconfig-002-20250710    clang-17
s390                  randconfig-002-20250710    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250710    gcc-12.4.0
sh                    randconfig-001-20250710    gcc-15.1.0
sh                    randconfig-002-20250710    gcc-12.4.0
sh                    randconfig-002-20250710    gcc-13.4.0
sh                          rsk7203_defconfig    gcc-15.1.0
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-12.4.0
sparc                 randconfig-001-20250710    gcc-13.4.0
sparc                 randconfig-002-20250710    gcc-12.4.0
sparc                 randconfig-002-20250710    gcc-14.3.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250710    gcc-12.4.0
sparc64               randconfig-001-20250710    gcc-8.5.0
sparc64               randconfig-002-20250710    gcc-12.4.0
sparc64               randconfig-002-20250710    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250710    gcc-11
um                    randconfig-001-20250710    gcc-12.4.0
um                    randconfig-002-20250710    clang-16
um                    randconfig-002-20250710    gcc-12.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250710    clang-20
x86_64      buildonly-randconfig-001-20250710    gcc-12
x86_64      buildonly-randconfig-002-20250710    clang-20
x86_64      buildonly-randconfig-002-20250710    gcc-12
x86_64      buildonly-randconfig-003-20250710    clang-20
x86_64      buildonly-randconfig-003-20250710    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250710    gcc-12
x86_64                randconfig-002-20250710    gcc-12
x86_64                randconfig-003-20250710    gcc-12
x86_64                randconfig-004-20250710    gcc-12
x86_64                randconfig-005-20250710    gcc-12
x86_64                randconfig-006-20250710    gcc-12
x86_64                randconfig-007-20250710    gcc-12
x86_64                randconfig-008-20250710    gcc-12
x86_64                randconfig-071-20250710    gcc-11
x86_64                randconfig-072-20250710    gcc-11
x86_64                randconfig-073-20250710    gcc-11
x86_64                randconfig-074-20250710    gcc-11
x86_64                randconfig-075-20250710    gcc-11
x86_64                randconfig-076-20250710    gcc-11
x86_64                randconfig-077-20250710    gcc-11
x86_64                randconfig-078-20250710    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

