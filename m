Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72543241473
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Aug 2020 03:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgHKBPD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Aug 2020 21:15:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:28511 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgHKBPD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Aug 2020 21:15:03 -0400
IronPort-SDR: w8i/IoDHWhjyRdcPP6RtaAhC4pgg9wyYW0zLkxVwmX417b5ifV2Nupl+6+Ht++Dz8F+leL56uE
 OabhhFjgNhsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="141505476"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="141505476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 18:15:02 -0700
IronPort-SDR: 0CIfP7TD2K4trAC0Kbgml7/6PWtJoRmZCwDt06U/E1Yw7e8o5A1Tsnpe9rWl/oRfXUVtS2rWwE
 bUZdmY3oypag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="290538784"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2020 18:15:00 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5IsW-0000IG-2V; Tue, 11 Aug 2020 01:15:00 +0000
Date:   Tue, 11 Aug 2020 09:14:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 7cd29e47553a773f54727d0756a57d0a3dcb3ab0
Message-ID: <5f31f0e1.beJga6jjAQLhVagJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 7cd29e47553a773f54727d0756a57d0a3dcb3ab0  Merge branches 'pm-cpufreq' and 'acpi-soc' into linux-next

elapsed time: 722m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7780mp_defconfig
arm                           stm32_defconfig
arm                             ezx_defconfig
arm                        multi_v7_defconfig
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
i386                 randconfig-a005-20200810
i386                 randconfig-a001-20200810
i386                 randconfig-a002-20200810
i386                 randconfig-a003-20200810
i386                 randconfig-a006-20200810
i386                 randconfig-a004-20200810
x86_64               randconfig-a013-20200810
x86_64               randconfig-a012-20200810
x86_64               randconfig-a016-20200810
x86_64               randconfig-a011-20200810
x86_64               randconfig-a014-20200810
x86_64               randconfig-a015-20200810
i386                 randconfig-a011-20200810
i386                 randconfig-a013-20200810
i386                 randconfig-a012-20200810
i386                 randconfig-a016-20200810
i386                 randconfig-a015-20200810
i386                 randconfig-a014-20200810
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
