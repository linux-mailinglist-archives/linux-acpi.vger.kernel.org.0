Return-Path: <linux-acpi+bounces-10749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB96A15B18
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jan 2025 03:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB0167DDF
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jan 2025 02:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1408140855;
	Sat, 18 Jan 2025 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaxRbCsP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64458F507;
	Sat, 18 Jan 2025 02:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737167896; cv=none; b=NLm9OHCPRWD8xzmuHhHH1cq044Q/xYw6u4UHp7IlhNNLprmxu3M/EQQRMVf3T9X4QBgf5DG1AZDyFNhBE45sQm8lSTIFt30KTSKIrLzh4JYMrGGLYedO9SS7rP3bA0vU2Lwdmz5H3xssZieIxbkWLflF3OqXazoiH3XBJK24Zio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737167896; c=relaxed/simple;
	bh=kodQxwwBcXy2fga1isLQuccPgQM8MH6REQC6XoX/EPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOx1BVzpzlwRlWiBXBbCIP1AbvsXwleV0bd8v6LGcpvOrvzPnE0kyODxQVsYBgHu3W8EBu0Own4AeEOfiKWmCUeY/WjwywLjqhyt1NFfHicEPvrp67KQOlRuhbQUqF43/2bGsaLfM75t0ZPQA+f2VIX1vGDLO7Qd9RxszFktiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaxRbCsP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737167895; x=1768703895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kodQxwwBcXy2fga1isLQuccPgQM8MH6REQC6XoX/EPw=;
  b=GaxRbCsP5ajqvdkx8Qm6rsYj0HTAs03eOkqFW1VOZ8mj4lTgRZ+QtKkE
   7owe9P5OoJv5QNqFC2NHeHLe0zNDMtkN0eI6x7vxhgu4wLCXz4ybv6YUr
   FocXWkjPKPUUrJ28lywns2qF56pBpBtB6XKTFo3EyeGXhdBnRn2rmg4Pl
   KLqjlb1HZuSimYT7Si6T28RqVriIezNMzWNtVC/gjETxJlHlYACMSXdnk
   GRiE3a3Qg3MdJtf5zyNNoRXE7nS6EB+2tAjDBZAMZ5jORzckpU26aHxoF
   3Aevit38oMbQeEOuyjS6RvsFsTmDGTCj2TTzWcRybwogjze07Z/8Dsmwt
   g==;
X-CSE-ConnectionGUID: bBdrJtUHQW6NujxhelOMHg==
X-CSE-MsgGUID: EvrylrERTZGJL9Sgy4ZWBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48284271"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="48284271"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 18:38:14 -0800
X-CSE-ConnectionGUID: 1d+YHYsETxqJ+S+FuvUzjA==
X-CSE-MsgGUID: S0PV8amMTvq5OriV29SPuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="110962931"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Jan 2025 18:38:09 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYyit-000U11-1y;
	Sat, 18 Jan 2025 02:38:07 +0000
Date: Sat, 18 Jan 2025 10:37:29 +0800
From: kernel test robot <lkp@intel.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
	will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@arm.com, xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org, lenb@kernel.org, tony.luck@intel.com,
	bp@alien8.de, yazen.ghannam@amd.com
Cc: oe-kbuild-all@lists.linux.dev, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v3 2/5] RAS/AEST: Introduce AEST driver sysfs interface
Message-ID: <202501181043.Qi8ohhYk-lkp@intel.com>
References: <20250115084228.107573-3-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115084228.107573-3-tianruidong@linux.alibaba.com>

Hi Ruidong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge arm64/for-next/core ras/edac-for-next linus/master tip/smp/core v6.13-rc7 next-20250117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ruidong-Tian/ACPI-RAS-AEST-Initial-AEST-driver/20250115-164601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250115084228.107573-3-tianruidong%40linux.alibaba.com
patch subject: [PATCH v3 2/5] RAS/AEST: Introduce AEST driver sysfs interface
reproduce: (https://download.01.org/0day-ci/archive/20250118/202501181043.Qi8ohhYk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501181043.Qi8ohhYk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/hwmon/isl28022.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/isl,isl28022.yaml
   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
>> Warning: /sys/kernel/debug/aest/<dev_name>/<node_name>/record<index>/err_* is defined 2 times:  ./Documentation/ABI/testing/debugfs-aest:69  ./Documentation/ABI/testing/debugfs-aest:76
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

