Return-Path: <linux-acpi+bounces-10798-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA376A1A4CC
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 14:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956DC3AAAD7
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999920E6EE;
	Thu, 23 Jan 2025 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UC4LIYam"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD61E493
	for <linux-acpi@vger.kernel.org>; Thu, 23 Jan 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638532; cv=none; b=qpVjSjJOyJYIoCdYKT8nHMm297MM84I2ON6TgupJ9OZATs2TPKs8lSTokhXzyBZH/9Jo2Od56JqmuCmuKBsN1YTa1kmub09VmnwxYDSJRdlLy+kPnx2JX/107hYXFF+4C+76O0abX0gthDP1XlQAjlhsCn298eOewx6pIxayoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638532; c=relaxed/simple;
	bh=3MoegCNOmpT0Qwh0/dTHVzxLkN4dZxrvaVTQ8pvkCfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QduARl57V6svoabpghojwfGYewRAhWVaF8eajRKovBzMOisnvRzynZN5oNlm0xM/5FjMMk81tGjBTeiTXjpifBKK7IGt5JEqqxCC1kBN1ZIwJtVzrKDDm38JGEBTQfd9P8cCw8ShkA7fDTik7YtNHxw1BMVqid2suBs3aXbdSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UC4LIYam; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737638529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=skrhwqElYadfZmEokudJOjgN6uzNO+XK0igkCNLj+D0=;
	b=UC4LIYam8dVIWIq+QKKefOaE7TRwAA9+dashrsjmBFC5amGqpI93Atad6FI+p92D60fefJ
	UW1St0p+bpeguS+2Y85MrUzhwDDwHAZQI4TOi0jLQhlTbnriNHIxjpVOg1qT+EkFUu0sWN
	23jjQYBrmQFwTJlQ/vwQIKMjBX/ql8E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-MVaFyAquPpKExWL0LRqS-w-1; Thu,
 23 Jan 2025 08:22:06 -0500
X-MC-Unique: MVaFyAquPpKExWL0LRqS-w-1
X-Mimecast-MFC-AGG-ID: MVaFyAquPpKExWL0LRqS-w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 056751955DDA;
	Thu, 23 Jan 2025 13:22:06 +0000 (UTC)
Received: from x1.redhat.com (unknown [10.39.194.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27331195605F;
	Thu, 23 Jan 2025 13:22:03 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V
Date: Thu, 23 Jan 2025 14:22:02 +0100
Message-ID: <20250123132202.18209-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The Vexia EDU ATLA 10 tablet comes in 2 different versions with
significantly different mainboards. The only outward difference is that
the charging barrel on one is marked 5V and the other is marked 9V.

Both ship with Android 4.4 as factory OS and have the usual broken DSDT
issues for x86 Android tablets.

Add a quirk to skip ACPI I2C client enumeration for the 5V version to
complement the existing quirk for the 9V version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index cb45ef5240da..068c1612660b 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -407,6 +407,19 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
+	{
+		/* Vexia Edu Atla 10 tablet 5V version */
+		.matches = {
+			/* Having all 3 of these not set is somewhat unique */
+			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_BOARD_NAME, "To be filled by O.E.M."),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "05/14/2015"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+	},
 	{
 		/* Vexia Edu Atla 10 tablet 9V version */
 		.matches = {
-- 
2.47.1


