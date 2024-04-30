Return-Path: <linux-acpi+bounces-5478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27168B6A15
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 07:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE771F22FB7
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 05:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44547175A7;
	Tue, 30 Apr 2024 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tzq9aENM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96617742;
	Tue, 30 Apr 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456516; cv=none; b=UwZAbUau7dkihwm8xFUxz4Z6YvtrgbU8/IPbFJuBJT5oJl+/RjmDHrVvjU28Mv+Wj8ds06lrXo8VkxIcMieO29QFswMM+ihiaEDaij+HEn7nEZgUI1ng+5rMZWEIDs2zuBeUQax/f5JCsRxsY+Epg3nn2RufdBXDzZoZ1S2EJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456516; c=relaxed/simple;
	bh=Ba1kSt+5JNsI61+Sn8ep10vXRbadut8twnYrmopZMQw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VhbfcJ5ij74pMVYLDZ9mgknwuPnzegDUc6FVYzghvPpphGRYLbjyeIwLREhMXq19Igy4tKdef2QkeR+wsdg3QhEusljqsMP/wn7hRWz2VTu6ASAYAd/La7h3Qla7q7wq2ilQdew+PqKZ/IRT9/i1/a+vmgdkU/NMYZq4tlojxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tzq9aENM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714456514; x=1745992514;
  h=date:from:to:cc:subject:message-id;
  bh=Ba1kSt+5JNsI61+Sn8ep10vXRbadut8twnYrmopZMQw=;
  b=Tzq9aENMrs6k1/ai0V1SLBipxXInaU+uwEapwiHiyahXIgbxgv+bmm3m
   PUSVjlPGMKKVJvWauYB5P6P6wtC3YnORIjjOQNQCuublz91UdYr/ZcrZ1
   v3TXYQF8NxD+7JmLrPy9FBWGPnxbSeMrrYb90KOc7kNTN0AbasRDzyEMe
   5ItkWFPAIIFXYiuWonrCgIpU61aTfok25mNcy1xK0FLRSJznqnACQ4sGW
   /fD+pLli39WWbQ9cYIr7nHYnsaCtEPsNlh8cQh8+ySvXjS9S61f/1fVaI
   a9hkgBiKJSbXH/l7oJnZ1lXGzpGjSF9VSnmB9q8DfeRL1UtecE+ZgqTub
   w==;
X-CSE-ConnectionGUID: WxOyqRWsSEWwBy1YM+HJUg==
X-CSE-MsgGUID: z0GOKvnWSdy55AF253nOlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10681193"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10681193"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 22:55:13 -0700
X-CSE-ConnectionGUID: Lf5e3fsEQZeiVTPhkCrbBw==
X-CSE-MsgGUID: YUx8C3adQrmylmAEZ6zUmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30799594"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2024 22:55:11 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1gSL-0007mu-0u;
	Tue, 30 Apr 2024 05:55:09 +0000
Date: Tue, 30 Apr 2024 13:54:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9b90da9c598279e774cc60068a24e2dc5abab26d
Message-ID: <202404301322.eclM87Sl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9b90da9c598279e774cc60068a24e2dc5abab26d  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 737m

configs tested: 155
configs skipped: 4

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
arc                   randconfig-001-20240430   gcc  
arc                   randconfig-002-20240430   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240430   clang
arm                   randconfig-002-20240430   clang
arm                   randconfig-003-20240430   clang
arm                   randconfig-004-20240430   clang
arm                             rpc_defconfig   clang
arm                       versatile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240430   clang
arm64                 randconfig-002-20240430   gcc  
arm64                 randconfig-003-20240430   clang
arm64                 randconfig-004-20240430   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240430   gcc  
csky                  randconfig-002-20240430   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240430   clang
hexagon               randconfig-002-20240430   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240430   gcc  
i386         buildonly-randconfig-002-20240430   clang
i386         buildonly-randconfig-003-20240430   gcc  
i386         buildonly-randconfig-004-20240430   clang
i386         buildonly-randconfig-005-20240430   clang
i386         buildonly-randconfig-006-20240430   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240430   clang
i386                  randconfig-002-20240430   gcc  
i386                  randconfig-003-20240430   gcc  
i386                  randconfig-004-20240430   gcc  
i386                  randconfig-005-20240430   gcc  
i386                  randconfig-006-20240430   gcc  
i386                  randconfig-011-20240430   gcc  
i386                  randconfig-012-20240430   clang
i386                  randconfig-013-20240430   clang
i386                  randconfig-014-20240430   gcc  
i386                  randconfig-015-20240430   gcc  
i386                  randconfig-016-20240430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240430   gcc  
loongarch             randconfig-002-20240430   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240430   gcc  
nios2                 randconfig-002-20240430   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240430   gcc  
parisc                randconfig-002-20240430   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                     kmeter1_defconfig   gcc  
powerpc                      mgcoge_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                      pasemi_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20240430   gcc  
powerpc               randconfig-002-20240430   gcc  
powerpc               randconfig-003-20240430   clang
powerpc                     stx_gp3_defconfig   clang
powerpc64             randconfig-001-20240430   clang
powerpc64             randconfig-002-20240430   clang
powerpc64             randconfig-003-20240430   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240430   gcc  
riscv                 randconfig-002-20240430   clang
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240430   gcc  
s390                  randconfig-002-20240430   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240430   gcc  
sh                    randconfig-002-20240430   gcc  
sh                           se7722_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240430   gcc  
sparc64               randconfig-002-20240430   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240430   clang
um                    randconfig-002-20240430   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240430   gcc  
xtensa                randconfig-002-20240430   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

