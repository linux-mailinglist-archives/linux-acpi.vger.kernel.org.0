Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672A362831E
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 15:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiKNOq4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 09:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiKNOqn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 09:46:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03496377
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 06:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668437117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLKwd7LdFoY3d3OGGTqZ2TY1L53YOPPgucadnQcACLc=;
        b=Hl5G5nlK3YGkOJ4/rEW6yR2N42WjHknu0ql3lqVAO3S8serLPE9DFEpF13oq1C5iUSO9R4
        g/NeJW34G/VbbiUyY770UaRHr8sItPHt5m5xNCbYqmSG4nygFTewLq2ZU9rNL2Nr8AgXgj
        922vkW6mUxvpcjwW8YwwO922+G4nRAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-gA0E6UgPMCq1Vd5ER2K7Sw-1; Mon, 14 Nov 2022 09:45:12 -0500
X-MC-Unique: gA0E6UgPMCq1Vd5ER2K7Sw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E779A800B23;
        Mon, 14 Nov 2022 14:45:11 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D7D61415102;
        Mon, 14 Nov 2022 14:45:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 4/7] ACPI: video: Add force_vendor quirk for Sony Vaio PCG-FRV35
Date:   Mon, 14 Nov 2022 15:44:56 +0100
Message-Id: <20221114144459.455519-5-hdegoede@redhat.com>
In-Reply-To: <20221114144459.455519-1-hdegoede@redhat.com>
References: <20221114144459.455519-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Sony Vaio PCG-FRV35 advertises both native and vendor backlight
control interfaces. With the upcoming changes to prefer native over
vendor acpi_video_get_backlight_type() will start returning native on
these laptops.

But the native radeon_bl0 interface does not work, where as the sony
vendor interface does work. Add a quirk to force use of the vendor
interface.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 327e0967ba54..43f667523ab0 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -239,6 +239,19 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 
+	/*
+	 * Models which should use the vendor backlight interface,
+	 * because of broken native backlight control.
+	 */
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Sony Vaio PCG-FRV35 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "PCG-FRV35"),
+		},
+	},
+
 	/*
 	 * Toshiba models with Transflective display, these need to use
 	 * the toshiba_acpi vendor driver for proper Transflective handling.
-- 
2.37.3

