Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907DB799996
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Sep 2023 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjIIQZY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Sep 2023 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346350AbjIIOT2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Sep 2023 10:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1CCE6
        for <linux-acpi@vger.kernel.org>; Sat,  9 Sep 2023 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694269108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5JN87ipcZZDfzZpWfTfXhO7OlCurwlMxSfKyrmINDVg=;
        b=C84ibOzqDhK50RzU9LMw/U7gDCaSq5CPslTjELtKpODALU0HnjMrwJU9ILODB+j/1j6rAd
        HrQD2Vqhw9CszMKVN1pnXA9mECu2/i0KsLZv8KMlv41CBNlHtKh8I3VPCNmJvjAQjTXUY4
        VGXAIzobIKQCLnjrcyj/YYCrlahMx7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-z22lFYjAOXyydZBovXzZcg-1; Sat, 09 Sep 2023 10:18:23 -0400
X-MC-Unique: z22lFYjAOXyydZBovXzZcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E1508ABBC8;
        Sat,  9 Sep 2023 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F34511460FE7;
        Sat,  9 Sep 2023 14:18:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/8] x86-android-tablets: Stop using gpiolib private APIs
Date:   Sat,  9 Sep 2023 16:18:08 +0200
Message-ID: <20230909141816.58358-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Bart, et. al.,

As promised here is a patch-series to make the x86-android-tablets code
stop using gpiolib private APIs.

Patches 1-2 are (small) gpiolib-acpi.c patches to add a quirk
(using the existing quirk mechanisms) to allow removing
x86-android-tablets' acpi_gpiochip_free_interrupts() usage.

Since patches 3-4 depend on these I plan to add these to
the platform-drivers-x86-android-tablets immutable-branch / pull
with the entire set for you.

May I please have your (or Andy's or Mika's) Acked-by for
merging these 2 patches through this branch?

Patches 3-6 deal with actually removing the private gpiolib API usage.

Patches 7-8 are some small improvements on top.

My plan is to let these patches sit on the list for review for
a couple of days and then I'll prepare an immutable-branch
with 6.6-rc1 + this series and send you a pull-req for that
based on a signed tag.

Then you can base future versions of your
"gpio: convert users to gpio_device_find() and remove gpiochip_find()"
series on top and drop any workarounds for the x86-android-tablets
code from that patch-series.

Regards,

Hans


Hans de Goede (8):
  gpiolib: acpi: Check if a GPIO is listed in ignore_interrupt earlier
  gpiolib: acpi: Add a ignore interrupt quirk for Peaq C1010
  platform/x86: x86-android-tablets: Remove invalid_aei_gpiochip from
    Peaq C1010
  platform/x86: x86-android-tablets: Remove invalid_aei_gpiochip support
  platform/x86: x86-android-tablets: Create a platform_device from
    module_init()
  platform/x86: x86-android-tablets: Stop using gpiolib private APIs
  platform/x86: x86-android-tablets: Use platform-device as gpio-keys
    parent
  platform/x86: x86-android-tablets: Drop "linux,power-supply-name" from
    lenovo_yt3_bq25892_0_props[]

 drivers/gpio/gpiolib-acpi.c                   |  30 ++++-
 .../platform/x86/x86-android-tablets/asus.c   |   1 +
 .../platform/x86/x86-android-tablets/core.c   | 123 +++++++++++-------
 .../platform/x86/x86-android-tablets/lenovo.c |  29 ++---
 .../platform/x86/x86-android-tablets/other.c  |  11 +-
 .../x86-android-tablets/x86-android-tablets.h |   7 +-
 6 files changed, 124 insertions(+), 77 deletions(-)

-- 
2.41.0

