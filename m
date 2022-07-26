Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59D581672
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jul 2022 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiGZPb4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jul 2022 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbiGZPbz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jul 2022 11:31:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1524BED;
        Tue, 26 Jul 2022 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658849514; x=1690385514;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hl+u7USFyWlFOxUxd5I+dkiqpw0PVDQT5ymfIrpcXZU=;
  b=EmBCX1xSoqw2Ie12WlE8BRiUhxsy/rxlqlWcFFBktPkLqLP7k86pZXpq
   eAf17JNDWmMcpFIseoFpWaVbRLj4RxRG139rFjUAWnt8rYoo//JxpmxR/
   xzL5fwGjI0+fjnE8CINEypLVI5A98T6k2WLsENM8hoBKNnjkhl36WFDiQ
   xd3P4oBpGJKTtjxPdi4ycnMQbopaeVsOhzBiNnPbhgys8FypSkQQVn4YU
   cruxmVBg9WBmw4uJMqriRiqKMgd3LONgwZJy8orso1EKh35GHLAipBz7X
   IZuEvl6HzCQjSf7+nccSXr8C7BRAj9OogkEkAAinTWP+UksvgFFRllAR+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="267749208"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="267749208"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 08:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="927377453"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2022 08:31:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGMWs-00073o-2g;
        Tue, 26 Jul 2022 15:31:26 +0000
Date:   Tue, 26 Jul 2022 23:30:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e399ae3422730fa46abf97b3563c23274ecb8ceb
Message-ID: <62e008aa.hGXu5TSEWwXQkLxD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e399ae3422730fa46abf97b3563c23274ecb8ceb  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 1191m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
sh                        sh7763rdp_defconfig
mips                     loongson1b_defconfig
powerpc                     ep8248e_defconfig
ia64                             allmodconfig
csky                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
i386                                defconfig
i386                             allyesconfig
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
s390                 randconfig-r044-20220724
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
mips                         tb0287_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
