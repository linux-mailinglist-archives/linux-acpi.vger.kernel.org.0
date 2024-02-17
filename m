Return-Path: <linux-acpi+bounces-3656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B283085920A
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Feb 2024 20:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D812845EC
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Feb 2024 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16D07E10F;
	Sat, 17 Feb 2024 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bG6yvhau"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926741E498;
	Sat, 17 Feb 2024 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708197808; cv=none; b=G8TVdd2SkrROdDxIhjZpyGu8uPzM6kzSeL/ALsuRy5o+4ZHzx7iGnXc/iUYqrS/EtiIAsdJj60ZqUowjZnaFrz4ogFMbg9TCsBCr4RzeoRB8bCPyj3con7S23e8yrv43Wfnz9YyuNnrcQhodX6e+Jm3KCqPgiKfiu1IsbBWNO9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708197808; c=relaxed/simple;
	bh=8JfZBygg2BjL4GyaOWxEHlt25xx6FKGw9zIRJOE3u48=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ECN+ifQu8jjovK2RCQ907VqT4hBqQrCVGdIsxWvVUuRVVfR6iP+zIIgF/IL6pkIIkQ/R3A9SYKAQb29j80TKOjO+KrtV3jz1QXnZK/HzSvi9A1ogWtpg49Hldxz6pGVklUTVS2TuB4oKox66aibaBB/tGg+DwZA09lWQPd96tCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bG6yvhau; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708197806; x=1739733806;
  h=date:from:to:cc:subject:message-id;
  bh=8JfZBygg2BjL4GyaOWxEHlt25xx6FKGw9zIRJOE3u48=;
  b=bG6yvhauAYdc8VKg9AjBtNcCcZ1WHTssScemZrrFIYFeP/eVDlGYOR+L
   2dL8od0tGSSiWYnC5/FsBQNmVTea6xvhoDaeH3uy1+fTiXk/aNNQV3eyv
   sKt+8OK2CMg3BrG51/nIUulHrth+seR141jneoU/zV+vj8Ko/n+5U3D4o
   4CaiDnV/KhViO+rk9iyXOZW1xPqQWkBsO1EjDd4faQ6c1oMrdn41ARloT
   Cw1mboSl+TSShq4d9gx2++ISWUGBzJgVlNNjk1f1nr1HYtqtX7JCswSex
   kJHzEgzo44zon/DdobTkXzI/mNJnZwWO05baSQnP1NFzwIzQ5RN/U5wgp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="6089002"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="6089002"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 11:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="35163419"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 17 Feb 2024 11:23:24 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbQHS-0002RK-14;
	Sat, 17 Feb 2024 19:23:22 +0000
Date: Sun, 18 Feb 2024 03:22:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 15b11c1aa49bcd33cac389d7dee6fe3321a6eef9
Message-ID: <202402180351.E5zrj8yi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 15b11c1aa49bcd33cac389d7dee6fe3321a6eef9  Merge branch 'pm-powercap' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-defconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-randconfig-002-20240217
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-randconfig-003-20240217
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-buildonly-randconfig-005-20240217
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-002-20240217
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- mips-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-randconfig-001-20240217
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-randconfig-003-20240217
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc64-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
`-- sparc64-allyesconfig
    |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
    `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
clang_recent_errors
|-- arm64-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-randconfig-004-20240217
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-052-20240217
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
`-- x86_64-randconfig-074-20240217
    |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
    `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used

elapsed time: 1447m

configs tested: 176
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240217   gcc  
arc                   randconfig-002-20240217   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                           imxrt_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                            mps2_defconfig   clang
arm                        mvebu_v7_defconfig   clang
arm                   randconfig-001-20240217   clang
arm                   randconfig-002-20240217   gcc  
arm                   randconfig-003-20240217   gcc  
arm                   randconfig-004-20240217   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240217   clang
arm64                 randconfig-002-20240217   gcc  
arm64                 randconfig-003-20240217   gcc  
arm64                 randconfig-004-20240217   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240217   gcc  
csky                  randconfig-002-20240217   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240217   clang
hexagon               randconfig-002-20240217   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240217   gcc  
i386         buildonly-randconfig-002-20240217   clang
i386         buildonly-randconfig-003-20240217   gcc  
i386         buildonly-randconfig-004-20240217   gcc  
i386         buildonly-randconfig-005-20240217   gcc  
i386         buildonly-randconfig-006-20240217   clang
i386                                defconfig   clang
i386                  randconfig-001-20240217   gcc  
i386                  randconfig-002-20240217   gcc  
i386                  randconfig-003-20240217   clang
i386                  randconfig-004-20240217   gcc  
i386                  randconfig-005-20240217   gcc  
i386                  randconfig-006-20240217   clang
i386                  randconfig-011-20240217   gcc  
i386                  randconfig-012-20240217   gcc  
i386                  randconfig-013-20240217   clang
i386                  randconfig-014-20240217   clang
i386                  randconfig-015-20240217   clang
i386                  randconfig-016-20240217   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240217   gcc  
loongarch             randconfig-002-20240217   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        maltaup_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240217   gcc  
nios2                 randconfig-002-20240217   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240217   gcc  
parisc                randconfig-002-20240217   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                          g5_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240217   gcc  
powerpc               randconfig-002-20240217   gcc  
powerpc               randconfig-003-20240217   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240217   clang
powerpc64             randconfig-002-20240217   gcc  
powerpc64             randconfig-003-20240217   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240217   gcc  
riscv                 randconfig-002-20240217   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240217   clang
s390                  randconfig-002-20240217   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240217   gcc  
sh                    randconfig-002-20240217   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240217   gcc  
sparc64               randconfig-002-20240217   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240217   clang
um                    randconfig-002-20240217   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240217   gcc  
x86_64       buildonly-randconfig-002-20240217   clang
x86_64       buildonly-randconfig-003-20240217   gcc  
x86_64       buildonly-randconfig-004-20240217   gcc  
x86_64       buildonly-randconfig-005-20240217   clang
x86_64       buildonly-randconfig-006-20240217   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240217   gcc  
x86_64                randconfig-002-20240217   clang
x86_64                randconfig-003-20240217   clang
x86_64                randconfig-004-20240217   clang
x86_64                randconfig-005-20240217   clang
x86_64                randconfig-006-20240217   clang
x86_64                randconfig-011-20240217   gcc  
x86_64                randconfig-012-20240217   gcc  
x86_64                randconfig-013-20240217   clang
x86_64                randconfig-014-20240217   gcc  
x86_64                randconfig-015-20240217   gcc  
x86_64                randconfig-016-20240217   clang
x86_64                randconfig-071-20240217   gcc  
x86_64                randconfig-072-20240217   gcc  
x86_64                randconfig-073-20240217   gcc  
x86_64                randconfig-074-20240217   clang
x86_64                randconfig-075-20240217   gcc  
x86_64                randconfig-076-20240217   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-002-20240217   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

