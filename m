Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF944EBE2A
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 11:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbiC3KBJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 06:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240583AbiC3KBI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 06:01:08 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F361B0A53;
        Wed, 30 Mar 2022 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648634363; x=1680170363;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VfBiVolvCJHl5eMtmZtvm1ki1KZT8OJLshIN1GcLDMY=;
  b=iy3GxxR1c4o8akhO1GsR9XQKD3rtxqFoCYhQxOy27zoTE6l/R3F0RcIF
   R7xDzElwuUI0ZFZ0dwz46uxmnONaYFE85TAFXdFlQOavRpQjWlhjZzj3V
   eQRih/Mil90uuBW85BjQabfazaKATgyQKxj+1T4zHY/0nDswhq+S8GzOI
   8K3jq8aEStf6EdMxmZo+93o5DQqHLTTDIdJzWZIDQlhtJ8Ihxr1nATeE+
   AR2fwM0tSgbTREDBR21WQGIAT7lw8Hr5y+8hKX+DDXXUFtG1sa9F0Qs0h
   ZvGi/14Y0GArSC4hcfExCySQPHu+OsKPSxWxwDhZ1Z74h5IuyWxmGNqOR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="320203544"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="320203544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 02:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="521832879"
Received: from lkp-server02.sh.intel.com (HELO 7a008980c4ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Mar 2022 02:59:18 -0700
Received: from kbuild by 7a008980c4ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZV6k-0000G7-0g; Wed, 30 Mar 2022 09:59:18 +0000
Date:   Wed, 30 Mar 2022 17:59:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bd19672308663b45ebecd8010fa1c51515719dc4
Message-ID: <624429f0.RenlGNGiIterGGxW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bd19672308663b45ebecd8010fa1c51515719dc4  Merge branch 'pm-docs' into linux-next

elapsed time: 739m

configs tested: 198
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220329
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allyesconfig
sh                          landisk_defconfig
sh                        edosk7760_defconfig
powerpc                     rainier_defconfig
um                             i386_defconfig
xtensa                    smp_lx200_defconfig
arm                        mini2440_defconfig
arm                      integrator_defconfig
sh                           se7751_defconfig
sh                            migor_defconfig
arm                        clps711x_defconfig
arm                            xcep_defconfig
arm                          badge4_defconfig
m68k                            q40_defconfig
nios2                         10m50_defconfig
mips                      fuloong2e_defconfig
sh                         microdev_defconfig
arc                        nsim_700_defconfig
arm                         nhk8815_defconfig
powerpc                    sam440ep_defconfig
mips                            ar7_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
sh                         ecovec24_defconfig
arm                             pxa_defconfig
arc                                 defconfig
i386                                defconfig
mips                           xway_defconfig
xtensa                       common_defconfig
sh                            hp6xx_defconfig
arc                          axs101_defconfig
sparc                       sparc32_defconfig
parisc                           alldefconfig
h8300                       h8s-sim_defconfig
sh                     magicpanelr2_defconfig
parisc                generic-32bit_defconfig
m68k                       m5275evb_defconfig
mips                         cobalt_defconfig
arm                        trizeps4_defconfig
sh                          lboxre2_defconfig
sh                         ap325rxa_defconfig
arm                            lart_defconfig
arm                          lpd270_defconfig
powerpc                      ppc40x_defconfig
m68k                       m5249evb_defconfig
arm                            pleb_defconfig
arm                         s3c6400_defconfig
mips                        vocore2_defconfig
sh                   sh7724_generic_defconfig
mips                         bigsur_defconfig
sh                        sh7757lcr_defconfig
arm                            qcom_defconfig
mips                         db1xxx_defconfig
sh                          sdk7786_defconfig
powerpc                         wii_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                  randconfig-c002-20220329
arm                  randconfig-c002-20220327
arm                  randconfig-c002-20220330
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
x86_64               randconfig-a006-20220328
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                 randconfig-a001-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
riscv                randconfig-r042-20220330
s390                 randconfig-r044-20220330
arc                  randconfig-r043-20220330
arc                  randconfig-r043-20220329
s390                 randconfig-r044-20220327
arc                  randconfig-r043-20220328
arc                  randconfig-r043-20220327
riscv                randconfig-r042-20220329
s390                 randconfig-r044-20220329
riscv                randconfig-r042-20220327
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220329
x86_64                        randconfig-c007
mips                 randconfig-c004-20220327
arm                  randconfig-c002-20220327
arm                  randconfig-c002-20220329
riscv                randconfig-c006-20220327
powerpc              randconfig-c003-20220327
powerpc              randconfig-c003-20220329
riscv                randconfig-c006-20220329
i386                          randconfig-c001
s390                 randconfig-c005-20220327
s390                 randconfig-c005-20220329
mips                 randconfig-c004-20220330
powerpc              randconfig-c003-20220330
riscv                randconfig-c006-20220330
arm                  randconfig-c002-20220330
powerpc                 mpc8313_rdb_defconfig
mips                           mtx1_defconfig
mips                     cu1830-neo_defconfig
powerpc                    socrates_defconfig
mips                           rs90_defconfig
powerpc                     mpc5200_defconfig
arm                     am200epdkit_defconfig
mips                   sb1250_swarm_defconfig
powerpc                   lite5200b_defconfig
powerpc                     kilauea_defconfig
riscv                            alldefconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a016-20220328
x86_64               randconfig-a012-20220328
x86_64               randconfig-a011-20220328
x86_64               randconfig-a014-20220328
x86_64               randconfig-a013-20220328
x86_64               randconfig-a015-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a015-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a013-20220328
i386                 randconfig-a014-20220328
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220328
hexagon              randconfig-r045-20220329
hexagon              randconfig-r045-20220328
hexagon              randconfig-r045-20220327
hexagon              randconfig-r041-20220327
hexagon              randconfig-r045-20220330
hexagon              randconfig-r041-20220329
hexagon              randconfig-r041-20220328
hexagon              randconfig-r041-20220330
s390                 randconfig-r044-20220328

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
