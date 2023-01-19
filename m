Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23796733D1
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 09:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjASIhA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 03:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjASIg7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 03:36:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0E04DBC5;
        Thu, 19 Jan 2023 00:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674117417; x=1705653417;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5N4kKIs+Ji8GAVVunCT2SNT9lJtH1DvKFjzNvHpufmU=;
  b=IhTyVsWkHwvHopqps7r6yq8m/cDbrXzvrYZwMn9Lky+XUvmVwFfgdPlI
   YFW+LI6WytC1tLXABuZfMjlYpAq5DnYEIk63gj8IwwbC959sVL/vlt976
   RRobdQBawMx1g2JmrmQTDpZ62BIxAeq/gIZ/cy6JoxEQMO7GhHMuPTVyj
   i4zyssZ35w7aEy+2Ad4KHoB4ltRMO2XKqoPa8vu7WVa6GIDIG+xayoO6X
   Da1dutAj74xjGkOuxw+IgtMRiDmf6+WSVJNS/Gvhx8DGFUqQf7Y+QAGDR
   vH7PE249XvYi7Yd9Q59YL495Aw5Qi2LfoUhJSyrJNKfpzJ6EjkV/2+Jdt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="313103700"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="313103700"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:36:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783977782"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="783977782"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2023 00:36:48 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIQPa-0001JR-2W;
        Thu, 19 Jan 2023 08:36:42 +0000
Date:   Thu, 19 Jan 2023 16:36:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 51381741a3b6c722ef18496645debda123fe2afe
Message-ID: <63c90107.Y73IBWUoF3FXeWwq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 51381741a3b6c722ef18496645debda123fe2afe  Merge branch 'acpi-battery' into bleeding-edge

elapsed time: 723m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
arm                                 defconfig
mips                             allyesconfig
x86_64                              defconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20230118
x86_64                           allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
s390                 randconfig-r044-20230118
riscv                randconfig-r042-20230118
sh                               allmodconfig
ia64                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
arc                                 defconfig
i386                          randconfig-a005
s390                             allmodconfig
alpha                               defconfig
alpha                             allnoconfig
i386                              allnoconfig
x86_64                        randconfig-a004
arc                               allnoconfig
arm                               allnoconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
s390                                defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                             allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a015
m68k                             allyesconfig
riscv                             allnoconfig

clang tested configs:
hexagon              randconfig-r045-20230118
hexagon              randconfig-r041-20230118
arm                  randconfig-r046-20230118
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
