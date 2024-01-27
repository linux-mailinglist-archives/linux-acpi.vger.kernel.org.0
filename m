Return-Path: <linux-acpi+bounces-3056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D983F03B
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Jan 2024 22:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EEF2822BB
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Jan 2024 21:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F7B17BA3;
	Sat, 27 Jan 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="au1wYywQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35BB1B278;
	Sat, 27 Jan 2024 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706391740; cv=none; b=cO72eSfgUg36DhS+76TjkBjQOlhGojTq+dtUIfCOjLxYIbbeN6e4JbHI5CATvSaML7sp+uSnbuR7VgadK2a0VDFjQG4dUyYKfBBcvAOYwUq/UOc4QcRsZ7kqxNoZLX5eXdWGpYjPRhGO/QfPE8mMsPDWWFqS156hWM9gL/BA5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706391740; c=relaxed/simple;
	bh=bhrI/pn1Dhplyfh2u57/n3aJ8qBWmH32oEyqB8o4nTs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i0frkMgYMGrLjihuCVPMplKKZNbMvVYowgDL6OzIaqOgO804t0B7jEJ1dBAPy2P/jcfwWtrW5t+KfuAAWXltJqbL92lubztms7ChlW0K4K7yw8RwHdiGocdnRYKrmAIIdwixZcf0gElRp45GuYC+YVwaib9FikEVQdt/rCxLh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=au1wYywQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706391738; x=1737927738;
  h=date:from:to:cc:subject:message-id;
  bh=bhrI/pn1Dhplyfh2u57/n3aJ8qBWmH32oEyqB8o4nTs=;
  b=au1wYywQQGgRr/oAcKk/Devv39d28czAnOnx4iLytovy3LodIEDbVgXS
   z9wHsameaLlurwpvIfmE2druuJqJJqXdRmG1mrHFJ4XqLaiH1Hnl8NbOD
   Y3ztmDiLxeb3F7g6Ucxs/Yawhd18MoNsiiW9JYw4Lj8KT5SZqVVF/BVp+
   csHrIGiHcnIFN2liTN90vx8vSFR9TufdR5cHiKl3tvkrB7QM8tvCYpjF7
   yprGJnP4mcyzblnHTDTbWuzBu2GbU2aJ+oOSbrYDm7XSt9UAfymJe2c8J
   B2rrOJ5+hbGXkS9a/izlV3xJHrpJ1Bv3a9LLohwZoyrBd5luFD7JbPo1A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="10097580"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10097580"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 13:42:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3079639"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Jan 2024 13:42:03 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTqR6-0002ld-0A;
	Sat, 27 Jan 2024 21:42:00 +0000
Date: Sun, 28 Jan 2024 05:41:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 87a1cb515445f16607b157c5899aaaefb9ba283b
Message-ID: <202401280504.ySsIyRAv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 87a1cb515445f16607b157c5899aaaefb9ba283b  Merge branch 'pm-sleep' into bleeding-edge

elapsed time: 1588m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240128   gcc  
arc                   randconfig-002-20240128   gcc  
arm                               allnoconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240128   clang
arm                   randconfig-002-20240128   clang
arm                   randconfig-003-20240128   clang
arm                   randconfig-004-20240128   clang
arm                           tegra_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240128   clang
arm64                 randconfig-002-20240128   clang
arm64                 randconfig-003-20240128   clang
arm64                 randconfig-004-20240128   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240128   gcc  
csky                  randconfig-002-20240128   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240128   clang
hexagon               randconfig-002-20240128   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240127   gcc  
i386         buildonly-randconfig-002-20240127   gcc  
i386         buildonly-randconfig-003-20240127   gcc  
i386         buildonly-randconfig-004-20240127   gcc  
i386         buildonly-randconfig-005-20240127   gcc  
i386         buildonly-randconfig-006-20240127   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240127   gcc  
i386                  randconfig-002-20240127   gcc  
i386                  randconfig-003-20240127   gcc  
i386                  randconfig-004-20240127   gcc  
i386                  randconfig-005-20240127   gcc  
i386                  randconfig-006-20240127   gcc  
i386                  randconfig-011-20240127   clang
i386                  randconfig-012-20240127   clang
i386                  randconfig-013-20240127   clang
i386                  randconfig-014-20240127   clang
i386                  randconfig-015-20240127   clang
i386                  randconfig-016-20240127   clang
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240128   gcc  
loongarch             randconfig-002-20240128   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                         bigsur_defconfig   gcc  
nios2                 randconfig-001-20240128   gcc  
nios2                 randconfig-002-20240128   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240128   gcc  
parisc                randconfig-002-20240128   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc               randconfig-001-20240128   clang
powerpc               randconfig-002-20240128   clang
powerpc               randconfig-003-20240128   clang
powerpc                     skiroot_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240128   clang
x86_64       buildonly-randconfig-002-20240128   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

