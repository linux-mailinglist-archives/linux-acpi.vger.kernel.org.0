Return-Path: <linux-acpi+bounces-6858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6792E3B8
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976731C21289
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915781509AE;
	Thu, 11 Jul 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeJwDfwB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DB7EEE7;
	Thu, 11 Jul 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691302; cv=none; b=sBUSu0fJu8YqvyNXmm4H6DTDQptNccb9j5VAF6rHJ2opnt5X3eLwgA0c99it4PY8NL7yITFqVdDgMpUYKvVlg9wsJLvwvrGH2LrQoyIGdiAt+IJtSo8z0Dd9uUmaQ91GCqkrc21BELnF3DHXfqp5MbNmpKMOnPm2T8w7kC7Nf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691302; c=relaxed/simple;
	bh=+MoSjA0p9IblJXh2kiCUht1U0WEbUqVEJc+uPnviA2M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rDZDpVPOL2OwYs8t/z6okGr9A7yr3/TPUEODeFCZWyPChDRXTZFvQYRXwE9GYNQsYaT4kFxMJRUZ3/uuCQediHwuhhJJqyr7pAeq+sdU4feVqmqn/UcrXY0XsJGyL/jmoxUxcQ1a5s4IiBIOEN4zryasVewhEt+pqsx6bNOWbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeJwDfwB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720691301; x=1752227301;
  h=date:from:to:cc:subject:message-id;
  bh=+MoSjA0p9IblJXh2kiCUht1U0WEbUqVEJc+uPnviA2M=;
  b=eeJwDfwBG+FV+a3zcrSVc/o2LWLFWxDHhqQy4x1u8nd3u6qGk0GzhhPY
   U4Q2UsrThqQtkw5EEBRMQVpVH8Mvq9D7YOiXDSIOcvH9GVL7m4bkA1HDo
   VG4zIfTTt3pit1EkkiPPIrWKxe/4oCguCupLRliRulk5bzonZzJDhIopW
   FkYWiqPNnBQH7d8zanZS3eUtb+SWdc7LPLLzSMDVGLrXkUKsI70QryQHC
   ckwCBmZkHL6pY2suW7d+xQUjr13IQNguQZgDuB+4GJQ0XmAGUhxAvfCJP
   t5Wh4vmljv3/GwTXkhEttRqiHn6UaJIXzECs1MSAk4newe8KKcURIEgGW
   w==;
X-CSE-ConnectionGUID: FNt7itjHRKafx8tpFG+hZw==
X-CSE-MsgGUID: yIHNudszRZCmsqH0hytW3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18194682"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="18194682"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:48:21 -0700
X-CSE-ConnectionGUID: B22k1LNsRJ+GdHW/63943w==
X-CSE-MsgGUID: 3mj3TerSStemJ3QmKydITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="71725763"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jul 2024 02:48:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRqPQ-000Z73-0n;
	Thu, 11 Jul 2024 09:48:16 +0000
