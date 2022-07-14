Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F465755AC
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 21:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiGNTQc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 15:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGNTQb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 15:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0A78422CE
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jul 2022 12:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657826189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pyOKjb33me+J8ld9DxsocCdXl7/5frLguxOUijQkyG4=;
        b=Nhx7eghgWeGdJC7Y9YdXuq3ZhnOKvUoZ8OWWvA71jsSd3aRghPQ9DdrDVKK/vndsojUDba
        v1FRdsBlWSv3JJVqYl1p6leypeVMv6QuEBeBmSDJkl6VE9SBpLmzIH/Xt5j+RyyJOAoMI4
        UVdFgrefUnaKTODUhowT82b9XAAcNv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-r1VdPEwrPwWiqB2fOtHU1g-1; Thu, 14 Jul 2022 15:16:20 -0400
X-MC-Unique: r1VdPEwrPwWiqB2fOtHU1g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24E86811E80;
        Thu, 14 Jul 2022 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DFD8492C3B;
        Thu, 14 Jul 2022 19:16:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Ben Greening <bgreening@gmail.com>
Subject: [PATCH] ACPI: video: Use native backlight on Dell Inspiron N4010
Date:   Thu, 14 Jul 2022 21:16:11 +0200
Message-Id: <20220714191611.10242-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Dell Inspiron N4010 does not have ACPI backlight control,
so acpi_video_get_backlight_type()'s heuristics return vendor as
the type to use.

But the vendor interface is broken, where as the native (intel_backlight)
works well, add a quirk to use native.

Link: https://lore.kernel.org/regressions/CALF=6jEe5G8+r1Wo0vvz4GjNQQhdkLT5p8uCHn6ZXhg4nsOWow@mail.gmail.com/
Reported-and-tested-by: Ben Greening <bgreening@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index becc198e4c22..4099140bbd5f 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -347,6 +347,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell Inspiron N4010 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron N4010"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Dell Vostro V131 */
-- 
2.36.0

