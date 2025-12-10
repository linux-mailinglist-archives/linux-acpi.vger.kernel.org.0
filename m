Return-Path: <linux-acpi+bounces-19541-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BEFCB338C
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AE9E312FF2D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DFB23EAB7;
	Wed, 10 Dec 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mel6ryE6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E1182D2;
	Wed, 10 Dec 2025 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378310; cv=none; b=VreU+IupALBMi6HyX6Mh0QAId7ijsbRNlFkVUWmG5DBHT9Xx3Sq7z2WrHjxCK2LqiYzp1Cls2Ny+TAbBeeP/KKTUkVxkXR1eWPoI8cmU56kCIlQ7veUwGilfUpsOH2f+OjDxSwQKm2XOXWIRhpk4Jc9ZOmlnkmO2bLYMg6Bf6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378310; c=relaxed/simple;
	bh=SYv0H0lZoj3lrl3sdPTiWtjC5eWPebsA8f4rqhvvT2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoVhJ8DGQaq9/C21wZ/lmvdjr3hlw6YSZ2aW7uWN6vpj/CzVI4rfCz7yqgBYLQJdRAYCY0DNGT5qkWw+38RXaU6KZ4JXbXEppu8kGfJZN2qgNfkIigG+csb1yCX8zpIQLs4SiR1SE9iAW+l8Y/PKSLrd8fz2+Cjaw9bwpc1guj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mel6ryE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E54CC19421;
	Wed, 10 Dec 2025 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765378309;
	bh=SYv0H0lZoj3lrl3sdPTiWtjC5eWPebsA8f4rqhvvT2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mel6ryE6jGiUjZhdo1SnymOKGroh9Hm83asqFbuzJ/X7iDoBiUCrQTY3kxF+R3Eql
	 Ga2b6o57bR4Or4GOFE+YS8ud1QlMWAnZHaB5Vr9DXJ08mG6bfY9bnNUHvydr+UL2wu
	 IjLWXi915RQO4WinWgbPOVoDnAZK2F9omAv9KJfMTx3oC9SgN83KI6t3wm7E5EmoWm
	 KlvzEaUGsNcEyZKM2XKP844mjKghHw03hMpJ15JmQkgqN6pm+02cbaLh1QH3WhY1m1
	 H8rZfUnMkuv/+xt5iL1oNDWD+3gdQXZeAjl6mkCl/FdphWIXe7RAC8IXOY/RPHR10l
	 z4w5p/AVSYe+w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 1/3] ACPI: scan: Register platform devices for backlight device
 objects
Date: Wed, 10 Dec 2025 15:48:29 +0100
Message-ID: <2335304.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <8617910.T7Z3S40VBb@rafael.j.wysocki>
References: <8617910.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPI device objects associated with backlight interfaces are special
because they are ACPI companions of PCI devices (GPUs), but the
interfaces exposed by them resemble platform device one.

Currently, the ACPI video driver binds to them with the help of a
special "synthetic" device ID regardless of the pairing with the PCI
devices, but since it is generally better to use platform drivers for
handling such interfaces, the plan is to convert that drviver into a
platform one.

However, for this purpose, platform devices corresponding to the
ACPI backlight device objects need to be registered, so update
acpi_bus_attach() to apply the default ACPI enumeration to them
and modify acpi_create_platform_device() to avoid bailing out early
if a "physical" device is already attached to a backlight ACPI device
object.

In addition, update acpi_companion_match() to return a valid struct
acpi_device pointer if the ACPI companion of the given device is a
backlight ACPI device object, which will facilitate driver matching
for platform devices corresponding to those objects.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_platform.c |    5 +++--
 drivers/acpi/bus.c           |    3 +++
 drivers/acpi/scan.c          |    3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -120,7 +120,7 @@ struct platform_device *acpi_create_plat
 	int count;
 
 	/* If the ACPI node already has a physical device attached, skip it. */
-	if (adev->physical_node_count)
+	if (adev->physical_node_count && !adev->pnp.type.backlight)
 		return NULL;
 
 	match = acpi_match_acpi_device(forbidden_id_list, adev);
@@ -138,7 +138,8 @@ struct platform_device *acpi_create_plat
 	}
 
 	INIT_LIST_HEAD(&resource_list);
-	if (adev->device_type == ACPI_BUS_TYPE_DEVICE) {
+	if (adev->device_type == ACPI_BUS_TYPE_DEVICE &&
+	    !adev->pnp.type.backlight) {
 		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
 		if (count < 0)
 			return NULL;
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -761,6 +761,9 @@ const struct acpi_device *acpi_companion
 	if (list_empty(&adev->pnp.ids))
 		return NULL;
 
+	if (adev->pnp.type.backlight)
+		return adev;
+
 	return acpi_primary_dev_companion(adev, dev);
 }
 
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2320,7 +2320,8 @@ static int acpi_bus_attach(struct acpi_d
 	if (ret < 0)
 		return 0;
 
-	if (device->pnp.type.platform_id || device->flags.enumeration_by_parent)
+	if (device->pnp.type.platform_id || device->pnp.type.backlight ||
+	    device->flags.enumeration_by_parent)
 		acpi_default_enumeration(device);
 	else
 		acpi_device_set_enumerated(device);




