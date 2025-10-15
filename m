Return-Path: <linux-acpi+bounces-17800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3CABDED95
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCE694F2476
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67501215191;
	Wed, 15 Oct 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9eH3Psf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B921DFDE;
	Wed, 15 Oct 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536364; cv=none; b=Kd8oYuo43qx56qO2L4UR7HH7Uk9slh1+voaWjLp+q2Y8DFhQc99fo7GyGpVebbA0Q4Vv0KMDAsqKjYF6GTpWcdGto6R5JJTOcx56QG4nKDG6ljJEjGnA8bl4BZIbCt/W+GbbVmiQ5olbpTSDShq/j49Xyc5Hw6LLGMrz3JOA6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536364; c=relaxed/simple;
	bh=ZMrcUqe/Ku7o/Ga2BSfmbV7M+s2uYpQdP8XaXS6+hSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uMUmrr1VTdfZXSCenw5i2b2/fk4t01gz+fHy01NjuW5c2IdcUE1nwRhKHLR7pV4WCexQ6699M/cxjDleiFJXIVed8ivskM2RlUldIVAlcO54O+N4jgEu+5ZnDZVe50uyhr35pKh/SUoM8RYa0nVQT/RnzuPywyrmBa7YHBislYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9eH3Psf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72935C4CEF8;
	Wed, 15 Oct 2025 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760536363;
	bh=ZMrcUqe/Ku7o/Ga2BSfmbV7M+s2uYpQdP8XaXS6+hSA=;
	h=From:To:Cc:Subject:Date:From;
	b=S9eH3PsfITfWsw0IME1RDORHyzdh3MtkMWECe+ufH+j+hOY3XfGPWIC1zelg69BSE
	 KSZcHWo3AXJK0+KZkwiZ5N/lwRGvxuvOcQzSBxFNd/GYJibelhG1cUfFaRnF64SCVL
	 ryCu/p64jrjHIubYH/yF8fzI0599VMOX4qpo5l6VURhUg607sHOdibXQvMedbvqx6I
	 WZlAaUpGeigBTuPMNGfAu3pLUo+uq/WwlxM0hrRMVVsyVoTfkDVFtLHiIEbSH2gQRa
	 eVNkmj/l8vy+5VJJy30n780VGiaJI/cCmG3XCwybKhTGHbM1qV5pPv1y8bkXkTrRas
	 Io/HDFEuEWMKw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] ACPI: battery: Drop redundant locking
Date: Wed, 15 Oct 2025 15:52:41 +0200
Message-ID: <2344462.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All of the evaluations of objects in the ACPI namespace are carried out
under the namespace lock and interpreter lock in ACPICA, so it is not
necessary to put any additional locks around them for synchronization.

However, the ACPI battery driver does just that, so remove the
redundant locking around ACPI object evaluation from it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -91,7 +91,6 @@ enum {
 };
 
 struct acpi_battery {
-	struct mutex lock;
 	struct mutex update_lock;
 	struct power_supply *bat;
 	struct power_supply_desc bat_desc;
@@ -535,11 +534,9 @@ static int acpi_battery_get_info(struct
 		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 		acpi_status status = AE_ERROR;
 
-		mutex_lock(&battery->lock);
 		status = acpi_evaluate_object(battery->device->handle,
 					      use_bix ? "_BIX":"_BIF",
 					      NULL, &buffer);
-		mutex_unlock(&battery->lock);
 
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(battery->device->handle,
@@ -576,11 +573,8 @@ static int acpi_battery_get_state(struct
 			msecs_to_jiffies(cache_time)))
 		return 0;
 
-	mutex_lock(&battery->lock);
 	status = acpi_evaluate_object(battery->device->handle, "_BST",
 				      NULL, &buffer);
-	mutex_unlock(&battery->lock);
-
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_info(battery->device->handle,
 				 "_BST evaluation failed: %s",
@@ -628,11 +622,8 @@ static int acpi_battery_set_alarm(struct
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
 
-	mutex_lock(&battery->lock);
 	status = acpi_execute_simple_method(battery->device->handle, "_BTP",
 					    battery->alarm);
-	mutex_unlock(&battery->lock);
-
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -1235,9 +1226,6 @@ static int acpi_battery_add(struct acpi_
 	strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
-	result = devm_mutex_init(&device->dev, &battery->lock);
-	if (result)
-		return result;
 
 	result = devm_mutex_init(&device->dev, &battery->update_lock);
 	if (result)




