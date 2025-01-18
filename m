Return-Path: <linux-acpi+bounces-10751-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59EA15EED
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jan 2025 22:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8E116598E
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jan 2025 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5448714F9FD;
	Sat, 18 Jan 2025 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxUgl/BK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46416EB54;
	Sat, 18 Jan 2025 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737236049; cv=none; b=RLGKbxHEd6oy1Pz6SONQvuCWt5OGNcMp27d1ge9sB1t8Da3fskWD0CscJeWkKCNV5qqROsoJL1V7sPP3HVn9OJvvYMVZ9HQqT9M3rX48Vl1FexfwZymRsuD6Fz5h1+jUbFYrAMAlrYYsirpUYN2k4W1W20SfK4VywKAi2fkrj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737236049; c=relaxed/simple;
	bh=FVYHUlDZLqC9No7c7qv3li4j8j7FzM8lrQp3F92ptcw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qm9CRz+dYJH7nwJ+u2mLTiE1iAd8jau6lqZOwL8Ce6FLksXJzoLxC3XPH5oDn7YkMn6R/5+5F2wCJ1jzbuggCPMi3vX6kqcEWB3BeashbkEpQn8n6yLMdUEb4gheTrdW+nVlfeqT34bWI+z0g6fWbP41J2c2s0I/1pM2dzRF0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxUgl/BK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737236047; x=1768772047;
  h=date:from:to:cc:subject:message-id;
  bh=FVYHUlDZLqC9No7c7qv3li4j8j7FzM8lrQp3F92ptcw=;
  b=MxUgl/BKRnB3YnjeyYCZs5EbrlIXm5WB8kqMxyolK8xGNKN1TpXKQGMD
   8MOmlZRRNo174vwsTIjzTxLvaf0geCwL4dCTi4O1dtAOUuVQ+ln1d2Qhq
   8yQle0U5h5vmSIrImalmSFd3PtTK/OSib7wD9vfSwmfMp7btMLgJfSOcV
   jTnACZmod0ug7T0hyH4T/LQ5vzohHvbqxu1sFzFaV0V12gA8grJ441aF5
   c/2zaGeOJDf6fBBPmbs++uZOoBUV53hLmnRGdLlnvaMgA1VUFJcZwdwE4
   LXTGCD3aepSSfmHOy+iIDz/Um6aNO5+cbRvWrsrJN206DrhF0bHXlkj8V
   A==;
X-CSE-ConnectionGUID: CSCZiv+PT6KWU/cB/I7djQ==
X-CSE-MsgGUID: ca8g6iw1REGO2A3mJxQvQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11319"; a="41320189"
X-IronPort-AV: E=Sophos;i="6.13,215,1732608000"; 
   d="scan'208";a="41320189"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 13:34:06 -0800
X-CSE-ConnectionGUID: +DoOmO32QqWBNLpy/nvGIg==
X-CSE-MsgGUID: INe9obLcRbar8nvR5aoMWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110170120"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Jan 2025 13:34:04 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZGSA-000Upi-2f;
	Sat, 18 Jan 2025 21:34:02 +0000
Date: Sun, 19 Jan 2025 05:33:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 cb2905642c7112b847413962c5be20fc9f83a83c
Message-ID: <202501190500.yR9S2kyx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: cb2905642c7112b847413962c5be20fc9f83a83c  Merge branch 'linux-next' into bleeding-edge

elapsed time: 1442m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250118    gcc-13.2.0
arc                   randconfig-002-20250118    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                            mps2_defconfig    clang-15
arm                   randconfig-001-20250118    gcc-14.2.0
arm                   randconfig-002-20250118    clang-20
arm                   randconfig-003-20250118    gcc-14.2.0
arm                   randconfig-004-20250118    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250118    clang-17
arm64                 randconfig-002-20250118    gcc-14.2.0
arm64                 randconfig-003-20250118    clang-20
arm64                 randconfig-004-20250118    clang-15
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250118    gcc-14.2.0
csky                  randconfig-002-20250118    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250118    clang-20
hexagon               randconfig-002-20250118    clang-20
i386        buildonly-randconfig-001-20250118    gcc-12
i386        buildonly-randconfig-002-20250118    clang-19
i386        buildonly-randconfig-003-20250118    clang-19
i386        buildonly-randconfig-004-20250118    gcc-11
i386        buildonly-randconfig-005-20250118    clang-19
i386        buildonly-randconfig-006-20250118    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250118    gcc-14.2.0
loongarch             randconfig-002-20250118    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250118    gcc-14.2.0
nios2                 randconfig-002-20250118    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250118    gcc-14.2.0
parisc                randconfig-002-20250118    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      pasemi_defconfig    clang-20
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250118    clang-15
powerpc               randconfig-002-20250118    clang-20
powerpc               randconfig-003-20250118    clang-20
powerpc64             randconfig-001-20250118    clang-17
powerpc64             randconfig-002-20250118    clang-19
powerpc64             randconfig-003-20250118    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250118    gcc-14.2.0
riscv                 randconfig-002-20250118    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250118    clang-20
s390                  randconfig-002-20250118    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                    randconfig-001-20250118    gcc-14.2.0
sh                    randconfig-002-20250118    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250118    gcc-14.2.0
sparc                 randconfig-002-20250118    gcc-14.2.0
sparc64               randconfig-001-20250118    gcc-14.2.0
sparc64               randconfig-002-20250118    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250118    clang-17
um                    randconfig-002-20250118    clang-15
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250118    clang-19
x86_64      buildonly-randconfig-002-20250118    gcc-12
x86_64      buildonly-randconfig-003-20250118    clang-19
x86_64      buildonly-randconfig-004-20250118    gcc-12
x86_64      buildonly-randconfig-005-20250118    clang-19
x86_64      buildonly-randconfig-006-20250118    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250118    gcc-14.2.0
xtensa                randconfig-002-20250118    gcc-14.2.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

