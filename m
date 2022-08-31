Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8544D5A787C
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Aug 2022 10:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiHaIFk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Aug 2022 04:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiHaIFi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2022 04:05:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83591BE32;
        Wed, 31 Aug 2022 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661933122; x=1693469122;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FTZUE/HMB0MTCpZxliUKMFEJs8Y03+K0ziFDxUfaydI=;
  b=fxtGGMJyS1kQqr2PormtuThtTPg6ZyPrkVhZ9RXvFJPVCyf5Katw5VMt
   T/46lSqswKEUpR2UI+WZsbV/s9nvTlgJleq9OYE1tDCLO+twL5moTEARd
   UgqFnSGMcFJu5xrseMAanhHGzQXJcIGi/GQ1F2zPfF1cUyDRig0N0Do/H
   Ywv3lN3nlxCH4FektlU1Rn2ojznOK3v84YISgpcPC5MWk8dFu7gO/mRPP
   S6b29MgGBhtw60eoUuDSZjw6KrzZxoRuFOYwFpcnkmzi97heJYWB64lQd
   45CuwrGCGblNq7cxdYpX23WOLYMNBaGUubiOZSpaHXsePKki82EjZdCyr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="294139221"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="294139221"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 01:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="612016964"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2022 01:04:59 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTIiZ-00006U-0y;
        Wed, 31 Aug 2022 08:04:59 +0000
Date:   Wed, 31 Aug 2022 16:04:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 41607487f81ccdf20e796adacc277483ecc9c234
Message-ID: <630f1603.6+GZXZtnLrO93ZoE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 41607487f81ccdf20e796adacc277483ecc9c234  Merge branch 'thermal-core' into linux-next

elapsed time: 722m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220830
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                              defconfig
i386                          randconfig-a001
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
i386                          randconfig-a003
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
x86_64                           allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a005
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
x86_64                           rhel-8.3-syz
arm                                 defconfig
i386                          randconfig-a012
mips                             allyesconfig
i386                          randconfig-a016
ia64                             allmodconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm64                            allyesconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sparc                               defconfig
mips                      loongson3_defconfig
m68k                       m5475evb_defconfig
xtensa                  nommu_kc705_defconfig
mips                       bmips_be_defconfig
arm                       imx_v6_v7_defconfig
mips                           jazz_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     asp8347_defconfig
sh                           se7619_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
sh                         apsh4a3a_defconfig
arm64                            alldefconfig
mips                        bcm47xx_defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                             allnoconfig
sh                           se7721_defconfig
sh                        edosk7760_defconfig
m68k                            mac_defconfig
xtensa                  cadence_csp_defconfig
x86_64                           alldefconfig
arm                         nhk8815_defconfig
arc                        vdk_hs38_defconfig
arm                           u8500_defconfig
arm                           tegra_defconfig
arm                          badge4_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                        nsim_700_defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
ia64                      gensparse_defconfig
sh                             sh03_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220830

clang tested configs:
hexagon              randconfig-r045-20220830
riscv                randconfig-r042-20220830
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
