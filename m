Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C0A527709
	for <lists+linux-acpi@lfdr.de>; Sun, 15 May 2022 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiEOKfM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 May 2022 06:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiEOKe7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 May 2022 06:34:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB9A286DC;
        Sun, 15 May 2022 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652610856; x=1684146856;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D2zM/NOEft1xXBFaRL/87t/mkHUG/94CxpYCSdy6ZDc=;
  b=ZVAVM1Pb73P86KKZmlz858ljRwHlJmYfZ6SWcbCq2iNC/EdHXYAKRYFk
   Wi7SLDCDX3/Ag0by93J74gr2pehfiC4AfxtH9nxZUzf+Prc27SCCKb0Ke
   yvbayHkVfNKBAkZKQzqV66gAklJJj7SzzZZhYebjMdEBoqURb6Jdaj94Y
   tL3qWhHYzAvwkqN29SMlIewEQcIWXvkoFcywfhLBa8UHIUA+R5FpaBejs
   5e0mVcXmFy94n6wMVVy0dDUxW+Hr/7Ed+8grSUGBWRZX5Lj2ghh0CBXo+
   v9hTl6aihNPLptT0kgtCFTMy5XGb56ccaRjUUM/AiuB/OjPP9/o0dgCgd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="258184980"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="258184980"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 03:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="740814903"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2022 03:34:11 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqBZi-0001X7-Nn;
        Sun, 15 May 2022 10:34:10 +0000
Date:   Sun, 15 May 2022 18:34:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 60c4d1a7db661a73f444de5563a84e57ce78dc76
Message-ID: <6280d718.XFcnVdyqKBjMBerm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
branch HEAD: 60c4d1a7db661a73f444de5563a84e57ce78dc76  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 4002m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
mips                         bigsur_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        trizeps4_defconfig
mips                         tb0226_defconfig
arm                         lpc18xx_defconfig
m68k                          atari_defconfig
ia64                         bigsur_defconfig
arc                     haps_hs_smp_defconfig
arc                        nsim_700_defconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
sh                            hp6xx_defconfig
sh                           se7751_defconfig
sh                          rsk7264_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
parisc64                            defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220512
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                                  kexec
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220512
arm                  randconfig-c002-20220512
s390                 randconfig-c005-20220512
i386                          randconfig-c001
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
arm                         orion5x_defconfig
powerpc                      ppc64e_defconfig
powerpc                     tqm5200_defconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
mips                      pic32mzda_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
