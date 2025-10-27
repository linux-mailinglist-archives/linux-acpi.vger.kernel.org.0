Return-Path: <linux-acpi+bounces-18240-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74008C0BD0B
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 06:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81E524E3689
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4229C321;
	Mon, 27 Oct 2025 05:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRog1G9O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F181E2614;
	Mon, 27 Oct 2025 05:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761542760; cv=none; b=HLTRjtMDb2EGLur2kf0lqbzKjVKC5GZxyA0+aFbZf4d+AJp85nHXX8vOKC86BqqLG45gOKiAj5h4UXBfBT6rqlm5f8Tqa4d/0wsNqjczPokirrgsQ261o3MWmI8z+OcHc6xGhdc56OzXC0kl7S0FXZpGszTgJXKBYLKhZB3WzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761542760; c=relaxed/simple;
	bh=UyO3NI3Zsc1AFM1Kky+wHxtIQt2JRFZ7nk6F6M+aGYs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a48RgOv4L3SM1cGCNu+uF4Apud1BCeA+LNUcGAPz5DMsVceiDgT9mmn+Swbdp0YPZvTHuxlm1kNWAp3Hdq+Ctm9Hpf7EPj/a3Y9upCEL4udaatQwFFNW6qKtoWU+UrolTHjnWHczziT2w+Zd8HZnkakkIr4mgnPlxqcXkbf7x3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRog1G9O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761542758; x=1793078758;
  h=date:from:to:cc:subject:message-id;
  bh=UyO3NI3Zsc1AFM1Kky+wHxtIQt2JRFZ7nk6F6M+aGYs=;
  b=DRog1G9O804qsmtWDwAbBtewm2R9r555sOHd5ycGzphHEjdABM1Wa04Y
   6wGdBYf6rzSj9JZyu+OpjD17gzRzqhWOqH82TZ5NAlZXsnxNHjifiKFoj
   l3uRpifgiMqboTpPUe6hxq3rC7UOs3Uy8G5xiMslRgzYzCv+QUzo4yLHK
   IeYwQENn9e5LIvrU8Sux7zC4zXHxsE2lWjGeYmTJdOE4ut/p+69SWuxqw
   QVm2dynrQhNqyJ37L+BhFNeVucJLKmC+fP61oeMrJGBZiX78NyNG98Gtu
   Y7uheQtZBd0dLkDA6kk/sIU49kwf1GpvbTZxoJ28QU+3dDT+qFcFTijRi
   A==;
X-CSE-ConnectionGUID: o182DxViTTqAFrxu0tMhFw==
X-CSE-MsgGUID: g+oucZF1R9W5EHM6VNPBKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63652014"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63652014"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 22:25:57 -0700
X-CSE-ConnectionGUID: jL9C1bKjTk+TjUES2+2RJw==
X-CSE-MsgGUID: KlrSb4lLRTSx4/XcJIUQtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184174710"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 26 Oct 2025 22:25:56 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDFjn-000GXB-35;
	Mon, 27 Oct 2025 05:25:49 +0000
Date: Mon, 27 Oct 2025 13:24:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH UNVERIFIED
 WARNING 0ed8ae1ead0222b851b290a8c8060541926fba00
Message-ID: <202510271343.29gnzLNI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 0ed8ae1ead0222b851b290a8c8060541926fba00  Merge branch 'fixes-next' into linux-next

Unverified Warning (likely false positive, kindly check if interested):

    drivers/base/power/runtime-test.c:182 pm_runtime_error_test() warn: pm_runtime_get_sync() also returns 1 on success
    drivers/base/power/runtime-test.c:22 pm_runtime_depth_test() warn: pm_runtime_get_sync() also returns 1 on success
    drivers/base/power/runtime-test.c:78 pm_runtime_idle_test() warn: pm_runtime_get_sync() also returns 1 on success

Warning ids grouped by kconfigs:

