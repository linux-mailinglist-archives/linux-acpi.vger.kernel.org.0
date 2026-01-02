Return-Path: <linux-acpi+bounces-19930-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A1CEE6F0
	for <lists+linux-acpi@lfdr.de>; Fri, 02 Jan 2026 12:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B493026AF5
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jan 2026 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D254430E838;
	Fri,  2 Jan 2026 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwXdzNeW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF12DC359;
	Fri,  2 Jan 2026 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767354858; cv=none; b=qVd6dhzQrhPENJqofaE4MyU7wLDALHUsoVbf5r2t9yHl+BILlL7SfTjPyCyJX4v6QjCi8doTSdcBl8IkRjrlfZaonE4jBXLIqTX4nTtLIVS5PjZXUJ2sGViQvNwS98qKmYFuaMjN/+CG/qtee45xYXQnYpkfigB3jPXh3GaYMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767354858; c=relaxed/simple;
	bh=mDdxG7/zwRmmh4mhj3Dckgv4R3kXHJAMB++qcEY5aMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncagHKH7zLazVz39hT6hhtXZrk400hMMsk3ajjUeDXsCBe2/6VBKphsrE4O1rCwOBXIamhSaWF24wYeCNq5ax2wzbIqKmibPwssTZx5BCT9IPOwxGHZb2UUm2Q5pz0FrbUck2iblwWwUnoUKVrnmd1gJ8rjnCT5udzcHEsJJlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwXdzNeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCE5C116B1;
	Fri,  2 Jan 2026 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767354858;
	bh=mDdxG7/zwRmmh4mhj3Dckgv4R3kXHJAMB++qcEY5aMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwXdzNeWK8goqoJjOrzbMuopSpyZun9PT2t8OaLaHbF7uFX+re0koBrKI4CBEvp49
	 6AJD5R4aDntOGdrVjslc2EQ10Y3m1aXDcDDEO+SjTOy4uW+DTorkGAAgf4jotVxK1B
	 eb9p2jXSnQS/wJVaHuULZpOkZsvImUsNbV8j/SFx3ghZKzj/BF18x3r3OpmhyHY3Bk
	 QLxIqowbmoW3GHQyJkBXpbTtsHCEeSB+shJODh0qja3pK2DYPUEEcLAZ+N+vLHg4tP
	 G9cMGLV8OFrpDACLno/P8HLlauxGLZQ1ht+/3g2JKHn/OUYdoLAQsWFj0HMYndpBMa
	 ax+5SaO04ETnA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Hans de Goede <hansg@kernel.org>
Subject:
 [RESEND][PATCH v1 1/3] ACPI: scan: Register platform devices for backlight
 device objects
Date: Fri, 02 Jan 2026 12:50:57 +0100
Message-ID: <5081593.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12824456.O9o76ZdvQC@rafael.j.wysocki>
References: <12824456.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

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
 drivers/acpi/acpi_platform.c | 4 ++--
 drivers/acpi/bus.c           | 3 +++
 drivers/acpi/scan.c          | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 52c8d602f3a5..377ca8324121 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -118,7 +118,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	int count = 0;
 
 	/* If the ACPI node already has a physical device attached, skip it. */
-	if (adev->physical_node_count)
+	if (adev->physical_node_count && !adev->pnp.type.backlight)
 		return NULL;
 
 	match = acpi_match_acpi_device(forbidden_id_list, adev);
@@ -135,7 +135,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 		}
 	}
 
-	if (adev->device_type == ACPI_BUS_TYPE_DEVICE) {
+	if (adev->device_type == ACPI_BUS_TYPE_DEVICE && !adev->pnp.type.backlight) {
 		struct list_head resource_list = LIST_HEAD_INIT(resource_list);
 
 		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a984ccd4a2a0..574e190f6bf9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -761,6 +761,9 @@ const struct acpi_device *acpi_companion_match(const struct device *dev)
 	if (list_empty(&adev->pnp.ids))
 		return NULL;
 
+	if (adev->pnp.type.backlight)
+		return adev;
+
 	return acpi_primary_dev_companion(adev, dev);
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d0479ac40856..360d82378e56 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2350,7 +2350,8 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	if (ret < 0)
 		return 0;
 
-	if (device->pnp.type.platform_id || device->flags.enumeration_by_parent)
+	if (device->pnp.type.platform_id || device->pnp.type.backlight ||
+	    device->flags.enumeration_by_parent)
 		acpi_default_enumeration(device);
 	else
 		acpi_device_set_enumerated(device);
-- 
2.51.0





