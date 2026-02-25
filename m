Return-Path: <linux-acpi+bounces-21172-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBFdA4Jjn2lRagQAu9opvQ
	(envelope-from <linux-acpi+bounces-21172-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 22:02:58 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EA619D8F8
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 22:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68FDE3073F4E
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06AB30F94B;
	Wed, 25 Feb 2026 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNB2/pnI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9202DC789;
	Wed, 25 Feb 2026 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053067; cv=none; b=JYhSHZYXUiSHFHpsC19T2z27Hu9XSKCfZscgDWjiNRKOn5a9yW3skHEPfNUkl4Pw/9yS6YkXBBjd6raHiWxuxo1eVs2nPtUk869sOfaAP74jA3Qlz5Ei3UOGDxz7CwgIROP2AbXMTCaxl+U9dB8s6IJOlra/c7oiUsTsmgfMQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053067; c=relaxed/simple;
	bh=IMfE0cfOnKIywR8ATEzDFw/vfR6sHCczmZkkkucB69o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4Qjfdod8HXP3cuQUXycQQlFbu6TcF4YY5a5pwJ0d9JZ4JY/QN9xxUAoA4T1IRc1B6sW95rEn+de0L2gkTTaZU/UIqkMj9oJ5QJx+whbmc8VM98TNR0bScEKUc4MBK7wKHY/fyAFRP7eTKbOcNnijh0x4vN7w4yWO6V33LrnX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNB2/pnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAE4C19422;
	Wed, 25 Feb 2026 20:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772053067;
	bh=IMfE0cfOnKIywR8ATEzDFw/vfR6sHCczmZkkkucB69o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNB2/pnIGAcLCPEHvNIKw0REyqkPG39Vf8dRwJ8zofsUzX2BUz9maGF+epFnXklXT
	 +x0yZGJyI6i11TIukdv4q2POszo2HBo1Ria9GueF8qLYOgP6mIElz20ycaPtnMRQWc
	 RIyCQlzkjnNEFGnqwEgvyzSye2ILqSYN98b0jDjNmJzx29fYj1mXPlnxaUH0LRRWru
	 iwjGRwURiJrFMDj3pKYvYSVE4riWmt6c0mrQxBnYRt1/+231tePTCUqG7ue6+LzuZp
	 MmCt1Ms0l/A4rS1blz2+pxK8DYaRaQIEiJs/ljQF8pXmESW6rCaAbhdTeMTeAyJQF8
	 lCZ5BaVaZrtcA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v1 2/5] platform/x86: fujitsu: Reorder code to avoid forward
 declarations
Date: Wed, 25 Feb 2026 21:43:52 +0100
Message-ID: <3418006.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <1968442.tdWV9SEqCh@rafael.j.wysocki>
References: <1968442.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-21172-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-acpi];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,10.30.226.201:query timed out,2600:3c0a:e001:db::12fc:5321:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: A0EA619D8F8
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





