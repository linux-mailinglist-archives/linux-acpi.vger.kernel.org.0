Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142575E5683
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 01:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiIUXEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 19:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIUXEt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 19:04:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BCD5303E;
        Wed, 21 Sep 2022 16:04:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so233663wms.4;
        Wed, 21 Sep 2022 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MO0iuegYftZgMTaVkMEpJ8NOG2X2uWjfilYBXSOUTbA=;
        b=EQYmWrAimRrjiHOhePo7fKml5BXN+oRbq6LHfu+R/T5YKkAuXSbYi9ujo6RIAZ6yoD
         bwlT3RPh/G1GwSELeUaIP+BCsomeTlXTwU92A1nNGCDtBo5b+ioEnnsA9leU0lBLgVFP
         Lgb59gMRAzH2vqHKuie1f1VEalW9rAZ73zTexGZ9K57DKwxgpf4mmpv+9vOWJ/ZRRGKM
         6Nd2juPWHJEW19+AQrS4+vDa0Ih0rrBLONjiay2RhH7Vh6+xE1ZE+Ru4M3brkWcHO4UA
         8m00sy4XpxYMKbpgQVjyFb39j9wZ6VJYJHnvJg4YOTyRUkgaEXgasMUiaSHD5MPxMQtL
         tXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MO0iuegYftZgMTaVkMEpJ8NOG2X2uWjfilYBXSOUTbA=;
        b=n0/I3vOP3maYjYuNMAbEIq2w6mSugkETN7/W5KR+i5PgE4EG7XQ5O6aNVlhWloL22t
         x9GYMolPpU02nY39T/9fOPKTTkrfBLlK7w4B6oJ9UzlwzhPoDlM9nyaB2WMw2Cofx7J4
         /4HhTVlvX2JcnEldG5RqgkYV+b0gwtstsxTkkCBoQKx2OvD0SWpsnpg1RUBc5RpazxJ6
         AOFyCs2DoAX9pJ/aZZFTaL7cum7vOuPl6jqPxWfKnN1U1SrwibsdbLe8NJY69zRWHVR7
         cv4XY1VAJBomBiPlzI8B9NSGgXnbvuEiG5hXZfG2HargRhPBmQb9OoRrcYUZIItbf0ky
         lS5g==
X-Gm-Message-State: ACrzQf35UYTcgETCgjhAGCLMLrDdANkMtTeMQxfB05myqSWVo4RxfQNW
        peQQIoXnN4X4RqiDNCMsgHgHHGIGF44=
X-Google-Smtp-Source: AMsMyM5UQ5aNlt3LD4kmMRgKwwqsCA93V+LO5pL+S7XErvnEEglfgtwFltmgdKR1idEpXGblJtsJCA==
X-Received: by 2002:a1c:f406:0:b0:3a5:d667:10 with SMTP id z6-20020a1cf406000000b003a5d6670010mr339287wma.70.1663801486706;
        Wed, 21 Sep 2022 16:04:46 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id x12-20020adfffcc000000b0022ac672654dsm3519252wrs.58.2022.09.21.16.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:04:46 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v3 0/5] Add multiple-consumer support to int3472-tps68470 driver
Date:   Thu, 22 Sep 2022 00:04:34 +0100
Message-Id: <20220921230439.768185-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all

At the moment there are a few places in the int3472-tps68470 driver that are
limited to just working with a single consuming device dependent on the PMIC.
There are systems where multiple camera sensors share a single TPS68470, so
we need to extend the driver to support them. This requires a couple of tweaks
to the ACPI functions to fetch dependent devices, which also assumes that only
a single dependent will be found.

The v2 for this series was some time ago...it's kept falling to the back of my
to-do list so I've only just gotten round to it; sorry about that. v2 here:

https://lore.kernel.org/linux-acpi/20220327161344.50477-1-djrscally@gmail.com/

Thanks
Dan

Daniel Scally (5):
  ACPI: scan: Add acpi_dev_get_next_consumer_dev()
  ACPI: bus: Add iterator for dependent devices
  platform/x86: int3472: Support multiple clock consumers
  platform/x86: int3472: Support multiple gpio lookups in board data
  platform/x86: int3472: Add board data for Surface Go2 IR camera

 drivers/acpi/scan.c                           | 40 +++++++---
 drivers/clk/clk-tps68470.c                    | 13 +++-
 drivers/platform/x86/intel/int3472/common.c   |  2 +-
 drivers/platform/x86/intel/int3472/tps68470.c | 76 ++++++++++++++++---
 drivers/platform/x86/intel/int3472/tps68470.h |  3 +-
 .../x86/intel/int3472/tps68470_board_data.c   | 54 ++++++++++++-
 include/acpi/acpi_bus.h                       | 15 +++-
 include/linux/platform_data/tps68470.h        |  7 +-
 8 files changed, 177 insertions(+), 33 deletions(-)

-- 
2.25.1

