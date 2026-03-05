Return-Path: <linux-acpi+bounces-21447-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJSXCrvnqWnuHQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21447-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:29:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83FA21826C
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37FB130439F2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9D33986F;
	Thu,  5 Mar 2026 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2/9/QOr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B03339856;
	Thu,  5 Mar 2026 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742563; cv=none; b=M9pYVgyVu+zjOSgIV6yiWpQtn41rxVumGtRDI7SWe2hcjjm+dhFVq93lvI1OpplIJSg3Gqj+aALhABoxv0KrMbSpJQa4/T+p0UfEYZVoOQO6muKcZAk9WBdCYVCRTNC5BK06JsC7GZ+emBD88Dg+AQw6mqZCXM8AI5sfykxtbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742563; c=relaxed/simple;
	bh=vJI7ioecKB+292u90uxL/TjFPXuKipET1011BWNkI/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXS7W1NR2CtblK58CvBIU3+oRRJG4+fhkNytP9qlBRY/v+xdOKN4gzWG8xtLuaHHg4CVssS6luO1yucZiTkzEzUuGkt/whSghEMZL9iGMu2GYEVXQNeagBYYtGIVXbYbgvkoK1gbSsjWWVw1I8KeQOx+i+n7beC8wU08yjCf8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2/9/QOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C69FC2BCB0;
	Thu,  5 Mar 2026 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742563;
	bh=vJI7ioecKB+292u90uxL/TjFPXuKipET1011BWNkI/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2/9/QOrufG3KuPgwN46SxTuBzhEC489DGVJCSF5P5sbmZe8yB5VFZby/Q4snHgSp
	 FUvKLv9KWW1qWedAlxAJP3EDICjupADNWPpqk3Gdg0b3+UunWOacG/e8g/I1Zac+Te
	 jBHng9wmKe/5SKOgPdcoBGNJF9xoKaxVjHF7cgPOixdpSg4Z8I/2LSRd76EwuCb20G
	 UXFcKdB+kdmqtBaEUX8cyVVKuHRWZaZ16j1mA2f/Gp7Vcthyj4VrSmz+A0OHaHorDe
	 aPRWuNEuI45OPHYijUdj3q8HXCXPzue8fq6Chq4LZxm/3TYnRlkPYCqaPN+eer5YM3
	 djJhMlfbLzLpw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 6/9] ACPI: event: Redefine acpi_notifier_call_chain()
Date: Thu, 05 Mar 2026 21:18:22 +0100
Message-ID: <2914546.BEx9A2HvPv@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4505861.ejJDZkT8p0@rafael.j.wysocki>
References: <4505861.ejJDZkT8p0@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A83FA21826C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21447-lists,linux-acpi=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rafael.j.wysocki:mid,intel.com:email]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Notice that acpi_notifier_call_chain() only uses its device argument
to retrieve the pnp.device_class and pnp.bus_id values from there, so
it can be redefined to take pointers to those two strings as parameters
istead of a struct acpi_device pointer.

That allows all of its callers to pass a string literal as its first
argument, so they won't need to initialize pnp.device_class in
struct acpi_device objects operated by them any more, and its
signature becomes more similar to acpi_bus_generate_netlink_event()
then.

Update the code as per the above.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c         | 3 ++-
 drivers/acpi/acpi_video.c | 9 ++++++---
 drivers/acpi/battery.c    | 3 ++-
 drivers/acpi/event.c      | 7 ++++---
 include/acpi/acpi_bus.h   | 3 ++-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 4985c8890609..2b500e89169f 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -133,7 +133,8 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 		acpi_bus_generate_netlink_event(adev->pnp.device_class,
 						  dev_name(&adev->dev), event,
 						  (u32) ac->state);
-		acpi_notifier_call_chain(adev, event, (u32) ac->state);
+		acpi_notifier_call_chain(ACPI_AC_CLASS, acpi_device_bid(adev),
+					 event, ac->state);
 		power_supply_changed(ac->charger);
 	}
 }
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 4fc2e52401a6..be53afcfb948 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1568,7 +1568,8 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 		break;
 	}
 
-	if (acpi_notifier_call_chain(device, event, 0))
+	if (acpi_notifier_call_chain(ACPI_VIDEO_CLASS, acpi_device_bid(device),
+				     event, 0))
 		/* Something vetoed the keypress. */
 		keycode = 0;
 
@@ -1609,7 +1610,8 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 		if (video_device->backlight)
 			backlight_force_update(video_device->backlight,
 					       BACKLIGHT_UPDATE_HOTKEY);
-		acpi_notifier_call_chain(device, event, 0);
+		acpi_notifier_call_chain(ACPI_VIDEO_CLASS, acpi_device_bid(device),
+					 event, 0);
 		return;
 	}
 
@@ -1642,7 +1644,8 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 	if (keycode)
 		may_report_brightness_keys = true;
 
-	acpi_notifier_call_chain(device, event, 0);
+	acpi_notifier_call_chain(ACPI_VIDEO_CLASS, acpi_device_bid(device),
+				 event, 0);
 
 	if (keycode && (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS)) {
 		input_report_key(input, keycode, 1);
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index acf5dd2177a1..1bfc4179e885 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1081,7 +1081,8 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
-	acpi_notifier_call_chain(device, event, acpi_battery_present(battery));
+	acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(device),
+				 event, acpi_battery_present(battery));
 	/* acpi_battery_update could remove power_supply object */
 	if (old && battery->bat)
 		power_supply_changed(battery->bat);
diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 96a9aaaaf9f7..4d840d2e7b98 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -24,12 +24,13 @@
 /* ACPI notifier chain */
 static BLOCKING_NOTIFIER_HEAD(acpi_chain_head);
 
-int acpi_notifier_call_chain(struct acpi_device *dev, u32 type, u32 data)
+int acpi_notifier_call_chain(const char *device_class,
+			     const char *bus_id, u32 type, u32 data)
 {
 	struct acpi_bus_event event;
 
-	strscpy(event.device_class, dev->pnp.device_class);
-	strscpy(event.bus_id, dev->pnp.bus_id);
+	strscpy(event.device_class, device_class);
+	strscpy(event.bus_id, bus_id);
 	event.type = type;
 	event.data = data;
 	return (blocking_notifier_call_chain(&acpi_chain_head, 0, (void *)&event)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index aad1a95e6863..ff14c9362122 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -625,7 +625,8 @@ int acpi_dev_install_notify_handler(struct acpi_device *adev,
 void acpi_dev_remove_notify_handler(struct acpi_device *adev,
 				    u32 handler_type,
 				    acpi_notify_handler handler);
-extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
+extern int acpi_notifier_call_chain(const char *device_class,
+				    const char *bus_id, u32 type, u32 data);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
 
-- 
2.51.0





