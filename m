Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C534BF226
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Feb 2022 07:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiBVGiY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Feb 2022 01:38:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiBVGiX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Feb 2022 01:38:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B15DF3A;
        Mon, 21 Feb 2022 22:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645511878; x=1677047878;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=O15gMyD3pZu1ehhynI27dsO78ZZEN4SItwaRKSaZ3QQ=;
  b=GacVMTp7LrxIXJ0XZ8cGmEa7YL5wcryIktw6Yqf0b44w7VgW6GhlOl/S
   h0N4SGclzJtYviXp/kWm06/lIAPdPCNIUuopOebMaD/dmPfvnI7WP8p07
   GT4GVGFUS0YBlP0e4iY0jYdSXrXzQTTeBTWYb5ldrdgJakgBV9g+uErqk
   TEqtbw/53qSKHLOoBSBDe1eSpocekyrWHoW1yLHrgT4wM3fXCjF54N/6K
   LP81PHas/Y+tka3Z+Iq2egqxdQi+AGO1ows5S81ko0Xi05e8w/+BgXYdY
   ivcXRPpr8W56iqwfe4WadEWMlSW7Tl1KiwzxmFmhW8pUalS1ch+1UB0Gq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="250444084"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="250444084"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 22:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="507868464"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 22:37:55 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMOo6-0002PW-IF; Tue, 22 Feb 2022 06:37:54 +0000
Date:   Tue, 22 Feb 2022 14:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2ecb866af0048e96c331a206a876a935d3649f78
Message-ID: <621484ae.Ho4k1TNaYofLj/c9%lkp@intel.com>
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
branch HEAD: 2ecb866af0048e96c331a206a876a935d3649f78  Merge branch 'thermal-hfi' into linux-next

elapsed time: 731m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220221
sh                 kfr2r09-romimage_defconfig
arm                           corgi_defconfig
ia64                             alldefconfig
sh                   secureedge5410_defconfig
mips                         mpc30x_defconfig
sh                          kfr2r09_defconfig
powerpc                         wii_defconfig
sh                   rts7751r2dplus_defconfig
mips                           gcw0_defconfig
mips                  decstation_64_defconfig
sh                          lboxre2_defconfig
xtensa                         virt_defconfig
ia64                          tiger_defconfig
arm                          iop32x_defconfig
sh                             shx3_defconfig
h8300                    h8300h-sim_defconfig
arm                       aspeed_g5_defconfig
m68k                          hp300_defconfig
arm                            xcep_defconfig
xtensa                       common_defconfig
sh                           se7721_defconfig
alpha                            alldefconfig
sh                           se7724_defconfig
mips                             allyesconfig
arm                      jornada720_defconfig
sh                               allmodconfig
powerpc                  storcenter_defconfig
mips                         tb0226_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
m68k                       m5208evb_defconfig
s390                             allmodconfig
mips                       bmips_be_defconfig
m68k                        m5407c3_defconfig
s390                             allyesconfig
m68k                       m5475evb_defconfig
arm                         nhk8815_defconfig
arm                          pxa3xx_defconfig
powerpc                        warp_defconfig
sh                           sh2007_defconfig
arm                          gemini_defconfig
powerpc                      pasemi_defconfig
m68k                          sun3x_defconfig
mips                         cobalt_defconfig
arm                        clps711x_defconfig
arm                            pleb_defconfig
powerpc                       holly_defconfig
sh                   sh7770_generic_defconfig
xtensa                  cadence_csp_defconfig
powerpc                    amigaone_defconfig
powerpc                     redwood_defconfig
sh                ecovec24-romimage_defconfig
powerpc                         ps3_defconfig
mips                        jmr3927_defconfig
microblaze                          defconfig
mips                         db1xxx_defconfig
arc                           tb10x_defconfig
arm                        mvebu_v7_defconfig
powerpc                        cell_defconfig
powerpc                  iss476-smp_defconfig
sh                          rsk7269_defconfig
powerpc                     tqm8555_defconfig
sh                        apsh4ad0a_defconfig
arm                           sunxi_defconfig
arm                  randconfig-c002-20220221
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20220221
x86_64               randconfig-a002-20220221
x86_64               randconfig-a005-20220221
x86_64               randconfig-a006-20220221
x86_64               randconfig-a001-20220221
x86_64               randconfig-a004-20220221
i386                 randconfig-a002-20220221
i386                 randconfig-a001-20220221
i386                 randconfig-a005-20220221
i386                 randconfig-a003-20220221
i386                 randconfig-a006-20220221
i386                 randconfig-a004-20220221
arc                  randconfig-r043-20220221
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220222
x86_64                        randconfig-c007
arm                  randconfig-c002-20220222
mips                 randconfig-c004-20220222
i386                          randconfig-c001
riscv                randconfig-c006-20220222
powerpc              randconfig-c003-20220221
x86_64               randconfig-c007-20220221
arm                  randconfig-c002-20220221
mips                 randconfig-c004-20220221
i386                 randconfig-c001-20220221
riscv                randconfig-c006-20220221
s390                 randconfig-c005-20220221
arm                          moxart_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        vexpress_defconfig
arm                          collie_defconfig
powerpc                  mpc866_ads_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      ppc44x_defconfig
x86_64               randconfig-a011-20220221
x86_64               randconfig-a015-20220221
x86_64               randconfig-a014-20220221
x86_64               randconfig-a016-20220221
x86_64               randconfig-a013-20220221
x86_64               randconfig-a012-20220221
i386                 randconfig-a016-20220221
i386                 randconfig-a012-20220221
i386                 randconfig-a015-20220221
i386                 randconfig-a011-20220221
i386                 randconfig-a014-20220221
i386                 randconfig-a013-20220221
hexagon              randconfig-r045-20220221
hexagon              randconfig-r041-20220221
riscv                randconfig-r042-20220221
hexagon              randconfig-r045-20220222
hexagon              randconfig-r041-20220222
s390                 randconfig-r044-20220221

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
