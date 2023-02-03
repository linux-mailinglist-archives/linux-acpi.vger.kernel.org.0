Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE968A047
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjBCRd6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjBCRdv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:33:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296BA4284
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:33:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so4447280wms.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdQwXSk6at4HTQQwAKtI4mmLfEPTQnP+6m7tLLX/JCM=;
        b=N7dRtRxLgR2H8Z7n0XTd9aWAm2GEDBZia3OGr4Y6fkL6SdTutP1BD7KNKSW6d7dx47
         ktFCX56E5g1ubKJm4/OnbTv40U6jkCFYl4XdwAe3xP7jamVEXP4ditpw2CnA1V7kDbSk
         Cqvylwb54ZMrDLxI2Bv9SN5SeRMW5bKJlKYhqQXmKg91caMv7t00F5Y3odgUmKj5p9fE
         BVeLfU9sZB/bt0XxKhFGtGC2m8/5E7MNPEUbUQNhmKPJfqsBplwGsZDXDF4vzsjWjLa4
         qRwshIki2940HADXdpZgD4TqQ4K0LHS+oX4En8kM2CzlrtaQgEe+EDiWqo/BqMPQVhOP
         BSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdQwXSk6at4HTQQwAKtI4mmLfEPTQnP+6m7tLLX/JCM=;
        b=Ncg74rPwfh9/v3EJrH5hhKH6idmMdtowl8Qig+0vMSc0TuERTQj4/8py2C4rDH1J6D
         UVC7pi9lMX67NbnkXO4CmHTlQLisn+KVU9cmFeBozyJgHuPxiEEk0m2tbhgz0oy77l3W
         9qr886vpI3DyX2nndM1iOozOYCRx3P4P3qSkHbCZ2OW+FrMfLQkTTkw2k9+yLSdQqrK/
         OfLWPcfelPCeCaHV4BF1/0RqdHDa39zlmg/gCUmELMVtaWQ5i5nLSyOsaAO20ukdFRAp
         uZgxYoPtb2ru3sPIrDJhhCEjTnXAUJ9lYgHGySBKoe2fcdXAeFBr/e1fN8CMlJvPAzFd
         H8Iw==
X-Gm-Message-State: AO0yUKVuKLXlvsKo4JqbnXfPc5+Y/qT/ALEOUpNww/QClnTMeEoN8Usi
        gyhOtXuHAP4khSRqAYq3sXlVzA==
X-Google-Smtp-Source: AK7set86tzxrkk8KEdyApTlZ4mRXwV81+0gOMkI+8qKNWexoAijxHWshS4TddCUKY8+E8raeRUH+1w==
X-Received: by 2002:a7b:c388:0:b0:3db:2e6e:7826 with SMTP id s8-20020a7bc388000000b003db2e6e7826mr12471715wmj.5.1675445627539;
        Fri, 03 Feb 2023 09:33:47 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:47 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 00/11] Generic trip points for ACPI
Date:   Fri,  3 Feb 2023 18:33:20 +0100
Message-Id: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
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

This series introduces the generic trip points usage in the thermal ACPI
driver. It provides a step by step changes to move the current code the
generic trip points.

I don't have an ACPI platform, the code is not tested.

The changes are based on top of linux-pm/linux-next


Daniel Lezcano (11):
  thermal/acpi: Remove the intermediate acpi_thermal_trip structure
  thermal/acpi: Change to a common acpi_thermal_trip structure
  thermal/acpi: Convert the acpi thermal trips to an array
  thermal/acpi: Move the active trip points to the same array
  thermal/acpi: Optimize get_trip_points()
  thermal/acpi: Encapsulate in functions the trip initialization
  thermal/acpi: Simplifify the condition check
  thermal/acpi: Remove active and enabled flags
  thermal/acpi: Convert the units to milli Celsuis
  thermal/acpi: Rewrite the trip point intialization to use the generic
    thermal trip
  thermal/acpi: Use the thermal framework ACPI API

 drivers/acpi/thermal.c | 683 ++++++++++++++++++++++++++---------------
 1 file changed, 439 insertions(+), 244 deletions(-)

-- 
2.34.1

