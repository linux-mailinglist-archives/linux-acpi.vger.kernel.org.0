Return-Path: <linux-acpi+bounces-459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE5E7BB7D0
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE4A1C209CD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58D1D543
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cacj4ftL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079F1D53F
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 12:33:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C50CF
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696595600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JNi9Evd7fsmHsG2VFwgtpjo6cxRius5zhdNLtK6p6lY=;
	b=Cacj4ftLX6meVdwylLEax9HjpM76lDn88Zw5KfxGaXUDM+4vqG2AvDAT3CTzc6hyiH3vp5
	cvJ1Q+IRNOSwy4/IHS2Z1i3LcQqQUf4Eo2evRZnKollrtQswytuwssID4AwPXjYlOOyPRE
	LjznsQCYz8MTzloS27kscxuBcK29BNg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-ljXA_4Y1PgW3yvdwOq93Pw-1; Fri, 06 Oct 2023 08:33:14 -0400
X-MC-Unique: ljXA_4Y1PgW3yvdwOq93Pw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 394503C13505;
	Fri,  6 Oct 2023 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E9672156711;
	Fri,  6 Oct 2023 12:33:13 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-acpi@vger.kernel.org,
	August Wikerfors <git@augustwikerfors.se>,
	Francesco <f.littarru@outlook.com>
Subject: [PATCH v2] ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q to irq1_edge_low_force_override[]
Date: Fri,  6 Oct 2023 14:33:04 +0200
Message-ID: <20231006123304.32686-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q are 3 GPU variants of a TongFang
barebone design which is sold under various brand names.

The ACPI IRQ override for the keyboard IRQ must be used on these AMD Zen
laptops in order for the IRQ to work.

Adjust the irq1_edge_low_force_override[] DMI match table for this:

1. Drop the sys-vendor match from the existing PCSpecialist Elimina Pro 16
   entry for the GM6BGEQ (RTX3050 GPU) model so that it will also match
   the laptop when sold by other vendors such as hyperbook.pl.

2. Add board-name matches for the GM6BG5Q (RTX4050) and GM6B0Q (RTX4060)
   models.

Suggested-by: August Wikerfors <git@augustwikerfors.se>
Reported-by: Francesco <f.littarru@outlook.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://laptopparts4less.frl/index.php?route=product/search&filter_name=GM6BG
Link: https://hyperbook.pl/en/content/14-hyperbook-drivers
Link: https://linux-hardware.org/?probe=bfa70344e3
Link: https://bbs.archlinuxcn.org/viewtopic.php?id=13313
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add missing reported and suggested by tags
---
 drivers/acpi/resource.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 014a3911381b..18f6353c142e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -512,17 +512,23 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 		},
 	},
 	{
-		/*
-		 * PCSpecialist Elimina Pro 16 M
-		 *
-		 * Some models have product-name "Elimina Pro 16 M",
-		 * others "GM6BGEQ". Match on board-name to match both.
-		 */
+		/* TongFang GM6BGEQ / PCSpecialist Elimina Pro 16 M, RTX 3050 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
 			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
 		},
 	},
+	{
+		/* TongFang GM6BG5Q, RTX 4050 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG5Q"),
+		},
+	},
+	{
+		/* TongFang GM6BG0Q / PCSpecialist Elimina Pro 16 M, RTX 4060 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
+		},
+	},
 	{ }
 };
 
-- 
2.41.0


