Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E616459F955
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 14:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiHXMQw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 08:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiHXMQa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 08:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ABE6FA0E
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661343386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v18TLB6llBn21xZmtCkJxNxeUJMalL9uiv3Zdl8G6jE=;
        b=C9jgW3hZU79go29oMcgdTYzmIeg0h2FbGWujHl6MP92U0L3HQrCZM3x0PQIOEU+fDJ0UPY
        FMsCtIAWdQdezjTHBL3nRfluKTrD8SQc5qsvtLl0ZgBF6vKYDZyArJp6552yi5wNpyfwmu
        wppFYIHhxNssmLAqvrauAPoFanflAWk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-KlunHvOzOR-vMnYGybvaHg-1; Wed, 24 Aug 2022 08:16:22 -0400
X-MC-Unique: KlunHvOzOR-vMnYGybvaHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF6EA294EDED;
        Wed, 24 Aug 2022 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEBCBC15BB3;
        Wed, 24 Aug 2022 12:16:17 +0000 (UTC)
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
Subject: [PATCH v4 11/31] drm/i915: Call acpi_video_register_backlight() (v2)
Date:   Wed, 24 Aug 2022 14:15:03 +0200
Message-Id: <20220824121523.1291269-12-hdegoede@redhat.com>
In-Reply-To: <20220824121523.1291269-1-hdegoede@redhat.com>
References: <20220824121523.1291269-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On machins without an i915 opregion the acpi_video driver immediately
probes the ACPI video bus and used to also immediately register
acpi_video# backlight devices when supported.

Once the drm/kms driver then loaded later and possibly registered
a native backlight device then the drivers/acpi/video_detect.c code
unregistered the acpi_video0 device to avoid there being 2 backlight
devices (when acpi_video_get_backlight_type()==native).

This means that userspace used to briefly see 2 devices and the
disappearing of acpi_video0 after a brief time confuses the systemd
backlight level save/restore code, see e.g.:
https://bbs.archlinux.org/viewtopic.php?id=269920

To fix this the ACPI video code has been modified to make backlight class
device registration a separate step, relying on the drm/kms driver to
ask for the acpi_video backlight registration after it is done setting up
its native backlight device.

Add a call to the new acpi_video_register_backlight() after the i915 calls
acpi_video_register() (after setting up the i915 opregion) so that the
acpi_video backlight devices get registered on systems where the i915
native backlight device is not registered.

Changes in v2:
-Only call acpi_video_register_backlight() when a panel is detected

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 8 ++++++++
 drivers/gpu/drm/i915/display/intel_panel.c   | 3 +++
 drivers/gpu/drm/i915/i915_drv.h              | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 6103b02c081f..2bb53efdb149 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -9088,6 +9088,14 @@ void intel_display_driver_register(struct drm_i915_private *i915)
 	/* Must be done after probing outputs */
 	intel_opregion_register(i915);
 	acpi_video_register();
+	/*
+	 * Only call this if i915 is driving the internal panel. If the internal
+	 * panel is not driven by i915 then another GPU driver may still register
+	 * a native backlight driver later and this should only be called after
+	 * any native backlights have been registered.
+	 */
+	if (i915->have_panel)
+		acpi_video_register_backlight();
 
 	intel_audio_init(i915);
 
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 237a40623dd7..4536c527f50c 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -646,8 +646,11 @@ intel_panel_mode_valid(struct intel_connector *connector,
 
 int intel_panel_init(struct intel_connector *connector)
 {
+	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
 	struct intel_panel *panel = &connector->panel;
 
+	dev_priv->have_panel = true;
+
 	intel_backlight_init_funcs(panel);
 
 	drm_dbg_kms(connector->base.dev,
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 69ce6db6a7c1..14b0dcaf25c2 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -756,6 +756,8 @@ struct drm_i915_private {
 
 	bool ipc_enabled;
 
+	bool have_panel;
+
 	struct intel_audio_private audio;
 
 	struct i915_pmu pmu;
-- 
2.37.2

