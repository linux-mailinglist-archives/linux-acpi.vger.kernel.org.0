Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510015A915B
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Sep 2022 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiIAH5X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Sep 2022 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiIAH5U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Sep 2022 03:57:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E92C9E8D;
        Thu,  1 Sep 2022 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662019038; x=1693555038;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aM7RmM5oLdR57n0tmAUEZLSoOLEkDuToJf2Jbm2ZbqU=;
  b=NSSWQqpnkil0Zt+bz1Z2MluH7CCnsweQaCLohg9AEqnaQk3iwMFL2y8z
   Z6i+22WpfQen+6s6tPyINCxcvgjbiLu+uScSkb45oT0mSa+JNv+uqaCEp
   Hyd0Xoui199Xaf3JfCu/UMOWyeni7Es0xDTBV7tyAMhePJ47F2X0U+Q0s
   +Q8EiEarNygbFm3QDH772aafbcKT0mtFAsTzaYsGVrFlNtMd5JjmuiX/v
   osKQbnx6mDg18sEE0xs/4ZLdLJlkmUVxUqyFTPwZtDy62EZf3uQnD4r4n
   dwlLbKz7bL3dKmPgVBnjEWhG43Z8GQerZMByBFUR8I9Idf27NYGIYoHXh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="278664690"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="278664690"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 00:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="738399823"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Sep 2022 00:57:16 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTf4e-00005o-0U;
        Thu, 01 Sep 2022 07:57:16 +0000
Date:   Thu, 01 Sep 2022 15:56:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f569faad1ef4d4f88432e6d5efba2562e0d1bc1f
Message-ID: <631065a0.1f0caBq0YvTQRxgc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f569faad1ef4d4f88432e6d5efba2562e0d1bc1f  Merge branch 'thermal-core' into bleeding-edge

elapsed time: 722m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220831
s390                 randconfig-r044-20220831
riscv                randconfig-r042-20220831
x86_64                              defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                               rhel-8.3
x86_64                        randconfig-a015
alpha                            allyesconfig
arc                              allyesconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           allyesconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
i386                          randconfig-a014
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                                 defconfig
x86_64                        randconfig-a006
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220831
hexagon              randconfig-r045-20220831
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
