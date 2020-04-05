Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370E519EB0B
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Apr 2020 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDEL5i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Apr 2020 07:57:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:41981 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgDEL5i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 5 Apr 2020 07:57:38 -0400
IronPort-SDR: hyu5XMV1ZrKdA5UOk+qAUV+QUTux9Dm+MnltO0yegfADkIXHOoL2pORkUmJj8EN041LH7eEXW/
 yQzpK4Js73dA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 04:57:35 -0700
IronPort-SDR: 2Rr4O3riE/SnFtjbA7vQb6COAAnNgi4asC/aO0zDYjMb2egez6KYav+gNZcDcP/nEF+YzSwY5S
 6fG0oaZ7JOng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,347,1580803200"; 
   d="gz'50?scan'50,208,50";a="285596251"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2020 04:57:33 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jL3u8-000HRR-SQ; Sun, 05 Apr 2020 19:57:32 +0800
Date:   Sun, 5 Apr 2020 19:56:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [pm:pm-sleep-core 2/3] drivers/base/power/main.c:588:31: warning:
 initialization of 'const char *' from 'char' makes pointer from integer
 without a cast
Message-ID: <202004051953.3ANbxrwZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-sleep-core
head:   3aa654e1e731ad8f8aff1a937e09fae14380b6e5
commit: f31f24f5fef92e6b50dffdd2c53d2d4c4c8c2fc9 [2/3] PM: sleep: core: Fold functions into their callers
config: nds32-randconfig-a001-20200405 (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f31f24f5fef92e6b50dffdd2c53d2d4c4c8c2fc9
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:68,
                    from <command-line>:
   drivers/base/power/main.c: In function 'device_resume_noirq':
>> drivers/base/power/main.c:588:31: warning: initialization of 'const char *' from 'char' makes pointer from integer without a cast [-Wint-conversion]
     588 |  const char uninitialized_var(*info);
         |                               ^
   include/linux/compiler-gcc.h:65:34: note: in definition of macro 'uninitialized_var'
      65 | #define uninitialized_var(x) x = x
         |                                  ^
   drivers/base/power/main.c: In function 'device_resume_early':
   drivers/base/power/main.c:779:31: warning: initialization of 'const char *' from 'char' makes pointer from integer without a cast [-Wint-conversion]
     779 |  const char uninitialized_var(*info);
         |                               ^
   include/linux/compiler-gcc.h:65:34: note: in definition of macro 'uninitialized_var'
      65 | #define uninitialized_var(x) x = x
         |                                  ^
   drivers/base/power/main.c: In function '__device_suspend_noirq':
   drivers/base/power/main.c:1196:31: warning: initialization of 'const char *' from 'char' makes pointer from integer without a cast [-Wint-conversion]
    1196 |  const char uninitialized_var(*info);
         |                               ^
   include/linux/compiler-gcc.h:65:34: note: in definition of macro 'uninitialized_var'
      65 | #define uninitialized_var(x) x = x
         |                                  ^
   drivers/base/power/main.c: In function '__device_suspend_late':
   drivers/base/power/main.c:1381:31: warning: initialization of 'const char *' from 'char' makes pointer from integer without a cast [-Wint-conversion]
    1381 |  const char uninitialized_var(*info);
         |                               ^
   include/linux/compiler-gcc.h:65:34: note: in definition of macro 'uninitialized_var'
      65 | #define uninitialized_var(x) x = x
         |                                  ^
   drivers/base/power/main.c: In function 'device_resume_early':
   drivers/base/power/main.c:779:31: warning: 'info' is used uninitialized in this function [-Wuninitialized]
     779 |  const char uninitialized_var(*info);
         |                               ^
   drivers/base/power/main.c: In function 'device_resume_noirq':
   drivers/base/power/main.c:588:31: warning: 'info' is used uninitialized in this function [-Wuninitialized]
     588 |  const char uninitialized_var(*info);
         |                               ^
   drivers/base/power/main.c: In function '__device_suspend_noirq':
   drivers/base/power/main.c:1196:31: warning: 'info' is used uninitialized in this function [-Wuninitialized]
    1196 |  const char uninitialized_var(*info);
         |                               ^
   drivers/base/power/main.c: In function '__device_suspend_late':
   drivers/base/power/main.c:1381:31: warning: 'info' is used uninitialized in this function [-Wuninitialized]
    1381 |  const char uninitialized_var(*info);
         |                               ^

vim +588 drivers/base/power/main.c

   575	
   576	/**
   577	 * device_resume_noirq - Execute a "noirq resume" callback for given device.
   578	 * @dev: Device to handle.
   579	 * @state: PM transition of the system being carried out.
   580	 * @async: If true, the device is being resumed asynchronously.
   581	 *
   582	 * The driver of @dev will not receive interrupts while this function is being
   583	 * executed.
   584	 */
   585	static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
   586	{
   587		pm_callback_t callback = NULL;
 > 588		const char uninitialized_var(*info);
   589		bool skip_resume;
   590		int error = 0;
   591	
   592		TRACE_DEVICE(dev);
   593		TRACE_RESUME(0);
   594	
   595		if (dev->power.syscore || dev->power.direct_complete)
   596			goto Out;
   597	
   598		if (!dev->power.is_noirq_suspended)
   599			goto Out;
   600	
   601		if (!dpm_wait_for_superior(dev, async))
   602			goto Out;
   603	
   604		if (dev->pm_domain) {
   605			info = "noirq power domain ";
   606			callback = pm_noirq_op(&dev->pm_domain->ops, state);
   607		} else if (dev->type && dev->type->pm) {
   608			info = "noirq type ";
   609			callback = pm_noirq_op(dev->type->pm, state);
   610		} else if (dev->class && dev->class->pm) {
   611			info = "noirq class ";
   612			callback = pm_noirq_op(dev->class->pm, state);
   613		} else if (dev->bus && dev->bus->pm) {
   614			info = "noirq bus ";
   615			callback = pm_noirq_op(dev->bus->pm, state);
   616		}
   617		if (callback) {
   618			skip_resume = false;
   619			goto Run;
   620		}
   621	
   622		skip_resume = dev_pm_may_skip_resume(dev);
   623		if (skip_resume)
   624			goto Skip;
   625	
   626		/*
   627		 * If "freeze" driver callbacks have been skipped during hibernation,
   628		 * because the device was runtime-suspended in __device_suspend_late(),
   629		 * the corresponding "thaw" callbacks must be skipped too, because
   630		 * running them for a runtime-suspended device may not be valid.
   631		 */
   632		if (dev_pm_smart_suspend_and_suspended(dev) &&
   633		    state.event == PM_EVENT_THAW) {
   634			skip_resume = true;
   635			goto Skip;
   636		}
   637	
   638		if (dev->driver && dev->driver->pm) {
   639			info = "noirq driver ";
   640			callback = pm_noirq_op(dev->driver->pm, state);
   641		}
   642	
   643		/*
   644		 * The device is going to be resumed, so set its PM-runtime status to
   645		 * "active" (that can be done for all devices regardless of whether or
   646		 * not PM-runtime is enabled for them).
   647		 */
   648		pm_runtime_set_active(dev);
   649	
   650	Run:
   651		error = dpm_run_callback(callback, dev, state, info);
   652	
   653	Skip:
   654		dev->power.is_noirq_suspended = false;
   655	
   656		if (skip_resume) {
   657			/* Make the next phases of resume skip the device. */
   658			dev->power.is_late_suspended = false;
   659			dev->power.is_suspended = false;
   660			/*
   661			 * The device is going to be left in suspend, but it might not
   662			 * have been in runtime suspend before the system suspended, so
   663			 * its runtime PM status needs to be updated to avoid confusing
   664			 * the runtime PM framework when runtime PM is enabled for the
   665			 * device again.
   666			 */
   667			pm_runtime_set_suspended(dev);
   668		}
   669	
   670	Out:
   671		complete_all(&dev->power.completion);
   672		TRACE_RESUME(error);
   673		return error;
   674	}
   675	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--rwEMma7ioTxnRzrJ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--rwEMma7ioTxnRzrJ--
