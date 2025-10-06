Return-Path: <linux-acpi+bounces-17598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AF6BBD0A2
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 06:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 585D94E19C9
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 04:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6DF22D4C8;
	Mon,  6 Oct 2025 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mX+Tdvos"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C422ACEF
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759725223; cv=none; b=oTY3igCOUS5amJvg2SXCCkFjtEeiP1YLMRl8dvdJyS3QDpA+KMqxTPcrePApd1tWdxQxlRaNa1TJ4azT1Z62C9qkvv6wTmtblChhBJnOZA3KCnpQwlXuDfFiZjp7f3TXO0PVxUjwqSvZEbnVknFUeVnk5eq7GUIxifihAi7raZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759725223; c=relaxed/simple;
	bh=MMP+8lv62xXdVJat5l5wTnY7UwHWMR/Q+m93+FTOpKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u6YDXFEMgxTfEuGEcRCeb/i89FprlqST27zGpFwCJYzULD1qK566RzTRu43i+SSZTveOJqFuOcG/hxzGFx04/7Mb6c2v1VgsZXN90fbrX2fVV6CVrZU9+yvLKZKe159g0DiqcYY+a29Cantw9TnjOLmM0FGWNnH2SkxIo2lLe2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mX+Tdvos; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759725222; x=1791261222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MMP+8lv62xXdVJat5l5wTnY7UwHWMR/Q+m93+FTOpKE=;
  b=mX+TdvosZv8jbkdZMktV4prScMYxp1AAwjgVo+b68d7OkBtphRnMkLLk
   jNWXbaGt+bIzq2PvaChFnx9cyNqgf+pmLSfniNz266a7/wb+BRq82VzlO
   L37uygFJQpjqVQ7+QcgfEAi3QiL9DPqbi+IczE8ChwHjFWNZiWoW7I8GM
   zVJRmI2XRCi8DyEjjJCOpPe8esGJPAPAxZwKiD8OY7ZbtXZBp5LIwtV6s
   agc/VcR2BeaCs7L90XyKQuAL8MteQWKdVVgNB2LBmwlGfaMgFy3iRJVi7
   +kR0jhoNPe9zyK3JYDwf1+gNB1dnUDhXFrC8qWOK/AhExyhsbKT2W3dOk
   w==;
X-CSE-ConnectionGUID: hBJB4n+nT+6CqtlNN6J5Tg==
X-CSE-MsgGUID: Q6Rfx9hMTzyThvMqnyy5oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="72513404"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="72513404"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2025 21:33:41 -0700
X-CSE-ConnectionGUID: z6I/9O3hQ6CM87Kh/JmG0Q==
X-CSE-MsgGUID: uhjo5XIBRAWGCMo3xZwL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="178915854"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa006.jf.intel.com with ESMTP; 05 Oct 2025 21:33:39 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] ACPI / DPTF: Fix typo in current_discharge_capability_ma attribute name
Date: Mon,  6 Oct 2025 10:01:49 +0530
Message-Id: <20251006043149.967725-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo "capbility" to "capability" in current_discharge_capability_ma
sysfs attribute name across all references. This corrects the spelling
in the DPTF_POWER_SHOW macro, DEVICE_ATTR_RO declaration, and attribute
array entry for consistent naming.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/acpi/dptf/dptf_power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 776914f31b9e..a3b25d9065c2 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -48,7 +48,7 @@ DPTF_POWER_SHOW(rest_of_platform_power_mw, PROP)
 DPTF_POWER_SHOW(max_steady_state_power_mw, PBSS)
 DPTF_POWER_SHOW(high_freq_impedance_mohm, RBHF)
 DPTF_POWER_SHOW(no_load_voltage_mv, VBNL)
-DPTF_POWER_SHOW(current_discharge_capbility_ma, CMPP);
+DPTF_POWER_SHOW(current_discharge_capability_ma, CMPP);
 
 static DEVICE_ATTR_RO(max_platform_power_mw);
 static DEVICE_ATTR_RO(platform_power_source);
@@ -59,7 +59,7 @@ static DEVICE_ATTR_RO(rest_of_platform_power_mw);
 static DEVICE_ATTR_RO(max_steady_state_power_mw);
 static DEVICE_ATTR_RO(high_freq_impedance_mohm);
 static DEVICE_ATTR_RO(no_load_voltage_mv);
-static DEVICE_ATTR_RO(current_discharge_capbility_ma);
+static DEVICE_ATTR_RO(current_discharge_capability_ma);
 
 static ssize_t prochot_confirm_store(struct device *dev,
 				     struct device_attribute *attr,
@@ -102,7 +102,7 @@ static struct attribute *dptf_battery_attrs[] = {
 	&dev_attr_max_steady_state_power_mw.attr,
 	&dev_attr_high_freq_impedance_mohm.attr,
 	&dev_attr_no_load_voltage_mv.attr,
-	&dev_attr_current_discharge_capbility_ma.attr,
+	&dev_attr_current_discharge_capability_ma.attr,
 	NULL
 };
 
-- 
2.34.1


