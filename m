Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E915061A33C
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Nov 2022 22:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKDVWQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Nov 2022 17:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKDVWP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2022 17:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718D8EE0D
        for <linux-acpi@vger.kernel.org>; Fri,  4 Nov 2022 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667596880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXVnleVj2DQ7lxjhiI1pKsdKMMSoDhZBUnK4Sfgt/14=;
        b=LPID/z+071ads3OLjUe9jowwtnwTbgKQHMSBR410EDNxt0styrNcrEwRZsrC4+PmH5hWoC
        5oxsG0PREqb/DtHSeb9McD+SY9N1DooqUDblAppYti3KV5pzgYSf/9CeqTSFWr/+LDOJgu
        Y6RAojOsb3w1f9bb3WfcOO7CEvpQSPI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-r0iucwrJPZeK2KTMVMjlag-1; Fri, 04 Nov 2022 17:21:18 -0400
X-MC-Unique: r0iucwrJPZeK2KTMVMjlag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10CEB1C0754E;
        Fri,  4 Nov 2022 21:21:18 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 784572024CBF;
        Fri,  4 Nov 2022 21:21:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org, Daniel Dadap <ddadap@nvidia.com>
Subject: [PATCH 3/3] ACPI: video: Add backlight=native DMI quirk for Dell G15 5515
Date:   Fri,  4 Nov 2022 22:21:08 +0100
Message-Id: <20221104212108.73537-4-hdegoede@redhat.com>
In-Reply-To: <20221104212108.73537-1-hdegoede@redhat.com>
References: <20221104212108.73537-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Dell G15 5515 has the WMI interface (and WMI call returns) expected
by the nvidia-wmi-ec-backlight interface. But the backlight class device
registered by the nvidia-wmi-ec-backlight driver does not actually work.

The amdgpu_bl0 native GPU backlight class device does actually work,
add a backlight=native DMI quirk for this.

Cc: Daniel Dadap <ddadap@nvidia.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add a comment that this needs to be revisited when dynamic-mux
  support gets added (suggested by: Daniel Dadap)
---
 drivers/acpi/video_detect.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index c02e960cdbe3..b2a616287638 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -645,6 +645,20 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 
+	/*
+	 * Models which have nvidia-ec-wmi support, but should not use it.
+	 * Note this indicates a likely firmware bug on these models and should
+	 * be revisited if/when Linux gets support for dynamic mux mode.
+	 */
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell G15 5515 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
+		},
+	},
+
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
 	 * for this do not catch.
-- 
2.37.3

