Return-Path: <linux-acpi+bounces-18217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E0EC08E95
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 11:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652464E2527
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686372E7F0A;
	Sat, 25 Oct 2025 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxhjMjDv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F72E7F00;
	Sat, 25 Oct 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761385816; cv=none; b=I9OxSavrVfhk7Gji04jXOj0meWs8UkDvSLFfUiuwImBz6FRP3gjf6/H+rzMQrUqKQL2Re5HNq45EttQbLZSnNNgD0BW6sch0QV84zS3gKDFBCH8IbmPxgRrgnqPjF/RmmxQjZJb21ZZoQc5VE4e/R0KA3UF/1Xd0CfgJU85/mY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761385816; c=relaxed/simple;
	bh=ouM4Qkzji8yTbIt98WysVLKnOMR55ZWGNARuKI785cg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WqDZNorp6c+8nirRF2M6jR93LJBOW53uctCYP5UiwdOPdmNIeUFAUhpfCpv0PYIyGL76lIn+IVcg61oJN972nmcbAcvy8LD1h+uLO2KQytNsv08vwwLkmatKJo9DOsQiyuOinCDr1xl/wt6kMiTQhdagkgNaMCtINYTS5VewNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxhjMjDv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761385814; x=1792921814;
  h=date:from:to:cc:subject:message-id;
  bh=ouM4Qkzji8yTbIt98WysVLKnOMR55ZWGNARuKI785cg=;
  b=MxhjMjDvA2FhdYnLHkHstXW7269yDw9hDWr7JgCErEVrgh6gmMS4N/UD
   RtlNKvZ31LIeHNM3j9E7l6mESjQVkG11303wOaw+ayggkim+8of9syDZB
   VNVvdZSTvNLzhaLG8b5IJYggv5nXpzgZgDeLW7ViMZrGG4oqwcf6zdSaP
   vlEMwXmpe8njUg4EfXT3z45o6D/tSDUpn8hsBnSNjsy+MYmjvS8KaxtZO
   3mH/aYiyhS9thdms8RbCfqabCsatLMTmBm0iMF+rbpmWNBPXNVRkjmJ9S
   VJSxsgs4JC1CAtSUHnOFPOnMIRgboV+P3cley5gh0A7aVbAB9EKY26hHd
   g==;
X-CSE-ConnectionGUID: duc1d3YLTXWKVFlKzrL7cQ==
X-CSE-MsgGUID: mLo3T2b2TY6T+vJE337ItQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51124079"
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="51124079"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 02:50:13 -0700
X-CSE-ConnectionGUID: ejDrb1V4STeX9KGRB8AaFw==
X-CSE-MsgGUID: c5EkSJAhSGyWlE4uD5M1Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="184986817"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 25 Oct 2025 02:50:11 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCauI-000FE5-18;
	Sat, 25 Oct 2025 09:49:59 +0000
Date: Sat, 25 Oct 2025 17:49:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 7aa96c04a4106fe78ee4bd3229e0a66ea19f0ed7
Message-ID: <202510251739.eqvG9tDK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 7aa96c04a4106fe78ee4bd3229e0a66ea19f0ed7  Merge branches 'pm-runtime-next' and 'acpi-fan-next' into linux-next

elapsed time: 1452m

