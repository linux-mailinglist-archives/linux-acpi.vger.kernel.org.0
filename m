Return-Path: <linux-acpi+bounces-5730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1DD8C2649
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E268A1F2123F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F61136E0C;
	Fri, 10 May 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="MjV+YDeh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBFC171E70;
	Fri, 10 May 2024 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349904; cv=none; b=dUn98AXlH8nF6Be9JuMTOqYLJwuDoWiFYrJ/4WYRD+G1bO9/Mu/gooawy8drzSnEXMOevk6vWeehxvswCuDYENKWx3tb4eZL5nHSNxy7uOCz9102e1uai6t7MyYd/zcqy3uKPu4tdxqzwE+J5EE1LRp4WPwrcdiKtRO42DhpaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349904; c=relaxed/simple;
	bh=AigkgpHRx5u5xY7r4e5L9K+exbczmphxJ+c+WCFIIDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiLfW93R5zzkVDCzv0Id4KXEnBMhKF2z0oJPkjUiWwqgj0WTBBN9rCAKMGGRqWBeL9YC8f1lsD0WOCSOHLbjE4Qb6kjClaWLF79l0MQA7Ls0Y899/UVCFrh7vaDLGEI5E47NCpY03zVhb8xbkHeS33tWA9kO1386v+ukno2ACVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=MjV+YDeh reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id a7fd470ac8d4b3c8; Fri, 10 May 2024 16:04:59 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BA58821031DA;
	Fri, 10 May 2024 16:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715349899;
	bh=AigkgpHRx5u5xY7r4e5L9K+exbczmphxJ+c+WCFIIDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjV+YDehwUHtsp2lTEOQugh+oqzekHf0mRoM2nu0a17A2RM7kZs3vyRTU35Do+hs9
	 DHdTCxVRFTKtm63K8uACJc006JsyFeySnRtNc0nv+r9/kBz/gIEURLtXTAZUqn7wpL
	 uydkDZ1qIj9e2pjXc1SDpP0l4pqYhd3y/dFeY4GuGpBO5hrQm8Z88y+wY65+LhMyWn
	 hXxs161oUdoaBPAFQfz3M1UccJ5En0Ou14sPaKNsiFkkkV7QtNiK6sgIAYIjQ/WnHR
	 K7gL05hWpvhc3WYU9tND39Fckvt7Ac3Emda3ZIghPmZeZA0RGmpxMLE7zKgJp8YD5s
	 3fNhOKWjU1HIw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject:
 [PATCH v1 2/2] platform/x86: wmi: Remove custom EC address space handler
Date: Fri, 10 May 2024 16:04:50 +0200
Message-ID: <2332870.ElGaqSPkdT@kreacher>
In-Reply-To: <5787281.DvuYhMxLoT@kreacher>
References: <5787281.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohepfigprghrmhhinhesghhmgidruggv
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The custom EC address space handler in the WMI driver was only needed
because the EC driver did not install its address space handler for
EC operation regions beyond the EC device scope in the ACPI namespace.

That has just changed, so the custom EC address handler is not needed
any more and it can be removed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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




