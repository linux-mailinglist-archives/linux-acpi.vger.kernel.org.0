Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7A74E88B7
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Mar 2022 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiC0QPe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Mar 2022 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiC0QPd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Mar 2022 12:15:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D00286E9;
        Sun, 27 Mar 2022 09:13:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so17072943wrg.3;
        Sun, 27 Mar 2022 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k5yR5jrH/QMMXMCp4FJlnl5oTgs/o/5E/vpww8mY/54=;
        b=W7iEGq181SF5B/oPVnKwGGKZGriuKje1/Ae7uTeUO2MpBiTgTa0yGyAJDgdLOqnOFd
         ZNKh7TF9SRhNY4r1ev5SyIAlkhe6+lD1S7zZjYjw1zRTXYZAnnmiVLgYVsR44p49uOYT
         6kxo4VkmA9hmrrO9mrnOlHCk7hvRLEi6Ye57uXYjfSHNuNhFJlB2HdyMQ4od6H3It8IL
         WmTQufLmdjoZvfRj++DoC2evVVRRGoEUYXLSUJYM+FVRJFu99g9tzAX7IVIv3hWj9tCK
         ywmDVc7kykX6o0MYOtn7083C+iFNUBR3MMUNn25yxC+68Rw8BYbbzLbEDzHgsX2gmSU2
         Wx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k5yR5jrH/QMMXMCp4FJlnl5oTgs/o/5E/vpww8mY/54=;
        b=unB8rlM3DGqgx6ym2Q1sCn7vbjwpMVeYgETuJstN9M0TARl7sOffRxcWducvkKo6sm
         2CuPKQzaSvthGU0cVsBrg9en4cxRNDKjQDZ/VPKqcOM0BepBoiQaS80D1boaXnTMfYZr
         joafbClWmT8LvDJr1Gq0jfoWprL4B7pi7W1oLo5ZXbCkL8v4nE1ijcjS5aOJ6z9N7Zzi
         MDlaIGV6Jq9m4K/33453qvBjWewS5wFnT3fFxijyP7ulYyRf5aIYYZvAeqPyDGmY0gqy
         iPodoxVleNDV95I/ASIhx3LqvCWSmNZUCEtHLkjvuCfIieLdnh3ZyWCV8+0N7hGcamOO
         OyQQ==
X-Gm-Message-State: AOAM532KV1a8nr2Bk1Xsm7dcS6uKsqUhGa+XQAy0HeFC178YsRFw7YJj
        uOY3mAQd3rI7MEyRGX8Kc6KnrWRyMdo=
X-Google-Smtp-Source: ABdhPJy9QTFoMyvXu3WMfSPi8K+acQPuFbNvwArjyHRbFj2ZA0SmQfgdqW7B0Xy9je2AXHOn+UyS5A==
X-Received: by 2002:a05:6000:181:b0:205:c1b9:7b10 with SMTP id p1-20020a056000018100b00205c1b97b10mr925459wrx.171.1648397633524;
        Sun, 27 Mar 2022 09:13:53 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm13764924wme.39.2022.03.27.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:13:53 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v2 0/5] Add multiple-consumer support to int3472-tps68470 driver
Date:   Sun, 27 Mar 2022 17:13:39 +0100
Message-Id: <20220327161344.50477-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Series level changes in v2:

- Dropped the patch that added a terminator to the existing tps68470 board data

The v1 can be found here:

https://lore.kernel.org/platform-driver-x86/20220216225304.53911-1-djrscally@gmail.com/

Thanks
Dan

Daniel Scally (5):
  ACPI: scan: Add acpi_dev_get_next_consumer_dev()
  ACPI: bus: Add iterator for dependent devices
  platform/x86: int3472: Support multiple clock consumers
  platform/x86: int3472: Support multiple gpio lookups in board data
  platform/x86: int3472: Add board data for Surface Go2 IR camera

 drivers/acpi/scan.c                           | 37 ++++++---
 drivers/clk/clk-tps68470.c                    | 13 +++-
 drivers/platform/x86/intel/int3472/common.c   |  2 +-
 drivers/platform/x86/intel/int3472/tps68470.c | 76 ++++++++++++++++---
 drivers/platform/x86/intel/int3472/tps68470.h |  3 +-
 .../x86/intel/int3472/tps68470_board_data.c   | 49 +++++++++++-
 include/acpi/acpi_bus.h                       | 15 +++-
 include/linux/platform_data/tps68470.h        |  7 +-
 8 files changed, 169 insertions(+), 33 deletions(-)

-- 
2.25.1

