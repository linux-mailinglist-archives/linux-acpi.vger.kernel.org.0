Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D26860A347
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 13:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiJXLx1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 07:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiJXLws (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 07:52:48 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A5E28709
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:44:49 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id f193so8500466pgc.0
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpAa0dkS8XhA2GQ66lc5m8kkJugJVYjadMORUlQ0wPQ=;
        b=t0cdU8Gq6mNNYiksD6eEYKO8Asn+CT0EzR/trw2LnPyXm+rD6nqXsCYeQqjtM7gPYM
         czLtjzn9STZMwbg25oKJ+rchJIE1C3EbruYtUtL1fo+a90zdV4qc0tsyovLT5dJAiUGE
         qsy+4fAYnPcQVS0njH5jJLQI9FZmFytWkVQGNsnYWmnWaeNhpSPFlsctwJOWhSbiXeZ9
         h7w4BZ8ZVIJgYAYNUV3nlz9q7wdjdRwS9ZZ0zjcSCMcue0JOz1szUQizwPn6jyvjKFGF
         cxNAlwAh76EuqilV01f5017ZpYLpbgRwKmZuX/eFx2jyV1b0J3gkxlk7wW3OSfaxul6v
         yo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpAa0dkS8XhA2GQ66lc5m8kkJugJVYjadMORUlQ0wPQ=;
        b=CgAWc9m6NSKaB7x0qb/uoIBj2dpZz3Qp6Nay60R4G9UUOSsFoqq0QNZho/cRL5zjpN
         ocMT7cABC0hL2BssUpw3BcQzE2ak548XpSqGxf7uIUG0r9VJ/3CKgWYcTLGdtIsMp9Oh
         ya/q3zhRtg/8KtPhNpKazt7ZfJ3BzVNi27+ApHCrQVBBgd3/FzBK7v7WchLPinFpQddr
         rice2+AbLZpE/DF76ENcNgev4vMpGCxtpZ24Og9KCDb7qSApcwJ6eGSbaSGKy19L59qJ
         rblbmm2S7uoKbSk99+QAOic1EpM9EPUNj9QQy2oism+Z0GtBopM5bIdvUoTJOM46OnvH
         qEVQ==
X-Gm-Message-State: ACrzQf1nTCGdEi99WJPpVxcubumt2qyX9sNkBQBf8m8VVPruK+WO4or+
        /AksrS1AcyOsTZfPBpq6Qdn0Jg==
X-Google-Smtp-Source: AMsMyM6nms4lu3tkLOdZ9JNSQbhLjcWcRc9H/ekaTG+Ayy8xJMo8kAow4Lj5Qd758THxno/pN3RsVg==
X-Received: by 2002:a65:68cb:0:b0:460:b552:fbf4 with SMTP id k11-20020a6568cb000000b00460b552fbf4mr28051732pgt.457.1666611526061;
        Mon, 24 Oct 2022 04:38:46 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:38:45 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 22/22] ACPI: video: Fallback to native backlight
Date:   Mon, 24 Oct 2022 20:35:13 +0900
Message-Id: <20221024113513.5205-23-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024113513.5205-1-akihiko.odaki@daynix.com>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native()
helper") and following commits made native backlight unavailable if
CONFIG_ACPI_VIDEO is set and the backlight feature of ACPI video is
unavailable, which broke the backlight functionality on Lenovo ThinkPad
C13 Yoga Chromebook. Allow to fall back to native backlight in such
cases.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/acpi/video_detect.c | 4 ++--
 include/acpi/video.h        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 88462f2fb8cc..36354241c740 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -732,8 +732,8 @@ static int __acpi_video_get_backlight_types(bool native)
 			return ACPI_BACKLIGHT_VIDEO;
 	}
 
-	/* No ACPI video (old hw), use vendor specific fw methods. */
-	return ACPI_BACKLIGHT_VENDOR;
+	/* No ACPI video, use native or vendor specific fw methods. */
+	return ACPI_BACKLIGHT_VENDOR | ACPI_BACKLIGHT_NATIVE;
 }
 
 int acpi_video_get_backlight_types(void)
diff --git a/include/acpi/video.h b/include/acpi/video.h
index 5b748fdb606e..656b59acfd1f 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -76,7 +76,7 @@ static inline int acpi_video_get_edid(struct acpi_device *device, int type,
 }
 static inline int acpi_video_get_backlight_types(void)
 {
-	return ACPI_BACKLIGHT_VENDOR;
+	return ACPI_BACKLIGHT_VENDOR | ACPI_BACKLIGHT_NATIVE;
 }
 static inline bool acpi_video_backlight_use_native(void)
 {
-- 
2.37.3

