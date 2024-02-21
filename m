Return-Path: <linux-acpi+bounces-3773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595B285D25F
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 09:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8B11F24A03
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419FD3BB20;
	Wed, 21 Feb 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlKR26SD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8303BB23;
	Wed, 21 Feb 2024 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503485; cv=none; b=J6b7j8uKi6HVCbfFOliEY3rcBJz/6trnUThLAtMiP+VjhZT0eqg1SP6mJFPHaBo0jS1tqI7NhNO6tjKRmPpeZ+vIWnfxwrwq7txBalBXp8iCzG/XblcoLUOnBrj7qy0FqsqIp68U6L6lESc4kb2vQ4haXYOUv0k8nHCthybuekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503485; c=relaxed/simple;
	bh=YRosB2M6G0YumLChNXKxsSUOo02KLncccTjH2tOxpaw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pNcHCrisNoTxRBzdtwyt2ML4L1V4ijNTzAhHiDgOR8uAXgqku+7EM45O8f9e+5FPmixBZ8uLlawY2ygqcuUr4VMa6h4ozFt/eKnZkLVmzwIbaLzVg8IOYLAlCxW/YfDVjgFm2MqM/sjp4Ic7FX/SxLn3hdfBirZrlSBc53HeZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlKR26SD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708503483; x=1740039483;
  h=date:from:to:cc:subject:message-id;
  bh=YRosB2M6G0YumLChNXKxsSUOo02KLncccTjH2tOxpaw=;
  b=BlKR26SD/wOazxB/9APlVJWy0KhbTqk91VPfKOA3hT/1L/gwGrvS7qMX
   uCaXG2lGSHh9QNXd/mD4c7GG1MVG1ru0hQq75V50ZSOGxbqlqjLkgKtIE
   /fcP/UBviaYu70WGA/oO+Bc+0xyAmC6GoRT8eoRnaU1I1ciAcuYjk5YyC
   yLC+mjj0qgkUjwyXxZ6I1XZUYhsD7Y7ynscqArAY7kzl6r1kzb4AcNZh6
   SxJHtpvu4t9oy44z8Y+5Bp1d45USt1K5tVBlD92jDqxQnUZ2eSfzSY75l
   Tzf21Qzy+vDVe6hERs09Y0dEWuwbq/zJfolt9hoxfwKzWwoUjGPAsMIyf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2536628"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2536628"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 00:18:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9685123"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 Feb 2024 00:18:00 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rchnR-0005AW-0k;
	Wed, 21 Feb 2024 08:17:46 +0000
Date: Wed, 21 Feb 2024 16:16:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 18e0452b740e01daf1abb498116ad89716bfd5bc
Message-ID: <202402211643.99kLO5dl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 18e0452b740e01daf1abb498116ad89716bfd5bc  Merge branch 'acpi-scan' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-defconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-randconfig-001-20240221
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-buildonly-randconfig-006-20240221
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-015-20240221
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-141-20240221
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- mips-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc64-randconfig-002-20240221
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc64-randconfig-003-20240221
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc64-randconfig-002-20240221
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
`-- x86_64-buildonly-randconfig-002-20240221
    |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
    `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
clang_recent_errors
|-- i386-randconfig-014-20240221
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
`-- x86_64-allyesconfig
    |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
    `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used

elapsed time: 726m

configs tested: 177
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
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240221   gcc  
arc                   randconfig-002-20240221   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                   randconfig-001-20240221   clang
arm                   randconfig-002-20240221   clang
arm                   randconfig-003-20240221   gcc  
arm                   randconfig-004-20240221   clang
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240221   gcc  
arm64                 randconfig-002-20240221   gcc  
arm64                 randconfig-003-20240221   gcc  
arm64                 randconfig-004-20240221   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240221   gcc  
csky                  randconfig-002-20240221   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240221   clang
hexagon               randconfig-002-20240221   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240221   gcc  
i386         buildonly-randconfig-002-20240221   clang
i386         buildonly-randconfig-003-20240221   gcc  
i386         buildonly-randconfig-004-20240221   gcc  
i386         buildonly-randconfig-005-20240221   gcc  
i386         buildonly-randconfig-006-20240221   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240221   gcc  
i386                  randconfig-002-20240221   clang
i386                  randconfig-003-20240221   clang
i386                  randconfig-004-20240221   gcc  
i386                  randconfig-005-20240221   gcc  
i386                  randconfig-006-20240221   clang
i386                  randconfig-011-20240221   gcc  
i386                  randconfig-012-20240221   clang
i386                  randconfig-013-20240221   gcc  
i386                  randconfig-014-20240221   clang
i386                  randconfig-015-20240221   gcc  
i386                  randconfig-016-20240221   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240221   gcc  
loongarch             randconfig-002-20240221   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                        omega2p_defconfig   clang
mips                      pic32mzda_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240221   gcc  
nios2                 randconfig-002-20240221   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240221   gcc  
parisc                randconfig-002-20240221   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   clang
powerpc               randconfig-001-20240221   gcc  
powerpc               randconfig-002-20240221   gcc  
powerpc               randconfig-003-20240221   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240221   gcc  
powerpc64             randconfig-002-20240221   gcc  
powerpc64             randconfig-003-20240221   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20240221   clang
riscv                 randconfig-002-20240221   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240221   clang
s390                  randconfig-002-20240221   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240221   gcc  
sh                    randconfig-002-20240221   gcc  
sh                          sdk7780_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240221   gcc  
sparc64               randconfig-002-20240221   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240221   gcc  
um                    randconfig-002-20240221   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240221   clang
x86_64       buildonly-randconfig-002-20240221   gcc  
x86_64       buildonly-randconfig-003-20240221   gcc  
x86_64       buildonly-randconfig-004-20240221   clang
x86_64       buildonly-randconfig-005-20240221   clang
x86_64       buildonly-randconfig-006-20240221   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240221   gcc  
x86_64                randconfig-002-20240221   gcc  
x86_64                randconfig-003-20240221   gcc  
x86_64                randconfig-004-20240221   gcc  
x86_64                randconfig-005-20240221   gcc  
x86_64                randconfig-006-20240221   gcc  
x86_64                randconfig-011-20240221   clang
x86_64                randconfig-012-20240221   gcc  
x86_64                randconfig-013-20240221   clang
x86_64                randconfig-014-20240221   gcc  
x86_64                randconfig-015-20240221   gcc  
x86_64                randconfig-016-20240221   gcc  
x86_64                randconfig-071-20240221   gcc  
x86_64                randconfig-072-20240221   gcc  
x86_64                randconfig-073-20240221   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240221   gcc  
xtensa                randconfig-002-20240221   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

