Return-Path: <linux-acpi+bounces-20353-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C77D21D78
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 01:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5304A3016CFF
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 00:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24671E49F;
	Thu, 15 Jan 2026 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHit+KfN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D263D76;
	Thu, 15 Jan 2026 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768436557; cv=none; b=TSzij/Wb9Q6zWjReSCLhWhgDqDWFFoVggqaLmcc8S8eiTQpmgLHiKl60kB+40Ly7/KrPNTrdNHe4qT4CToMf8SZg3BevsTn9iBE7bHEybCmqZLXQtEuW4jyUfxEpyIlbwTM8TvDAd0u6KrDw4Ck7SmLEbmy9XGl8ELJyJtS6vI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768436557; c=relaxed/simple;
	bh=zTGcYbTgQK1SeLlhAEM4KkRoQ5oRGJmT71KsFb/ltwo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qdyMHar2OTL69DCObmjgrFTFP/j1yKXHSGxst8hfpn0hLmBkpMZEXWz72K+eliZ++dK0Qu5h7q0nUxdi0kNsLzgfosGMezNO9hxKNUpLqDRMSCvFqVcCdC2WJENxcTIrLi/R7Zdks0r+0xG53PlP/WZ9eAUuyWxlKUT6d4tzAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHit+KfN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768436555; x=1799972555;
  h=date:from:to:cc:subject:message-id;
  bh=zTGcYbTgQK1SeLlhAEM4KkRoQ5oRGJmT71KsFb/ltwo=;
  b=PHit+KfNNmL/3lofYCiSll7pVq7UVLfmoS8mtFpO8EIVl1OaYCt/6xcL
   HkaV9nyuGxmvMDAZnRf9+ReZBGQWDmwIYy8ALA5mepAQBIyonc974w1sw
   kkUUwW1sAZ9nLt92T6VyiAgOwPXYuoW3xlP7ha/P9YRWX7rWrJGk9ePlr
   EL8HgyBlNT2EIT9iz6sKqGt615YJfaxCyfgu1RzvLei+BO/TbkK0LU4/R
   bkoq/s4mrKKSLXICfppVK9qRKr5L6Ri4VB0cuDpCGCjwhJlAvB7Nhnrzl
   1TrJGL9NjDTg1lMtCoBW9uYHhbu9Y4mEhBOzzc3B3klWdQ4mpqjtzJR4q
   A==;
X-CSE-ConnectionGUID: 3nt8WgurRzisT6vnP45GsA==
X-CSE-MsgGUID: 131BXvabTyKY6CmR3atLRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80854872"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="80854872"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 16:22:35 -0800
X-CSE-ConnectionGUID: ZMcDAXajTtCvXU67y6KtWQ==
X-CSE-MsgGUID: PsOMrvTITKiuBdBkcIV1gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="205234796"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Jan 2026 16:22:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgB8B-00000000HFA-085a;
	Thu, 15 Jan 2026 00:22:31 +0000
Date: Thu, 15 Jan 2026 08:21:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 4c96ec13fcaee154368f19887f7f84985ef605bc
Message-ID: <202601150844.5EVGGRtN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 4c96ec13fcaee154368f19887f7f84985ef605bc  Merge branch 'acpi-pm-fixes' into fixes

elapsed time: 731m

