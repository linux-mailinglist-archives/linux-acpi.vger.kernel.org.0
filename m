Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E56D1BA9
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Mar 2023 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjCaJOD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Mar 2023 05:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjCaJNU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Mar 2023 05:13:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4977B1FD39
        for <linux-acpi@vger.kernel.org>; Fri, 31 Mar 2023 02:12:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j13so19846810pjd.1
        for <linux-acpi@vger.kernel.org>; Fri, 31 Mar 2023 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680253964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bEto7ubn5V4uzMDEQriLskthJ74k1pNwsNQE693rnk=;
        b=MT1GyQugNsVUVRzTQ/JdPyMldZtAKmlvHsJ1/lgZHuREmZczM8LjsMH7wLy+SRXGDh
         HB3kLoxoNno4Vn4RAFrWBi1d9hWcrf/Vx+y9ztFLZ1+Nd0xR8TfIj2qppkmoSOOhuWbQ
         JfTYS+CQ/8n7QDq9Qqqzdtu4v3qqdfEk8Jm+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bEto7ubn5V4uzMDEQriLskthJ74k1pNwsNQE693rnk=;
        b=VR8oEsuZjrmXxhkDhIaRFMkkmSsEE/iEQDeLX9D0zhqJFv5SAJMH77Xs/CYVjRAHWl
         a7YRNDGoS5FZcKMrpUIu09194rrK0eCxQH31dtk9sriE/0xEN4xolamg65pWOhCGeqMe
         gkAhxNC4gAqOaTdfaBeJxBmEwP+eNSVo8q/IshPS6DRkEPu5Z8SJO7WrhS3di/4ByBEU
         7o0Dc0KC0ppa/+muFw3P0cQ9GP/mg/1XzCSdRMoN1jexuC9A/ewaHUv09ZA7BeWYLDp7
         Yvn+z+0PBv+p2L/msZuD11FMPkXcJpm3Wf+/myrCsQ4Zv8sYSt9D90zggoNCq4ZoV1rL
         f/+A==
X-Gm-Message-State: AO0yUKVl5Vzf1dQ0XUfIhNsvE4IDsuK8lTIR2/wAKxeUqFLvPAWeh9jS
        8lRHLdjjS6KtTBLfmQANW3OS+Q==
X-Google-Smtp-Source: AK7set9NYXYCY1EhR0WY8aHIIA1IYH3nhhCM2AQZabuZ1dCpAtdF13z4QVJxlWaBeNSIQGGmh8TTnA==
X-Received: by 2002:a05:6a20:2921:b0:d5:f7f5:85e4 with SMTP id t33-20020a056a20292100b000d5f7f585e4mr22155856pzf.22.1680253964628;
        Fri, 31 Mar 2023 02:12:44 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:ae9d:db7a:8a71:d458])
        by smtp.gmail.com with ESMTPSA id n6-20020a62e506000000b006227c3d5e29sm1360905pff.16.2023.03.31.02.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 02:12:44 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
Cc:     Xin Ji <xji@analogixsemi.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lyude Paul <lyude@redhat.com>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pin-yen Lin <treapking@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v15 09/10] drm/bridge: it6505: Fix Kconfig indentation
Date:   Fri, 31 Mar 2023 17:11:44 +0800
Message-Id: <20230331091145.737305-10-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331091145.737305-1-treapking@chromium.org>
References: <20230331091145.737305-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

(no changes since v10)

Changes in v10:
- Collected Reviewed-by tag

Changes in v7:
- New in v7

 drivers/gpu/drm/bridge/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index f076a09afac0..8f81311710e5 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -74,19 +74,19 @@ config DRM_FSL_LDB
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
2.40.0.348.gf938b09366-goog

