Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2900512C3C
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Apr 2022 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbiD1HIk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Apr 2022 03:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244789AbiD1HIf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Apr 2022 03:08:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC37C78D;
        Thu, 28 Apr 2022 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651129514; x=1682665514;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Tyx8UMLpzLkE5H7J9+iV5npaiElgUkBN8dO9mfu1X8=;
  b=dPK+tIfmzJ8XazDXjxXpBKaATbh4J/z1BEVTRZmIqWrSi/1ltEhgDSIi
   KmZmsQ6+WiguutFzjJsNMKyS06coFgwuRlG7mpwwJNag4SaOTDgOjoa8K
   eLg1rW25K4RMm9XUby023y0jfIYb3df9Yvco2CB2MlczRAFIy9bjvnOjm
   V0lLyZtqpVsPAJyrGqgSRRCyEVVmAuhAlbQ6ZiVOl96MCeayN9xOaI/bE
   EuWhIyAMDmFyqc/fN3dNwN0zYctYNo+zhyCxiIkQG8zputfeDq4MLApWD
   L4/hfHSan52AxhX+aazepcCH0+oTyjKvYwaEAU2pRy+55DMhvAmBh6mVk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266344667"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="266344667"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 00:05:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="682095251"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2022 00:05:12 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njyD9-00059b-BW;
        Thu, 28 Apr 2022 07:05:11 +0000
Date:   Thu, 28 Apr 2022 15:04:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:testing 12/12] drivers/idle/intel_idle.c:1854:13:
 warning: conflicting types for 'c1e_promotion_enable'; have 'void(void)'
Message-ID: <202204281547.5qD9L1sw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git testing
head:   55ecda6f25ef6de769ae64f162828aee4812c313
commit: 55ecda6f25ef6de769ae64f162828aee4812c313 [12/12] Merge branch 'intel-idle' into linux-next
config: x86_64-randconfig-c001 (https://download.01.org/0day-ci/archive/20220428/202204281547.5qD9L1sw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=55ecda6f25ef6de769ae64f162828aee4812c313
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm testing
        git checkout 55ecda6f25ef6de769ae64f162828aee4812c313
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/idle/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/idle/intel_idle.c: In function 'adl_idle_state_table_update':
   drivers/idle/intel_idle.c:1701:17: error: 'disable_promotion_to_c1e' undeclared (first use in this function)
    1701 |                 disable_promotion_to_c1e = true;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/idle/intel_idle.c:1701:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/idle/intel_idle.c:1706:9: error: implicit declaration of function 'c1e_promotion_enable' [-Werror=implicit-function-declaration]
    1706 |         c1e_promotion_enable();
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/idle/intel_idle.c: At top level:
>> drivers/idle/intel_idle.c:1854:13: warning: conflicting types for 'c1e_promotion_enable'; have 'void(void)'
    1854 | static void c1e_promotion_enable(void)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/idle/intel_idle.c:1854:13: error: static declaration of 'c1e_promotion_enable' follows non-static declaration
   drivers/idle/intel_idle.c:1706:9: note: previous implicit declaration of 'c1e_promotion_enable' with type 'void(void)'
    1706 |         c1e_promotion_enable();
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1854 drivers/idle/intel_idle.c

1aefbd7aeb7695 Rafael J. Wysocki 2020-01-10  1853  
da0e58c038e60e Artem Bityutskiy  2022-03-02 @1854  static void c1e_promotion_enable(void)
da0e58c038e60e Artem Bityutskiy  2022-03-02  1855  {
da0e58c038e60e Artem Bityutskiy  2022-03-02  1856  	unsigned long long msr_bits;
da0e58c038e60e Artem Bityutskiy  2022-03-02  1857  
da0e58c038e60e Artem Bityutskiy  2022-03-02  1858  	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
da0e58c038e60e Artem Bityutskiy  2022-03-02  1859  	msr_bits |= 0x2;
da0e58c038e60e Artem Bityutskiy  2022-03-02  1860  	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
da0e58c038e60e Artem Bityutskiy  2022-03-02  1861  }
da0e58c038e60e Artem Bityutskiy  2022-03-02  1862  

:::::: The code at line 1854 was first introduced by commit
:::::: da0e58c038e60e7e65d30813ebdfe91687aa8a24 intel_idle: add 'preferred_cstates' module argument

:::::: TO: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
