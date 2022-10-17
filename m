Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB592600532
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Oct 2022 04:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJQCWY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Oct 2022 22:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiJQCWY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Oct 2022 22:22:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C976744497;
        Sun, 16 Oct 2022 19:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665973341; x=1697509341;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cWkYhAdLuaSiTRewBbelfEEc6QGMlFnrQcbUtDRBuGc=;
  b=AJazEuYa79PRnuCFkSZCdpSvJGfGYlKryBQFl4kF9Ohb0nbMQnMNYMrx
   bRAVk6F6ecMot1MHr1li4WLmbhxuf0C8CmKC3esuWprOfq3YqBdhIF4g1
   mCK3PzU+Pkp40kGEOd9Y1woId9qSa1UxGR8+DHS+rhn4ZeRKIPU4OHp+G
   drODCRAoEV6WiPV1puyPM4oE8D3sVk2iiTEd47wSyWhhls/XMzXUsFjn0
   WbsqKjfSijY3J5c/rNfqB2PMBEBvo4dlhvk6fDZVhBhSppxxXhmyErncg
   Vk4ygwY0AlfaDDh7BtFBW0/mETb5F6aPehEKR+Fg4lZ530uKi5Z/uN1rB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="285413155"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="285413155"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 19:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="753479061"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="753479061"
Received: from lkp-server02.sh.intel.com (HELO 8556ec0e0fdc) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Oct 2022 19:22:19 -0700
Received: from kbuild by 8556ec0e0fdc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okFli-000049-35;
        Mon, 17 Oct 2022 02:22:18 +0000
Date:   Mon, 17 Oct 2022 10:21:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 134eb444363b548c34b7bf79d231a1ab7690cfb6
Message-ID: <634cbc1f.dw1aXk2jHDx35OSX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 134eb444363b548c34b7bf79d231a1ab7690cfb6  Merge branch 'acpi-resource' into bleeding-edge

elapsed time: 4611m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20221012
riscv                randconfig-r042-20221012
s390                 randconfig-r044-20221012
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
arc                              allyesconfig
powerpc                           allnoconfig
alpha                            allyesconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
s390                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a002
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
x86_64                           allyesconfig
arm                                 defconfig
sh                               allmodconfig
x86_64                        randconfig-a015
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a013
i386                          randconfig-a014
x86_64                        randconfig-a011
i386                          randconfig-a005
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig

clang tested configs:
hexagon              randconfig-r041-20221012
hexagon              randconfig-r045-20221012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a011
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a016
i386                          randconfig-a004
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
