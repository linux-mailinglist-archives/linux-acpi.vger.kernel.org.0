Return-Path: <linux-acpi+bounces-13629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D57AAF136
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 04:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFF84C5BF2
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 02:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2579433AC;
	Thu,  8 May 2025 02:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="map1Ah/e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090E2CA9
	for <linux-acpi@vger.kernel.org>; Thu,  8 May 2025 02:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672151; cv=none; b=LwJjtfN2Hyc0EtZ9I23RrNrwpNA93Ed9tcttHAUGHR2+4dqZ5HvBkN+8weYfscyqlVt54lU0TYt5WCBr5TuZX/Ate9mDAEiFWa/yHqAexCvgeOXJgGNISFFAfRiRYX3J1vGofd6ZOd4W5RkhSJBa3UeZxe8kjj9vJiCBaWIh/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672151; c=relaxed/simple;
	bh=/AK/utNvp7j588BtkBLgIveswdfpMff5DEFvkC4m5R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEdy9euKkpe7MiqigN6dKwD8+T1FwLH06hvNdlmx4mivcecOYKdonQ1Q/cgb+8NkdVOX9QNfD2nEVcplEiFAvdGf0RpycMVDiSQ7RfqV4GLidwDmu3nt4J3bwVA7f7ceTXxzU13TqNaNIdMGqGM4cq3Qg7x8SPqoIvN7xyae4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=map1Ah/e; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e033a3a07so6548205ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2025 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746672149; x=1747276949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sp0xP1kEFvMgOwhHMeYT9QVw2Uj7HrRfX3aJPFwgNXc=;
        b=map1Ah/egZmLLdn8ulpkONDaOiewyppCpysSsoZttDcZhV5mFP9+Hbn2IEvyqiDVNQ
         zw2F4YPmmARSBXuGDgf/zU0miBcfv3Ev+3FXWr2stEvrTrHsgjcjvyuC01B63cNKEbSK
         y29iszUZEygTjoyoRMI5QNeeC0SD2KY1OOefM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746672149; x=1747276949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sp0xP1kEFvMgOwhHMeYT9QVw2Uj7HrRfX3aJPFwgNXc=;
        b=CYvoKGBsR2jPZHj61oIqn4iStj75ThryG/Oglz7J9UpC7iCAzmEQP/4Hq2bKCEDxN2
         9sJXAObc7BC2TmJoSd+8Kpk6Dl7cEIwaoexNRd+PoyzYgrltYM4o5/NAb4gm5Ss0xCbk
         YBG2RbJM9QSFKs3YqVD62FeGcicwOjjA9u8muovf2XlT9iMLtd57wUXYPoHTRchyJs6m
         ohnOQD11rpET7OO3sWdl1ctO1i2OLCdpRGQdaiIY9TPOaBLwcicr+kpqiGTbRx04rgG5
         ZWQMqQcj5CCEgSU/S8h8I/6pNuTb7SlfoqQ4LMgfzQK7ghfHRdTQwS6weZ7XyPI7B5W8
         TCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn6rwruLgHSCobtKLb9+sZ9tH4I4aRguHmIiPGNm4tUpmOzt/2Mi4JNVFsP6SsWEMSO11jvKB11T9Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUKz6P0dl28REiS3HXQRAAVs+AFTAO6wDhWO+IVVsZSTs5An/
	8JYDgmW4SeUXBTZPcVdmD5PZ5TjPawCvFn45MU+tcBwNR7vNT03J5ebWnip2rg==
X-Gm-Gg: ASbGncsmhA8ScRsmVs62PNWYneauVZwfsp1EFg6E1lw0tFgU4b66+0xXtu5HRrwjxN9
	nAh8HCRY5s4Cc3CSDZNVTHIoan1Mlm4BP/LGxvN/Rk+lS0//2+o4KWFvZjYZ5iRQmNEfHpcqdrs
	YO/JMSC/jS4DqBNLx6+3KfbsKCulm7ys0LmofFz80SIQauPnWt+xyKD9XmobJsF11i23QMweJ1k
	3LQyRq6HiwBlow5UWNPLTWjDnEBwhW6BCuE+gPA5CDhjtSmyuWUOcKJkqnO0ZmOs32YHzmCvGIo
	qnacyor+rgWBJJNLtT37M35zZUbuxvwkSEBdQ25DelStVeCg5Q==
X-Google-Smtp-Source: AGHT+IHqpP2q/kmpMvzpgnBcM9hCaQj2hGlwLBObKRqs2Gt1GrCTZtNblWv7on0MUIs7M0GAhvzzYg==
X-Received: by 2002:a17:902:ccc9:b0:223:5e56:a1ce with SMTP id d9443c01a7336-22e5ea9dcf7mr82125505ad.32.1746672149402;
        Wed, 07 May 2025 19:42:29 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:dc6d:cdc2:d5e4:9262])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1fb3924df3sm8686147a12.3.2025.05.07.19.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 19:42:29 -0700 (PDT)
From: Peter Marheine <pmarheine@chromium.org>
To: rafael@kernel.org
Cc: Peter Marheine <pmarheine@chromium.org>,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: battery: negate current when discharging
Date: Thu,  8 May 2025 12:41:45 +1000
Message-ID: <20250508024146.1436129-1-pmarheine@chromium.org>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
In-Reply-To: <CAG_X_pA0vW6ZWcT2K5R4DnOmz3R-Kz4vpiSC9oyAwKrATXMkZA@mail.gmail.com>
References: <CAG_X_pA0vW6ZWcT2K5R4DnOmz3R-Kz4vpiSC9oyAwKrATXMkZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI specification requires that battery rate is always positive,
but the kernel ABI for POWER_SUPPLY_PROP_CURRENT_NOW
(Documentation/ABI/testing/sysfs-class-power) specifies that it should
be negative when a battery is discharging. When reporting CURRENT_NOW,
massage the value to match the documented ABI.

This only changes the sign of `current_now` and not `power_now` because
documentation doesn't describe any particular meaning for `power_now` so
leaving `power_now` unchanged is less likely to confuse userspace
unnecessarily, whereas becoming consistent with the documented ABI is
worth potentially confusing clients that read `current_now`.

Signed-off-by: Peter Marheine <pmarheine@chromium.org>
---
 drivers/acpi/battery.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6760330a8a..93bb1f7d90 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -243,10 +243,23 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN) {
 			ret = -ENODEV;
-		else
-			val->intval = battery->rate_now * 1000;
+			break;
+		}
+
+		val->intval = battery->rate_now * 1000;
+		/*
+		 * When discharging, the current should be reported as a
+		 * negative number as per the power supply class interface
+		 * definition.
+		 */
+		if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
+		    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
+		    acpi_battery_handle_discharging(battery)
+				== POWER_SUPPLY_STATUS_DISCHARGING)
+			val->intval = -val->intval;
+
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
-- 
2.49.0.1015.ga840276032-goog


