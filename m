Return-Path: <linux-acpi+bounces-5324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31B8B0430
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 10:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892091F22D9E
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 08:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB8C15885C;
	Wed, 24 Apr 2024 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRheSXvl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0A29CA;
	Wed, 24 Apr 2024 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946929; cv=none; b=V4tgSPO//t4+xO5/lYuDtqe7M5MzLNkKcN+04YN3uXAGVJZRpxkoZ6727ZaBoBeKT3x/pc27gmW/G1C1bjCyyoNDFXQZMoB3WAeTOmE415qYvTl7OBBrM6YSkZRUjpQD8fAr4vF2SHtO7Szh5Zs5Yxgb6clsBV0LTAQsb68LSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946929; c=relaxed/simple;
	bh=1vRidXgEpKxOEWwfG6m+JkglFOdZBQ6g+Noz0h7uPS4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QRUezh4aK9g+5/BYVow/KxRh9sKh8aFOq9I4vXYtfhCbNwxXReIn/RNViCHibh/J1QQCqGLTUvKDjclmyFd+1zK9MvZHx9EKAWFJ3V2jWadsFfZAJHjEz9dwDLDuwtB7wKVUYbGk/zFHeDy4V3dyYQnmu1w+Lgtv/pKwTfXaFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRheSXvl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713946927; x=1745482927;
  h=date:from:to:cc:subject:message-id;
  bh=1vRidXgEpKxOEWwfG6m+JkglFOdZBQ6g+Noz0h7uPS4=;
  b=nRheSXvloQ+P2R0XWAqmVDk883X/wgL0wDx8QQA72KhEFKXu7KznfHCP
   TIp5T0567fcUBV0jZeDTR3Dpu3DzgiuqUUkVQfo+iHSYSDct2SrNn6kFV
   /qZaQFI6T6Eypldn0v9iUeYDsHdGErOMHT4l8Jfw3mIj14CGtj439Pb7N
   Z7V115hSSzp5qVGV4BzsuVp+K1oaElUceTIQCA3KNza4j1hNnbLdjxu8C
   JYMpe9C8+2R3+COOLwDSs4c4azRrDPkKb9svRA5x0xbNiP2MPcrgqtXQE
   ijNsPlnjZkJSoMJ7EGQ37lfckXSHubjYDN5HjiRAJf5iHyt2D0ZND97Bl
   A==;
X-CSE-ConnectionGUID: dpiwVe2LQv+duUjuCS5gHA==
X-CSE-MsgGUID: qPaUnu+5SBqiLfJ1KMq0uA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9728640"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9728640"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:22:07 -0700
X-CSE-ConnectionGUID: ShJmyPOQSaiPmlcTOfXCuQ==
X-CSE-MsgGUID: S+CC9CJgSBKSrbOJ8MP1eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="29101643"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Apr 2024 01:22:05 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzXtD-00011u-0R;
	Wed, 24 Apr 2024 08:22:03 +0000
Date: Wed, 24 Apr 2024 16:21:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 480afe5f34df87486447d21771713990eab5d997
Message-ID: <202404241653.gCtW7R4R-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 480afe5f34df87486447d21771713990eab5d997  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 733m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240424   gcc  
arc                   randconfig-002-20240424   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          pxa3xx_defconfig   clang
arm                   randconfig-001-20240424   gcc  
arm                   randconfig-002-20240424   gcc  
arm                   randconfig-003-20240424   gcc  
arm                   randconfig-004-20240424   clang
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240424   clang
arm64                 randconfig-002-20240424   gcc  
arm64                 randconfig-003-20240424   gcc  
arm64                 randconfig-004-20240424   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240424   gcc  
csky                  randconfig-002-20240424   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240424   clang
hexagon               randconfig-002-20240424   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240424   gcc  
i386         buildonly-randconfig-002-20240424   gcc  
i386         buildonly-randconfig-003-20240424   gcc  
i386         buildonly-randconfig-004-20240424   gcc  
i386         buildonly-randconfig-005-20240424   gcc  
i386         buildonly-randconfig-006-20240424   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240424   gcc  
i386                  randconfig-002-20240424   gcc  
i386                  randconfig-003-20240424   gcc  
i386                  randconfig-004-20240424   clang
i386                  randconfig-005-20240424   gcc  
i386                  randconfig-006-20240424   gcc  
i386                  randconfig-011-20240424   clang
i386                  randconfig-012-20240424   gcc  
i386                  randconfig-013-20240424   clang
i386                  randconfig-014-20240424   clang
i386                  randconfig-015-20240424   clang
i386                  randconfig-016-20240424   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240424   gcc  
loongarch             randconfig-002-20240424   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                     loongson1b_defconfig   clang
mips                           rs90_defconfig   gcc  
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240424   gcc  
nios2                 randconfig-002-20240424   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240424   gcc  
parisc                randconfig-002-20240424   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc               randconfig-001-20240424   clang
powerpc               randconfig-002-20240424   gcc  
powerpc               randconfig-003-20240424   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc64             randconfig-001-20240424   gcc  
powerpc64             randconfig-002-20240424   gcc  
powerpc64             randconfig-003-20240424   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240424   gcc  
riscv                 randconfig-002-20240424   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240424   gcc  
s390                  randconfig-002-20240424   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240424   gcc  
sh                    randconfig-002-20240424   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240424   gcc  
sparc64               randconfig-002-20240424   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240424   gcc  
um                    randconfig-002-20240424   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240424   clang
x86_64       buildonly-randconfig-002-20240424   clang
x86_64       buildonly-randconfig-003-20240424   gcc  
x86_64       buildonly-randconfig-004-20240424   gcc  
x86_64       buildonly-randconfig-005-20240424   gcc  
x86_64       buildonly-randconfig-006-20240424   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240424   clang
x86_64                randconfig-002-20240424   clang
x86_64                randconfig-003-20240424   gcc  
x86_64                randconfig-004-20240424   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240424   gcc  
xtensa                randconfig-002-20240424   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

