Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423A919E7DD
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Apr 2020 00:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDDWBb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Apr 2020 18:01:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:26011 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgDDWBb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 4 Apr 2020 18:01:31 -0400
IronPort-SDR: x7hk8AZXTcZ8j8WVjLWPdzQDt8dx41U1cK4ostRo+2+lQIXxS5SvxT+TRbEq0v9DdSQVDZtgYE
 n/+WXp46RxBw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2020 15:01:29 -0700
IronPort-SDR: GhfF2Acnh7/3WLUrqrSoJXoi9yniv62KsFKN51x5pv+G0o5wEPDcOjCawenqbupuIIqgOz5yRc
 uglkGpWMkC9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,345,1580803200"; 
   d="gz'50?scan'50,208,50";a="329494652"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2020 15:01:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKqr0-000Itd-AK; Sun, 05 Apr 2020 06:01:26 +0800
Date:   Sun, 5 Apr 2020 06:01:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [pm:pm-sleep-core 2/3] drivers/base/power/main.c:824:10: warning:
 'callback' may be used uninitialized in this function
Message-ID: <202004050613.nXyYKeZF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-sleep-core
head:   a52086e57479bf4eb7e328aefc491dcb0c2da475
commit: bc95fd57b878a950c92e57ce8e2bd9d33a40d0cf [2/3] PM: sleep: core: Fold functions into their callers
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bc95fd57b878a950c92e57ce8e2bd9d33a40d0cf
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/base/power/main.c:568:21: warning: 'suspend_event' defined but not used [-Wunused-function]
     568 | static pm_message_t suspend_event(pm_message_t resume_msg)
         |                     ^~~~~~~~~~~~~
   drivers/base/power/main.c: In function 'device_resume_early':
   drivers/base/power/main.c:824:10: warning: 'info' may be used uninitialized in this function [-Wmaybe-uninitialized]
     824 |  error = dpm_run_callback(callback, dev, state, info);
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/power/main.c:824:10: warning: 'callback' may be used uninitialized in this function [-Wmaybe-uninitialized]
   drivers/base/power/main.c: In function 'device_resume_noirq':
   drivers/base/power/main.c:664:10: warning: 'info' may be used uninitialized in this function [-Wmaybe-uninitialized]
     664 |  error = dpm_run_callback(callback, dev, state, info);
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/power/main.c: In function '__device_suspend_noirq':
   drivers/base/power/main.c:1248:10: warning: 'info' may be used uninitialized in this function [-Wmaybe-uninitialized]
    1248 |  error = dpm_run_callback(callback, dev, state, info);
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/power/main.c: In function '__device_suspend_late':
   drivers/base/power/main.c:1449:10: warning: 'info' may be used uninitialized in this function [-Wmaybe-uninitialized]
    1449 |  error = dpm_run_callback(callback, dev, state, info);
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/callback +824 drivers/base/power/main.c

