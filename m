Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30147DB8D6
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 23:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394824AbfJQVOO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 17:14:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:56463 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395191AbfJQVOO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Oct 2019 17:14:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 14:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; 
   d="gz'50?scan'50,208,50";a="190155174"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2019 14:14:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iLD63-000ACv-2M; Fri, 18 Oct 2019 05:14:11 +0800
Date:   Fri, 18 Oct 2019 05:13:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [pm:bleeding-edge 50/51] include/linux/pm_qos.h:194:7: error:
 'DEV_PM_QOS_MIN_FREQUENCY' undeclared; did you mean
 'DEV_PM_QOS_RESUME_LATENCY'?
Message-ID: <201910180506.T0DNAlCi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ktyzcdoir5myksso"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--ktyzcdoir5myksso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   c1c487f8d64d46058ee2f4ca696eb1155a58b6f1
commit: ec4620f4aaa978842baf8ca0787fc9dc8de9c30a [50/51] PM: QoS: Drop frequency QoS types from device PM QoS
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        git checkout ec4620f4aaa978842baf8ca0787fc9dc8de9c30a
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/cpufreq.h:16:0,
                    from arch/x86/kernel/tsc.c:11:
   include/linux/pm_qos.h: In function 'dev_pm_qos_read_value':
>> include/linux/pm_qos.h:194:7: error: 'DEV_PM_QOS_MIN_FREQUENCY' undeclared (first use in this function); did you mean 'DEV_PM_QOS_RESUME_LATENCY'?
     case DEV_PM_QOS_MIN_FREQUENCY:
          ^~~~~~~~~~~~~~~~~~~~~~~~
          DEV_PM_QOS_RESUME_LATENCY
   include/linux/pm_qos.h:194:7: note: each undeclared identifier is reported only once for each function it appears in
>> include/linux/pm_qos.h:195:10: error: 'PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE' undeclared (first use in this function); did you mean 'PM_QOS_RESUME_LATENCY_DEFAULT_VALUE'?
      return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             PM_QOS_RESUME_LATENCY_DEFAULT_VALUE
>> include/linux/pm_qos.h:196:7: error: 'DEV_PM_QOS_MAX_FREQUENCY' undeclared (first use in this function); did you mean 'DEV_PM_QOS_MIN_FREQUENCY'?
     case DEV_PM_QOS_MAX_FREQUENCY:
          ^~~~~~~~~~~~~~~~~~~~~~~~
          DEV_PM_QOS_MIN_FREQUENCY
>> include/linux/pm_qos.h:197:10: error: 'PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE' undeclared (first use in this function); did you mean 'PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE'?
      return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE

vim +194 include/linux/pm_qos.h

6dbf5cea05a709 Rafael J. Wysocki 2017-02-24  172  
8262331eaaf751 Viresh Kumar      2019-07-04  173  static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
6dbf5cea05a709 Rafael J. Wysocki 2017-02-24  174  {
6dbf5cea05a709 Rafael J. Wysocki 2017-02-24  175  	return IS_ERR_OR_NULL(dev->power.qos) ?
0759e80b84e34a Rafael J. Wysocki 2017-11-07  176  		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
0759e80b84e34a Rafael J. Wysocki 2017-11-07  177  		pm_qos_read_value(&dev->power.qos->resume_latency);
6dbf5cea05a709 Rafael J. Wysocki 2017-02-24  178  }
e8db0be1245de1 Jean Pihet        2011-08-25  179  #else
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  180  static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  181  							  s32 mask)
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  182  			{ return PM_QOS_FLAGS_UNDEFINED; }
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  183  static inline enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev,
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  184  							s32 mask)
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  185  			{ return PM_QOS_FLAGS_UNDEFINED; }
8262331eaaf751 Viresh Kumar      2019-07-04  186  static inline s32 __dev_pm_qos_resume_latency(struct device *dev)
0759e80b84e34a Rafael J. Wysocki 2017-11-07  187  			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
2a79ea5ec53973 Viresh Kumar      2019-07-04  188  static inline s32 dev_pm_qos_read_value(struct device *dev,
2a79ea5ec53973 Viresh Kumar      2019-07-04  189  					enum dev_pm_qos_req_type type)
2a79ea5ec53973 Viresh Kumar      2019-07-04  190  {
2a79ea5ec53973 Viresh Kumar      2019-07-04  191  	switch (type) {
2a79ea5ec53973 Viresh Kumar      2019-07-04  192  	case DEV_PM_QOS_RESUME_LATENCY:
2a79ea5ec53973 Viresh Kumar      2019-07-04  193  		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
208637b37824c8 Viresh Kumar      2019-07-04 @194  	case DEV_PM_QOS_MIN_FREQUENCY:
208637b37824c8 Viresh Kumar      2019-07-04 @195  		return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
208637b37824c8 Viresh Kumar      2019-07-04 @196  	case DEV_PM_QOS_MAX_FREQUENCY:
208637b37824c8 Viresh Kumar      2019-07-04 @197  		return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
2a79ea5ec53973 Viresh Kumar      2019-07-04  198  	default:
2a79ea5ec53973 Viresh Kumar      2019-07-04  199  		WARN_ON(1);
2a79ea5ec53973 Viresh Kumar      2019-07-04  200  		return 0;
2a79ea5ec53973 Viresh Kumar      2019-07-04  201  	}
2a79ea5ec53973 Viresh Kumar      2019-07-04  202  }
2a79ea5ec53973 Viresh Kumar      2019-07-04  203  

:::::: The code at line 194 was first introduced by commit
:::::: 208637b37824c8956fe28d277835a403ee35fa84 PM / QoS: Add support for MIN/MAX frequency constraints

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ktyzcdoir5myksso
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
5mgEVbkzdIRqp8fWCQ4UfgDhSF/VDWgAAA==

--ktyzcdoir5myksso--
