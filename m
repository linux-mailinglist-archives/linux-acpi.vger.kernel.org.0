Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1443F431
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 02:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhJ2BBg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 21:01:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:35743 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhJ2BBg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Oct 2021 21:01:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="210608771"
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="gz'50?scan'50,208,50";a="210608771"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 17:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="gz'50?scan'50,208,50";a="665639283"
Received: from lkp-server01.sh.intel.com (HELO 3b851179dbd8) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2021 17:59:05 -0700
Received: from kbuild by 3b851179dbd8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgGEa-0002lY-Qx; Fri, 29 Oct 2021 00:59:04 +0000
Date:   Fri, 29 Oct 2021 08:58:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        markpearson@lenovo.com, pobrn@protonmail.com,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2] ACPI: platform_profile: Add support for notification
 chains
Message-ID: <202110290851.d6ReiRwO-lkp@intel.com>
References: <20211025210303.29083-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20211025210303.29083-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mario,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v5.15-rc7 next-20211028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/ACPI-platform_profile-Add-support-for-notification-chains/20211026-050443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-a013-20211028 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5db7568a6a1fcb408eb8988abdaff2a225a8eb72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/753ef2d5047b65eb707df546173703ca66305f95
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/ACPI-platform_profile-Add-support-for-notification-chains/20211026-050443
        git checkout 753ef2d5047b65eb707df546173703ca66305f95
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/platform/x86/asus-wmi.c:2172:12: error: static declaration of 'platform_profile_get' follows non-static declaration
   static int platform_profile_get(struct platform_profile_handler *pprof,
              ^
   include/linux/platform_profile.h:42:5: note: previous declaration is here
   int platform_profile_get(enum platform_profile_option *profile);
       ^
>> drivers/platform/x86/asus-wmi.c:2239:45: error: incompatible function pointer types assigning to 'int (*)(struct platform_profile_handler *, enum platform_profile_option *)' from 'int (enum platform_profile_option *)' [-Werror,-Wincompatible-function-pointer-types]
           asus->platform_profile_handler.profile_get = platform_profile_get;
                                                      ^ ~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/platform_profile_get +2172 drivers/platform/x86/asus-wmi.c

2daa86e78c494d Leonid Maksymchuk 2019-12-15  2170  
c63d44ae602419 Luke D. Jones     2021-08-19  2171  /* Platform profile ***********************************************************/
c63d44ae602419 Luke D. Jones     2021-08-19 @2172  static int platform_profile_get(struct platform_profile_handler *pprof,
c63d44ae602419 Luke D. Jones     2021-08-19  2173  				enum platform_profile_option *profile)
c63d44ae602419 Luke D. Jones     2021-08-19  2174  {
c63d44ae602419 Luke D. Jones     2021-08-19  2175  	struct asus_wmi *asus;
c63d44ae602419 Luke D. Jones     2021-08-19  2176  	int tp;
c63d44ae602419 Luke D. Jones     2021-08-19  2177  
c63d44ae602419 Luke D. Jones     2021-08-19  2178  	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
c63d44ae602419 Luke D. Jones     2021-08-19  2179  
c63d44ae602419 Luke D. Jones     2021-08-19  2180  	tp = asus->throttle_thermal_policy_mode;
c63d44ae602419 Luke D. Jones     2021-08-19  2181  
c63d44ae602419 Luke D. Jones     2021-08-19  2182  	switch (tp) {
c63d44ae602419 Luke D. Jones     2021-08-19  2183  	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
c63d44ae602419 Luke D. Jones     2021-08-19  2184  		*profile = PLATFORM_PROFILE_BALANCED;
c63d44ae602419 Luke D. Jones     2021-08-19  2185  		break;
c63d44ae602419 Luke D. Jones     2021-08-19  2186  	case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
c63d44ae602419 Luke D. Jones     2021-08-19  2187  		*profile = PLATFORM_PROFILE_PERFORMANCE;
c63d44ae602419 Luke D. Jones     2021-08-19  2188  		break;
c63d44ae602419 Luke D. Jones     2021-08-19  2189  	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
c63d44ae602419 Luke D. Jones     2021-08-19  2190  		*profile = PLATFORM_PROFILE_QUIET;
c63d44ae602419 Luke D. Jones     2021-08-19  2191  		break;
c63d44ae602419 Luke D. Jones     2021-08-19  2192  	default:
c63d44ae602419 Luke D. Jones     2021-08-19  2193  		return -EINVAL;
c63d44ae602419 Luke D. Jones     2021-08-19  2194  	}
c63d44ae602419 Luke D. Jones     2021-08-19  2195  
c63d44ae602419 Luke D. Jones     2021-08-19  2196  	return 0;
c63d44ae602419 Luke D. Jones     2021-08-19  2197  }
c63d44ae602419 Luke D. Jones     2021-08-19  2198  
c63d44ae602419 Luke D. Jones     2021-08-19  2199  static int platform_profile_set(struct platform_profile_handler *pprof,
c63d44ae602419 Luke D. Jones     2021-08-19  2200  				enum platform_profile_option profile)
c63d44ae602419 Luke D. Jones     2021-08-19  2201  {
c63d44ae602419 Luke D. Jones     2021-08-19  2202  	struct asus_wmi *asus;
c63d44ae602419 Luke D. Jones     2021-08-19  2203  	int tp;
c63d44ae602419 Luke D. Jones     2021-08-19  2204  
c63d44ae602419 Luke D. Jones     2021-08-19  2205  	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
c63d44ae602419 Luke D. Jones     2021-08-19  2206  
c63d44ae602419 Luke D. Jones     2021-08-19  2207  	switch (profile) {
c63d44ae602419 Luke D. Jones     2021-08-19  2208  	case PLATFORM_PROFILE_PERFORMANCE:
c63d44ae602419 Luke D. Jones     2021-08-19  2209  		tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
c63d44ae602419 Luke D. Jones     2021-08-19  2210  		break;
c63d44ae602419 Luke D. Jones     2021-08-19  2211  	case PLATFORM_PROFILE_BALANCED:
c63d44ae602419 Luke D. Jones     2021-08-19  2212  		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
c63d44ae602419 Luke D. Jones     2021-08-19  2213  		break;
c63d44ae602419 Luke D. Jones     2021-08-19  2214  	case PLATFORM_PROFILE_QUIET:
c63d44ae602419 Luke D. Jones     2021-08-19  2215  		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
c63d44ae602419 Luke D. Jones     2021-08-19  2216  		break;
c63d44ae602419 Luke D. Jones     2021-08-19  2217  	default:
c63d44ae602419 Luke D. Jones     2021-08-19  2218  		return -EOPNOTSUPP;
c63d44ae602419 Luke D. Jones     2021-08-19  2219  	}
c63d44ae602419 Luke D. Jones     2021-08-19  2220  
c63d44ae602419 Luke D. Jones     2021-08-19  2221  	asus->throttle_thermal_policy_mode = tp;
c63d44ae602419 Luke D. Jones     2021-08-19  2222  	return throttle_thermal_policy_write(asus);
c63d44ae602419 Luke D. Jones     2021-08-19  2223  }
c63d44ae602419 Luke D. Jones     2021-08-19  2224  
c63d44ae602419 Luke D. Jones     2021-08-19  2225  static int platform_profile_setup(struct asus_wmi *asus)
c63d44ae602419 Luke D. Jones     2021-08-19  2226  {
c63d44ae602419 Luke D. Jones     2021-08-19  2227  	struct device *dev = &asus->platform_device->dev;
c63d44ae602419 Luke D. Jones     2021-08-19  2228  	int err;
c63d44ae602419 Luke D. Jones     2021-08-19  2229  
c63d44ae602419 Luke D. Jones     2021-08-19  2230  	/*
c63d44ae602419 Luke D. Jones     2021-08-19  2231  	 * Not an error if a component platform_profile relies on is unavailable
c63d44ae602419 Luke D. Jones     2021-08-19  2232  	 * so early return, skipping the setup of platform_profile.
c63d44ae602419 Luke D. Jones     2021-08-19  2233  	 */
c63d44ae602419 Luke D. Jones     2021-08-19  2234  	if (!asus->throttle_thermal_policy_available)
c63d44ae602419 Luke D. Jones     2021-08-19  2235  		return 0;
c63d44ae602419 Luke D. Jones     2021-08-19  2236  
c63d44ae602419 Luke D. Jones     2021-08-19  2237  	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
c63d44ae602419 Luke D. Jones     2021-08-19  2238  
c63d44ae602419 Luke D. Jones     2021-08-19 @2239  	asus->platform_profile_handler.profile_get = platform_profile_get;
c63d44ae602419 Luke D. Jones     2021-08-19  2240  	asus->platform_profile_handler.profile_set = platform_profile_set;
c63d44ae602419 Luke D. Jones     2021-08-19  2241  
c63d44ae602419 Luke D. Jones     2021-08-19  2242  	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
c63d44ae602419 Luke D. Jones     2021-08-19  2243  	set_bit(PLATFORM_PROFILE_BALANCED,
c63d44ae602419 Luke D. Jones     2021-08-19  2244  		asus->platform_profile_handler.choices);
c63d44ae602419 Luke D. Jones     2021-08-19  2245  	set_bit(PLATFORM_PROFILE_PERFORMANCE,
c63d44ae602419 Luke D. Jones     2021-08-19  2246  		asus->platform_profile_handler.choices);
c63d44ae602419 Luke D. Jones     2021-08-19  2247  
c63d44ae602419 Luke D. Jones     2021-08-19  2248  	err = platform_profile_register(&asus->platform_profile_handler);
c63d44ae602419 Luke D. Jones     2021-08-19  2249  	if (err)
c63d44ae602419 Luke D. Jones     2021-08-19  2250  		return err;
c63d44ae602419 Luke D. Jones     2021-08-19  2251  
c63d44ae602419 Luke D. Jones     2021-08-19  2252  	asus->platform_profile_support = true;
c63d44ae602419 Luke D. Jones     2021-08-19  2253  	return 0;
c63d44ae602419 Luke D. Jones     2021-08-19  2254  }
c63d44ae602419 Luke D. Jones     2021-08-19  2255  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
xQxI1YRm1R6vehFH0/0PuYnmNoIbAgA=

--RnlQjJ0d97Da+TV1--
