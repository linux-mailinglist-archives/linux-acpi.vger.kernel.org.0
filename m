Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7551060DB9D
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Oct 2022 08:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiJZGwK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Oct 2022 02:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJZGwJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2022 02:52:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963019C2CA;
        Tue, 25 Oct 2022 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666767128; x=1698303128;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=48A3whc/JIcid0pEpadUw/To0jFtvo9Q0V16FOxTKTI=;
  b=BL5LpzgxRTz9LSyoZs1CJ7o0bvYwpEaDgGOcX89G8i4Xi9wwgtKWvYah
   uAeSMm3ZZGpNkb6AiI+9ilca8aKg8KWLr61In83dRqEYRPFN3I7pNqJbF
   +JkHEYvyeZePkXKE8hEaixpV+QEV/l2htq5t7Q5OMNKw3evmnSLMBYEdv
   h8N2g8EAzyW2aiCvvyetzlcsq3zsFU8AYIhfZ+WcexFeGYd6Jwi+ek9n1
   /oeSo2HI/8tMsCm1DS2GmfWTi5UaH0PT7YG4+iXzfN+15pvl+pqlRHBNC
   ly0nejHPbmYV+xIB0bmphPz3gQlOWprQ8l0LcNRkxh6s/6fDsn49ClfWd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="372084820"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="372084820"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 23:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="583052818"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="583052818"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2022 23:51:42 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onaGL-000779-2r;
        Wed, 26 Oct 2022 06:51:41 +0000
Date:   Wed, 26 Oct 2022 14:51:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4731015a0f0468e1ab6c2c0b417eac166f1a6d24
Message-ID: <6358d8f0.B/F75SsPK28VY6gy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4731015a0f0468e1ab6c2c0b417eac166f1a6d24  Merge branch 'devprop' into bleeding-edge

elapsed time: 723m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                              allyesconfig
um                           x86_64_defconfig
arc                               allnoconfig
alpha                            allyesconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
m68k                             allyesconfig
arc                                 defconfig
m68k                             allmodconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
mips                             allyesconfig
x86_64                              defconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
ia64                             allmodconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arc                  randconfig-r043-20221025
x86_64                        randconfig-a013
i386                 randconfig-a011-20221024
x86_64                        randconfig-a011
i386                 randconfig-a015-20221024
i386                 randconfig-a014-20221024
i386                 randconfig-a013-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a016-20221024
i386                             allyesconfig
x86_64                        randconfig-a015
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
sh                          kfr2r09_defconfig
arc                              alldefconfig
sh                           sh2007_defconfig
sh                        edosk7760_defconfig
sh                          r7780mp_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64               randconfig-a001-20221024
x86_64               randconfig-a005-20221024
x86_64               randconfig-a003-20221024
i386                          randconfig-a006
x86_64               randconfig-a004-20221024
x86_64               randconfig-a002-20221024
hexagon              randconfig-r041-20221025
riscv                randconfig-r042-20221025
hexagon              randconfig-r045-20221025
x86_64               randconfig-a006-20221024
s390                 randconfig-r044-20221025
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                        maltaup_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
