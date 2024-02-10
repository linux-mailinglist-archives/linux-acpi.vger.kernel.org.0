Return-Path: <linux-acpi+bounces-3351-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0842850461
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 13:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBD41C20E70
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974B3DBBA;
	Sat, 10 Feb 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Utj0kcwV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1F3DBB2;
	Sat, 10 Feb 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707568164; cv=none; b=An+/pErcJGeNokdOtzF1c78QqxMGg9qZ+a/jIAZQs/EzWgGRvzXaSHJtgYeRseA534wOLPznj8RGbJt28nx8iwRKn7WPufvIEpgewT9SNEduzD9I/qoV0qv/Y8lVAd7+iqHizxLFVmZmv9MIgB+c/6jLTPzZCoqTDO6qme9XGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707568164; c=relaxed/simple;
	bh=Hd1+wd5WnJX46yEwmD9CpuyvK+iJv2KUOnUZ+dhdMfQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qZt9baJjhQjTpXPKpI76jCzDSKlDL07nCrrOUryKayZTAA0kpcJBK6aBjVI/1A/0iedx6KSN+2/IQtd+s9YHge+OUjkV121Uc60LDNPoxqHfMeP6Eo4MUVbQssY2/Xo5XEBivMMNTCg72qzDm6fU9S3zDZrajJtFbM8+oRYORjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Utj0kcwV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707568162; x=1739104162;
  h=date:from:to:cc:subject:message-id;
  bh=Hd1+wd5WnJX46yEwmD9CpuyvK+iJv2KUOnUZ+dhdMfQ=;
  b=Utj0kcwVPn/EhSDw1FwdhYRwJR97uFkRXDfhaiMjyYTD6D8nt5bWYv/D
   PDYFNcRzx/5VgG3sGOcfApgKgiSpWmpC18IX3mMcHg3r+XGGZUZusXoSa
   1LE4ANDjUmQVjtWp6gaIwSEs43OmQJhViC6UiWOaHyXgQnJVJxCbp14s5
   Z2ySaUlch+lW2jiyT+yTTISXQYmgLMIKMrx4aa4AgokkEcAi04ZIuglAe
   BEksFwv1FJy3a/Smg5XG7uUHRO3Y5uwp708mJlwEe5XnzHwKAZ+8G/tGr
   3pYVd+Ra2Zumrhf2mZVoKRRmCod8p8yu0oTkkUvJ0dOs3Z9WjgVFKQLCA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1708565"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1708565"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 04:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="6815068"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Feb 2024 04:29:19 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYmTs-0005dw-2P;
	Sat, 10 Feb 2024 12:29:16 +0000
Date: Sat, 10 Feb 2024 20:28:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 2bc44535ed4f6a6013ec53b505c4c381e166f0ce
Message-ID: <202402102032.dc9RFTdT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2bc44535ed4f6a6013ec53b505c4c381e166f0ce  Merge branch 'thermal-core-testing' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402092329.W4VIvzU0-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402100947.E7EZyIMp-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402101037.cQIOnsH8-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/thermal/intel/intel_quark_dts_thermal.c:353:17: error: 'trips' undeclared (first use in this function)
drivers/thermal/thermal_of.c:536:15: error: incompatible type for argument 1 of 'kfree'
drivers/thermal/thermal_of.c:536:8: error: passing 'struct thermal_zone_device_ops' to parameter of incompatible type 'const void *'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-defconfig
|   |-- drivers-thermal-thermal_of.c:error:incompatible-type-for-argument-of-kfree
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-allmodconfig
|   |-- drivers-thermal-intel-intel_quark_dts_thermal.c:error:trips-undeclared-(first-use-in-this-function)
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-thermal-intel-intel_quark_dts_thermal.c:error:trips-undeclared-(first-use-in-this-function)
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-141-20240209
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- loongarch-randconfig-001-20240210
|   `-- drivers-thermal-thermal_of.c:error:incompatible-type-for-argument-of-kfree
|-- mips-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- mips-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- nios2-randconfig-002-20240210
|   `-- drivers-thermal-thermal_of.c:error:incompatible-type-for-argument-of-kfree
|-- powerpc-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-randconfig-001-20240210
|   `-- drivers-thermal-thermal_of.c:error:incompatible-type-for-argument-of-kfree
|-- s390-allyesconfig
|   `-- drivers-thermal-thermal_of.c:error:incompatible-type-for-argument-of-kfree
|-- s390-randconfig-002-20240210
|   `-- drivers-thermal-thermal_of.c:error:incompatible-type-for-argument-of-kfree
|-- sh-allmodconfig
|   `-- drivers-thermal-thermal_of.c:error:incompatible-type-for-argument-of-kfree
|-- sparc-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc-allyesconfig
|   |-- drivers-thermal-thermal_of.c:error:incompatible-type-for-argument-of-kfree
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc64-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc64-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc64-randconfig-002-20240210
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- sparc64-randconfig-r064-20240210
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-buildonly-randconfig-001-20240209
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- x86_64-randconfig-161-20240209
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
`-- xtensa-allyesconfig
    `-- drivers-thermal-thermal_of.c:error:incompatible-type-for-argument-of-kfree
