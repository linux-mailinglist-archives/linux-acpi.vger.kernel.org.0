Return-Path: <linux-acpi+bounces-17954-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CAFBEDF97
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Oct 2025 09:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911B0189FFE5
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Oct 2025 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11C221B9F1;
	Sun, 19 Oct 2025 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0JXLrl2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB3625;
	Sun, 19 Oct 2025 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760858066; cv=none; b=kEansL5cQ6AQAOL5CvFdtnBvSq7lTNMceDbs9InM8g2fqk31MMMBdF8Pbat9MqG/J7Oxn1/0rmxoUe0YQ6LpNUged9ILD4V3HXN3RkOj+dxFQBDu/a5+1WhnLsTTW9BQ8GjP3KgjRfXWKZVzDe78u/XHy1Ewwk+SaxSjSKH48Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760858066; c=relaxed/simple;
	bh=Xvjfqx5YqMp7jcrJTzmttFUId/wHX+wDw7Cu8JoOGBA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qaVnc4r63uLYlvtra923DgVB1pZ/pJW5o8YdAMS/3d8Eqzce4M7jC83OwcV3OSFxik0C+UXnz+U5utRPlc/nC74YimMeCJAZlw7aiylGqcNIeFlpDVDNj+HuPwy6XbsfOn6GpxB8FFocNhixTnMlejRFnyCsUd0KTKrydGFFjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0JXLrl2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760858064; x=1792394064;
  h=date:from:to:cc:subject:message-id;
  bh=Xvjfqx5YqMp7jcrJTzmttFUId/wHX+wDw7Cu8JoOGBA=;
  b=X0JXLrl25Y6MP+MoUAFLyHrGmoD/EgKSj4foPb39tLanSrMPcsDTUJeo
   0rj4bMv0y/W7l1rrygGYLbMWYdo/AZY/KNp0bRQF9Fy3lUncFl0vaxKaW
   YSbN4rnB439i0DAAWfxsfWlUV3i3bYF4NEru9QDFu/bE3vUJB59AhKkEI
   dS91btKV/l1SpevdrzjrWcOBYutiOFsj6ZdJVMHyzd8scpaXk++/2SpZI
   L7IWSiTT1EF1o6+UF8UyoyDXD5b5YovDUjgGUXvI/jHqDkhtJEjzhJJvm
   EhwuwxWWs0OIUIsbauwOLHGAdD048htKGxaCFmRy35HUPz0Sxu6AqLrDT
   Q==;
X-CSE-ConnectionGUID: 5Wgn9V+pRAmrVDl9p2qcQw==
X-CSE-MsgGUID: TjbIqGGUTwGJ2LqeURnK4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66655454"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="66655454"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 00:14:23 -0700
X-CSE-ConnectionGUID: J9fl6BXbQumpla0cckQ3SA==
X-CSE-MsgGUID: 7wfjZtI0RrqgjANfKcKJDg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 19 Oct 2025 00:14:22 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vANcS-0008uh-1H;
	Sun, 19 Oct 2025 07:14:20 +0000
Date: Sun, 19 Oct 2025 15:13:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH UNVERIFIED
 WARNING 277a48fa37d71bfaf0ce4781da3794782f5c1d93
Message-ID: <202510191529.BCyjKlLQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 277a48fa37d71bfaf0ce4781da3794782f5c1d93  Merge branch 'pm-core' into linux-next

