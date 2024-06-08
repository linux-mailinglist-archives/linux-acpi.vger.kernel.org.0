Return-Path: <linux-acpi+bounces-6276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE889012E1
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Jun 2024 19:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472D32828EF
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Jun 2024 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF521E4A6;
	Sat,  8 Jun 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRhcHzZp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996901EA67;
	Sat,  8 Jun 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717866138; cv=none; b=YoYYzhrS9DdGGtUSHZF+fm47LXPS+Us8UmI4pl6i2SpKM+HBmCC1s/+cRNQld+gNq19AkVaEkX7Yp9TMCNE7EvaXaoKjBsv63SCrCb7hyqeITww8rwq6cTHuxnUvFtuFDzUK2TlmgofS3Ig6RcJBVrIqhWrnhocaafm0yiOLOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717866138; c=relaxed/simple;
	bh=eZJtXYgzKJ03NKp+AX7YKQVkN/76dyMCDDFDfAawOwM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WyY+R/oJuZ09xZhPOhjm/IVv1hSqRQDf6Sq/7W9WkyIz4UTvnpSebSXuOBpftOJSWCCMl0EI+DyTfKdpDt0ouFwLnku5Bf0bqUfqz2a9+E9OKkuwoyoVzfP3FJ4kHXt8N1oMXHAp1qB5I6l7miw8rmXvAq3sYZLLIj74SlkI/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRhcHzZp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717866137; x=1749402137;
  h=date:from:to:cc:subject:message-id;
  bh=eZJtXYgzKJ03NKp+AX7YKQVkN/76dyMCDDFDfAawOwM=;
  b=PRhcHzZp9e2PogPqnsZdl0sCZdv/X8cHN6R1WyDmr/aSI+U7R1HOniOM
   KEip5qTs97Lma+ryHQ6g62fjc30/QUT0ZZckhre9RD6O9K0Ob0AUDZafI
   izVd0XnzzbJ3wCbq9lGOr06g/pPcYQ2E7b3EjyEVWHoI0m8XjtNXeQhF5
   Rk4MKUt99VibBI3CxVs/TLfKHutlYGgY3Vigp/T6hmikB+bEhFP3rEUP3
   bvh6r5K//Qav3F570xPkIGe7qFFMcKC02fjK0hYXfu+5AzlnAa5URk+KN
   vKpohiXaFaxziySfgtKh4D5kaVYdo6K4ZiOtlUGrk4kodIUqoNn2YKwRB
   g==;
X-CSE-ConnectionGUID: Og0G7R+vTu6sgwJOfzCw7w==
X-CSE-MsgGUID: Nue1PuqDT6iBliZRK9B5kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="14531605"
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="14531605"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 10:02:16 -0700
X-CSE-ConnectionGUID: EH1HrxCURSu71okqJWJjEg==
X-CSE-MsgGUID: /RC4otj3TnK9vM75Zj8muA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="38718165"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Jun 2024 10:02:08 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFzSA-0000Fo-0U;
	Sat, 08 Jun 2024 17:02:06 +0000
Date: Sun, 09 Jun 2024 01:01:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fd9fbb776ff6329fa87359a01d98f7d7949e7599
Message-ID: <202406090119.pVMonwQe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: fd9fbb776ff6329fa87359a01d98f7d7949e7599  Merge branch 'pm-tools' into bleeding-edge

elapsed time: 1237m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240608   gcc  
arc                   randconfig-002-20240608   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                       multi_v4t_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240608   gcc  
arm                   randconfig-002-20240608   clang
arm                   randconfig-003-20240608   clang
arm                   randconfig-004-20240608   clang
arm                           spitz_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240608   gcc  
arm64                 randconfig-002-20240608   gcc  
arm64                 randconfig-003-20240608   gcc  
arm64                 randconfig-004-20240608   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240608   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240608   gcc  
i386         buildonly-randconfig-002-20240608   clang
i386         buildonly-randconfig-003-20240608   gcc  
i386         buildonly-randconfig-004-20240608   gcc  
i386         buildonly-randconfig-005-20240608   clang
i386         buildonly-randconfig-006-20240608   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240608   clang
i386                  randconfig-002-20240608   gcc  
i386                  randconfig-003-20240608   gcc  
i386                  randconfig-004-20240608   clang
i386                  randconfig-005-20240608   gcc  
i386                  randconfig-006-20240608   gcc  
i386                  randconfig-011-20240608   clang
i386                  randconfig-012-20240608   clang
i386                  randconfig-013-20240608   clang
i386                  randconfig-014-20240608   gcc  
i386                  randconfig-015-20240608   clang
i386                  randconfig-016-20240608   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                     decstation_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