configs tested: 256
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-22
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260114    gcc-10.5.0
arc                   randconfig-001-20260115    clang-22
arc                   randconfig-002-20260114    gcc-10.5.0
arc                   randconfig-002-20260115    clang-22
arc                    vdk_hs38_smp_defconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    clang-22
arm                          moxart_defconfig    clang-22
arm                          pxa168_defconfig    gcc-15.2.0
arm                   randconfig-001-20260114    gcc-10.5.0
arm                   randconfig-001-20260115    clang-22
arm                   randconfig-002-20260114    gcc-10.5.0
arm                   randconfig-002-20260115    clang-22
arm                   randconfig-003-20260114    gcc-10.5.0
arm                   randconfig-003-20260115    clang-22
arm                   randconfig-004-20260114    gcc-10.5.0
arm                   randconfig-004-20260115    clang-22
arm                           sama7_defconfig    clang-22
arm                        shmobile_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260114    clang-22
arm64                 randconfig-001-20260115    clang-22
arm64                 randconfig-002-20260114    clang-22
arm64                 randconfig-002-20260115    clang-22
arm64                 randconfig-003-20260114    clang-22
arm64                 randconfig-003-20260115    clang-22
arm64                 randconfig-004-20260114    clang-22
arm64                 randconfig-004-20260115    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260114    clang-22
csky                  randconfig-001-20260115    clang-22
csky                  randconfig-002-20260114    clang-22
csky                  randconfig-002-20260115    clang-22
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260114    clang-22
hexagon               randconfig-001-20260115    clang-22
hexagon               randconfig-002-20260114    clang-22
hexagon               randconfig-002-20260115    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260114    gcc-14
i386        buildonly-randconfig-001-20260115    gcc-14
i386        buildonly-randconfig-002-20260114    gcc-14
i386        buildonly-randconfig-002-20260115    gcc-14
i386        buildonly-randconfig-003-20260114    gcc-14
i386        buildonly-randconfig-003-20260115    gcc-14
i386        buildonly-randconfig-004-20260114    gcc-14
i386        buildonly-randconfig-004-20260115    gcc-14
i386        buildonly-randconfig-005-20260114    gcc-14
i386        buildonly-randconfig-005-20260115    gcc-14
i386        buildonly-randconfig-006-20260114    gcc-14
i386        buildonly-randconfig-006-20260115    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260114    gcc-14
i386                  randconfig-001-20260115    clang-20
i386                  randconfig-002-20260114    gcc-14
i386                  randconfig-002-20260115    clang-20
i386                  randconfig-003-20260114    gcc-14
i386                  randconfig-003-20260115    clang-20
i386                  randconfig-004-20260114    gcc-14
i386                  randconfig-004-20260115    clang-20
i386                  randconfig-005-20260114    gcc-14
i386                  randconfig-005-20260115    clang-20
i386                  randconfig-006-20260114    gcc-14
i386                  randconfig-006-20260115    clang-20
i386                  randconfig-007-20260114    gcc-14
i386                  randconfig-007-20260115    clang-20
i386                  randconfig-011-20260115    gcc-14
i386                  randconfig-012-20260115    gcc-14
i386                  randconfig-013-20260115    gcc-14
i386                  randconfig-014-20260115    gcc-14
i386                  randconfig-015-20260115    gcc-14
i386                  randconfig-016-20260115    gcc-14
i386                  randconfig-017-20260115    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260114    clang-22
loongarch             randconfig-001-20260115    clang-22
loongarch             randconfig-002-20260114    clang-22
loongarch             randconfig-002-20260115    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath79_defconfig    gcc-15.2.0
mips                         db1xxx_defconfig    clang-22
mips                      pic32mzda_defconfig    clang-22
mips                          rb532_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260114    clang-22
nios2                 randconfig-001-20260115    clang-22
nios2                 randconfig-002-20260114    clang-22
nios2                 randconfig-002-20260115    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    clang-22
parisc                generic-64bit_defconfig    clang-22
parisc                generic-64bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260114    gcc-10.5.0
parisc                randconfig-001-20260114    gcc-14.3.0
parisc                randconfig-001-20260115    clang-22
parisc                randconfig-002-20260114    gcc-13.4.0
parisc                randconfig-002-20260114    gcc-14.3.0
parisc                randconfig-002-20260115    clang-22
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    clang-22
powerpc                    adder875_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                    gamecube_defconfig    clang-22
powerpc                 linkstation_defconfig    clang-22
powerpc                     rainier_defconfig    clang-22
powerpc               randconfig-001-20260114    gcc-11.5.0
powerpc               randconfig-001-20260114    gcc-14.3.0
powerpc               randconfig-001-20260115    clang-22
powerpc               randconfig-002-20260114    gcc-12.5.0
powerpc               randconfig-002-20260114    gcc-14.3.0
powerpc               randconfig-002-20260115    clang-22
powerpc                      tqm8xx_defconfig    clang-22
powerpc                         wii_defconfig    clang-22
powerpc                 xes_mpc85xx_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260114    gcc-14.3.0
powerpc64             randconfig-001-20260115    clang-22
powerpc64             randconfig-002-20260114    gcc-14.3.0
powerpc64             randconfig-002-20260114    gcc-8.5.0
powerpc64             randconfig-002-20260115    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260115    gcc-10.5.0
riscv                 randconfig-002-20260115    gcc-10.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260115    gcc-10.5.0
s390                  randconfig-002-20260115    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          r7785rp_defconfig    clang-22
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260115    gcc-10.5.0
sh                    randconfig-002-20260115    gcc-10.5.0
sh                           se7721_defconfig    gcc-15.2.0
sh                           se7722_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260115    clang-22
sparc                 randconfig-002-20260115    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260115    clang-22
sparc64               randconfig-002-20260115    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260115    clang-22
um                    randconfig-002-20260115    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260114    clang-20
x86_64      buildonly-randconfig-001-20260115    clang-20
x86_64      buildonly-randconfig-002-20260114    clang-20
x86_64      buildonly-randconfig-002-20260115    clang-20
x86_64      buildonly-randconfig-003-20260114    clang-20
x86_64      buildonly-randconfig-003-20260115    clang-20
x86_64      buildonly-randconfig-004-20260114    clang-20
x86_64      buildonly-randconfig-004-20260115    clang-20
x86_64      buildonly-randconfig-005-20260114    clang-20
x86_64      buildonly-randconfig-005-20260115    clang-20
x86_64      buildonly-randconfig-006-20260114    clang-20
x86_64      buildonly-randconfig-006-20260115    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260114    gcc-14
x86_64                randconfig-001-20260115    clang-20
x86_64                randconfig-002-20260114    gcc-14
x86_64                randconfig-002-20260115    clang-20
x86_64                randconfig-003-20260114    gcc-14
x86_64                randconfig-003-20260115    clang-20
x86_64                randconfig-004-20260114    gcc-14
x86_64                randconfig-004-20260115    clang-20
x86_64                randconfig-005-20260114    gcc-14
x86_64                randconfig-005-20260115    clang-20
x86_64                randconfig-006-20260114    gcc-14
x86_64                randconfig-006-20260115    clang-20
x86_64                randconfig-011-20260114    gcc-14
x86_64                randconfig-011-20260115    clang-20
x86_64                randconfig-012-20260114    gcc-14
x86_64                randconfig-012-20260115    clang-20
x86_64                randconfig-013-20260114    gcc-14
x86_64                randconfig-013-20260115    clang-20
x86_64                randconfig-014-20260114    gcc-14
x86_64                randconfig-014-20260115    clang-20
x86_64                randconfig-015-20260114    gcc-14
x86_64                randconfig-015-20260115    clang-20
x86_64                randconfig-016-20260114    gcc-14
x86_64                randconfig-016-20260115    clang-20
x86_64                randconfig-071-20260115    gcc-14
x86_64                randconfig-072-20260115    gcc-14
x86_64                randconfig-073-20260115    gcc-14
x86_64                randconfig-074-20260115    gcc-14
x86_64                randconfig-075-20260115    gcc-14
x86_64                randconfig-076-20260115    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260115    clang-22
xtensa                randconfig-002-20260115    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

