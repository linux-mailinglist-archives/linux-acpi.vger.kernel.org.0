Return-Path: <linux-acpi+bounces-1640-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 511EF7F2075
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 23:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AED1C20A2D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 22:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462B38F81
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rj4a0Fed"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3733ECB;
	Mon, 20 Nov 2023 13:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700517505; x=1732053505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RUVd5dQlPkTNx/mYNqXBDe31H3anIGZCPPAlDc79GMA=;
  b=Rj4a0FedPOSf68a/sz+ZE/CvilwAaqGqDjPsjM6wO9b4GV3s2XYxFUFp
   UKa1U/2c/pPxtCHrOmRUgYTvB01FT+E0AQ1x108JISKUxgWUibeYIlDWP
   Jtoin/V4IrBtpzdJFnX4xd+rxkL1X2YeRkrJiXmoYEOtjvXazhuTfmCBe
   7clh+GpjWYESd/kBsQS7+CJHLpK/ToNB1PKlzvWvciLPsJ8E174Zro+vm
   L9vHCfQMEAMR13WYKiQgTeKyjmpimIYUJo7WciHfw8+KKCLyCOclS8l69
   5CzLxnOQMipNaC+gc3l0UdLlY878o2h9mRa3Bm78ODFlH5p7MAsByNUz9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="477920169"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="477920169"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 13:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="7850310"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Nov 2023 13:58:23 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5CHX-0006xu-2D;
	Mon, 20 Nov 2023 21:58:19 +0000
Date: Tue, 21 Nov 2023 05:57:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 13/27] thermal.c:undefined reference to
 `acpi_passive_trip_temp'
Message-ID: <202311210503.P7Q5J2On-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f437a8d1debff5412e36a1c9454adee193b31950
commit: d967ccd25df78cb5bd789ce9799d4463ea77eb5b [13/27] ACPI: thermal: Use library functions to obtain trip point temperature values
config: i386-defconfig (https://download.01.org/0day-ci/archive/20231121/202311210503.P7Q5J2On-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210503.P7Q5J2On-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210503.P7Q5J2On-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/thermal.o: in function `get_active_temp':
   thermal.c:(.text+0x22): undefined reference to `acpi_active_trip_temp'
   ld: drivers/acpi/thermal.o: in function `acpi_thermal_init_trip':
>> thermal.c:(.text+0x356): undefined reference to `acpi_passive_trip_temp'
   ld: drivers/acpi/thermal.o: in function `acpi_thermal_adjust_trip':
   thermal.c:(.text+0x872): undefined reference to `acpi_passive_trip_temp'
   ld: drivers/acpi/thermal.o: in function `acpi_thermal_add':
>> thermal.c:(.text+0xaec): undefined reference to `acpi_hot_trip_temp'
>> ld: thermal.c:(.text+0xd79): undefined reference to `acpi_critical_trip_temp'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

