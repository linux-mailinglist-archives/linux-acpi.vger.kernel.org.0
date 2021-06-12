Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642363A5022
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Jun 2021 20:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFLSoj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Jun 2021 14:44:39 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:39825 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLSoj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jun 2021 14:44:39 -0400
Received: by mail-io1-f52.google.com with SMTP id f10so20663821iok.6
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jun 2021 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VLTl6PsbsF32MY8EVheJqcD04Efq6LH9FRawyHh0hQE=;
        b=j+Je+Z9HN/AcD8N6jOiv8hsCk9PzH4VvpC+8+zmIjx8VvwqLqx8LvmzeSMyBXAdfY4
         xZ+v3U9k5M/jNhP+2LEjcFjC+NCOs/uh8vdxq1D33KXJYpVPJFPUiRdbv4WQ9yyGcSPG
         l4M7grTV/E6If2S1XEHWnc6uveJraOCzO+0NQbz3PFuF2w6+sbeLghmVxigOe4/Yg7lR
         dtvPauc9tAUWc8qwoOWH8HJoYv9j9ZGzS47Wzk1EqOc/kp45W7aEDU3VjXa/uNDMXPoF
         pYO2SNbi8oo2E7Er8XH3mfochM9fvxmy7lYVB4SoQt6xPSmsueCnFaQnJ+QNSRZnAAR5
         Aq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VLTl6PsbsF32MY8EVheJqcD04Efq6LH9FRawyHh0hQE=;
        b=rn5SxzSH8W64RgmBY9C+7+Hds0mmVBEOAJk6wvW+JpjGxjqxYVg0MGZXd5oj0GiLO2
         z2w3tMfI5hwGNV994WnmFBsEaRN2AVvNEvWc3Hu+HqBJqgq0qoY9K7aRVPJI83j0cOz+
         2XcSlqqwDqmTH9Q6BRaK3V7uiMoc6MbVr+xvUR8mqT/vGBbRxjkPi6/TVVKgC2W/DX0x
         hwV2fjoXEB6Ug+o6ko9zsviN61nxN2lZYzPg6aYvyKgnZ7KGup9ckdltr4ElEXQFzVB8
         tcO7EZDIc/lOTJ+7s7Yj/QLXlVvJVGHrtPp+UDKoZcmqsytAd2BUbqdJSI3caA4a4Lq6
         XF8g==
X-Gm-Message-State: AOAM531uCxd1Swxp4ZG7PBxUwXG/P26jB4cw+HbDRFuJlMgzsjuzHYEV
        royuqoaxmGSJk3rp5u79I7g=
X-Google-Smtp-Source: ABdhPJyOIK3wgsEu0zBB7CfHaLS28ik6FWgLFMCNoQsFLfb23sG051371BFYO94C1enkVLFeGCY/GA==
X-Received: by 2002:a6b:e50c:: with SMTP id y12mr8326014ioc.20.1623523299223;
        Sat, 12 Jun 2021 11:41:39 -0700 (PDT)
Received: from fedora.. ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id h7sm5254399ilr.44.2021.06.12.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 11:41:38 -0700 (PDT)
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     rui.zhang@intel.com
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH] acpi: acpi_video: Fixed comment style code issues
Date:   Sat, 12 Jun 2021 12:40:09 -0600
Message-Id: <20210612184008.666840-1-majortomtosourcecontrol@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixed coding style issues.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 drivers/acpi/acpi_video.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0c884020f74b..61e52ab5aab6 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -134,8 +134,7 @@ struct acpi_video_device_attrib {
 	u32 display_type:4;	/* Describe the specific type in use */
 	u32 vendor_specific:4;	/* Chipset Vendor Specific */
 	u32 bios_can_detect:1;	/* BIOS can detect the device */
-	u32 depend_on_vga:1;	/* Non-VGA output device whose power is related to
-				   the VGA device. */
+	u32 depend_on_vga:1;	/* Non-VGA output device whose power is related to the VGA device */
 	u32 pipe_id:3;		/* For VGA multiple-head devices. */
 	u32 reserved:10;	/* Must be 0 */
 
@@ -1581,13 +1580,11 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 	input = video->input;
 
 	switch (event) {
-	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
-					 * most likely via hotkey. */
+	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch, most likely via hotkey. */
 		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
-	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
-					 * connector. */
+	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video connector. */
 		acpi_video_device_enumerate(video);
 		acpi_video_device_rebind(video);
 		keycode = KEY_SWITCHVIDEOMODE;
-- 
2.31.1

