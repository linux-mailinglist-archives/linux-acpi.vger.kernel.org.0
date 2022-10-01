Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985435F1BD9
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Oct 2022 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJAKpa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Oct 2022 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJAKp3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Oct 2022 06:45:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA863C8F4;
        Sat,  1 Oct 2022 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664621128; x=1696157128;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xiVJXuR8P1pRABToUvIhXZW5iUyJHHHG80SpQQPDLxI=;
  b=bE/wrLbhcKP3DR1+1lxIyqOHynT8jZ0WpAAN8oIdPb2B7l1N8lzb2HxI
   JebV/UO3lJ9BxXWnuZcvwFJZuYdlSU1ZgP0tjLHRO4FxYhlW8Xf6Jxjmi
   4CGc6S4bHl/v5drLxG9wDJ3QSBGyCXMksDXlKMLjAsY6X63Bznv6NZSDy
   mBfMiUQXxxfo2Lfz9Qo1Z/n9Zbr83tWwygAqjNXXabSdTWaW6nDjmFzEe
   ayqhT8gF3fJVLgeQHcRjitlakSGgmW4pt3M9exmSPYpo3clwf2XjJgCZw
   YlR3DgjVQUFHHT3LLEP6OSjiQtFct4HivXwH6e+PEhQOvVztlWoIMWIOs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="289527861"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="289527861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 03:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="653835538"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="653835538"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Oct 2022 03:45:26 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeZzq-00029L-0o;
        Sat, 01 Oct 2022 10:45:26 +0000
Date:   Sat, 01 Oct 2022 18:44:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 816cee8cb69ed35afedc0a1011493e5f8c6aeead
Message-ID: <63381a1d.1RMK5Xirt7dxFPZ9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 816cee8cb69ed35afedc0a1011493e5f8c6aeead  Merge branch 'thermal-core' into bleeding-edge

elapsed time: 979m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
arc                                 defconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
s390                             allmodconfig
arm                                 defconfig
m68k                             allmodconfig
s390                                defconfig
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
arc                  randconfig-r043-20220925
arm64                            allyesconfig
riscv                randconfig-r042-20220925
arm                              allyesconfig
i386                 randconfig-a001-20220926
arc                  randconfig-r043-20220926
x86_64               randconfig-a002-20220926
s390                 randconfig-r044-20220925
i386                 randconfig-a002-20220926
x86_64               randconfig-a005-20220926
x86_64                               rhel-8.3
i386                 randconfig-a003-20220926
x86_64               randconfig-a004-20220926
x86_64                        randconfig-a013
x86_64               randconfig-a006-20220926
x86_64                        randconfig-a011
i386                 randconfig-a004-20220926
i386                             allyesconfig
x86_64               randconfig-a001-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a006-20220926
x86_64               randconfig-a003-20220926
x86_64                        randconfig-a015
x86_64                           allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
i386                 randconfig-a011-20220926
i386                 randconfig-a015-20220926
x86_64                        randconfig-a012
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a016-20220926
x86_64                        randconfig-a014
i386                 randconfig-a012-20220926
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
