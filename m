Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3874AD73E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Feb 2022 12:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376362AbiBHLcT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Feb 2022 06:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356424AbiBHKpY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Feb 2022 05:45:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD4C03FEC3;
        Tue,  8 Feb 2022 02:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644317123; x=1675853123;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+KO4sF4k8MB+WmyP2JsU+xI5l1gssY/zGbTiH6WguDQ=;
  b=HhbXo3ClNx7+exLzhrkT1LG2P+DUdqgkM0e/0VQD8edBqUdRjlsJq7EM
   kMtBwIRRUo0HmF7VZ1F61utLi3DcdCBFB6JugvNh979L4jvZSUdJQRMHx
   E+e+L7qqoBU77UCJaYbGlNU3ySEAs3J9jplzJB9Lt6ElPtdih8uLik9kd
   iLVncKJhin1xNsrMgpsya7w02Z/gSjZTvfMm5DQKv/EbWUg9ib1BVtQIU
   9AoV5X8IYvkq0y1ucj4bbODWEUjoeu13BEvUan1UnV+RyHmYGpGC+c1JL
   /p9/MTUIqVn0r8V4KOjbsOLNKVVwY3u+4gTGcTfl55mB6mWFWZf8Hv9ls
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="228890764"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="228890764"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 02:45:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="481901913"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2022 02:45:20 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHNzr-00003Y-Sq; Tue, 08 Feb 2022 10:45:19 +0000
Date:   Tue, 08 Feb 2022 18:44:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 963096e03c9e753d00dd0a04bcf4699b5a05b816
Message-ID: <6202498e.hDHNVPWL/oPrDzPj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 963096e03c9e753d00dd0a04bcf4699b5a05b816  Merge branch 'acpi-pm' into bleeding-edge

elapsed time: 723m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220207
sh                               alldefconfig
sh                           se7751_defconfig
mips                            ar7_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                        cell_defconfig
sh                         ecovec24_defconfig
arm                        clps711x_defconfig
sh                        edosk7760_defconfig
arm                        keystone_defconfig
sparc                       sparc32_defconfig
m68k                       m5475evb_defconfig
m68k                        m5407c3_defconfig
sh                           se7343_defconfig
h8300                       h8s-sim_defconfig
powerpc                      ep88xc_defconfig
arm                  randconfig-c002-20220207
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allmodconfig
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
x86_64               randconfig-a013-20220207
x86_64               randconfig-a016-20220207
x86_64               randconfig-a015-20220207
x86_64               randconfig-a012-20220207
x86_64               randconfig-a014-20220207
x86_64               randconfig-a011-20220207
i386                 randconfig-a012-20220207
i386                 randconfig-a013-20220207
i386                 randconfig-a015-20220207
i386                 randconfig-a014-20220207
i386                 randconfig-a011-20220207
i386                 randconfig-a016-20220207
arc                  randconfig-r043-20220207
s390                 randconfig-r044-20220207
riscv                randconfig-r042-20220207
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
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220208
i386                          randconfig-c001
mips                 randconfig-c004-20220208
arm                  randconfig-c002-20220208
s390                 randconfig-c005-20220208
riscv                randconfig-c006-20220208
mips                           mtx1_defconfig
arm                            dove_defconfig
arm                       versatile_defconfig
powerpc                     pseries_defconfig
x86_64               randconfig-a004-20220207
x86_64               randconfig-a003-20220207
x86_64               randconfig-a002-20220207
x86_64               randconfig-a001-20220207
x86_64               randconfig-a005-20220207
x86_64               randconfig-a006-20220207
i386                 randconfig-a003-20220207
i386                 randconfig-a001-20220207
i386                 randconfig-a002-20220207
i386                 randconfig-a005-20220207
i386                 randconfig-a004-20220207
i386                 randconfig-a006-20220207
hexagon              randconfig-r045-20220207
hexagon              randconfig-r041-20220207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
