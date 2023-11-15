Return-Path: <linux-acpi+bounces-1534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5487ECA99
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 19:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3259D1C2093C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95032364C0
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmHfXLjR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD668C5
	for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2023 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700071347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=muc3l+/+AYAwkqlKLyDW1zeJpdAEkfUOAaBIp9fTr5c=;
	b=bmHfXLjRqxCkfzJY46XRLtnFdxzijDbAPZXFh0d0E3s9pqBMOL8M9jDIMXAuLUw41JixX0
	S4UIwMkyrc9LtEe56c1KXd6HaLdcqsvIBMNs3Bo2e0UikiUNX/o2n65ZwodP0AZflYZNXN
	ppSIGG26Yqrbhb6bpdU0DK/My+TQlSE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-RKqgvyMWMyWo7zpt5ol2_A-1; Wed,
 15 Nov 2023 13:02:24 -0500
X-MC-Unique: RKqgvyMWMyWo7zpt5ol2_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED7912808FC6;
	Wed, 15 Nov 2023 18:02:23 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 497F3492BE0;
	Wed, 15 Nov 2023 18:02:23 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA
Date: Wed, 15 Nov 2023 19:02:22 +0100
Message-ID: <20231115180222.10436-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Like various other ASUS ExpertBook-s, the ASUS ExpertBook B1402CVA
has an ACPI DSDT table that describes IRQ 1 as ActiveLow while
the kernel overrides it to EdgeHigh.

This prevents the keyboard from working. To fix this issue, add this laptop
to the skip_override_table so that the kernel does not override IRQ 1.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218114
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 15a3bdbd0755..9bd9f79cd409 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -447,6 +447,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1402CVA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
+		},
+	},
 	{
 		/* Asus ExpertBook B1502CBA */
 		.matches = {
-- 
2.41.0


