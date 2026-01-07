Return-Path: <linux-acpi+bounces-20002-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7612CFF640
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34260359D244
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94953A89BF;
	Wed,  7 Jan 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="darMaO/M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3B3A89A9
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800419; cv=none; b=qTzfC2gwGp0CT8Ot6llcZL1lzjYDUmtpB16shltHuqom7e48DNm0Tai0bZYC9YJVtgJa9w9B7NL9cdz1eyCr0aFzeKQty5cgXblte4PaGfvaMj0mCqDIf/Lu+KkTcUdwFanCR7pGQYAo4vSnNF5Sv8rNnwPsUcyAFGBV/MB58ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800419; c=relaxed/simple;
	bh=8NylTbAKkO0l/KF1BMUiE4edWBqzJMxu+bSiJDX+mBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyR6vFFg7wdSL+VoPCV2Fu3Q85XmzFJf145Xs5WLoKV8NsoT92EsuuN7/SSpZA936gzAnlD4hX4aRLf3+OokIpHl0c06j3NWHMZr/UxGlH8WrOTVSXl9X53ExVkBxMviZDodE7dLJareVSE88cXKTHv9Ttl7RwsTlV80NkyM5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=darMaO/M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-430f57cd471so1165220f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 07:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800415; x=1768405215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LnKRy0r9W4pXmpxTnitCMSMrxA5/RNH5gipwHUBu7h0=;
        b=darMaO/MCfZstB4Jvddnu8pXDEyhn/N7BeHaXifuNlYQDbXVQTngCn9LXbzgizDLQX
         CU/pEePdUKjA5EwLI7W42AW5SOqxaGcRCHr/vjAedDoYaGAf8bVuNZtpXWjUT18LhUAw
         wS0pBLSgZm2yBSIBHzndA2JPCcMfjfKBLHrtshLLo9UvqzMTmBmv2siM/sl5e9h42zDP
         AQRGzZGqXJuNgQEpFtw/eNls/RLVpN/+1H2aiQc/kjLpZZjNsQ0BTeyvY19XZwjZHYXq
         0Oxd2j2e5V7HjmV2gqtpbuulx52Pp+SseNud6W0cDlexKNYGUveTQ+Bh4q2jA/fcPuA8
         6JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800415; x=1768405215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnKRy0r9W4pXmpxTnitCMSMrxA5/RNH5gipwHUBu7h0=;
        b=GeqGfLXk4rWgZyPD/wLQMxRUl1qlhOgLokBy/VWY1RJLx11qik4ZGD98Jp7Gbr640n
         MQ+7RSV/pHL8cuj/m3y5zDkym7vlupQpR7pJG/Wlq39rX/TwHBzB9DBRRj5D6ajlWqmK
         Wl/vtKrrSBYy1U22OUOsaO94jrcOo+QMZy7I4eN30UZuclI1p3Hs39JQgt1zJula0iHa
         2yRn/jPkqFdFw6yfu3FT9faVw8fMD+U2V3efy1ReZ8n2VuC9otQ0eA0VjbdyNAdddtzX
         3cLnb2ipiqvkBETct4MsJlMBg/kWX7g4WkE++4dtxxTRvqCTRKvjiMmzf+hYjvKD2wo7
         6V4A==
X-Gm-Message-State: AOJu0YwSQ1JiLnsgYomkx0voqB6VN0uFF+IKWKMfQVw7L7DOQ+TcUtdl
	O0ZxaVdKeKJ74wCjoDqApYZzllegy0HHmjdWrR/yaPc1lQGn7HcQ/Rou
