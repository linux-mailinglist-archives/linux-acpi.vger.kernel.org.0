Return-Path: <linux-acpi+bounces-6017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9546A8D1331
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 06:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5CBDB20FCA
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 04:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80129168B1;
	Tue, 28 May 2024 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1fijX/q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2E17E8E4;
	Tue, 28 May 2024 04:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869110; cv=none; b=IOpqaz+oMGAD5Sns8LfYqaokxtqRGRgDtftHN67RglFenS9oy2Pk0DquugW5aj0165a98laPlUzK+gdiNYXRuIM7OLdH/bfurATjzc5gCE3BxQC/lvTyVH9vUNIl4B/XKPEi5AY9YJZ7Ar5r243zsfMXqtIYMXWU4FOzxRURGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869110; c=relaxed/simple;
	bh=Y41f4kf96vNZg88D5SiZsYMGRrCo34H0neH1dBHxoVQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qHJJUSPpz1IQGfpHHZvejgZ4T8gjlOREV0aRdBuiG60rjWgzb8erBFOyzNejBDvNmBAh3LbItT1Fp157VhC5Tk7YtolHkF2aYsGSCGq+M/9dnS5y/0ipgef7CI2cHLHXKVFouW+A8sRHxmybdxbk4517x6aIfGcu9BYpXaBeTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1fijX/q; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716869108; x=1748405108;
  h=date:from:to:cc:subject:message-id;
  bh=Y41f4kf96vNZg88D5SiZsYMGRrCo34H0neH1dBHxoVQ=;
  b=n1fijX/qB1d5mSfOIGtTheae2FBYLJgQ6ErGFV4cR2kmokhnRTguNsW+
   T5TxJxDUZHDMCtSL4TnnRNzB9bd+nFliTzdNSJqtxwGX+rmSdnQbKzdX2
   MmddwQgzsYcgXTlhjaNe3wRA/JtS+fD67fBcZxA31zU9zgfg/TkQJ7qOa
   tQ4QFhzZKNHvVN8f4z7u/ZCusDD+R3f8L0Fj0HzpCBSrzWpGeQ1ZO/vou
   2gynVdItLbkKgDi4Efxy4xquXh5Kr/UeMIG3VpBkVlL0y0uCIUAr+U5hT
   V1GsKOqt2R40YpI/CIbQehxpDcWuqrB40Byiyc6mPzIHLcDHJv50AfB3w
   w==;
X-CSE-ConnectionGUID: 4UQragtCR7CVh2+mBSDjDQ==
X-CSE-MsgGUID: cOIUiJcNQcyAln0QOht2qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17024671"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="17024671"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:05:07 -0700
X-CSE-ConnectionGUID: 6K60uMJHSjKd6WcFcktZCA==
X-CSE-MsgGUID: L7nxAquOReecNCReRAmASg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34848721"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 May 2024 21:05:05 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBo59-000BRt-21;
	Tue, 28 May 2024 04:05:03 +0000
Date: Tue, 28 May 2024 12:04:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 cc66adc7cf7b30134d6675c7d89237ad7204d3c1
Message-ID: <202405281226.13BY9Pyf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: cc66adc7cf7b30134d6675c7d89237ad7204d3c1  Merge branch 'thermal-core' into bleeding-edge

elapsed time: 977m

