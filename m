Return-Path: <linux-acpi+bounces-8450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B797F987AB1
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 23:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAABBB21E91
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 21:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB7186E30;
	Thu, 26 Sep 2024 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jllw0GgF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAA185944;
	Thu, 26 Sep 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385947; cv=none; b=KA5wN3mj7qFtcMBqQsRJ3Gq53cZ40wzQaDY2LmGWtJjfor8Kns1PeM0HoX4FDyyEXx+7gMDq8PnHo22VqrC6e20PI/3fgAcakoNYCNkW+3UO7glfUaWJYEmfjtyOEfpZwmiCEWJbyVyIDW3p72V1zipsIL8RTz00M4CtFjsl0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385947; c=relaxed/simple;
	bh=Z/k344jFIcduYbF/hloNr1fJqpx19RlTrt0oGOQ7ujY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TTnvLgr1pFofqCGLzmBQBbg22uC6Q+aD6XvcvkBr+iDFSj8iSZb7IdvP6kB9dHkjZguWQ7v9sgx+Nf4IaVQM7xtvNjgTWxnmgwDsMBzS0nu9AXp+2I9mecpNeS4fXK7kyuR8s9Y2w5COS3vaJo+MiJGWQASzytP9C2rfc2ABwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jllw0GgF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727385945; x=1758921945;
  h=date:from:to:cc:subject:message-id;
  bh=Z/k344jFIcduYbF/hloNr1fJqpx19RlTrt0oGOQ7ujY=;
  b=jllw0GgFnIW92KdujLk1wJWMhzkgMRxZ1wnqkep3GRormBjMB/3svifQ
   grh0K9gWCJ6q+Kopo/9KoR/6UicszpOdozujSrPoaPqCqnHmXORfyUP5I
   UAAU0PD03+Gl4Gz5ExiURCczRwdSkdGw8krftyY2nqn7sqLcGcSWj7f/F
   LEjHoQ3tYcdfFwu6DCIaGe/N+gaLS6va9oFswUmOqem/0N8pvLc+FNRwi
   cIjnHMuba/179BrY6EWu2BzRSZJDasL/DZpT+gMkP4SrwjzcrSrTqhl5Z
   +1HIGmA92+o4m0D50FE14wmGyn/4ezNJAU8tuLScS5JaWaumyjJxzSPeG
   Q==;
X-CSE-ConnectionGUID: cZSV89YBQRudBAwRmXxgcg==
X-CSE-MsgGUID: AHr/PMovQZ6SE5qoZdjAeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="29398837"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="29398837"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 14:25:45 -0700
X-CSE-ConnectionGUID: 1i6SpoTjTbeQYr0gbfdJmw==
X-CSE-MsgGUID: eJKve7rVTFWOeWCC3swEEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="72301795"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Sep 2024 14:25:43 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stvzY-000LD5-2s;
	Thu, 26 Sep 2024 21:25:40 +0000
Date: Fri, 27 Sep 2024 05:25:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 0da56073d802c38f74d82e9bfb8678408428e334
Message-ID: <202409270526.psjUbZ45-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 0da56073d802c38f74d82e9bfb8678408428e334  Merge branch 'thermal-core-experimental' into bleeding-edge

elapsed time: 1445m

