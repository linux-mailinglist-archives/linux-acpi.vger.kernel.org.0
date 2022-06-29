Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B799655F4D7
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jun 2022 06:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiF2EEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Jun 2022 00:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF2EEu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2022 00:04:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F9E2ED56;
        Tue, 28 Jun 2022 21:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656475489; x=1688011489;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cQ9/dgTUHz+6F1S0ByxMyzLZK/xRRhC6qkIAcWuWLXM=;
  b=Jd9wHcxULgI+zawLFxOjAkKD+gjnkHYvJS1k7xvUzWaZEC5EXeRWIRUW
   B4hh0IqSBsVjTrqPzTJW4OhDmKEfwsocoIgZjBPALVPzTr4gUNNoesn1A
   U+uBN+3HBl4CmA1rN0R38tqgXMp0crAT1GDVfRjiT6QE778Ba0KKyIL0n
   2Dq2PGY1ZAzR67Kk++QULZoSOYLaoQ5Sx4AMKx5vmKY8lSUrglUjJV7b5
   eo0CaDcO8GDXUCHqZMjCeRzGkXE+uH1Fqt09k09g2jLICnJYqhnNIFgOB
   xObdGzEV9asky0JM1q5mq9tpLdUO38msLPM+NmtEf5w3KXfcCTKPwhNIF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="264954998"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="264954998"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 21:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="693399191"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2022 21:04:46 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6OwY-000AtE-Ao;
        Wed, 29 Jun 2022 04:04:46 +0000
Date:   Wed, 29 Jun 2022 12:04:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 4035647418c1b31bcc12e6cfafc01f61f0c649ea
Message-ID: <62bbcf36.pFBdqnxFoqglQFOC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4035647418c1b31bcc12e6cfafc01f61f0c649ea  Merge branch 'acpi-bus' into linux-next

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202206281146.iWj1cpqY-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   |-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named-children
|   `-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named-node
`-- ia64-allmodconfig
    |-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named-children
    `-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named-node

elapsed time: 722m

configs tested: 70
configs skipped: 2

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220627
powerpc                      ppc40x_defconfig
arm                        realview_defconfig
arm                            pleb_defconfig
parisc64                            defconfig
arm                          pxa910_defconfig
ia64                         bigsur_defconfig
arm                       aspeed_g5_defconfig
sh                   sh7770_generic_defconfig
arc                            hsdk_defconfig
arm                         cm_x300_defconfig
riscv                            allyesconfig
ia64                             allmodconfig
x86_64               randconfig-k001-20220627
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64               randconfig-a012-20220627
x86_64               randconfig-a016-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a013-20220627
x86_64               randconfig-a014-20220627
x86_64               randconfig-a015-20220627
i386                 randconfig-a014-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a016-20220627
i386                 randconfig-a013-20220627
arc                  randconfig-r043-20220627
s390                 randconfig-r044-20220627
riscv                randconfig-r042-20220627
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func

clang tested configs:
arm                      pxa255-idp_defconfig
arm                            dove_defconfig
x86_64               randconfig-a004-20220627
x86_64               randconfig-a006-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
i386                 randconfig-a002-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a005-20220627
i386                 randconfig-a006-20220627
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
