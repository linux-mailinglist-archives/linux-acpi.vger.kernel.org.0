Return-Path: <linux-acpi+bounces-4605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101F88961A8
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Apr 2024 02:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3081C22581
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Apr 2024 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70103E560;
	Wed,  3 Apr 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzdaEyav"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38CDDD3;
	Wed,  3 Apr 2024 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105510; cv=none; b=BiRFTPFx/0dx1LL8cvSEyZqnHB4f1xDN/FcEZLwk3ErxQCr0S36e92OPYEcW4iTh1sqE1p4Yzq82j8gerHbWV9cTnhttsu7idtRxlRdURpT2/vtByh559oHbMtGTZbSUASros8nYI0cWrPVEpH2D9dGwhsRrFid39qlkRPwMAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105510; c=relaxed/simple;
	bh=2Rk4D5RDvMb3U9Iily/8E9F/vfmEX7nK+qtx/KtLMNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n7gL9kmpSJBA0bybVm78w3K8B8nsHxtRFYanBy71QrXKb4dlhAfOqabcpUv3vsL/TmvZfaeAASn1itnNgt2qABAsyqU8a7+4l/RhY0/flgV9Lbr+waFJRNmbMyvH9wUUweXZ2VUsHiauw8PwqALuea2UrLBXKqRjG9bqhCdPw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzdaEyav; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712105507; x=1743641507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2Rk4D5RDvMb3U9Iily/8E9F/vfmEX7nK+qtx/KtLMNE=;
  b=IzdaEyavPz6xbJR5T3KNf+h6iWWHvD5noCbQ/3jcqoJsESjeTlaZ0Y2t
   BAwuvoHKTAYiAOI4kBtU/yTUjgGZnWd+hl6OzWnZnGh9x/F5i9KPgIqkV
   7z1a9kZ1CsnISlb075eaA7Hqnp3BRS4zkuq8KzZo/imgn0DHLZPAcjUo9
   HoX8egxxN4CAwQTPEgFCOjCh0uIJETubsD97bEF7YnuXOpwXyaoseZ7EZ
   SROWy7eLGWB56J+tW3HEWtV/RbmgCcsofwi5Uu7v9nPB2HO/DwiuxDFZM
   V4TESdYbBjCmS4auL89r6QgOR/zwnweiI1W8JAIRGuujqJy6ceJ3u7rym
   w==;
X-CSE-ConnectionGUID: 6wdeMZe+TLSjtN4f4NKlnw==
X-CSE-MsgGUID: 5xEP0JxTRL+QHcSl1Lq/oA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7503799"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7503799"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 17:51:47 -0700
X-CSE-ConnectionGUID: PrYGTXviR2yD/g/e2Xh0tw==
X-CSE-MsgGUID: X5yaSiBeTceFMXUqKmTuHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18672295"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 02 Apr 2024 17:51:45 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rroqs-0001gn-0y;
	Wed, 03 Apr 2024 00:51:42 +0000
Date: Wed, 3 Apr 2024 08:50:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:intel_pstate-testing 14/14] intel_pstate.c:undefined
 reference to `arch_rebuild_sched_domains'
Message-ID: <202404030858.0AJW6re4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git intel_pstate-testing
head:   e35f6a1b27a71e7c8cb1880197e01d93b593cc85
commit: e35f6a1b27a71e7c8cb1880197e01d93b593cc85 [14/14] cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems
config: i386-buildonly-randconfig-001-20240403 (https://download.01.org/0day-ci/archive/20240403/202404030858.0AJW6re4-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404030858.0AJW6re4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404030858.0AJW6re4-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/cpufreq/intel_pstate.o: in function `intel_pstate_register_driver':
>> intel_pstate.c:(.text+0x232e): undefined reference to `arch_rebuild_sched_domains'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