clang_recent_errors
|-- arm-defconfig
|   `-- drivers-thermal-thermal_of.c:error:passing-struct-thermal_zone_device_ops-to-parameter-of-incompatible-type-const-void
|-- arm64-allmodconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- arm64-randconfig-001-20240210
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-001-20240209
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- i386-randconfig-004-20240209
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-allyesconfig
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc-randconfig-002-20240210
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
|-- powerpc64-randconfig-001-20240210
|   `-- drivers-thermal-thermal_of.c:error:passing-struct-thermal_zone_device_ops-to-parameter-of-incompatible-type-const-void
|-- powerpc64-randconfig-002-20240210
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
|-- x86_64-randconfig-011-20240209
|   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
|   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
`-- x86_64-randconfig-101-20240210
    |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
    `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used

elapsed time: 1446m

configs tested: 178
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240210   gcc  
arc                   randconfig-002-20240210   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                      jornada720_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240210   gcc  
arm                   randconfig-002-20240210   gcc  
arm                   randconfig-003-20240210   gcc  
arm                   randconfig-004-20240210   gcc  
arm                        shmobile_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240210   clang
arm64                 randconfig-002-20240210   gcc  
arm64                 randconfig-003-20240210   gcc  
arm64                 randconfig-004-20240210   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240210   gcc  
csky                  randconfig-002-20240210   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240210   clang
hexagon               randconfig-002-20240210   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240209   clang
i386         buildonly-randconfig-002-20240209   clang
i386         buildonly-randconfig-003-20240209   gcc  
i386         buildonly-randconfig-004-20240209   clang
i386         buildonly-randconfig-005-20240209   clang
i386         buildonly-randconfig-006-20240209   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240209   clang
i386                  randconfig-002-20240209   gcc  
i386                  randconfig-003-20240209   clang
i386                  randconfig-004-20240209   clang
i386                  randconfig-005-20240209   clang
i386                  randconfig-006-20240209   gcc  
i386                  randconfig-011-20240209   gcc  
i386                  randconfig-012-20240209   gcc  
i386                  randconfig-013-20240209   clang
i386                  randconfig-014-20240209   gcc  
i386                  randconfig-015-20240209   gcc  
i386                  randconfig-016-20240209   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240210   gcc  
loongarch             randconfig-002-20240210   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240210   gcc  
nios2                 randconfig-002-20240210   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240210   gcc  
parisc                randconfig-002-20240210   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc               randconfig-001-20240210   gcc  
powerpc               randconfig-002-20240210   clang
powerpc               randconfig-003-20240210   gcc  
powerpc64             randconfig-001-20240210   clang
powerpc64             randconfig-002-20240210   clang
powerpc64             randconfig-003-20240210   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240210   gcc  
riscv                 randconfig-002-20240210   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240210   gcc  
s390                  randconfig-002-20240210   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240210   gcc  
sh                    randconfig-002-20240210   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240210   gcc  
sparc64               randconfig-002-20240210   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240210   gcc  
um                    randconfig-002-20240210   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240209   gcc  
x86_64       buildonly-randconfig-002-20240209   gcc  
x86_64       buildonly-randconfig-003-20240209   clang
x86_64       buildonly-randconfig-004-20240209   gcc  
x86_64       buildonly-randconfig-005-20240209   clang
x86_64       buildonly-randconfig-006-20240209   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240209   clang
x86_64                randconfig-002-20240209   gcc  
x86_64                randconfig-003-20240209   gcc  
x86_64                randconfig-004-20240209   clang
x86_64                randconfig-005-20240209   gcc  
x86_64                randconfig-006-20240209   gcc  
x86_64                randconfig-011-20240209   clang
x86_64                randconfig-012-20240209   clang
x86_64                randconfig-013-20240209   gcc  
x86_64                randconfig-014-20240209   clang
x86_64                randconfig-015-20240209   gcc  
x86_64                randconfig-016-20240209   clang
x86_64                randconfig-071-20240209   gcc  
x86_64                randconfig-072-20240209   clang
x86_64                randconfig-073-20240209   clang
x86_64                randconfig-074-20240209   gcc  
x86_64                randconfig-075-20240209   gcc  
x86_64                randconfig-076-20240209   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240210   gcc  
xtensa                randconfig-002-20240210   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

