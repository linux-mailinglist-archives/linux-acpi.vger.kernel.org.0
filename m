Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A600119F47B
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Apr 2020 13:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgDFLWM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Apr 2020 07:22:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52264 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgDFLWM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2020 07:22:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BIRTS043084;
        Mon, 6 Apr 2020 11:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=k+Z5PcARq57oLYCiQuXm9HLbv3Ce2Qs1CiGfOWDzlvM=;
 b=YFf2DUC0Wa4QGFaJP0HpTeNwYjaVcAHHQLTd06UdXoMjnY2plqJ5QUVWRhJK2L03Qxs9
 cNqt00PbJKFy8MRNRnL3/XfV+oDmR7ZpVjzJAUQdlAzYE27IoQOuPM/fPKMLXdjIHUY3
 kdRQ3crM/Fnk5NJeajVjO1TtBrgiNNOQSEdRB82FeeoH1384+o1GvQAEGoZSskQJ3Ahn
 qawE6chbo6gmbKF8eVoeUkuV0IZneIsiH6MkDPnVRZiodcPwXsEv1BrpS87kYMOIYAB/
 TTetZyLq09dXKMzFP3WfcnN9/hVXOSiwlKEJj5L+NEIoZBt7zvl1SHv3yK1HuD7X8ZWW RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 306hnqx7m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 11:22:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BHO53147402;
        Mon, 6 Apr 2020 11:22:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30741a6td3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 11:22:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036BM3rC026879;
        Mon, 6 Apr 2020 11:22:03 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 04:22:02 -0700
Date:   Mon, 6 Apr 2020 14:21:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [pm:pm-sleep-core 2/2] drivers/base/power/main.c:664
 device_resume_noirq() error: uninitialized symbol 'info'.
Message-ID: <20200406112155.GG2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060099
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-sleep-core
head:   547556fab555120662914c71c1fe8ea0643e1871
commit: 547556fab555120662914c71c1fe8ea0643e1871 [2/2] PM: sleep: core: Fold functions into their callers
:::::: branch date: 2 hours ago
:::::: commit date: 2 hours ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/base/power/main.c:664 device_resume_noirq() error: uninitialized symbol 'info'.
drivers/base/power/main.c:1267 __device_suspend_noirq() error: uninitialized symbol 'info'.
drivers/base/power/main.c:1468 __device_suspend_late() error: uninitialized symbol 'info'.

# https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=547556fab555120662914c71c1fe8ea0643e1871
git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
git remote update pm
git checkout 547556fab555120662914c71c1fe8ea0643e1871
vim +/info +664 drivers/base/power/main.c

