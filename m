Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4054B941F
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Feb 2022 23:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbiBPWxg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Feb 2022 17:53:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiBPWxf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2022 17:53:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9311721FC55;
        Wed, 16 Feb 2022 14:53:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p9so5765373wra.12;
        Wed, 16 Feb 2022 14:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E16p9hY28NzrU0rxusUep8YgmPYYqLJtUXmi7YY7EFQ=;
        b=BnayIvFterfc5jZms9fbNhtBocsZgUzwm0FWa5IhGN/6ZUaWDA0G1POf28nLL9zy2P
         wE1i1E/mKomnEdavNhs2q9MXrsfAutlRc3LUyqoOjZHFkANzS1tY0VlzYFAJG4tDt2yu
         FrUhBM7w/wOTVTjofFpDauMSBb2lg30te2D9psXfNpngYusyrlDXFhY1QvThLco+8qXW
         yDbVhei08lNWAoM2wCh0/GYyULYETuwQ6/puNhACBxSVZMVFguwi0deast/WfHRT4+36
         kF5g0ub4G2eEJtOEakAnzNvzdq3LOqrxaFbfL20IDeaG223hL727YgC3Ijzo2u6tLFEE
         Xg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E16p9hY28NzrU0rxusUep8YgmPYYqLJtUXmi7YY7EFQ=;
        b=BWeCM+Bi4/PKGZdR2RsaFtMmDhNjlYaL5rm60Wtj7jpPgE8OsZOsNeZK/L1bAgJxhq
         w5qTiytAfGXfkUv5zdcXSnsd9DRj3tVgttFcwaXjNMS9msuNbYjXuQ8PkUstc4rediSp
         phsrivM84LnhIjwD0AlBbpc6ODrBzzUa2XWogtOaWfCjdia/lEFvWH6zIWzgVmhf5FIW
         UtrEMlwnIJP9Q/yNr85pG3jq04M8BqH4JX0YURtCJyRy04HaK1vdhQhnPaAdS9mi3DYm
         HQ/5yf25yBjLxhK2+vhBP77j4eVJCCmTmon+BgdfqFd+yWbBbtSokOE1BfMYae64FV7f
         hZ0A==
X-Gm-Message-State: AOAM531JKjcqEhWpItKf1w67rgAl5ONVpjrXkC6kdpchfG+X1NI51ZMc
        C+kahK/dgh50Uk1uJ5ePKh+3JQ6+kbH/AA==
X-Google-Smtp-Source: ABdhPJzE6DoNt6zrIR3fKBR7Kko/xPZLDHy5E3JtH2jkkQoKURtOc6Fa/KoM9tK+MWS0cvuh1/7ayg==
X-Received: by 2002:adf:f68d:0:b0:1e1:db49:a721 with SMTP id v13-20020adff68d000000b001e1db49a721mr136348wrp.297.1645052000091;
        Wed, 16 Feb 2022 14:53:20 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id o125sm182539wme.37.2022.02.16.14.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:53:18 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH 0/6] Add multiple-consumer support to int3472-tps68470 driver
Date:   Wed, 16 Feb 2022 22:52:58 +0000
Message-Id: <20220216225304.53911-1-djrscally@gmail.com>
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

At the moment there are a few places in the int3472-tps68470 driver that are
limited to just working with a single consuming device dependent on the PMIC.
There are systems where multiple camera sensors share a single TPS68470, so
we need to extend the driver to support them. This requires a couple of tweaks
to the ACPI functions to fetch dependent devices, which also assumes that only
a single dependent will be found.

Hans - this (plus a series to media [1]) adds support for the Surface Go 2's
IR camera...the regulator settings for the Go1/2/3 world facing camera are the
same, so I'd expect them to match for the IR sensor too, which means it should
enable support for your Go too.

Thanks
Dan


[1] https://lore.kernel.org/linux-media/20220215230737.1870630-1-djrscally@gmail.com/

Daniel Scally (6):
  ACPI: scan: Add acpi_dev_get_next_consumer_dev()
  ACPI: bus: Add iterator for dependent devices
  platform/x86: int3472: Support multiple clock consumers
  platform/x86: int3472: Add terminator to gpiod_lookup_table
  platform/x86: int3472: Support multiple gpio lookups in board data
  platform/x86: int3472: Add board data for Surface Go2 IR camera

 drivers/acpi/scan.c                           | 47 +++++++++--
 drivers/clk/clk-tps68470.c                    | 13 +++-
 drivers/platform/x86/intel/int3472/tps68470.c | 77 +++++++++++++++----
 drivers/platform/x86/intel/int3472/tps68470.h |  3 +-
 .../x86/intel/int3472/tps68470_board_data.c   | 58 +++++++++++++-
 include/acpi/acpi_bus.h                       | 14 ++++
 include/linux/platform_data/tps68470.h        |  7 +-
 7 files changed, 188 insertions(+), 31 deletions(-)

-- 
2.25.1

