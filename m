Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26068A094
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjBCRof (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjBCRoe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:44:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179A6D04D
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:44:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q5so5380637wrv.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoDsGvDWVRH6xhYZphiOr9pPdgfE1kVCaST6cHLsKjs=;
        b=vL1gLfG7ZTIMoWkMdcoeXI7O+uSAKEEXWVxFfJ1GFvrMIE3RhX5h7PAyCzKn9+pSA6
         0iLwkP9K9kXEb+VttNn64fEZAeQlpMY08ABs2MXxzFCtCQ6F7mNEjYduFo0Ag+d9D8D7
         poey5yn4cN3EtYmfKwewjTED58Co079ZM0sqIWmRCldpWiaLpjx5jkMGD846TTxnQ23r
         7uJLdQFnKU2Gu+/AVNlUfIZNQncUKH9WtgnqKDPlYBAMjMxVXQO0eLJww81M4L6Kzb7Q
         WZ9c1yQv31jw35wxVRgoRXnaJbvF85AaktehiwoN3gQxii55aTzxmztwRV/xsE2JUhuJ
         65xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoDsGvDWVRH6xhYZphiOr9pPdgfE1kVCaST6cHLsKjs=;
        b=IAhwpyWSolVRL9iMFXaKSDNqEtE/r2JCl53OyW2hED7ihnpHwDHFbwjgNXhTi/oA18
         4MGpIePvl9aOnbJdRut7i36QLKB4MNXAjLkRFLxGrUuXlqHh0yPcdeoAOCny0WldhBVZ
         uf2mSAE7uqxrogF2ZFo4cMdJurC+enHkMqNiqwocM1K7zinY7TCM6uJxrqyf5QeU5wDS
         Ss/3ciWz3p/4SH9YIvrOUS6hMlg1XWGzvaLBpMF3mnLLHtMI++wsR6ImptmxEgos2bXk
         MfHLOMQLuvwLl+H3KT6YIYpNjXF1pKZ1LxZmamkxStrpcyx9xy9eXjfOKD2W6GvBemER
         GwLg==
X-Gm-Message-State: AO0yUKUhbfErUKop+0om9hvmG1XMsvugdwJ8t7wdRhuBrsps2nhehAly
        cxgntyRMqNbUWLFTJx7PS3To8xjL+vCvt0Ml
X-Google-Smtp-Source: AK7set+wK9MXJ07L7xlk5RJhiN0moaTCNZP2D+V/KxjpTPxOAos1QHf03jXyc8DihpgUkfLcnBfGVA==
X-Received: by 2002:a05:6000:38e:b0:2bc:7fdd:9245 with SMTP id u14-20020a056000038e00b002bc7fdd9245mr10543864wrf.5.1675446272149;
        Fri, 03 Feb 2023 09:44:32 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 00/11] Generic trip points for ACPI
Date:   Fri,  3 Feb 2023 18:44:18 +0100
Message-Id: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
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

 drivers/acpi/thermal.c | 693 ++++++++++++++++++++++++++---------------
 1 file changed, 449 insertions(+), 244 deletions(-)

-- 
2.34.1