76569faa62c4638 Liu, Chuansheng   2014-02-18  603  static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
775b64d2b6ca376 Rafael J. Wysocki 2008-01-12  604  {
547556fab555120 Rafael J. Wysocki 2020-04-04  605  	pm_callback_t callback = NULL;
4fa3061a6856cc7 Rafael J. Wysocki 2017-12-10  606  	const char *info;
32bfa56ac158c1e Rafael J. Wysocki 2017-12-10  607  	bool skip_resume;
775b64d2b6ca376 Rafael J. Wysocki 2008-01-12  608  	int error = 0;
775b64d2b6ca376 Rafael J. Wysocki 2008-01-12  609  
775b64d2b6ca376 Rafael J. Wysocki 2008-01-12  610  	TRACE_DEVICE(dev);
775b64d2b6ca376 Rafael J. Wysocki 2008-01-12  611  	TRACE_RESUME(0);
775b64d2b6ca376 Rafael J. Wysocki 2008-01-12  612  
aae4518b3124b29 Rafael J. Wysocki 2014-05-16  613  	if (dev->power.syscore || dev->power.direct_complete)
dbf374142dd7a3c Rafael J. Wysocki 2012-08-06  614  		goto Out;
dbf374142dd7a3c Rafael J. Wysocki 2012-08-06  615  
3d2699bc179a10e Liu, Chuansheng   2014-02-18  616  	if (!dev->power.is_noirq_suspended)
3d2699bc179a10e Liu, Chuansheng   2014-02-18  617  		goto Out;
3d2699bc179a10e Liu, Chuansheng   2014-02-18  618  
0552e05fdfea191 Rafael J. Wysocki 2020-01-23  619  	if (!dpm_wait_for_superior(dev, async))
0552e05fdfea191 Rafael J. Wysocki 2020-01-23  620  		goto Out;
76569faa62c4638 Liu, Chuansheng   2014-02-18  621  
547556fab555120 Rafael J. Wysocki 2020-04-04  622  	if (dev->pm_domain) {
547556fab555120 Rafael J. Wysocki 2020-04-04  623  		info = "noirq power domain ";
547556fab555120 Rafael J. Wysocki 2020-04-04  624  		callback = pm_noirq_op(&dev->pm_domain->ops, state);
547556fab555120 Rafael J. Wysocki 2020-04-04  625  	} else if (dev->type && dev->type->pm) {
547556fab555120 Rafael J. Wysocki 2020-04-04  626  		info = "noirq type ";
547556fab555120 Rafael J. Wysocki 2020-04-04  627  		callback = pm_noirq_op(dev->type->pm, state);
547556fab555120 Rafael J. Wysocki 2020-04-04  628  	} else if (dev->class && dev->class->pm) {
547556fab555120 Rafael J. Wysocki 2020-04-04  629  		info = "noirq class ";
547556fab555120 Rafael J. Wysocki 2020-04-04  630  		callback = pm_noirq_op(dev->class->pm, state);
547556fab555120 Rafael J. Wysocki 2020-04-04  631  	} else if (dev->bus && dev->bus->pm) {
547556fab555120 Rafael J. Wysocki 2020-04-04  632  		info = "noirq bus ";
547556fab555120 Rafael J. Wysocki 2020-04-04  633  		callback = pm_noirq_op(dev->bus->pm, state);
547556fab555120 Rafael J. Wysocki 2020-04-04  634  	}

Assume none of these conditions are true

ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  635  	if (callback) {
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  636  		skip_resume = false;
75e94645fc3b100 Rafael J. Wysocki 2017-12-10  637  		goto Run;
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  638  	}
33c3374031facf7 Rafael J. Wysocki 2009-12-13  639  
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  640  	skip_resume = dev_pm_may_skip_resume(dev);
32bfa56ac158c1e Rafael J. Wysocki 2017-12-10  641  	if (skip_resume)
32bfa56ac158c1e Rafael J. Wysocki 2017-12-10  642  		goto Skip;
32bfa56ac158c1e Rafael J. Wysocki 2017-12-10  643  
75e94645fc3b100 Rafael J. Wysocki 2017-12-10  644  	/*
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  645  	 * If "freeze" driver callbacks have been skipped during hibernation,
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  646  	 * because the device was runtime-suspended in __device_suspend_late(),
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  647  	 * the corresponding "thaw" callbacks must be skipped too, because
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  648  	 * running them for a runtime-suspended device may not be valid.
75e94645fc3b100 Rafael J. Wysocki 2017-12-10  649  	 */
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  650  	if (dev_pm_smart_suspend_and_suspended(dev) &&
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  651  	    state.event == PM_EVENT_THAW) {
32bfa56ac158c1e Rafael J. Wysocki 2017-12-10  652  		skip_resume = true;
75e94645fc3b100 Rafael J. Wysocki 2017-12-10  653  		goto Skip;
75e94645fc3b100 Rafael J. Wysocki 2017-12-10  654  	}
75e94645fc3b100 Rafael J. Wysocki 2017-12-10  655  
75e94645fc3b100 Rafael J. Wysocki 2017-12-10  656  	if (dev->driver && dev->driver->pm) {
cf579dfb82550e3 Rafael J. Wysocki 2012-01-29  657  		info = "noirq driver ";
35cd133c6130c1e Rafael J. Wysocki 2011-12-18  658  		callback = pm_noirq_op(dev->driver->pm, state);
35cd133c6130c1e Rafael J. Wysocki 2011-12-18  659  	}

And these aren't true

35cd133c6130c1e Rafael J. Wysocki 2011-12-18  660  
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  661  	pm_runtime_set_active(dev);
ff2d75f7550e29e Rafael J. Wysocki 2020-04-04  662  
75e94645fc3b100 Rafael J. Wysocki 2017-12-10  663  Run:
9cf519d1c15fa05 Rafael J. Wysocki 2011-12-18 @664  	error = dpm_run_callback(callback, dev, state, info);
                                                                                                       ^^^^

75e94645fc3b100 Rafael J. Wysocki 2017-12-10  665  
75e94645fc3b100 Rafael J. Wysocki 2017-12-10  666  Skip:
3d2699bc179a10e Liu, Chuansheng   2014-02-18  667  	dev->power.is_noirq_suspended = false;
9cf519d1c15fa05 Rafael J. Wysocki 2011-12-18  668  
32bfa56ac158c1e Rafael J. Wysocki 2017-12-10  669  	if (skip_resume) {
02bd45a28bf3299 Rafael J. Wysocki 2019-07-04  670  		/* Make the next phases of resume skip the device. */
02bd45a28bf3299 Rafael J. Wysocki 2019-07-04  671  		dev->power.is_late_suspended = false;
02bd45a28bf3299 Rafael J. Wysocki 2019-07-04  672  		dev->power.is_suspended = false;
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  673  		/*
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  674  		 * The device is going to be left in suspend, but it might not
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  675  		 * have been in runtime suspend before the system suspended, so
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  676  		 * its runtime PM status needs to be updated to avoid confusing
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  677  		 * the runtime PM framework when runtime PM is enabled for the
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  678  		 * device again.
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  679  		 */
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  680  		pm_runtime_set_suspended(dev);
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  681  	}
0d4b54c6fee87ff Rafael J. Wysocki 2017-11-18  682  
dbf374142dd7a3c Rafael J. Wysocki 2012-08-06  683  Out:
76569faa62c4638 Liu, Chuansheng   2014-02-18  684  	complete_all(&dev->power.completion);
775b64d2b6ca376 Rafael J. Wysocki 2008-01-12  685  	TRACE_RESUME(error);
775b64d2b6ca376 Rafael J. Wysocki 2008-01-12  686  	return error;
775b64d2b6ca376 Rafael J. Wysocki 2008-01-12  687  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
