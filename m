Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D615A227B
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Aug 2022 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbiHZH7N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Aug 2022 03:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245714AbiHZH7M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Aug 2022 03:59:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA0D475C;
        Fri, 26 Aug 2022 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661500751; x=1693036751;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gY1t62Dh1/1E5AbJkxKEBER/k9+hXi1zG813UEJ1pKA=;
  b=XzxL7VfNZzqXHbtu8u9FOz/cClXIpALSUcR0w/rl6GIJmPe3TPs09LGM
   iAVRk8PtmaZ2MkEiAGT56K2YyZnGdAnZC7+7NRrcDdQfXVGVQq90huELo
   +aLz9kuI7cvWPUA/OQd2GbyOJCz8onMgAr4kDS5IM1oWLNEoyMHqEewDf
   Q0+SY+iwSRON4XIXR6PEpiPEb0c5HpZI49+FYiOFXq4LmqTH7fzhHgfk/
   rc3M68PZtF9JHaIUizq8VlRf24ZIiT2gw17Zx5Gr7B0dSPbGu2DR8HyCv
   piLjS5skqRls7+DdPipkoIdluWoqqdVFg0YqD8u69foFX4zXpNBP9HtFk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="356168666"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="356168666"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 00:59:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="938666564"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 00:59:07 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRUF9-0003eM-16;
        Fri, 26 Aug 2022 07:59:07 +0000
Date:   Fri, 26 Aug 2022 15:58:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3da4255837efe5d8ae47e0cf88e27e86d912c54e
Message-ID: <63087d1d.nDmDFLxcgW+VpczK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3da4255837efe5d8ae47e0cf88e27e86d912c54e  Merge branch 'acpi-bus' into bleeding-edge

elapsed time: 720m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
loongarch                         allnoconfig
loongarch                           defconfig
alpha                               defconfig
x86_64                        randconfig-a004
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a002
s390                                defconfig
x86_64                        randconfig-a006
s390                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
arm                                 defconfig
i386                          randconfig-a014
i386                          randconfig-a003
i386                          randconfig-a012
sh                               allmodconfig
i386                          randconfig-a016
x86_64                        randconfig-a015
i386                          randconfig-a005
mips                             allyesconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a001
m68k                             allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20220824
arm64                            allyesconfig
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220824
alpha                            allyesconfig
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220823
arc                  randconfig-r043-20220825
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220825
hexagon              randconfig-r045-20220825
i386                          randconfig-a006
hexagon              randconfig-r041-20220823
riscv                randconfig-r042-20220825
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220824
s390                 randconfig-r044-20220823
s390                 randconfig-r044-20220825
riscv                randconfig-r042-20220823
hexagon              randconfig-r045-20220823

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
