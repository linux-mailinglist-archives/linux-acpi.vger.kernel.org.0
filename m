Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE75E9855
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Sep 2022 05:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIZD4d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Sep 2022 23:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIZD4c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Sep 2022 23:56:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CADC21E32;
        Sun, 25 Sep 2022 20:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664164591; x=1695700591;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eh086qVFucH8dlz3eoG8NObR7R6ezc7PKEErDjfY2vM=;
  b=JjT+1ZlgWYmDUt9oYUpvAP64N7HcLGz+JMfVjmsrTMrljVrgFRiGegWa
   UEQiPEI6iZBLGMmlWl0/imI2QJhdWra5FkysH4AkVDq8/2Ctx62Efr4ul
   eRTq7eQSbIQFZxQLDWDwb00jnDMbdMxsNakLdh9D9zcqy+ohgGQH0qtUl
   Ly/iP94ncdHYuyF/0sup8tmyYTOhzGnxVUtR1bocbkkHhNb5J18NpnZR3
   IKAVPTL7gawtlGa5aYJbcY0TTeHZezSdYDBAUjbOHe/0Rqck3IEbBrMbr
   KbnloScIII5DVuhnlgzTEFnw9rjWg3DqWxe9QwS/vxdwekr+Fy/luuWaP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="284048494"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="284048494"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 20:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="572064473"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="572064473"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2022 20:56:29 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocfEK-0008f8-0l;
        Mon, 26 Sep 2022 03:56:28 +0000
Date:   Mon, 26 Sep 2022 11:56:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 392b72b87ef168779f8651662155dc60e723d491
Message-ID: <633122d8.gE3EroSeVgRKEsTv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 392b72b87ef168779f8651662155dc60e723d491  Merge branches 'pm-core' and 'powercap' into bleeding-edge

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
i386                                defconfig
arc                  randconfig-r043-20220925
i386                          randconfig-a001
i386                          randconfig-a003
arc                                 defconfig
powerpc                          allmodconfig
arm                                 defconfig
i386                          randconfig-a005
sh                               allmodconfig
x86_64                           rhel-8.3-syz
s390                 randconfig-r044-20220925
x86_64                         rhel-8.3-kunit
alpha                               defconfig
riscv                randconfig-r042-20220925
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
x86_64                        randconfig-a015
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                               rhel-8.3
arm                              allyesconfig
s390                             allmodconfig
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
x86_64                        randconfig-a004
arm64                            allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                           allyesconfig
s390                                defconfig
m68k                             allyesconfig
ia64                             allmodconfig
i386                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                             allyesconfig
alpha                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220925
i386                          randconfig-a002
hexagon              randconfig-r041-20220925
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
