Return-Path: <linux-acpi+bounces-8574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B5B9918A1
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 19:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644EE1F21AB5
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A81156880;
	Sat,  5 Oct 2024 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkMUvkZ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2D13C836;
	Sat,  5 Oct 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147682; cv=none; b=Ei/WuGzFNDT/Q6g8byi7m4aHMJ6vVkUmiP7N4gEXGhCZAf9CfBILUdjeJEqmpopMmSQT5LuP8lhSoupqduKRoKNWlKab4eTXmZLZNgYm6uAfXkwA1PbmA0BHcexGdubYnBqUmoNlQ95TTILHJBgajAuD8PjdMPJURxtr6tsEdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147682; c=relaxed/simple;
	bh=3L6QAfkSIOgO4hlo6slQl7bMWNGs75nVgGQ0nZH7uiM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HITzqYRDDYp331DRVW9GGxJOu8UO0WMk0xn0DvM9LyEiayd3jMXlRtRksWrKLBnbX8MOdE9UpalHymdDy1Uh6SX0HSUiNM8lCSC9ejBo/h/EnWe9CIRthrDp0ETg9YeKDnaKRPwlZmCC/lu3FTRe83vB7kaJ0DQmkrSjZx51ODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkMUvkZ7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728147681; x=1759683681;
  h=date:from:to:cc:subject:message-id;
  bh=3L6QAfkSIOgO4hlo6slQl7bMWNGs75nVgGQ0nZH7uiM=;
  b=JkMUvkZ7sHSmuLvSwxe+G2sGlfvR6/uUM3ma5E/zdR4X2wHVDqGtZrmi
   i2aMOQmkTzVso97mNsx4EcooFtzvQseIonxofwiyt74io2qHd1ANGVv3H
   fmZz9I1PyjEoZHN52sjdLiDC7BTy28XTp/yH3M167T8y5h9AoCiu9D26K
   RG3iD/FyZl2j5TY3n7UO1Y8xLwv1DHljS/7w0C0gY+SHDBlL566bmIwUS
   ia8vKXIVfZ8+G+ovOOsxy14DT/nkmta1ijEl7xhtw4gGEmJxJ5LUkM0PW
   dY4jqQzvLLcxeaQE8J6bL3Itm5NBuoaxMZQfRnjk96Jk5Iw+EvrlTfKXT
   g==;
X-CSE-ConnectionGUID: IK2BRK4TQKabhJvcU8Rj7g==
X-CSE-MsgGUID: iUYPkmyLQNS/Tbt/o87yig==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="31141973"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="31141973"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 10:01:20 -0700
X-CSE-ConnectionGUID: y/uqeomYT+ybovLr9tfHvw==
X-CSE-MsgGUID: eUntUcSaSYKIKOyaqRZydQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="105863396"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Oct 2024 10:01:20 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx89d-0003As-0F;
	Sat, 05 Oct 2024 17:01:17 +0000
Date: Sun, 06 Oct 2024 01:00:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ef9a232abad8689b506b4361cb5fd6829ab5b3c2
Message-ID: <202410060108.fmIQcO9m-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ef9a232abad8689b506b4361cb5fd6829ab5b3c2  Merge branch 'thermal-core-testing' into bleeding-edge

elapsed time: 1199m

configs tested: 138
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                            hisi_defconfig    clang-20
arm                            qcom_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241005    clang-18
i386        buildonly-randconfig-002-20241005    clang-18
i386        buildonly-randconfig-003-20241005    clang-18
i386        buildonly-randconfig-004-20241005    clang-18
i386        buildonly-randconfig-005-20241005    gcc-12
i386        buildonly-randconfig-006-20241005    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241005    gcc-11
i386                  randconfig-002-20241005    clang-18
i386                  randconfig-003-20241005    gcc-12
i386                  randconfig-004-20241005    clang-18
i386                  randconfig-005-20241005    clang-18
i386                  randconfig-006-20241005    clang-18
i386                  randconfig-011-20241005    gcc-12
i386                  randconfig-012-20241005    clang-18
i386                  randconfig-013-20241005    clang-18
i386                  randconfig-014-20241005    gcc-12
i386                  randconfig-015-20241005    gcc-12
i386                  randconfig-016-20241005    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      loongson3_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     mpc512x_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    clang-20
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                    sam440ep_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    clang-20
sh                            hp6xx_defconfig    clang-20
sh                           se7206_defconfig    clang-20
sh                           se7750_defconfig    clang-20
sh                           se7780_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241005    gcc-12
x86_64      buildonly-randconfig-002-20241005    gcc-12
x86_64      buildonly-randconfig-003-20241005    gcc-12
x86_64      buildonly-randconfig-004-20241005    gcc-12
x86_64      buildonly-randconfig-005-20241005    gcc-12
x86_64      buildonly-randconfig-006-20241005    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241005    gcc-12
x86_64                randconfig-002-20241005    gcc-12
x86_64                randconfig-003-20241005    gcc-12
x86_64                randconfig-004-20241005    gcc-12
x86_64                randconfig-005-20241005    gcc-12
x86_64                randconfig-006-20241005    gcc-12
x86_64                randconfig-011-20241005    gcc-12
x86_64                randconfig-012-20241005    gcc-12
x86_64                randconfig-013-20241005    gcc-12
x86_64                randconfig-014-20241005    gcc-12
x86_64                randconfig-015-20241005    gcc-12
x86_64                randconfig-016-20241005    gcc-12
x86_64                randconfig-071-20241005    gcc-12
x86_64                randconfig-072-20241005    gcc-12
x86_64                randconfig-073-20241005    gcc-12
x86_64                randconfig-074-20241005    gcc-12
x86_64                randconfig-075-20241005    gcc-12
x86_64                randconfig-076-20241005    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

