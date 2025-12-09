Return-Path: <linux-acpi+bounces-19509-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77853CB0248
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 15:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB516301EF20
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367B299943;
	Tue,  9 Dec 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQpCroJn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B7288C81;
	Tue,  9 Dec 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288848; cv=none; b=Bq/xXb6qpDnZpfLny9BfEiRfX8D/DGa4WT7Dou+qeylYxpvMJkYKSQLCv9idKIGjvaDdqcF+uzLPcHJQFFdGbvHLSAWYhsQw5U8TCwogj6kCGauqvl0+p/wDxZUY3mzc/zk/+HAHom5BkSkE/f1wNJAtKE8I8/yCF+jHs2I1pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288848; c=relaxed/simple;
	bh=vQ9cr9QNOIQjCRO2HKwu2PRBsLPRapCi7ScUcLLarWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfnsqFDCBXufT1IZ54KByWHkr7D3k1dzKYmZVEZyaoRn/jUyLVe5bvu1kv7dxCw176mMThsxGO+9btfVQLEGxNgHJculjZKP/96ACQFPLD/tQz643C8f9IcOSuk9c8trXBe0whSpvydyGhjks1MKsVkYWuS8JI5TgOvAyH5qToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQpCroJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60F1C113D0;
	Tue,  9 Dec 2025 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288848;
	bh=vQ9cr9QNOIQjCRO2HKwu2PRBsLPRapCi7ScUcLLarWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQpCroJnSV5v6RsCFMnhar4f1p/vZPj8Re4RhUKwbUAIEpI2xDLUCxzY2SzWm5kZn
	 V7WZ5rh4fskF4U7qU1mh8PhMJ3rRHmz2IFkxsT8TT3xvdaro/6BTBaWr0faGQ8w84z
	 IXInWFWYUaOQopV7JIJbcB92/A1ewcziRK4/e0rON9fyK+KOfvwzJvIk4qsBMHN4n4
	 oempo3DUslTR0/q7HaE8/eRpROG+wOPDGzaSX0Uhs5Wu2XSPytya0zkbKE5Yw3Cxax
	 2nc0BxQLt8s/I8goZYdDA+7D3008E8LrLxVLHwmcY2VUuFzpOiKLZ8ywx5fsX1Qgck
	 E9pOfeqlnyXhQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 08/10] ACPI: battery: Adjust event notification routine
Date: Tue, 09 Dec 2025 14:57:41 +0100
Message-ID: <1996647.taCxCBeP46@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2339822.iZASKD2KPV@rafael.j.wysocki>
References: <2339822.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Adjust acpi_battery_notify() to cast its "data" argument to a struct
acpi_battery pointer instead of a struct acpi_device one, which allows
the use of acpi_driver_data() to be limited and will facilitate
subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1054,8 +1054,8 @@ static void acpi_battery_refresh(struct
 /* Driver Interface */
 static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_battery *battery = acpi_driver_data(device);
+	struct acpi_battery *battery = data;
+	struct acpi_device *device = battery->device;
 	struct power_supply *old;
 
 	if (!battery)
@@ -1249,7 +1249,7 @@ static int acpi_battery_add(struct acpi_
 	device_init_wakeup(&device->dev, 1);
 
 	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_battery_notify, device);
+						 acpi_battery_notify, battery);
 	if (result)
 		goto fail_pm;
 




