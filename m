Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D082F23F711
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Aug 2020 11:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHHJaB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 8 Aug 2020 05:30:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:38270 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgHHJaA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 8 Aug 2020 05:30:00 -0400
IronPort-SDR: nlh7/TtQ5Q0rAZ7Sm9nUhnJdljjqkWq0hkaz9P1U1SNoyaPDFJjJhj/68KynhQl1vKRdeeu606
 0AS/Y8J3X3Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="153252133"
X-IronPort-AV: E=Sophos;i="5.75,449,1589266800"; 
   d="scan'208";a="153252133"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2020 02:29:59 -0700
IronPort-SDR: Sjf/jNLYpjAyKHHpGtanYcDzqulvdgT2xSHxIwEVCzG1xqr4iWMiXVBsys6ERaTtS3rrIRj5Md
 +FyOVnv/0arw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,449,1589266800"; 
   d="scan'208";a="293905816"
Received: from lkp-server02.sh.intel.com (HELO 65e25449d42f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2020 02:29:58 -0700
Received: from kbuild by 65e25449d42f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4LAr-00004f-Hg; Sat, 08 Aug 2020 09:29:57 +0000
Date:   Sat, 08 Aug 2020 17:29:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 e3198ed26e1361c3863ba3ad7c9cf2cdd063cdfd
Message-ID: <5f2e707d.8Q031Y3M5vLfPm0P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: e3198ed26e1361c3863ba3ad7c9cf2cdd063cdfd  Merge branch 'acpi-soc' into bleeding-edge

elapsed time: 724m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                         microdev_defconfig
sparc64                             defconfig
powerpc                    amigaone_defconfig
m68k                          sun3x_defconfig
parisc                generic-32bit_defconfig
h8300                    h8300h-sim_defconfig
mips                 decstation_r4k_defconfig
sh                   rts7751r2dplus_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200808
i386                 randconfig-a005-20200808
i386                 randconfig-a001-20200808
i386                 randconfig-a003-20200808
i386                 randconfig-a002-20200808
i386                 randconfig-a006-20200808
x86_64               randconfig-a013-20200807
x86_64               randconfig-a011-20200807
x86_64               randconfig-a012-20200807
x86_64               randconfig-a016-20200807
x86_64               randconfig-a015-20200807
x86_64               randconfig-a014-20200807
i386                 randconfig-a011-20200807
i386                 randconfig-a012-20200807
i386                 randconfig-a013-20200807
i386                 randconfig-a015-20200807
i386                 randconfig-a014-20200807
i386                 randconfig-a016-20200807
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
