Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9BF5F07F8
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Sep 2022 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiI3Jua (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Sep 2022 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiI3Ju2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Sep 2022 05:50:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123FB8B2FF;
        Fri, 30 Sep 2022 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664531427; x=1696067427;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1wg7CA05LIEooOAq3MIE1pmjiNA5DsimMXjeordC+To=;
  b=R55E8KPowPlmT7zdgYJepMKxiRebpT8zAbqKo8WRfFPpRDoIcWwe9kDR
   VqqBUyP58oqFk6z7tLYXH/Ur5UP53MySTpV2rPsOzLuE9kVC1SGAQlu/k
   n8IKPA+U4vXOYU0mqq3C/rjQk6bl15+PVTcGS0YRXbvLk+G4IytxFUNdS
   aZ23UlCRzmwp98gGV1HAjxtiuq0V7LmDqBcowjpQvIuHE58Mu1UcZ3+ke
   q1KF/2pNvuha8IN+0JWJ78uVKrgqUz6Fdq7lblXsn9Ld8Rjr0dZ+3blu2
   Thqysmi/nguQye1cfFnD9js6xDcOclp8ubv+b2Jmo3C3yzBoYc7v1G4ok
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="289315561"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="289315561"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 02:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="655901493"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="655901493"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2022 02:50:24 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeCf2-0000s6-06;
        Fri, 30 Sep 2022 09:50:24 +0000
Date:   Fri, 30 Sep 2022 17:49:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fa117123159976b3799c5738677e0489f8537abc
Message-ID: <6336bbc0.9jrW43t4lioyUFMR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: fa117123159976b3799c5738677e0489f8537abc  Merge branches 'acpi-pm', 'acpi-docs' and 'acpi-misc' into linux-next

elapsed time: 833m

configs tested: 86
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
x86_64                               rhel-8.3
i386                                defconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64               randconfig-a002-20220926
x86_64                           allyesconfig
mips                             allyesconfig
x86_64               randconfig-a001-20220926
i386                 randconfig-a001-20220926
powerpc                          allmodconfig
x86_64               randconfig-a003-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
i386                 randconfig-a002-20220926
x86_64               randconfig-a005-20220926
i386                 randconfig-a003-20220926
arc                  randconfig-r043-20220925
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
riscv                randconfig-r042-20220925
i386                 randconfig-a006-20220926
arm                                 defconfig
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arm64                            allyesconfig
m68k                             allyesconfig
arm                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                        edosk7760_defconfig
m68k                        mvme147_defconfig
x86_64                           alldefconfig
m68k                        m5307c3_defconfig
i386                          randconfig-c001
powerpc                        cell_defconfig
m68k                                defconfig
arm                          gemini_defconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
sh                             shx3_defconfig
sh                     magicpanelr2_defconfig
mips                      fuloong2e_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                   microwatt_defconfig
mips                      malta_kvm_defconfig
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
