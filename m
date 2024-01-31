Return-Path: <linux-acpi+bounces-3140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28797844ACE
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 23:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C90E1C213D5
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 22:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A00F39FD8;
	Wed, 31 Jan 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eajnZdKg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352339861;
	Wed, 31 Jan 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739336; cv=none; b=I4DlrfHTRaSWC7oD59JCy0hT59SpcqDdIVVe4Jx9L3wC3PqK1KNMXt6MA1w6SfOXXnzAqIQu70j5uO3K5gq/hC4imGB8eWy8//BLMn4yndpc8Hs00Hxyp3Q+fRuQcmEp+YTQlhK6QnNaet0vThF7QCt2NW3tTkGMO3QRAdv568c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739336; c=relaxed/simple;
	bh=4ZgH4xgEhEfQGmE0oc7WTPE8nB+LOjjf1I8a+exp5T0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eaUN5yR08E+xrB3l3+wJ/w55fc18tJugi6f3HsNKb6ecqdAundyWhL4O1Wk3OK/NqGU89BhwdgZwhqEwpq147B9r4h/6FyIGGDVzqklcftYNNTS4WyRqd3rcKs8/xy8Fzx4WH+XX0UqxZRvrR/bN4znnkGW+ngbvxjCB1NsP62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eajnZdKg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706739333; x=1738275333;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4ZgH4xgEhEfQGmE0oc7WTPE8nB+LOjjf1I8a+exp5T0=;
  b=eajnZdKgGP7quzXyEsExKOVqtSNDrhTOte+loYNI+06phNNrK7vLvXul
   H0yRb6YaC4gwxZCIph6homfeS0b7f1vGd0F7m4Xw9V2QfZMLwJloBcWKe
   fFCbgVlcVlotZj5eehad84x7KQ2D6VGF7u30zxOsN6yR4jtA1s7afcV9u
   G3iVrwi2R9YO/PLhPn8KaZldnytZXrYsubKotMaIC2D6fWGn366/vPjjJ
   eZMn9dXZ//77kmt0pB3JsAKxgwq0YyOmJF2dUyi2wYo7c3jXdVdhFRvQq
   KjwtrKxzY1wlMzd3I11+Y9+JXirVlODUGR1rPePK0Z0QxFqW3aNudCcU1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17275689"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="17275689"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 14:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4177967"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 31 Jan 2024 14:15:30 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVIrc-00025O-36;
	Wed, 31 Jan 2024 22:15:25 +0000
Date: Thu, 1 Feb 2024 06:15:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [rafael-pm:bleeding-edge 8/30] drivers/char/apm-emulation.c:91:9:
 error: redeclaration of enumerator 'SUSPEND_NONE'
