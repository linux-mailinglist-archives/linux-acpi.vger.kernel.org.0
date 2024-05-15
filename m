Return-Path: <linux-acpi+bounces-5847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E76C8C6CEE
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 21:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9D0B2161B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908915ADA4;
	Wed, 15 May 2024 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="wCPatG3A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87AF3BBEA;
	Wed, 15 May 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802294; cv=none; b=Fjbna76cFgE8nWaWtld77SYBgOL6EFrViX6tkp1hEN3UWHAc4g88JnMm3LOinv1RsyOmp4lS6cbGC4F+EquRXSPAA7lfGo5Rn3qjYVsOa9sJMs41Fc4EJ4y9bsE7OnZnn+PgfP7rkcsglBg0f39fNCrP0SZ+gukH4QMYEHJ014Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802294; c=relaxed/simple;
	bh=Ky8hZAwsZSe40oI2qnfiBQS5VZELG1bjpD5an4EKILM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwqNCMgNCVfjGiVtgobzSGCMW2TVzwf5BOhIzyp/8YiQ8qSOkNcDgXUKZhJswyaT46U5GybH91uHIcp6JMZ0UnsxKY7UPtBT71nDwbD4pYq1/NPfZd6U2Nd98WGw6U16CWiyUwwXmfOvI0oPZw7iRx2XWHavc0Y8hDuYDG6cIyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=wCPatG3A reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id b5439ae811171418; Wed, 15 May 2024 21:44:44 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CD20B7F3A73;
	Wed, 15 May 2024 21:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715802284;
	bh=Ky8hZAwsZSe40oI2qnfiBQS5VZELG1bjpD5an4EKILM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wCPatG3AF5YFzy+D1rXEI9VG/YjPnB7XVwcjZTKsXXesLakcGiJzJclOkmp0xGhzh
	 3Ra9SulVylnkUv65VuM+cX4EEBQpI9AWyC0eOtX9Iho6AMVzoSuOIsAePm0eqMC6bm
	 WTNm8fErdHI3s4ymBdlc4bx3CYKMt48hyPxVI/psAK+ognhdOJR18ekVk9s9CTlxWn
	 TUudQYYliG8t7ud1NRwNRq+3ePyF00WtlYyLwCyX3DpsLBa7GU0vhdaBVu4BMezPrD
	 HPcRufLKh/elg1ceZ6w/g7GDNKqfE+qs4S/nqcvQsXMTbi2v72dfDjWoyghoOtmIsA
	 ZNHRehWduGaHg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject:
 [PATCH v2 2/2] platform/x86: wmi: Remove custom EC address space handler
Date: Wed, 15 May 2024 21:43:54 +0200
Message-ID: <1887981.tdWV9SEqCh@kreacher>
In-Reply-To: <12437901.O9o76ZdvQC@kreacher>
References: <12437901.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhm
 pdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopeifpggrrhhmihhnsehgmhigrdguvg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The custom EC address space handler in the WMI driver was only needed
because the EC driver did not install its address space handler for
EC operation regions beyond the EC device scope in the ACPI namespace.

That has just changed, so the custom EC address handler is not needed
any more and it can be removed.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Add R-by tags from Heikki and Armin.

Note that this is on top of acpi-6.9-rc1, so it may need to be rebased
before applying.

---
 drivers/platform/x86/wmi.c |   62 ---------------------------------------------
 1 file changed, 62 deletions(-)

Index: linux-pm/drivers/platform/x86/wmi.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/wmi.c
+++ linux-pm/drivers/platform/x86/wmi.c
@@ -1153,47 +1153,6 @@ static int parse_wdg(struct device *wmi_
 	return 0;
 }
 
-/*
- * WMI can have EmbeddedControl access regions. In which case, we just want to
- * hand these off to the EC driver.
- */
-static acpi_status
-acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
-			  u32 bits, u64 *value,
-			  void *handler_context, void *region_context)
-{
-	int result = 0;
-	u8 temp = 0;
-
-	if ((address > 0xFF) || !value)
-		return AE_BAD_PARAMETER;
-
-	if (function != ACPI_READ && function != ACPI_WRITE)
-		return AE_BAD_PARAMETER;
-
-	if (bits != 8)
-		return AE_BAD_PARAMETER;
-
-	if (function == ACPI_READ) {
-		result = ec_read(address, &temp);
-		*value = temp;
-	} else {
-		temp = 0xff & *value;
-		result = ec_write(address, temp);
-	}
-
-	switch (result) {
-	case -EINVAL:
-		return AE_BAD_PARAMETER;
-	case -ENODEV:
-		return AE_NOT_FOUND;
-	case -ETIME:
-		return AE_TIME;
-	default:
-		return AE_OK;
-	}
-}
-
 static int wmi_get_notify_data(struct wmi_block *wblock, union acpi_object **obj)
 {
 	struct acpi_buffer data = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1308,14 +1267,6 @@ static void acpi_wmi_remove_notify_handl
 	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi_wmi_notify_handler);
 }
 
-static void acpi_wmi_remove_address_space_handler(void *data)
-{
-	struct acpi_device *acpi_device = data;
-
-	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_EC,
-					  &acpi_wmi_ec_space_handler);
-}
-
 static void acpi_wmi_remove_bus_device(void *data)
 {
 	struct device *wmi_bus_dev = data;
@@ -1347,19 +1298,6 @@ static int acpi_wmi_probe(struct platfor
 
 	dev_set_drvdata(&device->dev, wmi_bus_dev);
 
-	status = acpi_install_address_space_handler(acpi_device->handle,
-						    ACPI_ADR_SPACE_EC,
-						    &acpi_wmi_ec_space_handler,
-						    NULL, NULL);
-	if (ACPI_FAILURE(status)) {
-		dev_err(&device->dev, "Error installing EC region handler\n");
-		return -ENODEV;
-	}
-	error = devm_add_action_or_reset(&device->dev, acpi_wmi_remove_address_space_handler,
-					 acpi_device);
-	if (error < 0)
-		return error;
-
 	status = acpi_install_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
 					     acpi_wmi_notify_handler, wmi_bus_dev);
 	if (ACPI_FAILURE(status)) {




