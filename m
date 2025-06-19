Return-Path: <linux-acpi+bounces-14469-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4DDAE0976
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CF97A44ED
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938A23536B;
	Thu, 19 Jun 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYYYT7hj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6021E0AF;
	Thu, 19 Jun 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345030; cv=none; b=eDkmNWUQ9Wxp+fX0FPKfx1CwtMDxt8ou/GT1K7OuoJh67h1/Fe49cKsrrfFMmRQuxs5C2arHGSmCyzBu+Ni0xw7vmczgkYUTpeOv1So9HyuO2nvps2oq0rTcZWhvo0DWTmIhYSvcCxTbJf3pLGLJKATyhNRvIul/6Pcj2h3ljv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345030; c=relaxed/simple;
	bh=4fVId7INh6XF7ZHXFd2eg086ZY1YLJ0QfrmO1VPA3/Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mY03HjARkDkkw/8AwbMwT0YcExzXtWHDvLxFqf1vd/yTpkywUPHBamP1SrtIDZshEagTCPvkzKamoNJceqCvWxOPJj5qWHPAvUB2zIFTViHhL1UQxvsiySmkbuQR6Av81J2ZBumbss+cjHM/LHDIU2tT3/gA98YuZ287kqcMGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYYYT7hj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750345028; x=1781881028;
  h=date:from:to:cc:subject:message-id;
  bh=4fVId7INh6XF7ZHXFd2eg086ZY1YLJ0QfrmO1VPA3/Q=;
  b=OYYYT7hjzmunRNl0eXLy6Q0/sfdv8zWqRQnSrSWk5VDL2i5qAHvMuD3W
   CVDUa9fm/7ISov/ZvQ2jcpEQhjA1jKCecSwxUYYEN+O4f3XuMXuFPJ/SM
   VMwUk7me1cEiq8Af8PK3VraPPTQiIGx0TfBnHejzj49JLnXdJa/0/I4t0
   Q2KLRvZp8+136xrO8qKEKn8U2rA57MdShqvGDfw2p7luaZh932xcX0opm
   kIcXTmo6Upn6uZhz23GWza3A9TQ4AfCOYpZKg6T0JE0Ol15wXyzolhiE7
   s0E8ETk0denF1q1VbsBrXJms1MiASVeYKbptz6cUUoNOdMoEBO8hj4s5s
   A==;
X-CSE-ConnectionGUID: w+0Q8W6ER1qGN0vOFUHhvQ==
X-CSE-MsgGUID: e2tnxWeGRy26IPn/3s8+Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="64032261"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="64032261"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 07:57:08 -0700
X-CSE-ConnectionGUID: fCQypnsHQaK9TLeoefVlwA==
X-CSE-MsgGUID: jCLLDp9tSJGgnRBEatotfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="151371600"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Jun 2025 07:57:06 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSGhL-000KqS-2C;
	Thu, 19 Jun 2025 14:57:03 +0000
Date: Thu, 19 Jun 2025 22:56:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e7ee7d2f3ba5ea96a3f4027575025b57d4bd8e5f
Message-ID: <202506192218.N92wHTtN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e7ee7d2f3ba5ea96a3f4027575025b57d4bd8e5f  Merge branch 'pm-runtime' into bleeding-edge

elapsed time: 1087m

