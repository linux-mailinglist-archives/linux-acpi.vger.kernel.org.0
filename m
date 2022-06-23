Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94FF556FE0
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jun 2022 03:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbiFWB2Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Jun 2022 21:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiFWB2K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2022 21:28:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669BA18355;
        Wed, 22 Jun 2022 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655947684; x=1687483684;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JDaY/H6l4S7fw8l9x6LMQMp2crDdKIldldQwzF5WU4k=;
  b=Z+yp+tsw+uYnBzJgP11EIsldalP1h1x/PyOJ11I2ZrYhBenXCUz0Ecwi
   6+sR5/kUosdxDfoBmHVH+//NTq7CB4X4gW4ScjNvKsgQRnL/uKwipzTgt
   gVydfBv4Qf2ty026MhEM3ulzqm01RKcOU0r79yIF3W21aPcVPYGi2/Ku7
   jrZ2fyGHcdEn/ITHZLnPLhR1AQq29fRgm0gWteZTJTSWUInB3vszk5QnC
   rKro6pHU+bXtQ5oGDR4oLjj60z0phj0Xsab4frNZNQL+/SEzVkjEP4Atc
   UfEPJpGfA0TrltsBLcJ+gFEtDHXRczArlOaIPUguGUptouGpeB6lGtaAb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342277008"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="342277008"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 18:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="914958346"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2022 18:28:00 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4BdX-0000Hj-IM;
        Thu, 23 Jun 2022 01:27:59 +0000
Date:   Thu, 23 Jun 2022 09:17:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 22f7e9edec50b73e533b1f73bd4b2e10a0910d3f
Message-ID: <62b3bf31.e3RKhPmmPlJYpvAW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 22f7e9edec50b73e533b1f73bd4b2e10a0910d3f  Merge branch 'pm-sleep' into linux-next

elapsed time: 729m

configs tested: 88
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                          atari_defconfig
sh                             espt_defconfig
arc                    vdk_hs38_smp_defconfig
s390                          debug_defconfig
m68k                        mvme16x_defconfig
arm                            xcep_defconfig
arc                              alldefconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
arm                        oxnas_v6_defconfig
um                               alldefconfig
sh                          urquell_defconfig
sh                         microdev_defconfig
sparc                               defconfig
powerpc                      pasemi_defconfig
sh                             sh03_defconfig
openrisc                         alldefconfig
arm                           u8500_defconfig
arm                       aspeed_g5_defconfig
xtensa                              defconfig
ia64                             allmodconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                              debian-10.3
i386                                defconfig
i386                   debian-10.3-kselftests
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220622
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                 mpc8315_rdb_defconfig
arm                          ixp4xx_defconfig
riscv                    nommu_virt_defconfig
mips                           ip28_defconfig
arm                         hackkit_defconfig
riscv                             allnoconfig
powerpc                 xes_mpc85xx_defconfig
i386                             allyesconfig
mips                        qi_lb60_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r041-20220623
hexagon              randconfig-r045-20220623

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
