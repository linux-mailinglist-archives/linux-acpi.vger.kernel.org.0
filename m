Return-Path: <linux-acpi+bounces-21446-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGTbLhLoqWnrHgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21446-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:31:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CEC2182CB
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15DEA311FFAA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F1833893D;
	Thu,  5 Mar 2026 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri4M+i9U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656D2877DA;
	Thu,  5 Mar 2026 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742560; cv=none; b=HodexgfYQFB+XtN4L6ulWD3UtXtKDPk2BHeBBte+dtaOeA9hJ6npGMIGp0o5MgVM4rNSKIdbNApHP9UfpFcrYxHCDl/BSwzbs2Z7vE0VngZJgTildJVKvcmKSrnVqff6GjjZIPx9qdErbzwS+TQdpZZlbpf54Jz8UlQCzbQseRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742560; c=relaxed/simple;
	bh=ernrdKhesQzKSW4P8/b20dhtKj8kfX3mUWKJafyi044=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEjzduZ9dlJV1K3epCj5O0nOV8Yt0fVyXquhB9ts5jbWUwGXbx44oS17+bB7y+3O1Nie5X+HFT6LkWLTWg9XrCDX0fz2CGRw/B+2eWWB9XGZG8Zc2Fxz3mQKj12Rps+uwFrAp5y5gzWuIuS23/66YriSgJQsVfcJKBsSkw+jDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri4M+i9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A25DC19422;
	Thu,  5 Mar 2026 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742560;
	bh=ernrdKhesQzKSW4P8/b20dhtKj8kfX3mUWKJafyi044=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ri4M+i9U9ZwZ4AuvsYd0X0FU7FRkAhWlqkW/ZRRPz4ejCG6y/6AXUMmuXmbkpfX/i
	 gieXf/fVB+r1t+eHz0r6Ln8uNS+wwx8sYeqyI8BV+6ylYlzEqTEgIGJ+UjtdPdFVEm
	 T07PUgAQdYrTUSlIGXyCQEsmh1v6aFoqM7MKdnq3oZTE+akKxq6kf8X3ZzSDzk2vON
	 mNF5xQFDRehbMMPN8hadWggqpCU/RX0F2MsbENmPfB2YZcHAapRqRJ5zsK+ptYTZt7
	 jIZRFZG0mPFbwcn4TVlRSH43kWkNtEffnde8hsBuo9dnoYwp9rLAbBH4WzB0bXDW2s
	 r0sq5paV58JfA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 7/9] ACPI: driver: Avoid using pnp.device_class for netlink
 handling
Date: Thu, 05 Mar 2026 21:20:20 +0100
Message-ID: <4373540.1IzOArtZ34@rafael.j.wysocki>
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
X-Rspamd-Queue-Id: 65CEC2182CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21446-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update several core ACPI device drivers that use
acpi_bus_generate_netlink_event() for generating netlink messages to
pass a string literal as its first argument instead of a pointer to
pnp.device_class in a given struct acpi_device, which will allow them
to avoid initializing the pnp.device_class field in the future.

The ACPI button driver that uses different acpi_device_class()
values for different button types will still pass it to
acpi_bus_generate_netlink_event(), but update it to use the
acpi_device_class() macro instead of open coding the pointer
access path.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c               |    6 +++---
 drivers/acpi/acpi_pad.c         |    4 ++--
 drivers/acpi/battery.c          |    2 +-
 drivers/acpi/button.c           |    2 +-
 drivers/acpi/processor_driver.c |   22 ++++++++--------------
 drivers/acpi/thermal.c          |    6 +++---
 6 files changed, 18 insertions(+), 24 deletions(-)

