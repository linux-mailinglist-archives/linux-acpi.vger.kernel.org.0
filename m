Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D1155987F
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 13:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiFXLX7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 07:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiFXLX6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 07:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6A61562CD
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656069836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1z+SSoATymHXZPC4qsN0IQAqhp4hkUe+QU8XxhABvAM=;
        b=X2lrptWZrn2I0jNVPpHrUCcAhSXau4HFEO4xcH0nMxqsnYf1QIGo8YODiG9M8VAyvDWrkM
        71zXorfn44vGcyVckJLfA6A2Iju6QDbJxhqj2JE++2R4ZCCexI4Zlmm0I9egmI/niqi6hb
        Ynz77BwVgrugTN3c8S5GyILcn0bhv+s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-TQNey84YMCyIzW1ft1Dhzw-1; Fri, 24 Jun 2022 07:23:51 -0400
X-MC-Unique: TQNey84YMCyIzW1ft1Dhzw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 461E93C0D84C;
        Fri, 24 Jun 2022 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2671492C3B;
        Fri, 24 Jun 2022 11:23:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: [PATCH 1/7] ACPI: video: Change how we determine if brightness key-presses are handled
Date:   Fri, 24 Jun 2022 13:23:34 +0200
Message-Id: <20220624112340.10130-2-hdegoede@redhat.com>
In-Reply-To: <20220624112340.10130-1-hdegoede@redhat.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some systems have an ACPI video bus but not ACPI video devices with
backlight capability. On these devices brightness key-presses are
(logically) not reported through the ACPI video bus.

Change how acpi_video_handles_brightness_key_presses() determines if
brightness key-presses are handled by the ACPI video driver to avoid
vendor specific drivers/platform/x86 drivers filtering out their
brightness key-presses even though they are the only ones reporting
these presses.

Fixes: ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double trigger bug")
Reported-and-tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
Reported-and-tested-by: Kenneth Chan <kenneth.t.chan@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index b6ee27cb32f3..dc3c037d6313 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -79,6 +79,7 @@ module_param(device_id_scheme, bool, 0444);
 static int only_lcd = -1;
 module_param(only_lcd, int, 0444);
 
+static bool has_backlight;
 static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
 static DEFINE_MUTEX(video_list_lock);
@@ -1230,6 +1231,9 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 	acpi_video_device_bind(video, data);
 	acpi_video_device_find_cap(data);
 
+	if (data->cap._BCM && data->cap._BCL)
+		has_backlight = true;
+
 	mutex_lock(&video->device_list_lock);
 	list_add_tail(&data->entry, &video->video_device_list);
 	mutex_unlock(&video->device_list_lock);
@@ -2276,6 +2280,7 @@ void acpi_video_unregister(void)
 		cancel_delayed_work_sync(&video_bus_register_backlight_work);
 		acpi_bus_unregister_driver(&acpi_video_bus);
 		register_count = 0;
+		has_backlight = false;
 	}
 	mutex_unlock(&register_count_mutex);
 }
@@ -2294,13 +2299,7 @@ EXPORT_SYMBOL(acpi_video_register_backlight);
 
 bool acpi_video_handles_brightness_key_presses(void)
 {
-	bool have_video_busses;
-
-	mutex_lock(&video_list_lock);
-	have_video_busses = !list_empty(&video_bus_head);
-	mutex_unlock(&video_list_lock);
-
-	return have_video_busses &&
+	return has_backlight &&
 	       (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS);
 }
 EXPORT_SYMBOL(acpi_video_handles_brightness_key_presses);
-- 
2.36.0

