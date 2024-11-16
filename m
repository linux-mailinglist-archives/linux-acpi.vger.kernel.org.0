Return-Path: <linux-acpi+bounces-9609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746099CFDBA
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 10:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C721F2662F
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1C155312;
	Sat, 16 Nov 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLOlAdfW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAD762E0
	for <linux-acpi@vger.kernel.org>; Sat, 16 Nov 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731751113; cv=none; b=dMwwmvRdhRtBx7BONbrpnPery9KUn5+UD5uVBtnG+v5FbSR8qkC+vOJnDxPCHssW0PTKTscLce9yzRslt5rOuLgWnjD+kDxQnra19FBcp1JND0AUTuSxCy1gU7oMAqUz2zRgrQy83xRqTx1EJqzEcF9PYDHv3+WfNmu54OZKPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731751113; c=relaxed/simple;
	bh=Yp4RxllDDHfNTggcpa44tvyNn785MFNW4sNDlDkbrqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfYENpfemj/YVeXEbywMK3Pz9ta/fjw2vLAurmNCulPjG4vGgzbMyx5TwdSXRmyLcB6SlN38sZERsXeaDtIydYSmIo06xsSBeVsVOlxYvLjCqSr/ZIRPMUTJaSB5JKUqSuFpy1OQc76+G9vPPzY7hL8YMIJB7gVDsPkMoBCeHdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLOlAdfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731751110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=joSefEB8eVCA/KWVmP5S5T++dKMqAGKy+aJwSPb5lHQ=;
	b=bLOlAdfWyPPqzVy6pSe2JlfkD8oIb3AyU64/b+2Nc5pNTIz6KEI/j19NHvgKoL2D/qwgJg
	4bR0e4TB7pcj1d3bIWlnvSm4u4hmgoYk8LtswvVNunPOwdffXwkiy6xf7OIY/5I+eXAvbf
	c3EEe6cDWVbXroV9yECJIScItexhvGk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-iTp-kMUTNWuih0jDsAxQ2g-1; Sat,
 16 Nov 2024 04:58:28 -0500
X-MC-Unique: iTp-kMUTNWuih0jDsAxQ2g-1
X-Mimecast-MFC-AGG-ID: iTp-kMUTNWuih0jDsAxQ2g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD469195608D;
	Sat, 16 Nov 2024 09:58:27 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.52])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78C0419560A3;
	Sat, 16 Nov 2024 09:58:26 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 8 A1-840
Date: Sat, 16 Nov 2024 10:58:24 +0100
Message-ID: <20241116095825.11660-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The Acer Iconia One 8 A1-840 (not to be confused with the A1-840FHD which
is a different model) ships with Android 4.4 as factory OS and has
the usual broken DSDT issues for x86 Android tablets.

Add quirks to skip ACPI I2C client enumeration and disable ACPI battery/AC
and ACPI GPIO event handlers.

Also add the "INT33F5" HID for the TI PMIC used on this tablet to the list
of HIDs for which not to skip i2c_client instantiation, since we do want
an ACPI instantiated i2c_client for the PMIC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 423565c31d5e..1bb425b78032 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -308,6 +308,18 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
+	{
+		/* Acer Iconia One 8 A1-840 (non FHD version) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
+			/* Above strings are too generic also match BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "04/01/2014"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
@@ -425,6 +437,7 @@ static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
 	{ "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
 	{ "10EC5651", 0 }, /* RealTek ALC5651 audio codec */
 	{ "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
+	{ "INT33F5", 0 },  /* TI Dollar Cove PMIC */
 	{ "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
 	{ "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
 	{ "NPCE69A", 0 },  /* Asus Transformer keyboard dock */
-- 
2.47.0


