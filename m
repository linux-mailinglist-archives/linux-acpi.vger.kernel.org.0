Return-Path: <linux-acpi+bounces-5438-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61858B45D3
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Apr 2024 13:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DAC1C20E65
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Apr 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0F4495CC;
	Sat, 27 Apr 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBI9HqBW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440C38DD3;
	Sat, 27 Apr 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216716; cv=none; b=A7+Zcu2zniqGwMmCxR1l9Xiq6P/AqZY1LNBBQl0hDRQ4BnxioDM7SS6a+ts/0Rv4/rU98zcZg8ZWQzxSZkWaDyTUXoMN3MCsF9gwpi/aP44aAzCPDkdq8kXBCUllrO+Id0l+iGxBPMc3J3snzKdxw3i8jR8BgWCBNBCA6Vvctf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216716; c=relaxed/simple;
	bh=gpiig6p7CrwW7Ycku4/uE8UG9sdW0uuDA9IW0G2i8W0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uPo8P/qVHp8W1cWFh007oDQ4Woh25R9jz7S9LMB7YcJ0BZz3MLlV0EN+KvlnEkoa5DiQz6nvLdK86Pq7miFL6QgaSuZzWg0MzqMKX8LR8MAuzSM+dZPfbIFzDz7qhehx25c1uP5lA5FzwWH4U8syRYVIRxcLHfX8LhP5kWjUTHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBI9HqBW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714216714; x=1745752714;
  h=date:from:to:cc:subject:message-id;
  bh=gpiig6p7CrwW7Ycku4/uE8UG9sdW0uuDA9IW0G2i8W0=;
  b=mBI9HqBWRgsLKCRQHZTroGjwm9QPT6jn3FIxDKhKIpAgGxe9s2RKm82B
   rpDvtFJlRx/qt3rZvl2y1QOXOuC/Ut95wWk8rircFs2af9rnKv3XXPq2p
   hkmR7dBc8305JZXJPRHJtUF5McCxnEkQnbK0FL0Jimow0qjeQ+oUszXsQ
   AognKGvisUrcl6aaiuc2E1Uz01B8YdUS4xGBVLy/e3j+nLTtHSvEM8vwf
   Bcg30VaeDTNtPgmpogoN+rD0SRbR+DJf7OsZKPMAxDp7eYU6ciGlbJmtf
   Ydm/jJ/B43KcTMFAiIkPvTN+m/hyz+DDYieC6aFb0mNKm50lPUalxiINW
   A==;
X-CSE-ConnectionGUID: 3uOlvIX/QGK8k7wGQN/I4A==
X-CSE-MsgGUID: LbYls7UwQCWoUKICOgsTYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9794383"
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="9794383"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 04:18:33 -0700
X-CSE-ConnectionGUID: ObdEVf9CR5iMNU/CB8IhJg==
X-CSE-MsgGUID: 1G8Np6kHSqek9V2pP2xcXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="26073806"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2024 04:18:31 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0g4b-0004vk-0I;
	Sat, 27 Apr 2024 11:18:29 +0000
Date: Sat, 27 Apr 2024 19:17:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 d9e98e7641ce1ef34d0c33dae1f27611bd1cbcf9
Message-ID: <202404271952.W1Qo7e0b-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d9e98e7641ce1ef34d0c33dae1f27611bd1cbcf9  Merge branch 'pm-cpufreq' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202404271038.em6nJjzy-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404271148.HK9yHBlB-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/cpufreq/amd-pstate.c:760: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/cpufreq/amd-pstate.c:791: warning: Function parameter or struct member 'cpudata' not described in 'amd_pstate_init_freq'
drivers/cpufreq/amd-pstate.c:828:47: warning: variable 'lowest_nonlinear_freq' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allmodconfig
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   |-- drivers-cpufreq-amd-pstate.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   |-- drivers-cpufreq-amd-pstate.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
|-- i386-buildonly-randconfig-002-20240427
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   |-- drivers-cpufreq-amd-pstate.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
|-- i386-randconfig-012-20240427
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
|-- x86_64-defconfig
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   |-- drivers-cpufreq-amd-pstate.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
`-- x86_64-randconfig-003-20240427
    |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
    `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