Unverified Warning (likely false positive, kindly check if interested):

    drivers/base/power/runtime-test.c:182 pm_runtime_error_test() warn: pm_runtime_get_sync() also returns 1 on success
    drivers/base/power/runtime-test.c:22 pm_runtime_depth_test() warn: pm_runtime_get_sync() also returns 1 on success
    drivers/base/power/runtime-test.c:78 pm_runtime_idle_test() warn: pm_runtime_get_sync() also returns 1 on success
    include/linux/pm_runtime.h:631 class_pm_runtime_active_try_constructor() warn: passing zero to 'ERR_PTR'

Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-141-20251019
|   `-- include-linux-pm_runtime.h-class_pm_runtime_active_try_constructor()-warn:passing-zero-to-ERR_PTR
`-- x86_64-randconfig-161-20251019
    |-- drivers-base-power-runtime-test.c-pm_runtime_depth_test()-warn:pm_runtime_get_sync()-also-returns-on-success
    |-- drivers-base-power-runtime-test.c-pm_runtime_error_test()-warn:pm_runtime_get_sync()-also-returns-on-success
    |-- drivers-base-power-runtime-test.c-pm_runtime_idle_test()-warn:pm_runtime_get_sync()-also-returns-on-success
    `-- include-linux-pm_runtime.h-class_pm_runtime_active_try_constructor()-warn:passing-zero-to-ERR_PTR

elapsed time: 1068m

configs tested: 275
configs skipped: 8

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20251018    gcc-12.5.0
arc                   randconfig-001-20251019    clang-22
arc                   randconfig-002-20251018    gcc-8.5.0
arc                   randconfig-002-20251019    clang-22
arc                           tb10x_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                         axm55xx_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          exynos_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20251018    clang-19
arm                   randconfig-001-20251019    clang-22
arm                   randconfig-002-20251018    clang-20
arm                   randconfig-002-20251019    clang-22
arm                   randconfig-003-20251018    clang-22
arm                   randconfig-003-20251019    clang-22
arm                   randconfig-004-20251018    gcc-15.1.0
arm                   randconfig-004-20251019    clang-22
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251018    gcc-8.5.0
arm64                 randconfig-001-20251019    clang-22
arm64                 randconfig-002-20251018    clang-22
arm64                 randconfig-002-20251019    clang-22
arm64                 randconfig-003-20251018    gcc-13.4.0
arm64                 randconfig-003-20251019    clang-22
arm64                 randconfig-004-20251018    gcc-11.5.0
arm64                 randconfig-004-20251019    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251018    gcc-9.5.0
csky                  randconfig-001-20251019    clang-16
csky                  randconfig-001-20251019    gcc-13.4.0
csky                  randconfig-002-20251018    gcc-9.5.0
csky                  randconfig-002-20251019    clang-16
csky                  randconfig-002-20251019    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251018    clang-22
hexagon               randconfig-001-20251019    clang-16
hexagon               randconfig-001-20251019    clang-20
hexagon               randconfig-002-20251018    clang-22
hexagon               randconfig-002-20251019    clang-16
hexagon               randconfig-002-20251019    clang-17
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251018    gcc-14
i386        buildonly-randconfig-001-20251019    gcc-13
i386        buildonly-randconfig-002-20251018    gcc-14
i386        buildonly-randconfig-002-20251019    gcc-13
i386        buildonly-randconfig-003-20251018    clang-20
i386        buildonly-randconfig-003-20251019    gcc-13
i386        buildonly-randconfig-004-20251018    gcc-14
i386        buildonly-randconfig-004-20251019    gcc-13
i386        buildonly-randconfig-005-20251018    clang-20
i386        buildonly-randconfig-005-20251019    gcc-13
i386        buildonly-randconfig-006-20251018    clang-20
i386        buildonly-randconfig-006-20251019    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20251019    clang-20
i386                  randconfig-002-20251019    clang-20
i386                  randconfig-003-20251019    clang-20
i386                  randconfig-004-20251019    clang-20
i386                  randconfig-005-20251019    clang-20
i386                  randconfig-006-20251019    clang-20
i386                  randconfig-007-20251019    clang-20
i386                  randconfig-011-20251019    gcc-14
i386                  randconfig-012-20251019    gcc-14
i386                  randconfig-013-20251019    gcc-14
i386                  randconfig-014-20251019    gcc-14
i386                  randconfig-015-20251019    gcc-14
i386                  randconfig-016-20251019    gcc-14
i386                  randconfig-017-20251019    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251018    clang-22
loongarch             randconfig-001-20251019    clang-16
loongarch             randconfig-001-20251019    clang-18
loongarch             randconfig-002-20251018    gcc-13.4.0
loongarch             randconfig-002-20251019    clang-16
loongarch             randconfig-002-20251019    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251018    gcc-11.5.0
nios2                 randconfig-001-20251019    clang-16
nios2                 randconfig-001-20251019    gcc-8.5.0
nios2                 randconfig-002-20251018    gcc-8.5.0
nios2                 randconfig-002-20251019    clang-16
nios2                 randconfig-002-20251019    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251018    gcc-10.5.0
parisc                randconfig-001-20251019    clang-16
parisc                randconfig-001-20251019    gcc-15.1.0
parisc                randconfig-002-20251018    gcc-14.3.0
parisc                randconfig-002-20251019    clang-16
parisc                randconfig-002-20251019    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251018    clang-22
powerpc               randconfig-001-20251019    clang-16
powerpc               randconfig-001-20251019    clang-17
powerpc               randconfig-002-20251018    clang-22
powerpc               randconfig-002-20251019    clang-16
powerpc               randconfig-002-20251019    gcc-10.5.0
powerpc               randconfig-003-20251018    gcc-14.3.0
powerpc               randconfig-003-20251019    clang-16
powerpc               randconfig-003-20251019    gcc-11.5.0
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251018    gcc-10.5.0
powerpc64             randconfig-002-20251018    gcc-12.5.0
powerpc64             randconfig-002-20251019    clang-16
powerpc64             randconfig-003-20251018    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251019    clang-19
riscv                 randconfig-001-20251019    gcc-11.5.0
riscv                 randconfig-002-20251019    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-14
s390                  randconfig-001-20251019    gcc-11.5.0
s390                  randconfig-001-20251019    gcc-8.5.0
s390                  randconfig-002-20251019    clang-22
s390                  randconfig-002-20251019    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20251019    gcc-11.5.0
sh                    randconfig-001-20251019    gcc-15.1.0
sh                    randconfig-002-20251019    gcc-11.5.0
sh                    randconfig-002-20251019    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251019    gcc-11.5.0
sparc                 randconfig-002-20251019    gcc-11.5.0
sparc                 randconfig-002-20251019    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251019    gcc-11.5.0
sparc64               randconfig-001-20251019    gcc-8.5.0
sparc64               randconfig-002-20251019    gcc-11.5.0
sparc64               randconfig-002-20251019    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251019    gcc-11.5.0
um                    randconfig-001-20251019    gcc-13
um                    randconfig-002-20251019    clang-22
um                    randconfig-002-20251019    gcc-11.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251018    gcc-14
x86_64      buildonly-randconfig-001-20251019    clang-20
x86_64      buildonly-randconfig-002-20251018    gcc-14
x86_64      buildonly-randconfig-002-20251019    clang-20
x86_64      buildonly-randconfig-002-20251019    gcc-13
x86_64      buildonly-randconfig-003-20251018    gcc-14
x86_64      buildonly-randconfig-003-20251019    clang-20
x86_64      buildonly-randconfig-004-20251018    gcc-14
x86_64      buildonly-randconfig-004-20251019    clang-20
x86_64      buildonly-randconfig-004-20251019    gcc-14
x86_64      buildonly-randconfig-005-20251018    gcc-14
x86_64      buildonly-randconfig-005-20251019    clang-20
x86_64      buildonly-randconfig-006-20251018    clang-20
x86_64      buildonly-randconfig-006-20251019    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251019    clang-20
x86_64                randconfig-002-20251019    clang-20
x86_64                randconfig-003-20251019    clang-20
x86_64                randconfig-004-20251019    clang-20
x86_64                randconfig-005-20251019    clang-20
x86_64                randconfig-006-20251019    clang-20
x86_64                randconfig-007-20251019    clang-20
x86_64                randconfig-008-20251019    clang-20
x86_64                randconfig-071-20251019    clang-20
x86_64                randconfig-072-20251019    clang-20
x86_64                randconfig-073-20251019    clang-20
x86_64                randconfig-074-20251019    clang-20
x86_64                randconfig-075-20251019    clang-20
x86_64                randconfig-076-20251019    clang-20
x86_64                randconfig-077-20251019    clang-20
x86_64                randconfig-078-20251019    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251019    gcc-11.5.0
xtensa                randconfig-001-20251019    gcc-14.3.0
xtensa                randconfig-002-20251019    gcc-11.5.0
xtensa                randconfig-002-20251019    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

