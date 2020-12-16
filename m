Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4A2DBB47
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Dec 2020 07:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgLPGfR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Dec 2020 01:35:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:45521 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgLPGfR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Dec 2020 01:35:17 -0500
IronPort-SDR: WuXpjr1wDRfUcEUO7SYDAsnyjrCcopgyxCXV3hoyktVRU7P3h3VX3/k0K3/yk/MkFS61xBoPwP
 Laxbwken7MSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="175161164"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="175161164"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 22:34:35 -0800
IronPort-SDR: CxysrdpUf96KlnkAHd3nZ3toEb8xbwiKnBauIzj7ikT3U5nrrDwLzqzHrGgcRHBX0tHH16iePW
 sN/LSM1KhWiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="412331510"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Dec 2020 22:34:34 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpQOP-0001BZ-Fz; Wed, 16 Dec 2020 06:34:33 +0000
Date:   Wed, 16 Dec 2020 14:33:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 d767dc777613ec5643a61a966665f81594da46ae
Message-ID: <5fd9aa54.ON7EqWJt7wfHT0QR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: d767dc777613ec5643a61a966665f81594da46ae  Merge branch 'acpi-pnp' into bleeding-edge

elapsed time: 720m

configs tested: 90
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
c6x                        evmc6457_defconfig
powerpc                        fsp2_defconfig
h8300                    h8300h-sim_defconfig
xtensa                       common_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
um                             i386_defconfig
ia64                         bigsur_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc64e_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20201215
i386                 randconfig-a004-20201215
i386                 randconfig-a003-20201215
i386                 randconfig-a002-20201215
i386                 randconfig-a006-20201215
i386                 randconfig-a005-20201215
i386                 randconfig-a014-20201215
i386                 randconfig-a013-20201215
i386                 randconfig-a012-20201215
i386                 randconfig-a011-20201215
i386                 randconfig-a015-20201215
i386                 randconfig-a016-20201215
x86_64               randconfig-a003-20201215
x86_64               randconfig-a006-20201215
x86_64               randconfig-a002-20201215
x86_64               randconfig-a005-20201215
x86_64               randconfig-a004-20201215
x86_64               randconfig-a001-20201215
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201215
x86_64               randconfig-a012-20201215
x86_64               randconfig-a013-20201215
x86_64               randconfig-a015-20201215
x86_64               randconfig-a014-20201215
x86_64               randconfig-a011-20201215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