configs tested: 218
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250619    gcc-15.1.0
arc                   randconfig-002-20250619    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                         bcm2835_defconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                          pxa910_defconfig    clang-21
arm                   randconfig-001-20250619    clang-21
arm                   randconfig-001-20250619    gcc-15.1.0
arm                   randconfig-002-20250619    gcc-15.1.0
arm                   randconfig-002-20250619    gcc-8.5.0
arm                   randconfig-003-20250619    gcc-15.1.0
arm                   randconfig-003-20250619    gcc-8.5.0
arm                   randconfig-004-20250619    gcc-10.5.0
arm                   randconfig-004-20250619    gcc-15.1.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250619    gcc-15.1.0
arm64                 randconfig-001-20250619    gcc-8.5.0
arm64                 randconfig-002-20250619    gcc-15.1.0
arm64                 randconfig-002-20250619    gcc-9.5.0
arm64                 randconfig-003-20250619    gcc-10.5.0
arm64                 randconfig-003-20250619    gcc-15.1.0
arm64                 randconfig-004-20250619    gcc-10.5.0
arm64                 randconfig-004-20250619    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250619    gcc-11.5.0
csky                  randconfig-001-20250619    gcc-8.5.0
csky                  randconfig-002-20250619    gcc-8.5.0
csky                  randconfig-002-20250619    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250619    clang-21
hexagon               randconfig-001-20250619    gcc-8.5.0
hexagon               randconfig-002-20250619    clang-21
hexagon               randconfig-002-20250619    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250619    gcc-12
i386        buildonly-randconfig-002-20250619    gcc-12
i386        buildonly-randconfig-003-20250619    clang-20
i386        buildonly-randconfig-004-20250619    clang-20
i386        buildonly-randconfig-005-20250619    clang-20
i386        buildonly-randconfig-006-20250619    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250619    gcc-12
i386                  randconfig-002-20250619    gcc-12
i386                  randconfig-003-20250619    gcc-12
i386                  randconfig-004-20250619    gcc-12
i386                  randconfig-005-20250619    gcc-12
i386                  randconfig-006-20250619    gcc-12
i386                  randconfig-007-20250619    gcc-12
i386                  randconfig-011-20250619    clang-20
i386                  randconfig-012-20250619    clang-20
i386                  randconfig-013-20250619    clang-20
i386                  randconfig-014-20250619    clang-20
i386                  randconfig-015-20250619    clang-20
i386                  randconfig-016-20250619    clang-20
i386                  randconfig-017-20250619    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250619    gcc-15.1.0
loongarch             randconfig-001-20250619    gcc-8.5.0
loongarch             randconfig-002-20250619    gcc-15.1.0
loongarch             randconfig-002-20250619    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-21
mips                           ip32_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250619    gcc-8.5.0
nios2                 randconfig-002-20250619    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250619    gcc-11.5.0
parisc                randconfig-001-20250619    gcc-8.5.0
parisc                randconfig-002-20250619    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-21
powerpc                      katmai_defconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc               randconfig-001-20250619    gcc-8.5.0
powerpc               randconfig-001-20250619    gcc-9.3.0
powerpc               randconfig-002-20250619    clang-21
powerpc               randconfig-002-20250619    gcc-8.5.0
powerpc               randconfig-003-20250619    gcc-10.5.0
powerpc               randconfig-003-20250619    gcc-8.5.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250619    gcc-11.5.0
powerpc64             randconfig-001-20250619    gcc-8.5.0
powerpc64             randconfig-002-20250619    clang-21
powerpc64             randconfig-002-20250619    gcc-8.5.0
powerpc64             randconfig-003-20250619    gcc-10.5.0
powerpc64             randconfig-003-20250619    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250619    gcc-11.5.0
riscv                 randconfig-001-20250619    gcc-9.3.0
riscv                 randconfig-002-20250619    clang-16
riscv                 randconfig-002-20250619    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250619    clang-19
s390                  randconfig-001-20250619    gcc-9.3.0
s390                  randconfig-002-20250619    gcc-13.2.0
s390                  randconfig-002-20250619    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250619    gcc-9.3.0
sh                    randconfig-002-20250619    gcc-9.3.0
sh                           se7206_defconfig    clang-21
sh                   sh7724_generic_defconfig    clang-21
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250619    gcc-14.3.0
sparc                 randconfig-001-20250619    gcc-9.3.0
sparc                 randconfig-002-20250619    gcc-10.3.0
sparc                 randconfig-002-20250619    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250619    gcc-13.3.0
sparc64               randconfig-001-20250619    gcc-9.3.0
sparc64               randconfig-002-20250619    gcc-8.5.0
sparc64               randconfig-002-20250619    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250619    clang-19
um                    randconfig-001-20250619    gcc-9.3.0
um                    randconfig-002-20250619    clang-21
um                    randconfig-002-20250619    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250619    clang-20
x86_64      buildonly-randconfig-001-20250619    gcc-12
x86_64      buildonly-randconfig-002-20250619    gcc-12
x86_64      buildonly-randconfig-003-20250619    clang-20
x86_64      buildonly-randconfig-003-20250619    gcc-12
x86_64      buildonly-randconfig-004-20250619    gcc-12
x86_64      buildonly-randconfig-005-20250619    clang-20
x86_64      buildonly-randconfig-005-20250619    gcc-12
x86_64      buildonly-randconfig-006-20250619    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250619    gcc-11
x86_64                randconfig-002-20250619    gcc-11
x86_64                randconfig-003-20250619    gcc-11
x86_64                randconfig-004-20250619    gcc-11
x86_64                randconfig-005-20250619    gcc-11
x86_64                randconfig-006-20250619    gcc-11
x86_64                randconfig-007-20250619    gcc-11
x86_64                randconfig-008-20250619    gcc-11
x86_64                randconfig-071-20250619    clang-20
x86_64                randconfig-072-20250619    clang-20
x86_64                randconfig-073-20250619    clang-20
x86_64                randconfig-074-20250619    clang-20
x86_64                randconfig-075-20250619    clang-20
x86_64                randconfig-076-20250619    clang-20
x86_64                randconfig-077-20250619    clang-20
x86_64                randconfig-078-20250619    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250619    gcc-9.3.0
xtensa                randconfig-002-20250619    gcc-8.5.0
xtensa                randconfig-002-20250619    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

