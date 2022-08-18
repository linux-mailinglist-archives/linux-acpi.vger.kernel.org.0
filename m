Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F297C598BBA
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Aug 2022 20:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbiHRSqY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Aug 2022 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345589AbiHRSpY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Aug 2022 14:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F284E620
        for <linux-acpi@vger.kernel.org>; Thu, 18 Aug 2022 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660848321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3SH44BXwktH40KCcDZ9+emR32b1FaNxTyVmnyphrNZ0=;
        b=MnvHr0PUWdJ3+duIqOJE3NeubE6Z9JtZs2vuc5O1sNNTBsQkDoMYlwz4/lzsIbefmsyn1S
        MwcKrxX33zz2oV4gOWBolX/SiIPzGTG5tY3zF/bi+KN+doFrYrge5xYVG/U0uETCSUP8QA
        YA9ioRHrDcaDmATvtzDNcq8vzwafKmE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-LFpjrYx6M1uDx4MF-Xar3w-1; Thu, 18 Aug 2022 14:45:20 -0400
X-MC-Unique: LFpjrYx6M1uDx4MF-Xar3w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 490D285A581;
        Thu, 18 Aug 2022 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A84A7492C3B;
        Thu, 18 Aug 2022 18:45:14 +0000 (UTC)
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
Subject: [PATCH v3 31/31] drm/todo: Add entry about dealing with brightness control on devices with > 1 panel
Date:   Thu, 18 Aug 2022 20:43:02 +0200
Message-Id: <20220818184302.10051-32-hdegoede@redhat.com>
In-Reply-To: <20220818184302.10051-1-hdegoede@redhat.com>
References: <20220818184302.10051-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add an entry summarizing the discussion about dealing with brightness
control on devices with more then 1 internal panel.

The original discussion can be found here:
https://lore.kernel.org/dri-devel/20220517152331.16217-1-hdegoede@redhat.com/

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/gpu/todo.rst | 68 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 7634c27ac562..393d218e4a0c 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -679,6 +679,74 @@ Contact: Sam Ravnborg
 
 Level: Advanced
 
+Brightness handling on devices with multiple internal panels
+============================================================
+
+On x86/ACPI devices there can be multiple backlight firmware interfaces:
+(ACPI) video, vendor specific and others. As well as direct/native (PWM)
+register programming by the KMS driver.
+
+To deal with this backlight drivers used on x86/ACPI call
+acpi_video_get_backlight_type() which has heuristics (+quirks) to select
+which backlight interface to use; and backlight drivers which do not match
+the returned type will not register themselves, so that only one backlight
+device gets registered (in a single GPU setup, see below).
+
+At the moment this more or less assumes that there will only
+be 1 (internal) panel on a system.
+
+On systems with 2 panels this may be a problem, depending on
+what interface acpi_video_get_backlight_type() selects:
+
+1. native: in this case the KMS driver is expected to know which backlight
+   device belongs to which output so everything should just work.
+2. video: this does support controlling multiple backlights, but some work
+   will need to be done to get the output <-> backlight device mapping
+
+The above assumes both panels will require the same backlight interface type.
+Things will break on systems with multiple panels where the 2 panels need
+a different type of control. E.g. one panel needs ACPI video backlight control,
+where as the other is using native backlight control. Currently in this case
+only one of the 2 required backlight devices will get registered, based on
+the acpi_video_get_backlight_type() return value.
+
+If this (theoretical) case ever shows up, then supporting this will need some
+work. A possible solution here would be to pass a device and connector-name
+to acpi_video_get_backlight_type() so that it can deal with this.
+
+Note in a way we already have a case where userspace sees 2 panels,
+in dual GPU laptop setups with a mux. On those systems we may see
+either 2 native backlight devices; or 2 native backlight devices.
+
+Userspace already has code to deal with this by detecting if the related
+panel is active (iow which way the mux between the GPU and the panels
+points) and then uses that backlight device. Userspace here very much
+assumes a single panel though. It picks only 1 of the 2 backlight devices
+and then only uses that one.
+
+Note that all userspace code (that I know off) is currently hardcoded
+to assume a single panel.
+
+Before the recent changes to not register multiple (e.g. video + native)
+/sys/class/backlight devices for a single panel (on a single GPU laptop),
+userspace would see multiple backlight devices all controlling the same
+backlight.
+
+To deal with this userspace had to always picks one preferred device under
+/sys/class/backlight and will ignore the others. So to support brightness
+control on multiple panels userspace will need to be updated too.
+
+There are plans to allow brightness control through the KMS API by adding
+a "display brightness" property to drm_connector objects for panels. This
+solves a number of issues with the /sys/class/backlight API, including not
+being able to map a sysfs backlight device to a specific connector. Any
+userspace changes to add support for brightness control on devices with
+multiple panels really should build on top of this new KMS property.
+
+Contact: Hans de Goede
+
+Level: Advanced
+
 Outside DRM
 ===========
 
-- 
2.37.2

