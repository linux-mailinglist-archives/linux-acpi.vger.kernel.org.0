Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8954DA6E0
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 01:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348553AbiCPAbl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Mar 2022 20:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiCPAbj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2022 20:31:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC4E54F9C;
        Tue, 15 Mar 2022 17:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647390625; x=1678926625;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FcDRWTou30Wxb55qZtenvzv/I/o5T65Zp2z3SdJU3pk=;
  b=W9pNwBB50OeWQRna+LfeKPaq45dqcaaAEvpT3hBV/Ob9XoL0u9QYQLHp
   gItjkVGvTuyApbRMUj1mL0YJFQETywiQJxv3FXLHX9OQw+Mf8mSMi3GU3
   uANwM48OgGGJfrtvkK698Wuue1qsrdRVcY7LV0UE2pA0nG+YsDDGaPTar
   o5vqmK+pXJLWUR63chAgtsnWxezBTmkUOnm1QrTGx2fXi206W3DMjivGb
   Le6boqdBRkuv9KFxOuG4gaqqH1e/2auUBey17+a1UXAfBYJkIJJL1s8KH
   UlhEusmnGo21o2btCEJN1cekZtsW8ckDTmlTjkjitR+WVien1REWJNOoJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243906382"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="243906382"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:30:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="646435143"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 17:30:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUHYU-000Bgw-Tg; Wed, 16 Mar 2022 00:30:22 +0000
Date:   Wed, 16 Mar 2022 08:30:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 216aa68e610f96eb9882a10f1fe41732030e2d99
Message-ID: <62312f9c.Zi4I8XH8nG5qTv9j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 216aa68e610f96eb9882a10f1fe41732030e2d99  Merge branches 'pm-docs-next' and 'devprop-next' into bleeding-edge

elapsed time: 729m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                      footbridge_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc834x_itx_defconfig
mips                        vocore2_defconfig
sh                              ul2_defconfig
arm                        multi_v7_defconfig
sh                          r7780mp_defconfig
m68k                        m5307c3_defconfig
arm                  randconfig-c002-20220314
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
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a001-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a003-20220314
i386                 randconfig-a005-20220314
i386                 randconfig-a006-20220314
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                           ip28_defconfig
arm                       cns3420vb_defconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
powerpc                       ebony_defconfig
arm                      pxa255-idp_defconfig
powerpc                     skiroot_defconfig
powerpc                          g5_defconfig
mips                        omega2p_defconfig
x86_64               randconfig-a011-20220314
x86_64               randconfig-a014-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a015-20220314
i386                 randconfig-a012-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a016-20220314
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220313
hexagon              randconfig-r041-20220313

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
