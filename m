Return-Path: <linux-acpi+bounces-6778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15868928DC2
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 21:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E541F22E3C
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 19:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8F16A930;
	Fri,  5 Jul 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTh4q0S1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028A18AF4;
	Fri,  5 Jul 2024 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720207443; cv=none; b=U+mlO8xXjwE1NzFOEHbTOjtVeZbY7V0I0J41RXOocrOQ5uoH0Ud68CB+RRfJGY6OTKo2HuM61ye2e2YwIm755MNotBwUIZZ09TZ7cbZLcyjOP/LwiJfxfGQy2Wpg5zElWshkuDFXAqC2TicF5mjoITiQgWiUFe+T4/HCxDwVrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720207443; c=relaxed/simple;
	bh=f2zCONOHjdq6i93JwY6VsNj28xrlK3RPYesveMG3jWo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WMmq3xJL6o8O0z49i6IyAbzQcwKG56qUbpFIlq/kMu61VgYqNo18GBxnh6FpIA8mGjiGz0tsalmfY3eQBmg2TvHiDuwaKtQfKM18beBuaztlC3t0MrOZKRAhTM8rVhax3VB9kum2fM/xomNmdTSxiKiK62UDswp8zFpjJSOYCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTh4q0S1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720207441; x=1751743441;
  h=date:from:to:cc:subject:message-id;
  bh=f2zCONOHjdq6i93JwY6VsNj28xrlK3RPYesveMG3jWo=;
  b=VTh4q0S19oXeiZCuyC+5qIljr4v44ihfPVAD66RQSkGnXHQaRqpmPXZs
   r2urgcKYYr31FUovFdVviiKwtL+I78X59MT2+/YBVLgyMteaeKHebdBWu
   0w04kb63HSdGguypVy++GqMDZWr3yTx5Qy5WtlWKqqZcR1A1/ye8OB/Lc
   SLPM/A8YyGO+vqAmLmyXz8B4l3VKmUQy3ioHdfh0WACPUX8YaYM0cuOxd
   yBYpQg0dEbyxXi/gD08Q5l/phnlSgfFBg9c/bn64wIcUrBHSOc2O0M84s
   c8G6s3gGypCiCUryIFtUt2KyMBWp9DTcIy9zYIC14GLvf3wuyhdajrDee
   g==;
X-CSE-ConnectionGUID: u9S0Vam5RP+ZPvLshP3pAw==
X-CSE-MsgGUID: LJWT/3ZbSX+qt1um0IshNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28894628"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="28894628"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 12:24:01 -0700
X-CSE-ConnectionGUID: zQUWBqLiTbKw3RTnoGxQ4g==
X-CSE-MsgGUID: SMQGu9VjRHevRPMdypt9BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="51284366"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 Jul 2024 12:23:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPoXF-000SlA-0J;
	Fri, 05 Jul 2024 19:23:57 +0000
Date: Sat, 06 Jul 2024 03:23:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 375cf1e8ce4fafedf04a97482f88b3ff10035b51
Message-ID: <202407060338.pCY4347l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 375cf1e8ce4fafedf04a97482f88b3ff10035b51  Merge branch 'acpi-video' into bleeding-edge

elapsed time: 1452m

