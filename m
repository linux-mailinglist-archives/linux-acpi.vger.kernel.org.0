Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02043689737
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 11:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBCKsA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 05:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBCKr7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 05:47:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD3B443;
        Fri,  3 Feb 2023 02:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675421278; x=1706957278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SuTo8l/pXiGzxJcP/Cf8lFBatS3BM1QmwUzE3NjUOZk=;
  b=B5eSDBNkOvThhGaTrnGeu5mw0uyg3hOh6rosE25OJ70x62+wIwM2LUNh
   ncwnyVItdIYiTiirQosN0fMfbe+KS1aGo6yqW0g3hZ7lT16L9weYDcPZ2
   2Mxjj2j1vzm1X8AIavEvsZLLdJf+5oXZAR2P5o9Tcscl7XnS6rn7mzcCf
   zDWoRuGIS0gBQKclbGe8YmetSG9fnp6EmDS9ThmGL10MNr+Ej55I3eGJ+
   CzHWjbUXzD3F+aM7hh+TWlOssY7MzM+k91M4Z7RzAW0x/2MalL7G0U1v2
   F7IFGMDUNkfP33XAF3zNPXD8NQ76wVn5okLFQ79umH/d+17vHpD9YiVHx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="312374036"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="312374036"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 02:47:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="643233563"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="643233563"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2023 02:47:55 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNtbn-0000PN-0d;
        Fri, 03 Feb 2023 10:47:55 +0000
Date:   Fri, 3 Feb 2023 18:47:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: kismet: WARNING: unmet direct dependencies detected for IDLE_INJECT
 when selected by INTEL_POWERCLAMP
Message-ID: <202302031854.dRaSdTg4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   dcb17d36bed40f2ab07d6ffb318a5277b6c3378d
commit: da0e3490ff71f89e5d3438ae0b2e412d543eab11 thermal: intel: powerclamp: Use powercap idle-inject feature
date:   19 hours ago
config: x86_64-kismet-CONFIG_IDLE_INJECT-CONFIG_INTEL_POWERCLAMP-0-0 (https://download.01.org/0day-ci/archive/20230203/202302031854.dRaSdTg4-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=da0e3490ff71f89e5d3438ae0b2e412d543eab11
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout da0e3490ff71f89e5d3438ae0b2e412d543eab11
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_IDLE_INJECT --selectors CONFIG_INTEL_POWERCLAMP -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for IDLE_INJECT when selected by INTEL_POWERCLAMP
   .config:4831:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   .config:5885:warning: symbol value 'ONFIG_ARCH_MMAP_RND_COMPAT_BITS_MI' invalid for ARCH_MMAP_RND_COMPAT_BITS
   
   WARNING: unmet direct dependencies detected for IDLE_INJECT
     Depends on [n]: POWERCAP [=y] && CPU_IDLE [=n]
     Selected by [y]:
     - INTEL_POWERCLAMP [=y] && THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] || COMPILE_TEST [=y]) && X86 [=y] && CPU_SUP_INTEL [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
