Return-Path: <linux-acpi+bounces-17370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DADBA5FBA
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 15:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E64173A88
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD42E03E1;
	Sat, 27 Sep 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuPc3xRs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F512D6605;
	Sat, 27 Sep 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758979623; cv=none; b=cpwzAEsEw2L7tKFO/+bs0hQsTKZsHVwwqMyKBmF3HCSdEFBOyYHmpBNETJR1GeIZnAbDSpBiaH8Orui1PvLzMXGmRKXptsJqYOZ+Q9jZoXaFOZEaIMytW5F8AfffYz7i4vzgg//qdaoGu9UqI9EatrtIpU5TQ+AC8AG39J95Arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758979623; c=relaxed/simple;
	bh=fRtju74/JSHvPk0SkIzEvZPSjq0GaZdidyiTkuBepG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hfBCPzGdFsdepKukKFqHG3aSXfSAaFMSQ2YUvpqOH5fFJC4Q8HhGg9D8FxAu20cNnP4JPkH66fH4XuULfbVUhPiQlCchXc1xoGbTdTTYPhIaqxtXxdEbwvrFZWJ0qqwSaDk8GVKmDUwjjpzW2PC0Lf6agZC0s7lX9566JgWedtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuPc3xRs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758979621; x=1790515621;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fRtju74/JSHvPk0SkIzEvZPSjq0GaZdidyiTkuBepG0=;
  b=HuPc3xRsjE8nZJka/CYjEnQQRssmD5PNc+26W5zF00y8pEPbN6N9PLWu
   4Gw7Ya5gt7YeDRJVfrK3QC8ZXN7qM4p1uP0IiXLWMkuK3uXk8/8d7vg2e
   kcBbKfgd7fTQMj1C/cLR6L02YnWPGaK/eBtju8UnHhfv7qwGH47wc24Hp
   OanUA3urVjy2AGIoEupXREcrrHxviEk+eTmKUV8lwXeSilD/Hlt1OFyJB
   MQg/dF3UQ4vDCLd0JVNL59YNzVsNhKHtTiX7V7nKH0d0YzXAYUf5WD3II
   VZXdYzqMHUJJjhKYTi2at98U3Jzp5foxsoq0K9zsmTTeyVVq7wWkDqjZL
   Q==;
X-CSE-ConnectionGUID: vD0fN7qKQsC0qbnE+Ps+/Q==
X-CSE-MsgGUID: UfidrssmRU2U6lyK683UeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61179982"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="61179982"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 06:27:00 -0700
X-CSE-ConnectionGUID: wHWQzKNASMe9ZanJAjKQ3g==
X-CSE-MsgGUID: 5stGFlKCRlihrurRW2XcYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="182240115"
Received: from igk-lkp-server01.igk.intel.com (HELO 0e586ad5e7f7) ([10.91.175.65])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2025 06:26:58 -0700
Received: from kbuild by 0e586ad5e7f7 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1v2Uwx-000000005VB-46Qo;
	Sat, 27 Sep 2025 13:26:55 +0000
Date: Sat, 27 Sep 2025 15:26:22 +0200
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>
Subject: [rafael-pm:bleeding-edge 204/212] error[E0425]: cannot find value
 `CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS` in crate `bindings`
Message-ID: <202509271504.gmr2aLzD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   95b83771c9f38207ff42311ccc4739db76d19f33
commit: 8cf63e01b6b73132d69c04d35f11738705467281 [204/212] cpufreq: Make drivers using CPUFREQ_ETERNAL specify transition latency
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250927/202509271504.gmr2aLzD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509271504.gmr2aLzD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509271504.gmr2aLzD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find value `CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS` in crate `bindings`
   --> rust/kernel/cpufreq.rs:43:19
   |
   43    |         bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS as u32;
   |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: a constant with a similar name exists: `CPUFREQ_DEFAULT_TANSITION_LATENCY_NS`
   |
   ::: rust/bindings/bindings_generated.rs:12861:1
   |
   12861 | pub const CPUFREQ_DEFAULT_TANSITION_LATENCY_NS: u32 = 1000000;
   | --------------------------------------------------- similarly named constant `CPUFREQ_DEFAULT_TANSITION_LATENCY_NS` defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