configs tested: 222
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              alldefconfig    clang-15
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-14.1.0
arc                   randconfig-001-20240926    gcc-14.1.0
arc                   randconfig-002-20240926    gcc-14.1.0
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                       aspeed_g5_defconfig    clang-20
arm                        clps711x_defconfig    clang-15
arm                                 defconfig    gcc-14.1.0
arm                          gemini_defconfig    clang-20
arm                      integrator_defconfig    clang-15
arm                        keystone_defconfig    clang-20
arm                            mmp2_defconfig    clang-15
arm                        multi_v7_defconfig    clang-20
arm                         mv78xx0_defconfig    clang-15
arm                         orion5x_defconfig    gcc-14.1.0
arm                   randconfig-001-20240926    gcc-14.1.0
arm                   randconfig-002-20240926    gcc-14.1.0
arm                   randconfig-003-20240926    gcc-14.1.0
arm                   randconfig-004-20240926    gcc-14.1.0
arm                           sama5_defconfig    clang-15
arm                           sunxi_defconfig    gcc-14.1.0
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240926    gcc-14.1.0
arm64                 randconfig-002-20240926    gcc-14.1.0
arm64                 randconfig-003-20240926    gcc-14.1.0
arm64                 randconfig-004-20240926    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    clang-20
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240926    gcc-14.1.0
csky                  randconfig-002-20240926    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240926    gcc-14.1.0
hexagon               randconfig-002-20240926    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240926    gcc-12
i386        buildonly-randconfig-002-20240926    gcc-12
i386        buildonly-randconfig-003-20240926    gcc-12
i386        buildonly-randconfig-004-20240926    gcc-12
i386        buildonly-randconfig-005-20240926    gcc-12
i386        buildonly-randconfig-006-20240926    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240926    gcc-12
i386                  randconfig-002-20240926    gcc-12
i386                  randconfig-003-20240926    gcc-12
i386                  randconfig-004-20240926    gcc-12
i386                  randconfig-005-20240926    gcc-12
i386                  randconfig-006-20240926    gcc-12
i386                  randconfig-011-20240926    gcc-12
i386                  randconfig-012-20240926    gcc-12
i386                  randconfig-013-20240926    gcc-12
i386                  randconfig-014-20240926    gcc-12
i386                  randconfig-015-20240926    gcc-12
i386                  randconfig-016-20240926    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240926    gcc-14.1.0
loongarch             randconfig-002-20240926    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          atari_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         bigsur_defconfig    clang-15
mips                  cavium_octeon_defconfig    gcc-14.1.0
mips                  decstation_64_defconfig    clang-15
mips                  decstation_64_defconfig    clang-20
mips                          eyeq5_defconfig    clang-20
mips                           gcw0_defconfig    gcc-14.1.0
mips                           ip22_defconfig    clang-15
mips                           ip32_defconfig    clang-15
mips                     loongson1b_defconfig    clang-15
mips                         rt305x_defconfig    gcc-14.1.0
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240926    gcc-14.1.0
nios2                 randconfig-002-20240926    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240926    gcc-14.1.0
parisc                randconfig-002-20240926    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    amigaone_defconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    clang-20
powerpc                        icon_defconfig    clang-15
powerpc                      katmai_defconfig    gcc-14.1.0
powerpc                 linkstation_defconfig    gcc-14.1.0
powerpc                    mvme5100_defconfig    gcc-14.1.0
powerpc                      ppc6xx_defconfig    gcc-14.1.0
powerpc               randconfig-001-20240926    gcc-14.1.0
powerpc               randconfig-002-20240926    gcc-14.1.0
powerpc               randconfig-003-20240926    gcc-14.1.0
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm5200_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    clang-20
powerpc64             randconfig-001-20240926    gcc-14.1.0
powerpc64             randconfig-002-20240926    gcc-14.1.0
powerpc64             randconfig-003-20240926    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240926    gcc-14.1.0
riscv                 randconfig-002-20240926    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20240926    gcc-14.1.0
s390                  randconfig-002-20240926    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-14.1.0
sh                    randconfig-001-20240926    gcc-14.1.0
sh                    randconfig-002-20240926    gcc-14.1.0
sh                          rsk7203_defconfig    clang-20
sh                          rsk7269_defconfig    gcc-14.1.0
sh                           se7343_defconfig    clang-15
sh                           se7712_defconfig    gcc-14.1.0
sh                             sh03_defconfig    clang-15
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    clang-20
sparc64                          alldefconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240926    gcc-14.1.0
sparc64               randconfig-002-20240926    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240926    gcc-14.1.0
um                    randconfig-002-20240926    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240926    gcc-11
x86_64      buildonly-randconfig-002-20240926    gcc-11
x86_64      buildonly-randconfig-003-20240926    gcc-11
x86_64      buildonly-randconfig-004-20240926    gcc-11
x86_64      buildonly-randconfig-005-20240926    gcc-11
x86_64      buildonly-randconfig-006-20240926    gcc-11
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240926    gcc-11
x86_64                randconfig-002-20240926    gcc-11
x86_64                randconfig-003-20240926    gcc-11
x86_64                randconfig-004-20240926    gcc-11
x86_64                randconfig-005-20240926    gcc-11
x86_64                randconfig-006-20240926    gcc-11
x86_64                randconfig-011-20240926    gcc-11
x86_64                randconfig-012-20240926    gcc-11
x86_64                randconfig-013-20240926    gcc-11
x86_64                randconfig-014-20240926    gcc-11
x86_64                randconfig-015-20240926    gcc-11
x86_64                randconfig-016-20240926    gcc-11
x86_64                randconfig-071-20240926    gcc-11
x86_64                randconfig-072-20240926    gcc-11
x86_64                randconfig-073-20240926    gcc-11
x86_64                randconfig-074-20240926    gcc-11
x86_64                randconfig-075-20240926    gcc-11
x86_64                randconfig-076-20240926    gcc-11
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20240926    gcc-14.1.0
xtensa                randconfig-002-20240926    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

