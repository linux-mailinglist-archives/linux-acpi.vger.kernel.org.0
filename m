Return-Path: <linux-acpi+bounces-9974-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C043F9E624E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 01:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968F4162343
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009F1DDF5;
	Fri,  6 Dec 2024 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsI4Q80k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D44C9A;
	Fri,  6 Dec 2024 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445262; cv=none; b=JSUqiSWDwFA3LF2CxprkH7tTRc8cGcxwjPaZUOmR51i/Q5sLrb6LuKNpBQwezMdwK9pEF/YQi4BKuugUlNw3jF7Xpo5MdHQIq4GnEsy48JPnzmEJpIiWufM8+8UgsVFzsKRhywnocqEPeN7ZrDLJ9/dhp7oXqvDx3e3oOCCRF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445262; c=relaxed/simple;
	bh=6j3WnygxaesB+X744Fs8q8o2v0Vz5ciq/joPGLwU69Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NZVhTzOKZQTQb5WmfkHloToZjDi+jX0Fp+I09o/niLVvoXJFaGlcjRE7siYiDM/nV+PSycxv8ePkGXBKtm3dmoAba6sL6JcvUY1rPF6hG9Yw03IkDVgVIj8RGxycO8hyEgh67Kwc16VtAnh3REjffpGuic6Ji9JnOyp3WdpOLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsI4Q80k; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733445261; x=1764981261;
  h=date:from:to:cc:subject:message-id;
  bh=6j3WnygxaesB+X744Fs8q8o2v0Vz5ciq/joPGLwU69Q=;
  b=OsI4Q80k165OJ8Q0R7KtHEP1Mp2vuGZRc9iPeeYgZ6qRCskr+giyrK3m
   FMSpoG9qABnZ2NBEtWLhI9PQ6BZo77axaEYCKHT2FjnIRtWYJ0RCJ87MH
   RsGewHp77lNEA4xTkj1NBcgbGGHZ6THfadUSuhgRjOxN3tlyAxQpX/5p1
   e5ufN716Q+P3diMYah7LzwZAcpgxjbm7bu1I7QhKods1Lt6UPHixqlizZ
   MVtlyobnxoZZgu6eP4cCjydP9jy0fAZYULL7bEx8lCpDAVGcvoevqPSHH
   +TfbtTA20Jw2H0h1Kx+W65Q/aAdpMaXQ8nE6P9PxTAUDQuZm28f2szcQb
   Q==;
X-CSE-ConnectionGUID: BcxQoWctQpS2kisNdPoYAQ==
X-CSE-MsgGUID: BCh6GUO0Rwy5qX1EzRMJSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="56269954"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="56269954"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:34:20 -0800
X-CSE-ConnectionGUID: rjDKojJ4TbCiPtjwqgz0hg==
X-CSE-MsgGUID: ZL0oxD4UQqqLKwSBo3KVNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94455206"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Dec 2024 16:34:18 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJMIS-0000Wx-0k;
	Fri, 06 Dec 2024 00:34:16 +0000
Date: Fri, 06 Dec 2024 08:30:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4e13aaa70332423fef1f18034070e35dd7faad04
Message-ID: <202412060847.SKBMDpUg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4e13aaa70332423fef1f18034070e35dd7faad04  Merge branch 'pm-sleep' into bleeding-edge

elapsed time: 728m

configs tested: 215
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                         haps_hs_defconfig    gcc-13.2.0
arc                        nsimosci_defconfig    clang-20
arc                            randconfig-001    clang-20
arc                   randconfig-001-20241205    clang-20
arc                   randconfig-001-20241206    gcc-14.2.0
arc                            randconfig-002    clang-20
arc                   randconfig-002-20241205    clang-20
arc                   randconfig-002-20241206    gcc-14.2.0
arc                           tb10x_defconfig    clang-20
arc                        vdk_hs38_defconfig    gcc-14.2.0
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    gcc-14.1.0
arm                          collie_defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    clang-20
arm                        keystone_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                        multi_v7_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.1.0
arm                           omap1_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                            randconfig-001    clang-20
arm                   randconfig-001-20241205    clang-20
arm                   randconfig-001-20241206    gcc-14.2.0
arm                            randconfig-002    clang-20
arm                   randconfig-002-20241205    clang-20
arm                   randconfig-002-20241206    gcc-14.2.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20241205    clang-20
arm                   randconfig-003-20241206    gcc-14.2.0
arm                            randconfig-004    clang-20
arm                   randconfig-004-20241205    clang-20
arm                   randconfig-004-20241206    gcc-14.2.0
arm                             rpc_defconfig    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    clang-20
arm                          sp7021_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm                           u8500_defconfig    gcc-13.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                          randconfig-001    clang-20
arm64                 randconfig-001-20241205    clang-20
arm64                 randconfig-001-20241206    gcc-14.2.0
arm64                          randconfig-002    clang-20
arm64                 randconfig-002-20241205    clang-20
arm64                 randconfig-002-20241206    gcc-14.2.0
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20241205    clang-20
arm64                 randconfig-003-20241206    gcc-14.2.0
arm64                          randconfig-004    clang-20
arm64                 randconfig-004-20241205    clang-20
arm64                 randconfig-004-20241206    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241206    clang-19
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241206    clang-19
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241206    clang-19
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241206    clang-19
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241206    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241206    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                           virt_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                          eyeq6_defconfig    clang-20
mips                           ip27_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    clang-20
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    clang-20
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc64                         alldefconfig    clang-20
parisc64                         alldefconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    gcc-13.2.0
powerpc                   currituck_defconfig    clang-20
powerpc                       ebony_defconfig    clang-18
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    clang-20
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-13.2.0
powerpc                       holly_defconfig    clang-20
powerpc                        icon_defconfig    clang-20
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-13.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    clang-18
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                     tqm8540_defconfig    clang-20
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc                     tqm8548_defconfig    clang-20
powerpc                     tqm8555_defconfig    clang-20
powerpc                     tqm8560_defconfig    clang-20
powerpc64                        alldefconfig    clang-18
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-13.2.0
riscv                    nommu_virt_defconfig    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    clang-18
sh                        dreamcast_defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-13.2.0
sh                         ecovec24_defconfig    clang-20
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.1.0
sh                          landisk_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    clang-18
sh                          rsk7269_defconfig    clang-18
sh                           se7206_defconfig    clang-20
sh                           se7343_defconfig    clang-20
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    clang-18
sh                           sh2007_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    clang-20
sh                             shx3_defconfig    clang-20
sh                             shx3_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                           x86_64_defconfig    gcc-13.2.0
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20241205    clang-19
x86_64      buildonly-randconfig-001-20241206    clang-19
x86_64               buildonly-randconfig-002    gcc-12
x86_64      buildonly-randconfig-002-20241205    clang-19
x86_64      buildonly-randconfig-002-20241206    clang-19
x86_64               buildonly-randconfig-003    gcc-12
x86_64      buildonly-randconfig-003-20241205    clang-19
x86_64      buildonly-randconfig-003-20241206    clang-19
x86_64               buildonly-randconfig-004    gcc-12
x86_64      buildonly-randconfig-004-20241205    clang-19
x86_64      buildonly-randconfig-004-20241206    clang-19
x86_64               buildonly-randconfig-005    gcc-12
x86_64      buildonly-randconfig-005-20241205    clang-19
x86_64      buildonly-randconfig-005-20241206    clang-19
x86_64               buildonly-randconfig-006    gcc-12
x86_64      buildonly-randconfig-006-20241205    clang-19
x86_64      buildonly-randconfig-006-20241206    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

