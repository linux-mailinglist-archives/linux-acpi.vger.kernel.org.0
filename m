Return-Path: <linux-acpi+bounces-16178-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8500B3B9F0
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 13:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15B156070A
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC1313543;
	Fri, 29 Aug 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZP/bcX3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA032D1F6B
	for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466866; cv=none; b=JAm0OwR1oRzNv281xHA4sDFNZh1gtpFJ0ZFSCBFcii1yfuCFc0tU6YSxQ6E4kOaKGwkZpEWIzWcaBlNRFMtds7jdUUSSNvaw2KcTiVp0nuCBelbyBN7xkOfQIeA5jO7cLb5NbAAB6D1vcYgnqvbKadHBWn/pLKqCJnIhsjWtF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466866; c=relaxed/simple;
	bh=+XfPi2dIdUZ1nEnfY5p/xylwOMA4uWJDsK9FWyew83k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjgXArBjbfchNHCSfRVhDxAgjChpaPxyntURMYqJluKgKBLBN4ZO+9VkTvWM3OpaC9mprFxOdDyjwejpRLbRYY+2joIwLc7lErj45lTwhO483PgxMtQynldjQY/soINwg7AWAI4nKgdGaW6LDoMW1kU2CURHS/fN0Bh7lUs/NIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZP/bcX3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756466864; x=1788002864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+XfPi2dIdUZ1nEnfY5p/xylwOMA4uWJDsK9FWyew83k=;
  b=nZP/bcX3VRlGET7gJLsybJiLr1/CpO+YL0cjgY3lb2g+lsYxWxII6a8J
   VlQF2S0XmC3qwS3Dot3Vi0++RFoRf7wgN29OtLeke2rgiKlUWscBKAnN5
   unnmxENBNGVHPWwtdwklKbhLrhgY4BD1PMP/LCJmzqSWXacIZDClGf8qB
   ipyzDdnpW/cFJWKE1AHR+lQ4yxzV/QXjhvpIyfe36oOhKS9ybEymIsted
   WO2EGPF//Kdvarj1+tdv7d9PoZNbR9s1mGhrJm8Pkv/Sh2D2wT/D0RGo9
   sg+ZFgpz1CQ9+AIJMKGTntsTMDf2YCkuDt3UGCgYFrWFhMpXkGKP1EuId
   w==;
X-CSE-ConnectionGUID: 5S+ikHtiRaOmdCO5ow49fg==
X-CSE-MsgGUID: ArKoeSveQ6OOCW134V9bLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76203647"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="76203647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 04:27:43 -0700
X-CSE-ConnectionGUID: jMCZSBS2Tb+BKlZUAjksHQ==
X-CSE-MsgGUID: BQOqEWljRDeD8RzCEU2zPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="201271933"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 Aug 2025 04:27:41 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	saket.dumbre@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] ACPICA: acpidump: fix return values in ap_is_valid_checksum()
Date: Fri, 29 Aug 2025 16:56:14 +0530
Message-Id: <20250829112614.1872244-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ap_is_valid_checksum() has a boolean name suggesting it
should return TRUE/FALSE, but incorrectly returns AE_OK on success and
has no explicit return on failure, leading to undefined behavior.

Fix by returning proper values:
- FALSE when checksum validation fails
- TRUE when checksum validation succeeds

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/acpi/tools/acpidump/apdump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index bf30143efbdc..7a6223aa703c 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -86,9 +86,10 @@ u8 ap_is_valid_checksum(struct acpi_table_header *table)
 	if (ACPI_FAILURE(status)) {
 		fprintf(stderr, "%4.4s: Warning: wrong checksum in table\n",
 			table->signature);
+		return (FALSE);
 	}
 
-	return (AE_OK);
+	return (TRUE);
 }
 
 /******************************************************************************
-- 
2.34.1


