Return-Path: <linux-acpi+bounces-12813-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D89A7EC30
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F627A296A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F62571BD;
	Mon,  7 Apr 2025 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIhqjflx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F49256C68
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051673; cv=none; b=oskiLd6teTX6YkJA1V81l/aVmr8SVzI8nAMq7AzZMl9tfvAZxC1rrxEOtFKDo38aoJWPLADhDvzKqx9iBI2UZ21xlOgj3iZWWRvfGUCrzizcLf/8Z3ci2Z0GcBHQaautdp75hHhOUL3SB+PEXhnZ7rT42PEYPLae+jHCJI4UEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051673; c=relaxed/simple;
	bh=jc+HkENZJIE/WyOoX7Wd1g4lRbZOlgcYKfYj6l/NAHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bw/o0cQwaWyvS6vxQ5JYAsNiCZ/3WrBXejcNySaw6k0S4d31+4v4BeeNxyqCIuIVB95xUhieZa7HQeQTNC/gGFyKIpC8XzcS8dFGZEi73bv+juB+WrruaRXrZTSDjO3SuCpI4tUcYf7cJ7mPFCjmgcNNtZNWIPAxjuh9ck3GIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIhqjflx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744051672; x=1775587672;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jc+HkENZJIE/WyOoX7Wd1g4lRbZOlgcYKfYj6l/NAHc=;
  b=kIhqjflx1BpmJlkYERnphiHj+TjzX8N4naXhldICbBubbjmokxjaoESg
   e33T5Nx4bmCTXrGUb6LDbmM+Yoapu47d/tecNiYyI7Xv8BVJOmUk2+tr7
   1McdtSddEGwKcFU2xUH3cOuMa2sBlHzT22wuLO7bqiTGBX6h9GED+XVee
   1vEIedg63vZPO2QcPhoUkgTZnvkMyMqQD/VHxxa7Y1eXdzoK7F2eOB1CV
   1WKX67CBOen2TH0MgBbTKXO4jGhCkn/Grksnx0hWRGJ6kIrmAZkepyvvt
   vz40LJ4/cRRdIhqKqzQfb+2wD8rOeyotdmqsXlCtKYskzMqttJnY9YV4/
   g==;
X-CSE-ConnectionGUID: P82jyuZrTCmKeMXcfHUf0w==
X-CSE-MsgGUID: jh8jmjprRle3W92674oAGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45167633"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45167633"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:47:51 -0700
X-CSE-ConnectionGUID: 3O06cto4TVmpELNz1wcTtQ==
X-CSE-MsgGUID: GH3E5Cp/SaaUsXrsWq9RtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="127788685"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:47:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u1rVb-0000000AAPo-3Vdt;
	Mon, 07 Apr 2025 21:47:47 +0300
Date: Mon, 7 Apr 2025 21:47:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: ACPICA compilation error on x86_64_defconfig (W=1 build)
Message-ID: <Z_Qd0x6bLSQjJ7Rw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

v6.15-rc1 (but seems older should also be problematic) fails to compile by
Clang 19 with `make W=1`.

  CC      drivers/acpi/acpica/nsaccess.o
  drivers/acpi/acpica/nsaccess.c:295:6: error: variable 'num_carats' set but not used [-Werror,-Wunused-but-set-variable]
    295 |         u32 num_carats;
        |             ^
  1 error generated.

I looked briefly in the code and I have no idea how to fix this, as probably
__maybe_unused not an option for ACPICA. Hence this report.

Note, the in-tree defconfig is in use:

	git checkout v6.15-rc1
	make x86_64_defconfig
	make W=1

should trigger it.

-- 
With Best Regards,
Andy Shevchenko



