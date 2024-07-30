Return-Path: <linux-acpi+bounces-7120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC61940937
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 09:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56C6282E18
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68019007A;
	Tue, 30 Jul 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASowlKQl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5218FC9A;
	Tue, 30 Jul 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323611; cv=none; b=MySW6KZo6w2kGcfZ62/ZPCBbpOBi4RvbsMFYxz+LKKhI+eYjkMNrnJD5+5HZhNhGl4ThiiBJcLopzsMnpJBfHECI6qTVFsf0jTWbJMok6SDee56oL+NvPJbebONekSTQz322Vwg86Zo2HvvM4zbWYMwZpv/LMthpxNhNNue1EME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323611; c=relaxed/simple;
	bh=ZXSJnaiDOLYwKSPGpvYw0eQcCUwbnCAuA13/la0NwJo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PNgMU5kmtUOJhHzAwqgNsAN9NGpVV5ayzcjI0ReHaGwChUW1lou6nlQhmzP0N6ssVLyJ3XntIWBWN/jyPH0Pw0k52mSOAH+aGamgj5cugnGXYvT1TojSkaFgQpyx5PcA2a04BP/p5T9jHSU7KvsfGera9R5U3ON7U3RxnbgfIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASowlKQl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722323609; x=1753859609;
  h=date:from:to:cc:subject:message-id;
  bh=ZXSJnaiDOLYwKSPGpvYw0eQcCUwbnCAuA13/la0NwJo=;
  b=ASowlKQlfVvQPka7s2nxmAru5uM4TdbQOWPfci9wW9Ptn+GNUCaCBHu8
   iYx//klGqgexTXFyIzQW9+q9jq+5w42Fdks+vuxzhbnKgSK/h9tZScnHv
   6oHxIH6OsMZh/SSRdnNHlXkLOPF4LCIvPY9cphkCnosKA/JR/TQTB1BVz
   6lBouKD0+GU4pKLNGgkt+eZDcEuynkSTx8STmkGBOhR+Q0KcfsJVgBnR/
   yidhgYvrLPmvMscPq6nzTANlgSa5QjXzoNpaVN87s4MA0dwVxWBpAWGdk
   1BOlVaovJMNRSMRrlMt+mY0fY3C53VKUFxd3uhWinqjmc6NVC8GS8Tgug
   g==;
X-CSE-ConnectionGUID: kGqdJgROS2qdAyp/Qc0u/A==
X-CSE-MsgGUID: HlJlPS5RS9q/oQcjSegBhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19920914"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="19920914"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 00:13:28 -0700
X-CSE-ConnectionGUID: lrikJOL2SuqmQfNr2e/lIA==
X-CSE-MsgGUID: kHSvAakoRiS7wNm10i7AHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="77473603"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jul 2024 00:13:27 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYh2y-000sbG-3B;
	Tue, 30 Jul 2024 07:13:24 +0000
Date: Tue, 30 Jul 2024 15:12:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fc9143fe3439b74733b2030b83ebbf9dcb9f5f3d
Message-ID: <202407301528.EVsggzPx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: fc9143fe3439b74733b2030b83ebbf9dcb9f5f3d  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

Warning ids grouped by kconfigs:

recent_errors
`-- arm64-randconfig-051-20240729
    |-- arch-arm64-boot-dts-freescale-imx8mq-evk.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-hummingboard-pulse.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-kontron-pitx-imx8m.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-librem5-devkit.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-librem5-r2.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-librem5-r3.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-librem5-r4.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-mnt-reform2.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-nitrogen.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-phanbell.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-pico-pi.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-thor96.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-tqma8mq-mba8mx.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-zii-ultra-rmb3.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx8mq-zii-ultra-zest.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-imx8mq-tmu
    |-- arch-arm64-boot-dts-freescale-imx93-11x11-evk.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    |-- arch-arm64-boot-dts-freescale-imx93-9x9-qsb.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    |-- arch-arm64-boot-dts-freescale-imx93-phyboard-segin.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    |-- arch-arm64-boot-dts-freescale-imx93-tqma9352-mba93xxca.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    |-- arch-arm64-boot-dts-freescale-imx93-tqma9352-mba93xxla.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    `-- arch-arm64-boot-dts-freescale-imx93-var-som-symphony.dtb:soc-bus-tmu:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu

elapsed time: 1165m

