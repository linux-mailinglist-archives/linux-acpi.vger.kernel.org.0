Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB36F56F1
	for <lists+linux-acpi@lfdr.de>; Wed,  3 May 2023 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjECLIG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 May 2023 07:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjECLIF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 May 2023 07:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F31B0
        for <linux-acpi@vger.kernel.org>; Wed,  3 May 2023 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683112039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K3jqoqPQDQnEYgn6GJe/Oqoor/fXTlzmxc43rLH1ZDs=;
        b=Ln5i7ywHeQV397aG5uy4+ome90OPHVVpTmnfiVsj4B8GF63TfDrP77OmNZfLQGwYTJgI7K
        2EI4QFj8LJNaYgpMN32buvusfsQhs9IYDpVHuYsJPvlmkQQndCQgEFNWLl0GUJzQcbBOdm
        csWDGPNo5NpeXZlCjGzRU5yermLCV7c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-qUYO1ptePR-3-pk_FxPECQ-1; Wed, 03 May 2023 07:07:16 -0400
X-MC-Unique: qUYO1ptePR-3-pk_FxPECQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E40EC3C0252E;
        Wed,  3 May 2023 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59F684014E87;
        Wed,  3 May 2023 11:07:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3
Date:   Wed,  3 May 2023 13:07:09 +0200
Message-Id: <20230503110709.22260-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Linux defaults to picking the non-working ACPI video backlight interface
on the Apple iMac11,3 .

Add a DMI quirk to pick the working native radeon_bl0 interface instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index bcc25d457581..61586caebb01 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -470,6 +470,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple iMac11,3 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-- 
2.39.2

