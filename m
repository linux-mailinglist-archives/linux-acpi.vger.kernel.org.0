Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806C95AC36F
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Sep 2022 10:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiIDI1P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 4 Sep 2022 04:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiIDI1L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Sep 2022 04:27:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026141D3A;
        Sun,  4 Sep 2022 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662280029; x=1693816029;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ju+KKLx57zu2A9etoqVou1Lket7t8L7FHT+HvTOQKf8=;
  b=MWZj+q8GjZKefOsEilmoqLU7BAQ2CgEKo+jzI8sdV0lDGTR9LP0jsCgW
   6H+VCAkJDDlg6RMqq9wq6AROBluv5x+s7ZUXILLmuug0AeExD6EGP4YQb
   +iSAYUlMmoIh0SzRK1fuGb9oJ6NSTE7DrVdSbp+f+a80NfHo6nyYxhZTZ
   ob8CYgX5zu2RbZnC+b2ugIeic9KdSPFpq7L0Tfk59MnAg0RQYF1Nu2Nit
   7zwdJZStW2lmFx0KsuqHjDsYQfO62olHEiTT6K8HSJxZHnYKl+HyNc4+w
   slOX2Qk/boUGaz8o4Jk1sRJeJzleLk6j6F4x0fKk5JidzUY596+xtQeVs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="297008980"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="297008980"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 01:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="858654103"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Sep 2022 01:26:40 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUkxj-0002oi-1o;
        Sun, 04 Sep 2022 08:26:39 +0000
Date:   Sun, 04 Sep 2022 16:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bbc77c8d9661c790806ca96ca01a356275b6a684
Message-ID: <63146128.Wj6a7OWDbwzShZ3i%lkp@intel.com>
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
branch HEAD: bbc77c8d9661c790806ca96ca01a356275b6a684  Merge branch 'acpi-properties' into bleeding-edge

elapsed time: 724m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
arm                                 defconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
arc                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
alpha                            allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
arm                              allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a015
m68k                             allyesconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
m68k                             allmodconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a016
x86_64                         rhel-8.3-kunit
arm                           u8500_defconfig
x86_64                        randconfig-a006
m68k                       m5475evb_defconfig
mips                      fuloong2e_defconfig
x86_64                        randconfig-a004
csky                              allnoconfig
i386                             allyesconfig
sparc64                          alldefconfig
arm                         assabet_defconfig
sh                           se7722_defconfig
ia64                             allmodconfig
microblaze                      mmu_defconfig
sh                           se7712_defconfig
arm                         lpc18xx_defconfig
mips                       bmips_be_defconfig
sparc                               defconfig
alpha                             allnoconfig
arm                      integrator_defconfig
riscv                             allnoconfig
arc                  randconfig-r043-20220904
parisc64                         alldefconfig
sh                            shmin_defconfig
ia64                      gensparse_defconfig
arc                               allnoconfig
riscv                randconfig-r042-20220904
s390                 randconfig-r044-20220904
loongarch                         allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
loongarch                           defconfig
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a003
arm                   milbeaut_m10v_defconfig
x86_64                        randconfig-a005
powerpc                 mpc8272_ads_defconfig
hexagon              randconfig-r045-20220904
powerpc                          g5_defconfig
hexagon              randconfig-r041-20220904
riscv                          rv32_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
