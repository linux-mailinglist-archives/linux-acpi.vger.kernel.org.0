Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE716C3326
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Mar 2023 14:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCUNqi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Mar 2023 09:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCUNqh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Mar 2023 09:46:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CCC367CA;
        Tue, 21 Mar 2023 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679406396; x=1710942396;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZW8wdPHKShucaPeOtFDEvYAWNcF09UzyV28v8Mrljks=;
  b=NFPK6oMpKPtTUk6Cl9vopqPyccPuZeDJJHnsPiw0cjF7iBtyWEnQBMy/
   qDoPhxia/D8iCB+YahITAjTn0BjsT1VmceAYq2gdueFpmqerWI1J9LkIK
   LbhzteKz5TM8Ato3T4PPBA6gi3HjiKs3RFzzTLgAHPCMZIRCArq5DFh5y
   f0rykEzYWvu+JQV2glH+nbj9irNr9kY9gsGGmNAoBctjs2HDUgigpedt/
   q7eDsvNkuhFcKcUIlGNV0vV/Xn5dkc/XODTadB/OGaHPjdp4oyv4MC2QH
   vdVms5CK2buzsowqD5K14OYfmoE/tdzUVEKaOkZmsN5pVv32V1JH5agbv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="336446594"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="336446594"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:46:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="683880872"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="683880872"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Mar 2023 06:46:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pecJp-000Bx4-0R;
        Tue, 21 Mar 2023 13:46:29 +0000
Date:   Tue, 21 Mar 2023 21:46:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 52/63] kismet: WARNING: unmet direct
 dependencies detected for ISAPNP when selected by SND_ALS100
Message-ID: <202303212130.VdcuD2v8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   226ec3112c6fa4db1188828f76319f7eb6eb85ee
commit: e46dd09e5172877dd18dce7703f13338f3732ce3 [52/63] PNP: add HAS_IOPORT dependencies
config: x86_64-kismet-CONFIG_ISAPNP-CONFIG_SND_ALS100-0-0 (https://download.01.org/0day-ci/archive/20230321/202303212130.VdcuD2v8-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=e46dd09e5172877dd18dce7703f13338f3732ce3
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout e46dd09e5172877dd18dce7703f13338f3732ce3
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_ISAPNP --selectors CONFIG_SND_ALS100 -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303212130.VdcuD2v8-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ISAPNP when selected by SND_ALS100
   .config:4982:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   
   WARNING: unmet direct dependencies detected for ISAPNP
     Depends on [n]: PNP [=y] && (ISA [=n] || HAS_IOPORT && COMPILE_TEST [=y])
     Selected by [y]:
     - SND_ALS100 [=y] && SOUND [=y] && !UML && SND [=y] && SND_ISA [=y] && PNP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
