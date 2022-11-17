Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9674762D56F
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Nov 2022 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiKQItL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Nov 2022 03:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiKQIsz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Nov 2022 03:48:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826FE5800A;
        Thu, 17 Nov 2022 00:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668674926; x=1700210926;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GeIgJvOZjbf40md/+WvCeVkFtxPHTdokqPztjR0SS/s=;
  b=b41AfsldF4icyxSN95Hab91z8myoBifNtElSLgQZuJygA7DKI5sn9sl+
   pHib75reDe6iZABPQlEGBPd3Qx7+4IMXIbSPRxnbPQwg05yaNOEfZf3km
   3xytrRf6s5avQSt96S1jvWEN29UvVIrtZACLxX4+NRmbL6vzMuFkWJyRf
   npiDoFi+yY3zF/ciOBa/FRbs678E509MH/vQ8wdYcslwXO/9+l6aLpbOH
   MHH7MzdPa5edubwvf4NQK5pVdeiQ+AlAFqCGuq6EqOWLDzkZQ3InBfilG
   2G677ryLBTQPRV2dAcer+eQlJ5zZUdtECHeamYA3D18WnpEnC9743W61R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="399085888"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="399085888"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 00:48:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="764684015"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="764684015"
Received: from lkp-server01.sh.intel.com (HELO 55744f5052f8) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2022 00:48:44 -0800
Received: from kbuild by 55744f5052f8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovaZf-000055-33;
        Thu, 17 Nov 2022 08:48:43 +0000
Date:   Thu, 17 Nov 2022 16:48:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 45d898cbd5d7f1a3dd646dadbf7c597211680d77
Message-ID: <6375f543.8CGNDmOQoFJN64O9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 45d898cbd5d7f1a3dd646dadbf7c597211680d77  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 725m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221116
s390                             allmodconfig
x86_64                          rhel-8.3-func
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
ia64                             allmodconfig
arm                               allnoconfig
i386                                defconfig
alpha                            allyesconfig
powerpc                           allnoconfig
arc                              allyesconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a015
m68k                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                             allmodconfig
sh                               allmodconfig
x86_64                              defconfig
i386                          randconfig-a012
i386                          randconfig-a001
i386                          randconfig-a016
i386                          randconfig-a003
i386                          randconfig-a014
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                               rhel-8.3
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221116
hexagon              randconfig-r041-20221116
riscv                randconfig-r042-20221116
s390                 randconfig-r044-20221116
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