recent_errors
`-- i386-randconfig-141-20251027
    |-- drivers-base-power-runtime-test.c-pm_runtime_depth_test()-warn:pm_runtime_get_sync()-also-returns-on-success
    |-- drivers-base-power-runtime-test.c-pm_runtime_error_test()-warn:pm_runtime_get_sync()-also-returns-on-success
    `-- drivers-base-power-runtime-test.c-pm_runtime_idle_test()-warn:pm_runtime_get_sync()-also-returns-on-success

elapsed time: 963m

configs tested: 165
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251026    gcc-13.4.0
arc                   randconfig-002-20251026    gcc-9.5.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                        multi_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20251026    clang-22
arm                   randconfig-002-20251026    clang-20
arm                   randconfig-003-20251026    clang-17
arm                   randconfig-004-20251026    clang-20
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251026    gcc-15.1.0
arm64                 randconfig-002-20251026    clang-22
arm64                 randconfig-003-20251026    gcc-8.5.0
arm64                 randconfig-004-20251026    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251026    gcc-15.1.0
csky                  randconfig-002-20251026    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251026    clang-18
hexagon               randconfig-002-20251026    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251026    gcc-14
i386        buildonly-randconfig-002-20251026    clang-20
i386        buildonly-randconfig-003-20251026    gcc-14
i386        buildonly-randconfig-004-20251026    clang-20
i386        buildonly-randconfig-005-20251026    clang-20
i386        buildonly-randconfig-006-20251026    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251027    gcc-14
i386                  randconfig-002-20251027    gcc-14
i386                  randconfig-003-20251027    gcc-14
i386                  randconfig-004-20251027    gcc-14
i386                  randconfig-005-20251027    gcc-14
i386                  randconfig-006-20251027    gcc-14
i386                  randconfig-007-20251027    gcc-14
i386                  randconfig-011-20251027    clang-20
i386                  randconfig-012-20251027    clang-20
i386                  randconfig-013-20251027    clang-20
i386                  randconfig-014-20251027    clang-20
i386                  randconfig-015-20251027    clang-20
i386                  randconfig-016-20251027    clang-20
i386                  randconfig-017-20251027    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251026    clang-22
loongarch             randconfig-002-20251026    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251026    gcc-8.5.0
nios2                 randconfig-002-20251026    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251026    gcc-12.5.0
parisc                randconfig-002-20251026    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251026    gcc-13.4.0
powerpc               randconfig-002-20251026    gcc-8.5.0
powerpc               randconfig-003-20251026    gcc-10.5.0
powerpc64             randconfig-001-20251026    gcc-10.5.0
powerpc64             randconfig-002-20251026    gcc-12.5.0
powerpc64             randconfig-003-20251026    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251027    gcc-13.4.0
riscv                 randconfig-002-20251027    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251027    clang-22
s390                  randconfig-002-20251027    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251027    gcc-12.5.0
sh                    randconfig-002-20251027    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251027    gcc-12.5.0
sparc                 randconfig-002-20251027    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251027    gcc-14.3.0
sparc64               randconfig-002-20251027    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251027    clang-22
um                    randconfig-002-20251027    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251026    clang-20
x86_64      buildonly-randconfig-002-20251026    gcc-12
x86_64      buildonly-randconfig-003-20251026    gcc-14
x86_64      buildonly-randconfig-004-20251026    gcc-14
x86_64      buildonly-randconfig-005-20251026    clang-20
x86_64      buildonly-randconfig-006-20251026    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20251027    clang-20
x86_64                randconfig-072-20251027    clang-20
x86_64                randconfig-073-20251027    clang-20
x86_64                randconfig-074-20251027    clang-20
x86_64                randconfig-075-20251027    clang-20
x86_64                randconfig-076-20251027    clang-20
x86_64                randconfig-077-20251027    clang-20
x86_64                randconfig-078-20251027    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251027    gcc-12.5.0
xtensa                randconfig-002-20251027    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

