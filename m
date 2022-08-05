Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8536258A531
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Aug 2022 06:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiHEEJN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Aug 2022 00:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiHEEJM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Aug 2022 00:09:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD261137;
        Thu,  4 Aug 2022 21:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659672551; x=1691208551;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GQCMUSPbjr7vZHAJ2+HZlUcSjr+99CWpiXGDIFmbmqY=;
  b=iRQAaaZrmNaLvt96oFJJ0TLQNfqthYCj/NPUZMN5nrJhujEAkXDk/T5m
   C7bldPEN81YFmjNRN/lehCAWsAfc0JTf1M9xPZFu5TsmbH6uI1SBJJVDn
   Ln4HU/26E7jBYBVQ2HitHvqgL7ohJg+Cz6V6l5Dtbm/NLeQDY4I172Y7A
   iQjsV+N8WjF5VpaifZYVsTf6WJub8fddQiWuC5KYfhWCXEpuF4m5iU/0N
   NVHgJiGUTx9jPvMg9vM3tUZQypr2HInJsyiZ0CkmrNjoD2LpciCuw59I+
   YbDsEUsZHqw13monEA8GLl4QGgY7LvnV0GEph8GDO4ODZ0urKdtKwVNZK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="316003602"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="316003602"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 21:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="631867807"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2022 21:09:09 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJoe4-000J7D-2h;
        Fri, 05 Aug 2022 04:09:08 +0000
Date:   Fri, 05 Aug 2022 12:08:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9851f9cb75d0cfdfcfa1a4586432eb4712491bfc
Message-ID: <62ec97c1.IB9/QGh+mzAn83I7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9851f9cb75d0cfdfcfa1a4586432eb4712491bfc  Merge branches 'thermal-tools', 'thermal-core' and 'thermal-intel' into linux-next

elapsed time: 718m

configs tested: 67
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                             allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
x86_64                           allyesconfig
m68k                             allyesconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20220804
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a003
powerpc                           allnoconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                         amcore_defconfig
sh                             shx3_defconfig
parisc                generic-64bit_defconfig
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
hexagon              randconfig-r045-20220804
hexagon              randconfig-r041-20220804
x86_64                        randconfig-a005
riscv                randconfig-r042-20220804
x86_64                        randconfig-a001
s390                 randconfig-r044-20220804
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
arm                        mvebu_v5_defconfig
mips                        bcm63xx_defconfig
arm                              alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
