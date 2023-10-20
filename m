Return-Path: <linux-acpi+bounces-782-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F97D0D61
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F158C1C20F30
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600DF17982
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGUfNDHy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BF101CA
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 08:48:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69FED52;
	Fri, 20 Oct 2023 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697791693; x=1729327693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ycYM//IBzYahr1OT+k/0SqcANs76449DXAt6/AuLX9M=;
  b=DGUfNDHyfUwZk67l/7ienlCmcACFM+T7a4497ecipvcMGwx61kTH96cj
   hjnCzgj9WGBuqM+LFN8O8o3+9/xOkEF2BA+lTCQnVDWD7hcve1H7IGHLI
   nLK7P48ZxPFlyKsutg+LrQgjACIV7Caxs6wZNmXM5vi0MKPZQbrEhQd/W
   Q8CYhzQeRCI96r5vfj5wRaj9L8v60Swjwd1o024ecpzsmjufeA/421ZF0
   RGn0sW/HRZCp7U0/Sj+wR41rZlQ3XVciY8XDuSsrJGK3K/ygaQOI3r3Js
   5U9Pfiy1CSvrtUs17fxQ7GO5GaXDwckDTfuFNsyGTe0ByS2544JgchEqI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450683524"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450683524"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873832171"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873832171"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 01:48:01 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	robert.moore@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux@roeck-us.net
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 4/8] ACPI: utils: use acpi_dev_uid_match() for matching _UID
Date: Fri, 20 Oct 2023 14:17:28 +0530
Message-Id: <20231020084732.17130-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Convert manual _UID references to use standard ACPI helpers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 664b9890b625..e3ba835e6590 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -889,8 +889,7 @@ static int acpi_dev_match_cb(struct device *dev, const void *data)
 	if (acpi_match_device_ids(adev, match->hid))
 		return 0;
 
-	if (match->uid && (!adev->pnp.unique_id ||
-	    strcmp(adev->pnp.unique_id, match->uid)))
+	if (!acpi_dev_uid_match(adev, match->uid))
 		return 0;
 
 	if (match->hrv == -1)
-- 
2.17.1


