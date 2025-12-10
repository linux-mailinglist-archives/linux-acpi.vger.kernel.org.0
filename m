Return-Path: <linux-acpi+bounces-19536-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F363FCB332E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AF4C30322A0
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A519E242D9D;
	Wed, 10 Dec 2025 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qevCGp1l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962E241103;
	Wed, 10 Dec 2025 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377894; cv=none; b=Q9+uMHGFYfa53tVkRLhN8D00j1zgtHDuA/6hvmsZWs4ZbI6tmIp7qf6QWicDA+As4XwQnYXvr9VcztD6ZLctiRRT9Rk33lHbJpXoYQCq2NZ3+Awtu6BiV+yoVApCA4YNIeHI1qkRTUix5SGlWS3+0PVQUFdSyqGdxRljni9gGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377894; c=relaxed/simple;
	bh=lp8PEtpkaTQ0KcEFGCPYSwOtRAHJMPB6hYTLSd37GR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/+bJ7GKLbkb00i8c6XloHrrwRyAJmQg56TQbutZiXZiH6duk502bo/9hs16wO9jz/5jM6/je0kMF5C/JwSeVtt/zlMRjfaztH47WDaLmaNXMQwtoLRyy+WHH/4WbqHGEaDWDrf0QowlVgj8A5sEDxD7n3mjDEK3iq4PRkgLOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qevCGp1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFE3C4CEF7;
	Wed, 10 Dec 2025 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377894;
	bh=lp8PEtpkaTQ0KcEFGCPYSwOtRAHJMPB6hYTLSd37GR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qevCGp1lSmkP8njT578YGRQrIKFCT/49GBCCme0AHF/w9CLHi1Zmpz6TZHruvey52
	 jXjf/T4LxR6PrwXHWfXu9hFr4SwngoPIr3H9KA+f6g/rynqhSET/Me5ztUUdnoXU1J
	 BYvw8GRVZJHhjDatrpnOKSN4vLuqjwCK+buVWv+jvwzh086yM/XMlidV+RfJpY2Ry8
	 i5pcTauMYv+KonRiNo8JTkkkJvsT5Lg+DU/kYdcOoe+2Z3LWZGTsJucC3heVUmV14c
	 JS8VTgesqeqTZEzG1yj3bNODBtubx+OViuasT2P26/O9OwVFS6r0ZDsbKdENUL/gzA
	 bMf2iVPI7MLMw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 2/4] ACPI: thermal: Adjust event notification routine
Date: Wed, 10 Dec 2025 15:43:11 +0100
Message-ID: <5035876.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
References: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Adjust acpi_thermal_notify() to cast its "data" argument to a struct
acpi_thermal pointer istead of a struct acpi_device one, which allows
the use of acpi_driver_data() to be limited and will facilitate
subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -670,8 +670,7 @@ static void acpi_thermal_unregister_ther
 
 static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_thermal *tz = acpi_driver_data(device);
+	struct acpi_thermal *tz = data;
 
 	if (!tz)
 		return;
@@ -685,8 +684,8 @@ static void acpi_thermal_notify(acpi_han
 		acpi_thermal_trips_update(tz, event);
 		break;
 	default:
-		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
-				  event);
+		acpi_handle_debug(tz->device->handle,
+				  "Unsupported event [0x%x]\n", event);
 		break;
 	}
 }
@@ -881,7 +880,7 @@ static int acpi_thermal_add(struct acpi_
 		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temp_dk));
 
 	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						 acpi_thermal_notify, device);
+						 acpi_thermal_notify, tz);
 	if (result)
 		goto flush_wq;
 