configs tested: 228
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240705   gcc-13.2.0
arc                   randconfig-002-20240705   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240705   gcc-13.2.0
arm                   randconfig-002-20240705   gcc-13.2.0
arm                   randconfig-003-20240705   gcc-13.2.0
arm                   randconfig-004-20240705   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240705   clang-19
arm64                 randconfig-001-20240705   gcc-13.2.0
arm64                 randconfig-002-20240705   clang-19
arm64                 randconfig-002-20240705   gcc-13.2.0
arm64                 randconfig-003-20240705   clang-19
arm64                 randconfig-003-20240705   gcc-13.2.0
arm64                 randconfig-004-20240705   clang-19
arm64                 randconfig-004-20240705   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240705   gcc-13.2.0
csky                  randconfig-002-20240705   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240705   clang-19
hexagon               randconfig-002-20240705   clang-17
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240705   gcc-13
i386         buildonly-randconfig-002-20240705   gcc-13
i386         buildonly-randconfig-002-20240705   gcc-9
i386         buildonly-randconfig-003-20240705   gcc-11
i386         buildonly-randconfig-003-20240705   gcc-13
i386         buildonly-randconfig-004-20240705   clang-18
i386         buildonly-randconfig-004-20240705   gcc-13
i386         buildonly-randconfig-005-20240705   clang-18
i386         buildonly-randconfig-005-20240705   gcc-13
i386         buildonly-randconfig-006-20240705   clang-18
i386         buildonly-randconfig-006-20240705   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240705   gcc-13
i386                  randconfig-002-20240705   clang-18
i386                  randconfig-002-20240705   gcc-13
i386                  randconfig-003-20240705   gcc-11
i386                  randconfig-003-20240705   gcc-13
i386                  randconfig-004-20240705   gcc-13
i386                  randconfig-005-20240705   clang-18
i386                  randconfig-005-20240705   gcc-13
i386                  randconfig-006-20240705   clang-18
i386                  randconfig-006-20240705   gcc-13
i386                  randconfig-011-20240705   gcc-13
i386                  randconfig-012-20240705   gcc-13
i386                  randconfig-013-20240705   clang-18
i386                  randconfig-013-20240705   gcc-13
i386                  randconfig-014-20240705   gcc-13
i386                  randconfig-014-20240705   gcc-8
i386                  randconfig-015-20240705   gcc-10
i386                  randconfig-015-20240705   gcc-13
i386                  randconfig-016-20240705   clang-18
i386                  randconfig-016-20240705   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240705   gcc-13.2.0
loongarch             randconfig-002-20240705   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                          rb532_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240705   gcc-13.2.0
nios2                 randconfig-002-20240705   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240705   gcc-13.2.0
parisc                randconfig-002-20240705   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                      ppc64e_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240705   gcc-13.2.0
powerpc               randconfig-002-20240705   clang-19
powerpc               randconfig-003-20240705   clang-19
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240705   gcc-13.2.0
powerpc64             randconfig-002-20240705   clang-19
powerpc64             randconfig-002-20240705   gcc-13.2.0
powerpc64             randconfig-003-20240705   clang-19
powerpc64             randconfig-003-20240705   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240705   gcc-13.2.0
riscv                 randconfig-002-20240705   clang-19
riscv                 randconfig-002-20240705   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240705   gcc-13.2.0
s390                  randconfig-002-20240705   clang-16
s390                  randconfig-002-20240705   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240705   gcc-13.2.0
sh                    randconfig-002-20240705   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240705   gcc-13.2.0
sparc64               randconfig-002-20240705   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240705   clang-19
um                    randconfig-001-20240705   gcc-13.2.0
um                    randconfig-002-20240705   clang-15
um                    randconfig-002-20240705   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240705   gcc-7
x86_64       buildonly-randconfig-002-20240705   gcc-13
x86_64       buildonly-randconfig-002-20240705   gcc-7
x86_64       buildonly-randconfig-003-20240705   clang-18
x86_64       buildonly-randconfig-003-20240705   gcc-7
x86_64       buildonly-randconfig-004-20240705   clang-18
x86_64       buildonly-randconfig-004-20240705   gcc-7
x86_64       buildonly-randconfig-005-20240705   clang-18
x86_64       buildonly-randconfig-005-20240705   gcc-7
x86_64       buildonly-randconfig-006-20240705   clang-18
x86_64       buildonly-randconfig-006-20240705   gcc-7
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240705   clang-18
x86_64                randconfig-001-20240705   gcc-7
x86_64                randconfig-002-20240705   gcc-13
x86_64                randconfig-002-20240705   gcc-7
x86_64                randconfig-003-20240705   clang-18
x86_64                randconfig-003-20240705   gcc-7
x86_64                randconfig-004-20240705   gcc-13
x86_64                randconfig-004-20240705   gcc-7
x86_64                randconfig-005-20240705   gcc-13
x86_64                randconfig-005-20240705   gcc-7
x86_64                randconfig-006-20240705   gcc-13
x86_64                randconfig-006-20240705   gcc-7
x86_64                randconfig-011-20240705   clang-18
x86_64                randconfig-011-20240705   gcc-7
x86_64                randconfig-012-20240705   gcc-7
x86_64                randconfig-012-20240705   gcc-9
x86_64                randconfig-013-20240705   clang-18
x86_64                randconfig-013-20240705   gcc-7
x86_64                randconfig-014-20240705   gcc-13
x86_64                randconfig-014-20240705   gcc-7
x86_64                randconfig-015-20240705   clang-18
x86_64                randconfig-015-20240705   gcc-7
x86_64                randconfig-016-20240705   gcc-7
x86_64                randconfig-016-20240705   gcc-9
x86_64                randconfig-071-20240705   gcc-13
x86_64                randconfig-071-20240705   gcc-7
x86_64                randconfig-072-20240705   gcc-13
x86_64                randconfig-072-20240705   gcc-7
x86_64                randconfig-073-20240705   clang-18
x86_64                randconfig-073-20240705   gcc-7
x86_64                randconfig-074-20240705   gcc-13
x86_64                randconfig-074-20240705   gcc-7
x86_64                randconfig-075-20240705   clang-18
x86_64                randconfig-075-20240705   gcc-7
x86_64                randconfig-076-20240705   clang-18
x86_64                randconfig-076-20240705   gcc-7
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240705   gcc-13.2.0
xtensa                randconfig-002-20240705   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

