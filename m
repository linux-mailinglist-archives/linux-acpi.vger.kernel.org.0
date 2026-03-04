Return-Path: <linux-acpi+bounces-21347-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMsADgB/qGmYvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21347-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:50:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E08206A4F
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3342030432DB
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF6F3D668C;
	Wed,  4 Mar 2026 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnFJS7Qk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC03D75D6;
	Wed,  4 Mar 2026 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649988; cv=none; b=oInynQqFkaUgNk6KzRiZoTh6M1kFFK86HtOq/RigoOkgyjH4hlxihoSqIZAwSIwJYii9Ukk4rP+RLRTAlLuVgQX6iYK8udY+3I94v4z0+K5WA+60DVEiS0ss8r12OanwloMJ1rqBh9/F898YU5GWak5xAB4SUPN6s/pngPP1xOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649988; c=relaxed/simple;
	bh=YGG8+AxtNsMQqvO5KwS+v5uC9yN0OxHX/Xl+KOQeLsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaY3raahi6bagp5ySeM58VjrhiKw4Xxf/y0pHsRiypa1MiV93ZTYP0JP039NV/q2KojxnANNf6Ps+Iqf7EXq4eRqRFe6T2+iOEWA993+kSElR3lnwH2UaqyLqImEqjYAFm/822tVstLrUfYN2yvj54X5LWq3ApIc2NzfSPsw+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnFJS7Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3E1C4CEF7;
	Wed,  4 Mar 2026 18:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649987;
	bh=YGG8+AxtNsMQqvO5KwS+v5uC9yN0OxHX/Xl+KOQeLsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnFJS7Qk3CEXhfcuk2THOZEokRIH6JivC2u2xnRgSWe9ddC7SxPlU0ZGpEozuEEe2
	 N1k2Hnc4YXUbmanPNdJBhakmyGzRTe6Fjzrj0hNL+GCW+uMTAWZ0e3lSQG6DZ4Y5ua
	 Mpcz5dkU0y1m2Chhj6mExpY46lDriiY+nVQbi63t4cWXX7t4+uVgw8cpV3xbAP+DHp
	 zcA9c2UfXqXjzsBhTgS4VHAVKyJnewhQjSCATKgwG9c0FVHj2n6hP0uFjEVqmMQtKY
	 F/U1SeDkHYZ3ZeVohE8r5QmvxA21/U+0Lo7Cv0w9AvQd4EES/yiP2ablg+eqQrasIu
	 fbmB91OX/jIrA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: chrome-platform@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v1 5/6] platform/chrome: wilco_ec: event: Register ACPI notify handler
Date: Wed, 04 Mar 2026 19:45:12 +0100
Message-ID: <886338398.0ifERbkFSE@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A4E08206A4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21347-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/chrome/wilco_ec/event.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 743cd4839bff..f4500dd05f93 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -253,14 +253,16 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
 
 /**
  * event_device_notify() - Callback when EC generates an event over ACPI.
- * @adev: The device that the event is coming from.
+ * @handle: ACPI handle of the device that the event is coming from.
  * @value: Value passed to Notify() in ACPI.
+ * @data: Notify handler data.
  *
  * This function will read the events from the device and enqueue them.
  */
-static void event_device_notify(struct acpi_device *adev, u32 value)
+static void event_device_notify(acpi_handle handle, u32 value, void *data)
 {
 	struct acpi_buffer event_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = data;
 	union acpi_object *obj;
 	acpi_status status;
 
@@ -489,8 +491,16 @@ static int event_device_add(struct acpi_device *adev)
 	if (error)
 		goto free_dev_data;
 
+	/* Install an ACPI notify handler. */
+	error = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+						event_device_notify, adev);
+	if (error)
+		goto free_cdev;
+
 	return 0;
 
+free_cdev:
+	cdev_device_del(&dev_data->cdev, &dev_data->dev);
 free_dev_data:
 	hangup_device(dev_data);
 free_minor:
@@ -502,6 +512,8 @@ static void event_device_remove(struct acpi_device *adev)
 {
 	struct event_device_data *dev_data = adev->driver_data;
 
+	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+				       event_device_notify);
 	cdev_device_del(&dev_data->cdev, &dev_data->dev);
 	ida_free(&event_ida, MINOR(dev_data->dev.devt));
 	hangup_device(dev_data);
@@ -519,7 +531,6 @@ static struct acpi_driver event_driver = {
 	.ids = event_acpi_ids,
 	.ops = {
 		.add = event_device_add,
-		.notify = event_device_notify,
 		.remove = event_device_remove,
 	},
 };
-- 
2.51.0





