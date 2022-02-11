Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9C4B2693
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Feb 2022 13:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350372AbiBKM6B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Feb 2022 07:58:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbiBKM57 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Feb 2022 07:57:59 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21782F1;
        Fri, 11 Feb 2022 04:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644584277; x=1676120277;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=H7hr8Tb0BcEtWSXOSLmmpsuGSrqeWSlH/gYsWFpNPdo=;
  b=O35mGQxRCN7nIPVAjJ9YjZ42gFadBWTapZVsKJcxI4uFpqP/Wn4+t4nm
   hapHHjlaDf6kKFVXz/c+lnihtH/nB/zaMtQWjtRXEQcMgZqlmUKxTtyVU
   GdUxjzLZUfHLvoO+0dJF2oW6RvYiAS76i2scHEQ+LztqBncC23Vk2iAwk
   cPc9oqI7wBnWu1WNxDVBNuvNKwDl1i+ypOAY2T3dqgSnycrk1xI488+i6
   Ezid9AVnPwENh+pGBSe/3OASgXOyVzvctwK+7V5tCqm2bLppoMt4Wsz9n
   +H/yaWrYAjAUkfpy/EeskGaM3y7kWKJGbcArKmKOLyECoELtp09a6VCqt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249476002"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="249476002"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 04:57:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="772089668"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2022 04:57:50 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIVUk-0004bZ-0u; Fri, 11 Feb 2022 12:57:50 +0000
Date:   Fri, 11 Feb 2022 20:57:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a24b2df244afcb80fcb7c12537b3c86a5be3e1f9
Message-ID: <62065d3d.Ya6trq6Nc15wfeQf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a24b2df244afcb80fcb7c12537b3c86a5be3e1f9  Merge branch 'thermal-hfi' into bleeding-edge

elapsed time: 769m

configs tested: 90
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                           h3600_defconfig
powerpc                       eiger_defconfig
xtensa                          iss_defconfig
openrisc                 simple_smp_defconfig
arm                          simpad_defconfig
mips                  maltasmvp_eva_defconfig
m68k                          atari_defconfig
xtensa                       common_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8540_ads_defconfig
arm                  randconfig-c002-20220209
arm                  randconfig-c002-20220211
arm                  randconfig-c002-20220210
ia64                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
nds32                             allnoconfig
nios2                               defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220211
arm                  randconfig-c002-20220211
i386                          randconfig-c001
mips                 randconfig-c004-20220211
s390                 randconfig-c005-20220211
riscv                randconfig-c006-20220211
arm                     am200epdkit_defconfig
arm                         orion5x_defconfig
powerpc                   lite5200b_defconfig
powerpc                     ksi8560_defconfig
mips                       lemote2f_defconfig
arm                                 defconfig
mips                           rs90_defconfig
powerpc                  mpc885_ads_defconfig
i386                          randconfig-a002
x86_64                        randconfig-a012
riscv                randconfig-r042-20220211
s390                 randconfig-r044-20220211

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