Message-ID: <202402010647.vqP6EYJu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   bd0e3c391ff3c3c5c9b41227d6b7433fcf4d9c61
commit: 0897a442fca735890658fe84ace34bdac0e7bcce [8/30] PM: sleep: stats: Use array of suspend step names
config: arm-randconfig-002-20240201 (https://download.01.org/0day-ci/archive/20240201/202402010647.vqP6EYJu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402010647.vqP6EYJu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402010647.vqP6EYJu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/char/apm-emulation.c:91:9: error: redeclaration of enumerator 'SUSPEND_NONE'
      91 |         SUSPEND_NONE,
         |         ^~~~~~~~~~~~
   In file included from drivers/char/apm-emulation.c:24:
   include/linux/suspend.h:44:9: note: previous definition of 'SUSPEND_NONE' with type 'enum suspend_stat_step'
      44 |         SUSPEND_NONE = 0,
         |         ^~~~~~~~~~~~


vim +/SUSPEND_NONE +91 drivers/char/apm-emulation.c

7726942fb15edd Ralf Baechle  2007-02-09  50  
d20a4dca47d2cd Johannes Berg 2008-06-11  51  /*
d20a4dca47d2cd Johannes Berg 2008-06-11  52   * thread states (for threads using a writable /dev/apm_bios fd):
d20a4dca47d2cd Johannes Berg 2008-06-11  53   *
d20a4dca47d2cd Johannes Berg 2008-06-11  54   * SUSPEND_NONE:	nothing happening
d20a4dca47d2cd Johannes Berg 2008-06-11  55   * SUSPEND_PENDING:	suspend event queued for thread and pending to be read
d20a4dca47d2cd Johannes Berg 2008-06-11  56   * SUSPEND_READ:	suspend event read, pending acknowledgement
d20a4dca47d2cd Johannes Berg 2008-06-11  57   * SUSPEND_ACKED:	acknowledgement received from thread (via ioctl),
d20a4dca47d2cd Johannes Berg 2008-06-11  58   *			waiting for resume
d20a4dca47d2cd Johannes Berg 2008-06-11  59   * SUSPEND_ACKTO:	acknowledgement timeout
d20a4dca47d2cd Johannes Berg 2008-06-11  60   * SUSPEND_DONE:	thread had acked suspend and is now notified of
d20a4dca47d2cd Johannes Berg 2008-06-11  61   *			resume
d20a4dca47d2cd Johannes Berg 2008-06-11  62   *
d20a4dca47d2cd Johannes Berg 2008-06-11  63   * SUSPEND_WAIT:	this thread invoked suspend and is waiting for resume
d20a4dca47d2cd Johannes Berg 2008-06-11  64   *
d20a4dca47d2cd Johannes Berg 2008-06-11  65   * A thread migrates in one of three paths:
d20a4dca47d2cd Johannes Berg 2008-06-11  66   *	NONE -1-> PENDING -2-> READ -3-> ACKED -4-> DONE -5-> NONE
d20a4dca47d2cd Johannes Berg 2008-06-11  67   *				    -6-> ACKTO -7-> NONE
d20a4dca47d2cd Johannes Berg 2008-06-11  68   *	NONE -8-> WAIT -9-> NONE
d20a4dca47d2cd Johannes Berg 2008-06-11  69   *
d20a4dca47d2cd Johannes Berg 2008-06-11  70   * While in PENDING or READ, the thread is accounted for in the
d20a4dca47d2cd Johannes Berg 2008-06-11  71   * suspend_acks_pending counter.
d20a4dca47d2cd Johannes Berg 2008-06-11  72   *
d20a4dca47d2cd Johannes Berg 2008-06-11  73   * The transitions are invoked as follows:
d20a4dca47d2cd Johannes Berg 2008-06-11  74   *	1: suspend event is signalled from the core PM code
d20a4dca47d2cd Johannes Berg 2008-06-11  75   *	2: the suspend event is read from the fd by the userspace thread
d20a4dca47d2cd Johannes Berg 2008-06-11  76   *	3: userspace thread issues the APM_IOC_SUSPEND ioctl (as ack)
d20a4dca47d2cd Johannes Berg 2008-06-11  77   *	4: core PM code signals that we have resumed
d20a4dca47d2cd Johannes Berg 2008-06-11  78   *	5: APM_IOC_SUSPEND ioctl returns
d20a4dca47d2cd Johannes Berg 2008-06-11  79   *
d20a4dca47d2cd Johannes Berg 2008-06-11  80   *	6: the notifier invoked from the core PM code timed out waiting
d20a4dca47d2cd Johannes Berg 2008-06-11  81   *	   for all relevant threds to enter ACKED state and puts those
d20a4dca47d2cd Johannes Berg 2008-06-11  82   *	   that haven't into ACKTO
d20a4dca47d2cd Johannes Berg 2008-06-11  83   *	7: those threads issue APM_IOC_SUSPEND ioctl too late,
d20a4dca47d2cd Johannes Berg 2008-06-11  84   *	   get an error
d20a4dca47d2cd Johannes Berg 2008-06-11  85   *
d20a4dca47d2cd Johannes Berg 2008-06-11  86   *	8: userspace thread issues the APM_IOC_SUSPEND ioctl (to suspend),
d20a4dca47d2cd Johannes Berg 2008-06-11  87   *	   ioctl code invokes pm_suspend()
d20a4dca47d2cd Johannes Berg 2008-06-11  88   *	9: pm_suspend() returns indicating resume
d20a4dca47d2cd Johannes Berg 2008-06-11  89   */
d20a4dca47d2cd Johannes Berg 2008-06-11  90  enum apm_suspend_state {
d20a4dca47d2cd Johannes Berg 2008-06-11 @91  	SUSPEND_NONE,
d20a4dca47d2cd Johannes Berg 2008-06-11  92  	SUSPEND_PENDING,
d20a4dca47d2cd Johannes Berg 2008-06-11  93  	SUSPEND_READ,
d20a4dca47d2cd Johannes Berg 2008-06-11  94  	SUSPEND_ACKED,
d20a4dca47d2cd Johannes Berg 2008-06-11  95  	SUSPEND_ACKTO,
d20a4dca47d2cd Johannes Berg 2008-06-11  96  	SUSPEND_WAIT,
d20a4dca47d2cd Johannes Berg 2008-06-11  97  	SUSPEND_DONE,
d20a4dca47d2cd Johannes Berg 2008-06-11  98  };
d20a4dca47d2cd Johannes Berg 2008-06-11  99  

:::::: The code at line 91 was first introduced by commit
:::::: d20a4dca47d2cd027ed58a13f91b424affd1f449 APM emulation: Notify about all suspend events, not just APM invoked ones (v2)

:::::: TO: Johannes Berg <johannes@sipsolutions.net>
:::::: CC: Andi Kleen <andi@basil.nowhere.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

