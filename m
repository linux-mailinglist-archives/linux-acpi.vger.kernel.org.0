Return-Path: <linux-acpi+bounces-21561-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO87KocAr2lmLgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21561-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:16:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E97023D857
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 728943002290
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF123E8C58;
	Mon,  9 Mar 2026 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGQ66qms"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823E3E715E;
	Mon,  9 Mar 2026 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076298; cv=none; b=gPzv+cpr0fD7oNeY4gEuSnV7uVye3MtiwsKOyodFs6gBINwIqLhvedAhG/TvCfvQgFJZ1NbX2ggpi1lJA+S4l3ZeyhrZrpOgS6PgnCHM+Vl5bxmfdHixlFgLXOCRptL9mVvp5kxq+sE3spI3buYSRXmRKCMbnrctTJwbGE/2/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076298; c=relaxed/simple;
	bh=HAKaWRP+YTCtaUrWplUJK5PdjI3gm83NIBXQ8fsBmhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XszGOCW+cAUyea1+G8woAdV/EZgmZoHzCQWwfnRCWI3VMdE+b8mZGd+XJay1HAfQyXVab+YgFESFl4TQPBzeuj3yb8+QjUS/VZ0g9qguo+jBUNrgjhWX3nlp8rJGmRTpGIKtOWAW5huNBIrII6ynagO+rclbdNGgd9PRqKBGCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGQ66qms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C151C2BCAF;
	Mon,  9 Mar 2026 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773076298;
	bh=HAKaWRP+YTCtaUrWplUJK5PdjI3gm83NIBXQ8fsBmhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGQ66qmscIicNYBSilyze8eX1RAPK4nEUvlgFj3zTrXaqJsLEHEf2Xhcd5pKl4ZCv
	 06cixlKnuNnvUSbmsL/pW6xVSawJbLTBLvnU4fFhmbxUy5bArO9oveQK9h2kuayUeD
	 mEv1JmfR7n5N8U+7VDZr3V71R/sqOieng0P6FCwYGSkeTlhpCS5T8wrlou9X4ZRgYk
	 CTL5GB006HrGGzwyRd4QlNd3fz+L9s3k8tUJr/KEfGry8UFKiqkBTxPTXdk6fv9TyA
	 HkeYhkhxgF3TestlKj57JjTGyQxmPBBRjiDRLiNdWUndYkzdAbF6EH0xjexe4UBdJa
	 7x0Pma13a1asQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v2 2/5] platform/x86: fujitsu: Reorder code to avoid forward
 declarations
Date: Mon, 09 Mar 2026 18:05:18 +0100
Message-ID: <4730334.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12863082.O9o76ZdvQC@rafael.j.wysocki>
References: <12863082.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0E97023D857
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	TAGGED_FROM(0.00)[bounces-21561-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rafael.j.wysocki:mid,intel.com:email]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Move the definitions of acpi_fujitsu_bl_notify() and
acpi_fujitsu_laptop_notify() along with some helpers above
the definitions of the functions that will refer to them
after subsequent changes, to avoid having to add forward
declarations of them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/platform/x86/fujitsu-laptop.c | 216 +++++++++++++-------------
 1 file changed, 108 insertions(+), 108 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 931fbcdd21b8..1adce90ae3e6 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -500,6 +500,36 @@ static int fujitsu_backlight_register(struct acpi_device *device)
 	return 0;
 }
 
+/* Brightness notify */
+
+static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
+{
+	struct fujitsu_bl *priv = acpi_driver_data(device);
+	int oldb, newb;
+
+	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
+		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
+				 event);
+		sparse_keymap_report_event(priv->input, -1, 1, true);
+		return;
+	}
+
+	oldb = priv->brightness_level;
+	get_lcd_level(device);
+	newb = priv->brightness_level;
+
+	acpi_handle_debug(device->handle,
+			  "brightness button event [%i -> %i]\n", oldb, newb);
+
+	if (oldb == newb)
+		return;
+
+	if (!disable_brightness_adjust)
+		set_lcd_level(device, newb);
+
+	sparse_keymap_report_event(priv->input, oldb < newb, 1, true);
+}
+
 static int acpi_fujitsu_bl_add(struct acpi_device *device)
 {
 	struct fujitsu_bl *priv;
@@ -531,36 +561,6 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	return fujitsu_backlight_register(device);
 }
 
-/* Brightness notify */
-
-static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
-{
-	struct fujitsu_bl *priv = acpi_driver_data(device);
-	int oldb, newb;
-
-	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
-		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
-				 event);
-		sparse_keymap_report_event(priv->input, -1, 1, true);
-		return;
-	}
-
-	oldb = priv->brightness_level;
-	get_lcd_level(device);
-	newb = priv->brightness_level;
-
-	acpi_handle_debug(device->handle,
-			  "brightness button event [%i -> %i]\n", oldb, newb);
-
-	if (oldb == newb)
-		return;
-
-	if (!disable_brightness_adjust)
-		set_lcd_level(device, newb);
-
-	sparse_keymap_report_event(priv->input, oldb < newb, 1, true);
-}
-
 /* ACPI device for hotkey handling */
 
 static const struct key_entry keymap_default[] = {
@@ -908,6 +908,84 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	return 0;
 }
 
