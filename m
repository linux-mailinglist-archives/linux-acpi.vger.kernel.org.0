Return-Path: <linux-acpi+bounces-21018-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOL4DklWmGncGQMAu9opvQ
	(envelope-from <linux-acpi+bounces-21018-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 13:40:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 993611678CF
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 13:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E53A730A455D
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290A3446CB;
	Fri, 20 Feb 2026 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muJ0LUUE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8653451A9;
	Fri, 20 Feb 2026 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591094; cv=none; b=GdSnUO64JgKi2uVsFvqeIqvQMLmy1ZDcWhrZCZ6sS/oTYvnZpCywOVtpxmsDnJCzw76PoP69QJ4cqyQOXsPAC1mGycGZ+6JO+419ZAVIg/BJTvLGR14vJxuqanvUdyJPJuyljSSjjTlA6p0C7LRQMrq+Wgh3q4U9qoU/CCZ+wSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591094; c=relaxed/simple;
	bh=ZjuULHlzQuAgtwtu1i/dIHEtQred4jaY0d+Ndi+RozY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZxFLIbMtfrIc4bQBAGeUIu3VqhBx6JNIv4pQd/wHPF8SNaSJVTYcE6nPaelHzUI9E3uQlN9zCuxS6eVkrlyZ7kZzxznZuZPxdodYjEMDTjGun1crdGToc/wc0Fb77/0NoBglXiuH/hfRMP/8oSePFEOezWt9mDRHw0yTeQGtzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muJ0LUUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F42C116D0;
	Fri, 20 Feb 2026 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771591094;
	bh=ZjuULHlzQuAgtwtu1i/dIHEtQred4jaY0d+Ndi+RozY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=muJ0LUUEqLQHdGPw35/9F+Jonu++NHAWi9MChVKsQ1xGMI53iPPW0AybYzi5trjv7
	 3E2pZmnsZy+GwM2fjsKW4/sKkmXGKErLTPZAoglnsbLDW/mRZORtibFl8OaNjvNPIZ
	 fXUWSD9wCdKJmV2R8wzPYYscnZapEWxyCp+h5d69sVJrqVlOtA/yLsYMQyS7f/YlOL
	 Ed2Hfs2hL6LcnzoyIAeYD6w/chwO4jZCRhbFwq07n7NpYRtXzNPpG8GYZht6QOUFLY
	 RKMgEMoJH5EobRRDm9cQ+EEoJMl4/asUrU6uz/x4Jc/216oSmTIPYlEiem1j/+LwNO
	 H4UefiXiOrA9Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yauhen Kharuzhy <jekhor@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] ACPI: x86: Force enabling of PWM2 on the Yogabook YB1-X90
Date: Fri, 20 Feb 2026 07:37:54 -0500
Message-ID: <20260220123805.3371698-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220123805.3371698-1-sashal@kernel.org>
References: <20260220123805.3371698-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21018-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 993611678CF
X-Rspamd-Action: no action

From: Yauhen Kharuzhy <jekhor@gmail.com>

[ Upstream commit a8c975302868c716afef0f50467bebbd069a35b8 ]

The PWM2 on YB1-X90 tablets is used for keyboard backlight control but
it is disabled in the ACPI DSDT table. Add it to the override_status_ids
list to allow keyboard function control driver
(drivers/platform/x86/lenovo/yogabook.c) to use it.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Link: https://patch.msgid.link/20260211222242.4101162-1-jekhor@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a comprehensive picture. Let me analyze this commit.

## Analysis

### 1. Commit Message Analysis

The commit adds an entry to the `override_status_ids` list in
`drivers/acpi/x86/utils.c` to force-enable the PWM2 ACPI device on
Lenovo Yoga Book YB1-X90 tablets. The PWM2 is used for keyboard
backlight control but is disabled in the ACPI DSDT table. Without this
override, the yogabook platform driver cannot control the keyboard
backlight.

### 2. Code Change Analysis

The change is a straightforward addition of a `PRESENT_ENTRY_HID` entry
to the existing quirk table. It:
- Targets HID `"80862289"` (Intel Cherry Trail PWM), UID `"2"` (PWM2
  specifically)
