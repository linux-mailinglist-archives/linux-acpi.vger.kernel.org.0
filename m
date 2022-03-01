Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB41B4C8862
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 10:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiCAJpI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 04:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiCAJpF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 04:45:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0CE5749B;
        Tue,  1 Mar 2022 01:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646127858; x=1677663858;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kXru06/IOIGyvmWQpJlCO6LXdwoif1r6qFgNVJS0Gu4=;
  b=BVXMgiDom6D7i4rdRdO+zkes3yoLQjB0Ljq46ulxYZZSjUR8TrMe4IPV
   u8uUHxTqCYMxmaUwrwUxvg5pmbz3QnBBsyAc/sWspHAYOZ8tIWswG24s6
   QaBJBwi05kb+fuzkiBJUb0umLXpOQZBQrrpztyLuIR7uQLVUtN3T5/luL
   Ee8Yxe9Ctgq4WoafhzN9LgPNuuefw18eCSjCu63L7WB1OAQGeHo/iCY88
   fmoGvCNSGoduarcTMqFOuKeAXNBhLji536efqy2lD9kPI/2k2NuZ7kAaC
   c8D+d4Fh72Sas0AISNbhSgrEaWjei0pLJjBPXKNXNkyxcMxYrsbO4g1vT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250681266"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="250681266"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 01:44:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="507743365"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2022 01:44:14 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOz3F-0000Fk-EQ; Tue, 01 Mar 2022 09:44:13 +0000
Date:   Tue, 01 Mar 2022 17:43:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ac62facbd440da5ba31f5b4b137c234815b6c2d2
Message-ID: <621deac6.naqZhUKaeXm2KwZO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ac62facbd440da5ba31f5b4b137c234815b6c2d2  Merge branch 'acpi-fan' into linux-next

elapsed time: 739m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
parisc                              defconfig
arc                 nsimosci_hs_smp_defconfig
mips                             allyesconfig
h8300                       h8s-sim_defconfig
nios2                         10m50_defconfig
mips                           jazz_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
mips                         db1xxx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      bamboo_defconfig
arc                        nsim_700_defconfig
arm                        keystone_defconfig
mips                            gpr_defconfig
arm                       omap2plus_defconfig
arm                        cerfcube_defconfig
powerpc                     tqm8555_defconfig
mips                         mpc30x_defconfig
mips                       bmips_be_defconfig
sh                          landisk_defconfig
sh                          r7785rp_defconfig
arc                            hsdk_defconfig
sh                               alldefconfig
powerpc                   motionpro_defconfig
powerpc                      ppc6xx_defconfig
arc                          axs103_defconfig
arm                        realview_defconfig
arm                          iop32x_defconfig
powerpc                         ps3_defconfig
arm                  randconfig-c002-20220228
arm                  randconfig-c002-20220227
arm                  randconfig-c002-20220301
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64               randconfig-a011-20220228
x86_64               randconfig-a015-20220228
x86_64               randconfig-a014-20220228
x86_64               randconfig-a013-20220228
x86_64               randconfig-a016-20220228
x86_64               randconfig-a012-20220228
i386                 randconfig-a016-20220228
i386                 randconfig-a012-20220228
i386                 randconfig-a015-20220228
i386                 randconfig-a011-20220228
i386                 randconfig-a013-20220228
i386                 randconfig-a014-20220228
arc                  randconfig-r043-20220228
riscv                randconfig-r042-20220228
s390                 randconfig-r044-20220228
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
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                 randconfig-c004-20220301
powerpc              randconfig-c003-20220301
arm                  randconfig-c002-20220301
s390                 randconfig-c005-20220301
riscv                randconfig-c006-20220301
arm                  colibri_pxa300_defconfig
powerpc                     powernv_defconfig
mips                           rs90_defconfig
arm                         orion5x_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8560_defconfig
mips                           ip28_defconfig
arm                        mvebu_v5_defconfig
arm                          imote2_defconfig
powerpc                   lite5200b_defconfig
mips                           ip22_defconfig
arm                       versatile_defconfig
arm                        vexpress_defconfig
mips                          malta_defconfig
arm                         hackkit_defconfig
x86_64               randconfig-a001-20220228
x86_64               randconfig-a004-20220228
x86_64               randconfig-a003-20220228
x86_64               randconfig-a005-20220228
x86_64               randconfig-a002-20220228
x86_64               randconfig-a006-20220228
i386                 randconfig-a002-20220228
i386                 randconfig-a001-20220228
i386                 randconfig-a005-20220228
i386                 randconfig-a003-20220228
i386                 randconfig-a006-20220228
i386                 randconfig-a004-20220228
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301
hexagon              randconfig-r041-20220228
hexagon              randconfig-r045-20220228
hexagon              randconfig-r045-20220227
hexagon              randconfig-r041-20220227
riscv                randconfig-r042-20220227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
