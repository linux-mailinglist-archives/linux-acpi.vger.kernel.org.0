Return-Path: <linux-acpi+bounces-14691-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2652AE9EB0
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904433B0F80
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6028C016;
	Thu, 26 Jun 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwY0jOjB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581A28B7CC;
	Thu, 26 Jun 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944402; cv=none; b=lDtLijoXyH7UCnXnOSJLxelxsP9joLJ7o+nvwLBiM+IWv9SRu98mFdSBEN5RR4rhX9J88fiwACbtQ3KeTk3TKbS48ew1oQtk7p37F5W73pXQjYLvq1oznRUUNSzcxlcbMhcY0cjMvTU2CKDhKRMbT9eM6dvEx1/XEYsPbJErfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944402; c=relaxed/simple;
	bh=On1ai4dZklsJYuX9vQzfB1wETLIETlbz6WbH81Mp3hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lroag9zpZuBsZtEGrF9vXJc2Ci4sq6JSTtmjXspisP9Il2mD0ww/564pWLK1AAl3BZqdpUZ/i/QlLWvtr7AZ3vzmWt629cuJkDp8D61GrpOn4ZffZs+Pc11gRntreaXD+wpzO39J69QU1ZyMHLdtMCp5dvxSoHeLIQRTDgHGxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwY0jOjB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750944401; x=1782480401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=On1ai4dZklsJYuX9vQzfB1wETLIETlbz6WbH81Mp3hg=;
  b=GwY0jOjBXr7PgWb5GZFz1znO18GoOf0XNcQsQAj5pOPOqbL/f19f/MfS
   /odN/EWkpc8oSOKJbCqhVRwZpA9Lq/bfFbJYGKIwAsoyjZwQlP2OTNW2z
   MLScFw69zzHRgwgOsowmFNyKFKbsYmicnQD4R/ZUuCZe1g8qsl3opcTgz
   zrJzSJldiEDCDJMcuxM1waWgcR1rH6u2LnABO3y2qX9nx+Pg3cnM6bN+0
   RpS2DNxnS+wQiMv07jcVi2kwgIMt4SG/J6nOhnAotIyHAY25RUZC9C1Dv
   fqfoMNXcBIods1Qk5xFHyD712lULTPd5ZxNUwQzlt8ALP3JkB0/SSbTP8
   g==;
X-CSE-ConnectionGUID: LS36jmZGQieryh9/O4Q3uw==
X-CSE-MsgGUID: Fdg/GCWsTa+TOvuctnzuRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70809836"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="70809836"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:26:40 -0700
X-CSE-ConnectionGUID: aMX5AkRNQr+L8NUyedp/Xw==
X-CSE-MsgGUID: VvngBVbmTFm1/1+imcMX4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="153048528"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 26 Jun 2025 06:26:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C2641345; Thu, 26 Jun 2025 16:26:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 1/1] ACPI: LPSS: Remove AudioDSP related ID
Date: Thu, 26 Jun 2025 16:26:05 +0300
Message-ID: <20250626132635.221064-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AudioDSP drivers are in control for all functions of the hardware
they have (they are multi-functional devices). The LPSS driver prepares
for enumeration only single devices, such as DMA, UART, SPI, I²C. Hence
the registration of AudioDSP should not be covered. Moreover, the very
same ACPI _HID has been added by the catpt driver a few years ago.

And even more serious issue with this, is that the register window at
offset 0x800 is actually D-SRAM0 in case of AudioDSP and writing to it
is a data corruption.

That all being said, remove the AudioDSP ID from the LPSS driver,
where it doesn't belong to.

Fixes: c2f8783fa2d0 ("ASoC: Intel: Add common SST driver loader on ACPI systems")
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Tested-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed Fixes (Cezary), added tags (Cezary)

 drivers/acpi/x86/lpss.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
index 258440b899a9..6daa6372f980 100644
--- a/drivers/acpi/x86/lpss.c
+++ b/drivers/acpi/x86/lpss.c
@@ -387,9 +387,6 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
 	{ "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
 
-	/* Wildcat Point LPSS devices */
-	{ "INT3438", LPSS_ADDR(lpt_spi_dev_desc) },
-
 	{ }
 };
 
-- 
2.47.2