cf579dfb82550e Rafael J. Wysocki 2012-01-29  780  
cf579dfb82550e Rafael J. Wysocki 2012-01-29  781  /**
cf579dfb82550e Rafael J. Wysocki 2012-01-29  782   * device_resume_early - Execute an "early resume" callback for given device.
cf579dfb82550e Rafael J. Wysocki 2012-01-29  783   * @dev: Device to handle.
cf579dfb82550e Rafael J. Wysocki 2012-01-29  784   * @state: PM transition of the system being carried out.
58c256a3a37ea7 Randy Dunlap      2014-07-27  785   * @async: If true, the device is being resumed asynchronously.
cf579dfb82550e Rafael J. Wysocki 2012-01-29  786   *
cf579dfb82550e Rafael J. Wysocki 2012-01-29  787   * Runtime PM is disabled for @dev while this function is being executed.
cf579dfb82550e Rafael J. Wysocki 2012-01-29  788   */
9e5e7910df824b Liu, Chuansheng   2014-02-18  789  static int device_resume_early(struct device *dev, pm_message_t state, bool async)
cf579dfb82550e Rafael J. Wysocki 2012-01-29  790  {
4fa3061a6856cc Rafael J. Wysocki 2017-12-10  791  	pm_callback_t callback;
4fa3061a6856cc Rafael J. Wysocki 2017-12-10  792  	const char *info;
cf579dfb82550e Rafael J. Wysocki 2012-01-29  793  	int error = 0;
cf579dfb82550e Rafael J. Wysocki 2012-01-29  794  
cf579dfb82550e Rafael J. Wysocki 2012-01-29  795  	TRACE_DEVICE(dev);
cf579dfb82550e Rafael J. Wysocki 2012-01-29  796  	TRACE_RESUME(0);
cf579dfb82550e Rafael J. Wysocki 2012-01-29  797  
aae4518b3124b2 Rafael J. Wysocki 2014-05-16  798  	if (dev->power.syscore || dev->power.direct_complete)
dbf374142dd7a3 Rafael J. Wysocki 2012-08-06  799  		goto Out;
dbf374142dd7a3 Rafael J. Wysocki 2012-08-06  800  
3d2699bc179a10 Liu, Chuansheng   2014-02-18  801  	if (!dev->power.is_late_suspended)
3d2699bc179a10 Liu, Chuansheng   2014-02-18  802  		goto Out;
3d2699bc179a10 Liu, Chuansheng   2014-02-18  803  
0552e05fdfea19 Rafael J. Wysocki 2020-01-23  804  	if (!dpm_wait_for_superior(dev, async))
0552e05fdfea19 Rafael J. Wysocki 2020-01-23  805  		goto Out;
9e5e7910df824b Liu, Chuansheng   2014-02-18  806  
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  807  	if (dev->pm_domain) {
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  808  		info = "early power domain ";
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  809  		callback = pm_late_early_op(&dev->pm_domain->ops, state);
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  810  	} else if (dev->type && dev->type->pm) {
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  811  		info = "early type ";
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  812  		callback = pm_late_early_op(dev->type->pm, state);
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  813  	} else if (dev->class && dev->class->pm) {
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  814  		info = "early class ";
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  815  		callback = pm_late_early_op(dev->class->pm, state);
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  816  	} else if (dev->bus && dev->bus->pm) {
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  817  		info = "early bus ";
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  818  		callback = pm_late_early_op(dev->bus->pm, state);
bc95fd57b878a9 Rafael J. Wysocki 2020-04-04  819  	} else if (dev->driver && dev->driver->pm) {
cf579dfb82550e Rafael J. Wysocki 2012-01-29  820  		info = "early driver ";
cf579dfb82550e Rafael J. Wysocki 2012-01-29  821  		callback = pm_late_early_op(dev->driver->pm, state);
cf579dfb82550e Rafael J. Wysocki 2012-01-29  822  	}
cf579dfb82550e Rafael J. Wysocki 2012-01-29  823  
cf579dfb82550e Rafael J. Wysocki 2012-01-29 @824  	error = dpm_run_callback(callback, dev, state, info);
3d2699bc179a10 Liu, Chuansheng   2014-02-18  825  	dev->power.is_late_suspended = false;
cf579dfb82550e Rafael J. Wysocki 2012-01-29  826  
dbf374142dd7a3 Rafael J. Wysocki 2012-08-06  827   Out:
cf579dfb82550e Rafael J. Wysocki 2012-01-29  828  	TRACE_RESUME(error);
9f6d8f6ab26b42 Rafael J. Wysocki 2012-12-22  829  
9f6d8f6ab26b42 Rafael J. Wysocki 2012-12-22  830  	pm_runtime_enable(dev);
9e5e7910df824b Liu, Chuansheng   2014-02-18  831  	complete_all(&dev->power.completion);
cf579dfb82550e Rafael J. Wysocki 2012-01-29  832  	return error;
cf579dfb82550e Rafael J. Wysocki 2012-01-29  833  }
cf579dfb82550e Rafael J. Wysocki 2012-01-29  834  

:::::: The code at line 824 was first introduced by commit
:::::: cf579dfb82550e34de7ccf3ef090d8b834ccd3a9 PM / Sleep: Introduce "late suspend" and "early resume" of devices

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Rafael J. Wysocki <rjw@sisk.pl>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vkogqOf2sHV7VnPd--
