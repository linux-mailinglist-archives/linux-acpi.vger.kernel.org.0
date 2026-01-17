Return-Path: <linux-acpi+bounces-20417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA995D38DF0
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46AF5300B023
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1680313298;
	Sat, 17 Jan 2026 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RI9Qr64n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E93128DF;
	Sat, 17 Jan 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768647598; cv=none; b=tIg69ny+cW3j+jOeTPjxx9crBq3QR+Y281HOJL5hIUOK6YCl1JmVlDD8q4n0mDqQkWbMyx23LGUgIXFzzZD+bC9PFSW21tH/68JCXDUEJCWWW2poa92QOJjLK25t6+LYER60r4gA/93mm/ZB/CgzLC/CAphbpc1w/7DXdVwsWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768647598; c=relaxed/simple;
	bh=XrpTOB7cY4I77LN2JHLPO8zuJxrFmCYl4bgYKFpH9KU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YQ3i9378eIlXLNDrKvNuacbJglJy8k7d5it57qRFEfC74Z06D29vaLp791/kC0tQSyFLUIXy50DpbFIjv79LYKICekqlckPAMnGdyaM++2suaJiWpxyA8jNL3zfzcKfSXC6gSLnZCKSwWXHe41YV20lQfzYdrvDPkjQJHAGQ5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RI9Qr64n; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768647597; x=1800183597;
  h=date:from:to:cc:subject:message-id;
  bh=XrpTOB7cY4I77LN2JHLPO8zuJxrFmCYl4bgYKFpH9KU=;
  b=RI9Qr64nijAVHCNeYrQpZxvqTclMafkfajiPN5hyguUCGnsA69FYaGjK
   zAfVw/I13E4sxcaGOa84lRcCBeoP8fY8fYd7eF8GSIuyZjk9xxvVcBfF3
   v2LEkqKVm0DbZz/k5mu+IH0j3/Ei7ZtMjTBk2TtogQo9wXqxqtlqdFs4O
   4zCSq8lKA6VyzvuNzD2hsLXdRmOloJQK33lMYqlLK+pAVPA4nqCb03Dw2
   FcQep2DhNqXFVxt+eAuB58LmUUlClXOn67fzFz72wNb1gIv+K9XytYby6
   gdMdvuu/I/3yOjKqolvWDjMZLXbH4mgXBl5fNUSTtSEXKsgmglTzFhDuu
   g==;
X-CSE-ConnectionGUID: PYcqtdbbRhiN9k9XZthwTA==
X-CSE-MsgGUID: SGKTxva3TrCysofCny7q6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69839216"
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="69839216"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 02:59:54 -0800
X-CSE-ConnectionGUID: mQYvhpO0TWCqppSZXFvhiA==
X-CSE-MsgGUID: OKOtZ4QdT4W2X6ZJguJsjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="205484261"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Jan 2026 02:59:52 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vh421-00000000LmU-474l;
	Sat, 17 Jan 2026 10:59:49 +0000
Date: Sat, 17 Jan 2026 18:59:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f32a1ef7d46f78c7dde6aa42407a7f305e10e419
Message-ID: <202601171816.BgtVzf6m-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f32a1ef7d46f78c7dde6aa42407a7f305e10e419  Merge branch 'pm-runtime-cleanup' into bleeding-edge

elapsed time: 915m

configs tested: 202
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs103_defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    clang-22
arc                   randconfig-001-20260117    gcc-12.5.0
arc                   randconfig-002-20260117    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20260117    gcc-12.5.0
arm                   randconfig-002-20260117    gcc-12.5.0
arm                   randconfig-003-20260117    gcc-12.5.0
arm                   randconfig-004-20260117    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260117    clang-22
arm64                 randconfig-002-20260117    clang-22
arm64                 randconfig-003-20260117    clang-22
arm64                 randconfig-004-20260117    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260117    clang-22
csky                  randconfig-002-20260117    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260117    clang-22
hexagon               randconfig-002-20260117    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260117    gcc-13
i386        buildonly-randconfig-002-20260117    gcc-13
i386        buildonly-randconfig-003-20260117    gcc-13
i386        buildonly-randconfig-004-20260117    gcc-13
i386        buildonly-randconfig-005-20260117    gcc-13
i386        buildonly-randconfig-006-20260117    gcc-13
i386                  randconfig-001-20260117    gcc-14
i386                  randconfig-002-20260117    gcc-14
i386                  randconfig-003-20260117    gcc-14
i386                  randconfig-004-20260117    gcc-14
i386                  randconfig-005-20260117    gcc-14
i386                  randconfig-006-20260117    gcc-14
i386                  randconfig-007-20260117    gcc-14
i386                  randconfig-011-20260117    gcc-14
i386                  randconfig-012-20260117    gcc-14
i386                  randconfig-013-20260117    gcc-14
i386                  randconfig-014-20260117    gcc-14
i386                  randconfig-015-20260117    gcc-14
i386                  randconfig-016-20260117    gcc-14
i386                  randconfig-017-20260117    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260117    clang-22
loongarch             randconfig-002-20260117    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    clang-22
mips                           ip30_defconfig    clang-22
mips                          malta_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260117    clang-22
nios2                 randconfig-002-20260117    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260117    clang-22
parisc                randconfig-002-20260117    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      bamboo_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    clang-22
powerpc                      ppc64e_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260117    clang-22
powerpc               randconfig-002-20260117    clang-22
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20260117    clang-22
powerpc64             randconfig-002-20260117    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260117    gcc-10.5.0
riscv                 randconfig-002-20260117    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260117    gcc-10.5.0
s390                  randconfig-002-20260117    gcc-10.5.0
sh                               alldefconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260117    gcc-10.5.0
sh                    randconfig-002-20260117    gcc-10.5.0
sh                           se7751_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260117    gcc-14.3.0
sparc                 randconfig-002-20260117    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260117    gcc-14.3.0
sparc64               randconfig-002-20260117    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260117    gcc-14.3.0
um                    randconfig-002-20260117    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260117    clang-20
x86_64      buildonly-randconfig-002-20260117    clang-20
x86_64      buildonly-randconfig-003-20260117    clang-20
x86_64      buildonly-randconfig-004-20260117    clang-20
x86_64      buildonly-randconfig-005-20260117    clang-20
x86_64      buildonly-randconfig-006-20260117    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260117    clang-20
x86_64                randconfig-002-20260117    clang-20
x86_64                randconfig-003-20260117    clang-20
x86_64                randconfig-004-20260117    clang-20
x86_64                randconfig-005-20260117    clang-20
x86_64                randconfig-006-20260117    clang-20
x86_64                randconfig-011-20260117    clang-20
x86_64                randconfig-012-20260117    clang-20
x86_64                randconfig-013-20260117    clang-20
x86_64                randconfig-014-20260117    clang-20
x86_64                randconfig-015-20260117    clang-20
x86_64                randconfig-016-20260117    clang-20
x86_64                randconfig-071-20260117    clang-20
x86_64                randconfig-072-20260117    clang-20
x86_64                randconfig-073-20260117    clang-20
x86_64                randconfig-074-20260117    clang-20
x86_64                randconfig-075-20260117    clang-20
x86_64                randconfig-076-20260117    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260117    gcc-14.3.0
xtensa                randconfig-002-20260117    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

