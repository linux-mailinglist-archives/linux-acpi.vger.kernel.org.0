Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76D46C4811
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Mar 2023 11:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCVKrS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Mar 2023 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjCVKrR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2023 06:47:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627705DEFE
        for <linux-acpi@vger.kernel.org>; Wed, 22 Mar 2023 03:46:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o2so11465769plg.4
        for <linux-acpi@vger.kernel.org>; Wed, 22 Mar 2023 03:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679482009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1i7/ik/z7PzthF0LtcXXLV4glwpiw3jmNHLrvqZUe4=;
        b=gp9ll4ixIWG02zkDEpUNYehV6ogQBclVEBYQjH8j4GurP2cp19o0LJ2Znt1KOnUH0i
         gJ/7JT2ZDzNLfl/0R/yA6dBhwBcFVEMmn6VIm25fvaok0CUiEQg9ifBehu6cOHyVVeGI
         cJQ6PKylpvj0Qdrnt+PLQqgaQrKG+1wcHzq+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1i7/ik/z7PzthF0LtcXXLV4glwpiw3jmNHLrvqZUe4=;
        b=gsmAsvrANpRitRVlI0Qffpbd1HwbAOv9HRd9zUF1zhT5EkCfFpsp2CiX2WOBpZqPtH
         2RB/vVcd5mdYJXidHKxjqp5h3XSheWljrKKaF5cDjHPFWUjO4VZMNWI2M7E9fuieykjT
         ZtTY1rMjz8d767VyJGCjfB+dWAJ/WyWOP3yJTCMT4EPDzoPhB690OBeq0Iai1YTm67jQ
         7gXpUekfs516vhL7uvn/XvcdTl7bApFnpIqe+pchS9WEtbDarUO4auXIhm67IaaTZXfy
         N4C6qiIHDGxkKwDwKDsshM49yKQ9PXYVjhFfziBYC6g/ecFC19eWZ2JaOEQkmRLuOXdT
         gkFQ==
X-Gm-Message-State: AO0yUKXcv7zIbJqt8t9Hbhs/upR7gi75+d0DWE1TENghJhvSybIZOqKu
        ZRApPJZDAq1S2gvePW9U5EftPA==
X-Google-Smtp-Source: AK7set9cCkJRlKlnXtH0IY4wVuZRd9EJOJLukMzvzq4+ZoVghave4Wi1qfLWigDe03muVZKKZJcemw==
X-Received: by 2002:a17:90b:4d83:b0:23f:9a73:c20b with SMTP id oj3-20020a17090b4d8300b0023f9a73c20bmr3074236pjb.18.1679482008842;
        Wed, 22 Mar 2023 03:46:48 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:343d:79bf:55f9:1da5])
        by smtp.gmail.com with ESMTPSA id hg4-20020a17090b300400b002340d317f3esm9508742pjb.52.2023.03.22.03.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:46:48 -0700 (PDT)
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
Cc:     Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-acpi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v14 00/10] Register Type-C mode-switch in DP bridge endpoints
Date:   Wed, 22 Mar 2023 18:46:29 +0800
Message-Id: <20230322104639.221402-1-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


This series introduces bindings for anx7625/it6505 to register Type-C
mode-switch in their output endpoints, and use data-lanes property to
describe the pin connections.

This series is not directly related to the built-in mux in anx7625,
which automatically switches between the two orientations of a single
Type-C connector. This series adds support of registering mode switches
for two downstream devices, while we use orientation switches for two
orientations of the Type-C connector.

The first two patch modifies fwnode_graph_devcon_matches and
cros_typec_init_ports to enable the registration of the switches.

Patch 4~6 introduce the bindings for anx7625 and the corresponding driver
modifications.

Patch 7~9 add similar bindings and driver changes for it6505.

v13: https://lore.kernel.org/all/20230303143350.815623-1-treapking@chromium.org/
v12: https://lore.kernel.org/all/20230221095054.1868277-1-treapking@chromium.org/
v11: https://lore.kernel.org/all/20230204133040.1236799-1-treapking@chromium.org/
v10: https://lore.kernel.org/all/20230112042104.4107253-1-treapking@chromium.org/
v9: https://lore.kernel.org/all/20230109084101.265664-1-treapking@chromium.org/
v8: https://lore.kernel.org/all/20230107102231.23682-1-treapking@chromium.org/
v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chromium.org/
v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chromium.org/
v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@chromium.org/

Changes in v14:
- Collect review tags
- Introduce a new Kconfig because it didn't build when CONFIG_TYPEC=m
- Add comments about devm_* usage
- Fix style issues

Changes in v13:
- Update the kernel doc of fwnode_connection_find_match
- Add typec_mode_switch_node_count helper
- Fix style issues
- Update a typo in the commit message
- Collect Reviewed-by tag

