Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75704584B00
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jul 2022 07:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiG2FR0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jul 2022 01:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiG2FR0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jul 2022 01:17:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79CA459A0;
        Thu, 28 Jul 2022 22:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659071844; x=1690607844;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xUxX15pZtSECEOF2hlI0jHwjsyiBPIivBMlq619fnT8=;
  b=QJrrv2A8ZIfDlwzmIog92phuXSZ/DbHHH5k4su0eT6XiPI50FmRmWafW
   ge4jKrXIVj57xjw467equO16Nj/znFVwLQlJyK8qy66QV/cAqXTEN32Nh
   e9xFCsKS210zeFZ/BkemG6dGWca5rXsFRmN8q+5X2fE8g20ZhD/1BBj3o
   gnUKauWEuWiOAS2IOJxdUYcGaq+F1SUzZse+HHTH3aqy5bsQd7hAcpRlj
   HasIiMZuUmAuHoZZ+ctsvW9LIMF4/JpX+tkaO3B+qPXmNhMUsMmROOoL+
   9alT0adsiGbPlEWvCq8a7ugEyP+bIxf3iQywZ4RO7jxFXYTmrDCL15XUO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="374995710"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="374995710"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 22:17:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="928613260"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2022 22:17:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHING-000B8Q-1o;
        Fri, 29 Jul 2022 05:17:22 +0000
Date:   Fri, 29 Jul 2022 13:16:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 584787d16c07afa9d691dd2ee09a630b874d725e
Message-ID: <62e36d33.+CG5CmxllbfwfCnC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 584787d16c07afa9d691dd2ee09a630b874d725e  Merge branch 'acpi-pci' into bleeding-edge

elapsed time: 704m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                                defconfig
arm                                 defconfig
x86_64                        randconfig-a015
i386                             allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
i386                          randconfig-a012
powerpc                          allmodconfig
arm64                            allyesconfig
i386                          randconfig-a016
sh                               allmodconfig
arm                              allyesconfig
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a004
arc                  randconfig-r043-20220728
riscv                randconfig-r042-20220728
s390                 randconfig-r044-20220728
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a005
i386                          randconfig-a011
hexagon              randconfig-r045-20220728
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220728
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
