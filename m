Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0203724BA15
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Aug 2020 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgHTL7V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Aug 2020 07:59:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:47846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730471AbgHTKAc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Aug 2020 06:00:32 -0400
IronPort-SDR: suthkiEbz1NDtkMGO68hVELzy6g3F7/5ensOYb4fOJEFNw+G1rh8SbIYs3FDm9X6N7uZ8/lHlQ
 p7Ks6qopk8eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="216808343"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="216808343"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 03:00:29 -0700
IronPort-SDR: 9vPQ1Ai56nlI3E3iimStg2e4+hwACdURfbH0hbUgl344ZMn+M3huu505oi+zVUr1LUB2Q5d6QH
 zv/maG8VVCcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="371536268"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2020 03:00:28 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8hMx-00000h-Ln; Thu, 20 Aug 2020 10:00:27 +0000
Date:   Thu, 20 Aug 2020 17:59:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 1f08d51cd57fddbecc396183e544b1d6df98cbfa
Message-ID: <5f3e4997.YKLVDrfCHX/SnJpi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 1f08d51cd57fddbecc396183e544b1d6df98cbfa  Merge branch 'opp/fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

elapsed time: 726m

configs tested: 83
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     powernv_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v7_defconfig
arm                          pxa168_defconfig
powerpc                     skiroot_defconfig
sh                         ap325rxa_defconfig
arc                 nsimosci_hs_smp_defconfig
microblaze                      mmu_defconfig
arm                         vf610m4_defconfig
arm                           h5000_defconfig
mips                        nlm_xlp_defconfig
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
i386                 randconfig-a005-20200818
i386                 randconfig-a002-20200818
i386                 randconfig-a001-20200818
i386                 randconfig-a006-20200818
i386                 randconfig-a003-20200818
i386                 randconfig-a004-20200818
x86_64               randconfig-a013-20200818
x86_64               randconfig-a016-20200818
x86_64               randconfig-a012-20200818
x86_64               randconfig-a011-20200818
x86_64               randconfig-a014-20200818
x86_64               randconfig-a015-20200818
i386                 randconfig-a016-20200818
i386                 randconfig-a011-20200818
i386                 randconfig-a015-20200818
i386                 randconfig-a013-20200818
i386                 randconfig-a012-20200818
i386                 randconfig-a014-20200818
i386                 randconfig-a016-20200819
i386                 randconfig-a011-20200819
i386                 randconfig-a015-20200819
i386                 randconfig-a013-20200819
i386                 randconfig-a012-20200819
i386                 randconfig-a014-20200819
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
