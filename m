Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92EF666A44
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jan 2023 05:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbjALEXU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Jan 2023 23:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbjALEWO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2023 23:22:14 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90F4915D
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 20:22:12 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 7so11982154pga.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 20:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08tc41QAkvFbPfqG9xFaXxlEL+CygmRv6gbW1qKfyT0=;
        b=B5rTvu21cB1Pvztm8jHvC80rb1+BLt39TQzgQuAiwLFONfkM0ra6deRHzxhaRehscV
         q8pfteWSIIfiqIsRaEUI/7FuMhjNZzIwC9hAyEuO0YNO0NKuDHn4sJZgF/nHP9Kgvlqv
         9nHCV5KdxevdTllYWjnCYu8586wYWfMkDf8lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08tc41QAkvFbPfqG9xFaXxlEL+CygmRv6gbW1qKfyT0=;
        b=nziD3RkQ0lPme/tJzhwS/kfrFPm1qwPIAEEn7EobtCNHjiAgBSmeIw94N4QWXmsIVe
         c61Czp2uQG9G5reHWAEU7wQ/8KtEOk3U/K1ra5gg359j3wqWBLZFZD6E8+/6lgKz5TYf
         V9fFwhJVm6pv5Ngs4sYQluoknMZfJnxnf/g9R3IuGT7b+kJFr1wkcNPlr22wiQiOLOD/
         1RAkXscYd5R8zL58niUB+qg95wo6ofbtAUfQJPTjSkA4yLXwZV0uEELcVeRRWJ4Xsoyj
         FU+OqZYBKIdjg8+FzikOxvvlr/IMeTofm+/ASeSDxCWJTjHXu8W5iUilDwdyd0MGKsfK
         u0pA==
X-Gm-Message-State: AFqh2kr7iS5z9f2U2ufXQ9IumqTxaCm46JNHf/KITTGJz+sfDzgUKTEQ
        3R66Sdjabnu2mYGNoTVfh0qRjw==
X-Google-Smtp-Source: AMrXdXvPDWRWvAEy23yDATr61v6ibCe4oHiINnKlEZfgCwdIByilVS/mdvq2OI8+1KVsEpuEH4ZCMw==
X-Received: by 2002:a62:870f:0:b0:582:bb80:58d7 with SMTP id i15-20020a62870f000000b00582bb8058d7mr4747262pfe.26.1673497332331;
        Wed, 11 Jan 2023 20:22:12 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:594f:5484:7591:d074])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78bc8000000b00582579cb0e0sm5519478pfd.129.2023.01.11.20.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 20:22:12 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, chrome-platform@lists.linux.dev,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v10 8/9] drm/bridge: it6505: Fix Kconfig indentation
Date:   Thu, 12 Jan 2023 12:21:03 +0800
Message-Id: <20230112042104.4107253-9-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112042104.4107253-1-treapking@chromium.org>
References: <20230112042104.4107253-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replace the spaces with tab characters in the Kconfig file.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v10:
- Collected Reviewed-by tag

Changes in v7:
- New in v7

 drivers/gpu/drm/bridge/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 57946d80b02d..737578dd57ed 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -85,19 +85,19 @@ config DRM_FSL_LDB
 	  Support for i.MX8MP DPI-to-LVDS on-SoC encoder.
 
 config DRM_ITE_IT6505
-        tristate "ITE IT6505 DisplayPort bridge"
-        depends on OF
+	tristate "ITE IT6505 DisplayPort bridge"
+	depends on OF
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDCP_HELPER
 	select DRM_DISPLAY_HELPER
-        select DRM_DP_AUX_BUS
-        select DRM_KMS_HELPER
-        select DRM_DP_HELPER
-        select EXTCON
-        select CRYPTO
-        select CRYPTO_HASH
-        help
-          ITE IT6505 DisplayPort bridge chip driver.
+	select DRM_DP_AUX_BUS
+	select DRM_KMS_HELPER
+	select DRM_DP_HELPER
+	select EXTCON
+	select CRYPTO
+	select CRYPTO_HASH
+	help
+	  ITE IT6505 DisplayPort bridge chip driver.
 
 config DRM_LONTIUM_LT8912B
 	tristate "Lontium LT8912B DSI/HDMI bridge"
-- 
2.39.0.314.g84b9a713c41-goog

