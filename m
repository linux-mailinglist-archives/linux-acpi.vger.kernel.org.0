Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6294B69EF
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Feb 2022 11:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiBOK5B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Feb 2022 05:57:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiBOK46 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Feb 2022 05:56:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D2B10A0;
        Tue, 15 Feb 2022 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644922606; x=1676458606;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dTrtqie4shxFDrwGEl538Whbee33Y8ND67NcnSwUL54=;
  b=HQZnn+XSFDYve8mJVxnvpgnuSRIPuH8C/j/1jgPyBZPf/hsuiFo1mqTq
   VxR1Hmdjydolkd+U+o1uOKs+Z/mpZ/+K9g8TWLwGE2PpY8DEjZO336+C5
   TWyYT1+xL+VTSsgrN/3TCFIwtcgm8/+NWpbKllAHHHtvgVdlpBUHVR+kP
   NL3nMJS1xgG+3RyGS0kTVMDkxT9vbIqw6uvUS7ttKuwNLJXulHMl8uN8f
   kY1Kj7OHFcdn4lsgB3aj9vYIGnXg7UsBy+v+HKXlZ4qZKAZ14/zZgZcoB
   Vljf7cqX+Wz5OQn3OoxZmGg3UTl5z1/VLLRqz3nTsma9A67lkMliPFbMK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250270689"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="250270689"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="497016534"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 02:56:43 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJvVj-0009Yt-9w; Tue, 15 Feb 2022 10:56:43 +0000
Date:   Tue, 15 Feb 2022 18:56:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9db71e8e3027d2026be1ea9b6cfce8fd7216fb01
Message-ID: <620b86c6.uRMwLUkkE1+grIue%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9db71e8e3027d2026be1ea9b6cfce8fd7216fb01  Merge branch 'acpi-ec' into bleeding-edge

elapsed time: 731m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220214
mips                 randconfig-c004-20220214
mips                           jazz_defconfig
sh                            titan_defconfig
sh                          urquell_defconfig
arm                            hisi_defconfig
powerpc                   currituck_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
m68k                       m5475evb_defconfig
sh                              ul2_defconfig
arm                        trizeps4_defconfig
arm                         lpc18xx_defconfig
powerpc                      bamboo_defconfig
arm                        mvebu_v7_defconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20220214
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a013-20220214
x86_64               randconfig-a014-20220214
x86_64               randconfig-a012-20220214
x86_64               randconfig-a015-20220214
x86_64               randconfig-a011-20220214
x86_64               randconfig-a016-20220214
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
arc                  randconfig-r043-20220214
s390                 randconfig-r044-20220214
riscv                randconfig-r042-20220214
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
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                            dove_defconfig
arm64                            allyesconfig
mips                          ath25_defconfig
mips                     loongson1c_defconfig
arm                        magician_defconfig
riscv                            alldefconfig
powerpc                   lite5200b_defconfig
i386                 randconfig-a004-20220214
i386                 randconfig-a002-20220214
i386                 randconfig-a003-20220214
i386                 randconfig-a001-20220214
i386                 randconfig-a006-20220214
i386                 randconfig-a005-20220214
x86_64               randconfig-a002-20220214
x86_64               randconfig-a004-20220214
x86_64               randconfig-a003-20220214
x86_64               randconfig-a001-20220214
x86_64               randconfig-a006-20220214
x86_64               randconfig-a005-20220214
hexagon              randconfig-r041-20220214
hexagon              randconfig-r045-20220214

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
