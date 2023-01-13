Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE94866A187
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jan 2023 19:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjAMSIP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Jan 2023 13:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAMSHv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jan 2023 13:07:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127F7C388
        for <linux-acpi@vger.kernel.org>; Fri, 13 Jan 2023 10:02:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so17943643wms.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Jan 2023 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Az+ftUwxnjeSykCqxp/VBoimqkVshao7VEmsaRnDBos=;
        b=R7p79Bk11Gk/HhYTyPPHIVL9WhxNrq0sN+BJePVa6RdwAPIK7pJ5nmN1IlC0y7hnjy
         S2/y5ULj3sX9kjS+f4+7V+ak5n5fhcuEKScimD+HK5/YA+OiUExUnelLlU1C5lD2WETJ
         S6BahYB7+yaWJ4rmeYPo2FeHz45ZS54+TE4YTKY1G4w5ifXQfM8lAMcPHGu4Ph3k0nN8
         RW8n/nnTu6jlgqnezzKQdC3SsglKdORhGn65EBopu3udZ5fmHtyjMSFOcOpfRCDKCG9P
         LxAIfCOpMjfj7L+YRfydVExFCW7YPn7VkyfTnBm1QdpLmIQ2kifRwZduOIcsDK2TP9VF
         0aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Az+ftUwxnjeSykCqxp/VBoimqkVshao7VEmsaRnDBos=;
        b=iDFknJZinjbebYOPEgqRdXTrF3LFFZLoxFmOjH62mWAULehRc9hWMm8iXlfW8UXoWH
         qETH/TsewEwkAQX3ysSFVk7dmSF7oSMGmlhR3R4TYG7mNGOxT3rdnADQiO4vG5Vbh+hM
         FDJmfaJh/s/LbxvRmx6iRuN9nGiTlId2xmo/wV8J0RUJ5OsrdcIsnjBMjtjahyVlndGG
         KT2JOjEay6hOkLB9IGeO6gMuHm0UjXs6WSyV4JPsJqgGN5+RYBnjRsaKuVT08M2i1Sm4
         mPp8B0Rw+nctCfQm8nNgA3zM4QgCzWzMBjE9ecq0Jn/tMth58eUwIvIGINfXt7Bz5QBa
         UUXg==
X-Gm-Message-State: AFqh2kq/keXvNOYG0UA3HqJlNKZoR+UMfVa3ibfzhv8/7q3InDeaQWV4
        q8qWYj15YknmIjBnBbFwqQu53Q==
X-Google-Smtp-Source: AMrXdXuMtaqozmZBVDnHbd+2elDneZyA+lyQKvLzgwsP9QUXaokXNlSIv4cxBjwKleMO/dC4RoMKfQ==
X-Received: by 2002:a05:600c:18a3:b0:3d1:fcac:3c95 with SMTP id x35-20020a05600c18a300b003d1fcac3c95mr59660292wmp.34.1673632960467;
        Fri, 13 Jan 2023 10:02:40 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b002426d0a4048sm20057227wrn.49.2023.01.13.10.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:02:39 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
Subject: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Date:   Fri, 13 Jan 2023 19:02:32 +0100
Message-Id: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Recently sent as a RFC, the thermal ACPI for generic trip points is a set of
functions to fill the generic trip points structure which will become the
standard structure for the thermal framework and its users.

Different Intel drivers and the ACPI thermal driver are using the ACPI tables to
get the thermal zone information. As those are getting the same information,
providing this set of ACPI function with the generic trip points will
consolidate the code.

Also, the Intel PCH and the Intel 34xx drivers are converted to use the generic
trip points relying on the ACPI generic trip point parsing functions.

These changes have been tested on a Thinkpad Lenovo x280 with the PCH and
INT34xx drivers. No regression have been observed, the trip points remain the
same for what is described on this system.

Changelog:
 - V5:
   - Fixed GTSH unit conversion, deciK -> milli C

 - V4:
   - Fixed Kconfig option dependency, select THERMAL_ACPI if ACPI is set
     only for the PCH driver

 - V3:
   - Took into account Rafael's comments
   - Used a silence option THERMAL_ACPI in order to stay consistent
     with THERMAL_OF. It is up to the API user to select the option.

 - V2:
   - Fix the thermal ACPI patch where the thermal_acpi.c was not included in
     the series
   - Provide a couple of users of this API which could have been tested on a
     real system

Daniel Lezcano (3):
  thermal/acpi: Add ACPI trip point routines
  thermal/drivers/intel: Use generic trip points for intel_pch
  thermal/drivers/intel: Use generic trip points int340x

 drivers/thermal/Kconfig                       |   4 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/intel/Kconfig                 |   1 +
 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++-----------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 drivers/thermal/intel/intel_pch_thermal.c     |  88 ++------
 drivers/thermal/thermal_acpi.c                | 210 ++++++++++++++++++
 include/linux/thermal.h                       |   8 +
 9 files changed, 286 insertions(+), 214 deletions(-)
 create mode 100644 drivers/thermal/thermal_acpi.c

-- 
2.34.1

