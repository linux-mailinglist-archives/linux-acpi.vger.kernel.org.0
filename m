Return-Path: <linux-acpi+bounces-13890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06152AC3076
	for <lists+linux-acpi@lfdr.de>; Sat, 24 May 2025 18:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD309E395D
	for <lists+linux-acpi@lfdr.de>; Sat, 24 May 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D1E1A315D;
	Sat, 24 May 2025 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnEk0+03"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9549170A37;
	Sat, 24 May 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748104281; cv=none; b=ZhIeoAXlPJCN7BD9osG3U7/Sb2wNxrje22eUwQDWXOVhagE7omiY4Em7YzEfP9/eik9B3zt3gLkj8HRoqoRWZbvZvlYdtr2fVsGYq0jraTGuZgJ75rmgckscpMoGT7HQXcJnAEW/Khudm/iKF0ad9u9FTvW3UZwBMxzH8vXM0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748104281; c=relaxed/simple;
	bh=DtbYzhOb1aRL6VKbgkaJm06Ktt+aDXv/KRuqW4JV+Gw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DS7C37wW7HstRsA0JzcY+u2+tphWfJtpC1vqnUWGqYZrUMiFxBEs11qs6FOCOSNTo+l67mYTagZBZujxwG/FsDk96A6Yrz4wvsK4nMhH2aJmaT05Ny+S1hB88n5LPuyl0kZvLsMCy5HM2r62gd9iVH2fJEv3M05DVQjwGKM6ub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnEk0+03; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748104279; x=1779640279;
  h=date:from:to:cc:subject:message-id;
  bh=DtbYzhOb1aRL6VKbgkaJm06Ktt+aDXv/KRuqW4JV+Gw=;
  b=GnEk0+03OqXM/UCRV01z9W2wvDxSX8mHnXDTB9zmaBQZbf4KgmF4OtPX
   UMKV8I2lJHnyJR6EzIDoghBlLeXDxn0Lsx0RBwn9BLaLxktT/FEvhGaXk
   jlFRMNsZ+t/EOVZzv/z/WqF0J9GzM8ivqUC7UJG9wHc8e2li1npUdILQR
   dH5CyAfeEUXWwdJjhUes75uLB2mLoP+fQBSB1lh6epneGB3pqLPwIubzr
   nd/u8Ox0l0FL8rIxJminzW9WieIxtu0yFSflqZQ0dn8MVF00c973YfeEH
   OVePJQWrdw2MKipaqFUs/MamtiQrB8sdpVOqnyDYnFa6k7KUviMV1Xu7J
   g==;
X-CSE-ConnectionGUID: OkFjTIAtRpe/ul7ESe9o3g==
X-CSE-MsgGUID: 9Ck5V7iOQIGrbGD00p9kAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="49250503"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="49250503"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 09:31:15 -0700
X-CSE-ConnectionGUID: 0yaHHazWQeat9Q63M9fKxQ==
X-CSE-MsgGUID: 3BA46RuLRzC51KIyI8H2zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="142563017"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 24 May 2025 09:31:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIrmA-000RJQ-2c;
	Sat, 24 May 2025 16:31:10 +0000
Date: Sun, 25 May 2025 00:31:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 40c7a8b63e1234b6a0ab3ff51543d51a80b639cb
Message-ID: <202505250052.HV9VZDGl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 40c7a8b63e1234b6a0ab3ff51543d51a80b639cb  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 1447m

configs tested: 127
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                        nsim_700_defconfig    gcc-14.2.0
arc                   randconfig-001-20250524    gcc-15.1.0
arc                   randconfig-002-20250524    gcc-15.1.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-17
arm                      integrator_defconfig    clang-21
arm                         lpc18xx_defconfig    clang-21
arm                   randconfig-001-20250524    gcc-7.5.0
arm                   randconfig-002-20250524    gcc-7.5.0
arm                   randconfig-003-20250524    clang-20
arm                   randconfig-004-20250524    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250524    gcc-5.5.0
arm64                 randconfig-002-20250524    gcc-7.5.0
arm64                 randconfig-003-20250524    clang-19
arm64                 randconfig-004-20250524    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250524    gcc-11.5.0
csky                  randconfig-002-20250524    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250524    clang-21
hexagon               randconfig-002-20250524    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250524    clang-20
i386        buildonly-randconfig-002-20250524    gcc-12
i386        buildonly-randconfig-003-20250524    gcc-12
i386        buildonly-randconfig-004-20250524    gcc-12
i386        buildonly-randconfig-005-20250524    clang-20
i386        buildonly-randconfig-006-20250524    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250524    gcc-13.3.0
loongarch             randconfig-002-20250524    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250524    gcc-13.3.0
nios2                 randconfig-002-20250524    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250524    gcc-6.5.0
parisc                randconfig-002-20250524    gcc-8.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                   motionpro_defconfig    clang-21
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc               randconfig-001-20250524    gcc-5.5.0
powerpc               randconfig-002-20250524    gcc-7.5.0
powerpc               randconfig-003-20250524    clang-21
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250524    gcc-7.5.0
powerpc64             randconfig-002-20250524    gcc-10.5.0
powerpc64             randconfig-003-20250524    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250524    clang-21
riscv                 randconfig-002-20250524    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250524    clang-17
s390                  randconfig-002-20250524    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                    randconfig-001-20250524    gcc-13.3.0
sh                    randconfig-002-20250524    gcc-7.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250524    gcc-6.5.0
sparc                 randconfig-002-20250524    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250524    gcc-8.5.0
sparc64               randconfig-002-20250524    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                    randconfig-001-20250524    gcc-12
um                    randconfig-002-20250524    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250524    gcc-12
x86_64      buildonly-randconfig-002-20250524    gcc-12
x86_64      buildonly-randconfig-003-20250524    gcc-12
x86_64      buildonly-randconfig-004-20250524    gcc-12
x86_64      buildonly-randconfig-005-20250524    gcc-11
x86_64      buildonly-randconfig-006-20250524    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250524    gcc-8.5.0
xtensa                randconfig-002-20250524    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

