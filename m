Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97DD4CF1B3
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Mar 2022 07:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiCGGRe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Mar 2022 01:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiCGGRd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Mar 2022 01:17:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386455F24E;
        Sun,  6 Mar 2022 22:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646633800; x=1678169800;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=czqyC369iJ/4Fiuo2aAnacT+hcsllm8pRuj6qchrKa8=;
  b=NZO7Y2rLEtWgkJiWj/ds8LH/DJA4LUd+ZDFGjO0zN9vkMvjW9h9MqJQz
   PIcTb12a7BIbpyK2sEIVQ8ow1f8WYzpks7zZ6+RjBK/0ayR3Aw+eeGe6B
   1N/kMmk1myGPRCzK8Mqg8tCo3opullzL3K0FP0twguIEUYjHUw05973pq
   jx77G64sLjrtFheWfLphRyj7iRTQFyYlbd1aQzSkuwEFcrvaUFxOjR+Qb
   3FG9k9YVlsQh0eC9EGulkyiqIHK0uXAyQF/kxOVVhexqrz8+LEYr4884q
   g7PLNVcUWzyuJYjQm6i1tWfyRVA7A6wvokEoWqglRiVvGk0w05rbfqQ2v
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="317544470"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="317544470"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 22:16:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="710991044"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2022 22:16:37 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nR6fY-00002N-B1; Mon, 07 Mar 2022 06:16:32 +0000
Date:   Mon, 07 Mar 2022 13:40:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c6f4ba2d2b9ac49e8576e8532879484fabec198e
Message-ID: <62259ac4.hltsASUBeeswv9DD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c6f4ba2d2b9ac49e8576e8532879484fabec198e  Merge branch 'acpi-apei' into bleeding-edge

elapsed time: 4819m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
m68k                       m5275evb_defconfig
sh                             sh03_defconfig
arm                         axm55xx_defconfig
sh                          r7780mp_defconfig
xtensa                generic_kc705_defconfig
arm                          pxa3xx_defconfig
m68k                          multi_defconfig
arm                           stm32_defconfig
sh                          r7785rp_defconfig
arc                        vdk_hs38_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                            hisi_defconfig
arm                            mps2_defconfig
h8300                     edosk2674_defconfig
arm                  randconfig-c002-20220302
arm                  randconfig-c002-20220304
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                            allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220304
arc                  randconfig-r043-20220302
s390                 randconfig-r044-20220302
riscv                randconfig-r042-20220304
s390                 randconfig-r044-20220304
riscv                randconfig-r042-20220302
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     tqm5200_defconfig
powerpc                     kilauea_defconfig
mips                      maltaaprp_defconfig
powerpc                      ppc64e_defconfig
i386                             allyesconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220304
hexagon              randconfig-r045-20220302
hexagon              randconfig-r041-20220302
hexagon              randconfig-r041-20220304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
