Return-Path: <linux-acpi+bounces-7052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E197E93C088
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2024 13:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8A628292C
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2024 11:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB7A1991A1;
	Thu, 25 Jul 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAGtLHsE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3744132492;
	Thu, 25 Jul 2024 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905567; cv=none; b=Q6HSmAY4IIfatIBc+yn5bWCz3ho0C7LtLhvCOc29mjo+jT/VuQSkofTVv/ZP6c3zZ+ZjrSm5ecTDowtxnNbjPPYjp5yn+GqDQJp2unw0XXVVzIucT4x0S6pP9hZFfXXcqZSqPGZgJRS94fcuI6SlGrWXSyeefJiv3NBYubKy4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905567; c=relaxed/simple;
	bh=PPzcs5N7v3uNZG4pADM3LOHWnQeVCnk2C+mbKNhab/0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MtLFt5RYnH20oFpoPslrDYi8kv++2zm/byaz2G1/qGQIVxxi0uaskLsn1XmJs83lknVRb/ML1GWGhqjpFzkoCJ+yA5XVZJRe86DZNgmfVdw0Vxxn34oRKy6ZrLIqyvZ3iDJXvf9aE+oFwQZbkBet9U3Ugj0em+3djjdFowt7U/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAGtLHsE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721905565; x=1753441565;
  h=date:from:to:cc:subject:message-id;
  bh=PPzcs5N7v3uNZG4pADM3LOHWnQeVCnk2C+mbKNhab/0=;
  b=dAGtLHsEJ86KGbTJR7x8MQIX7VgeNxCTY/rtd8b/J4Bapy3FmL1WMfNh
   KPX6+qTP3VRpFA6oV2pUV1Y4OcWR5kqnMTlinVevitmsOXefXpJylbQiK
   JF3+JAE1cXkMRz7nhFIJvnhRF61gsN0oF4KhahwR+tgFjjwMlhSCvhwVB
   60125nQlelLIB4Df2FtiavBjlZQOmW4r21UBbMflVmIQkeIhlB+7tD9go
   8KH6JVhNFiII90lOEtEEgAbBZnIQfSBTDfjON5SJrbrIhT6l5i2m+IXLK
   4RgU2sTkpa6BycVzVjur5IWgVVX4uz0/JDa8QevvUNtscEYmhbgTEory7
   g==;
X-CSE-ConnectionGUID: s5u9u4pURpCbld9+5EpcgA==
X-CSE-MsgGUID: HqSfyLq4Q5WN/qrFxGUcVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30234777"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="30234777"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 04:06:04 -0700
X-CSE-ConnectionGUID: 8vzYhU+hS4KCnFGdQMRkGA==
X-CSE-MsgGUID: 7B/BawCdS9eC5TRZODnHgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="58027321"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Jul 2024 04:06:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWwIJ-000o2E-2L;
	Thu, 25 Jul 2024 11:05:59 +0000
Date: Thu, 25 Jul 2024 19:05:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d138ebca836ae9753a88fe6824bcbfeed2f4aef0
Message-ID: <202407251959.lUGb7G6q-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d138ebca836ae9753a88fe6824bcbfeed2f4aef0  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 1455m

