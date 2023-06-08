Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54DD727AEE
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jun 2023 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjFHJOE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jun 2023 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjFHJNy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2023 05:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32518F
        for <linux-acpi@vger.kernel.org>; Thu,  8 Jun 2023 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686215588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=16KxC6axyYz6jl6eF4eiauurZZuB6mm1c7hjr9Mvt8I=;
        b=NwDnlDJA7Kst4GGZcAUZ8ITL7o2WKgL4VNZp4v4kSWbz5Q6vONNdRsMEBjtfv68T6D/ziA
        4XUzhRD52Ibt7u63ykIqFCuiJkZi9al4bt25/7q96SnCs57aMMf+e2RLcLDFz2cM4cgBdN
        V2NbQbscvum9xjdcSARYUwCjaad+Swc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-HzJFljjhNpynOZWbY0SdsQ-1; Thu, 08 Jun 2023 05:13:05 -0400
X-MC-Unique: HzJFljjhNpynOZWbY0SdsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F09FB3802AE3;
        Thu,  8 Jun 2023 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 040BDC0004B;
        Thu,  8 Jun 2023 09:13:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH] ACPI: video: Stop trying to use vendor backlight control on laptops from after ~2012
Date:   Thu,  8 Jun 2023 11:12:58 +0200
Message-Id: <20230608091258.7963-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There have been 2 separate reports now about a non working
"dell_backlight" device getting registered under /sys/class/backlight
1 report for a Raptor Lake based Dell and 1 report for a Meteor Lake
(development) platform.

On hw from the last 10 years dell-laptop will not register "dell_backlight"
because acpi_video_get_backlight_type() will return acpi_backlight_video
there if called before the GPU/kms driver loads. So it does not matter if
the GPU driver's native backlight is registered after dell-laptop loads.

But it seems that on the latest generation laptops the ACPI tables
no longer contain acpi_video backlight control support which causes
acpi_video_get_backlight_type() to return acpi_backlight_vendor causing
"dell_backlight" to get registered if the dell-laptop module is loaded
before the GPU/kms driver.

Vendor specific backlight control like the "dell_backlight" device is
only necessary on quite old hw (from before acpi_video backlight control
was introduced). Work around "dell_backlight" registering on very new
hw (where acpi_video backlight control seems to be no more) by making
acpi_video_get_backlight_type() return acpi_backlight_none instead
of acpi_backlight_vendor as final fallback when the ACPI tables have
support for Windows 8 or later (laptops from after ~2012).

Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
Reported-by: AceLan Kao <acelan.kao@canonical.com>
Closes: https://lore.kernel.org/platform-driver-x86/20230607034331.576623-1-acelan.kao@canonical.com/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b87783c5872d..eb014c0eba42 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -844,6 +844,27 @@ enum acpi_backlight_type __acpi_video_get_backlight_type(bool native, bool *auto
 	if (native_available)
 		return acpi_backlight_native;
 
+	/*
+	 * The vendor specific BIOS interfaces are only necessary for
+	 * laptops from before ~2008.
+	 *
+	 * For laptops from ~2008 till ~2023 this point is never reached
+	 * because on those (video_caps & ACPI_VIDEO_BACKLIGHT) above is true.
+	 *
+	 * Laptops from after ~2023 no longer support ACPI_VIDEO_BACKLIGHT,
+	 * if this point is reached on those, this likely means that
+	 * the GPU kms driver which sets native_available has not loaded yet.
+	 *
+	 * Returning acpi_backlight_vendor in this case is known to sometimes
+	 * cause a non working vendor specific /sys/class/backlight device to
+	 * get registered.
+	 *
+	 * Return acpi_backlight_none on laptops with ACPI tables written
+	 * for Windows 8 (laptops from after ~2012) to avoid this problem.
+	 */
+	if (acpi_osi_is_win8())
+		return acpi_backlight_none;
+
 	/* No ACPI video/native (old hw), use vendor specific fw methods. */
 	return acpi_backlight_vendor;
 }
-- 
2.40.1

