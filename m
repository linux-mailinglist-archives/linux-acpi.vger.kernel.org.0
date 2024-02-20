Return-Path: <linux-acpi+bounces-3716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B906585BC99
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 13:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0375B21172
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2969D25;
	Tue, 20 Feb 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdyKUAmZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600CE5D8E0;
	Tue, 20 Feb 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433552; cv=none; b=Btqd6oq3WRF00DCpOYx9w0FIJVsF9gcltv+Bni8lGO8o4MqVGxJsK00CA9+w40uZWl9CNTXD4JLwDXyaSPu4gfJLUeTOvYNR8tyj/eVVe2DN4mfK6WeWApGlnaVRh8lJMO0Ji8yWAl7c/5yB2expHSdsQik/Mqq3i0YHa5xQlL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433552; c=relaxed/simple;
	bh=27J29GbUYkzzrz24PCkzC+jn7tOu2G5+GGywDwpuzZo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iWQk0tJM7h5XuSJ85jBWaqOA4ZR933CjeBfbYhAUdGNlOvfL7zdmURlhZ0C2ZW4yVVJa8yzsIsoOxvhPcQ0j4qqFbDnPnt4vV8SmsDnyFxVg/iGCW/3TkS9UTkngDgJ8oypZC0HaAouFofketmA0MlaHQRy7Pc7eLFOMw+5KYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdyKUAmZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708433550; x=1739969550;
  h=date:from:to:cc:subject:message-id;
  bh=27J29GbUYkzzrz24PCkzC+jn7tOu2G5+GGywDwpuzZo=;
  b=XdyKUAmZRN3Nqg5cKfjOOp0reXPmA2gYj+roUbdPAEoXhWOWz9ocN3Io
   hpoCy48gHA7ME8n1jKNrqM4RNDaVZkJq5LcNdkNabIwTT7dH6Gz220gRo
   GVq4UVBRo7Uxq8FtUbRz/R9D9kfZIOChJBiyYkqKiww+/0V+lowwAfaCc
   cdlFXTGL3ZxeNsgrVbkxqTHXOB1TDIURluOZUeqDV040HNZnA0I21fIw0
   PLDf+tqONQDWrWLg8ll7DYewPS5xFRq/SFwemKrZopUd8lECbiUz8n9bf
   kqFN5LuPceTnN0n4bQrJpJ5mKiINDcDCCOn4Y+0J8gj6gTMzrUESAxrPx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2406320"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2406320"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 04:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9433487"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 20 Feb 2024 04:52:29 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcPbl-0004Vx-2F;
	Tue, 20 Feb 2024 12:52:25 +0000
Date: Tue, 20 Feb 2024 20:51:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3e16e0c79f4cf7872da721f32bc4c91f1ffa2216
Message-ID: <202402202047.zY4npFfT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3e16e0c79f4cf7872da721f32bc4c91f1ffa2216  Merge branch 'thermal-core-testing' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-defconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-051-20240220
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- mips-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- mips-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc64-randconfig-001-20240220
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc64-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc64-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-buildonly-randconfig-005-20240220
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-randconfig-001-20240220
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
`-- x86_64-randconfig-003-20240220
    |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
    `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
clang_recent_errors
|-- arm64-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-randconfig-002-20240220
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-randconfig-004-20240220
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-buildonly-randconfig-006-20240219
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-052-20240220
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-randconfig-003-20240220
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
|-- x86_64-buildonly-randconfig-001-20240220
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-randconfig-004-20240220
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
`-- x86_64-randconfig-012-20240220
    |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
    `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used

elapsed time: 1453m

configs tested: 172
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240220   gcc  
arc                   randconfig-002-20240220   gcc  
arm                               allnoconfig   clang
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240220   clang
arm                   randconfig-002-20240220   gcc  
arm                   randconfig-003-20240220   gcc  
arm                   randconfig-004-20240220   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240220   clang
arm64                 randconfig-002-20240220   clang
arm64                 randconfig-003-20240220   clang
arm64                 randconfig-004-20240220   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240220   gcc  
csky                  randconfig-002-20240220   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240220   clang
hexagon               randconfig-002-20240220   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240219   gcc  
i386         buildonly-randconfig-002-20240219   gcc  
i386         buildonly-randconfig-003-20240219   clang
i386         buildonly-randconfig-004-20240219   gcc  
i386         buildonly-randconfig-005-20240219   clang
i386         buildonly-randconfig-006-20240219   clang
i386                                defconfig   clang
i386                  randconfig-001-20240219   clang
i386                  randconfig-002-20240219   clang
i386                  randconfig-003-20240219   clang
i386                  randconfig-004-20240219   gcc  
i386                  randconfig-005-20240219   clang
i386                  randconfig-006-20240219   gcc  
i386                  randconfig-011-20240219   gcc  
i386                  randconfig-012-20240219   clang
i386                  randconfig-013-20240219   gcc  
i386                  randconfig-014-20240219   clang
i386                  randconfig-015-20240219   gcc  
i386                  randconfig-016-20240219   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240220   gcc  
loongarch             randconfig-002-20240220   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                     loongson1b_defconfig   clang
mips                     loongson1c_defconfig   gcc  
mips                           rs90_defconfig   gcc  
mips                        vocore2_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240220   gcc  
nios2                 randconfig-002-20240220   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240220   gcc  
parisc                randconfig-002-20240220   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240220   gcc  
powerpc               randconfig-002-20240220   clang
powerpc               randconfig-003-20240220   clang
powerpc64             randconfig-001-20240220   gcc  
powerpc64             randconfig-002-20240220   gcc  
powerpc64             randconfig-003-20240220   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240220   clang
riscv                 randconfig-002-20240220   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240220   gcc  
s390                  randconfig-002-20240220   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240220   gcc  
sh                    randconfig-002-20240220   gcc  
sh                           se7343_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240220   gcc  
sparc64               randconfig-002-20240220   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240220   gcc  
um                    randconfig-002-20240220   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240220   clang
x86_64       buildonly-randconfig-002-20240220   clang
x86_64       buildonly-randconfig-003-20240220   gcc  
x86_64       buildonly-randconfig-004-20240220   clang
x86_64       buildonly-randconfig-005-20240220   gcc  
x86_64       buildonly-randconfig-006-20240220   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240220   gcc  
x86_64                randconfig-002-20240220   gcc  
x86_64                randconfig-003-20240220   gcc  
x86_64                randconfig-004-20240220   clang
x86_64                randconfig-005-20240220   clang
x86_64                randconfig-006-20240220   gcc  
x86_64                randconfig-011-20240220   gcc  
x86_64                randconfig-012-20240220   clang
x86_64                randconfig-013-20240220   clang
x86_64                randconfig-014-20240220   gcc  
x86_64                randconfig-015-20240220   clang
x86_64                randconfig-016-20240220   gcc  
x86_64                randconfig-071-20240220   clang
x86_64                randconfig-072-20240220   clang
x86_64                randconfig-073-20240220   clang
x86_64                randconfig-074-20240220   clang
x86_64                randconfig-075-20240220   clang
x86_64                randconfig-076-20240220   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240220   gcc  
xtensa                randconfig-002-20240220   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