configs tested: 175
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240724   gcc-13.2.0
arc                   randconfig-002-20240724   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g5_defconfig   gcc-14.1.0
arm                     davinci_all_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-14.1.0
arm                   randconfig-001-20240724   gcc-13.2.0
arm                   randconfig-002-20240724   gcc-13.2.0
arm                   randconfig-003-20240724   gcc-13.2.0
arm                   randconfig-004-20240724   gcc-13.2.0
arm                       spear13xx_defconfig   gcc-14.1.0
arm                           spitz_defconfig   gcc-14.1.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240724   gcc-13.2.0
arm64                 randconfig-002-20240724   gcc-13.2.0
arm64                 randconfig-003-20240724   gcc-13.2.0
arm64                 randconfig-004-20240724   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240724   gcc-13.2.0
csky                  randconfig-002-20240724   gcc-13.2.0
hexagon                           allnoconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240724   clang-18
i386         buildonly-randconfig-002-20240724   clang-18
i386         buildonly-randconfig-002-20240724   gcc-9
i386         buildonly-randconfig-003-20240724   clang-18
i386         buildonly-randconfig-004-20240724   clang-18
i386         buildonly-randconfig-005-20240724   clang-18
i386         buildonly-randconfig-006-20240724   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240724   clang-18
i386                  randconfig-002-20240724   clang-18
i386                  randconfig-003-20240724   clang-18
i386                  randconfig-004-20240724   clang-18
i386                  randconfig-004-20240724   gcc-9
i386                  randconfig-005-20240724   clang-18
i386                  randconfig-006-20240724   clang-18
i386                  randconfig-011-20240724   clang-18
i386                  randconfig-011-20240724   gcc-13
i386                  randconfig-012-20240724   clang-18
i386                  randconfig-013-20240724   clang-18
i386                  randconfig-013-20240724   gcc-13
i386                  randconfig-014-20240724   clang-18
i386                  randconfig-014-20240724   gcc-8
i386                  randconfig-015-20240724   clang-18
i386                  randconfig-015-20240724   gcc-13
i386                  randconfig-016-20240724   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240724   gcc-13.2.0
loongarch             randconfig-002-20240724   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-14.1.0
mips                      pic32mzda_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240724   gcc-13.2.0
nios2                 randconfig-002-20240724   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240724   gcc-13.2.0
parisc                randconfig-002-20240724   gcc-13.2.0
parisc64                         alldefconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                     ksi8560_defconfig   gcc-14.1.0
powerpc                 mpc837x_rdb_defconfig   gcc-14.1.0
powerpc                      pmac32_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240724   gcc-13.2.0
powerpc               randconfig-002-20240724   gcc-13.2.0
powerpc               randconfig-003-20240724   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-14.1.0
powerpc                     tqm8560_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240724   gcc-13.2.0
powerpc64             randconfig-002-20240724   gcc-13.2.0
powerpc64             randconfig-003-20240724   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240724   gcc-13.2.0
riscv                 randconfig-002-20240724   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240724   gcc-13.2.0
s390                  randconfig-002-20240724   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                            migor_defconfig   gcc-14.1.0
sh                    randconfig-001-20240724   gcc-13.2.0
sh                    randconfig-002-20240724   gcc-13.2.0
sh                        sh7763rdp_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240724   gcc-13.2.0
sparc64               randconfig-002-20240724   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240724   gcc-13.2.0
um                    randconfig-002-20240724   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240724   clang-18
x86_64       buildonly-randconfig-002-20240724   clang-18
x86_64       buildonly-randconfig-003-20240724   clang-18
x86_64       buildonly-randconfig-004-20240724   clang-18
x86_64       buildonly-randconfig-005-20240724   clang-18
x86_64       buildonly-randconfig-006-20240724   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240724   clang-18
x86_64                randconfig-002-20240724   clang-18
x86_64                randconfig-003-20240724   clang-18
x86_64                randconfig-004-20240724   clang-18
x86_64                randconfig-005-20240724   clang-18
x86_64                randconfig-006-20240724   clang-18
x86_64                randconfig-011-20240724   clang-18
x86_64                randconfig-012-20240724   clang-18
x86_64                randconfig-013-20240724   clang-18
x86_64                randconfig-014-20240724   clang-18
x86_64                randconfig-015-20240724   clang-18
x86_64                randconfig-016-20240724   clang-18
x86_64                randconfig-071-20240724   clang-18
x86_64                randconfig-072-20240724   clang-18
x86_64                randconfig-073-20240724   clang-18
x86_64                randconfig-074-20240724   clang-18
x86_64                randconfig-075-20240724   clang-18
x86_64                randconfig-076-20240724   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240724   gcc-13.2.0
xtensa                randconfig-002-20240724   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

