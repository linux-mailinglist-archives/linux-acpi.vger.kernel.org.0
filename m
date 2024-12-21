Return-Path: <linux-acpi+bounces-10257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D69FA2B5
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 22:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE15016597D
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F7A1DAC9B;
	Sat, 21 Dec 2024 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJF41mjH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2A19D06A;
	Sat, 21 Dec 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734818273; cv=none; b=D3XXwi6WDiqtOF5LUoD/ArbOfWpg8lkNg5VchArJA56yKK39xllz/oXbpBnN4vTePZaQoLRFH1YQjyjMOFZHiJWVVoyRApbVbawOjAegkT41XThOjnTrd5t318q3BEjQyLO4ngIWURmG7l91muu1MDpYnUZAETHaRvuQVAcJ2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734818273; c=relaxed/simple;
	bh=FkL1aONG5gOug1pxjRDpyjoQnvAur0UZOJVoYE6dw+M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FKYOTfFEjM4teY0+k89Wl5CVxGfnfU6GuZ7JtIxImwXpwAyFPqitXXMnA5bswvAf7XPklmMmEoEBaZ1Lf4jxcmjNjuY1MsLG/w4wLDQEXsqIBwCb9qhkoCnxaFo//RHCFrma8vOp21byq5c/fRRreATJ6G+DpLwgf7Bo3imMVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJF41mjH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734818271; x=1766354271;
  h=date:from:to:cc:subject:message-id;
  bh=FkL1aONG5gOug1pxjRDpyjoQnvAur0UZOJVoYE6dw+M=;
  b=YJF41mjHnrvOTzdCgVmieVhyPJskbjFATc6NLYfD5o3oYf+FFaRoUdoe
   4IepTq+b8Lgc1zV7E6QANznTc/bEU06mlycs7zIOuheMpOnwPKxhTqX2X
   wOawXZUnkpC5Ow7DvnW+3yBQRPEOSdJKIaAlPck/Y+dPeZYd4Uodi0HDS
   MHaNbSs1t6m2C/t3p6FoZgy518t5whfF3gJzqdTgWuu8j7dg4sKfgEm64
   Cg24cdvNWnhQLNcRj18kjNRH2w2MWCDXnha8ZS0pjlKVayPG7U+brsRet
   5QQbRkbOy8lTZtz+BSVScXIzhNVEDFlXSzNDvruQw92kX+v9b23UBthB0
   w==;
X-CSE-ConnectionGUID: k05VpX3fTgW9yiJ3kcAr6A==
X-CSE-MsgGUID: CSEDmPm1S7e7ZOz9AmzRgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11293"; a="60716769"
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="60716769"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 13:57:50 -0800
X-CSE-ConnectionGUID: 4ggFqbw6SU+e0VzZOcsTBg==
X-CSE-MsgGUID: FUhee+VBRGqxq4GvKcIaYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="98650427"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Dec 2024 13:57:49 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tP7Tm-0002WY-2y;
	Sat, 21 Dec 2024 21:57:46 +0000
Date: Sun, 22 Dec 2024 05:57:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 046f4750e2ecb0e166d66d7f700daa3225a14a35
Message-ID: <202412220558.ADgjO30h-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 046f4750e2ecb0e166d66d7f700daa3225a14a35  Merge branch 'experimental/intel_pstate-testing' into bleeding-edge

elapsed time: 1443m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241221    gcc-13.2.0
arc                   randconfig-002-20241221    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                   randconfig-001-20241221    gcc-14.2.0
arm                   randconfig-002-20241221    gcc-14.2.0
arm                   randconfig-003-20241221    gcc-14.2.0
arm                   randconfig-004-20241221    clang-18
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241221    clang-18
arm64                 randconfig-002-20241221    clang-16
arm64                 randconfig-003-20241221    clang-20
arm64                 randconfig-004-20241221    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241221    gcc-14.2.0
csky                  randconfig-002-20241221    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-002-20241221    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241221    gcc-12
i386        buildonly-randconfig-002-20241221    gcc-12
i386        buildonly-randconfig-003-20241221    clang-19
i386        buildonly-randconfig-004-20241221    clang-19
i386        buildonly-randconfig-005-20241221    clang-19
i386        buildonly-randconfig-006-20241221    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241221    gcc-14.2.0
loongarch             randconfig-002-20241221    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241221    gcc-14.2.0
nios2                 randconfig-002-20241221    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20241221    gcc-14.2.0
parisc                randconfig-002-20241221    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    clang-20
powerpc                       eiger_defconfig    clang-17
powerpc                      pmac32_defconfig    clang-20
powerpc               randconfig-001-20241221    gcc-14.2.0
powerpc               randconfig-002-20241221    gcc-14.2.0
powerpc               randconfig-003-20241221    gcc-14.2.0
powerpc64             randconfig-001-20241221    gcc-14.2.0
powerpc64             randconfig-002-20241221    gcc-14.2.0
powerpc64             randconfig-003-20241221    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20241221    gcc-14.2.0
riscv                 randconfig-002-20241221    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241221    gcc-14.2.0
s390                  randconfig-002-20241221    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                    randconfig-001-20241221    gcc-14.2.0
sh                    randconfig-002-20241221    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241221    gcc-14.2.0
sparc                 randconfig-002-20241221    gcc-14.2.0
sparc64               randconfig-001-20241221    gcc-14.2.0
sparc64               randconfig-002-20241221    gcc-14.2.0
um                               alldefconfig    clang-19
um                                allnoconfig    clang-18
um                    randconfig-001-20241221    clang-18
um                    randconfig-002-20241221    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241221    gcc-12
x86_64      buildonly-randconfig-002-20241221    gcc-12
x86_64      buildonly-randconfig-003-20241221    gcc-12
x86_64      buildonly-randconfig-004-20241221    gcc-12
x86_64      buildonly-randconfig-005-20241221    gcc-11
x86_64      buildonly-randconfig-006-20241221    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241221    gcc-14.2.0
xtensa                randconfig-002-20241221    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

