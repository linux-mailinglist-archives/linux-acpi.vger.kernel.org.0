Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59723507E87
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Apr 2022 04:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiDTCGk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Apr 2022 22:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358799AbiDTCGj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2022 22:06:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6C23147
        for <linux-acpi@vger.kernel.org>; Tue, 19 Apr 2022 19:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650420234; x=1681956234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qvDEhsl7hIoDNKe+3wWu0A8CGhWmMRsX3/dxJdjiSjY=;
  b=S9ko7SzChZ5o+6z1euIdyqB6V96zfUfE0hGrQZpAizRV6sZUp+KvDSPc
   s53bcoAAT4PCTHf+1rzR+IPgufzVibvOA78vSNYc+ndAGE8g5qA01RVp4
   ZrKeXE+sKlSO9nmfO3IBiSutC1RmDxmDFfFn371tMXxCb9fFSRhu0ozCr
   1Nabytvq34V4QzMdfHnhiW7cyrRX+G6cT0kPYNEYydnAnteP+oj5zmaEH
   CEUKhPsRdW/NUlVNXA4RFnlqK8UjnbpybyLN5f5Ii856FHBc+wM8By95X
   9xjix6Xr+z2/x1i7pBbCV7u7JYg9WfmLa5Xzr4Q6QceHMdAcwRWJvZP/6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263680260"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="263680260"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="702409452"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2022 19:03:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngzh9-0006Qu-6n;
        Wed, 20 Apr 2022 02:03:51 +0000
Date:   Wed, 20 Apr 2022 10:02:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: Avoid flush_scheduled_work() usage
Message-ID: <202204200917.Gi0wjcgM-lkp@intel.com>
References: <892bb009-4ba8-15fa-c8f9-eb66ab75b2f0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <892bb009-4ba8-15fa-c8f9-eb66ab75b2f0@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Tetsuo,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on v5.18-rc3 next-20220419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/ACPI-Avoid-flush_scheduled_work-usage/20220419-215854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220420/202204200917.Gi0wjcgM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cebc6c01f6fac86f7deaf74ca81311d9c3d179f4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tetsuo-Handa/ACPI-Avoid-flush_scheduled_work-usage/20220419-215854
        git checkout cebc6c01f6fac86f7deaf74ca81311d9c3d179f4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/acpi/acpi_video.c:1640:21: error: use of undeclared identifier 'acpi_wq'
           queue_delayed_work(acpi_wq, &video_device->switch_brightness_work, HZ / 10);
                              ^
   drivers/acpi/acpi_video.c:2258:6: warning: no previous prototype for function 'acpi_video_unregister_backlight' [-Wmissing-prototypes]
   void acpi_video_unregister_backlight(void)
        ^
   drivers/acpi/acpi_video.c:2258:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void acpi_video_unregister_backlight(void)
   ^
   static 
   1 warning and 1 error generated.
--
>> drivers/acpi/video_detect.c:532:14: error: use of undeclared identifier 'acpi_wq'
                   queue_work(acpi_wq, &backlight_notify_work);
                              ^
   drivers/acpi/video_detect.c:605:13: warning: no previous prototype for function 'acpi_video_detect_exit' [-Wmissing-prototypes]
   void __exit acpi_video_detect_exit(void)
               ^
   drivers/acpi/video_detect.c:605:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __exit acpi_video_detect_exit(void)
   ^
   static 
   1 warning and 1 error generated.


vim +/acpi_wq +1640 drivers/acpi/acpi_video.c

  1632	
  1633	static void brightness_switch_event(struct acpi_video_device *video_device,
  1634					    u32 event)
  1635	{
  1636		if (!brightness_switch_enabled)
  1637			return;
  1638	
  1639		video_device->switch_brightness_event = event;
> 1640		queue_delayed_work(acpi_wq, &video_device->switch_brightness_work, HZ / 10);
  1641	}
  1642	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
