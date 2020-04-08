Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECFA1A297A
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Apr 2020 21:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgDHTnT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Apr 2020 15:43:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:14567 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgDHTnT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Apr 2020 15:43:19 -0400
IronPort-SDR: 2MTKrMhg1oC+KZl9PDrTNPaNYlP45abhBfgbQzxFvEXlN/7RPTfVSyYGwLh5KMQ6QIZw5Z2B7n
 q9Pve5VvvgBg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 12:43:17 -0700
IronPort-SDR: 8LcUJ4LJfIkbczLCgVN4LUApd+PApDDVSBoFjJvLN62IXaux9arFGFM7eq5qjlvY4syiaSRvqI
 vfW3vtm2GJOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="gz'50?scan'50,208,50";a="330634071"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2020 12:43:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jMGbS-000FTR-Jz; Thu, 09 Apr 2020 03:43:14 +0800
Date:   Thu, 9 Apr 2020 03:42:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [pm:pm-sleep-core 3/7] drivers/base/power/main.c:646:3: error: label
 'skip' used but not defined
Message-ID: <202004090306.RzFIVdGL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-sleep-core
head:   a10300155e14f5644294172cfda77106ee71e236
commit: c56010827abbc0b471d4af29f2e7d45c661ae1b3 [3/7] PM: sleep: core: Do not skip callbacks in the resume phase
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c56010827abbc0b471d4af29f2e7d45c661ae1b3
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/power/main.c: In function 'device_resume_noirq':
   drivers/base/power/main.c:656:1: warning: label 'Skip' defined but not used [-Wunused-label]
     656 | Skip:
         | ^~~~
>> drivers/base/power/main.c:646:3: error: label 'skip' used but not defined
     646 |   goto skip;
         |   ^~~~

vim +/skip +646 drivers/base/power/main.c

   584	
   585	/**
   586	 * device_resume_noirq - Execute a "noirq resume" callback for given device.
   587	 * @dev: Device to handle.
   588	 * @state: PM transition of the system being carried out.
   589	 * @async: If true, the device is being resumed asynchronously.
   590	 *
   591	 * The driver of @dev will not receive interrupts while this function is being
   592	 * executed.
   593	 */
   594	static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
   595	{
   596		pm_callback_t callback = NULL;
   597		const char *info = NULL;
   598		bool skip_resume;
   599		int error = 0;
   600	
   601		TRACE_DEVICE(dev);
   602		TRACE_RESUME(0);
   603	
   604		if (dev->power.syscore || dev->power.direct_complete)
   605			goto Out;
   606	
   607		if (!dev->power.is_noirq_suspended)
   608			goto Out;
   609	
   610		if (!dpm_wait_for_superior(dev, async))
   611			goto Out;
   612	
   613		skip_resume = dev_pm_may_skip_resume(dev);
   614		/*
   615		 * If the driver callback is skipped below or by the middle layer
   616		 * callback and device_resume_early() also skips the driver callback for
   617		 * this device later, it needs to appear as "suspended" to PM-runtime,
   618		 * so change its status accordingly.
   619		 *
   620		 * Otherwise, the device is going to be resumed, so set its PM-runtime
   621		 * status to "active", but do that only if DPM_FLAG_SMART_SUSPEND is set
   622		 * to avoid confusing drivers that don't use it.
   623		 */
   624		if (skip_resume)
   625			pm_runtime_set_suspended(dev);
   626		else if (dev_pm_smart_suspend_and_suspended(dev))
   627			pm_runtime_set_active(dev);
   628	
   629		if (dev->pm_domain) {
   630			info = "noirq power domain ";
   631			callback = pm_noirq_op(&dev->pm_domain->ops, state);
   632		} else if (dev->type && dev->type->pm) {
   633			info = "noirq type ";
   634			callback = pm_noirq_op(dev->type->pm, state);
   635		} else if (dev->class && dev->class->pm) {
   636			info = "noirq class ";
   637			callback = pm_noirq_op(dev->class->pm, state);
   638		} else if (dev->bus && dev->bus->pm) {
   639			info = "noirq bus ";
   640			callback = pm_noirq_op(dev->bus->pm, state);
   641		}
   642		if (callback)
   643			goto Run;
   644	
   645		if (skip_resume)
 > 646			goto skip;
   647	
   648		if (dev->driver && dev->driver->pm) {
   649			info = "noirq driver ";
   650			callback = pm_noirq_op(dev->driver->pm, state);
   651		}
   652	
   653	Run:
   654		error = dpm_run_callback(callback, dev, state, info);
   655	
   656	Skip:
   657		dev->power.is_noirq_suspended = false;
   658	
   659	Out:
   660		complete_all(&dev->power.completion);
   661		TRACE_RESUME(error);
   662		return error;
   663	}
   664	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7k5h3fNfVvbb/wGo3uOAFakAAA==

--M9NhX3UHpAaciwkO--
