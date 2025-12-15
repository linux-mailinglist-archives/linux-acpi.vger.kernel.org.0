Return-Path: <linux-acpi+bounces-19583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69308CBE37E
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7FC33026BEE
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809D3370EC;
	Mon, 15 Dec 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIm/gbek"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE23336EFF;
	Mon, 15 Dec 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807466; cv=none; b=i7aInFCJzgUIqLshfK1OfzkElv57UfLRJGx6+OQ+GgdhYGhD/6KpvEC/33vhUM6bdYjTHhkKYqyEMTJeoPzQcGRBDQ3cSBPSm5GuUqj7c3OzI3G5o/A6NrB5XizpHHa4E9UNkVTO8vbyGDyGR0YWjpcedY8owrYyUOv92Ca3mEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807466; c=relaxed/simple;
	bh=Xkq/kysYSxD7x1QSgo1sORs5P631danxBCYMdS8cfrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UF5vUcDYx6qAYlZ3t8Kj9wihLH0KiwAfI/RvAcFGKoX2G4EJ/Vb3ormxzV1Ghqb+7EI2sWBLUbzEveDooCCHJ5sw90AKvtK0SwwDejLJtqQBq2jRDKRbkJk07mvtHc5Oh9JjcDJN5PexEehzELAlAjefIHtcTd32+bvjHw++1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIm/gbek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAD7C19422;
	Mon, 15 Dec 2025 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807466;
	bh=Xkq/kysYSxD7x1QSgo1sORs5P631danxBCYMdS8cfrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIm/gbekh+I46KujjWWjrUTg+23Orb+UXr9Ii1/ZwX3PgDHPP9MInICpr8tLQPADa
	 lBfkOwBUqBfsFEUIwlH4TMHUXrB5+uoa0MCfc8dlEWDKi8VUWcAcJLfk87OiGiCqQH
	 rZvfFrEkwRzaIupNlNBZS0otZ2IScbOf+xRz1N9G84A0lelM1/ZTllTqpQFxEO0iF8
	 259aK6rF7Rg7rFgJzqtf3JMex29NHHrkOBdhSkJFXXqw3Qc1btSNhaNmpZF+59aCZ0
	 lGiW975gymScapEtyzj9TR/GRI7FYBw6n3QKu0Cjc9GVryjtvqE3O5txHoJxdlNkow
	 AZS54uIQw3JuQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v2 03/10] ACPI: button: Adjust event notification routines
