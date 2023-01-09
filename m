Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240C666302C
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jan 2023 20:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbjAITTD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Jan 2023 14:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjAITTC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2023 14:19:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D458FD9
        for <linux-acpi@vger.kernel.org>; Mon,  9 Jan 2023 11:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673291894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zoLZoXv5kTqIagLLUj3c3IklqdI9Ly9EHlczHVsTcvI=;
        b=EOEF4c1j/9h3R6q+oetWdGjFmp1a4hcEcHBw7KPLneBR3m9I3tovRrsM8au34pSzdKpfTC
        57sg6S3aqwqXQGzj6GubostsGbJnzPS1rVNyYa8ytPzIHBcdueyENY6B57/cCHczo0vOLF
        rSXlTbJmJfw0epsvLxTb8elXyXvYBFE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-x3JbdIvPNqekeOa_pHGDkQ-1; Mon, 09 Jan 2023 14:18:13 -0500
X-MC-Unique: x3JbdIvPNqekeOa_pHGDkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A45AA3811F2B;
        Mon,  9 Jan 2023 19:18:12 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4BD3140EBF5;
        Mon,  9 Jan 2023 19:18:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Allow selecting NVidia-WMI-EC or Apple GMUX backlight from the cmdline
Date:   Mon,  9 Jan 2023 20:18:11 +0100
Message-Id: <20230109191811.53961-1-hdegoede@redhat.com>
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

The patches adding NVidia-WMI-EC and Apple GMUX backlight detection
support to acpi_video_get_backlight_type(), forgot to update
acpi_video_parse_cmdline() to allow manually selecting these from
the commandline.

Add support for these to acpi_video_parse_cmdline().

Fixes: fe7aebb40d42 ("ACPI: video: Add Nvidia WMI EC brightness control detection (v3)")
Fixes: 21245df307cb ("ACPI: video: Add Apple GMUX brightness control detection")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 1b78c7434492..8a541efc5675 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -50,6 +50,10 @@ static void acpi_video_parse_cmdline(void)
 		acpi_backlight_cmdline = acpi_backlight_video;
 	if (!strcmp("native", acpi_video_backlight_string))
 		acpi_backlight_cmdline = acpi_backlight_native;
+	if (!strcmp("nvidia_wmi_ec", acpi_video_backlight_string))
+		acpi_backlight_cmdline = acpi_backlight_nvidia_wmi_ec;
+	if (!strcmp("apple_gmux", acpi_video_backlight_string))
+		acpi_backlight_cmdline = acpi_backlight_apple_gmux;
 	if (!strcmp("none", acpi_video_backlight_string))
 		acpi_backlight_cmdline = acpi_backlight_none;
 }
-- 
2.39.0

