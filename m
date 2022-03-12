Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711D94D6EB0
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Mar 2022 13:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiCLMli (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Mar 2022 07:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCLMlh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Mar 2022 07:41:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DC41D330;
        Sat, 12 Mar 2022 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647088831; x=1678624831;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yRTYP/FooPXwwCa8B9QLoZnS895MMvyeiPt7HFgLbkc=;
  b=Qi0BW1zuuGCwTkopbfNZfThh84trxGftI0MEIfVDPDHRzyxYiMXNX4Tz
   v+YrJvVAEsqYMvpVZ7PcPoKHZOn+IINfSf6uiz30l6VsWq8AyGPLRN3fQ
   GD5IyG66UtvNcjh3RUrPtfhQO9Yp/SSE25dmGz9yP/+opzl1n/uTLytpP
   qMAzW+PnYRctl8QQd/4WiKzIZm98gNA2Ox4g+WHv05s+4VZ3C5lh2h1W0
   JeG590l4pOCIrSTIb6h4BpXbFb97NjL41DNZ05U6Q+rfz/oohUpW1ylsw
   napX2bnDCWe7WVy3Q+p3krkF8Sri8qMWgZe3n1FfaAQDgZSV8XSMn5auF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255522340"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255522340"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 04:40:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="514863292"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2022 04:40:28 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT12q-0007s2-08; Sat, 12 Mar 2022 12:40:28 +0000
Date:   Sat, 12 Mar 2022 20:39:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bbc0e4dfa777cb722b27b3f36a839c0fc61f475b
Message-ID: <622c9481.vhBMDgUD/HNLRZUL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
branch HEAD: bbc0e4dfa777cb722b27b3f36a839c0fc61f475b  Merge branch 'pm-docs-next' into bleeding-edge

elapsed time: 903m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
mips                        vocore2_defconfig
i386                             alldefconfig
arm                            zeus_defconfig
x86_64                           alldefconfig
powerpc                      mgcoge_defconfig
m68k                        mvme16x_defconfig
sh                            migor_defconfig
m68k                          amiga_defconfig
sh                   sh7724_generic_defconfig
ia64                      gensparse_defconfig
powerpc                       ppc64_defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220310
arc                  randconfig-r043-20220312
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
mips                 randconfig-c004-20220310
x86_64                        randconfig-c007
mips                 randconfig-c004-20220312
riscv                randconfig-c006-20220312
s390                 randconfig-c005-20220310
s390                 randconfig-c005-20220312
arm                  randconfig-c002-20220312
powerpc              randconfig-c003-20220310
i386                          randconfig-c001
riscv                randconfig-c006-20220310
powerpc              randconfig-c003-20220312
arm                  randconfig-c002-20220310
mips                       lemote2f_defconfig
arm                   milbeaut_m10v_defconfig
mips                     cu1000-neo_defconfig
mips                  cavium_octeon_defconfig
powerpc                          g5_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
riscv                randconfig-r042-20220310
s390                 randconfig-r044-20220312
hexagon              randconfig-r045-20220312
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220312
hexagon              randconfig-r045-20220310
s390                 randconfig-r044-20220310
hexagon              randconfig-r041-20220312

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
