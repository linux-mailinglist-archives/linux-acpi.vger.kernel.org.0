Return-Path: <linux-acpi+bounces-13499-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C615AABCA8
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 10:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE531189715D
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9141DE88A;
	Tue,  6 May 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ar8PTbt7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFF1AA79C;
	Tue,  6 May 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746518753; cv=none; b=ettXrrQGUZ/ocn5Uj7w1RafoGR6oqTUhDXH49FyCMK/U4o3pBXzx9ZWYQeIV/lPakoRR0fkB9QAMpqV7ZQMV7WyGOe9JCmfINcG09/6cwgAb2aOEbg6tRNA7GYlQAqmA8WagNL3eXHefCnD75QNWZzgrGA/KinjqfQ8o5h4cGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746518753; c=relaxed/simple;
	bh=uO7fc6V3D2/gI0yn6ReNgKH+8/Wuv56u0BGHjLXJPeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jaosiGruZAk6ooMvPmz77sFe6rxuLySNEDnImqpoZp2OczC5eLi/471/Fyc+U/urXIadCsOKBZ7ucITn7KJfH1j3+4tMjKdKQ44WBVPteHjwKl3W0S3fkfZSjPsccR56qtxe8vY/PMEsVsntuUYyB6CcAEuxRd1HrBFq+y0/yG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ar8PTbt7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746518751; x=1778054751;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uO7fc6V3D2/gI0yn6ReNgKH+8/Wuv56u0BGHjLXJPeo=;
  b=ar8PTbt7gjcwCIEMrDAlWOL3pEso3zPdobEPSEpLPAhMAgNu4zRe/hdL
   nQOdhthVlfKQnPRLc2KPMESZ0vJdd0nEU5tEP5kFBuEe9JnAqY9PpPfF1
   mHKazQbQCNtidnIGBDpDeoUsEtwuZFo/7YNNpvIZNVxx3DjVHhvPSuMLu
   IYlmjtPttlimzak4Vlr8hWjqGr0kli2eojjUYzX1YS8UiMkgKR+GEa9OH
   pCgPadpM8+Z3HZvQWFLkSc6GUvUfJWkVXlXecYJlYO+9EwVkQoEPWK4/4
   XqhOocs5DGq+S3KbjeVViFxfI1fV9kXJWeE3dEwyH2/Y1p9kii7QBqzWB
   Q==;
X-CSE-ConnectionGUID: GPxSrYMTS9uFjgVvMQxsew==
X-CSE-MsgGUID: 4wdIkpISS32Cbkus9ZWdqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48077569"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="48077569"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 01:05:50 -0700
X-CSE-ConnectionGUID: JCRwmQQsQ9ObY7qM4ihNyQ==
X-CSE-MsgGUID: KQtkHFplSj6a35dt+urp2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="136029801"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 May 2025 01:05:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCDJB-0006O7-2p;
	Tue, 06 May 2025 08:05:45 +0000
Date: Tue, 6 May 2025 16:05:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [rafael-pm:bleeding-edge 91/93] drivers/pinctrl/pinctrl-amd.c:987:2:
 error: must use 'struct' tag to refer to type 'pinctrl_dev'
Message-ID: <202505061622.qVVdwLYk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   c6039ca5edc14d1f0b34aa83a37fb7a379d8de46
commit: a2c2d5006579832e53851808f05d1bcf866215ca [91/93] pinctrl: amd: Fix hibernation support with CONFIG_SUSPEND unset
config: x86_64-buildonly-randconfig-001-20250506 (https://download.01.org/0day-ci/archive/20250506/202505061622.qVVdwLYk-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250506/202505061622.qVVdwLYk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505061622.qVVdwLYk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-amd.c:987:2: error: must use 'struct' tag to refer to type 'pinctrl_dev'
     987 |         pinctrl_dev = dev_get_drvdata(dev);
         |         ^
         |         struct 
>> drivers/pinctrl/pinctrl-amd.c:987:14: error: expected identifier or '('
     987 |         pinctrl_dev = dev_get_drvdata(dev);
         |                     ^
   2 errors generated.


vim +987 drivers/pinctrl/pinctrl-amd.c

79d2c8bede2c93 Daniel Drake        2017-09-11  984  
f31f33dbb3bab5 Maciej S. Szmigiero 2025-01-06  985  static int amd_gpio_suspend(struct device *dev)
f31f33dbb3bab5 Maciej S. Szmigiero 2025-01-06  986  {
179db1909c5c4b Mario Limonciello   2025-04-07 @987  	pinctrl_dev = dev_get_drvdata(dev);
f31f33dbb3bab5 Maciej S. Szmigiero 2025-01-06  988  	return amd_gpio_suspend_hibernate_common(dev, true);
f31f33dbb3bab5 Maciej S. Szmigiero 2025-01-06  989  }
f31f33dbb3bab5 Maciej S. Szmigiero 2025-01-06  990  

:::::: The code at line 987 was first introduced by commit
:::::: 179db1909c5c4b5300cce626507b0f843f7d2cc2 pinctrl: amd: Add an LPS0 check() callback

:::::: TO: Mario Limonciello <mario.limonciello@amd.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

