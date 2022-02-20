Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25C14BCD07
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Feb 2022 08:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiBTHQ6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 20 Feb 2022 02:16:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiBTHQ5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Feb 2022 02:16:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9BE2C4;
        Sat, 19 Feb 2022 23:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645341396; x=1676877396;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Dk2tEy1WYBh2FFMsDGZPffpOnKJ/yzGQkkNOh/0/ijk=;
  b=bmPa009KZJeD1LG2ltDSDvyoNfTEyoEH3uWjYJfkMhRLSTLy5IwthqVt
   YPKHcdeiupJH8+wiSFjmR51mFdkOgsxn6K8bUI35rsQfz1j3+Bj4CxGrU
   4kfe18F7BOdEhgARdKyoH2qCAKYa8pwMpcv7Yf5t34DTA00pIhFSy9Z6I
   P2qBtGBfoLdBhO2ZfZEmM6nWUipFUvXhEUxKG5DdCn1fecM5y/Z1YVAd9
   zwbKzXp/AUBTE1KaeBsI1Uz/z8SLbMDwTgMSz7vfRs85fN+KUPIW0V0CQ
   33N9WiXsJ2jLji/d2B0ljgx119soYcxDTxVgGwinMHFSk0rMgUROhwRlc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="251533938"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="251533938"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 23:16:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="705859925"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2022 23:16:34 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLgSP-00003N-EM; Sun, 20 Feb 2022 07:16:33 +0000
Date:   Sun, 20 Feb 2022 15:16:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3f4a4374662e7c4826d13cd108265253a11e5114
Message-ID: <6211eaba.nNO/5buGIMGQ4kvp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3f4a4374662e7c4826d13cd108265253a11e5114  Merge branch 'thermal-hfi' into bleeding-edge

elapsed time: 3506m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
arm                        clps711x_defconfig
arm                            zeus_defconfig
sh                           se7780_defconfig
microblaze                      mmu_defconfig
powerpc                       eiger_defconfig
h8300                               defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        mvme147_defconfig
riscv                    nommu_k210_defconfig
powerpc                 linkstation_defconfig
arm                  randconfig-c002-20220217
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220217
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
mips                          ath79_defconfig
mips                           ip22_defconfig
mips                      maltaaprp_defconfig
arm                      tct_hammer_defconfig
riscv                            alldefconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
s390                 randconfig-r044-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
