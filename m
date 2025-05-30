Return-Path: <linux-acpi+bounces-14014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3717AC8F80
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 15:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45CC3B2017
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3F927FB19;
	Fri, 30 May 2025 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvjhAxAV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B24233715;
	Fri, 30 May 2025 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608923; cv=none; b=WDu6Ejl08ElOsk+b/hFmDQMgIADCpAvF05Tkl74rC1L4xGwCiRttg+9jzpVLz5SOVF/o3Yks4NAnUgr+fCOGXCB+4eTXTThGDYP1BVwQrZq6o4yTIpcBAlcpz3B9Ocbg+Z08Yl6bqoEBZCW1qgbkojr87cak+YGu5hhT/gM85bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608923; c=relaxed/simple;
	bh=aJwjP9e7gjZQaQWCt6ezZxkzG8xw3MSul2haAO5YENA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jN87FuAfRW5t0IvaurIEKUH2B/pqFU/bIlJcaSzjv0XlfDGS2mxZoSyKgW4NiVcFB4Oq2avVRkC5Z9M+vMyfF9JE9u6SHqKl+pijw7JBVCzuhU0FMjiZTIKiI+mGJQpd71x+Tzjvvdtzhntig4yFrNeJgGYUu98+RVX1+cdJ4xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvjhAxAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA22C4CEEB;
	Fri, 30 May 2025 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608922;
	bh=aJwjP9e7gjZQaQWCt6ezZxkzG8xw3MSul2haAO5YENA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvjhAxAVCBqw0wK5TqC9pNgdboSCUCMhh6+atTKHBxBZucSu6Fw2RNzgO1NVZmMCp
	 whciEnX2eclm5gQE13DuqYUMTvck9hs+L+5ErnSO1kLCCBpizbh9JdRTcJHFyDs4DS
	 6KH3pNpSI8fLFnMavSTgGrcNQEyLL/o0uPQlkD744cLhIyw8ZyEX/PUPAyTpcELjjg
	 fvZMWcXa25N8KGqZlRWDnos9e5mPqDmxJQDnp+4N4luzGWMDTpVg/mIvnG1291kOwx
	 EUZs0B4GZDoPbMat5OkrwDrVTNsjDKYKtiT2wMCRIevokMtQLPqdPzDN4NPL1Xp0Aa
	 kCf+psmr2bPJg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Marheine <pmarheine@chromium.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rjw@rjwysocki.net,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 10/10] ACPI: battery: negate current when discharging
Date: Fri, 30 May 2025 08:41:48 -0400
Message-Id: <20250530124148.2576913-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124148.2576913-1-sashal@kernel.org>
References: <20250530124148.2576913-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Peter Marheine <pmarheine@chromium.org>

[ Upstream commit 234f71555019d308c6bc6f98c78c5551cb8cd56a ]

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
Link: https://patch.msgid.link/20250508024146.1436129-1-pmarheine@chromium.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and examination of the kernel
codebase, I can now provide my assessment: **YES** This commit should be
backported to stable kernel trees because: 1. **Fixes a real user-facing
bug**: The commit addresses an ABI inconsistency where ACPI battery
drivers were reporting current_now with the wrong sign. According to the
kernel's power supply ABI documentation
(Documentation/ABI/testing/sysfs-class-power), `current_now` should be
negative when discharging and positive when charging, but ACPI battery
drivers were reporting positive values always. 2. **Small and contained
fix**: The change is minimal and well-contained. It only affects the
`POWER_SUPPLY_PROP_CURRENT_NOW` case in `acpi_battery_get_property()`
function in `drivers/acpi/battery.c`. The code adds a simple check to
negate the current value only when: - Property requested is
`POWER_SUPPLY_PROP_CURRENT_NOW` (not power_now) - Battery is in
discharging state - The `acpi_battery_handle_discharging()` function
confirms it's actually discharging 3. **Follows stable rules**: This is
an important bugfix that corrects userspace-visible behavior to match
documented ABI. Applications and battery monitoring tools rely on the
documented behavior that negative current indicates discharging. 4.
**Minimal regression risk**: The change is very conservative: - Only
affects `current_now`, not `power_now` (as noted in commit message) -
Uses existing `acpi_battery_handle_discharging()` logic to double-check
the discharging state - Leaves all other battery properties unchanged 5.
**Similar pattern in similar drivers**: From the historical examples
provided, commits like "power: supply: bq27xxx: fix polarity of
current_now" and "power: supply: axp20x_battery: properly report current
when discharging" were backported with YES status for exactly the same
type of issue - fixing current sign during discharge. 6. **Affects
critical subsystem**: Battery reporting is crucial for power management,
and incorrect current direction can confuse userspace tools and
potentially impact power management decisions. The commit carefully
addresses the ABI compliance issue while minimizing risk by only
changing the sign for `current_now` during confirmed discharging states,
making it an ideal candidate for stable backporting.

 drivers/acpi/battery.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f9fb092f33a26..4a188cc28b5ce 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -255,10 +255,23 @@ static int acpi_battery_get_property(struct power_supply *psy,
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
2.39.5


