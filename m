Return-Path: <linux-acpi+bounces-8029-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8596740D
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 02:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305861F21C03
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 00:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4478F1DA4C;
	Sun,  1 Sep 2024 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix6P6fhx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957BEEC9;
	Sun,  1 Sep 2024 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725151168; cv=none; b=bD6jVg8l6gQBtshk6gFxrzNHcO8TCPbELs+4BCwG02htwUVAh9Ezmdw21RiZnUcWeE8AveFjZd/lNIJA1rM8s8EtpU1ufNaWPEsPUJm6Lt47LfV2fYcgjjxHGCSc8pekr7YLpqa2KPJws/PsdK4mJ+8E79R+7/nujY9Bh3gOmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725151168; c=relaxed/simple;
	bh=Nh9sOnO+MrjCmpBeROylthdQi4AlJueEe38fe1BK7Ww=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZdaGDL4jGC3e7TaBVTWErW/Q77wPCbglXZQBXwpEiE8H1Y2nX80lnQ00ymZuDWuDL3MwwiMqOMgERslrwQoVKtQDzEnzYAzCmBwfxk1sQRkANb0NzaFl3Z71YCtdbZwYbtvLWTWrGeu2D+sHwe9PXDmJ6qfEWm+nPgMhYBxx9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix6P6fhx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725151166; x=1756687166;
  h=date:from:to:cc:subject:message-id;
  bh=Nh9sOnO+MrjCmpBeROylthdQi4AlJueEe38fe1BK7Ww=;
  b=Ix6P6fhxsbvxu5IdBeLPISPdVrB37DsHrxqEt31WLo0Rp70TprGzpNVJ
   iTpfbinDi4+fd0ExoyNrL5z2s1cbGJ0x4rSLQEJOXCcDD9KTPtB9L/U9D
   YordvRqGjl+3JSOYTh/yYgmURHo2bejj7NViDfKsWn+cqs7Thj//gpZYY
   rtjLvcbSXVZ04d3JXU6vfBkIFr74pPZAD7etrSpOJx50ea/Ldz9kOr91y
   2jkVhKtXI4JNDaHXuQNXHTfH7UpDIxXm00BrzqjCOSYGLHEOXiSIJUOba
   oPMHB1z86Mhj8Y20l7hTQReXt2zurk68ZzHEynVfzVCSb2fV/okTopgtu
   A==;
X-CSE-ConnectionGUID: JvPlbyH/QhKyvRkW8E10XA==
X-CSE-MsgGUID: rjrqrLBzT+OmPg1Emu7LQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23899257"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="23899257"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 17:39:26 -0700
X-CSE-ConnectionGUID: NJsH7CfPS7SaprFLo97Kmw==
X-CSE-MsgGUID: yk/fRBrrTPSmDKk3xdFc2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="69073724"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2024 17:39:25 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skYck-0003EO-0q;
	Sun, 01 Sep 2024 00:39:22 +0000
Date: Sun, 01 Sep 2024 08:38:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d683340e443e46fafe40b050b5dedb64924bf6c8
Message-ID: <202409010846.qDCTHA2N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d683340e443e46fafe40b050b5dedb64924bf6c8  Merge branch 'thermal-core-experimental' into bleeding-edge

elapsed time: 2123m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g5_defconfig   clang-20
arm                         at91_dt_defconfig   clang-20
arm                        clps711x_defconfig   clang-20
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          exynos_defconfig   clang-20
arm64                            alldefconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240901   clang-18
i386         buildonly-randconfig-002-20240901   clang-18
i386         buildonly-randconfig-003-20240901   clang-18
i386         buildonly-randconfig-004-20240901   clang-18
i386         buildonly-randconfig-005-20240901   clang-18
i386         buildonly-randconfig-006-20240901   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240901   clang-18
i386                  randconfig-002-20240901   clang-18
i386                  randconfig-003-20240901   clang-18
i386                  randconfig-004-20240901   clang-18
i386                  randconfig-005-20240901   clang-18
i386                  randconfig-006-20240901   clang-18
i386                  randconfig-011-20240901   clang-18
i386                  randconfig-012-20240901   clang-18
i386                  randconfig-013-20240901   clang-18
i386                  randconfig-014-20240901   clang-18
i386                  randconfig-015-20240901   clang-18
i386                  randconfig-016-20240901   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          hp300_defconfig   clang-20
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           ci20_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                        fsp2_defconfig   clang-20
powerpc                 mpc832x_rdb_defconfig   clang-20
powerpc                     tqm8540_defconfig   clang-20
powerpc                         wii_defconfig   clang-20
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                         ecovec24_defconfig   clang-20
sh                               j2_defconfig   clang-20
sh                          kfr2r09_defconfig   clang-20
sh                          urquell_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

