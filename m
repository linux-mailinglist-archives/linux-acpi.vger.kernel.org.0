Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADEA6C3095
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Mar 2023 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCULnb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Mar 2023 07:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCULna (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Mar 2023 07:43:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB2025956;
        Tue, 21 Mar 2023 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679399008; x=1710935008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qnNkkpmy7Rwc1eiUds7kCJbW1yhUf9MuxTVfSCSEH2Q=;
  b=GyU9wwL8obncCIkhqCN0OU3xkqMjI8cpS7MjcHwYy88H5BjSujeOX3E9
   ZatJz+4yC7XFSqxmf83iLltLD3VeCzalO9T+tbcuQQ8fqn1UiOMP/vlAd
   XaB30xoAlGZrXK6LQ2Br6CAaI1piYouYE0fy+sJsrN5KGVTljriTnpseg
   c/TXodAuJ/wSfU1z8GpUHkv/MOs+Ot4dS4W+d+HRkMpwk911jxv377Y/P
   BkQycx4gqF60P4YY2PRiswXk5XsycgZ2yv3t9zzJO2+QVJJWcKc4b6C0M
   MeJ8V88ggd3ravKHFZnqqLskY0fM5WCl6+6AOjZRlxe9fhyi1hyOiAoGD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="403790013"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="403790013"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 04:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="1010909543"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="1010909543"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Mar 2023 04:43:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peaOj-000BrW-28;
        Tue, 21 Mar 2023 11:43:25 +0000
Date:   Tue, 21 Mar 2023 19:42:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 52/63] kismet: WARNING: unmet direct
 dependencies detected for ISAPNP when selected by SND_AD1816A
Message-ID: <202303211932.5gtCVHCz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   226ec3112c6fa4db1188828f76319f7eb6eb85ee
commit: e46dd09e5172877dd18dce7703f13338f3732ce3 [52/63] PNP: add HAS_IOPORT dependencies
config: x86_64-kismet-CONFIG_ISAPNP-CONFIG_SND_AD1816A-0-0 (https://download.01.org/0day-ci/archive/20230321/202303211932.5gtCVHCz-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=e46dd09e5172877dd18dce7703f13338f3732ce3
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout e46dd09e5172877dd18dce7703f13338f3732ce3
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_ISAPNP --selectors CONFIG_SND_AD1816A -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303211932.5gtCVHCz-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ISAPNP when selected by SND_AD1816A
   .config:4899:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   .config:5957:warning: symbol value 'ONFIG_ARCH_MMAP_RND_COMPAT_BITS_MI' invalid for ARCH_MMAP_RND_COMPAT_BITS
   
   WARNING: unmet direct dependencies detected for ISAPNP
     Depends on [n]: PNP [=y] && (ISA [=n] || HAS_IOPORT && COMPILE_TEST [=y])
     Selected by [y]:
     - SND_AD1816A [=y] && SOUND [=y] && !UML && SND [=y] && SND_ISA [=y] && PNP [=y]
     - SND_ALS100 [=y] && SOUND [=y] && !UML && SND [=y] && SND_ISA [=y] && PNP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
