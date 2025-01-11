Return-Path: <linux-acpi+bounces-10533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B29A0A639
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 23:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2432C1889DC6
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 22:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19061B87F0;
	Sat, 11 Jan 2025 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0xZP3Tm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192312E7E;
	Sat, 11 Jan 2025 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736634140; cv=none; b=kqczY5MIbTf2PpqW+XA+MWfM90tFs/WDMHmhAmlHl+aKdmhzMVj4n2XnuJwq3f7LNrIwdIzksutthCiAYDWCmKQRMRDaBLfoa6jOFyAK6L9kZG0zgky/ZAcVeCVS5pJI/1/Tbl799hdoEiEd4pDa0VRTYB5V3VDNDScskfJiJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736634140; c=relaxed/simple;
	bh=O96j7AKL7PEWjkKNF5fcMMhBh0Cs1QwGYZL6+0XmgE4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZiZ3NizLI56GEsC7ToLGSBNz6JvqPCDAa+1iqL/orFIkCIE7Njx9x1245+ZtqBhUu90FUjC4uziQvRuWksU4C3lbdO2LAOrZHgWmaOciHKg2OCyZGloIrpuZRSvk8TOh7BWXQ710O0V/aTZz0b+gxF5w/+GMtSVmz4zTiuhG4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0xZP3Tm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736634139; x=1768170139;
  h=date:from:to:cc:subject:message-id;
  bh=O96j7AKL7PEWjkKNF5fcMMhBh0Cs1QwGYZL6+0XmgE4=;
  b=b0xZP3TmMT9r84r1e6U+D+qz7MUMtpqP6tZAEQJTiYalCT5xvU7ChAB8
   CsrkKFO9MR5tZBxrfRJbPhq4ggb2OMfwTfJxjfnFKb8oPfr9urLeQoX+i
   SngSW7kI7peajZHNuOpELcheZ5VXIiNM3mr4FwsDIIvet41h7p5DovCxG
   N6JynQ7Kix88ZLVXwIq1+v6Ik1jnl9Fr69vLia0EU4r/4CbMhwBIJqvJY
   5wimib1GcPwBui2viflofIlQsgPQY+F7JJZ95Jtq8e8EZcwtEh+aEPZ8m
   eVgECkrKRz/iCDsNpG7GNw9PkSUopazrnChGSG0qqkdDMNi6nmNpWDFg5
   w==;
X-CSE-ConnectionGUID: masy0DeSRC2YK3fpPrJ7oQ==
X-CSE-MsgGUID: xVuA3QLWSRWyQcXjrJ04tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="36183957"
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="36183957"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 14:22:18 -0800
X-CSE-ConnectionGUID: ONN9iqWIRvOs3HhUp/KOLw==
X-CSE-MsgGUID: +Mi2ROGOS0G0NKnSgFUT5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108686280"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Jan 2025 14:22:17 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWjry-000LHB-2s;
	Sat, 11 Jan 2025 22:22:14 +0000
Date: Sun, 12 Jan 2025 06:21:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3a8ba95b37517b37574deba4d44615a96db68d3e
Message-ID: <202501120625.okHJ8IPr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3a8ba95b37517b37574deba4d44615a96db68d3e  Merge branch 'experimental/intel_pstate-testing' into bleeding-edge

elapsed time: 1465m

configs tested: 100
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20250111    gcc-13.2.0
arc                   randconfig-002-20250111    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                         bcm2835_defconfig    clang-16
arm                          moxart_defconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-20
arm                   randconfig-001-20250111    clang-16
arm                   randconfig-002-20250111    gcc-14.2.0
arm                   randconfig-003-20250111    clang-20
arm                   randconfig-004-20250111    clang-20
arm                          sp7021_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250111    gcc-14.2.0
arm64                 randconfig-002-20250111    clang-20
arm64                 randconfig-003-20250111    clang-18
arm64                 randconfig-004-20250111    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250111    gcc-14.2.0
csky                  randconfig-002-20250111    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250111    clang-20
hexagon               randconfig-002-20250111    clang-15
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250111    gcc-12
i386        buildonly-randconfig-002-20250111    gcc-11
i386        buildonly-randconfig-003-20250111    gcc-12
i386        buildonly-randconfig-004-20250111    gcc-12
i386        buildonly-randconfig-005-20250111    gcc-12
i386        buildonly-randconfig-006-20250111    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250111    gcc-14.2.0
loongarch             randconfig-002-20250111    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-20
mips                        bcm63xx_defconfig    clang-20
mips                        omega2p_defconfig    clang-16
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250111    gcc-14.2.0
nios2                 randconfig-002-20250111    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250111    gcc-14.2.0
parisc                randconfig-002-20250111    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc                     mpc5200_defconfig    clang-20
powerpc               randconfig-001-20250111    gcc-14.2.0
powerpc               randconfig-002-20250111    gcc-14.2.0
powerpc               randconfig-003-20250111    gcc-14.2.0
powerpc64             randconfig-001-20250111    gcc-14.2.0
powerpc64             randconfig-002-20250111    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250111    clang-18
riscv                 randconfig-002-20250111    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250111    clang-20
s390                  randconfig-002-20250111    clang-19
s390                       zfcpdump_defconfig    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250111    gcc-14.2.0
sh                    randconfig-002-20250111    gcc-14.2.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250111    gcc-14.2.0
sparc                 randconfig-002-20250111    gcc-14.2.0
sparc64               randconfig-001-20250111    gcc-14.2.0
sparc64               randconfig-002-20250111    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250111    clang-18
um                    randconfig-002-20250111    clang-20
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250111    clang-19
x86_64      buildonly-randconfig-002-20250111    gcc-12
x86_64      buildonly-randconfig-003-20250111    gcc-12
x86_64      buildonly-randconfig-004-20250111    clang-19
x86_64      buildonly-randconfig-005-20250111    gcc-12
x86_64      buildonly-randconfig-006-20250111    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250111    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

