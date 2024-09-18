Return-Path: <linux-acpi+bounces-8328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2357597BEBC
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2024 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6E0283CD9
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2024 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129C1537B5;
	Wed, 18 Sep 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ppnk1eGU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4F1C8FC9
	for <linux-acpi@vger.kernel.org>; Wed, 18 Sep 2024 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673943; cv=none; b=oDvDlA3DPyiFQhbvnoAWkhLCEryPE9Fscg8+1hOoZBvgkohjrHM7UJBLTt+nb2u19pg+PZEormDdQhkW388qDt4JOrdUlG5e+mUDgeLckahavl4nCnlJf3JL67W7YVjRd7sfc8WNuAMqOdfaupj/LYK9f/spho4VAFB9h4xBMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673943; c=relaxed/simple;
	bh=vQCotvNNiYUQsgf8VD4VtrOxGDX5OqxOq4016Yi1Fk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nReGAs+pFYTOj3IryixDNCZYUtInXLra+wwKcGlH18lf7PtzWOQCR3SPXDOFkSG9VVfpxOtB7GNAxDS01AkffF9pI6HTZrF80zOiDPkA1k1M7xFsWf9dT/bJ3R4TVPS6KZgYSaCchKSpRijEQ49u+9E300H56l+MEEKuZKpX8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ppnk1eGU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726673940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KdSt1VfVB9P3r3796KVdogAhGOTn7TpWjXb5rzTlrd4=;
	b=Ppnk1eGUa+NnrAHOMtezKEk0gTvWnie0OJGG6+kTpX195nBV6OQT3FmKsx39xZGpCsTtBd
	AQz30gyPjQXTEwr6atV8bEw5RBaCeByyVAb3CB67pgMDExQ/FbzGni18KlJeoOS5rMG1Vf
	U1RZ3zsKl/rR1it9Xgu3gV9LI4z7TIM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-TigzuWihMCiArBPC1Nf28A-1; Wed,
 18 Sep 2024 11:38:59 -0400
X-MC-Unique: TigzuWihMCiArBPC1Nf28A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA8141955D59;
	Wed, 18 Sep 2024 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C634F19560AA;
	Wed, 18 Sep 2024 15:38:55 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	All applicable <stable@vger.kernel.org>
Subject: [PATCH] ACPI: video: Add backlight=native quirk for Dell OptiPlex 5480 AIO
Date: Wed, 18 Sep 2024 17:38:49 +0200
Message-ID: <20240918153849.37221-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Dell All In One (AIO) models released after 2017 may use a backlight
controller board connected to an UART.

In DSDT this uart port will be defined as:

   Name (_HID, "DELL0501")
   Name (_CID, EisaId ("PNP0501")

The Dell OptiPlex 5480 AIO has an ACPI device for one if its UARTs with
the above _HID + _CID. Loading the dell-uart-backlight driver fails with
the following errors:

[   18.261353] dell_uart_backlight serial0-0: Timed out waiting for response.
[   18.261356] dell_uart_backlight serial0-0: error -ETIMEDOUT: getting firmware version
[   18.261359] dell_uart_backlight serial0-0: probe with driver dell_uart_backlight failed with error -110

Indicating that there is no backlight controller board attached to
the UART, while the GPU's native backlight control method does work.

Add a quirk to use the GPU's native backlight control method on this model.

Fixes: cd8e468efb4f ("ACPI: video: Add Dell UART backlight controller detection")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b70e84e8049a..015bd8e66c1c 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -844,6 +844,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	 * controller board in their ACPI tables (and may even have one), but
 	 * which need native backlight control nevertheless.
 	 */
+	{
+	 /* https://github.com/zabbly/linux/issues/26 */
+	 .callback = video_detect_force_native,
+	 /* Dell OptiPlex 5480 AIO */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 5480 AIO"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=2303936 */
 	 .callback = video_detect_force_native,
-- 
2.46.0