--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -130,9 +130,9 @@ static void acpi_ac_notify(acpi_handle h
 			msleep(ac_sleep_before_get_state_ms);
 
 		acpi_ac_get_state(ac);
-		acpi_bus_generate_netlink_event(adev->pnp.device_class,
-						  dev_name(&adev->dev), event,
-						  (u32) ac->state);
+		acpi_bus_generate_netlink_event(ACPI_AC_CLASS,
+						dev_name(&adev->dev), event,
+						ac->state);
 		acpi_notifier_call_chain(ACPI_AC_CLASS, acpi_device_bid(adev),
 					 event, ac->state);
 		power_supply_changed(ac->charger);
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -413,8 +413,8 @@ static void acpi_pad_notify(acpi_handle
 	switch (event) {
 	case ACPI_PROCESSOR_AGGREGATOR_NOTIFY:
 		acpi_pad_handle_notify(handle);
-		acpi_bus_generate_netlink_event(adev->pnp.device_class,
-			dev_name(&adev->dev), event, 0);
+		acpi_bus_generate_netlink_event(ACPI_PROCESSOR_AGGREGATOR_CLASS,
+						dev_name(&adev->dev), event, 0);
 		break;
 	default:
 		pr_warn("Unsupported event [0x%x]\n", event);
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1078,7 +1078,7 @@ static void acpi_battery_notify(acpi_han
 	if (event == ACPI_BATTERY_NOTIFY_INFO)
 		acpi_battery_refresh(battery);
 	acpi_battery_update(battery, false);
-	acpi_bus_generate_netlink_event(device->pnp.device_class,
+	acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
 	acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(device),
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -468,7 +468,7 @@ static void acpi_button_notify(acpi_hand
 	input_report_key(input, keycode, 0);
 	input_sync(input);
 
-	acpi_bus_generate_netlink_event(device->pnp.device_class,
+	acpi_bus_generate_netlink_event(acpi_device_class(device),
 					dev_name(&device->dev),
 					event, ++button->pushed);
 }
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -53,7 +53,7 @@ static void acpi_processor_notify(acpi_h
 {
 	struct acpi_device *device = data;
 	struct acpi_processor *pr;
-	int saved;
+	int saved, ev_data = 0;
 
 	if (device->handle != handle)
 		return;
@@ -66,33 +66,27 @@ static void acpi_processor_notify(acpi_h
 	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
 		saved = pr->performance_platform_limit;
 		acpi_processor_ppc_has_changed(pr, 1);
-		if (saved == pr->performance_platform_limit)
-			break;
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event,
-						  pr->performance_platform_limit);
+		ev_data = pr->performance_platform_limit;
+		if (saved == ev_data)
+			return;
+
 		break;
 	case ACPI_PROCESSOR_NOTIFY_POWER:
 		acpi_processor_power_state_has_changed(pr);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event, 0);
 		break;
 	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
 		acpi_processor_tstate_has_changed(pr);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event, 0);
 		break;
 	case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
 		cpufreq_update_limits(pr->id);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event, 0);
 		break;
 	default:
 		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
-		break;
+		return;
 	}
 
-	return;
+	acpi_bus_generate_netlink_event(ACPI_PROCESSOR_CLASS,
+					dev_name(&device->dev), event, ev_data);
 }
 
 static int __acpi_processor_start(struct acpi_device *device);
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -340,7 +340,7 @@ static void acpi_thermal_trips_update(st
 	thermal_zone_for_each_trip(tz->thermal_zone,
 				   acpi_thermal_adjust_trip, &atd);
 	acpi_queue_thermal_check(tz);
-	acpi_bus_generate_netlink_event(adev->pnp.device_class,
+	acpi_bus_generate_netlink_event(ACPI_THERMAL_CLASS,
 					dev_name(&adev->dev), event, 0);
 }
 
@@ -542,7 +542,7 @@ static void acpi_thermal_zone_device_hot
 {
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
 
-	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
+	acpi_bus_generate_netlink_event(ACPI_THERMAL_CLASS,
 					dev_name(&tz->device->dev),
 					ACPI_THERMAL_NOTIFY_HOT, 1);
 }
@@ -551,7 +551,7 @@ static void acpi_thermal_zone_device_cri
 {
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
 
-	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
+	acpi_bus_generate_netlink_event(ACPI_THERMAL_CLASS,
 					dev_name(&tz->device->dev),
 					ACPI_THERMAL_NOTIFY_CRITICAL, 1);
 




