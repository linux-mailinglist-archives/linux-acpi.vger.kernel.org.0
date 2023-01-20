Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAC467614C
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jan 2023 00:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjATXPs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 18:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjATXPq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 18:15:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BCD72B8
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2023 15:15:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t5so6118648wrq.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2023 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcdsDDfSv/wOa26KZForZ8gEXRm+p3O2oR+ZEYCfkv4=;
        b=TMyYtdLS+kw/Y7uOKSZDlvFr4P5eCu4SU6aqXmXP5IhaJx/7BOZpvvn9IQ1Y2gmX2Y
         0HTPw2tiIat4yLQmAPd5zBqbGRCWHkdnHe+ynj9z7oXVvilNcnk8Wt1dnFB0bc95MMyz
         VzEdMjlN7BF5n0zW5MqttwEvZdP0gpy09qLK/XdrD2pGNqdOKlwIHTH5jtYXhDqe11AX
         jmKoEWhoQYKPIAVckHP9BFHmR80Run9MlE1TWsgHpcBO5q1CbpjpqcXs53voEcUiaqBm
         5Wj/MS+2Ej1I0mt8ydXvrxeqkgmkYuKgyVobfadhI4sSjW96Pf3PmUychMxqT7otDILe
         vMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcdsDDfSv/wOa26KZForZ8gEXRm+p3O2oR+ZEYCfkv4=;
        b=GJ46IPZgZ0ZUb/5HQRT6/sQ82wiBakbOAciYTfB7WXG5HPAl6ObJBMivUgTjKbZvyA
         SCLTsGmCDL4+xUGXOqistPcSEIO8A6AJUh2buSXWaCD4rK8u3yCEkovL38wjq3KHk7z0
         H9iiG/yYZZFXm0mfxtIoZEU76dtMZFC61LLpgTyK0UJO+IG1rQakuXVTtogmJOA9Gq+j
         YvpPMHJsCybysm5N50YePNnQPuk5byGyfJrT5lJjXuSWiLHqcCkGoG9ing9U81gOrdOP
         OFkdBns243T+igYekTy65KYS50IDcAgjlzKPn6YfuuwnGLfDuM3N3YgwDAx5xwIS0Qa2
         WjVA==
X-Gm-Message-State: AFqh2koQOZDQL6xkdnlTsjPxHS09moMRaLsU9wcdzQw/HaXOeRLEJEPg
        PfenqUx8ems4nj0AEKg/ZmzZqQ==
X-Google-Smtp-Source: AMrXdXu5uRtEXEjUmBxsqEg9GL5wXWVse6JOwIon7LMB1tEA+GaItIVqoZboTQ60rlO/FQLPmy2ChA==
X-Received: by 2002:a5d:6102:0:b0:2bd:beac:ef7b with SMTP id v2-20020a5d6102000000b002bdbeacef7bmr14686709wrt.52.1674256543948;
        Fri, 20 Jan 2023 15:15:43 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm36436828wrx.21.2023.01.20.15.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 15:15:43 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
Subject: [PATCH v6 0/3] Thermal ACPI APIs for generic trip points
Date:   Sat, 21 Jan 2023 00:15:27 +0100
Message-Id: <20230120231530.2368330-1-daniel.lezcano@linaro.org>
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
 - V6:
   - Changed thermal ACPI function names according the changes done in the first patch
   - Put back the GTSH function here as it is specific to int340x
   - Propagate the function name change from thermal ACPI
   - Changed the functions name and prototype to return the temperature
     instead of passing a pointer
   - Removed the GTSH function as it does not belong to the ACPI standard
   - Changed hysteresis -> hyst, temperature -> temp
   - Changed message level info -> debug
   - Changed error messages
   - Return -ENODATA error only
   - Fixed description functions
 
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
 .../int340x_thermal/int340x_thermal_zone.c    | 168 ++++------------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 drivers/thermal/intel/intel_pch_thermal.c     |  88 ++-------
 drivers/thermal/thermal_acpi.c                | 185 ++++++++++++++++++
 include/linux/thermal.h                       |   7 +
 9 files changed, 263 insertions(+), 202 deletions(-)
 create mode 100644 drivers/thermal/thermal_acpi.c

-- 
2.34.1

