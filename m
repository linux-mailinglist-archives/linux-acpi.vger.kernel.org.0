Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB163977D
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Nov 2022 18:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKZRyp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Nov 2022 12:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKZRyo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Nov 2022 12:54:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181D14082;
        Sat, 26 Nov 2022 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669485283; x=1701021283;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+HBvBEKjgzLh+b0Rh5KAiXiIJQYa7lQ+EKQIYo9j+Fc=;
  b=jiZpEOt+TFvAY2OT2IErBssaq1/EiSGqYfRFnVVVfY8p53dKfP1HPoQT
   2i0tyYHwrWKnSnoMXdoLe9Og5bXY1Vj4XTZxCNOqi0LO+4HEtUcZcbTVZ
   U3AzK/EGUA8WVOVWpb8VhEJWsuOBpVdAU3ciT4YkXgQp4Mgf0P9ZlmtnS
   HkumJAiIJ2V/qFWBDofyLXANbOSLu+iwTRetqkIK9ccXSHtIM5bgL7O5d
   BtSNBKmbYFGJKGlhZ+zRTTZuzOs6EIndMo4+YVb9lapd68suzzMgo6f2H
   6alhGUkggqT82t79P3qPxm2ptWdq3kvwzrbkZBU6krSmH7ayj7JNhWmfQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="341520756"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="341520756"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 09:54:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="673794897"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="673794897"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2022 09:54:40 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oyzNv-0006Ur-33;
        Sat, 26 Nov 2022 17:54:39 +0000
Date:   Sun, 27 Nov 2022 01:53:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 86c625dd876b10c15ec2075d8d0b1fccaa1486bc
Message-ID: <638252a5.ibwrwvRdXMcEEs8K%lkp@intel.com>
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
branch HEAD: 86c625dd876b10c15ec2075d8d0b1fccaa1486bc  Merge branch 'pnp' into bleeding-edge

elapsed time: 1353m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                  randconfig-r043-20221124
um                             i386_defconfig
um                           x86_64_defconfig
alpha                             allnoconfig
x86_64                           rhel-8.3-syz
i386                              allnoconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm                               allnoconfig
arc                               allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
ia64                             allmodconfig
s390                                defconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
m68k                             allyesconfig
s390                             allyesconfig
m68k                             allmodconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                          randconfig-a005
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
riscv                randconfig-r042-20221124
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
