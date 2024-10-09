Return-Path: <linux-acpi+bounces-8655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3C996CCD
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699EBB217C3
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78A019924D;
	Wed,  9 Oct 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N43sAW0c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479638DE5;
	Wed,  9 Oct 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482039; cv=none; b=DKZ3Dv2j8X422ZDk0VfTv79H7AvuNJO8YvutHzyqLXk7+MbAnkO8XZnxZCe70Va7iJfs8lFkGhxKOtLSQpNo4K0UKaVo41d598MQ9zG+Tex/cqCyzXjBzqMRu8XXSyPB+3M/5QUOtBkf37Mhj2T0tST3ry8S6yh/e/XXzpMfisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482039; c=relaxed/simple;
	bh=8N5jfzDOt7ZOjj9uSBVdMRUWIVi1JgHRbc8fx2TsvTE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BboOgp4odLI4VQH9UCQmbezVUVyjCq6JxByvfM2eOazRjGi/MVIx7jFUCr/eJhWmOhHOB5aripGEDqfzx5TtTqTmrmMl2ZqjQ9RoFIgMUjqCniANaAf0vGVz51zHpZEXUa3Empcb8LGCRyzquYMcCPkArdyR630nBDwixNyulaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N43sAW0c; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728482038; x=1760018038;
  h=date:from:to:cc:subject:message-id;
  bh=8N5jfzDOt7ZOjj9uSBVdMRUWIVi1JgHRbc8fx2TsvTE=;
  b=N43sAW0ccSNtipE5JeXyFmY0GsOySs7ksmKR4kmm3JowKwSIMwHALW8C
   LIoG1C0xMH6y2QE/WbVPeC/Fh/edoaVw/Y6YfEbCLBTT+1sJ/Ko5lcwWt
   zJLHtLD7VtsMh3CNZ5X0UQEtXBKEbudcYq0hIwrdhq67DUDgDtRgRMbJr
   ykerjar7xdQlJsaZPq8hYqpvuTBzhQFZTGHzP8ywMxpZAhUT6PrwEuuM8
   hqDaKNAc3vur0EzVRosZv4e1fA7XkqkkXLslE4JbdBsS+K/6mDUmPqKSw
   NYZsuRZlhjr4Hb/5Ec/OvkaLqYR640iSjJWIt2KDXpmP+UFr/xdV0CefR
   Q==;
X-CSE-ConnectionGUID: n10vvN/IRQiaWapLHoE7kw==
X-CSE-MsgGUID: Wn/IEHQsSRivw4bExxMzKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27731345"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27731345"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 06:53:58 -0700
X-CSE-ConnectionGUID: OepCtk8BSBqZn+jWhFJcow==
X-CSE-MsgGUID: rUsaUtsnQwi9n0hTNGnyUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="99587864"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2024 06:53:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syX8T-0009I8-1B;
	Wed, 09 Oct 2024 13:53:53 +0000
Date: Wed, 09 Oct 2024 21:53:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 942b486a07f61edf985ba5c1be8c8f887cf8c5cc
Message-ID: <202410092124.0RRsFM9t-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 942b486a07f61edf985ba5c1be8c8f887cf8c5cc  Merge branch 'thermal-core-testing' into bleeding-edge

elapsed time: 1078m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          exynos_defconfig    gcc-14.1.0
arm                          gemini_defconfig    gcc-14.1.0
arm                        multi_v7_defconfig    gcc-14.1.0
arm                           sama5_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241009    clang-18
i386        buildonly-randconfig-002-20241009    clang-18
i386        buildonly-randconfig-003-20241009    clang-18
i386        buildonly-randconfig-004-20241009    clang-18
i386        buildonly-randconfig-005-20241009    clang-18
i386        buildonly-randconfig-006-20241009    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241009    clang-18
i386                  randconfig-002-20241009    clang-18
i386                  randconfig-003-20241009    clang-18
i386                  randconfig-004-20241009    clang-18
i386                  randconfig-005-20241009    clang-18
i386                  randconfig-006-20241009    clang-18
i386                  randconfig-011-20241009    clang-18
i386                  randconfig-012-20241009    clang-18
i386                  randconfig-013-20241009    clang-18
i386                  randconfig-014-20241009    clang-18
i386                  randconfig-015-20241009    clang-18
i386                  randconfig-016-20241009    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    gcc-14.1.0
mips                           ci20_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
mips                      malta_kvm_defconfig    gcc-14.1.0
mips                           rs90_defconfig    gcc-14.1.0
mips                           xway_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     rainier_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241009    clang-18
x86_64      buildonly-randconfig-002-20241009    clang-18
x86_64      buildonly-randconfig-003-20241009    clang-18
x86_64      buildonly-randconfig-004-20241009    clang-18
x86_64      buildonly-randconfig-005-20241009    clang-18
x86_64      buildonly-randconfig-006-20241009    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241009    clang-18
x86_64                randconfig-002-20241009    clang-18
x86_64                randconfig-003-20241009    clang-18
x86_64                randconfig-004-20241009    clang-18
x86_64                randconfig-005-20241009    clang-18
x86_64                randconfig-006-20241009    clang-18
x86_64                randconfig-011-20241009    clang-18
x86_64                randconfig-012-20241009    clang-18
x86_64                randconfig-013-20241009    clang-18
x86_64                randconfig-014-20241009    clang-18
x86_64                randconfig-015-20241009    clang-18
x86_64                randconfig-016-20241009    clang-18
x86_64                randconfig-071-20241009    clang-18
x86_64                randconfig-072-20241009    clang-18
x86_64                randconfig-073-20241009    clang-18
x86_64                randconfig-074-20241009    clang-18
x86_64                randconfig-075-20241009    clang-18
x86_64                randconfig-076-20241009    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

