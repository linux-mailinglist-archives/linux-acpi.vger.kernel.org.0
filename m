Return-Path: <linux-acpi+bounces-3211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54791848B7B
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Feb 2024 07:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDB11F21D74
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Feb 2024 06:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083CD6FB9;
	Sun,  4 Feb 2024 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgWahN1w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35B8F65;
	Sun,  4 Feb 2024 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707027798; cv=none; b=KUikjr46QvaJHOmQoGdRkMZgO9cw1PKE5Do7I/u9tAj2iMC8S3irpaFGbxATAcbGSGyqCMQG/z2AAYW5pLub1Qj8DgVwLAKk+aIj23q9W7aE1OJbi5qycrSRX49C6qq4uTOWqgHbDqW+ARTXSkQ/u0UMiHpFqPikpIVFTz48mOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707027798; c=relaxed/simple;
	bh=Cq80qbYXYMeg0Icl1wWN3J9C3RikWjHYAs52vvB2ZLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eb3ukYR+idvDJZAMQmVU1tGpovZ5u1iZ1YCKavD4aRttNNO9vwxxJEtUWorwglu+A+6IOmuv9C7yrOFPLi3u5d16dmEdgLHhJnGgqWk+5po2oCg3ZNJ2oMnv+cwHQfwwShU9cpZjWVP1Fwr7SM98s/6v0YCazj11ysLXOksCXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgWahN1w; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707027796; x=1738563796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cq80qbYXYMeg0Icl1wWN3J9C3RikWjHYAs52vvB2ZLs=;
  b=NgWahN1wAAmscXXt+mI37quAWGLK7H0CSnCXPG3x0ifLC9zyWGdsSEdx
   3uzGuDPBp40Ia+Fwfh/CfB8pnOEjBfc9gwCIJTNEyqo6oXcGSjrjoudyf
   vrBrgccoq+rFA6HQwFHHUsNVY1DMeu6lx/pmThkgyysC2FPwjJi1dAj3R
   2QaJnDMtTtKEycU5VVXQkD3a6Cq05gYpvkg4T8wsvtfmKV4VA6y+Pjqob
   46iBButhaC8SJhCsnq3j9fBIxmsyHJ3RG/fE88msT3tdcJOmVljdiqbaH
   3/1dZ3r8pdnEBu4tRw9YECWFwlXsznmqofDBXw0Tm5zi5JXuC2pRRokvs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="394790390"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="394790390"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 22:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="932857666"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="932857666"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2024 22:23:11 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWVuG-00064m-2p;
	Sun, 04 Feb 2024 06:23:08 +0000
Date: Sun, 4 Feb 2024 14:22:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [rafael-pm:bleeding-edge 10/36] drivers/char/apm-emulation.c:91:2:
 error: redefinition of enumerator 'SUSPEND_NONE'
Message-ID: <202402041425.jNvSR8Q1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   7f82463a4ec5fd466fa00e93d627b38da5d43ae2
commit: 0897a442fca735890658fe84ace34bdac0e7bcce [10/36] PM: sleep: stats: Use array of suspend step names
config: arm-randconfig-001-20240203 (https://download.01.org/0day-ci/archive/20240204/202402041425.jNvSR8Q1-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041425.jNvSR8Q1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402041425.jNvSR8Q1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/char/apm-emulation.c:91:2: error: redefinition of enumerator 'SUSPEND_NONE'
      91 |         SUSPEND_NONE,
         |         ^
   include/linux/suspend.h:44:2: note: previous definition is here
      44 |         SUSPEND_NONE = 0,
         |         ^
   drivers/char/apm-emulation.c:319:23: warning: implicit conversion from enumeration type 'enum suspend_stat_step' to different enumeration type 'enum apm_suspend_state' [-Wenum-conversion]
     319 |                 as->suspend_state = SUSPEND_NONE;
         |                                   ~ ^~~~~~~~~~~~
   1 warning and 1 error generated.


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

