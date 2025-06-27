Return-Path: <linux-acpi+bounces-14806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E41CAEC093
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 22:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A2816B1F3
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 20:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D9C2EAD00;
	Fri, 27 Jun 2025 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akivyhQa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F512E92DE;
	Fri, 27 Jun 2025 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054743; cv=none; b=ePCdzheOgfdonn9+1ufo0QroAZ2NoDbjsDsLoc3Db+Ok/20R243bgkjaiwJzE62lA0huzVCsN2koZ0OsgI7MtCoPUIE6aTGhz1HO/uUHbgk1Z6C13uPJdsf6ZfUBBhgdNoll4P/jb6Q9IhjsKqUWLdQD9cGFIOWI1LHc0LPQfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054743; c=relaxed/simple;
	bh=4wgiv6mGRS+ppSDkDeOUC1QFCDmnhELli5L+imAfmqE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Pm/O6Cbojv/RDRe9SuT2unV01l/Ccn90WyBikDWGRF04JOsXh7mUJKr6rNUpqW6BrJGL5UWLB/BpIuhuJbPdfsQCYRo5sllAl4xz4Zbr/Sq5CfJYV+P9YiGujW6pRqA8O6ilUHKYoatOKFHb/f525K4do9BgnVl1EP3Sj1pLRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akivyhQa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751054742; x=1782590742;
  h=date:from:to:cc:subject:message-id;
  bh=4wgiv6mGRS+ppSDkDeOUC1QFCDmnhELli5L+imAfmqE=;
  b=akivyhQaqI9Gk3jAEJW43fW5dnfhQOkjMCVZH3XsuML5fl3UHOH8Grdx
   ylCGYR/1imVXDpzDbvKqPFFhUVTAtDV3b4BMkDGdRP80pTRxqcG8X53cU
   mkoSPCz8XCyCSODcYOlP2UsquD1LhJt9U18hzwGTXBxIEv/ZAKKYecxGd
   rn/wXN7kF3d+U77P1UDJy4exLpnkFWCqAlBLj9iUDv6f5ngQ0HxKGeGKJ
   6pUiqTmzCS8umtp+yNb/aMMfBAF0IZYd5PWGwQ1+H5l5KgCsuuoMRTXla
   ABj4d7gZO79d682iy4sRsoJWTvfK6lFezaFFaq/WzUGwao0r88gRz/lZR
   g==;
X-CSE-ConnectionGUID: qYjGqVKiQKWmOieERX9XzA==
X-CSE-MsgGUID: UYMUaC2GSQaARP2dVnPM/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53342096"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="53342096"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 13:05:41 -0700
X-CSE-ConnectionGUID: hCeOB0f6TRmDytjjtOaVdQ==
X-CSE-MsgGUID: 4WIKNHi8SeySLm04cqLp5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="152626730"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Jun 2025 13:05:40 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVFKL-000WVQ-14;
	Fri, 27 Jun 2025 20:05:37 +0000
Date: Sat, 28 Jun 2025 04:05:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4b73ba494ac7bab450b34a521a50c07c8500eb0f
Message-ID: <202506280402.WVGpDpX3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4b73ba494ac7bab450b34a521a50c07c8500eb0f  Merge branch 'pm-powercap' into bleeding-edge

elapsed time: 1446m

