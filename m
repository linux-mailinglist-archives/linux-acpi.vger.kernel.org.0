Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B6A6695E9
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jan 2023 12:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbjAMLvj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Jan 2023 06:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbjAMLvQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jan 2023 06:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F222E50F70
        for <linux-acpi@vger.kernel.org>; Fri, 13 Jan 2023 03:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673610101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=isVOZ9GRr18rPWGPzYgy4dJ/cFyoVZ1pgMHiAqQq1BA=;
        b=GGr1Xr7ozEMIrdUQ8BgcSavAHShFtet1SP4ff9LQKIhk6HsFl7F5Oh/Fn/KZMYAq+6DiNQ
        hpsz5TsbQuhTQ8f8y+tuQQjw/NzudmZwIuvfhAYGVoEfzl/6Q1F0gPuRvjYb+m5rwkh5jC
        1y/yp7AkYqtkKQpqechTehzJkKVUM4s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-4ftcf2kwPuepngchr3KO3A-1; Fri, 13 Jan 2023 06:41:36 -0500
X-MC-Unique: 4ftcf2kwPuepngchr3KO3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1C933813F34;
        Fri, 13 Jan 2023 11:41:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C09544078904;
        Fri, 13 Jan 2023 11:41:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Acer Aspire 4810T
Date:   Fri, 13 Jan 2023 12:41:26 +0100
Message-Id: <20230113114126.172078-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Acer Aspire 4810T predates Windows 8, so it defaults to using
acpi_video# for backlight control, but this is non functional on
this model.

Add a DMI quirk to use the native backlight interface which does
work properly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index d4edd64dcc2f..fb526ba8825b 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -515,6 +515,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Acer Aspire 4810T */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 4810T"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Acer Aspire 5738z */
-- 
2.39.0