Date: Thu, 11 Jul 2024 17:47:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ecea71f32ac764472931531d00cff6f94b56cc22
Message-ID: <202407111747.LJINPudI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ecea71f32ac764472931531d00cff6f94b56cc22  Merge branch 'thermal-core-next' into bleeding-edge

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- alpha-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- arc-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- arc-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- arm-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- arm-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- arm64-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- arm64-defconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- arm64-randconfig-002-20240711
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- arm64-randconfig-004-20240711
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- i386-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- i386-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- loongarch-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- loongarch-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- loongarch-randconfig-002-20240711
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- m68k-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- m68k-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- microblaze-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- microblaze-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- mips-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- mips-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- openrisc-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- parisc-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- parisc-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- powerpc-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- powerpc-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- riscv-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- riscv-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- s390-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- s390-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- sh-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- sh-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- sparc-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- sparc-allyesconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- sparc64-randconfig-002-20240711
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
|-- x86_64-allmodconfig
|   `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret
`-- x86_64-allyesconfig
    `-- drivers-thermal-tegra-soctherm.c:warning:unused-variable-ret

elapsed time: 1249m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240711   gcc-13.2.0
arc                   randconfig-002-20240711   gcc-13.2.0
arm                              allmodconfig   gcc-13.3.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.3.0
arm                       aspeed_g4_defconfig   clang-19
arm                            mps2_defconfig   clang-19
arm                            qcom_defconfig   clang-19
arm                   randconfig-001-20240711   clang-19
arm                   randconfig-002-20240711   gcc-13.3.0
arm                   randconfig-003-20240711   clang-19
arm                   randconfig-004-20240711   gcc-13.3.0
arm                          sp7021_defconfig   gcc-13.3.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.3.0
arm64                 randconfig-001-20240711   clang-19
arm64                 randconfig-002-20240711   gcc-13.2.0
arm64                 randconfig-003-20240711   gcc-13.2.0
arm64                 randconfig-004-20240711   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.3.0
csky                  randconfig-001-20240711   gcc-13.3.0
csky                  randconfig-002-20240711   gcc-13.3.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240711   clang-19
hexagon               randconfig-002-20240711   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240711   gcc-13
i386         buildonly-randconfig-002-20240711   gcc-10
i386         buildonly-randconfig-003-20240711   gcc-13
i386         buildonly-randconfig-004-20240711   gcc-8
i386         buildonly-randconfig-005-20240711   gcc-10
i386         buildonly-randconfig-006-20240711   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240711   gcc-13
i386                  randconfig-002-20240711   gcc-10
i386                  randconfig-003-20240711   gcc-8
i386                  randconfig-004-20240711   gcc-13
i386                  randconfig-005-20240711   clang-18
i386                  randconfig-006-20240711   gcc-13
i386                  randconfig-011-20240711   gcc-9
i386                  randconfig-012-20240711   clang-18
i386                  randconfig-013-20240711   gcc-13
i386                  randconfig-014-20240711   clang-18
i386                  randconfig-015-20240711   clang-18
i386                  randconfig-016-20240711   gcc-9
loongarch                        allmodconfig   gcc-13.3.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.3.0
loongarch             randconfig-001-20240711   gcc-13.3.0
loongarch             randconfig-002-20240711   gcc-13.3.0
m68k                             allmodconfig   gcc-13.3.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.3.0
m68k                             allyesconfig   gcc-13.3.0
m68k                            mac_defconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.3.0
mips                         db1xxx_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.3.0
nios2                 randconfig-001-20240711   gcc-13.3.0
nios2                 randconfig-002-20240711   gcc-13.3.0
openrisc                          allnoconfig   gcc-13.3.0
openrisc                         allyesconfig   gcc-13.3.0
openrisc                            defconfig   gcc-13.3.0
parisc                           allmodconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-13.3.0
parisc                           allyesconfig   gcc-13.3.0
parisc                              defconfig   gcc-13.3.0
parisc                randconfig-001-20240711   gcc-13.3.0
parisc                randconfig-002-20240711   gcc-13.3.0
powerpc                          allmodconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-13.3.0
powerpc                          allyesconfig   clang-19
powerpc                       ebony_defconfig   clang-19
powerpc                      obs600_defconfig   clang-14
powerpc               randconfig-001-20240711   gcc-13.3.0
powerpc               randconfig-002-20240711   clang-19
powerpc               randconfig-003-20240711   clang-19
powerpc                     stx_gp3_defconfig   clang-19
powerpc64             randconfig-001-20240711   gcc-13.3.0
powerpc64             randconfig-002-20240711   clang-16
powerpc64             randconfig-003-20240711   gcc-13.3.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.3.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240711   clang-14
riscv                 randconfig-002-20240711   gcc-13.3.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240711   clang-19
s390                  randconfig-002-20240711   gcc-13.2.0
sh                               allmodconfig   gcc-13.3.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.3.0
sh                               allyesconfig   gcc-13.3.0
sh                                  defconfig   gcc-13.3.0
sh                    randconfig-001-20240711   gcc-13.3.0
sh                    randconfig-002-20240711   gcc-13.3.0
sparc                            allmodconfig   gcc-13.3.0
sparc64                             defconfig   gcc-13.3.0
sparc64               randconfig-001-20240711   gcc-13.3.0
sparc64               randconfig-002-20240711   gcc-13.3.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240711   gcc-8
um                    randconfig-002-20240711   gcc-8
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240711   clang-18
x86_64       buildonly-randconfig-002-20240711   clang-18
x86_64       buildonly-randconfig-003-20240711   clang-18
x86_64       buildonly-randconfig-004-20240711   clang-18
x86_64       buildonly-randconfig-005-20240711   gcc-13
x86_64       buildonly-randconfig-006-20240711   gcc-13
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240711   gcc-13
x86_64                randconfig-002-20240711   gcc-13
x86_64                randconfig-003-20240711   gcc-11
x86_64                randconfig-004-20240711   gcc-9
x86_64                randconfig-005-20240711   clang-18
x86_64                randconfig-006-20240711   gcc-13
x86_64                randconfig-011-20240711   gcc-13
x86_64                randconfig-012-20240711   clang-18
x86_64                randconfig-013-20240711   gcc-13
x86_64                randconfig-014-20240711   clang-18
x86_64                randconfig-015-20240711   clang-18
x86_64                randconfig-016-20240711   gcc-10
x86_64                randconfig-071-20240711   gcc-13
x86_64                randconfig-072-20240711   gcc-13
x86_64                randconfig-073-20240711   clang-18
x86_64                randconfig-074-20240711   gcc-13
x86_64                randconfig-075-20240711   clang-18
x86_64                randconfig-076-20240711   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-13.3.0
xtensa                randconfig-001-20240711   gcc-13.3.0
xtensa                randconfig-002-20240711   gcc-13.3.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

