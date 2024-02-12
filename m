Return-Path: <linux-acpi+bounces-3390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B0A850D15
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 04:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25ADCB21721
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 03:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3860B4428;
	Mon, 12 Feb 2024 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xdd6t8gu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC346A4;
	Mon, 12 Feb 2024 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707710193; cv=none; b=UDxTRSOOriA3AM4fgzWQEytB5QyXebU38+sgZHt8DlcP7hvOVdvGAnQQhp2z9Sv40t//VBc8IoaiLTosKQVBdD5A2ANHSAqaa8aPpqt0W1HQ5kyHL1IqfZMV6FV9Yk8yjhvp9ol8ZcBboycDx2X3pD2Y4+dQjcXiSj5yTSYX2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707710193; c=relaxed/simple;
	bh=A4MxOKydhK2D4lZnGkKga+h+MkQ6vwlVIvb/uPDHRP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U48P/pNJz2QxuHBXLTB1rshTW8XbpF1YTncLcpPDioDAZfPUoSBZr1Zy7cVcCTD1GdAc3uPd/NjbiHAu1he5V6QaWA4GZQ6NdTUbEhpkl2BPhJ1jex+D2u9yTREJBYRurRftaHZynx05DIScnI/ClTk0oCkRr2xZFUQNINcVkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xdd6t8gu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707710190; x=1739246190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A4MxOKydhK2D4lZnGkKga+h+MkQ6vwlVIvb/uPDHRP0=;
  b=Xdd6t8guKnhOLlkq+SdpRMT7ZakBE78nI+k9cWCiXO3TJ4QQ2moFJ6ir
   7TTH4LNRprPxdb40mWdk59Y+/JlhpBN082Z7XMu5eIxhTDwPbDRg8XpWA
   n2fCJPjRu4nLm72xWCUFG1eP+YeKAwEl6uxKCz6qMfy1VTQlobRcfaAnr
   db/oo/h+miwHjA6WQxmVp5bCqFtOadejlj10qlA1h0T0n0atpMTrJeLNv
   n52PPB4JY5zh93XB7gRJRkFO6IsXZY5CSR/7MUVu8sk0oZJh7Wm2IFMSf
   xcRPznMfJpLOQkE/zZ8GP7rHlAJb00xTtLlB2LF7b/WIgp4xbRNhHG8zY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="13046955"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="13046955"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 19:56:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="934982006"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="934982006"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2024 19:56:27 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZNQf-0006ty-0L;
	Mon, 12 Feb 2024 03:56:25 +0000
Date: Mon, 12 Feb 2024 11:55:39 +0800
From: kernel test robot <lkp@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [rafael-pm:testing 44/61] kernel/power/energy_model.c:113:15:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <202402121149.SmoySn7a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git testing
head:   c3c4923f2082353762e8f46dec6e3b0f165a1606
commit: ca0fc871f16f4bef746b5ba814b67afb59119700 [44/61] PM: EM: Introduce runtime modifiable table
config: x86_64-randconfig-122-20240211 (https://download.01.org/0day-ci/archive/20240212/202402121149.SmoySn7a-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402121149.SmoySn7a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402121149.SmoySn7a-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/power/energy_model.c:113:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct em_perf_table [noderef] __rcu *table @@     got struct em_perf_table * @@
   kernel/power/energy_model.c:113:15: sparse:     expected struct em_perf_table [noderef] __rcu *table
   kernel/power/energy_model.c:113:15: sparse:     got struct em_perf_table *
>> kernel/power/energy_model.c:114:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct em_perf_table [noderef] __rcu *table @@
   kernel/power/energy_model.c:114:15: sparse:     expected void const *objp
   kernel/power/energy_model.c:114:15: sparse:     got struct em_perf_table [noderef] __rcu *table
>> kernel/power/energy_model.c:119:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
   kernel/power/energy_model.c:119:19: sparse:     expected struct callback_head *head
   kernel/power/energy_model.c:119:19: sparse:     got struct callback_head [noderef] __rcu *
>> kernel/power/energy_model.c:130:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct em_perf_table [noderef] __rcu *table @@     got void * @@
   kernel/power/energy_model.c:130:15: sparse:     expected struct em_perf_table [noderef] __rcu *table
   kernel/power/energy_model.c:130:15: sparse:     got void *
   kernel/power/energy_model.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct em_perf_state [noderef] __rcu * @@
   kernel/power/energy_model.c:195:9: sparse:     expected void const *
   kernel/power/energy_model.c:195:9: sparse:     got struct em_perf_state [noderef] __rcu *
   kernel/power/energy_model.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct em_perf_state [noderef] __rcu * @@
   kernel/power/energy_model.c:195:9: sparse:     expected void const *
   kernel/power/energy_model.c:195:9: sparse:     got struct em_perf_state [noderef] __rcu *
   kernel/power/energy_model.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got struct em_perf_state [noderef] __rcu * @@
   kernel/power/energy_model.c:195:9: sparse:     expected void *p
   kernel/power/energy_model.c:195:9: sparse:     got struct em_perf_state [noderef] __rcu *

vim +113 kernel/power/energy_model.c

   108	
   109	static void em_destroy_table_rcu(struct rcu_head *rp)
   110	{
   111		struct em_perf_table __rcu *table;
   112	
 > 113		table = container_of(rp, struct em_perf_table, rcu);
 > 114		kfree(table);
   115	}
   116	
   117	static void em_free_table(struct em_perf_table __rcu *table)
   118	{
 > 119		call_rcu(&table->rcu, em_destroy_table_rcu);
   120	}
   121	
   122	static struct em_perf_table __rcu *
   123	em_allocate_table(struct em_perf_domain *pd)
   124	{
   125		struct em_perf_table __rcu *table;
   126		int table_size;
   127	
   128		table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
   129	
 > 130		table = kzalloc(sizeof(*table) + table_size, GFP_KERNEL);
   131		return table;
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

