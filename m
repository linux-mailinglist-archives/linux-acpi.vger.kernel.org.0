Return-Path: <linux-acpi+bounces-17940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD873BED15C
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE5347CA2
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135FA2EBB9E;
	Sat, 18 Oct 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y3QQWzRp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C401F3BA2;
	Sat, 18 Oct 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797329; cv=none; b=UJKPDvUfuyzmutVChSKA/1zGeMPHokTB3aPie2PHJuvE46IfHlbGMXSk3buLLrat6AiKRp5oXe1ZYYtaTUvMs0Gv3EGIAdULyQ3fyi1DHN1tKt10mTvMVmE7OFfm55ohwAeQ/f+bAlhKodEmOjPAgDVHtRaRCBb2aa8CFNe/aJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797329; c=relaxed/simple;
	bh=9Yp3lWJoa834+XZ6vTMNTzs2BLUob7J+OnRKmzYu8r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sc4D6CluVf9/zh7XtM7gVlkBkO1THPCUbewJdVeitg5jJM1o2rewE7qZx8gwIxlaMLnqUajV550t4cgQhG1GzfwCAlOmWDYoFXZAVVrPf2eA6ni8PlvJ2KfRpozQnsf7KobSLyiVl7qA0S84BTCrGIuQKPT1CSlbLaJ6T/nrlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y3QQWzRp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760797324;
	bh=9Yp3lWJoa834+XZ6vTMNTzs2BLUob7J+OnRKmzYu8r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3QQWzRpxO5IXGn61zAoOcjSsRL2U/BnlLMfr1ZqcQIkJo8SUdnBE9ixNQqXmS4r8
	 ZEZPXXCbr+bQKuUAoAE5ZwjiOLeV2kbo5WtHXxBDCuzfzuM2OsNWqpRVAbB+hYoJoX
	 2g7ETOuTnXtnUZgVHxD7hdg0LJtUhVDXeGaTEH2KZdixmrq7iqJpKZAs+/wtK4/j62
	 4uqz5ME8UoQcjq7fR3zdbpQwv/sC0K54CycwqzXKP3nSIlEa3/lZ9N5IsKA2YNGU1I
	 xcyQysrXeTFjgA7k48QwaEsAAr8EvhTyVYAJVpdWumWiG10wCjBQ87q1KcYS+NyRY1
	 OEi415JhXtxeA==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 957E617E124A;
	Sat, 18 Oct 2025 16:22:01 +0200 (CEST)
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
Subject: [RFC 2/4] ACPI: button: Cancel hibernation if button is pressed during hibernation
Date: Sat, 18 Oct 2025 19:21:05 +0500
Message-ID: <20251018142114.897445-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251018142114.897445-1-usama.anjum@collabora.com>
References: <20251018142114.897445-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_pm_wakeup_event() is called from acpi_button_notify() which is
called when power button is pressed. But system doesn't wake up as
pm_wakeup_dev_event() isn't called with hard parameter set in case of
hibernation. It gets set only for s2idle cases.

Call acpi_pm_wakeup_event() if power button is pressed and hibernation
is in progress. Set the hard parameter such that pm_system_wakeup()
gets called which increments pm_abort_suspend counter. Hence hibernation
would be cancelled as in hibernation path, this counter is checked if it
should be aborted.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/acpi/button.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 0a70260401882..4a2575c0c44e3 100644
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
+	    hibernation_in_progress()) {
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


