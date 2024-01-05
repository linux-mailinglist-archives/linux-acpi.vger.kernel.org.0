Return-Path: <linux-acpi+bounces-2735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE8825331
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jan 2024 13:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61D328537E
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jan 2024 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E902CCC4;
	Fri,  5 Jan 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SO9Bsefo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770962CCBB;
	Fri,  5 Jan 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704456122; x=1735992122;
  h=date:from:to:cc:subject:message-id;
  bh=tgEzi/vx3qRRs+7/mhSmcgopQO/Owc77kON5raOul7M=;
  b=SO9Bsefo7fGWKtwD/vGixAwgGK7luFsxf69spZdpmLt4j/35+H2rsuUG
   PN7RYh951a5CdyUjlZMpp5RSkYBRHwFT7aOkrVvm0jJTQGKxYP8V5tswe
   1bidhaUG75j5L8SYQc6RTv+eITbK+1YLVrk7OoqnUWTCmkTjFmJqeavsv
   c++i4QayzXLPOpUgpch64jSli8UzBi0o4BqonPStfU+puzD55Cfh3EePP
   AbLv3I8RNi6h7WUFLYL8jfu/uQBZWdvRMVvwz5iB9onpZhTf09WzhxCmz
   aKjsGr1qUE0iLVNt93WeU2nZGZE69aXxXUdHZWbr2BeSdjYv+VOYl/1FM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="397214207"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="397214207"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 04:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773832386"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="773832386"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2024 04:01:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLitf-0001CA-0g;
	Fri, 05 Jan 2024 12:01:55 +0000
Date: Fri, 05 Jan 2024 20:00:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 92626c145ac3f7688020cc855716febabc1d9a86
Message-ID: <202401052057.CPnMI5Jm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 92626c145ac3f7688020cc855716febabc1d9a86  Merge branch 'thermal-core' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- s390-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o
`-- s390-allyesconfig
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
    `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o
clang_recent_errors
|-- x86_64-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o
`-- x86_64-allyesconfig
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
    `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o

elapsed time: 1445m

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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240104   gcc  
arc                   randconfig-002-20240104   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20240104   gcc  
arm                   randconfig-002-20240104   gcc  
arm                   randconfig-003-20240104   gcc  
arm                   randconfig-004-20240104   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240104   gcc  
arm64                 randconfig-002-20240104   gcc  
arm64                 randconfig-003-20240104   gcc  
arm64                 randconfig-004-20240104   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240104   gcc  
csky                  randconfig-002-20240104   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240104   clang
hexagon               randconfig-002-20240104   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240104   gcc  
i386         buildonly-randconfig-002-20240104   gcc  
i386         buildonly-randconfig-003-20240104   gcc  
i386         buildonly-randconfig-004-20240104   gcc  
i386         buildonly-randconfig-005-20240104   gcc  
i386         buildonly-randconfig-006-20240104   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240104   gcc  
i386                  randconfig-002-20240104   gcc  
i386                  randconfig-003-20240104   gcc  
i386                  randconfig-004-20240104   gcc  
i386                  randconfig-005-20240104   gcc  
i386                  randconfig-006-20240104   gcc  
i386                  randconfig-011-20240104   clang
i386                  randconfig-012-20240104   clang
i386                  randconfig-013-20240104   clang
i386                  randconfig-014-20240104   clang
i386                  randconfig-015-20240104   clang
i386                  randconfig-016-20240104   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240104   gcc  
loongarch             randconfig-002-20240104   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           mtx1_defconfig   clang
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240104   gcc  
nios2                 randconfig-002-20240104   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240104   gcc  
parisc                randconfig-002-20240104   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                   microwatt_defconfig   clang
powerpc                      ppc64e_defconfig   clang
powerpc               randconfig-001-20240104   gcc  
powerpc               randconfig-002-20240104   gcc  
powerpc               randconfig-003-20240104   gcc  
powerpc64             randconfig-001-20240104   gcc  
powerpc64             randconfig-002-20240104   gcc  
powerpc64             randconfig-003-20240104   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240104   gcc  
riscv                 randconfig-002-20240104   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240104   clang
s390                  randconfig-002-20240104   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240104   gcc  
sh                    randconfig-002-20240104   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240104   gcc  
sparc64               randconfig-002-20240104   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240104   gcc  
um                    randconfig-002-20240104   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240104   gcc  
x86_64       buildonly-randconfig-002-20240104   gcc  
x86_64       buildonly-randconfig-003-20240104   gcc  
x86_64       buildonly-randconfig-004-20240104   gcc  
x86_64       buildonly-randconfig-005-20240104   gcc  
x86_64       buildonly-randconfig-006-20240104   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240104   clang
x86_64                randconfig-002-20240104   clang
x86_64                randconfig-003-20240104   clang
x86_64                randconfig-004-20240104   clang
x86_64                randconfig-005-20240104   clang
x86_64                randconfig-006-20240104   clang
x86_64                randconfig-011-20240104   gcc  
x86_64                randconfig-012-20240104   gcc  
x86_64                randconfig-013-20240104   gcc  
x86_64                randconfig-014-20240104   gcc  
x86_64                randconfig-015-20240104   gcc  
x86_64                randconfig-016-20240104   gcc  
x86_64                randconfig-071-20240104   gcc  
x86_64                randconfig-072-20240104   gcc  
x86_64                randconfig-073-20240104   gcc  
x86_64                randconfig-074-20240104   gcc  
x86_64                randconfig-075-20240104   gcc  
x86_64                randconfig-076-20240104   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240104   gcc  
xtensa                randconfig-002-20240104   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

