Return-Path: <linux-acpi+bounces-17038-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2587B59CDB
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C235212C1
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81D2374298;
	Tue, 16 Sep 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7yqTH1x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688632C11CE
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038506; cv=none; b=YxrxTi37WqLAP6mBtV2D/M4qEXuiIz1p5vl99+eguiGYCq4+7iI9/1ysyC4OKU9jQFCUhGpSLEhSeUJ7d1ZM1VW11zQ63yf6m5I8coquU/jDllUhArzhHwmFstDqiMsjbJWYJBp1xueOPz9fmCO0TYRba3632Pirui2IJyIIJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038506; c=relaxed/simple;
	bh=B2qYXoILk/DYIyxK+5+jce29Axc6iUgAh2GsD4B1DdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPfBkx8UblL2SS/RSc+7WT4z+t1HMpd3nVP6Gwnsytr4b7PS/QJDAht4955xMfcFafl8Ez2gShI3cV8w9+SqSymaw9UgllegLHFlPsnV9ZHQ1Gnmff0F6Ltj+jU95HxMf/rZIN/8rbavUL5yBGnNylE7wXhIQizqmUmbvaoYJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7yqTH1x; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038505; x=1789574505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B2qYXoILk/DYIyxK+5+jce29Axc6iUgAh2GsD4B1DdI=;
  b=K7yqTH1x9zPlJ7v7/6Xf4i+LUWVQIhaHuAHspNyByXh36Tjftv6YG9lF
   TVzapsJrckyTqiR//aPcuIdDGoPFaK44kM9hReTqQVc5j/RNgND2q6jjs
   vIyZvIPdWu/wkKrAswdxpui2MWa1FnL0c0lZBhbhxHgHq9hFWEyYSKb9r
   wRGWISfYUEcs+JkSPbuJ0Pmy9bxBva3qK23ISJg38fcE1OGsRYhcj/Oh2
   ODZEOVppEgWedQ4dDxLc5Dzczdxy6xKzfhKNu455IpT9+tBlMJ7eYEpaf
   MToikNzfdewM693IyTNOuhBPxbnHRW7HdZ4HB4cnp3yDDLTHfvpGJbvqt
   g==;
X-CSE-ConnectionGUID: VytqZZhrRVajgECd0NfZHQ==
X-CSE-MsgGUID: Q8qBdTz8SOOC/EeMGbH+dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422989"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422989"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:41 -0700
X-CSE-ConnectionGUID: Q51OeCbJQIeXpRxDxG4X8w==
X-CSE-MsgGUID: MdkeNNDAT6qmrRFdOQcVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091549"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8CFA1121F13;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gb0f-2EKL;
	Tue, 16 Sep 2025 19:01:30 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 14/14] spi: cadence: Remove explicit device node availability check
Date: Tue, 16 Sep 2025 19:01:29 +0300
Message-ID: <20250916160129.3955410-15-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't check the availability of child device nodes explicitly as this is
now embedded in device_for_each_child_node().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/spi/spi-cadence-xspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 6dcba0e0ddaa..23e426ef9b9c 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -908,9 +908,6 @@ static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
 	unsigned int cs;
 
 	device_for_each_child_node(&pdev->dev, fwnode_child) {
-		if (!fwnode_device_is_available(fwnode_child))
-			continue;
-
 		if (fwnode_property_read_u32(fwnode_child, "reg", &cs)) {
 			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
 			fwnode_handle_put(fwnode_child);
-- 
2.47.3


