Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF184C55F1
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Feb 2022 13:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiBZMz2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Feb 2022 07:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiBZMz2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Feb 2022 07:55:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28F624913B;
        Sat, 26 Feb 2022 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645880093; x=1677416093;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S+EXp80RPbZsZvoDlUMfsZhHkuO+dmZhNNQYuzSkbx0=;
  b=UGLJT/qtqwkdlFrhu+5XY1hAhHvrkIqIi26JGGPvDvdX4pO9UDzLOXsF
   VALmUkUwbHrol1s4MXPyLAmFXOyE29IegMEQzo5+FdGi4UeZtjdKRwTUm
   5bKSIil+lpTLOWY3J8gd4k/2aboom6qG+2FwsrLHaky0k5xKTNKvHCeah
   3l8pBPkip4UKWsY+NMzSwFPlgQ+c9gmzg9KPXTp2rJ43YM2hQ7MFuITef
   oCfqCzZsUV5U8orZwZmv2RoqxI0ezqGl0s2BKPkvkivtXTbhTn11JZATW
   ELCFusMtxEscScpUkhmGyEg2Ce52I7kF/mEy0vnO3diUa+c87F0Up19xx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="339092513"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="339092513"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 04:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="708152006"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Feb 2022 04:54:51 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNwb5-0005U1-06; Sat, 26 Feb 2022 12:54:51 +0000
Date:   Sat, 26 Feb 2022 20:54:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 203eb3b975f961128ac00226afd60fbf7ceb2dfb
Message-ID: <621a230b.BgEEdIca0UOh8Jck%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 203eb3b975f961128ac00226afd60fbf7ceb2dfb  Merge branch 'acpi-fan' into bleeding-edge

elapsed time: 721m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220225
mips                         tb0226_defconfig
sh                          kfr2r09_defconfig
arc                      axs103_smp_defconfig
powerpc                     pq2fads_defconfig
arm                           sama5_defconfig
parisc                generic-64bit_defconfig
microblaze                      mmu_defconfig
arm                           h5000_defconfig
sh                           se7750_defconfig
h8300                       h8s-sim_defconfig
mips                          rb532_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20220225
arm                  randconfig-c002-20220226
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220225
s390                 randconfig-r044-20220226
riscv                randconfig-r042-20220226
arc                  randconfig-r043-20220226
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                 mpc8315_rdb_defconfig
mips                     loongson2k_defconfig
riscv                    nommu_virt_defconfig
mips                           ip28_defconfig
powerpc                     ppa8548_defconfig
arm                           sama7_defconfig
mips                      malta_kvm_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220226
hexagon              randconfig-r045-20220226
s390                 randconfig-r044-20220225
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
