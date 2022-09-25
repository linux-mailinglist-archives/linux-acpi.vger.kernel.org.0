Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8BA5E9175
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Sep 2022 09:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiIYHhn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Sep 2022 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIYHhm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Sep 2022 03:37:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D03BC4E;
        Sun, 25 Sep 2022 00:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664091461; x=1695627461;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rQNy2xgvmhhAdYWJ2bjD8oJFB1DlxIHW7xpHRLF75zo=;
  b=KgPzjHg/6xV0HZ8C593PRLJXnfu5/o1tAPsDmHLzJlhAlwGo7jbFe3Ph
   2BsUSG6lLviizBMdD3L+Yg9By27Dej2ubetkOAqdKpiy4bsJjBaWcaVB5
   V/qSBlaDe7SmsH7HeygxwKt3x4Fz1fV9M1MH8I2DB1hTa4KGDtlv6nOjP
   w5qGOSDaa1HAfb34qlthw09GIZSBrhRhf3sDlr07L8OeLTPfAWQurPzI+
   qDghuiwNytOVov6xVZql10A0bAjIKmJOYeh8voWyUDio7zXUhw4I6366B
   gZuIR8yFJ76YzFBISTnAabOqH7a2rSScciusJ7BiBI/1ka5WfTjp2ttc8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="364871369"
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="364871369"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 00:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="763080918"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2022 00:37:37 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocMCn-0007dz-0u;
        Sun, 25 Sep 2022 07:37:37 +0000
Date:   Sun, 25 Sep 2022 15:37:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 ecfa396ef37aea5cf4b20db57585af16b110ac6b
Message-ID: <6330051e.S6XR1bK2uaiN/0Gq%lkp@intel.com>
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
branch HEAD: ecfa396ef37aea5cf4b20db57585af16b110ac6b  Merge branch 'powercap' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202209250438.1vajrE1K-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/acpi/sleep.c:1096:28: error: use of undeclared identifier 'SYS_OFF_MODE_RESTART_PREPARE'
drivers/acpi/sleep.c:1096:42: error: 'SYS_OFF_MODE_RESTART_PREPARE' undeclared (first use in this function); did you mean 'SYS_OFF_MODE_RESTART'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- i386-defconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a001
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a003
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a005
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a012
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a014
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a016
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- ia64-allmodconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- ia64-randconfig-r014-20220925
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- loongarch-allyesconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-allmodconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-allyesconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-defconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-a002
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-a004
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-a006
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-a011
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-a013
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-a015
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-8.3
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-8.3-kunit
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-8.3-kvm
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
`-- x86_64-rhel-8.3-syz
    `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-(first-use-in-this-function)
clang_recent_errors
|-- i386-randconfig-a002
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- i386-randconfig-a004
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- i386-randconfig-a006
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- i386-randconfig-a011
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- i386-randconfig-a013
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- i386-randconfig-a015
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- x86_64-randconfig-a001
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- x86_64-randconfig-a003
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- x86_64-randconfig-a005
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- x86_64-randconfig-a012
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
|-- x86_64-randconfig-a014
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE
`-- x86_64-randconfig-a016
    `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MODE_RESTART_PREPARE

elapsed time: 725m

configs tested: 58
configs skipped: 2

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
arm64                            allyesconfig
arc                  randconfig-r043-20220925
arm                              allyesconfig
riscv                randconfig-r042-20220925
s390                 randconfig-r044-20220925
i386                                defconfig
i386                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                               rhel-8.3
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220925
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
