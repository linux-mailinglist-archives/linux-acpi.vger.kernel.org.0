Return-Path: <linux-acpi+bounces-18672-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910DC41543
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 288284E733A
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 18:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B72E5418;
	Fri,  7 Nov 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="enMnSQJS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99933B940;
	Fri,  7 Nov 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541130; cv=none; b=rGVa8BpPSeTLol/GZFFYvyAHjykaKeyB0HkJ+cvq/Sy6xZ/cgsUaZPAWe7qTG9dAceBNVL5CKQxRQjXynBvAc1Ac4tP9uIwfsZk0zawtLVltxJFQcApPKBW93nqfBcAJpUeg5KnKgZHblqIXrIAZ6evnjaT2YGVac9i+B2Lfh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541130; c=relaxed/simple;
	bh=p7JYx3rGvaWC41tnyNec+b33gebpWFTr9SuPyJ8mJn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAkQtYTdqskSkSEUaU/wRkD2IdWrVsI+Z6EXZnLUu90ca4XSbMOzuLMLamAuCOAq0cHc+K2USfS7OlDc8uohpzIbdf/XLhLmaurMA65SsUHMngZD17YhGqvju0I081lIi6IymBlODii/4/ZCj3rsXbGa+Fx7gfv1t3I5fHMEHx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=enMnSQJS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762541126;
	bh=p7JYx3rGvaWC41tnyNec+b33gebpWFTr9SuPyJ8mJn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enMnSQJSX3lrRnxVvEndU3PZ4Hg05uwRZ1q8BywGQzNQJ1wPzPnuPwuaTi8zbZmSN
	 51TrgoPC4QKOyG7Ljd4/dmPgJNP7uZoZvDqhvmkVRUBGBsK0h7ihG94NdXaeUOWIoA
	 kCkg6KC/OSNSrWCq9OoHtt3L8k86ariSfSPmhAAUkPdODtsfJ0hiwav4+EAd+jdgrj
	 WI3WwoLX0BHsHA7leegPkvnbcdqlRSKgD4gYpcNPnQlX9EZzirGGXQ2ad4KmF8LTGU
	 onNnDuyK6dUdO2+1H1z0HEY3UFJlEoBB0XaA3Hx18pH35zz+hyM68AdZCbhMeV7h5F
	 isbsWVaiGlQuQ==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D0E3B17E108B;
	Fri,  7 Nov 2025 19:45:22 +0100 (CET)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	superm1@kernel.org
Subject: [PATCH 2/4] ACPI: button: Cancel hibernation if button is pressed during hibernation
Date: Fri,  7 Nov 2025 23:44:29 +0500
Message-ID: <20251107184438.1328717-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251107184438.1328717-1-usama.anjum@collabora.com>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_pm_wakeup_event() is called from acpi_button_notify() which is
called when power button is pressed. The system is worken up from s2idle
in this case by setting hard parameter to pm_wakeup_dev_event().

Call acpi_pm_wakeup_event() if power button is pressed and hibernation
is in progress. Set the hard parameter such that pm_system_wakeup()
gets called which increments pm_abort_suspend counter. The explicit call
to acpi_pm_wakeup_event() is necessary as ACPI button device has the
wakeup source. Hence call to input_report_key() with input device
doesn't call pm_system_wakeup() as it doesn't have wakeup source
registered.

Hence hibernation would be cancelled as in hibernation path, this counter
is checked if it should be aborted.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since RFC:
- Use pm_sleep_transition_in_progress()
- Update descriptin why explicit call to acpi_pm_wakeup_event() is
  necessary
---
 drivers/acpi/button.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 3c6dd9b4ba0ad..e4be5c763edaf 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -20,6 +20,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <acpi/button.h>
+#include <linux/suspend.h>
 
 #define ACPI_BUTTON_CLASS		"button"
 #define ACPI_BUTTON_FILE_STATE		"state"
@@ -458,11 +459,16 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	acpi_pm_wakeup_event(&device->dev);
 
 	button = acpi_driver_data(device);
-	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
-		return;
-
 	input = button->input;
 	keycode = test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_POWER;
+	if (event == ACPI_BUTTON_NOTIFY_STATUS && keycode == KEY_POWER &&
+	    pm_sleep_transition_in_progress()) {
+		pm_wakeup_dev_event(&device->dev, 0, true);
+		return;
+	}
+
+	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
+		return;
 
 	input_report_key(input, keycode, 1);
 	input_sync(input);
-- 
2.47.3