configs tested: 214
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.3.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240730   gcc-13.2.0
arc                   randconfig-002-20240730   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.3.0
arm                            hisi_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.3.0
arm                        keystone_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.3.0
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240730   gcc-13.2.0
arm                   randconfig-002-20240730   gcc-13.2.0
arm                   randconfig-003-20240730   gcc-13.2.0
arm                   randconfig-004-20240730   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.3.0
arm                       spear13xx_defconfig   gcc-13.3.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240730   gcc-13.2.0
arm64                 randconfig-002-20240730   gcc-13.2.0
arm64                 randconfig-003-20240730   gcc-13.2.0
arm64                 randconfig-004-20240730   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240730   gcc-13.2.0
csky                  randconfig-002-20240730   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240729   clang-18
i386         buildonly-randconfig-001-20240730   gcc-13
i386         buildonly-randconfig-002-20240729   gcc-13
i386         buildonly-randconfig-002-20240730   gcc-13
i386         buildonly-randconfig-003-20240729   clang-18
i386         buildonly-randconfig-003-20240730   gcc-13
i386         buildonly-randconfig-004-20240729   gcc-10
i386         buildonly-randconfig-004-20240730   gcc-13
i386         buildonly-randconfig-005-20240729   clang-18
i386         buildonly-randconfig-005-20240730   gcc-13
i386         buildonly-randconfig-006-20240729   gcc-8
i386         buildonly-randconfig-006-20240730   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240729   gcc-12
i386                  randconfig-001-20240730   gcc-13
i386                  randconfig-002-20240729   clang-18
i386                  randconfig-002-20240730   gcc-13
i386                  randconfig-003-20240729   gcc-10
i386                  randconfig-003-20240730   gcc-13
i386                  randconfig-004-20240729   gcc-13
i386                  randconfig-004-20240730   gcc-13
i386                  randconfig-005-20240729   gcc-8
i386                  randconfig-005-20240730   gcc-13
i386                  randconfig-006-20240729   gcc-13
i386                  randconfig-006-20240730   gcc-13
i386                  randconfig-011-20240729   gcc-13
i386                  randconfig-011-20240730   gcc-13
i386                  randconfig-012-20240729   clang-18
i386                  randconfig-012-20240730   gcc-13
i386                  randconfig-013-20240729   gcc-9
i386                  randconfig-013-20240730   gcc-13
i386                  randconfig-014-20240729   clang-18
i386                  randconfig-014-20240730   gcc-13
i386                  randconfig-015-20240729   gcc-13
i386                  randconfig-015-20240730   gcc-13
i386                  randconfig-016-20240729   clang-18
i386                  randconfig-016-20240730   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240730   gcc-13.2.0
loongarch             randconfig-002-20240730   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.3.0
nios2                         10m50_defconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240730   gcc-13.2.0
nios2                 randconfig-002-20240730   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.3.0
parisc                randconfig-001-20240730   gcc-13.2.0
parisc                randconfig-002-20240730   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                       eiger_defconfig   gcc-13.3.0
powerpc                 mpc834x_itx_defconfig   gcc-13.3.0
powerpc                     rainier_defconfig   gcc-13.3.0
powerpc               randconfig-002-20240730   gcc-13.2.0
powerpc               randconfig-003-20240730   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-13.3.0
powerpc                     tqm8541_defconfig   gcc-13.3.0
powerpc64             randconfig-001-20240730   gcc-13.2.0
powerpc64             randconfig-002-20240730   gcc-13.2.0
powerpc64             randconfig-003-20240730   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240730   gcc-13.2.0
riscv                 randconfig-002-20240730   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240730   gcc-13.2.0
s390                  randconfig-002-20240730   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240730   gcc-13.2.0
sh                    randconfig-002-20240730   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.3.0
sh                           se7721_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240730   gcc-13.2.0
sparc64               randconfig-002-20240730   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240730   gcc-13.2.0
um                    randconfig-002-20240730   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240730   clang-18
x86_64       buildonly-randconfig-002-20240730   clang-18
x86_64       buildonly-randconfig-003-20240730   clang-18
x86_64       buildonly-randconfig-004-20240730   clang-18
x86_64       buildonly-randconfig-005-20240730   clang-18
x86_64       buildonly-randconfig-006-20240730   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240730   clang-18
x86_64                randconfig-002-20240730   clang-18
x86_64                randconfig-003-20240730   clang-18
x86_64                randconfig-004-20240730   clang-18
x86_64                randconfig-005-20240730   clang-18
x86_64                randconfig-006-20240730   clang-18
x86_64                randconfig-011-20240730   clang-18
x86_64                randconfig-012-20240730   clang-18
x86_64                randconfig-013-20240730   clang-18
x86_64                randconfig-014-20240730   clang-18
x86_64                randconfig-015-20240730   clang-18
x86_64                randconfig-016-20240730   clang-18
x86_64                randconfig-071-20240730   clang-18
x86_64                randconfig-072-20240730   clang-18
x86_64                randconfig-073-20240730   clang-18
x86_64                randconfig-074-20240730   clang-18
x86_64                randconfig-075-20240730   clang-18
x86_64                randconfig-076-20240730   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240730   gcc-13.2.0
xtensa                randconfig-002-20240730   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