X-Gm-Gg: AY/fxX752p8q87KYZJvWJrq2JAlUwWmu34uhajWda5l80vrDj8Q6JWfgIiZZK2lK/z9
	nhWKdZZXfCR7SkTNN9J0Hp8d/ep4HiqMHon5Z+F46Dw+JmHY1D/ZRlAWIaIQI7ylvF1DiIHGoN/
	mKoKH5OJAbN4ZVeFB20dMpiFHw2uj5HtXYue4KA0hiL2Pal0BoCw5HJd+4xp68GnYP5JDDlTUSR
	CL/DJQj/ud8Os0zP5cQ94C+2CDsFTQnOUGnPwA6a6Hs34l2ZWeHbFcfwJgoaiDtlxyoOB99i3r/
	ebd9Ki7cwmYxPtyNNYK6+ZhjT1c3UKIPgoxc8k8/vCwbNIoqCt4IqAT2pEr9leIZSQhiuHG3+yj
	1Gcm+7nF0QV55JF2Etmf1tSZJ1iFU+t1Wj2sYKIMdP1xx274hCWZerHytmeu6GGgJiGBMN6jMH0
	DMsnve3Gciz7Ai33wrZ3INbxwFwJCcmEDinqkZWLpct40Xs0CLnAqb5foIiLlCVYQ0wVtMehw=
X-Google-Smtp-Source: AGHT+IFhFh3T0uRqlfiQlVX5OqrzXHZtllu89mEJORSKo6LkQq8PeB5+E8fZ+Tl98LJAkRUhIT6SOg==
X-Received: by 2002:a5d:64e7:0:b0:431:7a0:dbbe with SMTP id ffacd0b85a97d-432c374ffaamr4032308f8f.32.1767800414774;
        Wed, 07 Jan 2026 07:40:14 -0800 (PST)
Received: from jakob-laptop.d.ethz.ch (2001-67c-10ec-574c-8000--36.net6.ethz.ch. [2001:67c:10ec:574c:8000::36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm11037422f8f.16.2026.01.07.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:40:14 -0800 (PST)
From: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
X-Google-Original-From: Jakob Riemenschneider <jriemenschne@student.ethz.ch>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9 (Turn On Display)
Date: Wed,  7 Jan 2026 16:40:15 +0100
Message-ID: <20260107154015.322698-1-jriemenschne@student.ethz.ch>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Windows 11, version 22H2 introduced a new function index (Function 9) to
the Microsoft LPS0 _DSM, titled "Turn On Display Notification".

According to Microsoft documentation, this function signals to the system
firmware that the OS intends to turn on the display when exiting Modern
Standby. This allows the firmware to release Power Limits (PLx) earlier,
improving resume latency on supported OEM designs. Without this call,
some devices may remain in a throttled power state longer than necessary
during resume.

This patch defines the new function index (ACPI_LPS0_MS_DISPLAY_ON) and
invokes it in acpi_s2idle_restore_early_lps0() immediately after the
screen-on notification, provided the firmware supports the function in
its mask.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications#turn-on-display-notification-function-9
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220505
Signed-off-by: Jakob Riemenschneider <jriemenschne@student.ethz.ch>
---
 drivers/acpi/x86/s2idle.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 6d4d06236..4ce4cc8a0 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -45,6 +45,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_EXIT		6
 #define ACPI_LPS0_MS_ENTRY      7
 #define ACPI_LPS0_MS_EXIT       8
+#define ACPI_LPS0_MS_DISPLAY_ON 9
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
@@ -352,6 +353,8 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 			return "lps0 ms entry";
 		case ACPI_LPS0_MS_EXIT:
 			return "lps0 ms exit";
+		case ACPI_LPS0_MS_DISPLAY_ON:
+			return "lps0 ms display on";
 		}
 	} else {
 		switch (state) {
@@ -618,9 +621,14 @@ static void acpi_s2idle_restore_early_lps0(void)
 	}
 
 	/* Screen on */
-	if (lps0_dsm_func_mask_microsoft > 0)
+	if (lps0_dsm_func_mask_microsoft > 0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+				/* Modern Turn Display On */
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_DISPLAY_ON,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	}
+
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
 					ACPI_LPS0_SCREEN_ON_AMD :
-- 
2.52.0