configs tested: 233
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250627    gcc-10.5.0
arc                   randconfig-001-20250627    gcc-8.5.0
arc                   randconfig-002-20250627    gcc-10.5.0
arc                   randconfig-002-20250627    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20250627    gcc-10.5.0
arm                   randconfig-001-20250627    gcc-15.1.0
arm                   randconfig-002-20250627    gcc-10.5.0
arm                   randconfig-003-20250627    clang-21
arm                   randconfig-003-20250627    gcc-10.5.0
arm                   randconfig-004-20250627    gcc-10.5.0
arm                   randconfig-004-20250627    gcc-8.5.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250627    clang-17
arm64                 randconfig-001-20250627    gcc-10.5.0
arm64                 randconfig-002-20250627    gcc-10.5.0
arm64                 randconfig-003-20250627    gcc-10.5.0
arm64                 randconfig-003-20250627    gcc-12.3.0
arm64                 randconfig-004-20250627    clang-19
arm64                 randconfig-004-20250627    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250627    clang-21
csky                  randconfig-001-20250627    gcc-15.1.0
csky                  randconfig-002-20250627    clang-21
csky                  randconfig-002-20250627    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250627    clang-21
hexagon               randconfig-002-20250627    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250627    gcc-12
i386        buildonly-randconfig-002-20250627    gcc-12
i386        buildonly-randconfig-003-20250627    gcc-12
i386        buildonly-randconfig-004-20250627    gcc-12
i386        buildonly-randconfig-005-20250627    clang-20
i386        buildonly-randconfig-005-20250627    gcc-12
i386        buildonly-randconfig-006-20250627    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250628    clang-20
i386                  randconfig-002-20250628    clang-20
i386                  randconfig-003-20250628    clang-20
i386                  randconfig-004-20250628    clang-20
i386                  randconfig-005-20250628    clang-20
i386                  randconfig-006-20250628    clang-20
i386                  randconfig-007-20250628    clang-20
i386                  randconfig-011-20250627    gcc-12
i386                  randconfig-012-20250627    gcc-12
i386                  randconfig-013-20250627    gcc-12
i386                  randconfig-014-20250627    gcc-12
i386                  randconfig-015-20250627    gcc-12
i386                  randconfig-016-20250627    gcc-12
i386                  randconfig-017-20250627    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250627    clang-21
loongarch             randconfig-001-20250627    gcc-15.1.0
loongarch             randconfig-002-20250627    clang-21
loongarch             randconfig-002-20250627    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-21
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250627    clang-21
nios2                 randconfig-001-20250627    gcc-8.5.0
nios2                 randconfig-002-20250627    clang-21
nios2                 randconfig-002-20250627    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250627    clang-21
parisc                randconfig-001-20250627    gcc-9.3.0
parisc                randconfig-002-20250627    clang-21
parisc                randconfig-002-20250627    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    clang-21
powerpc                        fsp2_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc               randconfig-001-20250627    clang-21
powerpc               randconfig-001-20250627    gcc-15.1.0
powerpc               randconfig-002-20250627    clang-21
powerpc               randconfig-003-20250627    clang-21
powerpc               randconfig-003-20250627    gcc-15.1.0
powerpc                     sequoia_defconfig    gcc-15.1.0
powerpc                     taishan_defconfig    clang-21
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250627    clang-21
powerpc64             randconfig-001-20250627    gcc-12.4.0
powerpc64             randconfig-002-20250627    clang-21
powerpc64             randconfig-002-20250627    gcc-10.5.0
powerpc64             randconfig-003-20250627    clang-21
powerpc64             randconfig-003-20250627    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250627    gcc-11.5.0
riscv                 randconfig-001-20250627    gcc-8.5.0
riscv                 randconfig-002-20250627    gcc-11.5.0
riscv                 randconfig-002-20250627    gcc-13.3.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250627    clang-21
s390                  randconfig-001-20250627    gcc-11.5.0
s390                  randconfig-002-20250627    clang-21
s390                  randconfig-002-20250627    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250627    gcc-11.5.0
sh                    randconfig-001-20250627    gcc-9.3.0
sh                    randconfig-002-20250627    gcc-11.5.0
sh                    randconfig-002-20250627    gcc-15.1.0
sh                          sdk7786_defconfig    clang-21
sh                           se7343_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250627    gcc-11.5.0
sparc                 randconfig-002-20250627    gcc-11.5.0
sparc                 randconfig-002-20250627    gcc-8.5.0
sparc64                          alldefconfig    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250627    gcc-11.5.0
sparc64               randconfig-002-20250627    gcc-11.5.0
sparc64               randconfig-002-20250627    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250627    gcc-11.5.0
um                    randconfig-001-20250627    gcc-12
um                    randconfig-002-20250627    gcc-11.5.0
um                    randconfig-002-20250627    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250627    clang-20
x86_64      buildonly-randconfig-002-20250627    clang-20
x86_64      buildonly-randconfig-003-20250627    clang-20
x86_64      buildonly-randconfig-004-20250627    clang-20
x86_64      buildonly-randconfig-005-20250627    clang-20
x86_64      buildonly-randconfig-005-20250627    gcc-12
x86_64      buildonly-randconfig-006-20250627    clang-20
x86_64      buildonly-randconfig-006-20250627    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250627    clang-20
x86_64                randconfig-002-20250627    clang-20
x86_64                randconfig-003-20250627    clang-20
x86_64                randconfig-004-20250627    clang-20
x86_64                randconfig-005-20250627    clang-20
x86_64                randconfig-006-20250627    clang-20
x86_64                randconfig-007-20250627    clang-20
x86_64                randconfig-008-20250627    clang-20
x86_64                randconfig-071-20250627    gcc-12
x86_64                randconfig-072-20250627    gcc-12
x86_64                randconfig-073-20250627    gcc-12
x86_64                randconfig-074-20250627    gcc-12
x86_64                randconfig-075-20250627    gcc-12
x86_64                randconfig-076-20250627    gcc-12
x86_64                randconfig-077-20250627    gcc-12
x86_64                randconfig-078-20250627    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250627    gcc-11.5.0
xtensa                randconfig-001-20250627    gcc-13.3.0
xtensa                randconfig-002-20250627    gcc-10.5.0
xtensa                randconfig-002-20250627    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

