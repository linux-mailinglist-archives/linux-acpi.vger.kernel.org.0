Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893DA53F6F6
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jun 2022 09:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiFGHNv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jun 2022 03:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiFGHNv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jun 2022 03:13:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0379E64D9;
        Tue,  7 Jun 2022 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654586029; x=1686122029;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=llF76QcHw+Aho1/ZKoPV8jVpAedMYUR11m5/d7d1+Fc=;
  b=WWvmyPN2b68+Kuh6nRmvzEDFAn0YbfBbIqnKlzbjmUAE1rP95hnxASKK
   6+su3ZG5gogzSneaUr499AEgPLf17emADfdfNv/uzgIGqKdXEAgPSC7vK
   8yLqvtf5qkDn8p9nHeZJ3ETuO91pIKRyVfkwcHVNB5Zlw8dQZknFrNRGp
   VAnOy+vaBvQtZb/hxWQoUptl21GDuR6Ey1RJgtpO/nQlmQ5KoYIGmuBul
   PvFYNZzntQYyj1rvKvVyR6Wzy6tGD5iN3Dk8xiNDYuw643KH/rN4cVyEi
   Wand45O+NxNYa1ZdB1PzZN0UIOep2itf0CR4Gt43c/MCgU7vEsKOY5KAM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="276751529"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="276751529"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="682621079"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2022 00:13:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyTPN-000DSf-KW;
        Tue, 07 Jun 2022 07:13:45 +0000
Date:   Tue, 07 Jun 2022 15:13:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6a8964e282382ab8f2e64355d2ce8eda80e8fe30
Message-ID: <629efa90.l8uapqHJf1Su+u23%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6a8964e282382ab8f2e64355d2ce8eda80e8fe30  Merge branch 'pm-sysoff' into linux-next

elapsed time: 723m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-c001
m68k                         amcore_defconfig
arm                          pxa3xx_defconfig
arc                                 defconfig
sh                   rts7751r2dplus_defconfig
sh                         ap325rxa_defconfig
arc                     haps_hs_smp_defconfig
xtensa                generic_kc705_defconfig
arc                      axs103_smp_defconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     taishan_defconfig
sh                            shmin_defconfig
sh                           se7750_defconfig
sh                          sdk7786_defconfig
arm                        mvebu_v7_defconfig
ia64                        generic_defconfig
powerpc                    sam440ep_defconfig
powerpc                      chrp32_defconfig
nios2                         10m50_defconfig
arc                          axs103_defconfig
powerpc                     rainier_defconfig
arc                            hsdk_defconfig
arm                            qcom_defconfig
openrisc                    or1ksim_defconfig
m68k                                defconfig
mips                     decstation_defconfig
arm                           u8500_defconfig
sh                          rsk7264_defconfig
mips                         db1xxx_defconfig
arm                           tegra_defconfig
sh                             shx3_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
sh                            migor_defconfig
mips                 decstation_r4k_defconfig
ia64                                defconfig
nios2                            alldefconfig
m68k                        m5307c3_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220605
riscv                             allnoconfig
h8300                            allyesconfig
m68k                             allyesconfig
xtensa                           allyesconfig
m68k                             allmodconfig
csky                                defconfig
mips                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
alpha                            allyesconfig
mips                             allmodconfig
sh                               allmodconfig
s390                                defconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
s390                             allmodconfig
riscv                          rv32_defconfig
parisc                              defconfig
parisc64                            defconfig
riscv                    nommu_k210_defconfig
parisc                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
s390                             allyesconfig
sparc                               defconfig
powerpc                          allyesconfig
i386                             allyesconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sparc                            allyesconfig
powerpc                          allmodconfig
i386                                defconfig
um                             i386_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                             allmodconfig
arm64                               defconfig
ia64                             allyesconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a010
i386                          randconfig-a012
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a008
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a007
i386                          randconfig-a005
i386                          randconfig-a009
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220606
riscv                randconfig-c006-20220606
s390                 randconfig-c005-20220606
i386                 randconfig-c001-20220606
mips                 randconfig-c004-20220606
x86_64               randconfig-c007-20220606
arm                  randconfig-c002-20220606
arm                             mxs_defconfig
mips                        qi_lb60_defconfig
mips                            e55_defconfig
arm                     am200epdkit_defconfig
mips                      maltaaprp_defconfig
arm                        mvebu_v5_defconfig
powerpc                     powernv_defconfig
i386                          randconfig-a002
x86_64                        randconfig-a009
x86_64                        randconfig-a007
x86_64                        randconfig-a010
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a008
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a006
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
