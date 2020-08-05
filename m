Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED723C558
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Aug 2020 07:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHEF5i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Aug 2020 01:57:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:10435 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgHEF5g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Aug 2020 01:57:36 -0400
IronPort-SDR: dLSdMEgHAc/7XEJv6JPVFnIzAFw00uXSQoU40QycSP7sez9bXcOaLz8mR6POxv96pWK1Q1F0Xe
 Y5saduU5mOng==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="151694196"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="151694196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 22:57:34 -0700
IronPort-SDR: URG6wInY0RkfM5siM4OBnnd3WqkgCoaNyQBgRbb0nsJ9J9cOkcOGbHkKeFdXZNQAFoJPjm3YPk
 +tbGZuUPuVzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="467346844"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Aug 2020 22:57:33 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3CQe-0000bT-Ic; Wed, 05 Aug 2020 05:57:32 +0000
Date:   Wed, 05 Aug 2020 13:57:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 83f7a626aa4d238dd3897065384eda829f14a005
Message-ID: <5f2a4a44.6chRtUahZM9dC9O2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 83f7a626aa4d238dd3897065384eda829f14a005  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 803m

configs tested: 84
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          pxa3xx_defconfig
x86_64                           allyesconfig
m68k                         amcore_defconfig
mips                  decstation_64_defconfig
arm                           viper_defconfig
parisc                           alldefconfig
arm                           h3600_defconfig
sh                        edosk7760_defconfig
mips                        vocore2_defconfig
sh                          kfr2r09_defconfig
m68k                       m5208evb_defconfig
mips                        jmr3927_defconfig
arm                          badge4_defconfig
arm                          pxa168_defconfig
arm                              alldefconfig
c6x                        evmc6457_defconfig
mips                        qi_lb60_defconfig
alpha                               defconfig
sh                           se7619_defconfig
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
i386                 randconfig-a005-20200805
i386                 randconfig-a004-20200805
i386                 randconfig-a001-20200805
i386                 randconfig-a003-20200805
i386                 randconfig-a002-20200805
i386                 randconfig-a006-20200805
x86_64               randconfig-a013-20200805
x86_64               randconfig-a011-20200805
x86_64               randconfig-a012-20200805
x86_64               randconfig-a016-20200805
x86_64               randconfig-a015-20200805
x86_64               randconfig-a014-20200805
i386                 randconfig-a011-20200805
i386                 randconfig-a012-20200805
i386                 randconfig-a013-20200805
i386                 randconfig-a014-20200805
i386                 randconfig-a015-20200805
i386                 randconfig-a016-20200805
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
