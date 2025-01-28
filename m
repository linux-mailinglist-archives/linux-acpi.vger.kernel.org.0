Return-Path: <linux-acpi+bounces-10851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0A5A20407
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2025 06:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CAA1887E2E
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2025 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6901D6DA3;
	Tue, 28 Jan 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAPyNA+9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588D1D47B5;
	Tue, 28 Jan 2025 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042426; cv=none; b=sCfGIgWuCNonCrgAmYYo5E5aoqcrWXsy6fy4SIsGrStoJii9iUUBHxqiBkqDENnEVswRzyOVmJ4a5H5Lfvs80Q3IRS4sBH/bUIfZaIvBJoDYykOJa/1yn7MqjueS2inbknvUgvYo3o8f0rh3T6xn9XaLEcF5Z8l+ptENpU+20ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042426; c=relaxed/simple;
	bh=Hjt3TJ7xTzMLlSQnonHGbm3oLTto5HuJhlxie89G82I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=az2wNbLvDqt+XxjePxgko57f+lxaZVRlMM3DqBio7V24eRBQWeMN6x6O0238dpVo0vYmJJi2IsgbxPlGq2TW1ENAwCA0Ds7ipq8rW1gbsV4H9cqwpJfe9i+kvQAHp0DGIQPAEIjWH9FsPsZvdeRnVh/Kb1gh/2qtPsg2VMGsiyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAPyNA+9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738042424; x=1769578424;
  h=date:from:to:cc:subject:message-id;
  bh=Hjt3TJ7xTzMLlSQnonHGbm3oLTto5HuJhlxie89G82I=;
  b=WAPyNA+9CiiojTSojGbjYeNJOYzpgZz8WONTSOa61O5Wmx0eCEkMMuYG
   OIYKzCF/1hmNovdyxqPK1qOVmVoVaFTejFWZbF17S+faZKOSNVLiTYlhE
   ndEBPbdDd9aBWzslkwsC2a520dfVfkR11C+30skdxyH03z5J4tw7qUYZa
   zhTNMMYBrxxK5RdxuPfvbdnfoWhcXW+DMHvpfejCSYZY7mq1XtNydU+d6
   htJT75sBp/0JvnbSKIg95xpXysTH24skr60hNY0lCtzm4Lc5h7paM+cHo
   SdddlLcSG6D8w9SpJZxjGmln3fKnTyA3SGjr4LV7M5ycy/GAOpjGiMIGy
   A==;
X-CSE-ConnectionGUID: 1eQ236osQEOQBKC83VdODA==
X-CSE-MsgGUID: mSxWjkXeR9ydeFdiOBCtHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="49110037"
X-IronPort-AV: E=Sophos;i="6.13,240,1732608000"; 
   d="scan'208";a="49110037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 21:33:43 -0800
X-CSE-ConnectionGUID: l8qNhke3TOOiLOOadxo97g==
X-CSE-MsgGUID: T7TQ9voTQimLj2SrenIQBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145847431"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2025 21:33:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tceEF-000hUF-2x;
	Tue, 28 Jan 2025 05:33:39 +0000
Date: Tue, 28 Jan 2025 13:33:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fc2f1c3f6a69162be891295f651a6322055c8325
Message-ID: <202501281318.Gko1ocFp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: fc2f1c3f6a69162be891295f651a6322055c8325  Merge branch 'experimental/intel_pstate/eas-take1' into bleeding-edge

elapsed time: 937m

configs tested: 128
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250127    gcc-13.2.0
arc                   randconfig-002-20250127    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20250127    gcc-14.2.0
arm                   randconfig-002-20250127    gcc-14.2.0
arm                   randconfig-003-20250127    clang-16
arm                   randconfig-004-20250127    clang-18
arm                         s5pv210_defconfig    gcc-14.2.0
arm                           sama7_defconfig    clang-16
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250127    gcc-14.2.0
arm64                 randconfig-002-20250127    gcc-14.2.0
arm64                 randconfig-003-20250127    gcc-14.2.0
arm64                 randconfig-004-20250127    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250127    gcc-14.2.0
csky                  randconfig-002-20250127    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250127    clang-17
hexagon               randconfig-002-20250127    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250127    gcc-12
i386        buildonly-randconfig-002-20250127    clang-19
i386        buildonly-randconfig-003-20250127    gcc-12
i386        buildonly-randconfig-004-20250127    gcc-12
i386        buildonly-randconfig-005-20250127    gcc-12
i386        buildonly-randconfig-006-20250127    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250127    gcc-14.2.0
loongarch             randconfig-002-20250127    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250127    gcc-14.2.0
nios2                 randconfig-002-20250127    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250127    gcc-14.2.0
parisc                randconfig-002-20250127    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250127    clang-16
powerpc               randconfig-002-20250127    gcc-14.2.0
powerpc               randconfig-003-20250127    gcc-14.2.0
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250127    gcc-14.2.0
powerpc64             randconfig-002-20250127    gcc-14.2.0
powerpc64             randconfig-003-20250127    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250127    clang-20
riscv                 randconfig-002-20250127    clang-16
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250127    clang-20
s390                  randconfig-002-20250127    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250127    gcc-14.2.0
sh                    randconfig-002-20250127    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250127    gcc-14.2.0
sparc                 randconfig-002-20250127    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250127    gcc-14.2.0
sparc64               randconfig-002-20250127    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250127    clang-20
um                    randconfig-002-20250127    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250127    clang-19
x86_64      buildonly-randconfig-002-20250127    clang-19
x86_64      buildonly-randconfig-003-20250127    clang-19
x86_64      buildonly-randconfig-004-20250127    clang-19
x86_64      buildonly-randconfig-005-20250127    gcc-12
x86_64      buildonly-randconfig-006-20250127    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250127    gcc-14.2.0
xtensa                randconfig-002-20250127    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

