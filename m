Return-Path: <linux-acpi+bounces-11293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56136A3AEFB
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 02:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5DC172815
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 01:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171DC3597C;
	Wed, 19 Feb 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cntVRs8r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D814F70;
	Wed, 19 Feb 2025 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928793; cv=none; b=ZGvnJscdlhPjtNjtFBx3mnQvALoks7bIWOvRB8lWWLVWRNufNAbJvx+mJiRbX97As8K7UNVre2W9P+59AN7Nci3XGH39AFDMYmknmaJLfZxCN2AE2QD2YpvqxsTbJnXf9QG0PubslLRqUsIIHNE5dLRRHyo4KCQG8D2LMQQ6KQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928793; c=relaxed/simple;
	bh=axWQL+M5cKuPHZHDLo1o7+tsR20aRvv7FWFLVFOI0Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M4BAFD572RJ7SAWlewfmzHOS04DG/WEYY7iVGQAqe6AbzJggNpMSWXjqAUcO3jqAJd6+/pQImZYRIylomuGh4+iYT16cdEBlJLSmKTVbPEuRswZ5EHK7PA5n0M3XiLgzu6abRXjfp37E3hGvlFIxtsZL8iBL9lZC8Jr8veLsv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cntVRs8r; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739928791; x=1771464791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=axWQL+M5cKuPHZHDLo1o7+tsR20aRvv7FWFLVFOI0Zs=;
  b=cntVRs8rNI1TzVKSVgmkOHAS99lSfmCMw/UNGB/JlnFtetPVk5xo0k9V
   HNONJKq7RwV9NCiEDknW+c3NmaTaWudgN3GGREjRnUuh7PT+ud3pxKB4h
   AyQpZFCJxbMfej/NAh/+ZiD9osMYKUc2mOGPjArmWGAimO3vYoKjyzbxx
   fictguGPLLEOOUVw/nVEtUyFvICnuOT3G3KTpvZqcNRypT2YSLcfwP8Dv
   Vj6ttPFRZW7m8JpoLjc0lmcMIyzLs0NacHqb64rFHSw/7bl99tU2NQ3lY
   vODVR1atxRxcJRnajX9sNhHFp1VaZDwFJnol01iM+VU/QUGZe2U9Ag+7Z
   Q==;
X-CSE-ConnectionGUID: RLgIXqALQNCgHFvQjWEHXQ==
X-CSE-MsgGUID: hpHzKXbCSByNX/dKQELzoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40906354"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="40906354"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 17:33:10 -0800
X-CSE-ConnectionGUID: 7LGULbJ1SMCq+74mrsrHng==
X-CSE-MsgGUID: anUxnAtdSq6UCZ8yMyGMlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="145418110"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 17:33:09 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkYxW-00015V-2J;
	Wed, 19 Feb 2025 01:33:06 +0000
Date: Wed, 19 Feb 2025 09:32:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [rafael-pm:pm-sleep-testing 5/6] include/linux/device.h:1030:26:
 error: 'struct dev_pm_info' has no member named 'smart_suspend'
Message-ID: <202502190916.pODQrvQP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-sleep-testing
head:   e0d95f1b2b755e2cd05b11dcddabb6cab24a041b
commit: d7aa9525f39c3c2f5520db30b40edb9c8f13774e [5/6] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
config: i386-buildonly-randconfig-006-20250219 (https://download.01.org/0day-ci/archive/20250219/202502190916.pODQrvQP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502190916.pODQrvQP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502190916.pODQrvQP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/blk_types.h:11,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:23,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:14:
   include/linux/device.h: In function 'dev_pm_smart_suspend':
>> include/linux/device.h:1030:26: error: 'struct dev_pm_info' has no member named 'smart_suspend'
    1030 |         return dev->power.smart_suspend;
         |                          ^
   make[3]: *** [scripts/Makefile.build:102: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=686350231
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1264: prepare0] Error 2 shuffle=686350231
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=686350231
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=686350231
   make: Target 'prepare' not remade because of errors.


vim +1030 include/linux/device.h

  1027	
  1028	static inline bool dev_pm_smart_suspend(struct device *dev)
  1029	{
> 1030		return dev->power.smart_suspend;
  1031	}
  1032	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

