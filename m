Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0949C4F3
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jan 2022 09:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiAZILn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jan 2022 03:11:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:20228 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbiAZILm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jan 2022 03:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643184702; x=1674720702;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+0CNHvxudF+drdCVHIQmeiLO4y31a0s8hhTTtm7SUQA=;
  b=X3FqtR4A8+8ocmKyfcsS1AbzP14FBX2x9t4BXccaex7rf1KnIq9mnbpV
   DH8id8ZQNAsb2F+judgnWt8VooN8uvEibBFr1iybzld5/FvBfv4VzaS5z
   BcZYjyzXTfLM4dAoei2w/eKrg4bN0d3ZfcTnPlogSsuChDsSjT2wG28CS
   JbJU4rVUJRCfulbIu3hJYBpfIUQTvs4kXOwYVpd8QMKbiV2wOQ0okG/3K
   ZKqg+vXZefhpM7O3t5XLwz3kaHmHZoR19RSEKCbPU7J90aTC/AmSRQHLP
   JvSROxOgXxXmOBOqvNB4eB1hwp28aEjeIP0P/4gME+VGeVm2ZAxAUK6M2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244101724"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="244101724"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:11:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="563339697"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2022 00:11:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCdP0-000KyW-Rr; Wed, 26 Jan 2022 08:11:38 +0000
Date:   Wed, 26 Jan 2022 16:10:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 af8e84518513d168ae3bc299e761ce7fec1dcb89
Message-ID: <61f10200.0PBUFzNDuN552Nk2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: af8e84518513d168ae3bc299e761ce7fec1dcb89  Merge branch 'acpi-properties' into bleeding-edge

elapsed time: 737m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220124
nios2                            alldefconfig
sh                 kfr2r09-romimage_defconfig
sh                          urquell_defconfig
mips                         cobalt_defconfig
powerpc                         ps3_defconfig
powerpc                  storcenter_defconfig
sh                            shmin_defconfig
sh                           se7780_defconfig
mips                         db1xxx_defconfig
xtensa                  audio_kc705_defconfig
s390                             allyesconfig
arc                                 defconfig
mips                            gpr_defconfig
powerpc                       ppc64_defconfig
arm                  randconfig-c002-20220124
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
arc                  randconfig-r043-20220124
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                  randconfig-c002-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
s390                 randconfig-c005-20220124
x86_64               randconfig-c007-20220124
riscv                randconfig-c006-20220124
mips                      bmips_stb_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
i386                 randconfig-a011-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
i386                 randconfig-a016-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
s390                 randconfig-r044-20220124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
