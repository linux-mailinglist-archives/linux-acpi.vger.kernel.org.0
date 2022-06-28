Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC8455CECB
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiF1GGM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 02:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiF1GGL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 02:06:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109F52315F;
        Mon, 27 Jun 2022 23:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656396369; x=1687932369;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2n/5vn8rOoyELei0tsqkTQhJvHu4rRiriyqzIYLuJ8k=;
  b=mKo1IEVUCl+h1xI0ZmDKatkloUdrG/u9msvziaRBTmf72B7mLJ/nPuq4
   +CevJKNwKxQCsY9aDu/KbIyOq9Ou3XzublUf9+YIm1HjdFPT/dYhivhys
   naNNWSY/TN78QOc6SwaPhlDtXIEc9HPA7+Sp/6UVLrd+AIqreAIqrQ2jh
   HXg7Gvu5wdmse3xe7T0aJGxQ3N8B5pvm5UK9XhfHhXIv42SA1aaWPU9tB
   2MU4r1MhuXV5lcUhFGSpv90SdgQnLEtmZtCVUnzEy40wScxoHg3iEGUXz
   wct0ZFbv2cB/be7b6rV1JA1S6X+3ZugIny3LsVRR8A/0kclCCxilsy7x6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281682813"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281682813"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 23:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="594633503"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2022 23:06:08 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o64MR-0009aI-QX;
        Tue, 28 Jun 2022 06:06:07 +0000
Date:   Tue, 28 Jun 2022 14:05:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 3ea94b067c49378a574fc477647ece5c2f41dccb
Message-ID: <62ba9a43.2Ijs96enQ2O4Tcxl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3ea94b067c49378a574fc477647ece5c2f41dccb  Merge branch 'acpi-bus' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202206281146.iWj1cpqY-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm64-allyesconfig
    |-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named-children
    `-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named-node

elapsed time: 726m

configs tested: 52
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64               randconfig-a012-20220627
x86_64               randconfig-a016-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a013-20220627
x86_64               randconfig-a014-20220627
x86_64               randconfig-a015-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a016-20220627
i386                 randconfig-a013-20220627
i386                 randconfig-a014-20220627
arc                  randconfig-r043-20220627
s390                 randconfig-r044-20220627
riscv                randconfig-r042-20220627
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a006-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a004-20220627
i386                 randconfig-a002-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a006-20220627
i386                 randconfig-a005-20220627
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
