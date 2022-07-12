Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9A57265B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jul 2022 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbiGLTry (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jul 2022 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiGLTrS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2022 15:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91CE94F187
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jul 2022 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657654794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYNsjCN6Tw/oqp4zM9jwqxiybSMoea1HMnVsBx4lMHQ=;
        b=Oplyn3fDNW/8jGxKSQeeNC0IDXsk4gTddFXXUiYxw6REOgXpktL5rPA3MUiyM7WoLyzFe8
        /M4y8Hm/MGGH7uf+CCfKHVbv9xLVol0E4rrA3hZleZ0IKBU2X8ZnsP/NU2ChnB2ZWEGehx
        RtmtASO2QkhMBujLp32x+c3AJ6CQdCs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-_SEaw1onPbygIvvUCEm2wQ-1; Tue, 12 Jul 2022 15:39:51 -0400
X-MC-Unique: _SEaw1onPbygIvvUCEm2wQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CC6F18E5280;
        Tue, 12 Jul 2022 19:39:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF12340E80E1;
        Tue, 12 Jul 2022 19:39:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude <lyude@redhat.com>, Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan@vger.kernel.org, Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 07/29] ACPI: video: Remove acpi_video_bus from list before tearing it down
Date:   Tue, 12 Jul 2022 21:38:48 +0200
Message-Id: <20220712193910.439171-8-hdegoede@redhat.com>
In-Reply-To: <20220712193910.439171-1-hdegoede@redhat.com>
References: <20220712193910.439171-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Move the list_del removing an acpi_video_bus from video_bus_head
on teardown to before the teardown is done, to avoid code iterating
over the video_bus_head list seeing acpi_video_bus objects on there
which are (partly) torn down already.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 43177c20ce4f..09899b7f7fab 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2117,14 +2117,14 @@ static int acpi_video_bus_remove(struct acpi_device *device)
 
 	video = acpi_driver_data(device);
 
-	acpi_video_bus_remove_notify_handler(video);
-	acpi_video_bus_unregister_backlight(video);
-	acpi_video_bus_put_devices(video);
-
 	mutex_lock(&video_list_lock);
 	list_del(&video->entry);
 	mutex_unlock(&video_list_lock);
 
+	acpi_video_bus_remove_notify_handler(video);
+	acpi_video_bus_unregister_backlight(video);
+	acpi_video_bus_put_devices(video);
+
 	kfree(video->attached_array);
 	kfree(video);
 
-- 
2.36.0