configs tested: 204
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
arc                   randconfig-001-20240527   gcc  
arc                   randconfig-001-20240528   gcc  
arc                   randconfig-002-20240527   gcc  
arc                   randconfig-002-20240528   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240527   clang
arm                   randconfig-001-20240528   gcc  
arm                   randconfig-002-20240527   gcc  
arm                   randconfig-002-20240528   gcc  
arm                   randconfig-003-20240527   gcc  
arm                   randconfig-003-20240528   clang
arm                   randconfig-004-20240527   gcc  
arm                   randconfig-004-20240528   clang
arm                         s5pv210_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm                       versatile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240527   gcc  
arm64                 randconfig-001-20240528   clang
arm64                 randconfig-002-20240527   gcc  
arm64                 randconfig-002-20240528   clang
arm64                 randconfig-003-20240527   clang
arm64                 randconfig-003-20240528   gcc  
arm64                 randconfig-004-20240527   gcc  
arm64                 randconfig-004-20240528   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240527   gcc  
csky                  randconfig-001-20240528   gcc  
csky                  randconfig-002-20240527   gcc  
csky                  randconfig-002-20240528   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240527   clang
hexagon               randconfig-001-20240528   clang
hexagon               randconfig-002-20240527   clang
hexagon               randconfig-002-20240528   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240527   gcc  
i386         buildonly-randconfig-002-20240527   gcc  
i386         buildonly-randconfig-003-20240527   gcc  
i386         buildonly-randconfig-004-20240527   clang
i386         buildonly-randconfig-005-20240527   gcc  
i386         buildonly-randconfig-006-20240527   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240527   gcc  
i386                  randconfig-002-20240527   clang
i386                  randconfig-003-20240527   gcc  
i386                  randconfig-004-20240527   gcc  
i386                  randconfig-005-20240527   gcc  
i386                  randconfig-006-20240527   gcc  
i386                  randconfig-011-20240527   gcc  
i386                  randconfig-012-20240527   clang
i386                  randconfig-013-20240527   gcc  
i386                  randconfig-014-20240527   clang
i386                  randconfig-015-20240527   gcc  
i386                  randconfig-016-20240527   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240527   gcc  
loongarch             randconfig-001-20240528   gcc  
loongarch             randconfig-002-20240527   gcc  
loongarch             randconfig-002-20240528   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240527   gcc  
nios2                 randconfig-001-20240528   gcc  
nios2                 randconfig-002-20240527   gcc  
nios2                 randconfig-002-20240528   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240527   gcc  
parisc                randconfig-001-20240528   gcc  
parisc                randconfig-002-20240527   gcc  
parisc                randconfig-002-20240528   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc               randconfig-001-20240527   gcc  
powerpc               randconfig-001-20240528   gcc  
powerpc               randconfig-002-20240527   gcc  
powerpc               randconfig-002-20240528   clang
powerpc               randconfig-003-20240527   clang
powerpc               randconfig-003-20240528   clang
powerpc64             randconfig-001-20240527   clang
powerpc64             randconfig-001-20240528   clang
powerpc64             randconfig-002-20240527   gcc  
powerpc64             randconfig-002-20240528   gcc  
powerpc64             randconfig-003-20240527   gcc  
powerpc64             randconfig-003-20240528   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240528   clang
riscv                 randconfig-002-20240528   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240528   gcc  
s390                  randconfig-002-20240528   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240528   gcc  
sh                    randconfig-002-20240528   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240528   gcc  
sparc64               randconfig-002-20240528   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240528   gcc  
um                    randconfig-002-20240528   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240527   clang
x86_64       buildonly-randconfig-002-20240527   gcc  
x86_64       buildonly-randconfig-003-20240527   gcc  
x86_64       buildonly-randconfig-004-20240527   gcc  
x86_64       buildonly-randconfig-005-20240527   gcc  
x86_64       buildonly-randconfig-006-20240527   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240527   clang
x86_64                randconfig-002-20240527   gcc  
x86_64                randconfig-003-20240527   clang
x86_64                randconfig-004-20240527   clang
x86_64                randconfig-005-20240527   clang
x86_64                randconfig-006-20240527   clang
x86_64                randconfig-011-20240527   gcc  
x86_64                randconfig-012-20240527   gcc  
x86_64                randconfig-013-20240527   clang
x86_64                randconfig-014-20240527   gcc  
x86_64                randconfig-015-20240527   gcc  
x86_64                randconfig-016-20240527   gcc  
x86_64                randconfig-071-20240527   gcc  
x86_64                randconfig-072-20240527   clang
x86_64                randconfig-073-20240527   clang
x86_64                randconfig-074-20240527   clang
x86_64                randconfig-075-20240527   clang
x86_64                randconfig-076-20240527   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240528   gcc  
xtensa                randconfig-002-20240528   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

