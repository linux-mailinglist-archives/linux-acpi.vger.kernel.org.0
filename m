Return-Path: <linux-acpi+bounces-7163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D04942B48
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5899A1C210B7
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A671A7F7B;
	Wed, 31 Jul 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDM4Lq1B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E23CF73;
	Wed, 31 Jul 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419639; cv=none; b=A4f/c30TfbzibuANv6e5ZazTPJZNpBJTBeG7vtuRvH1ua8BF9sJrDRD4RbnEPtQdIE0VHxd2LP+AP0ZQFQtw3ZklthOixiH+nd+mI58OqAVnAGQSM+iTSaaluPj9VA2qy+gj8mZN0uW6zeY368CW+nUnaBkPZ20+tB9x7Tg7jQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419639; c=relaxed/simple;
	bh=rxk/NxfRpx/PeHLsJi8F8nFmIB84b5MwuGyDY06PgZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=twoDRFaayv7dImDz2D44r/zII1cDBWggXuMGnMWPJ077ByXrjC+bkiMeMgvPthCuIoC5AT4lqFnEoKL/6BpgWjnn3b2V8h1ZQeeheAqLYNH6E6GSDwtiqbWAEXq7VU27cd5DdpimxRRZajXMKPgS6fWadXJyS1AXA7EnpjL1JSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDM4Lq1B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722419638; x=1753955638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rxk/NxfRpx/PeHLsJi8F8nFmIB84b5MwuGyDY06PgZA=;
  b=UDM4Lq1BEEZCMkeQAyDGc4HMqm3GGMIAho2/O1z4I3z9zdeEqeMZVNBL
   mWAPZKLTQXAV1pDtxZ9epeDCykNk/vPeLc/7YDCOpd7VknmsexGj1G2zN
   EhWM286rJGEXB0sqdt3nArQkloRx9OxFmNBOrJm274UzeA6IV086MjUbQ
   8gZQXNbRe6WejC9T8JYksE3vRGARS+zlw3Zi1VcpYbSGQOZYjV6lMcRgc
   2YC/lqyAlIKZfjLalLiDOxyendHIroPt5m7XqYx1Ql1NUFqUNn58nnRWz
   4ZqTEUY6Ke9t96CDZoJfh6vgFUQcY+RLggaafPmcoW0/4iYUMO4jD/2Gq
   Q==;
X-CSE-ConnectionGUID: /Yi36YB0T/WLN/DQ4QDUPg==
X-CSE-MsgGUID: rWpS14ZsSVGgJXOK3VZnRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="19877403"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="19877403"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:53:58 -0700
X-CSE-ConnectionGUID: 0A0JBsiORSGq898kpxIyrQ==
X-CSE-MsgGUID: nOCvqoHmSPu+omZr+Psh6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59482087"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:53:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] ACPI: battery: Remove redundant NULL initalizations
Date: Wed, 31 Jul 2024 12:53:45 +0300
Message-Id: <20240731095345.2878-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A local 'battery' variable is initialized to NULL on two occassions
where it is unconditionally rewritten later. Remove the unnecessary
initializations.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/acpi/battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index da3a879d638a..06e84d21ba3b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1207,7 +1207,7 @@ static int acpi_battery_update_retry(struct acpi_battery *battery)
 static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
-	struct acpi_battery *battery = NULL;
+	struct acpi_battery *battery;
 
 	if (!device)
 		return -EINVAL;
@@ -1260,7 +1260,7 @@ static int acpi_battery_add(struct acpi_device *device)
 
 static void acpi_battery_remove(struct acpi_device *device)
 {
-	struct acpi_battery *battery = NULL;
+	struct acpi_battery *battery;
 
 	if (!device || !acpi_driver_data(device))
 		return;
-- 
2.39.2


