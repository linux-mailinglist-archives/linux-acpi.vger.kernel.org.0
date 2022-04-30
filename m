Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9509D5160FE
	for <lists+linux-acpi@lfdr.de>; Sun,  1 May 2022 01:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiD3X1L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 Apr 2022 19:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbiD3X1I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Apr 2022 19:27:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381EF5A5A7;
        Sat, 30 Apr 2022 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651361025; x=1682897025;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LcKoOFAObsyAD/ndPxOCPXL8Nf7equVeddrUCIIimX4=;
  b=B2NjbCFVD/8ZOq0lU+MvETRidwN8xS42FFCNod77NqR7ZJ9eedKi2V9X
   h2XnrRzIioY0j15kPL/dT694lu7f7fQmj1Lvn5Tj73qbwOebhIVp0D0y0
   N5/J/69MRVbKh1mMR2wXUcBEtJ0lUo5GL21tnoz/rdiEJeE5UmmMe+0TR
   V/tF6tUDnQNdgNinv1kryscinpodnDEtSMiwyJsmNwiWGEkTzcHuXHQYU
   FK2QzxX7YCL2G62vQ3p+UtYp+m4NWrESSHeyRpYQhrxKdJsVfgkjgJLMV
   m/Gvmg2o3CUhSLkfxCAmAkPW8taDS0uZEuUOe/7P9Dm7TvMQ9EKXspQnj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="246847630"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="246847630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 16:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="707070898"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2022 16:23:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkwRC-0007m0-Q6;
        Sat, 30 Apr 2022 23:23:42 +0000
Date:   Sun, 01 May 2022 07:22:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f2febeef358161ef4f8055451778e19fc78d429c
Message-ID: <626dc4c9.OQFd63oOBHa9VwE6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f2febeef358161ef4f8055451778e19fc78d429c  Merge branch 'acpi-osl' into bleeding-edge

elapsed time: 3473m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
mips                           ci20_defconfig
sh                        sh7763rdp_defconfig
powerpc                        cell_defconfig
parisc                generic-64bit_defconfig
arm                         cm_x300_defconfig
arm                         nhk8815_defconfig
mips                         cobalt_defconfig
ia64                             alldefconfig
parisc                              defconfig
sh                          lboxre2_defconfig
arc                              alldefconfig
sh                               j2_defconfig
arm                        multi_v7_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc64                            defconfig
s390                                defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220428
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
arm                  randconfig-c002-20220428
i386                          randconfig-c001
powerpc              randconfig-c003-20220428
s390                 randconfig-c005-20220428
riscv                randconfig-c006-20220428
arm                       spear13xx_defconfig
mips                        workpad_defconfig
arm                          collie_defconfig
mips                     loongson2k_defconfig
powerpc                     tqm8540_defconfig
arm                         orion5x_defconfig
arm                         lpc32xx_defconfig
arm                        magician_defconfig
powerpc                 mpc8272_ads_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220428
hexagon              randconfig-r045-20220428
riscv                randconfig-r042-20220428
s390                 randconfig-r044-20220428

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
