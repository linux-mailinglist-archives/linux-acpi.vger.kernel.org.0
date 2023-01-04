Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3220865DFD6
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jan 2023 23:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbjADWVe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Jan 2023 17:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbjADWVd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jan 2023 17:21:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C340874
        for <linux-acpi@vger.kernel.org>; Wed,  4 Jan 2023 14:21:31 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t15so25603503wro.9
        for <linux-acpi@vger.kernel.org>; Wed, 04 Jan 2023 14:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=weOUQoZCFA8L0eGcVwVPrrrKunEzGQwEXtU4PkZVHt4=;
        b=xodKISgLoCBgs7Su4XuU1EVy+K1ccTNKgy5OUIBCl4ZgLURBRepzOs6ysodIVYWbD6
         Qai8K2QUiSCLVoTwy0ua8/dpIqnrVityd1Z+acPWEaHhElugyxJongd6SV5Kv2Fgzao6
         LjyjXT5ygRgf4y07HMRVWtDqea1kDvkp0zy70qxrafDOgeUgg/0P1niqhYTa/0pM2sUX
         TDRYNY+2iw9JwYj4S6s0qXd1SzKjkIxrw5/TZg2FAuTN6UBaikT90pwmBpcfstWFP/MY
         tS59vs8hXAnAMmTQtT0FRr3sIy6R7xmx9x0wgimFNCYeZ4Y+ynpkRyeNBEWx6/loDOyq
         zCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weOUQoZCFA8L0eGcVwVPrrrKunEzGQwEXtU4PkZVHt4=;
        b=1IblFLarnYkZI6GNWtYWKSDv/BpFe9hp+e/6X2nFtNzUpBDtE4OHd3PHC6y6wu+aAW
         e+wFblNHvSj8+E3X45v5bdO/khF4UPVYXWhHsHtnJGeIGqw2KIesPFXyn899SprST834
         ro0GVV635OBiXZEzMTqbKts5xhBJcrRxgbXgb8xCJI7TzpOZJBPn7jiA4maydYvFB/UB
         Nmc+K1jl4VK8cWujU7fwTIgobwnYVFu3PPmcxtD19SV1Cbw1DI8v8uPe1YuGP42vwHDr
         x08fetLWZPKBNO6V/O7OTO+tSzvwLNC7PGfu1O5jyGTu5DkVckWa+0NJ+dOVON+fK2Py
         300w==
X-Gm-Message-State: AFqh2koi92Gz8arU0t2J04WNmuUXWbsmSVt3ApsSI5bVDJwnak52CMpY
        RQ6OE4fpMTnrpljQUVZgr0J9Vg==
X-Google-Smtp-Source: AMrXdXuz1EnvJFYd7vhdPhtANn7B/Gb8pTWJCW+Q8og+hzlk95NlwAEE218zp3R96Tnx+71zqwC93g==
X-Received: by 2002:a05:6000:609:b0:242:eda:dda5 with SMTP id bn9-20020a056000060900b002420edadda5mr33338899wrb.25.1672870890389;
        Wed, 04 Jan 2023 14:21:30 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l7-20020adfc787000000b002238ea5750csm42430278wrg.72.2023.01.04.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:21:30 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com,
        christophe.jaillet@wanadoo.fr
Subject: [PATCH v3 0/3] Thermal ACPI APIs for generic trip points
Date:   Wed,  4 Jan 2023 23:21:24 +0100
Message-Id: <20230104222127.2364396-1-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++----------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 drivers/thermal/intel/intel_pch_thermal.c     |  88 ++-----
 drivers/thermal/thermal_acpi.c                | 218 ++++++++++++++++++
 include/linux/thermal.h                       |   8 +
 9 files changed, 294 insertions(+), 214 deletions(-)
 create mode 100644 drivers/thermal/thermal_acpi.c

-- 
2.34.1

