Return-Path: <linux-acpi+bounces-5640-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13CE8BD83F
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 01:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516CA1F23DC8
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 23:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEB15CD65;
	Mon,  6 May 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeTXzJik"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286D1E492;
	Mon,  6 May 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039053; cv=none; b=WUfKE/kgUmtpk8RqkEZxDMSVoRefPlbkYchLRnDUul0w3YsUyWrV/UdZRe5AZpleEuMP14HR46HAQTim0N+AB3DIsanGO41/MF1xxRan9hBXFxa1mLce4BO+CQ6cAlD/jG2TX0Yq6eqt1rtmyxK7OHMb85bxBpyoi/qy8hdTYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039053; c=relaxed/simple;
	bh=gPAYoAacB+hI7HjjgY/LeWilIYdzL4qCuR2qRit+6o4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oWTrg6ic5GAG1CvVYZWQ69vHuJa2cX0oy5K4MbEgqo307Ur6PU9q31nTMWA31Ui1NziO/gY+ju/N5qBQuywb4nc7qNNcknCOm7DogTXSc3xKfSBSJaBTQsq3bymaKVvE5T5+20pCY6uEmK15WUphgdGLdsZ9EY5d2/f3qejruwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeTXzJik; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715039052; x=1746575052;
  h=date:from:to:cc:subject:message-id;
  bh=gPAYoAacB+hI7HjjgY/LeWilIYdzL4qCuR2qRit+6o4=;
  b=PeTXzJikOdw/np7cB/YZr/IKYYwbz80fWypUsrZBy2PYdNTlrZxnx7M9
   CNYJ0WhO/GSD4JVOe9KCZ/yxKCfsTBy5+V7FB3qMCzLYHFMEiFd68PBVl
   fRYOVHBaFVfuSbVdZyGuvNkaKwuYog9SUt+xIpGC+llKa4kXPJuKKperu
   8Dj/Z6V1tocZ37C+m5wY8CbCMBEwUKsqs9tZR7aFv/ZzrzJ0nhB/0TwdX
   J4O1DRa9pVVIfSofndp/p2HYc1p2LChKVqf/J+0AKw1wlH3xatgct3CNN
   SXVcmuerr8t1ADDEIdB9OB2e9rcJgl9Mqoz+NANuyXv/NskhD3Mo05YUf
   g==;
X-CSE-ConnectionGUID: VjVJajIdQWaSC0OE1WE/tA==
X-CSE-MsgGUID: 6WJJI15sQAydtVxkbcIYSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21967774"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="21967774"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 16:44:11 -0700
X-CSE-ConnectionGUID: G3UpO9gYQv2XWqJqdvyUKQ==
X-CSE-MsgGUID: VkgJGaoyTXmcP9cY9saK5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="28315699"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2024 16:44:09 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4806-000181-2B;
	Mon, 06 May 2024 23:44:06 +0000
Date: Tue, 07 May 2024 07:43:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 b0e05525f385820d096acba5e24f54e4c17738e9
Message-ID: <202405070754.vFN20Dyg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: b0e05525f385820d096acba5e24f54e4c17738e9  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 728m

configs tested: 180
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
arc                   randconfig-001-20240506   gcc  
arc                   randconfig-002-20240506   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                         nhk8815_defconfig   clang
arm                   randconfig-001-20240506   clang
arm                   randconfig-002-20240506   clang
arm                   randconfig-003-20240506   gcc  
arm                   randconfig-004-20240506   clang
arm                         s3c6400_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240506   gcc  
arm64                 randconfig-002-20240506   gcc  
arm64                 randconfig-003-20240506   clang
arm64                 randconfig-004-20240506   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240506   gcc  
csky                  randconfig-002-20240506   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240506   clang
hexagon               randconfig-002-20240506   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240506   gcc  
i386         buildonly-randconfig-002-20240506   clang
i386         buildonly-randconfig-003-20240506   gcc  
i386         buildonly-randconfig-004-20240506   gcc  
i386         buildonly-randconfig-005-20240506   gcc  
i386         buildonly-randconfig-006-20240506   clang
i386                                defconfig   clang
i386                  randconfig-001-20240506   gcc  
i386                  randconfig-002-20240506   clang
i386                  randconfig-003-20240506   gcc  
i386                  randconfig-004-20240506   clang
i386                  randconfig-005-20240506   clang
i386                  randconfig-006-20240506   gcc  
i386                  randconfig-011-20240506   gcc  
i386                  randconfig-012-20240506   gcc  
i386                  randconfig-013-20240506   gcc  
i386                  randconfig-014-20240506   clang
i386                  randconfig-015-20240506   clang
i386                  randconfig-016-20240506   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240506   gcc  
loongarch             randconfig-002-20240506   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   clang
mips                           ip32_defconfig   clang
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240506   gcc  
nios2                 randconfig-002-20240506   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240506   gcc  
parisc                randconfig-002-20240506   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240506   gcc  
powerpc               randconfig-002-20240506   clang
powerpc               randconfig-003-20240506   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-001-20240506   clang
powerpc64             randconfig-002-20240506   clang
powerpc64             randconfig-003-20240506   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240506   clang
riscv                 randconfig-002-20240506   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240506   gcc  
s390                  randconfig-002-20240506   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240506   gcc  
sh                    randconfig-002-20240506   gcc  
sh                           se7724_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240506   gcc  
sparc64               randconfig-002-20240506   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240506   clang
um                    randconfig-002-20240506   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240506   gcc  
x86_64       buildonly-randconfig-002-20240506   gcc  
x86_64       buildonly-randconfig-003-20240506   gcc  
x86_64       buildonly-randconfig-004-20240506   clang
x86_64       buildonly-randconfig-005-20240506   clang
x86_64       buildonly-randconfig-006-20240506   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240506   clang
x86_64                randconfig-002-20240506   clang
x86_64                randconfig-003-20240506   clang
x86_64                randconfig-004-20240506   clang
x86_64                randconfig-005-20240506   clang
x86_64                randconfig-006-20240506   clang
x86_64                randconfig-011-20240506   gcc  
x86_64                randconfig-012-20240506   gcc  
x86_64                randconfig-013-20240506   gcc  
x86_64                randconfig-014-20240506   gcc  
x86_64                randconfig-015-20240506   gcc  
x86_64                randconfig-016-20240506   gcc  
x86_64                randconfig-071-20240506   gcc  
x86_64                randconfig-072-20240506   clang
x86_64                randconfig-073-20240506   gcc  
x86_64                randconfig-074-20240506   clang
x86_64                randconfig-075-20240506   gcc  
x86_64                randconfig-076-20240506   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240506   gcc  
xtensa                randconfig-002-20240506   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

