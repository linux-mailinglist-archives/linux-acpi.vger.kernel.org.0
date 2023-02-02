Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ACC6887C0
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Feb 2023 20:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjBBTsv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Feb 2023 14:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBBTsu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2023 14:48:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B2C28876;
        Thu,  2 Feb 2023 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675367329; x=1706903329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kiDPwFI1i9Pmd7k0PJDVU032KafNcHUft8lNUV3rfww=;
  b=oCHr44Q+S2bg6BWVK6fQgDi/+7lX9n9b9ODSHVXc1YXVhM3JO120Bkm9
   1xcZvMc3/OqyTEfPQc7vxYZWkCPXkvnXfEhhljHsDwTL7wjjqBPxwcZEH
   u7wDX2X7ZYIGuNbT9fDElFlmody+/ZgtSr3LbY7ydsGY/nnh5Ut5MY6N3
   HiYpRLo0vDmiKU8QjVe+7WJhM9yR+lBSVQ1xjq2xQFPZQ4cDEOzMchkpt
   EALV1umeg0ZIADIYMq+roAEsH97CaSPXarH48OTsLyuJT7Ml6n3U/MvLZ
   qps0CfRrNUTUpJdCI02jykxspfRPctVaENHiRrXuIV/FfJx5c/cKnZ0xI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="390945164"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="390945164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 11:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="729003553"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="729003553"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2023 11:48:47 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNfZe-0006nE-0e;
        Thu, 02 Feb 2023 19:48:46 +0000
Date:   Fri, 3 Feb 2023 03:48:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 173/175]
 drivers/thermal/intel/intel_powerclamp.c:422:6: warning: variable 'update'
 is used uninitialized whenever 'if' condition is false
Message-ID: <202302030328.3iKhirHI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f24bb5858fe63bcdab4f0680e7648f907304789c
commit: da0e3490ff71f89e5d3438ae0b2e412d543eab11 [173/175] thermal: intel: powerclamp: Use powercap idle-inject feature
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20230203/202302030328.3iKhirHI-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=da0e3490ff71f89e5d3438ae0b2e412d543eab11
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout da0e3490ff71f89e5d3438ae0b2e412d543eab11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thermal/intel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/intel/intel_powerclamp.c:422:6: warning: variable 'update' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (!(powerclamp_data.count % powerclamp_data.window_size_now)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/intel/intel_powerclamp.c:430:6: note: uninitialized use occurs here
           if (update) {
               ^~~~~~
   drivers/thermal/intel/intel_powerclamp.c:422:2: note: remove the 'if' if its condition is always true
           if (!(powerclamp_data.count % powerclamp_data.window_size_now)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/intel/intel_powerclamp.c:416:13: note: initialize the variable 'update' to silence this warning
           bool update;
                      ^
                       = 0
   1 warning generated.


vim +422 drivers/thermal/intel/intel_powerclamp.c

   408	
   409	/*
   410	 * This function is called from idle injection core on timer expiry
   411	 * for the run duration. This allows powerclamp to readjust or skip
   412	 * injecting idle for this cycle.
   413	 */
   414	static bool idle_inject_update(void)
   415	{
   416		bool update;
   417	
   418		/* We can't sleep in this callback */
   419		if (!mutex_trylock(&powerclamp_lock))
   420			return true;
   421	
 > 422		if (!(powerclamp_data.count % powerclamp_data.window_size_now)) {
   423	
   424			should_skip = powerclamp_adjust_controls(powerclamp_data.target_ratio,
   425								 powerclamp_data.guard,
   426								 powerclamp_data.window_size_now);
   427			update = true;
   428		}
   429	
   430		if (update) {
   431			unsigned int runtime = get_run_time();
   432	
   433			idle_inject_set_duration(ii_dev, runtime, duration);
   434		}
   435	
   436		powerclamp_data.count++;
   437	
   438		mutex_unlock(&powerclamp_lock);
   439	
   440		if (should_skip)
   441			return false;
   442	
   443		return true;
   444	}
   445	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
