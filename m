Return-Path: <linux-acpi+bounces-5264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF8F8AD3B3
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536661F21687
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5B7154424;
	Mon, 22 Apr 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3kCcO40"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA01153BC6
	for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713809630; cv=none; b=BmRp51DEwbsOLEz9XN65x3JijgxzZ4LQzC8msdectRbPJcaZl06C4edyRRH/Hktb7DY+5+5n6NcZrDxqG0minJkQuMBDLOfGPoopM8p/YhNFS2yxI8rMzYx6EoMtFmVVMGMu6jgyITbb8ME9f+EeKFx1iY7ugcN7/AWpSFhYi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713809630; c=relaxed/simple;
	bh=9t6GOlBjlEuT8oqPe50Lt0xgv9GpXuMIJcN0b+IFMOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AgGtAhbxCGmfYgy91lhCcYtOK5bSAhpiRJG/ophpeijTjayFdcLqqikrhseMF8q7nEJDb5ebXvm7QljwHJLO7+YRG7PQwgGVM6zbxhVulzmGi70pzxAqbO/sLWwtpKB6wwXoSqlJfpVo38Usd7nhUbNMYr4VqOUemEnylm51jdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3kCcO40; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713809630; x=1745345630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9t6GOlBjlEuT8oqPe50Lt0xgv9GpXuMIJcN0b+IFMOg=;
  b=L3kCcO4097A6s03OCdlw4V0XKcDzZsNUu2x6zCKLKzrRSoDvXwq7G+K0
   Voppvud1Se/ZI2rRc6CHoKFLKFt5qOQ05vot0TqeQL7LHixp6C7EA8Dp1
   gD8ERp5J42MU1rPYlTANsrQCh7N6pXsqrySbf4dQ1A/0f56b9OGDTuLkx
   YMABvTYrm7pkW15M7JsnnkItWxOZphzVvxeiOf8aC/gGjY4zXvVYiisVk
   kDuDN6wDG78bCTPXamtZCF4yto9q9GQ1tCuaEyogbJYt1nSNpdlGlvyhl
   oyfjSyXSu/ATc5W7T9wmGoVLv/z9SscPD9JaYFlWsUPWoLEWl+ggbphJO
   A==;
X-CSE-ConnectionGUID: CvS8CiEmRYOiYMr4iW+w8A==
X-CSE-MsgGUID: stwCG3EURAGTSy41pM+kHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9280676"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9280676"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 11:13:49 -0700
X-CSE-ConnectionGUID: odFGWbPpQAaTtrzIhGcYwQ==
X-CSE-MsgGUID: K0EeJLoARTea/OFXt1MrmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28884192"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 11:13:46 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id CBAB4120480;
	Mon, 22 Apr 2024 21:13:42 +0300 (EEST)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	mika.westerberg@intel.com,
	"Liao, Bard" <bard.liao@intel.com>,
	"Ujfalusi, Peter" <peter.ujfalusi@intel.com>
Subject: [PATCH 1/1] ACPI: property: Add reference to UEFI DSD Guide
Date: Mon, 22 Apr 2024 21:13:42 +0300
Message-Id: <20240422181342.810350-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UEFI DSD Guide specifies a number of GUIDs supported by the _DSD
parser. Point to the DSD Guide in the documentation.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 2b73580c9f36..80a52a4e66dd 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -31,9 +31,14 @@ static int acpi_data_get_property_array(const struct acpi_device_data *data,
  * not defined without a warning. For instance if any of the properties
  * from different GUID appear in a property list of another, it will be
  * accepted by the kernel. Firmware validation tools should catch these.
+ *
+ * References:
+ *
+ * [1] UEFI DSD Guide.
+ *     https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc
  */
 static const guid_t prp_guids[] = {
-	/* ACPI _DSD device properties GUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
+	/* ACPI _DSD device properties GUID [1]: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
 	GUID_INIT(0xdaffd814, 0x6eba, 0x4d8c,
 		  0x8a, 0x91, 0xbc, 0x9b, 0xbf, 0x4a, 0xa3, 0x01),
 	/* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
@@ -53,12 +58,12 @@ static const guid_t prp_guids[] = {
 		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
 };
 
-/* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
+/* ACPI _DSD data subnodes GUID [1]: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
 static const guid_t ads_guid =
 	GUID_INIT(0xdbb8e3e6, 0x5886, 0x4ba6,
 		  0x87, 0x95, 0x13, 0x19, 0xf5, 0x2a, 0x96, 0x6b);
 
-/* ACPI _DSD data buffer GUID: edb12dd0-363d-4085-a3d2-49522ca160c4 */
+/* ACPI _DSD data buffer GUID [1]: edb12dd0-363d-4085-a3d2-49522ca160c4 */
 static const guid_t buffer_prop_guid =
 	GUID_INIT(0xedb12dd0, 0x363d, 0x4085,
 		  0xa3, 0xd2, 0x49, 0x52, 0x2c, 0xa1, 0x60, 0xc4);
-- 
2.39.2


