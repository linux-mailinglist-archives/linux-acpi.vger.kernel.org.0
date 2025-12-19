Return-Path: <linux-acpi+bounces-19688-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D1CCE4A3
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 03:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26AAA3017640
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 02:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78902222CC;
	Fri, 19 Dec 2025 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z70CysRb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B21D6187;
	Fri, 19 Dec 2025 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112526; cv=none; b=WDSubEirTVkAJZB6C9SGJKgyC+ff5P0CcFgvqg7gOb1MeLA+5tadzMVZLPKGeeSru2yiW0rF4RicLHQ7GbH4h5CPjkGiV6v6lZ6hJfSUc/s9CkJ8zhO6/IRN+euEakuwmvXboGo9KESeL8YTF2fWtkTi6zUViQq9Sx4tTt7qNyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112526; c=relaxed/simple;
	bh=3XqoZZZqSXEtJ0glbNTZ9hdXl0suOXzeyXiBGlw9uKw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W8HMOlo1LSIiGekkEmV6prBMaSWtnFjh+EVLmIa18u/8yVyjXMnYt/D50B1X4Gk2MFCRYhmldPvRh0AKuKaoGhtA6EqXTk9NjtYetRKEu1TZHC+ZxS3T0zoxZ5RsiIRwZR6jiWCcWKM1GeqajuflfkSgf870hM11hG5vBr87Kg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z70CysRb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766112526; x=1797648526;
  h=date:from:to:cc:subject:message-id;
  bh=3XqoZZZqSXEtJ0glbNTZ9hdXl0suOXzeyXiBGlw9uKw=;
  b=Z70CysRbjpDe7c8MphdLNLZ2g+X3Sy50j/rHDle8ZUDt5jYch0KD8mTu
   gj8r4dQKKYaLJUIRGjrTm/dpChHNVG2/SRekVENUhRmT0UmmCBGZG0TAb
   +2JG454gKxmd3HeB4U2eK8l3A8ZYY+CLa7YO66lfs/nGJfsXivsk8+xpx
   lpIuzTMGtTY3yNrNoYjj7ak/NccjHMYNWop0oUSDTXmZYZnDhTvQOmdZO
   3mS1eA3ezq+Sx/7veKoGgUvNhXuPJA7bnV43DnTe93qbRg3UvXM0c31bJ
   iHLMqOkDPWZm5O2dD88DEy+fbHJgRiWp4tvog5awpch4/3oCcqaQsrnzQ
   g==;
X-CSE-ConnectionGUID: elR7KSF9RMWKsTtJlYSkPA==
X-CSE-MsgGUID: LLZ9LI/kRB26GtxnWEdTOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="85496010"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="85496010"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 18:48:45 -0800
X-CSE-ConnectionGUID: yNkCCtyuR1q3Y2pjTdvrLQ==
X-CSE-MsgGUID: ujOH0aIiTCOczq57KyVmpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="198340217"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Dec 2025 18:48:42 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWQXo-000000002uX-2V1V;
	Fri, 19 Dec 2025 02:48:40 +0000
Date: Fri, 19 Dec 2025 10:47:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 86435669c1256f4d5bac8e68f0f4df839a1eaf51
Message-ID: <202512191034.91W63RPa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 86435669c1256f4d5bac8e68f0f4df839a1eaf51  Merge branch 'pm-powercap' into fixes

elapsed time: 2043m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251219    gcc-11.5.0
arc                   randconfig-002-20251219    gcc-8.5.0
arm                                 defconfig    clang-22
arm                            mmp2_defconfig    gcc-15.1.0
arm                   randconfig-001-20251219    clang-22
arm                   randconfig-002-20251219    gcc-11.5.0
arm                   randconfig-003-20251219    clang-22
arm                   randconfig-004-20251219    gcc-8.5.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251219    clang-22
arm64                 randconfig-002-20251219    clang-20
arm64                 randconfig-003-20251219    gcc-9.5.0
arm64                 randconfig-004-20251219    clang-22
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251219    gcc-12.5.0
csky                  randconfig-002-20251219    gcc-9.5.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251219    clang-18
hexagon               randconfig-002-20251219    clang-19
i386                             allmodconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251219    clang-20
i386        buildonly-randconfig-002-20251219    clang-20
i386        buildonly-randconfig-003-20251219    clang-20
i386        buildonly-randconfig-004-20251219    clang-20
i386        buildonly-randconfig-005-20251219    clang-20
i386        buildonly-randconfig-006-20251219    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20251219    gcc-12
i386                  randconfig-012-20251219    clang-20
i386                  randconfig-013-20251219    clang-20
i386                  randconfig-014-20251219    gcc-14
i386                  randconfig-015-20251219    gcc-14
i386                  randconfig-016-20251219    gcc-14
i386                  randconfig-017-20251219    gcc-14
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251219    gcc-15.1.0
loongarch             randconfig-002-20251219    clang-22
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        mvme147_defconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251219    gcc-11.5.0
nios2                 randconfig-002-20251219    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251219    gcc-13.4.0
parisc                randconfig-002-20251219    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                     akebono_defconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251219    clang-22
powerpc               randconfig-002-20251219    gcc-8.5.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251219    clang-22
powerpc64             randconfig-002-20251219    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251219    gcc-10.5.0
riscv                 randconfig-002-20251219    clang-22
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251219    gcc-12.5.0
s390                  randconfig-002-20251219    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251219    gcc-15.1.0
sh                    randconfig-002-20251219    gcc-9.5.0
sh                          rsk7203_defconfig    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251219    gcc-8.5.0
sparc                 randconfig-002-20251219    gcc-15.1.0
sparc64                          alldefconfig    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251219    gcc-9.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251219    clang-20
x86_64      buildonly-randconfig-002-20251219    gcc-13
x86_64      buildonly-randconfig-003-20251219    clang-20
x86_64      buildonly-randconfig-004-20251219    clang-20
x86_64      buildonly-randconfig-005-20251219    clang-20
x86_64      buildonly-randconfig-006-20251219    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251219    gcc-14
x86_64                randconfig-002-20251219    gcc-14
x86_64                randconfig-003-20251219    gcc-14
x86_64                randconfig-004-20251219    clang-20
x86_64                randconfig-005-20251219    clang-20
x86_64                randconfig-006-20251219    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

