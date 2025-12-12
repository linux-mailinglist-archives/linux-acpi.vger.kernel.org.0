Return-Path: <linux-acpi+bounces-19561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9182CCB9D26
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Dec 2025 21:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FBE630715EF
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Dec 2025 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF63101A2;
	Fri, 12 Dec 2025 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmPcsOMs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF330FC37;
	Fri, 12 Dec 2025 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572768; cv=none; b=rOiA6+zKwPRl8FfBx3OcvfDL/69KuObkK8FvOX70fVlCdVgvnOH6wxTLowNgQtQNXOvfEdZ6SXvgEIughwGNYWzw7yyLVqHlwkkMdm2hYj4fBGAq4L6Ctiu8ndeMqWMTSMubVLIJ8vVo9R1f0iXxULvRe/Y44znIgI9ytZdzfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572768; c=relaxed/simple;
	bh=vqSsXppT5+TIL5Yyc20A11uIQ7pfiju2vkocraiM7Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZoDlLNUSisP7/Pu0kkrmkQnoWGBBdFJM2z7e0Wlc7QwSjdYA2BxWtDW8K7U/FihbX+ni7yPhnQ5+BWRPEGhhHPL7us7SzC+sxJfQEQ7Oln03tBwVxMGJKZ59N+eaUiei6xOnj6N5lxp1edpFYK3+49+NAO7JwceQhBCDsVOtKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmPcsOMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B02C4CEF1;
	Fri, 12 Dec 2025 20:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765572767;
	bh=vqSsXppT5+TIL5Yyc20A11uIQ7pfiju2vkocraiM7Ko=;
	h=From:To:Cc:Subject:Date:From;
	b=jmPcsOMs+lvaD4xIdZEPOCpQNYONoSCrstP3qiV0CGW7pgkHAJ2ZBA8QOMyyAa6Yk
	 gIBn39dLFLvJn0rx7xiFWIXXNqEJYODDr2aSskZY+WIDGiXKsl2yDJ2luSHukaXRwX
	 N0TAwdggfqu5/d935RvGnUyLOOLHmwiv3XvQVpza4INgGOxRKQFiSOXW6Qqb9V/NXQ
	 5oPs5fqj3/lDvF/2wLOm0Ikpnv5o0rxK4camB6y5uo1/f6dxdoAb4FlA3ANB6WepRw
	 1ZQ8zp7qYF43NO5VAWyGOmcEdqibxlMehLi15u/SuXTXJyHlY4Ixmd6i++8yWp3Ihn
	 889OOG1tPEBxA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1] ACPI: sysfs: Add device cid attribute for exposing _CID lists
Date: Fri, 12 Dec 2025 21:52:44 +0100
Message-ID: <2812426.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new sysfs attribute called "cid" under struct acpi_device for
exposing the list of compatible device IDs returned by the device's
_CID object, if present.

The new attribute will be present only if the _CID object is present.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_sysfs.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -403,6 +403,33 @@ hid_show(struct device *dev, struct devi
 }
 static DEVICE_ATTR_RO(hid);
 
+static ssize_t cid_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_device_info *info = NULL;
+	ssize_t len = 0;
+
+	acpi_get_object_info(acpi_dev->handle, &info);
+	if (!info)
+		return 0;
+
+	if (info->valid & ACPI_VALID_CID) {
+		struct acpi_pnp_device_id_list *cid_list = &info->compatible_id_list;
+		int i;
+
+		for (i = 0; i < cid_list->count - 1; i++)
+			len += sysfs_emit(buf, "%s,", cid_list->ids[i].string);
+
+		len += sysfs_emit(buf, "%s\n", cid_list->ids[i].string);
+	}
+
+	kfree(info);
+
+	return len;
+}
+static DEVICE_ATTR_RO(cid);
+
 static ssize_t uid_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -520,6 +547,7 @@ static DEVICE_ATTR_RO(status);
 static struct attribute *acpi_attrs[] = {
 	&dev_attr_path.attr,
 	&dev_attr_hid.attr,
+	&dev_attr_cid.attr,
 	&dev_attr_modalias.attr,
 	&dev_attr_description.attr,
 	&dev_attr_adr.attr,
@@ -562,6 +590,9 @@ static bool acpi_show_attr(struct acpi_d
 	if (attr == &dev_attr_status)
 		return acpi_has_method(dev->handle, "_STA");
 
+	if (attr == &dev_attr_cid)
+		return acpi_has_method(dev->handle, "_CID");
+
 	/*
 	 * If device has _EJ0, 'eject' file is created that is used to trigger
 	 * hot-removal function from userland.