+static void acpi_fujitsu_laptop_press(struct acpi_device *device, int scancode)
+{
+	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	int ret;
+
+	ret = kfifo_in_locked(&priv->fifo, (unsigned char *)&scancode,
+			      sizeof(scancode), &priv->fifo_lock);
+	if (ret != sizeof(scancode)) {
+		dev_info(&priv->input->dev, "Could not push scancode [0x%x]\n",
+			 scancode);
+		return;
+	}
+	sparse_keymap_report_event(priv->input, scancode, 1, false);
+	dev_dbg(&priv->input->dev, "Push scancode into ringbuffer [0x%x]\n",
+		scancode);
+}
+
+static void acpi_fujitsu_laptop_release(struct acpi_device *device)
+{
+	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	int scancode, ret;
+
+	while (true) {
+		ret = kfifo_out_locked(&priv->fifo, (unsigned char *)&scancode,
+				       sizeof(scancode), &priv->fifo_lock);
+		if (ret != sizeof(scancode))
+			return;
+		sparse_keymap_report_event(priv->input, scancode, 0, false);
+		dev_dbg(&priv->input->dev,
+			"Pop scancode from ringbuffer [0x%x]\n", scancode);
+	}
+}
+
+static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
+{
+	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	unsigned long flags;
+	int scancode, i = 0;
+	unsigned int irb;
+
+	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
+		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
+				 event);
+		sparse_keymap_report_event(priv->input, -1, 1, true);
+		return;
+	}
+
+	if (priv->flags_supported)
+		priv->flags_state = call_fext_func(device, FUNC_FLAGS, 0x4, 0x0,
+						   0x0);
+
+	while ((irb = call_fext_func(device,
+				     FUNC_BUTTONS, 0x1, 0x0, 0x0)) != 0 &&
+	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE) {
+		scancode = irb & 0x4ff;
+		if (sparse_keymap_entry_from_scancode(priv->input, scancode))
+			acpi_fujitsu_laptop_press(device, scancode);
+		else if (scancode == 0)
+			acpi_fujitsu_laptop_release(device);
+		else
+			acpi_handle_info(device->handle,
+					 "Unknown GIRB result [%x]\n", irb);
+	}
+
+	/*
+	 * First seen on the Skylake-based Lifebook E736/E746/E756), the
+	 * touchpad toggle hotkey (Fn+F4) is handled in software. Other models
+	 * have since added additional "soft keys". These are reported in the
+	 * status flags queried using FUNC_FLAGS.
+	 */
+	if (priv->flags_supported & (FLAG_SOFTKEYS)) {
+		flags = call_fext_func(device, FUNC_FLAGS, 0x1, 0x0, 0x0);
+		flags &= (FLAG_SOFTKEYS);
+		for_each_set_bit(i, &flags, BITS_PER_LONG)
+			sparse_keymap_report_event(priv->input, BIT(i), 1, true);
+	}
+}
+
 static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv;
@@ -1001,84 +1079,6 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
 	kfifo_free(&priv->fifo);
 }
 
-static void acpi_fujitsu_laptop_press(struct acpi_device *device, int scancode)
-{
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
-	int ret;
-
-	ret = kfifo_in_locked(&priv->fifo, (unsigned char *)&scancode,
-			      sizeof(scancode), &priv->fifo_lock);
-	if (ret != sizeof(scancode)) {
-		dev_info(&priv->input->dev, "Could not push scancode [0x%x]\n",
-			 scancode);
-		return;
-	}
-	sparse_keymap_report_event(priv->input, scancode, 1, false);
-	dev_dbg(&priv->input->dev, "Push scancode into ringbuffer [0x%x]\n",
-		scancode);
-}
-
-static void acpi_fujitsu_laptop_release(struct acpi_device *device)
-{
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
-	int scancode, ret;
-
-	while (true) {
-		ret = kfifo_out_locked(&priv->fifo, (unsigned char *)&scancode,
-				       sizeof(scancode), &priv->fifo_lock);
-		if (ret != sizeof(scancode))
-			return;
-		sparse_keymap_report_event(priv->input, scancode, 0, false);
-		dev_dbg(&priv->input->dev,
-			"Pop scancode from ringbuffer [0x%x]\n", scancode);
-	}
-}
-
-static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
-{
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
-	unsigned long flags;
-	int scancode, i = 0;
-	unsigned int irb;
-
-	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
-		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
-				 event);
-		sparse_keymap_report_event(priv->input, -1, 1, true);
-		return;
-	}
-
-	if (priv->flags_supported)
-		priv->flags_state = call_fext_func(device, FUNC_FLAGS, 0x4, 0x0,
-						   0x0);
-
-	while ((irb = call_fext_func(device,
-				     FUNC_BUTTONS, 0x1, 0x0, 0x0)) != 0 &&
-	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE) {
-		scancode = irb & 0x4ff;
-		if (sparse_keymap_entry_from_scancode(priv->input, scancode))
-			acpi_fujitsu_laptop_press(device, scancode);
-		else if (scancode == 0)
-			acpi_fujitsu_laptop_release(device);
-		else
-			acpi_handle_info(device->handle,
-					 "Unknown GIRB result [%x]\n", irb);
-	}
-
-	/*
-	 * First seen on the Skylake-based Lifebook E736/E746/E756), the
-	 * touchpad toggle hotkey (Fn+F4) is handled in software. Other models
-	 * have since added additional "soft keys". These are reported in the
-	 * status flags queried using FUNC_FLAGS.
-	 */
-	if (priv->flags_supported & (FLAG_SOFTKEYS)) {
-		flags = call_fext_func(device, FUNC_FLAGS, 0x1, 0x0, 0x0);
-		flags &= (FLAG_SOFTKEYS);
-		for_each_set_bit(i, &flags, BITS_PER_LONG)
-			sparse_keymap_report_event(priv->input, BIT(i), 1, true);
-	}
-}
-
 /* Initialization */
 
 static const struct acpi_device_id fujitsu_bl_device_ids[] = {
-- 
2.51.0





