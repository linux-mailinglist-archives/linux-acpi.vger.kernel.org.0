Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66377530152
	for <lists+linux-acpi@lfdr.de>; Sun, 22 May 2022 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbiEVGnQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 22 May 2022 02:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbiEVGnP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 22 May 2022 02:43:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5E520F47;
        Sat, 21 May 2022 23:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653201794; x=1684737794;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4w46qxfNSVssfa7fbKnGNmQEU8ePKVCiB2XwRuFc7as=;
  b=RIs1SArIO/z0HIl9heEOjWiOFcLPcBGXXKUq/52Yw8jL1FnCliEjMbeG
   FB2BRzffeEcVIrLrwpCqOstIk0pSe2f/Ra6SG5L+w6H00ICORn7B+Q95D
   Vy5E6aQ+4KFQ2k7LnmC/tKTIb/7niY1w4RgZDLenMu4FMO/G9S/5QQAEy
   gTtjD3BuudkUlGw+wSVeOB9LYZq5+pcYFvwQBgWAecYUhLca/i9z+W10P
   oht1xEpSuV/u4HisHbzvi4qb5VFGen50DtPBtYoyOIbwTc/w0otsLPwxg
   +Dm/9iZ9kLexLb2uklaYR7HMaPpeJsoV06Z6DVHB9Z6MzAnrWQqZNrXwV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="298273655"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="298273655"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 23:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="547342991"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2022 23:43:12 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsfJ1-00006p-H8;
        Sun, 22 May 2022 06:43:11 +0000
Date:   Sun, 22 May 2022 14:42:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3d22e39d225d7adb6c670065f4ae016e759171ed
Message-ID: <6289db57.CKTfld2m2iPjA4xf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3d22e39d225d7adb6c670065f4ae016e759171ed  Merge branch 'acpica' into linux-next

elapsed time: 829m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
mips                             allyesconfig
riscv                            allyesconfig
um                           x86_64_defconfig
riscv                            allmodconfig
um                             i386_defconfig
mips                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
nios2                            allyesconfig
arm                           imxrt_defconfig
arm                       imx_v6_v7_defconfig
mips                     loongson1b_defconfig
parisc                           alldefconfig
arm                         assabet_defconfig
xtensa                generic_kc705_defconfig
s390                       zfcpdump_defconfig
arm                       omap2plus_defconfig
powerpc64                           defconfig
mips                 decstation_r4k_defconfig
arm                            qcom_defconfig
arm                        realview_defconfig
powerpc                     sequoia_defconfig
arm                           sama5_defconfig
arc                           tb10x_defconfig
h8300                     edosk2674_defconfig
nios2                            alldefconfig
arm                           h5000_defconfig
m68k                          multi_defconfig
arc                          axs101_defconfig
alpha                               defconfig
ia64                                defconfig
sh                         microdev_defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220522
s390                 randconfig-r044-20220522
riscv                randconfig-r042-20220522
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                          ep93xx_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                   lite5200b_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           omap1_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r041-20220522
hexagon              randconfig-r045-20220522

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
