Return-Path: <linux-acpi+bounces-12538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA8A75802
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Mar 2025 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76DB3ABD00
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Mar 2025 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392438F9C;
	Sat, 29 Mar 2025 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSFdhOKt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4F4A05;
	Sat, 29 Mar 2025 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743288464; cv=none; b=ipMRdc04GppXqzNQONjX0Q5A8ELRqX67mO+ju79T/iVK0LD6Hz0fki6i8VF5Cw6rGsNh8NMiZWTU1b6tTX3AqHRCPiI7n6MF4LEgzzF0H34RWw1FpZpsv4pRFs7HyQrgCMeF7DraAM9vDu19hMF/if+Jo9Z+FD1PE2o86A28YsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743288464; c=relaxed/simple;
	bh=Pdw747ooCzMPUDWOEjOb4pzhnS3wEQWbz2JIk9hIae4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rXwjz7HuejPL03h+Lh06aIiA2OKCf9ZoT3TUzSE8bNphffXbJ3VX5N3N17sVXaoqt+ejnzoqq+ogygYqc/st9Mp7VYqNa2d/4xhkZaiBNxhIpBfLo0ijyxmDDt5uCgEDC3CQYPNY3VI10GNz29j0OcBWoLUErgD/Hi2Zj1NE12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSFdhOKt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743288462; x=1774824462;
  h=date:from:to:cc:subject:message-id;
  bh=Pdw747ooCzMPUDWOEjOb4pzhnS3wEQWbz2JIk9hIae4=;
  b=XSFdhOKtrpnp9YQIsYK7qzCLAInyw2w5sNYveRJollHjuUdCtIhBwk+e
   AaxYQDOxJ2l2CUqWH2VAtQAmc1YfW8UtJkR1ZFq/zfDwViuKCoElaam6b
   K7/RARZh0Hwc1/9gE3wTVHaC3oAcVymEFtdgK3SQtv8zOw8mWaeMxB91z
   LeGwmA0PGwmvh0zAkjh+fg9Sk2mAHMNh1X5UooLYmL/MaQL/kDWQEZd5O
   eifFn/d3whK2qgzg5hefokAQsUquvRLl+B3vH4pn9n7skeJUniViYgHkV
   BDgtYc94zKvIgk7TiUgGT6oO9W03rYq4ck7q0bu8GnFLCSvkpbGZ1OWiD
   w==;
X-CSE-ConnectionGUID: ffpFDTuyT8G5f58OT5pDBw==
X-CSE-MsgGUID: YU/H4ganSGyOj8mVSu42zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11388"; a="43775880"
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="43775880"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 15:47:41 -0700
X-CSE-ConnectionGUID: K6Vofa9JSGqpwKMBYvg6Og==
X-CSE-MsgGUID: CAm2KX9cRBKJQy9I4AUtzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="130456954"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2025 15:47:39 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tyexh-0008PI-09;
	Sat, 29 Mar 2025 22:47:34 +0000
Date: Sun, 30 Mar 2025 06:47:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 0652b490b875ede4ae9ae857ffb06f813adbb395
Message-ID: <202503300604.bxFBlFVb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 0652b490b875ede4ae9ae857ffb06f813adbb395  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 1441m

configs tested: 206
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250329    gcc-14.2.0
arc                   randconfig-002-20250329    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                         axm55xx_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250329    gcc-9.3.0
arm                   randconfig-002-20250329    clang-17
arm                   randconfig-003-20250329    clang-21
arm                   randconfig-004-20250329    clang-21
arm                             rpc_defconfig    clang-18
arm                         socfpga_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    clang-21
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250329    gcc-7.5.0
arm64                 randconfig-002-20250329    gcc-9.5.0
arm64                 randconfig-003-20250329    gcc-5.5.0
arm64                 randconfig-004-20250329    gcc-5.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250329    gcc-11.5.0
csky                  randconfig-002-20250329    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250329    clang-21
hexagon               randconfig-002-20250329    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250329    gcc-12
i386        buildonly-randconfig-002-20250329    gcc-12
i386        buildonly-randconfig-003-20250329    clang-20
i386        buildonly-randconfig-004-20250329    gcc-11
i386        buildonly-randconfig-005-20250329    gcc-12
i386        buildonly-randconfig-006-20250329    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250330    clang-20
i386                  randconfig-002-20250330    clang-20
i386                  randconfig-003-20250330    clang-20
i386                  randconfig-004-20250330    clang-20
i386                  randconfig-005-20250330    clang-20
i386                  randconfig-006-20250330    clang-20
i386                  randconfig-007-20250330    clang-20
i386                  randconfig-011-20250330    clang-20
i386                  randconfig-012-20250330    clang-20
i386                  randconfig-013-20250330    clang-20
i386                  randconfig-014-20250330    clang-20
i386                  randconfig-015-20250330    clang-20
i386                  randconfig-016-20250330    clang-20
i386                  randconfig-017-20250330    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250329    gcc-14.2.0
loongarch             randconfig-002-20250329    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    clang-21
m68k                          multi_defconfig    gcc-14.2.0
m68k                            q40_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250329    gcc-7.5.0
nios2                 randconfig-002-20250329    gcc-7.5.0
openrisc                         alldefconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250329    gcc-6.5.0
parisc                randconfig-002-20250329    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    clang-21
powerpc                        fsp2_defconfig    clang-21
powerpc                      katmai_defconfig    clang-21
powerpc                      pmac32_defconfig    clang-21
powerpc               randconfig-001-20250329    gcc-5.5.0
powerpc               randconfig-002-20250329    gcc-5.5.0
powerpc               randconfig-003-20250329    gcc-9.3.0
powerpc64             randconfig-001-20250329    gcc-9.3.0
powerpc64             randconfig-002-20250329    gcc-9.3.0
powerpc64             randconfig-003-20250329    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250329    gcc-14.2.0
riscv                 randconfig-002-20250329    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250329    gcc-8.5.0
s390                  randconfig-002-20250329    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250329    gcc-5.5.0
sh                    randconfig-002-20250329    gcc-11.5.0
sh                   sh7770_generic_defconfig    clang-21
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250329    gcc-8.5.0
sparc                 randconfig-002-20250329    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250329    gcc-6.5.0
sparc64               randconfig-002-20250329    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250329    gcc-12
um                    randconfig-002-20250329    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250329    clang-20
x86_64      buildonly-randconfig-002-20250329    gcc-12
x86_64      buildonly-randconfig-003-20250329    gcc-12
x86_64      buildonly-randconfig-004-20250329    clang-20
x86_64      buildonly-randconfig-005-20250329    clang-20
x86_64      buildonly-randconfig-006-20250329    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250330    clang-20
x86_64                randconfig-002-20250330    clang-20
x86_64                randconfig-003-20250330    clang-20
x86_64                randconfig-004-20250330    clang-20
x86_64                randconfig-005-20250330    clang-20
x86_64                randconfig-006-20250330    clang-20
x86_64                randconfig-007-20250330    clang-20
x86_64                randconfig-008-20250330    clang-20
x86_64                randconfig-071-20250330    clang-20
x86_64                randconfig-072-20250330    clang-20
x86_64                randconfig-073-20250330    clang-20
x86_64                randconfig-074-20250330    clang-20
x86_64                randconfig-075-20250330    clang-20
x86_64                randconfig-076-20250330    clang-20
x86_64                randconfig-077-20250330    clang-20
x86_64                randconfig-078-20250330    clang-20
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250329    gcc-10.5.0
xtensa                randconfig-002-20250329    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

