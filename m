Return-Path: <linux-acpi+bounces-15115-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECBDB02E97
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Jul 2025 06:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A4717F4AE
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Jul 2025 04:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132C213632B;
	Sun, 13 Jul 2025 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpUpNi93"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE94A24;
	Sun, 13 Jul 2025 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752381665; cv=none; b=O2T50HqdVMx1kWPvRSWm7REhGRg+SKIA005/8+5Z5sdTW/Iul5+WT59RC822Qp6aeKKqdexqKB+qYBNTPNrz9ycQ7f7RDXVv3Jrc8f1T+C7px8iSgpPLLWiIB4m4WmBHsLRs5g72yQpw6wfWLkmYU1uqZSsvPXDTygt5AHh7gfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752381665; c=relaxed/simple;
	bh=YjRRKL9PU/3Xn6uDFQdkDu1HQJ3WLHhvW5B6pzsO/X8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gaHTKvu+yrFWsGytd7rTuk3aiTVsTxIA51Obud3yqNlh9AioK0MHvLY415q72pSDt1EuVob4A9CVgwvLcCfQSys+h8kAcPGlF0Mu1+x2bCbKonlynSEEY1cunuWGHXpBWgmw7+Ck6yv4kK0H88cB4Ui1YDs1zVgKT01rF0+5rxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpUpNi93; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752381661; x=1783917661;
  h=date:from:to:cc:subject:message-id;
  bh=YjRRKL9PU/3Xn6uDFQdkDu1HQJ3WLHhvW5B6pzsO/X8=;
  b=IpUpNi93/NNXz3ELyuunyjB+QiIbj2V3QXfOX+LzEmRzFerA3HNmgSMi
   dP2QPlmdhFzyIPrsi7II/rrTsTXyPQGhnvC9lxILnpxwir/UiATQriDG/
   37B+qu1fMteHGZe/laTQY7NhuUYxmwJh1TY5dmUPVUwIFI26YAquXyMro
   tLqgbqfCKgK2pTCss0X8kGNhCzcTfYXW5V9HMhLwabS6+d2QGP6K/yTP4
   teomgwVEFsU7YclGII7V0MNo3uIzwaUHLkdnSUx4r+FzmoftBRD1SgFw1
   I4IaSRL/0RooPXAlng01sEMDzmXQFgUlIGhTgoN063BngoJOuy30DnTYd
   w==;
X-CSE-ConnectionGUID: rhzpG4NPQgKRqwdMzm2lWw==
X-CSE-MsgGUID: GYN6ZveOS0ms2mjZCg4Gaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65970950"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="65970950"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 21:41:00 -0700
X-CSE-ConnectionGUID: iprAVTdzQsat+VfNzCfRJA==
X-CSE-MsgGUID: D6lkTso1TDGQHHjhMU/YOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="157218117"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Jul 2025 21:40:58 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaoWG-0007sp-1Q;
	Sun, 13 Jul 2025 04:40:56 +0000
Date: Sun, 13 Jul 2025 12:40:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d47c63d531e87f8120199edcf8f2adce10d8c2d1
Message-ID: <202507131257.AZK599I5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d47c63d531e87f8120199edcf8f2adce10d8c2d1  Merge branch 'pm-kexec' into bleeding-edge

elapsed time: 1178m

configs tested: 198
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250712    gcc-10.5.0
arc                   randconfig-002-20250712    gcc-13.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                       imx_v6_v7_defconfig    clang-16
arm                        mvebu_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250712    gcc-8.5.0
arm                   randconfig-002-20250712    gcc-10.5.0
arm                   randconfig-003-20250712    clang-21
arm                   randconfig-004-20250712    clang-21
arm                         s5pv210_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250712    gcc-12.3.0
arm64                 randconfig-002-20250712    gcc-12.3.0
arm64                 randconfig-003-20250712    gcc-8.5.0
arm64                 randconfig-004-20250712    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250712    gcc-14.3.0
csky                  randconfig-002-20250712    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250712    clang-21
hexagon               randconfig-002-20250712    clang-18
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250712    clang-20
i386        buildonly-randconfig-002-20250712    gcc-11
i386        buildonly-randconfig-003-20250712    gcc-12
i386        buildonly-randconfig-004-20250712    gcc-12
i386        buildonly-randconfig-005-20250712    gcc-12
i386        buildonly-randconfig-006-20250712    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250713    clang-20
i386                  randconfig-002-20250713    clang-20
i386                  randconfig-003-20250713    clang-20
i386                  randconfig-004-20250713    clang-20
i386                  randconfig-005-20250713    clang-20
i386                  randconfig-006-20250713    clang-20
i386                  randconfig-007-20250713    clang-20
i386                  randconfig-011-20250713    gcc-12
i386                  randconfig-012-20250713    gcc-12
i386                  randconfig-013-20250713    gcc-12
i386                  randconfig-014-20250713    gcc-12
i386                  randconfig-015-20250713    gcc-12
i386                  randconfig-016-20250713    gcc-12
i386                  randconfig-017-20250713    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250712    gcc-15.1.0
loongarch             randconfig-002-20250712    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    gcc-15.1.0
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250712    gcc-11.5.0
nios2                 randconfig-002-20250712    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250712    gcc-8.5.0
parisc                randconfig-002-20250712    gcc-12.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-21
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc               randconfig-001-20250712    gcc-15.1.0
powerpc               randconfig-002-20250712    gcc-8.5.0
powerpc               randconfig-003-20250712    clang-21
powerpc64             randconfig-002-20250712    clang-21
powerpc64             randconfig-003-20250712    clang-19
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250712    gcc-8.5.0
riscv                 randconfig-002-20250712    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250712    clang-21
s390                  randconfig-002-20250712    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250712    gcc-15.1.0
sh                    randconfig-002-20250712    gcc-14.3.0
sh                           se7721_defconfig    gcc-15.1.0
sh                             sh03_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250712    gcc-13.4.0
sparc                 randconfig-002-20250712    gcc-15.1.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250712    clang-20
sparc64               randconfig-002-20250712    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250712    gcc-12
um                    randconfig-002-20250712    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250712    gcc-12
x86_64      buildonly-randconfig-002-20250712    gcc-12
x86_64      buildonly-randconfig-003-20250712    clang-20
x86_64      buildonly-randconfig-004-20250712    clang-20
x86_64      buildonly-randconfig-005-20250712    gcc-12
x86_64      buildonly-randconfig-006-20250712    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250713    gcc-12
x86_64                randconfig-002-20250713    gcc-12
x86_64                randconfig-003-20250713    gcc-12
x86_64                randconfig-004-20250713    gcc-12
x86_64                randconfig-005-20250713    gcc-12
x86_64                randconfig-006-20250713    gcc-12
x86_64                randconfig-007-20250713    gcc-12
x86_64                randconfig-008-20250713    gcc-12
x86_64                randconfig-071-20250713    clang-20
x86_64                randconfig-072-20250713    clang-20
x86_64                randconfig-073-20250713    clang-20
x86_64                randconfig-074-20250713    clang-20
x86_64                randconfig-075-20250713    clang-20
x86_64                randconfig-076-20250713    clang-20
x86_64                randconfig-077-20250713    clang-20
x86_64                randconfig-078-20250713    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250712    gcc-8.5.0
xtensa                randconfig-002-20250712    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

