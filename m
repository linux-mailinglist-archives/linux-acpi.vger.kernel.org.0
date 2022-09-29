Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9C5EF017
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiI2INU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 04:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiI2INT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 04:13:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8D13D869;
        Thu, 29 Sep 2022 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664439198; x=1695975198;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pkAcdd9WCoqbv6rQwZvQp7KdEX0nNmUATk0UEump9s8=;
  b=MNwwUw3esNsV8p6r5ITJuKOGfK/ZOfeJ/0sxaXknR2PJCLSVBKornOWL
   xFAq2RQHxyLZ/yGOcNBD7QeyAhQZYtO6zOocDdIJB/U4oneYfdUm2rWSD
   2ikkVEXT+i2LFlsl7QmFWL4M9mprI9B80oLiV2w1Fyaddmyj+s8eeM1L3
   Hc4h6cKjB5tRIRizOM5NBAnW/HUUq9gHnyzTPbgl+gnxsoU8ZFHQtZwwA
   z+C4TcYUci7S1fyvrObel4Z8TC9ZOi2icyccNj7g/y0WIb/bcsOdFMrBh
   LvoGCjYwKszgWX/NPp35ST4bI9uvH7BG7DZtetSGcWoJ4H52L+JUiDdaG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="288990739"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="288990739"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 01:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="797466372"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="797466372"
Received: from lkp-server01.sh.intel.com (HELO 6126f2790925) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Sep 2022 01:13:16 -0700
Received: from kbuild by 6126f2790925 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odofT-0000sS-1W;
        Thu, 29 Sep 2022 08:13:15 +0000
Date:   Thu, 29 Sep 2022 16:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 99546c51c86d8f9e56d2f9e2252b05b84d89c2ea
Message-ID: <63355385.9bVHW41B8Q1HuRkz%lkp@intel.com>
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
branch HEAD: 99546c51c86d8f9e56d2f9e2252b05b84d89c2ea  Merge branch 'acpi-pm' into bleeding-edge

elapsed time: 721m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                              defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64               randconfig-a004-20220926
i386                                defconfig
alpha                               defconfig
arc                  randconfig-r043-20220925
s390                             allyesconfig
s390                                defconfig
x86_64                               rhel-8.3
i386                 randconfig-a001-20220926
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64               randconfig-a006-20220926
i386                 randconfig-a002-20220926
arm                              allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a014
riscv                randconfig-r042-20220925
i386                 randconfig-a003-20220926
x86_64               randconfig-a001-20220926
x86_64                           allyesconfig
x86_64               randconfig-a003-20220926
i386                          randconfig-a012
x86_64               randconfig-a002-20220926
x86_64               randconfig-a005-20220926
i386                          randconfig-a016
x86_64                        randconfig-a015
i386                 randconfig-a004-20220926
arc                  randconfig-r043-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a006-20220926
s390                 randconfig-r044-20220925
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                             allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a014
i386                          randconfig-a013
hexagon              randconfig-r045-20220925
i386                          randconfig-a015
hexagon              randconfig-r041-20220926
i386                          randconfig-a011
hexagon              randconfig-r045-20220926
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220925
x86_64                        randconfig-a012
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
