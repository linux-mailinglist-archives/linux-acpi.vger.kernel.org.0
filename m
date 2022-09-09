Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA95B2CF4
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Sep 2022 05:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIIDcu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Sep 2022 23:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiIIDct (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Sep 2022 23:32:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BEBE7F96;
        Thu,  8 Sep 2022 20:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662694367; x=1694230367;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Rc9I+U8f8nZpjDWSe7O3ImjcloxzYbjAjY0cyXiQTyQ=;
  b=h1KjOzateT2nUxix1X1RGuto24kKoW/dCRxs451ZHbvptHjldRY5V9GR
   lxk4krGk7n9cnNYgqM/TpAsfjrt2QWfKJMy8AHtMQvLOJdPfpsnpMIX4t
   4su6lpfnEHS6vh6MBtReMgfzn1QKDsFlm8yQdqYTFiqNTIr0f+5gY/3kL
   BS4NVNHfS4ONP4M6T+A8tn/1dWX8JKDAW1LFFz6nxQzCl4/2RsCdFAjrO
   9UIKC9AQ7DlPDabQ0b9wUPPk5baAdWCJlLRzzukik6IyOS1Vjt6zmYH5T
   rEyz/SxS9jgh0b3oZU5MsHwzVINbvtE9KD9LwfuhcsSicQoFpBfhsLJyC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284406279"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="284406279"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 20:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="757457253"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2022 20:32:45 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWUl2-0000fJ-3B;
        Fri, 09 Sep 2022 03:32:44 +0000
Date:   Fri, 09 Sep 2022 11:32:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2bc2aea001d35f669e1fe6c767df0ea79fe3e6e5
Message-ID: <631ab3bf.OvSHvO7aKHQy5Uv/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2bc2aea001d35f669e1fe6c767df0ea79fe3e6e5  Merge branch 'acpi-bus' into linux-next

elapsed time: 795m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                                 defconfig
arc                  randconfig-r043-20220908
arm                              allyesconfig
arc                  randconfig-r043-20220907
arm64                            allyesconfig
s390                 randconfig-r044-20220908
riscv                randconfig-r042-20220908
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
arm                             pxa_defconfig
arc                              alldefconfig
arm                           u8500_defconfig
powerpc                      mgcoge_defconfig
m68k                                defconfig
arm                            hisi_defconfig
xtensa                    smp_lx200_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
m68k                          atari_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     tqm8548_defconfig
mips                     decstation_defconfig
powerpc                     stx_gp3_defconfig
sh                          sdk7780_defconfig
mips                            ar7_defconfig
mips                         rt305x_defconfig
arc                      axs103_smp_defconfig
openrisc                    or1ksim_defconfig
sh                             shx3_defconfig
xtensa                              defconfig
mips                    maltaup_xpa_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7705_defconfig
powerpc                      ppc40x_defconfig
mips                      loongson3_defconfig
sh                         apsh4a3a_defconfig
parisc                           alldefconfig
sh                            migor_defconfig
openrisc                            defconfig
arc                    vdk_hs38_smp_defconfig
sh                         microdev_defconfig
mips                           xway_defconfig
sh                     magicpanelr2_defconfig
sparc64                          alldefconfig
arm                         nhk8815_defconfig
m68k                          multi_defconfig
nios2                            allyesconfig
sh                             espt_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220908
m68k                        m5307c3_defconfig
sh                           se7721_defconfig
powerpc                      bamboo_defconfig
arm                      footbridge_defconfig
arm                        realview_defconfig
m68k                       m5275evb_defconfig
parisc                           allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
hexagon              randconfig-r041-20220907
hexagon              randconfig-r041-20220908
riscv                randconfig-r042-20220907
hexagon              randconfig-r045-20220908
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                        fsp2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                        qi_lb60_defconfig
arm                          pcm027_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                           mtx1_defconfig
mips                          ath79_defconfig
powerpc                     ppa8548_defconfig
mips                           ip22_defconfig
arm                          moxart_defconfig
powerpc                 mpc8315_rdb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
