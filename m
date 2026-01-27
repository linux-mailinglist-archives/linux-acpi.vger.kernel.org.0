Return-Path: <linux-acpi+bounces-20685-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGH1LZcZeWksvQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20685-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:01:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB49A2C3
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673B53023515
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDDF22D4C8;
	Tue, 27 Jan 2026 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI1BXj+D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157301E7C34
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544082; cv=none; b=YDEqjKoTvLbhCY+N3gBJf3l0Yob7c81j6UjIPMpFqEEeOYM9X8I3vzmnyw6NHsXPdlsij46DE8JqrmMe+AlPj50tWM46NHtfXIdvxcEnwR/2e+jEzYd3Ak2qi3fbxi2KUA/Nx1KVLiz64koMie0ktTOv2Nk/e0lT49rZrqrSEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544082; c=relaxed/simple;
	bh=9TbVAiB8xmPLMIat08RxGmQrSfW3baJDeZStTiXU14g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ee+p3URYyB0FtppFw8yd+x7td/d2JLs2O0RudxID4cB0z0EzE3YIimouWYdYlmaA8UDhbgl8dRtUmE0hLJsUvsBhJjqRDwQt1G/zNpDU/DZbZy2PVSvSc1LKfvgxMQpSLvMcK3XkpN6/iBFs1vmty2m+0QzELfKLgpk7nuGTMD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI1BXj+D; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359a316d89so4539166f8f.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 12:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769544079; x=1770148879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1HymHUB9Wx8lSqzigaAIxk/7vgjbosQ3HEwzmr7JTo=;
        b=eI1BXj+DmRCj8+kqRbd4hOx1A2P8KVbMRuSv+gNdjFMDI19JunYLtbcKKeQ2wq6gKT
         w3tur+yA8vWQhKNAjifnenfVOJhvy+7j2bdWsWjN+jIOxWN8YkfEuRzHP+0gGZnHzF83
         OFZlvL2GjqHg/xP1rY+Gdr4uFkyq3bJkTETtjFMwd6a+2d/MJwXNxDnEiwZD+1BF/1lC
         DowKeP3JIvkxnYbsY4Pk7V0wbAOKNtcrulohNmYYwNK7p4BTPLFHzek8tYx7fx2ECjl6
         FqxM0ZuseRrFgvL8J8LkVMl4sl+V5NRRsKiazoMTHyt+EReSq1ftgKhmEhxiI10ri231
         GUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769544079; x=1770148879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1HymHUB9Wx8lSqzigaAIxk/7vgjbosQ3HEwzmr7JTo=;
        b=rYqHbSJG5h8QjII5M5dbmbv9me84nLEy1DmK/Fq6iZEft2FQgrcue02T/t6iZZF4Uw
         1qGDCVC62qy8Heu5DIQGJwDo5HyDgfrHGveHcPoUBdhOS7V2adh8T5VCXx+tKIKslAQb
         4ju5LZA+4C+JpnY02IoftqdSyZPSoNvwEZjwhM1OVjnWGA0aAdzBoEIEWgpUn+GOyrE3
         CZvhZjH7Uu9QZ3U5WTbA+mnb/jOjRZRuZmi/oivcB7Kavkoj34C3ah7SX29m2Bcsq0d1
         ggEqz4b/psaVuriy7jmE7IENRItbcIwPMcWSEGLXCtnOUhWaIeB6xPyeNzWPbxNrXLX4
         WFEg==
X-Forwarded-Encrypted: i=1; AJvYcCVneHORbUEvM90js7h1IscHjjleXTvnYTfKl1+LJ1Z+OkIzb2qDZ1fubweKCaCyuyqg0PZAhD3K9lXf@vger.kernel.org
X-Gm-Message-State: AOJu0YyYB3mqSnDms3zYm9Yn4JmE2Fd2aFt09Mbxd3OWaYtd2NJyes7l
	BFOWMxhN1ZEAUcH3NbgfaNhQ5znqkHggeEf2tfXRVXb2eHzai8DNWAjh