Date: Mon, 15 Dec 2025 14:55:09 +0100
Message-ID: <2260995.Icojqenx9y@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2685338.Lt9SDvczpP@rafael.j.wysocki>
References: <2685338.Lt9SDvczpP@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Adjust the event notification routines in the ACPI button driver to
take a struct acpi_button pointer as an argument istead of a struct
acpi_device one where applicable, which allows the use of
acpi_driver_data() to be limited and will facilitate subsequent
changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/acpi/button.c |   67 ++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -169,6 +169,7 @@ static struct acpi_driver acpi_button_dr
 };
 
 struct acpi_button {
+	struct acpi_device *adev;
 	unsigned int type;
 	struct input_dev *input;
 	char phys[32];			/* for input device */
@@ -202,9 +203,9 @@ static int acpi_lid_evaluate_state(struc
 	return lid_state ? 1 : 0;
 }
 
-static int acpi_lid_notify_state(struct acpi_device *device, int state)
+static int acpi_lid_notify_state(struct acpi_button *button, int state)
 {
-	struct acpi_button *button = acpi_driver_data(device);
+	struct acpi_device *device = button->adev;
 	ktime_t next_report;
 	bool do_update;
 
@@ -287,18 +288,18 @@ static int acpi_lid_notify_state(struct
 static int __maybe_unused acpi_button_state_seq_show(struct seq_file *seq,
 						     void *offset)
 {
-	struct acpi_device *device = seq->private;
+	struct acpi_button *button = seq->private;
 	int state;
 
-	state = acpi_lid_evaluate_state(device);
+	state = acpi_lid_evaluate_state(button->adev);
 	seq_printf(seq, "state:      %s\n",
 		   state < 0 ? "unsupported" : (state ? "open" : "closed"));
 	return 0;
 }
 
-static int acpi_button_add_fs(struct acpi_device *device)
+static int acpi_button_add_fs(struct acpi_button *button)
 {
-	struct acpi_button *button = acpi_driver_data(device);
+	struct acpi_device *device = button->adev;
 	struct proc_dir_entry *entry = NULL;
 	int ret = 0;
 
@@ -333,7 +334,7 @@ static int acpi_button_add_fs(struct acp
 	/* create /proc/acpi/button/lid/LID/state */
 	entry = proc_create_single_data(ACPI_BUTTON_FILE_STATE, S_IRUGO,
 			acpi_device_dir(device), acpi_button_state_seq_show,
-			device);
+			button);
 	if (!entry) {
 		ret = -ENODEV;
 		goto remove_dev_dir;
@@ -355,9 +356,9 @@ remove_button_dir:
 	goto done;
 }
 
-static int acpi_button_remove_fs(struct acpi_device *device)
+static int acpi_button_remove_fs(struct acpi_button *button)
 {
-	struct acpi_button *button = acpi_driver_data(device);
+	struct acpi_device *device = button->adev;
 
 	if (button->type != ACPI_BUTTON_TYPE_LID)
 		return 0;
@@ -385,9 +386,10 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
-static int acpi_lid_update_state(struct acpi_device *device,
+static int acpi_lid_update_state(struct acpi_button *button,
 				 bool signal_wakeup)
 {
+	struct acpi_device *device = button->adev;
 	int state;
 
 	state = acpi_lid_evaluate_state(device);
@@ -397,19 +399,17 @@ static int acpi_lid_update_state(struct
 	if (state && signal_wakeup)
 		acpi_pm_wakeup_event(&device->dev);
 
-	return acpi_lid_notify_state(device, state);
+	return acpi_lid_notify_state(button, state);
 }
 
-static void acpi_lid_initialize_state(struct acpi_device *device)
+static void acpi_lid_initialize_state(struct acpi_button *button)
 {
-	struct acpi_button *button = acpi_driver_data(device);
-
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
-		(void)acpi_lid_notify_state(device, 1);
+		(void)acpi_lid_notify_state(button, 1);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device, false);
+		(void)acpi_lid_update_state(button, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
@@ -421,8 +421,8 @@ static void acpi_lid_initialize_state(st
 
 static void acpi_lid_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_button *button;
+	struct acpi_button *button = data;
+	struct acpi_device *device = button->adev;
 
 	if (event != ACPI_BUTTON_NOTIFY_STATUS) {
 		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
@@ -430,17 +430,16 @@ static void acpi_lid_notify(acpi_handle
 		return;
 	}
 
-	button = acpi_driver_data(device);
 	if (!button->lid_state_initialized)
 		return;
 
-	acpi_lid_update_state(device, true);
+	acpi_lid_update_state(button, true);
 }
 
 static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_button *button;
+	struct acpi_button *button = data;
+	struct acpi_device *device = button->adev;
 	struct input_dev *input;
 	int keycode;
 
@@ -457,7 +456,6 @@ static void acpi_button_notify(acpi_hand
 
 	acpi_pm_wakeup_event(&device->dev);
 
-	button = acpi_driver_data(device);
 	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
 		return;
 
@@ -505,7 +503,7 @@ static int acpi_button_resume(struct dev
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		button->last_state = !!acpi_lid_evaluate_state(device);
 		button->last_time = ktime_get();
-		acpi_lid_initialize_state(device);
+		acpi_lid_initialize_state(button);
 	}
 
 	if (button->type == ACPI_BUTTON_TYPE_POWER) {
@@ -521,12 +519,12 @@ static int acpi_button_resume(struct dev
 
 static int acpi_lid_input_open(struct input_dev *input)
 {
-	struct acpi_device *device = input_get_drvdata(input);
-	struct acpi_button *button = acpi_driver_data(device);
+	struct acpi_button *button = input_get_drvdata(input);
+	struct acpi_device *device = button->adev;
 
 	button->last_state = !!acpi_lid_evaluate_state(device);
 	button->last_time = ktime_get();
-	acpi_lid_initialize_state(device);
+	acpi_lid_initialize_state(button);
 
 	return 0;
 }
@@ -551,6 +549,7 @@ static int acpi_button_add(struct acpi_d
 
 	device->driver_data = button;
 
+	button->adev = device;
 	button->input = input = input_allocate_device();
 	if (!input) {
 		error = -ENOMEM;
@@ -587,7 +586,7 @@ static int acpi_button_add(struct acpi_d
 	}
 
 	if (!error)
-		error = acpi_button_add_fs(device);
+		error = acpi_button_add_fs(button);
 
 	if (error) {
 		input_free_device(input);
@@ -617,7 +616,7 @@ static int acpi_button_add(struct acpi_d
 		break;
 	}
 
-	input_set_drvdata(input, device);
+	input_set_drvdata(input, button);
 	error = input_register_device(input);
 	if (error) {
 		input_free_device(input);
@@ -628,17 +627,17 @@ static int acpi_button_add(struct acpi_d
 	case ACPI_BUS_TYPE_POWER_BUTTON:
 		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 							  acpi_button_event,
-							  device);
+							  button);
 		break;
 	case ACPI_BUS_TYPE_SLEEP_BUTTON:
 		status = acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
 							  acpi_button_event,
-							  device);
+							  button);
 		break;
 	default:
 		status = acpi_install_notify_handler(device->handle,
 						     ACPI_ALL_NOTIFY, handler,
-						     device);
+						     button);
 		break;
 	}
 	if (ACPI_FAILURE(status)) {
@@ -661,7 +660,7 @@ static int acpi_button_add(struct acpi_d
 err_input_unregister:
 	input_unregister_device(input);
 err_remove_fs:
-	acpi_button_remove_fs(device);
+	acpi_button_remove_fs(button);
 err_free_button:
 	kfree(button);
 	return error;
@@ -689,7 +688,7 @@ static void acpi_button_remove(struct ac
 	}
 	acpi_os_wait_events_complete();
 
-	acpi_button_remove_fs(device);
+	acpi_button_remove_fs(button);
 	input_unregister_device(button->input);
 	kfree(button);
 }




