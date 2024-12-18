Return-Path: <linux-acpi+bounces-10178-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273209F6139
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2024 10:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907077A16E9
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2024 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415D15B13D;
	Wed, 18 Dec 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDrp9O5U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8503595C
	for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513391; cv=none; b=l6d8EPvXh6Omzwt5zDYVpJVpGnBfKfGmwcZ1Mw1+lSTNqEEhHiKRS06CzTUc9qnrNklYJ3tZQYZkWfDn2Xs9SyAz0PKmFvsABXnq2HYQlvuYH5+3bi7WUxP8dk0t1xUteqfZ76Jy0Q0GlX38O4+Zqo2/CNClnHs4Jxi8BfagY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513391; c=relaxed/simple;
	bh=GozWxWdcAlfYLe4DPgdoKBOYCDrO/+VsHPsjipGChRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l4/tk5s8klnuzK6LaopZaCvaj1glr7dFfIr0WrvvSUdvmvaBTa0+0jaS/S33IfRmSS1wbZP7swnbP7WMPSDzcmctu7uCkV6Zjksmx64KDC7pldecUUkpg7nrMKtDaULqdCHPs9lzPIml6YsaHDSsk5pGojMMfgjzrW8B8+3Qpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDrp9O5U; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734513390; x=1766049390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GozWxWdcAlfYLe4DPgdoKBOYCDrO/+VsHPsjipGChRI=;
  b=hDrp9O5Ue/D9869d7j98aDw2qG52VbpM1gE2zsRcy7YhspDsmUaUVKgR
   HNsS9MKAlWGFwwfeMyALH8uKzIN5lxaT02tUql8I4Slqdsd6um+Unv1Fm
   GkLQoWVJFEQbd+mO6ktzU8A4L+Ml068OoVL2fE7dvZgRq02rRwzQREMmV
   RsOWcJBa60WPa5KJ4AXVQUCi5MOiZ5frZmI6V8SKRgJl7VwkWSjg/NP7M
   cDil0HUFWYUELyLe1VQCuxesS2OhaQH5cYqj+X/ZAQgSe2+DA6mLa/6jO
   pfIrHVzqUsx9MF/caG20tR6FG7aUeRzMyYJdbZcipL7qpCrLwyEMjMJAQ
   g==;
X-CSE-ConnectionGUID: klM9057KS32vUvfyJ4x4Ig==
X-CSE-MsgGUID: co9SQ7mWSw2jsYyss7QDxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="46392263"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="46392263"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:16:29 -0800
X-CSE-ConnectionGUID: f1KHUg8KSi2moY5lCMa1QA==
X-CSE-MsgGUID: +wJqZY1jRuiwC/Af2mApuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="97862072"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:16:28 -0800
Received: from svinhufvud.intel.com (maa-artisokka.localdomain [192.168.240.50])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8ACBC11F775;
	Wed, 18 Dec 2024 11:16:23 +0200 (EET)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	andriy.shevchenko@linux.intel.com
Subject: [PATCH 1/1] ACPI: property: Consider data nodes as being available
Date: Wed, 18 Dec 2024 11:16:22 +0200
Message-Id: <20241218091622.914266-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Years after fwnode_device_is_available() was introduced, new functions
making use of the function on data nodes have been added, such as
fwnode_for_each_available_child_node(), it becomes apparent that returning
"false" for all child nodes on ACPI wasn't a workable option.

On DT side most access functions, even those without "_available" part,
did only operate on available nodes. That wasn't the case on ACPI where
only device node availability is known explicitly.

Thus from now on, return true from fwnode_device_is_available() on all
ACPI data nodes.

Fixes: 2294b3af05e9 ("device property: Introduce fwnode_device_is_available()")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 80a52a4e66dd..1ee81e771ae6 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1492,7 +1492,7 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *__fwnode)
 static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	if (!is_acpi_device_node(fwnode))
-		return false;
+		return true;
 
 	return acpi_device_is_present(to_acpi_device_node(fwnode));
 }

base-commit: 7fa366f1b6e376c38966faa42da7f0f2e013fdab
-- 
2.39.5


