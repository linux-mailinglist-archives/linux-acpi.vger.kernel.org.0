Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821DB538AC0
	for <lists+linux-acpi@lfdr.de>; Tue, 31 May 2022 06:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiEaExA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 May 2022 00:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiEaExA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 May 2022 00:53:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B32205D0;
        Mon, 30 May 2022 21:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653972778; x=1685508778;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=76fY8Ek9YA85m7Sn8y5UyEEJ6MnFoPwGlkuOWG/vkBg=;
  b=bCWYDXD7xBG03o94Z/U6E5Ajuv0ac72kT0FkyXzenmI0KjJWC7DrH744
   VyNKSe7d8DZMS7iPjOsqVJ7AFqNfX5NavqqwCLEQfF3XX8OJTwVVQH8Cx
   Ea7SlCnCoPg5l4s6514DjbwSKdkPzr+oT2pLuNJ3kVjMWKECWDKrAPncB
   KhmDDs0B85HbQUun5pCXGYnNgG1GRJsfeSOYQOA2wYd8t6Fd1bDGKNMkO
   HyOyZ3kZQUCDta5kaFZDbQh55vQ+HdcXgZk/57aP0NTXWIgEc26vlKGym
   5o+AbnZjmb+nHOqYHj1wHheBcIJEdbkNRBEl4igF5LNsBMf5kKnwQAMBN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="335793662"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="335793662"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 21:52:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="632865999"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 May 2022 21:52:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvtsF-0002LA-Px;
        Tue, 31 May 2022 04:52:55 +0000
Date:   Tue, 31 May 2022 12:51:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2517a0ba026a90d717f7bd9ee51098c10e93904d
Message-ID: <62959eee.s3Cftj/5JE61nbEP%lkp@intel.com>
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
branch HEAD: 2517a0ba026a90d717f7bd9ee51098c10e93904d  Merge branch 'acpi-osl' into linux-next

Unverified Warning (likely false positive, please contact us if interested):

kernel/reboot.c:554:43: warning: Parameter 'power_off' can be declared with const [constParameter]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-p002-20220530
|   `-- kernel-reboot.c:warning:Parameter-power_off-can-be-declared-with-const-constParameter
`-- x86_64-randconfig-p001-20220530
    `-- kernel-reboot.c:warning:Parameter-power_off-can-be-declared-with-const-constParameter

elapsed time: 722m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
mips                             allyesconfig
riscv                            allmodconfig
um                             i386_defconfig
mips                             allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
i386                 randconfig-c001-20220530
m68k                       m5249evb_defconfig
arm                       omap2plus_defconfig
mips                       capcella_defconfig
sh                   sh7770_generic_defconfig
m68k                          hp300_defconfig
h8300                            alldefconfig
powerpc                      mgcoge_defconfig
arm                         nhk8815_defconfig
sh                        sh7763rdp_defconfig
mips                     loongson1b_defconfig
arm                            lart_defconfig
s390                       zfcpdump_defconfig
powerpc64                           defconfig
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20220531
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
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
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20220530
x86_64               randconfig-a006-20220530
x86_64               randconfig-a004-20220530
x86_64               randconfig-a001-20220530
x86_64               randconfig-a002-20220530
x86_64               randconfig-a005-20220530
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a002-20220530
i386                 randconfig-a003-20220530
i386                 randconfig-a004-20220530
i386                 randconfig-a005-20220530
i386                 randconfig-a001-20220530
i386                 randconfig-a006-20220530
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220530
arc                  randconfig-r043-20220531
s390                 randconfig-r044-20220531
riscv                randconfig-r042-20220531
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     pseries_defconfig
mips                       lemote2f_defconfig
powerpc                      pmac32_defconfig
powerpc                      walnut_defconfig
mips                         tb0219_defconfig
powerpc                     kmeter1_defconfig
mips                malta_qemu_32r6_defconfig
arm                       imx_v4_v5_defconfig
arm                    vt8500_v6_v7_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220530
x86_64               randconfig-a013-20220530
x86_64               randconfig-a012-20220530
x86_64               randconfig-a014-20220530
x86_64               randconfig-a015-20220530
x86_64               randconfig-a016-20220530
i386                 randconfig-a012-20220530
i386                 randconfig-a011-20220530
i386                 randconfig-a014-20220530
i386                 randconfig-a016-20220530
i386                 randconfig-a013-20220530
i386                 randconfig-a015-20220530
hexagon              randconfig-r045-20220530
s390                 randconfig-r044-20220530
hexagon              randconfig-r041-20220530
riscv                randconfig-r042-20220530

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
