Return-Path: <linux-acpi+bounces-3540-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739AA8565B9
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 15:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3A8B25552
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A6131E52;
	Thu, 15 Feb 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIvj6AeL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1712D74D;
	Thu, 15 Feb 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006526; cv=none; b=aGb6ScZsKgWBfNr7/PH21a+kTumdy3YadB2u2urRJ0PGzwiinQw5+19lq/tTclqP1pdASTwomqlaB9Emyvx2mK/VH02NXPttn68Yn4xff4cNBFaoiR+Zb8HMZ1eyZYWK1rvh/aGdezaQtyNvi9t4UeVEcExt1F7pfBwQiy0CuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006526; c=relaxed/simple;
	bh=FcHteD02PMPntlTNZ7Jd5XPYsanUAkd4u7PiBmK5gA4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eJKnLTZxd1lbb6Sk5YpRMmZaVoHRbJqMOxaUA5OSJRYgqqLzDXKx8v/C+wLb4AbgTk/Tmljip1rVtzkw9a5IvnfhtdW7/KV114vD5OrgGtOgmMCKcUyA5fOiiQcvJxjsnL4WBrVCblfbQ7qcMlf2AFbc8lpRLeGrOHwDYnOiuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIvj6AeL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708006525; x=1739542525;
  h=date:from:to:cc:subject:message-id;
  bh=FcHteD02PMPntlTNZ7Jd5XPYsanUAkd4u7PiBmK5gA4=;
  b=MIvj6AeLf+ZPzXj6i7bh9haQ7fjlTVdYFx8o2GNeqV0/K51LV+1s9Ahk
   2+XYAARoXq5xEsp0qwwJ05rI7zIkKiTTiEghqh0QM9zbuB5Wc6vEUUL7z
   EJK9uH73/1esnrVcE9lblI6cKqK6rR/eFoxRcUpId0TGZYL+cPor9eU47
   8p+cKWoC1F76H7Dp3BPGDJHb5Rja/+dA0cOWso3hqX1x+BZ6KJL6zDzrq
   BDjvvPVshacRykF+O/Am4Ilqw1vduZpGq+VmUxaYIFJKpqrJxJV2AnFYF
   S1N0eIfli95xKQYgDRBEh3wwq8RtO50ueDb+ck+04NgGxCmouE36A7cbM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5905889"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5905889"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3534543"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 15 Feb 2024 06:15:22 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1racVR-0000Ye-0j;
	Thu, 15 Feb 2024 14:14:54 +0000
Date: Thu, 15 Feb 2024 22:14:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3155f8c5dcdd4c1926ee67feebaacdff4797294b
Message-ID: <202402152212.lodmt6n3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3155f8c5dcdd4c1926ee67feebaacdff4797294b  Merge branch 'thermal-core-testing' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-defconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-r062-20240215
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- mips-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-randconfig-001-20240215
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-buildonly-randconfig-003-20240215
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-buildonly-randconfig-006-20240215
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-randconfig-073-20240215
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
`-- x86_64-randconfig-074-20240215
    |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
    `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
clang_recent_errors
|-- arm64-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-buildonly-randconfig-006-20240215
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-003-20240215
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-015-20240215
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- riscv-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- riscv-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
`-- x86_64-randconfig-001-20240215
    |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
    `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used

elapsed time: 1459m

configs tested: 179
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
arc                   randconfig-001-20240215   gcc  
arc                   randconfig-002-20240215   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240215   clang
arm                   randconfig-002-20240215   gcc  
arm                   randconfig-003-20240215   gcc  
arm                   randconfig-004-20240215   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240215   clang
arm64                 randconfig-002-20240215   clang
arm64                 randconfig-003-20240215   gcc  
arm64                 randconfig-004-20240215   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240215   gcc  
csky                  randconfig-002-20240215   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240215   clang
hexagon               randconfig-002-20240215   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240215   clang
i386         buildonly-randconfig-002-20240215   clang
i386         buildonly-randconfig-003-20240215   clang
i386         buildonly-randconfig-004-20240215   clang
i386         buildonly-randconfig-005-20240215   clang
i386         buildonly-randconfig-006-20240215   clang
i386                                defconfig   clang
i386                  randconfig-001-20240215   gcc  
i386                  randconfig-002-20240215   gcc  
i386                  randconfig-003-20240215   clang
i386                  randconfig-004-20240215   gcc  
i386                  randconfig-005-20240215   gcc  
i386                  randconfig-006-20240215   gcc  
i386                  randconfig-011-20240215   clang
i386                  randconfig-012-20240215   clang
i386                  randconfig-013-20240215   gcc  
i386                  randconfig-014-20240215   gcc  
i386                  randconfig-015-20240215   clang
i386                  randconfig-016-20240215   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240215   gcc  
loongarch             randconfig-002-20240215   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   clang
mips                         db1xxx_defconfig   clang
mips                      fuloong2e_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240215   gcc  
nios2                 randconfig-002-20240215   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240215   gcc  
parisc                randconfig-002-20240215   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                       maple_defconfig   clang
powerpc               randconfig-001-20240215   gcc  
powerpc               randconfig-002-20240215   clang
powerpc               randconfig-003-20240215   clang
powerpc64             randconfig-001-20240215   clang
powerpc64             randconfig-002-20240215   gcc  
powerpc64             randconfig-003-20240215   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240215   gcc  
riscv                 randconfig-002-20240215   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240215   clang
s390                  randconfig-002-20240215   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240215   gcc  
sh                    randconfig-002-20240215   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240215   gcc  
sparc64               randconfig-002-20240215   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240215   gcc  
um                    randconfig-002-20240215   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240215   clang
x86_64       buildonly-randconfig-002-20240215   clang
x86_64       buildonly-randconfig-003-20240215   gcc  
x86_64       buildonly-randconfig-004-20240215   gcc  
x86_64       buildonly-randconfig-005-20240215   clang
x86_64       buildonly-randconfig-006-20240215   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240215   clang
x86_64                randconfig-002-20240215   clang
x86_64                randconfig-003-20240215   gcc  
x86_64                randconfig-004-20240215   clang
x86_64                randconfig-005-20240215   clang
x86_64                randconfig-006-20240215   clang
x86_64                randconfig-011-20240215   gcc  
x86_64                randconfig-012-20240215   gcc  
x86_64                randconfig-013-20240215   gcc  
x86_64                randconfig-014-20240215   gcc  
x86_64                randconfig-015-20240215   gcc  
x86_64                randconfig-016-20240215   clang
x86_64                randconfig-071-20240215   clang
x86_64                randconfig-072-20240215   clang
x86_64                randconfig-073-20240215   gcc  
x86_64                randconfig-074-20240215   gcc  
x86_64                randconfig-075-20240215   clang
x86_64                randconfig-076-20240215   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240215   gcc  
xtensa                randconfig-002-20240215   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

