Return-Path: <linux-acpi+bounces-14988-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7BEAF86EB
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 06:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AC4482D36
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00DA1EF36E;
	Fri,  4 Jul 2025 04:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+uKSI7V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A311E990E;
	Fri,  4 Jul 2025 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604732; cv=none; b=ZZCfOstBCFQI0q8LwzWCu7GQlrpUp3S5My8td5V0cAU+0iEWaNDLnszn/njQqcRyMMXW1ucHxZ6JWPrZryniRUQOHs8ntFBXkZwibldjtbKN4ixNvunHJMId2bs405Yx7dZ9GC2ndUUFVNWff2LiVr4ZeX4pLlczIFsKrB5H9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604732; c=relaxed/simple;
	bh=2mIQG9jBCyc40AjfGWSEMFGuCAVNReVDjC2t3G/lxV8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tHRjBeMEczLiMT6lnkFX7eGTKpktQZ84zSEnGPSdmqY2DVFtLKQKy266YTX91BuIDnZ9wghGZQHvahF4yvJanJjHuaQbDtrFSB5HLVoWtboBJKuQKpgDkbFQ16byIY4JWzjRPu3ljkBteVKj6TNuLHl+DILVTEF2r4QtaPHfHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+uKSI7V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751604731; x=1783140731;
  h=date:from:to:cc:subject:message-id;
  bh=2mIQG9jBCyc40AjfGWSEMFGuCAVNReVDjC2t3G/lxV8=;
  b=I+uKSI7V4U4efV9VHT54YrQr0d/1o9gHDzK4wSc3+2tOAnEpIngm0Jc6
   AgK2XlDrIcTD8U32JkpAW+okLXxpMcZ1yPFp9jQW4LJQMlA/X2kltmRJh
   MlOdu7fBKmIl/VyFpne0SKIvZDj4FWdDyqRvoLCL+38NJ7iBp4KHBigJ3
   Dfqrv5YiSvcbvmh4eu2LfDreNQilbxcEguZr4sZc3aOY/CVBQF8FTLtvA
   1gOasfsk9+vmuhYz9om4vFpfMaDyoRmRM+sXwIDu2wpevD+Xzpb0humAc
   LbUSlSHjUUVCFyPyV/n14CNEGRqvvNgn+5Q9XvKrcZCKwD7FT+DdgXHu2
   A==;
X-CSE-ConnectionGUID: cmqyFVzEQjSL+qYLGMoTUA==
X-CSE-MsgGUID: hFFEEXChR1m+QMaq3izRFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57711608"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="57711608"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 21:52:09 -0700
X-CSE-ConnectionGUID: xlrMc8T3QTS+jgU65GAvkw==
X-CSE-MsgGUID: EVuCRDQBSH+1nAaiDda+zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="191727784"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Jul 2025 21:52:07 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXYP7-0003Lj-1T;
	Fri, 04 Jul 2025 04:52:05 +0000
Date: Fri, 04 Jul 2025 12:51:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 73cb2657cb1637055353d8df53b686f969901d3e
Message-ID: <202507041225.CXfGUuBb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 73cb2657cb1637055353d8df53b686f969901d3e  Merge branch 'pm-sleep' into fixes

elapsed time: 753m

configs tested: 152
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250704    gcc-8.5.0
arc                   randconfig-002-20250704    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                   randconfig-001-20250704    gcc-8.5.0
arm                   randconfig-002-20250704    clang-21
arm                   randconfig-003-20250704    gcc-8.5.0
arm                   randconfig-004-20250704    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250704    gcc-14.3.0
arm64                 randconfig-002-20250704    clang-21
arm64                 randconfig-003-20250704    clang-16
arm64                 randconfig-004-20250704    gcc-10.5.0
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250704    gcc-15.1.0
csky                  randconfig-002-20250704    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250704    clang-21
hexagon               randconfig-002-20250704    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250704    clang-20
i386        buildonly-randconfig-001-20250704    gcc-12
i386        buildonly-randconfig-002-20250704    clang-20
i386        buildonly-randconfig-003-20250704    clang-20
i386        buildonly-randconfig-004-20250704    clang-20
i386        buildonly-randconfig-005-20250704    clang-20
i386        buildonly-randconfig-006-20250704    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20250704    clang-20
i386                  randconfig-012-20250704    clang-20
i386                  randconfig-013-20250704    clang-20
i386                  randconfig-014-20250704    clang-20
i386                  randconfig-015-20250704    clang-20
i386                  randconfig-016-20250704    clang-20
i386                  randconfig-017-20250704    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250704    gcc-15.1.0
loongarch             randconfig-002-20250704    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            allmodconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    clang-21
nios2                 randconfig-001-20250704    gcc-8.5.0
nios2                 randconfig-002-20250704    gcc-10.5.0
openrisc                         allmodconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250704    gcc-14.3.0
parisc                randconfig-002-20250704    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250704    clang-21
powerpc               randconfig-002-20250704    gcc-9.3.0
powerpc               randconfig-003-20250704    clang-21
powerpc64             randconfig-001-20250704    clang-18
powerpc64             randconfig-002-20250704    gcc-10.5.0
powerpc64             randconfig-003-20250704    clang-18
riscv                            allmodconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20250704    clang-21
riscv                 randconfig-002-20250704    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250704    clang-21
s390                  randconfig-001-20250704    gcc-15.1.0
s390                  randconfig-002-20250704    clang-21
s390                  randconfig-002-20250704    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250704    clang-21
sh                    randconfig-001-20250704    gcc-15.1.0
sh                    randconfig-002-20250704    clang-21
sh                    randconfig-002-20250704    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-21
sparc                 randconfig-001-20250704    clang-21
sparc                 randconfig-001-20250704    gcc-11.5.0
sparc                 randconfig-002-20250704    clang-21
sparc                 randconfig-002-20250704    gcc-8.5.0
sparc64                          allmodconfig    clang-21
sparc64                          allyesconfig    clang-21
sparc64               randconfig-001-20250704    clang-21
sparc64               randconfig-001-20250704    gcc-13.4.0
sparc64               randconfig-002-20250704    clang-20
sparc64               randconfig-002-20250704    clang-21
um                               allmodconfig    clang-19
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250704    clang-21
um                    randconfig-002-20250704    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250704    clang-20
x86_64      buildonly-randconfig-002-20250704    gcc-12
x86_64      buildonly-randconfig-003-20250704    clang-20
x86_64      buildonly-randconfig-004-20250704    clang-20
x86_64      buildonly-randconfig-005-20250704    clang-20
x86_64      buildonly-randconfig-006-20250704    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20250704    clang-20
x86_64                randconfig-072-20250704    clang-20
x86_64                randconfig-073-20250704    clang-20
x86_64                randconfig-074-20250704    clang-20
x86_64                randconfig-075-20250704    clang-20
x86_64                randconfig-076-20250704    clang-20
x86_64                randconfig-077-20250704    clang-20
x86_64                randconfig-078-20250704    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-21
xtensa                randconfig-001-20250704    clang-21
xtensa                randconfig-001-20250704    gcc-12.4.0
xtensa                randconfig-002-20250704    clang-21
xtensa                randconfig-002-20250704    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