- Scopes to `INTEL_ATOM_AIRMONT` CPU platform (Cherry Trail)
- Narrows with 3 DMI_EXACT_MATCH entries specific to the Yoga Book
  Android variant (YETI-11)
- This is the exact same pattern as the existing Xiaomi Mi Pad 2 entry
  (lines 78-82) which also enables PWM2 for touchkey backlight control

The change is ~12 lines including the comment. It follows an
established, well-understood pattern that's been used in this file for
years.

### 3. Classification: Hardware Quirk

This is a **hardware quirk/workaround** — one of the explicitly allowed
exception categories for stable backports. The device has broken ACPI
firmware (DSDT disables a needed device), and this quirk works around it
by forcing the device present.

### 4. Scope and Risk Assessment

- **Very small change**: ~12 lines added to a data table
- **Zero risk to other hardware**: The DMI_EXACT_MATCH conditions ensure
  this only triggers on the exact Lenovo Yoga Book YB1-X90 (YETI-11
  variant)
- **Well-tested pattern**: Identical to the Xiaomi Mi Pad 2 entry that's
  been in the kernel since v4.18
- **No code logic changes**: Only adds data to an existing table

### 5. Dependencies

The change depends on:
- The `override_status_ids` mechanism — present since at least v4.x
- The yogabook platform driver
  (`drivers/platform/x86/lenovo/yogabook.c`) — added in v6.6 via commit
  `6df1523fa0b79`
- The keyboard backlight support in the platform driver — added in v6.6
  via commit `fc4f1d88bc6b1`

The prerequisite code exists in all current stable trees (6.6+). The
file path changed recently (moved to `lenovo/` subdirectory in commit
`651b57dd40871`), so older stable trees may need minor context
adjustment, but the data-table addition itself is trivially portable.

### 6. User Impact

Without this quirk, the keyboard backlight on Lenovo Yoga Book YB1-X90
tablets doesn't work under Linux. This is a real hardware enablement
issue for a specific consumer tablet.

### 7. Stable Suitability

- **Obviously correct**: Follows the exact same pattern as existing
  entries
- **Fixes a real issue**: Keyboard backlight doesn't work without it
- **Small and contained**: Data-only addition to a quirk table
- **No new features**: Enables existing functionality on specific
  hardware
- **No new APIs**: Pure internal quirk

### Verification

- Verified `fc4f1d88bc6b1` (keyboard backlight platform driver) is in
  v6.6 via `git merge-base --is-ancestor`
- Verified `6df1523fa0b79` (platform driver support) is in v6.6 via `git
  merge-base --is-ancestor`
- Verified `1a1e7540cf501` (ACPI quirk for i2c clients) is in v6.6 via
  `git merge-base --is-ancestor`
- Verified the existing Xiaomi Mi Pad 2 PWM2 entry (`b72cd8e0fa34d`) is
  in v6.6 via `git merge-base --is-ancestor`, confirming the
  infrastructure exists
- Read `drivers/acpi/x86/utils.c` lines 55-104 to confirm the existing
  code structure and similar entries
- Confirmed via git log that the commit `a8c975302868c` exists and
  matches the described change
- The agent exploration confirmed the yogabook platform driver at
  `drivers/platform/x86/lenovo/yogabook.c` uses `devm_pwm_get(dev,
  "pwm_soc_lpss_2")` at line 488, which is the PWM2 device being enabled
  by this quirk

This is a textbook hardware quirk addition — small, safe, DMI-scoped to
one specific device, follows an established pattern, and enables real
hardware functionality for users. It meets all stable kernel criteria.

**YES**

 drivers/acpi/x86/utils.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4ee30c2897a2b..418951639f511 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -81,6 +81,18 @@ static const struct override_status_id override_status_ids[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 	      }),
 
+	/*
+	 * Lenovo Yoga Book uses PWM2 for touch keyboard backlight control.
+	 * It needs to be enabled only for the Android device version (YB1-X90*
+	 * aka YETI-11); the Windows version (YB1-X91*) uses ACPI control
+	 * methods.
+	 */
+	PRESENT_ENTRY_HID("80862289", "2", INTEL_ATOM_AIRMONT, {
+		DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+		DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+		DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+	      }),
+
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
-- 
2.51.0


