Return-Path: <linux-acpi+bounces-19938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44372CEFF2A
	for <lists+linux-acpi@lfdr.de>; Sat, 03 Jan 2026 14:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E68F03003FDF
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Jan 2026 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C4320298C;
	Sat,  3 Jan 2026 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keKI3giD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A365176ADE;
	Sat,  3 Jan 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445355; cv=none; b=Jj0UBuht1+huS7L9952RjVvoiy9JO2B67Lj1TkLZAzGY8m7o334TTjC7AEslOJEIpn5+9dwu+j25EtWBqw6L2EfWepKp5sHoIE4bqnLswFEZkTQ6hkEZiDaDmtquzPE9F1b3bViLBM8A+NBmHU88F4U1CECbQYjqltGhetpsxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445355; c=relaxed/simple;
	bh=zUq6jFk7GOGydnlwoGC1WDCPsnOGbkXe8l46GFM9j+c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qmdimakT6yOplmuKMAswoCwm1ul5g2pDeIJJApxZ1lNQTUGmywuiDjfmDJ0sS/4OhWTLTB1Gf39i95rFiMQEgkAXJdHUboUMtzLdv6SDb/aCYExBJCuKAzNIXwV7LT8OdmtOuyHCgj3pecIFXADhkBij4YdwK/SwOB1OoLqVJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keKI3giD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767445353; x=1798981353;
  h=date:from:to:cc:subject:message-id;
  bh=zUq6jFk7GOGydnlwoGC1WDCPsnOGbkXe8l46GFM9j+c=;
  b=keKI3giDAeAx6lisZ2ItJ4h7E2VhO6Jjnbi/EBRVYQvhbpTryi8988qB
   NpkF5741xIAMh7BdtjbpN+urjF2awkPmznfsl7Fr6V5Fv7UuQYxWixLKY
   abd/YWJmkJEkc2uZKnAF6uylLG/6ZlG4jEFX9fb8Z5qwOM5IGEynmlm89
   KRsbS4Ysfqb6tmAIpRWoalD6Qw0EOQlqyjkvCdWlJ//jU1i/bNY2VIjs0
   ihKmmxqmQ6D1ml3IEVRHOpf7TLuhxqzLL6m5wghKryF2LSDZpHIlryidq
   EZ7MDt+I4qaCenppTohpKoITWLMQ4XgMsEyUVUSQHiflPAF9lGL4Y6niT
   A==;
X-CSE-ConnectionGUID: imwkOOf1RSqSUhWMJ57LDw==
X-CSE-MsgGUID: R4RqriSvSem8yaAg4lpDFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="69056459"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="69056459"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 05:02:33 -0800
X-CSE-ConnectionGUID: ghoaAgf3QrybxRJEcf9wZA==
X-CSE-MsgGUID: LaM3UYhrTfeM/RDla9tj3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="207047231"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 03 Jan 2026 05:02:32 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vc1H3-000000002if-1R1d;
	Sat, 03 Jan 2026 13:02:29 +0000
Date: Sat, 03 Jan 2026 21:01:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9a29c65f49d4879b155e9e9eb0a64da71b89d92d
Message-ID: <202601032145.MB0TN2Xg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9a29c65f49d4879b155e9e9eb0a64da71b89d92d  Merge branch 'pm-runtime-cleanup' into bleeding-edge

elapsed time: 1479m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260103    gcc-8.5.0
arc                   randconfig-002-20260103    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                   randconfig-001-20260103    gcc-10.5.0
arm                   randconfig-002-20260103    gcc-15.1.0
arm                   randconfig-003-20260103    gcc-11.5.0
arm                   randconfig-004-20260103    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260103    clang-22
arm64                 randconfig-002-20260103    gcc-8.5.0
arm64                 randconfig-003-20260103    gcc-15.1.0
arm64                 randconfig-004-20260103    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260103    gcc-15.1.0
csky                  randconfig-002-20260103    gcc-13.4.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260103    clang-22
hexagon               randconfig-002-20260103    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20260103    gcc-14
i386        buildonly-randconfig-002-20260103    gcc-14
i386        buildonly-randconfig-003-20260103    gcc-14
i386        buildonly-randconfig-004-20260103    clang-20
i386        buildonly-randconfig-005-20260103    clang-20
i386        buildonly-randconfig-006-20260103    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260103    gcc-14
i386                  randconfig-002-20260103    gcc-14
i386                  randconfig-003-20260103    gcc-14
i386                  randconfig-004-20260103    gcc-14
i386                  randconfig-005-20260103    clang-20
i386                  randconfig-006-20260103    clang-20
i386                  randconfig-007-20260103    clang-20
i386                  randconfig-011-20260103    clang-20
i386                  randconfig-012-20260103    clang-20
i386                  randconfig-013-20260103    clang-20
i386                  randconfig-014-20260103    clang-20
i386                  randconfig-015-20260103    clang-20
i386                  randconfig-017-20260103    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260103    gcc-15.1.0
loongarch             randconfig-002-20260103    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                  maltasmvp_eva_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260103    gcc-8.5.0
nios2                 randconfig-002-20260103    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260103    gcc-8.5.0
parisc                randconfig-002-20260103    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   motionpro_defconfig    clang-22
powerpc                     powernv_defconfig    gcc-15.1.0
powerpc               randconfig-001-20260103    gcc-14.3.0
powerpc               randconfig-002-20260103    clang-17
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20260103    gcc-14.3.0
powerpc64             randconfig-002-20260103    gcc-13.4.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260103    clang-22
riscv                 randconfig-002-20260103    gcc-13.4.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20260103    gcc-12.5.0
s390                  randconfig-002-20260103    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20260103    gcc-12.5.0
sh                    randconfig-002-20260103    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260103    gcc-12.5.0
sparc                 randconfig-002-20260103    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260103    clang-22
sparc64               randconfig-002-20260103    gcc-13.4.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260103    gcc-14
um                    randconfig-002-20260103    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20260103    gcc-14
x86_64      buildonly-randconfig-002-20260103    clang-20
x86_64      buildonly-randconfig-003-20260103    clang-20
x86_64      buildonly-randconfig-004-20260103    gcc-14
x86_64      buildonly-randconfig-005-20260103    clang-20
x86_64      buildonly-randconfig-006-20260103    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260103    clang-20
x86_64                randconfig-002-20260103    clang-20
x86_64                randconfig-003-20260103    clang-20
x86_64                randconfig-004-20260103    clang-20
x86_64                randconfig-005-20260103    gcc-14
x86_64                randconfig-006-20260103    clang-20
x86_64                randconfig-011-20260103    gcc-14
x86_64                randconfig-012-20260103    gcc-14
x86_64                randconfig-013-20260103    gcc-14
x86_64                randconfig-014-20260103    gcc-14
x86_64                randconfig-015-20260103    gcc-14
x86_64                randconfig-016-20260103    clang-20
x86_64                randconfig-071-20260103    gcc-14
x86_64                randconfig-072-20260103    gcc-14
x86_64                randconfig-073-20260103    clang-20
x86_64                randconfig-074-20260103    clang-20
x86_64                randconfig-075-20260103    clang-20
x86_64                randconfig-076-20260103    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20260103    gcc-9.5.0
xtensa                randconfig-002-20260103    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

