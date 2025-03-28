Return-Path: <linux-acpi+bounces-12533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE3A751A1
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 21:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68603B01FE
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 20:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2021C8627;
	Fri, 28 Mar 2025 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVwJi/5F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E696E545;
	Fri, 28 Mar 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194879; cv=none; b=eVyEEdTCtFg/GX1hOodZid6nvCDWQn5tWwvTeX5xCjJoPFEnxaOwo8upWqdK1eYAK9cE1vZW6ElJip/InMBaNzx90Y0ZyV2iPx5t1xs+tVx26xP1KcJTheMXAk8dAaTGzQfi13ZV+hJbZiFSfX7hwdIzG+lzwKwj6etwkwGF2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194879; c=relaxed/simple;
	bh=sFFHxPogWSBe+H5EPKShJmV1UZQ0W9imdU/DbskLvbo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XiOqMPMQIAJmETNkD9gFZdMnYpNuadcg0NkRsyaC/I73p+5XwhJjIHgFozYXOX3MC0VUFhCIYX1TbYRffABWYUu0bXhMEJSvqGXZqqypvua1oufvTtf77CLBq5HJc8qiNrt2inkhRAXbpa7+0vIe5EpUCbT/23Grs+1MUmEu0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVwJi/5F; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743194878; x=1774730878;
  h=date:from:to:cc:subject:message-id;
  bh=sFFHxPogWSBe+H5EPKShJmV1UZQ0W9imdU/DbskLvbo=;
  b=DVwJi/5FQQNLEv46/I974om3yzttr50pQfiIDTaoS3TA4CkfSPBm9V0+
   qPHw2y8knKRgYvHRvgC4C2MHkibeskE6WgwCwyBXjTwdKqQ/fC+4UL715
   Sig7+Nf1bQ3nHXah1XTEQhFzP9oiCUK5XZEmnweoibTikcNpSkor3HV+L
   pZIVjnckn0t3vVIm3Wy27FtoHtpc/j5WgHDFwETOOLh9jVYwaVeHhK8go
   +VYBJnrLtlGoywR/Oo0W4M+ziZa1NI5zFcrsYnd9giWGbuiFmTChcIdBz
   r1QFii0EyGtEv5T4Ybesf1sRoVxYftKO70EnxcOWnpkOLjIlSsasaBzyp
   w==;
X-CSE-ConnectionGUID: mEGVAdPQS7SlFai6Om22sw==
X-CSE-MsgGUID: D1BC6IcrSjaHzt+mlspBVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44752132"
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="44752132"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 13:47:57 -0700
X-CSE-ConnectionGUID: Pzyz5iWlQQOfk9twGBE4KA==
X-CSE-MsgGUID: IENkmD6tQwSfZDxWRfTDeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="148718826"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 28 Mar 2025 13:47:55 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tyGcL-0007h4-13;
	Fri, 28 Mar 2025 20:47:53 +0000
Date: Sat, 29 Mar 2025 04:47:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9d937d7be208b2895b2956c5afb28affc28237bd
Message-ID: <202503290428.FCManzYA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9d937d7be208b2895b2956c5afb28affc28237bd  Merge branch 'acpi-platform-profile' into bleeding-edge

elapsed time: 1449m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20250328    gcc-12.4.0
arc                   randconfig-002-20250328    gcc-14.2.0
arc                           tb10x_defconfig    gcc-14.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-21
arm                   randconfig-001-20250328    clang-18
arm                   randconfig-002-20250328    gcc-8.5.0
arm                   randconfig-003-20250328    clang-18
arm                   randconfig-004-20250328    gcc-8.5.0
arm                       spear13xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250328    gcc-8.5.0
arm64                 randconfig-002-20250328    clang-15
arm64                 randconfig-003-20250328    clang-16
arm64                 randconfig-004-20250328    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250328    gcc-12.4.0
csky                  randconfig-002-20250328    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250328    clang-21
hexagon               randconfig-002-20250328    clang-14
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250328    gcc-12
i386        buildonly-randconfig-002-20250328    gcc-12
i386        buildonly-randconfig-003-20250328    clang-20
i386        buildonly-randconfig-004-20250328    gcc-12
i386        buildonly-randconfig-005-20250328    clang-20
i386        buildonly-randconfig-006-20250328    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250328    gcc-14.2.0
loongarch             randconfig-002-20250328    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250328    gcc-6.5.0
nios2                 randconfig-002-20250328    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250328    gcc-9.3.0
parisc                randconfig-002-20250328    gcc-13.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                       holly_defconfig    clang-21
powerpc                      mgcoge_defconfig    clang-21
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc               randconfig-001-20250328    clang-21
powerpc               randconfig-002-20250328    clang-21
powerpc               randconfig-003-20250328    clang-21
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250328    clang-16
powerpc64             randconfig-002-20250328    clang-21
powerpc64             randconfig-003-20250328    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250328    gcc-8.5.0
riscv                 randconfig-002-20250328    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250328    gcc-6.5.0
s390                  randconfig-002-20250328    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250328    gcc-10.5.0
sh                    randconfig-002-20250328    gcc-14.2.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250328    gcc-13.3.0
sparc                 randconfig-002-20250328    gcc-7.5.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250328    gcc-11.5.0
sparc64               randconfig-002-20250328    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250328    clang-17
um                    randconfig-002-20250328    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250328    clang-20
x86_64      buildonly-randconfig-002-20250328    clang-20
x86_64      buildonly-randconfig-003-20250328    clang-20
x86_64      buildonly-randconfig-004-20250328    clang-20
x86_64      buildonly-randconfig-005-20250328    clang-20
x86_64      buildonly-randconfig-006-20250328    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250328    gcc-9.3.0
xtensa                randconfig-002-20250328    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