Changes in v12:
- Check the availability of the device node in fwnode_graph_devcon_matches
- Ensured valid access to "matches" in fwnode_graph_devcon_matches
- Updated the documentation in fwnode_connection_find_match(es)
- Add fwnode_for_each_typec_mode_switch macro
- Remove a duplicated dmesg in the helper
- Used IS_REACHABLE instead to guard the function signatures
- Removed the 4-lane binding in analogix,anx7625.yaml
- Reworded the description for the mode-switch property
- Fixed style issues in anx7625 driver
- Fixed the inverted orientation setting in anx7625 driver
- Changed "&ctx->client->dev" to "ctx->dev"
- Fixed the schema of "data-lanes" property for it6505
- Fixes style issues in it6505 driver
- Replaced &it6505->client->dev with it6505->dev
- Updated the error logs when parsing data-lanes property

Changes in v11:
- Added missing fwnode_handle_put in drivers/base/property.c
- Collected Acked-by tag
- Use fwnode helpers instead of DT
- Moved the helpers to a new file
- Use "reg" instead of "data-lanes" to determine the port number
- Updated the description of the endpoints in the bindings
- Referenced video-interfaces.yaml instead for the endpoints binding
- Removed duplicated definitions from inherited schema
- Moved the "data-lanes" parsing logics to bridge drivers
- Removed Kconfig dependencies for the bridge drivers
- Updated the usage of the private bridge driver data
- Added a clarification on the anx7625 built-in mux in the cover letter

Changes in v10:
- Collected Reviewed-by and Tested-by tags
- Replaced "void *" with "typec_mux_set_fn_t" for mux_set callbacks
- Print out the node name when errors on parsing DT
- Use dev_dbg instead of dev_warn when no Type-C switch nodes available
- Made the return path of drm_dp_register_mode_switch clearer
- Added a TODO for implementing orientation switch for anx7625
- Updated the commit message for the absence of orientation switch
- Fixed typo in the commit message

Changes in v9:
- Collected Reviewed-by tag
- Fixed subject prefix again
- Changed the naming of the example node for it6505

Changes in v8:
- Fixed the build issue when CONFIG_TYPEC=m
- Fixed some style issues
- Fixed the subject prefixes for the bindings patch
- Fixed the bindings for data-lanes properties

Changes in v7:
- Fix the long comment lines
- Extracted the common codes to a helper function
- Fixed style issues in anx7625 driver
- Removed DT property validation in anx7625 driver.
- Fixed style issues in it6505 driver
- Removed the redundant sleep in it6505 driver
- Removed DT property validation in it6505 driver
- Rebased to drm-misc-next
- Fixed indentations in bindings patches
- Added a new patch to fix indentations in Kconfig

Changes in v6:
- Changed it6505_typec_mux_set callback function to accommodate with
  the latest drm-misc patches
- Changed the driver implementation to accommodate with the new binding
- Dropped typec-switch binding and use endpoints and data-lanes properties
  to describe the pin connections
- Added new patches (patch 1,2,4) to fix probing issues
- Changed the bindings of it6505/anx7625 and modified the drivers
  accordingly
- Merged it6505/anx7625 driver changes into a single patch

Pin-yen Lin (8):
  drm/display: Add Type-C switch helpers
  dt-bindings: display: bridge: anx7625: Add mode-switch support
  drm/bridge: anx7625: Check for Type-C during panel registration
  drm/bridge: Remove redundant i2c_client in anx7625/it6505
  drm/bridge: anx7625: Register Type C mode switches
  dt-bindings: display: bridge: it6505: Add mode-switch support
  drm/bridge: it6505: Fix Kconfig indentation
  drm/bridge: it6505: Register Type C mode switches

Prashant Malani (2):
  device property: Add remote endpoint to devcon matcher
  platform/chrome: cros_ec_typec: Purge blocking switch devlinks

 .../display/bridge/analogix,anx7625.yaml      |  88 ++++-
 .../bindings/display/bridge/ite,it6505.yaml   | 101 +++++-
 drivers/base/property.c                       |  31 +-
 drivers/gpu/drm/bridge/Kconfig                |  20 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c     | 256 +++++++++++---
 drivers/gpu/drm/bridge/analogix/anx7625.h     |  22 +-
 drivers/gpu/drm/bridge/ite-it6505.c           | 318 ++++++++++++++----
 drivers/gpu/drm/display/Kconfig               |   8 +
 drivers/gpu/drm/display/Makefile              |   2 +
 drivers/gpu/drm/display/drm_dp_typec_helper.c | 105 ++++++
 drivers/platform/chrome/cros_ec_typec.c       |  10 +
 include/drm/display/drm_dp_helper.h           |  46 +++
 12 files changed, 855 insertions(+), 152 deletions(-)
 create mode 100644 drivers/gpu/drm/display/drm_dp_typec_helper.c

-- 
2.40.0.rc1.284.g88254d51c5-goog

