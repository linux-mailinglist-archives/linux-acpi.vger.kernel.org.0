Return-Path: <linux-acpi+bounces-13905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B4AC45B5
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 02:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CD4188BA67
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 00:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E0101C8;
	Tue, 27 May 2025 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5K8l/FG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB74A28;
	Tue, 27 May 2025 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748306224; cv=none; b=XLZR293g/uUL7P7shqNTTesRNVrx8y8uuIU5TK/YiOlBdFMzmfdcydIICC3FqXUifQr9KfL0FOfLOazv1i0318wMu0OKvbYXs14Ar46WwMwEVkG0mMyf+CoJImwU9jxQVWqaD4CNqOnTUOcTcLHdNUPyNZVMqqaaEJWsxDlfZ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748306224; c=relaxed/simple;
	bh=P+qd8Qut1BxhSqmuaCew79qWqpC+lPzXyZD0Z573oKU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QofueL6kcfYsuD15tyMGEKMZTfLAggCx5KrBbCQeUpEOzV+R9e8nUWmsqXoAf5fsyibl2Pl6zyMGEk0frkCGDe8/8hx2LaU2Rku7KyiCvQc0PxtxWqaLim1AeFLQoADbAWZC2hvBn4UC6eOvQA4hNSTVPrv0IS1fC/r7hz+gwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5K8l/FG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748306222; x=1779842222;
  h=date:from:to:cc:subject:message-id;
  bh=P+qd8Qut1BxhSqmuaCew79qWqpC+lPzXyZD0Z573oKU=;
  b=E5K8l/FGX7l6k2ydXvjNo4PFgtk0A+KcuGHYTwrK6xMg28yf+jcvcAEC
   AGfzsZnsCLrlpXV2zfodeAbJuam/4ygo1rI67WMqPP1e6Byrz9wOVDcaJ
   X71dFV/7xwxKAhjsacDfh6KyNGPEqOZVBBoY4vBxQx8gC7FSXtfvs3sBe
   9usFEj2HFITpP0QUs+2ek7Dk4SVNG70DyovrVXVrnQWr46ISYQbY4gZcg
   7fJytvWSyjpFK3GL49WZIPE0nr5ahpJcy0u/j7c2U3QQQekD9Be/cd9Hi
   AoFcio7exZsP+9B/MPpnG+/t2v7fVSqAiPli5KHOKngnk9ji8Z+UpJ6N+
   g==;
X-CSE-ConnectionGUID: QtcxwmiWTf2K11pxEkMkuw==
X-CSE-MsgGUID: D0KlduUCQhy7uvUFFlcygA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="61687695"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="61687695"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 17:37:01 -0700
X-CSE-ConnectionGUID: nPuSPAZ1QNKWXaMYo7BVCA==
X-CSE-MsgGUID: v+tEVVONSlyU5KNQwPLqzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="179753978"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 May 2025 17:37:00 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJiJN-000SlQ-2c;
	Tue, 27 May 2025 00:36:57 +0000
Date: Tue, 27 May 2025 08:36:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3ac905182f05b09af77ce635f284d3e067f6a2c2
Message-ID: <202505270801.E9Ezp8cW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3ac905182f05b09af77ce635f284d3e067f6a2c2  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 801m

configs tested: 136
configs skipped: 7

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
arc                   randconfig-001-20250526    gcc-15.1.0
arc                   randconfig-002-20250526    gcc-15.1.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                      footbridge_defconfig    clang-17
arm                         orion5x_defconfig    clang-21
arm                   randconfig-001-20250526    gcc-6.5.0
arm                   randconfig-002-20250526    clang-21
arm                   randconfig-003-20250526    gcc-7.5.0
arm                   randconfig-004-20250526    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250526    clang-21
arm64                 randconfig-002-20250526    clang-19
arm64                 randconfig-003-20250526    clang-20
arm64                 randconfig-004-20250526    gcc-5.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250526    gcc-9.3.0
csky                  randconfig-002-20250526    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250526    clang-19
hexagon               randconfig-002-20250526    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250526    gcc-12
i386        buildonly-randconfig-002-20250526    clang-20
i386        buildonly-randconfig-003-20250526    clang-20
i386        buildonly-randconfig-004-20250526    gcc-12
i386        buildonly-randconfig-005-20250526    clang-20
i386        buildonly-randconfig-006-20250526    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250526    gcc-15.1.0
loongarch             randconfig-002-20250526    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
mips                        qi_lb60_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250526    gcc-5.5.0
nios2                 randconfig-002-20250526    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250526    gcc-6.5.0
parisc                randconfig-002-20250526    gcc-8.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-21
powerpc               randconfig-001-20250526    clang-21
powerpc               randconfig-002-20250526    clang-18
powerpc               randconfig-003-20250526    clang-21
powerpc                     stx_gp3_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250526    gcc-7.5.0
powerpc64             randconfig-002-20250526    gcc-7.5.0
powerpc64             randconfig-003-20250526    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250526    clang-21
riscv                 randconfig-002-20250526    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250526    clang-18
s390                  randconfig-002-20250526    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250526    gcc-11.5.0
sh                    randconfig-002-20250526    gcc-7.5.0
sh                           se7780_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250526    gcc-14.2.0
sparc                 randconfig-002-20250526    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250526    gcc-14.2.0
sparc64               randconfig-002-20250526    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250526    clang-21
um                    randconfig-002-20250526    gcc-12
um                           x86_64_defconfig    clang-21
x86_64      buildonly-randconfig-001-20250526    gcc-12
x86_64      buildonly-randconfig-002-20250526    gcc-12
x86_64      buildonly-randconfig-003-20250526    clang-20
x86_64      buildonly-randconfig-004-20250526    gcc-12
x86_64      buildonly-randconfig-005-20250526    gcc-12
x86_64      buildonly-randconfig-006-20250526    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250526    gcc-12.4.0
xtensa                randconfig-002-20250526    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

