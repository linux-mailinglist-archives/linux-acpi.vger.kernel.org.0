Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9991450E7CC
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Apr 2022 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbiDYSLc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Apr 2022 14:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbiDYSLb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Apr 2022 14:11:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692E10772E;
        Mon, 25 Apr 2022 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650910106; x=1682446106;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=o3L9DbsHcCsscF7qtxYsQTb6HK5BgXKp4ZCB7vwcXD8=;
  b=A3vB3UBfn0wJ5hiXlNAeFakxkoenYsCd5qw7HnZhfdas8aZDSOqP70uk
   wWxwAjvy9mivNDpHrj4UFzrYkOUotVXS96vho7PjXWzrmkynaGbcb+orG
   kgE11vsvQuPY6TRv2tAtZSAstshpHLp6yaxUOC0Uc7Nu7HEVb7AoUGTlj
   2+9SEk2yMp6bPToAxLi+DwLtmKb3vhCTybUwmXmmJMVb7yJZQaW+mR3Vg
   GLNA6S4TwOVcTGCG6wAR2CPlgBaEjIoTVFWI8vvEj/T6JdKuPLmY71weQ
   774tHFZvZbdGojeGje7ChUN4S+pDkEZCWqfWr1ZiCAXMgnrBAMqUKdaT1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="328265467"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="328265467"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:08:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="807153126"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Apr 2022 11:08:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj38J-0002ks-Sz;
        Mon, 25 Apr 2022 18:08:23 +0000
Date:   Tue, 26 Apr 2022 02:08:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 f23bedef4354b1e8a69a25d8c9c1201e6d8e8762
Message-ID: <6266e387.bctpuhyghUvd25GS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f23bedef4354b1e8a69a25d8c9c1201e6d8e8762  Merge branch 'acpi-pci' into bleeding-edge

Warning reports:

https://lore.kernel.org/linux-pm/202204240259.PyW8hsJz-lkp@intel.com
https://lore.kernel.org/linux-pm/202204241452.pAvKt2JP-lkp@intel.com

Warning: (recently discovered and may have been fixed)

WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in reference from the function hsr_netlink_exit() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x15ff5e0): Section mismatch in reference from the function dm_stats_init() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in reference from the function btintel_send_intel_reset() to the variable .exit.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in reference from the function sctp_sched_ops_register() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1bf624c): Section mismatch in reference from the function sctp_sched_ops_init() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in reference from the function sctp_sched_set_sched() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in reference from the function sctp_sched_get_sched() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in reference from the function component_compare_dev_name() to the variable .exit.text:.LFB4478
WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .rodata:_entry.30

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- riscv-buildonly-randconfig-r002-20220421
    |-- Section-mismatch-in-reference-from-the-function-btintel_send_intel_reset()-to-the-variable-.exit.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-component_compare_dev_name()-to-the-variable-.exit.text:.LFB4478
    |-- Section-mismatch-in-reference-from-the-function-dm_stats_init()-to-the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-hsr_netlink_exit()-to-the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-sctp_sched_get_sched()-to-the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-sctp_sched_ops_init()-to-the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-sctp_sched_ops_register()-to-the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-sctp_sched_set_sched()-to-the-variable-.init.text:.L0
    `-- Section-mismatch-in-reference-from-the-variable-.L0-to-the-variable-.rodata:_entry.

elapsed time: 4386m

configs tested: 109
configs skipped: 4

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                          simpad_defconfig
m68k                        m5407c3_defconfig
um                                  defconfig
powerpc                   currituck_defconfig
sh                        edosk7760_defconfig
powerpc                      ppc40x_defconfig
arc                          axs103_defconfig
sparc                               defconfig
m68k                             allyesconfig
nios2                            alldefconfig
powerpc                      tqm8xx_defconfig
arm                          badge4_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                   motionpro_defconfig
powerpc                      pcm030_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                  randconfig-c002-20220422
x86_64                        randconfig-c001
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220422
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                 randconfig-c004-20220424
arm                  randconfig-c002-20220424
powerpc              randconfig-c003-20220424
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220424
riscv                randconfig-c006-20220424
mips                       rbtx49xx_defconfig
riscv                    nommu_virt_defconfig
powerpc                      walnut_defconfig
mips                         tb0219_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220422
riscv                randconfig-r042-20220422
hexagon              randconfig-r045-20220422
s390                 randconfig-r044-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
