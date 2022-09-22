Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091305E5C0C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 09:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiIVHMz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Sep 2022 03:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiIVHMW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2022 03:12:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F1B7EDA;
        Thu, 22 Sep 2022 00:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663830733; x=1695366733;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hrFEGOOTR5E0lv2UWJquhx4Tlo3vC0i+tTZYOkAGxZo=;
  b=WaObvi+/G2uKU5NtyJS7rkaRc0+LiaR1bHqjJOq5rnXq8oHVlapGgRaH
   Qgxzk2vLg7+g75S+1OEBCY5NUTMgTs5UEMTvJckDeGywD0AeDmBwNRXU/
   Uni90UoZCEUonB7HI/ryBltLy1t0QJsYIFdnOqWxb/wh0HxYufVxmYfsK
   s7gSYY6fK44QDsNIwHwhWMLr4d8R4sJXNIpzc4fSTIn8FUFgb137/FvPX
   0LUVA2NpU/HHSKW5ErNb16oF4T8ARtP52Z5TdEbQ4eYPaGjXlTGB9Trck
   JChT8rIMAmdZh3ZRYWWH6NZ/G6QAhdpTk8c2sdjkRjUAFeSjCBDswcG5w
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364199443"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="364199443"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 00:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="652855234"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Sep 2022 00:12:05 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obGNQ-0004Pi-1h;
        Thu, 22 Sep 2022 07:12:04 +0000
Date:   Thu, 22 Sep 2022 15:11:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 65dc2656226949bc594ef5367dd29b7cb8ca27eb
Message-ID: <632c0a9b.Uy4+mGNx8fBFsycG%lkp@intel.com>
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
branch HEAD: 65dc2656226949bc594ef5367dd29b7cb8ca27eb  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
alpha                            allyesconfig
arc                              allyesconfig
arc                  randconfig-r043-20220921
m68k                             allyesconfig
riscv                randconfig-r042-20220921
m68k                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
i386                                defconfig
powerpc                          allmodconfig
s390                 randconfig-r044-20220921
sh                               allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                        randconfig-a011
x86_64                              defconfig
arm                                 defconfig
i386                             allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                               rhel-8.3
i386                          randconfig-a014
x86_64                           allyesconfig
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