X-Gm-Gg: AZuq6aKV8s5SxhLkpcZ8fSPZltm+Oo2VthMY8K1BCL0Q8jo4PHXCCKkxRrZE55vNtqe
	1CB1+f5xZSuvv1zzKgUtAhhi0WWNVY8fP4fopCuFY/yLifqrhB17pr7nmjTwtcSEnzHMspeZxqN
	S5c/l9K2YcObd+B2MazklMxfLDMoLWfpkOFSdC4qOyOnd1y/HiuambNIm21uX1SsrQnUKcqVPgk
	5bpUYVXInRZaFHsJTUa1PDbO8bvzsmY2ffOKFQ0Im53pMbuh3ZElnnQfR33wW8EhhQnTvnA7jft
	KcLjOAPmd1HmtI6zT/2eHCovKi0SUiDseuMe1Pi/hQwezvGlOmfzD91VldyBbW2gokovn7nBAUa
	0tIEyiWV4qkTUGbVtxsfMVWLHzMFJ5OzzymIVz45bYrGzvsMUvGQnuTTQcW6DYLdWpcvks49XBq
	4YQ2nmwHaYcCDBpiqRNjFRO/YMl9I7tm+KbkYc6u/nkUizA7Fa0Ac=
X-Received: by 2002:a05:6000:1a8f:b0:435:db6e:e3b2 with SMTP id ffacd0b85a97d-435dd090a39mr4182208f8f.27.1769544079172;
        Tue, 27 Jan 2026 12:01:19 -0800 (PST)
Received: from jakob-laptop.tail0b2949.ts.net ([213.55.197.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee562sm1197724f8f.18.2026.01.27.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:01:18 -0800 (PST)
From: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	lkml@antheas.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakob Riemenschneider <riemenschneiderjakob@gmail.com>,
	Antheas Kapenekakis <antheas@antheas.dev>
Subject: [PATCH v2] ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9 (Turn On Display)
Date: Tue, 27 Jan 2026 21:01:21 +0100
Message-ID: <20260127200121.1292216-1-riemenschneiderjakob@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,antheas.dev,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20685-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riemenschneiderjakob@gmail.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CAFB49A2C3
X-Rspamd-Action: no action

Windows 11, version 22H2 introduced a new function index (Function 9) to
the Microsoft LPS0 _DSM, titled "Turn On Display Notification".

According to Microsoft documentation, this function signals to the system
firmware that the OS intends to turn on the display when exiting Modern
Standby. This allows the firmware to release Power Limits (PLx) earlier.

Crucially, this patch fixes a functional issue observed on the Lenovo Yoga
Slim 7i Aura (15ILL9), where system fans and keyboard backlights fail to
resume after suspend. Investigation linked shows the EC on this device
turns off these components during sleep but requires the Function 9
notification to wake them up again.

This patch defines the new function index (ACPI_MS_TURN_ON_DISPLAY) and
invokes it in acpi_s2idle_restore_early_lps0(). The execution order is
updated to match the logic of an "intent" signal:

1. LPS0 Exit (Function 6)
2. Turn On Display Intent (Function 9)
3. Modern Standby Exit (Function 8)
4. Screen On (Function 4)

Invoking Function 9 before the Modern Standby Exit ensures the firmware
has time to restore power rails and functionality (like fans) before the
software fully exits the sleep state.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications#turn-on-display-notification-function-9
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220505
Suggested-by: Antheas Kapenekakis <antheas@antheas.dev>
Signed-off-by: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
---
v2:
 - Renamed constant from ACPI_LPS0_MS_DISPLAY_ON to ACPI_MS_TURN_ON_DISPLAY per feedback.
 - Moved the Function 9 call to occur before MS Exit (Function 8) to act as an intent signal.
 
 drivers/acpi/x86/s2idle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 6d4d06236..de94b57f7 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -45,6 +45,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_EXIT		6
 #define ACPI_LPS0_MS_ENTRY      7
 #define ACPI_LPS0_MS_EXIT       8
+#define ACPI_MS_TURN_ON_DISPLAY 9
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
@@ -352,6 +353,8 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 			return "lps0 ms entry";
 		case ACPI_LPS0_MS_EXIT:
 			return "lps0 ms exit";
+		case ACPI_MS_TURN_ON_DISPLAY:
+			return "lps0 ms turn on display";
 		}
 	} else {
 		switch (state) {
@@ -612,6 +615,9 @@ static void acpi_s2idle_restore_early_lps0(void)
 	if (lps0_dsm_func_mask_microsoft > 0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		/* Intent to turn on display */
+		acpi_sleep_run_lps0_dsm(ACPI_MS_TURN_ON_DISPLAY,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		/* Modern Standby exit */
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-- 
2.52.0


