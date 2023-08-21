Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3446B782611
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Aug 2023 11:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjHUJKX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Aug 2023 05:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjHUJKW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2023 05:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A8C7
        for <linux-acpi@vger.kernel.org>; Mon, 21 Aug 2023 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692608973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n+un/h4Se3kF0gyO71Y6Gkd3Cbyfhb2n6D6SM21FoJ4=;
        b=aspTLXAcDaNdqWcRTmUMb8F8u5/bxxMFvPQhKWN2qEmX2D9TQ+od+jUde4IDFYELOuTzzD
        4mqpRs8cVhIHVJ2aFeS+JXXJbVFEU54h3scRwn2a6eIKiPpZr29WhGUBjKuThv9H6RVGtg
        k0eYWVq8QPUv2AL9q3x5nG9RqjY4zU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-56PgXgEnOOe2q1rWZ575uw-1; Mon, 21 Aug 2023 05:09:29 -0400
X-MC-Unique: 56PgXgEnOOe2q1rWZ575uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72CA58DC664;
        Mon, 21 Aug 2023 09:09:29 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB27C140E950;
        Mon, 21 Aug 2023 09:09:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-acpi@vger.kernel.org, All applicable <stable@vger.kernel.org>
Subject: [PATCH] ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M
Date:   Mon, 21 Aug 2023 11:09:27 +0200
Message-ID: <20230821090927.305926-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It turns out that some PCSpecialist Elimina Pro 16 M models
have "GM6BGEQ" as DMI product-name instead of "Elimina Pro 16 M",
causing the existing DMI quirk to not work on these models.

The DMI board-name is always "GM6BGEQ", so match on that instead.

Fixes: 56fec0051a69 ("ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 16 M")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394#c36
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index a4d9f149b48d..32cfa3f4efd3 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -501,9 +501,13 @@ static const struct dmi_system_id maingear_laptop[] = {
 static const struct dmi_system_id pcspecialist_laptop[] = {
 	{
 		.ident = "PCSpecialist Elimina Pro 16 M",
+		/*
+		 * Some models have product-name "Elimina Pro 16 M",
+		 * others "GM6BGEQ". Match on board-name to match both.
+		 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Elimina Pro 16 M"),
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
 		},
 	},
 	{ }
-- 
2.41.0