configs tested: 248
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251024    gcc-8.5.0
arc                   randconfig-001-20251025    clang-22
arc                   randconfig-002-20251024    gcc-14.3.0
arc                   randconfig-002-20251025    clang-22
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            hisi_defconfig    clang-22
arm                   randconfig-001-20251024    clang-20
arm                   randconfig-001-20251025    clang-22
arm                   randconfig-002-20251024    gcc-15.1.0
arm                   randconfig-002-20251025    clang-22
arm                   randconfig-003-20251024    clang-22
arm                   randconfig-003-20251025    clang-22
arm                   randconfig-004-20251024    clang-22
arm                   randconfig-004-20251025    clang-22
arm                           sama7_defconfig    clang-22
arm                        spear6xx_defconfig    clang-22
arm                           u8500_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251024    gcc-8.5.0
arm64                 randconfig-001-20251025    clang-22
arm64                 randconfig-002-20251024    clang-16
arm64                 randconfig-002-20251025    clang-22
arm64                 randconfig-003-20251024    gcc-13.4.0
arm64                 randconfig-003-20251025    clang-22
arm64                 randconfig-004-20251024    clang-17
arm64                 randconfig-004-20251025    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251024    gcc-14.3.0
csky                  randconfig-001-20251025    gcc-10.5.0
csky                  randconfig-002-20251024    gcc-11.5.0
csky                  randconfig-002-20251025    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251024    clang-22
hexagon               randconfig-001-20251025    gcc-10.5.0
hexagon               randconfig-002-20251024    clang-22
hexagon               randconfig-002-20251025    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251024    clang-20
i386        buildonly-randconfig-001-20251025    clang-20
i386        buildonly-randconfig-002-20251024    gcc-14
i386        buildonly-randconfig-002-20251025    clang-20
i386        buildonly-randconfig-003-20251024    clang-20
i386        buildonly-randconfig-003-20251025    clang-20
i386        buildonly-randconfig-004-20251024    gcc-14
i386        buildonly-randconfig-004-20251025    clang-20
i386        buildonly-randconfig-005-20251024    gcc-14
i386        buildonly-randconfig-005-20251025    clang-20
i386        buildonly-randconfig-006-20251024    gcc-14
i386        buildonly-randconfig-006-20251025    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251025    clang-20
i386                  randconfig-002-20251025    clang-20
i386                  randconfig-003-20251025    clang-20
i386                  randconfig-004-20251025    clang-20
i386                  randconfig-005-20251025    clang-20
i386                  randconfig-006-20251025    clang-20
i386                  randconfig-007-20251025    clang-20
i386                  randconfig-011-20251025    gcc-14
i386                  randconfig-012-20251025    gcc-14
i386                  randconfig-013-20251025    gcc-14
i386                  randconfig-014-20251025    gcc-14
i386                  randconfig-015-20251025    gcc-14
i386                  randconfig-016-20251025    gcc-14
i386                  randconfig-017-20251025    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251024    gcc-15.1.0
loongarch             randconfig-001-20251025    gcc-10.5.0
loongarch             randconfig-002-20251024    gcc-15.1.0
loongarch             randconfig-002-20251025    gcc-10.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251024    gcc-11.5.0
nios2                 randconfig-001-20251025    gcc-10.5.0
nios2                 randconfig-002-20251024    gcc-11.5.0
nios2                 randconfig-002-20251025    gcc-10.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251024    gcc-9.5.0
parisc                randconfig-001-20251025    gcc-10.5.0
parisc                randconfig-002-20251024    gcc-13.4.0
parisc                randconfig-002-20251025    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                       ebony_defconfig    clang-22
powerpc               randconfig-001-20251024    gcc-8.5.0
powerpc               randconfig-001-20251025    gcc-10.5.0
powerpc               randconfig-002-20251024    clang-17
powerpc               randconfig-002-20251025    gcc-10.5.0
powerpc               randconfig-003-20251024    clang-16
powerpc               randconfig-003-20251025    gcc-10.5.0
powerpc64             randconfig-001-20251024    gcc-12.5.0
powerpc64             randconfig-001-20251025    gcc-10.5.0
powerpc64             randconfig-002-20251024    gcc-14.3.0
powerpc64             randconfig-002-20251025    gcc-10.5.0
powerpc64             randconfig-003-20251024    gcc-8.5.0
powerpc64             randconfig-003-20251025    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251024    clang-22
riscv                 randconfig-001-20251025    clang-22
riscv                 randconfig-002-20251024    clang-22
riscv                 randconfig-002-20251025    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251024    gcc-13.4.0
s390                  randconfig-001-20251025    clang-22
s390                  randconfig-002-20251024    clang-22
s390                  randconfig-002-20251025    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251024    gcc-12.5.0
sh                    randconfig-001-20251025    clang-22
sh                    randconfig-002-20251024    gcc-14.3.0
sh                    randconfig-002-20251025    clang-22
sh                   sh7724_generic_defconfig    clang-22
sh                            titan_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251024    gcc-12.5.0
sparc                 randconfig-001-20251025    clang-22
sparc                 randconfig-002-20251024    gcc-8.5.0
sparc                 randconfig-002-20251025    clang-22
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251024    clang-20
sparc64               randconfig-001-20251025    clang-22
sparc64               randconfig-002-20251024    clang-22
sparc64               randconfig-002-20251025    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251024    gcc-14
um                    randconfig-001-20251025    clang-22
um                    randconfig-002-20251024    clang-22
um                    randconfig-002-20251025    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251024    clang-20
x86_64      buildonly-randconfig-001-20251025    clang-20
x86_64      buildonly-randconfig-002-20251024    clang-20
x86_64      buildonly-randconfig-002-20251025    clang-20
x86_64      buildonly-randconfig-003-20251024    clang-20
x86_64      buildonly-randconfig-003-20251025    clang-20
x86_64      buildonly-randconfig-004-20251024    gcc-14
x86_64      buildonly-randconfig-004-20251025    clang-20
x86_64      buildonly-randconfig-005-20251024    gcc-14
x86_64      buildonly-randconfig-005-20251025    clang-20
x86_64      buildonly-randconfig-006-20251024    clang-20
x86_64      buildonly-randconfig-006-20251025    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251025    clang-20
x86_64                randconfig-002-20251025    clang-20
x86_64                randconfig-003-20251025    clang-20
x86_64                randconfig-004-20251025    clang-20
x86_64                randconfig-005-20251025    clang-20
x86_64                randconfig-006-20251025    clang-20
x86_64                randconfig-007-20251025    clang-20
x86_64                randconfig-008-20251025    clang-20
x86_64                randconfig-071-20251025    clang-20
x86_64                randconfig-072-20251025    clang-20
x86_64                randconfig-073-20251025    clang-20
x86_64                randconfig-074-20251025    clang-20
x86_64                randconfig-075-20251025    clang-20
x86_64                randconfig-076-20251025    clang-20
x86_64                randconfig-077-20251025    clang-20
x86_64                randconfig-078-20251025    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251024    gcc-11.5.0
xtensa                randconfig-001-20251025    clang-22
xtensa                randconfig-002-20251024    gcc-13.4.0
xtensa                randconfig-002-20251025    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