clang_recent_errors
|-- i386-defconfig
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   |-- drivers-cpufreq-amd-pstate.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
|-- i386-randconfig-063-20240427
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   |-- drivers-cpufreq-amd-pstate.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
|-- x86_64-allmodconfig
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   |-- drivers-cpufreq-amd-pstate.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
|-- x86_64-randconfig-101-20240427
|   |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
|   |-- drivers-cpufreq-amd-pstate.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used
`-- x86_64-rhel-8.3-rust
    |-- drivers-cpufreq-amd-pstate.c:warning:Function-parameter-or-struct-member-cpudata-not-described-in-amd_pstate_init_freq
    |-- drivers-cpufreq-amd-pstate.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    `-- drivers-cpufreq-amd-pstate.c:warning:variable-lowest_nonlinear_freq-set-but-not-used

elapsed time: 985m

configs tested: 178
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240427   gcc  
arc                   randconfig-002-20240427   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   clang
arm                   randconfig-001-20240427   clang
arm                   randconfig-002-20240427   clang
arm                   randconfig-003-20240427   gcc  
arm                   randconfig-004-20240427   clang
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240427   clang
arm64                 randconfig-002-20240427   clang
arm64                 randconfig-003-20240427   gcc  
arm64                 randconfig-004-20240427   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240427   gcc  
csky                  randconfig-002-20240427   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240427   clang
hexagon               randconfig-002-20240427   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240427   clang
i386         buildonly-randconfig-002-20240427   gcc  
i386         buildonly-randconfig-003-20240427   clang
i386         buildonly-randconfig-004-20240427   clang
i386         buildonly-randconfig-005-20240427   clang
i386         buildonly-randconfig-006-20240427   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240427   clang
i386                  randconfig-002-20240427   gcc  
i386                  randconfig-003-20240427   clang
i386                  randconfig-004-20240427   gcc  
i386                  randconfig-005-20240427   gcc  
i386                  randconfig-006-20240427   clang
i386                  randconfig-011-20240427   gcc  
i386                  randconfig-012-20240427   gcc  
i386                  randconfig-013-20240427   clang
i386                  randconfig-014-20240427   clang
i386                  randconfig-015-20240427   gcc  
i386                  randconfig-016-20240427   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240427   gcc  
loongarch             randconfig-002-20240427   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240427   gcc  
nios2                 randconfig-002-20240427   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240427   gcc  
parisc                randconfig-002-20240427   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                       maple_defconfig   clang
powerpc                      mgcoge_defconfig   clang
powerpc               randconfig-001-20240427   clang
powerpc               randconfig-002-20240427   clang
powerpc               randconfig-003-20240427   clang
powerpc64             randconfig-001-20240427   gcc  
powerpc64             randconfig-002-20240427   gcc  
powerpc64             randconfig-003-20240427   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240427   clang
riscv                 randconfig-002-20240427   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240427   gcc  
s390                  randconfig-002-20240427   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                    randconfig-001-20240427   gcc  
sh                    randconfig-002-20240427   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240427   gcc  
sparc64               randconfig-002-20240427   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240427   clang
um                    randconfig-002-20240427   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240427   clang
x86_64       buildonly-randconfig-002-20240427   clang
x86_64       buildonly-randconfig-003-20240427   gcc  
x86_64       buildonly-randconfig-004-20240427   clang
x86_64       buildonly-randconfig-005-20240427   clang
x86_64       buildonly-randconfig-006-20240427   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240427   clang
x86_64                randconfig-002-20240427   clang
x86_64                randconfig-003-20240427   gcc  
x86_64                randconfig-004-20240427   clang
x86_64                randconfig-005-20240427   gcc  
x86_64                randconfig-006-20240427   gcc  
x86_64                randconfig-011-20240427   gcc  
x86_64                randconfig-012-20240427   clang
x86_64                randconfig-013-20240427   clang
x86_64                randconfig-014-20240427   clang
x86_64                randconfig-015-20240427   gcc  
x86_64                randconfig-016-20240427   gcc  
x86_64                randconfig-071-20240427   gcc  
x86_64                randconfig-072-20240427   clang
x86_64                randconfig-073-20240427   clang
x86_64                randconfig-074-20240427   clang
x86_64                randconfig-075-20240427   clang
x86_64                randconfig-076-20240427   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240427   gcc  
xtensa                randconfig-002-20240427   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

