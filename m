Return-Path: <linux-acpi+bounces-14208-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B44AD08B8
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 21:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E231727A7
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 19:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D77204863;
	Fri,  6 Jun 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMJGfjbx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7017FBA2;
	Fri,  6 Jun 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749238644; cv=none; b=nehTHqUyUy1RVqnZuyJiMaqaPxxVAdsd/RqDGEj3J9LdQGOhjDpBcewYhkB+pdPSnSkz47XkSn3MzL68ac8OI4hKtbthWo8Qr2ZyLHkbFTf1nCxACie+/D+jZdaiLUrNJmUWkYnEryhGHFswP/xYTnkr5YDAKaD75eRyck71qDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749238644; c=relaxed/simple;
	bh=yauKZvBgJgkLXxhOcb4XcPY7cqiucnyOqvsgSihOc5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=apBKqrh/cn1gZ7Op9nbnKQ3eybTaB15V/mo80BLLx1ky7A0OpzTZmCjU563jJdYcVccTw9BfDcs3HT3ah4plq/zo7HuqOuIxh9Ujqbh0QHsD2rLx9f/dlaTYABaM/w0frHjIDWdcvQG3ZJHemTrQQHZmeAmkoKrKemxhv2QXzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMJGfjbx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749238643; x=1780774643;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yauKZvBgJgkLXxhOcb4XcPY7cqiucnyOqvsgSihOc5w=;
  b=fMJGfjbx0JDZk+kqodmf3GpR1DJVj0ajz17c5WdfcHnRsq7yqqFvtF9F
   jqkEqB2pi6zERKZg5vIcXBXzhyI4KGF9sYkvIT5syBskGcwFgK6t1lXv0
   Vc8U3c4P8E7pCGI7KS+YsKqtp29/LFQLBF+AYyQpEk2XtGVQj9zg2rEDl
   YQLrL9qJDhjBAfRtCuLBIbPWBq7/0Jo3pGW8j6a7s/yu+AcQ/wL3HE8zj
   jJCuE8HWBRjMRXX5H+Pft04ZMR4B91yDNs3TJCd+e5430fXYpACsvKzcl
   UFK/67v/eKTQQvBICvKZ7B/qdAEoM9sc0k8Cx/fHYXWsUMbqqa4nvsnQ5
   Q==;
X-CSE-ConnectionGUID: +R51QbclRKezN0+CNWw9kQ==
X-CSE-MsgGUID: JmBlSM2wSKaV2mUOkDTUZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="62794188"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="62794188"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 12:37:22 -0700
X-CSE-ConnectionGUID: qomSxd9RQJ2x0B+qhszmmg==
X-CSE-MsgGUID: aUWKipvwSb2oBZbAWpFSuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="176857294"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Jun 2025 12:37:21 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNcsQ-0005Ez-2R;
	Fri, 06 Jun 2025 19:37:18 +0000
Date: Sat, 7 Jun 2025 03:36:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 7/9] drivers/acpi/processor_idle.c:63:
 undefined reference to `arch_cpu_rescan_dead_smt_siblings'
Message-ID: <202506070341.ACtZRDtC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   aedfeec2f90dc1553d4e2230c4f5d30c2a6876d4
commit: 0e0551545a620641d99184afff8b2079cedd11da [7/9] ACPI: processor: Rescan "dead" SMT siblings during initialization
config: i386-buildonly-randconfig-003-20250607 (https://download.01.org/0day-ci/archive/20250607/202506070341.ACtZRDtC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250607/202506070341.ACtZRDtC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506070341.ACtZRDtC-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/processor_idle.o: in function `acpi_idle_rescan_dead_smt_siblings':
>> drivers/acpi/processor_idle.c:63: undefined reference to `arch_cpu_rescan_dead_smt_siblings'


vim +63 drivers/acpi/processor_idle.c

    58	
    59	#ifdef CONFIG_ACPI_PROCESSOR_CSTATE
    60	void acpi_idle_rescan_dead_smt_siblings(void)
    61	{
    62		if (cpuidle_get_driver() == &acpi_idle_driver)
  > 63			arch_cpu_rescan_dead_smt_siblings();
    64	}
    65	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

