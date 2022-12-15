Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B2864D647
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Dec 2022 06:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLOFxp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Dec 2022 00:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiLOFxo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Dec 2022 00:53:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13CD2AE3F;
        Wed, 14 Dec 2022 21:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671083623; x=1702619623;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vBYIKub1ILlCxfTrAPE1vLqEgAoyGgoHOBktpWHdYAU=;
  b=Iq5kW4BjR3QDf7N8jsE7BplxG98ufixNTBPz1JtT6hgqOYyGuSeSyrq/
   /b5FCQ3hCGJulFeXQ+FrUswK5SGk5ihxUhM76XkA2XCGIdlBCtUc0JT97
   rqDJApw4TYeTC8d2bBtre9gB1R9uaaq5+dDUBOFgIzxL6Emy5i3wO6Zm7
   nIlA+78N35r+tOK6OVE09E1STQMImUk1to2J6617fWOopyjpi5PKSsspw
   ShKIp4JMz7rY7x6sVSbIsZnNiizooN0vlnoSXa5yqcGdpZHzuaK/H0Oiq
   OPZQp4qA1/Neqco203lWQHZtmu3yki8Xg9OTZZCCVoEWRxdXMv7VFVN3R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="345678573"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="345678573"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 21:53:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="756221835"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="756221835"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2022 21:53:42 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p5hBd-00064K-09;
        Thu, 15 Dec 2022 05:53:41 +0000
Date:   Thu, 15 Dec 2022 13:52:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 02f29b079520d658643d9f1cf1d2e815bc38d396
Message-ID: <639ab635.cM9cGaA97WfPlvIt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 02f29b079520d658643d9f1cf1d2e815bc38d396  Merge branch 'thermal-next' into linux-next

elapsed time: 725m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
i386                                defconfig
um                           x86_64_defconfig
alpha                             allnoconfig
i386                              allnoconfig
um                             i386_defconfig
arc                               allnoconfig
arm                               allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a014
x86_64                           rhel-8.3-bpf
s390                 randconfig-r044-20221214
riscv                randconfig-r042-20221214
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
s390                                defconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
i386                          randconfig-a016
arc                  randconfig-r043-20221214
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                             allyesconfig
i386                          randconfig-a005
x86_64                              defconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a013
m68k                             allmodconfig
x86_64                        randconfig-a011
arc                              allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a015
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                             allmodconfig
riscv                             allnoconfig
mips                        bcm47xx_defconfig
sparc                       sparc32_defconfig
loongarch                        alldefconfig
mips                       bmips_be_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7269_defconfig
parisc                generic-64bit_defconfig
powerpc                 mpc834x_itx_defconfig

clang tested configs:
i386                          randconfig-a013
arm                  randconfig-r046-20221214
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a005
i386                          randconfig-a002
hexagon              randconfig-r041-20221214
hexagon              randconfig-r045-20221214
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-k001
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
