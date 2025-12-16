Return-Path: <linux-acpi+bounces-19600-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B89CC178C
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Dec 2025 09:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70F983022D0F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Dec 2025 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F1534B421;
	Tue, 16 Dec 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwBLfLlA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8032D45B;
	Tue, 16 Dec 2025 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872482; cv=none; b=dzWbZPsgoBNPaWOkFqRDfJocZH776EG6IsZYt61jm9LLG/p00TtS20HP7E7pvEFO6ssSq9COAHyBuip7IPMA4jyL0hv6sN24v1W+2+4vULH+ET30a3WSZQi7lV8fhG+9OcMWJhSPsPnBNQzWD9rQoIAlQMLXRLCD1ulbPPQ0qyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872482; c=relaxed/simple;
	bh=7ya8M9nKw1DttSbzGdH88QyhTyenkyVNYWjg62SeJME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H4LOtEPTr/2XnQnUHkgrfTS3ONVkG9pi/vBU/x92mlKX0xeqI1ELLtZiB1MTSvzH6KNBGahCi9jNejBB0O8TNRdjVPxIuNB6ELGkVfuFWiELUVLVpfo5gwsFjY7vCVVwywGi+lAYu7BRFTvvYlSBCLm+ft0OZU0koR+rEikktRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwBLfLlA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765872477; x=1797408477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7ya8M9nKw1DttSbzGdH88QyhTyenkyVNYWjg62SeJME=;
  b=kwBLfLlAbGaXtz41u1j/sNh1DkaDE7UT7t4Rjz7eF26/xTntCPkD5jyP
   8DUyWBnFxCA8oI8cNaTgBeWVvx6AhrrxR5wf41OAOOxMe2Pl+E2+heCX7
   KBY+FKssapu0iPmZau+y6ZUpUcN6IorjreMIggxFrYwksOHSMbdUCJo0Z
   FE64SubGme+avTtAKyKxYnDpq0fiw9L9vd9U7BE5BSh+fLInuW4e7Dv3x
   moaFO6yCe5mQwWatPJorAhqdwEGvUbguqB6Xu/4+a/nPnoNVK+KmVe7rp
   GHfu+7lTdeNtb30sZurn/iEeNOJHs26AuU8PnVZ7fB96jl35ISnOpz0vc
   A==;
X-CSE-ConnectionGUID: xPY7X+/LRCST1/usI9JphA==
X-CSE-MsgGUID: ZaodUJecSH6ZZzDlBOgx1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="71638341"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="71638341"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 00:07:56 -0800
X-CSE-ConnectionGUID: X2clB673RmOuffU0Xoy/ZQ==
X-CSE-MsgGUID: fyd5hP8cR1iH2gkhdT5CgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="202864556"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 16 Dec 2025 00:07:55 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVQ65-000000001LQ-1A4X;
	Tue, 16 Dec 2025 08:07:53 +0000
Date: Tue, 16 Dec 2025 16:07:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [rafael-pm:acpi-queue 25/29] drivers/acpi/scan.c:2753:34-35:
 Unneeded semicolon
Message-ID: <202512161613.2xk2GzgN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-queue
head:   e88d169a6053918f230dfc78ee0eff2c2a2ca9bf
commit: 685f8a959d00a36e01207e4ea2051259afb226ec [25/29] ACPI: EC: Convert the driver to a platform one
config: i386-randconfig-053-20251216 (https://download.01.org/0day-ci/archive/20251216/202512161613.2xk2GzgN-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512161613.2xk2GzgN-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/acpi/scan.c:2753:34-35: Unneeded semicolon

vim +2753 drivers/acpi/scan.c

  2743	
  2744	int acpi_bus_register_early_device(int type)
  2745	{
  2746		struct acpi_device *device = NULL;
  2747		int result;
  2748	
  2749		result = acpi_add_single_object(&device, NULL, type, false);
  2750		if (result)
  2751			return result;
  2752	
> 2753		acpi_default_enumeration(device);;
  2754		return 0;
  2755	}
  2756	EXPORT_SYMBOL_GPL(acpi_bus_register_early_device);
  2757	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

