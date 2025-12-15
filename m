Return-Path: <linux-acpi+bounces-19585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46704CBEC22
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD0EF301BCEA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910A4337BA6;
	Mon, 15 Dec 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAI+aGMp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655613375C2;
	Mon, 15 Dec 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807472; cv=none; b=tL3TSPv+ao8ZjPjTwZLr1qBRGM3jpMOnlH136Rad46/hC+zlcJBKzdeZH/DFakJRYHIz4FYhI1tAqDZByfTJqQBlujS7YbArwqhiB9Wgn0GKiiGl8vpG+kBBSeUYodUW+/Lauya7bWvdFGrfdFhxMFlkUsL/B7UlMyi/YpVcgek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807472; c=relaxed/simple;
	bh=kkjhdf7EQKF50gO4BFSY1K8cph+W3kWYhNyG08AR8mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXduKhysviHVpIxavZR1Y5MbSrXifYLjLrHYBjMUPyUByeEF8IZOJ7iCddOXTICzFaK7l5haWaHM81ba+zZHxtJzI02riFLBDFYxGHB2+Ot2+DH62IBV0DrTtrAKkrUHNylzwJeAegWcmOKcXjWa9bSRee39SJ1BGUs9mvPRna0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAI+aGMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECA3C4AF09;
	Mon, 15 Dec 2025 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807472;
	bh=kkjhdf7EQKF50gO4BFSY1K8cph+W3kWYhNyG08AR8mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAI+aGMpEJCoJjvEcFDYv4y71pLFEJIKLXOXMhscy1c6NhluZcX3tD7z43HrWSi7Y
	 /DMKXBqyJpvbUkK3yb2+ibPKyeil+GIVZZ6QVp29dpnlfNuOcEOKxwuffxKS22OM17
	 dDsyIDx2B4pyPKsWMVcUXse/gxXE4ANYxWIMh9vtTWSfXUhjVL3xx4ShQAw2JQG/LR
	 aOrZSCPGKaYdwLrMZ/x0xsgRI1hSha3me6i979Hz8M+4+FD2XrL2Tzs1fraITswuBY
	 OnkCIAvK8hG16FDCynS4qMb176vdhdnValiuhsRvDgWv3Kt3DwdOmZNVBpOuFhxytq
	 Qf1vnwMIl6zuw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 01/10] ACPI: scan: Register platform devices for fixed event
 buttons
Date: Mon, 15 Dec 2025 14:52:45 +0100
Message-ID: <3731144.R56niFO833@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2685338.Lt9SDvczpP@rafael.j.wysocki>
References: <2685338.Lt9SDvczpP@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On platforms using ACPI, power and sleep buttons may be so called "fixed
event devices" in which case they are hooked up directly to the Fixed
Events register in the platform via dedicated lines and there are no
corresponding device objects in the ACPI namespace.  Nevertheless, in
Linux they get corresponding struct acpi_device objects with special
device IDs, either LNXPWRBN or LNXSLPBN, which are then used for driver
binding in a ususal way.

However, the function creating those struct acpi_device objects for
"fixed event device" buttons, acpi_bus_scan_fixed(), does not register
platform devices for them, unlike the generic code handling device
enumeration based on the ACPI namespace.  Consequently, if an ACPI power
or sleep button is represented by a device object in the ACPI namespace,
it will get a corresponding platform device, but if it is a "fixed event
device", it will not get one, which is inconsistent and prevents the
ACPI power button driver from being converted into a platform driver.

For the sake of consistency and to allow the ACPI power button driver to
become a platform one going forward, modify acpi_bus_scan_fixed() to
register platform devices for "fixed event device" buttons and update
ACPI platform device registration code to work with non-device ACPI
object types, so it can handle the buttons in question.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rearrange acpi_create_platform_device() for cleanliness.

---
 drivers/acpi/acpi_platform.c |   38 +++++++++++++++++++++-----------------
 drivers/acpi/scan.c          |    4 ++++
 2 files changed, 25 insertions(+), 17 deletions(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -114,10 +114,8 @@ struct platform_device *acpi_create_plat
 	struct platform_device *pdev = NULL;
 	struct platform_device_info pdevinfo;
 	const struct acpi_device_id *match;
-	struct resource_entry *rentry;
-	struct list_head resource_list;
 	struct resource *resources = NULL;
-	int count;
+	int count = 0;
 
 	/* If the ACPI node already has a physical device attached, skip it. */
 	if (adev->physical_node_count)
@@ -137,22 +135,28 @@ struct platform_device *acpi_create_plat
 		}
 	}
 
-	INIT_LIST_HEAD(&resource_list);
-	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
-	if (count < 0)
-		return NULL;
-	if (count > 0) {
-		resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
-		if (!resources) {
+	if (adev->device_type == ACPI_BUS_TYPE_DEVICE) {
+		struct list_head resource_list = LIST_HEAD_INIT(resource_list);
+
+		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+		if (count < 0)
+			return ERR_PTR(-ENODATA);
+
+		if (count > 0) {
+			struct resource_entry *rentry;
+
+			resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
+			if (!resources) {
+				acpi_dev_free_resource_list(&resource_list);
+				return ERR_PTR(-ENOMEM);
+			}
+			count = 0;
+			list_for_each_entry(rentry, &resource_list, node)
+				acpi_platform_fill_resource(adev, rentry->res,
+							    &resources[count++]);
+
 			acpi_dev_free_resource_list(&resource_list);
-			return ERR_PTR(-ENOMEM);
 		}
-		count = 0;
-		list_for_each_entry(rentry, &resource_list, node)
-			acpi_platform_fill_resource(adev, rentry->res,
-						    &resources[count++]);
-
-		acpi_dev_free_resource_list(&resource_list);
 	}
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2767,6 +2767,8 @@ static void acpi_bus_scan_fixed(void)
 				device_init_wakeup(&adev->dev, true);
 			else
 				dev_dbg(&adev->dev, "No driver\n");
+
+			acpi_default_enumeration(adev);
 		}
 	}
 
@@ -2779,6 +2781,8 @@ static void acpi_bus_scan_fixed(void)
 			adev->flags.match_driver = true;
 			if (device_attach(&adev->dev) < 0)
 				dev_dbg(&adev->dev, "No driver\n");
+
+			acpi_default_enumeration(adev);
 		}
 	}
 }




