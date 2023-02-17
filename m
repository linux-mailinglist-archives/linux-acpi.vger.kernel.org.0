Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D469AE68
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Feb 2023 15:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBQOw5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Feb 2023 09:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjBQOwy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Feb 2023 09:52:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD036E644
        for <linux-acpi@vger.kernel.org>; Fri, 17 Feb 2023 06:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676645525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IGD7klui2lg3FOhZKFYbccHdCBj47eCYARHj7tU/AKI=;
        b=dhEjy1uPxSjOxZSt6nLRjY4Z+xJrdNtVHS3yUqrO+3qEmTbzVZk1/A12YU/OKXyKF8HNSt
        MTJfOmwtc5mBpW5Whh9KqkfWVdR6DgCutcCz9u4/kRXFjYGgjy4A9JrDaNA3l/SyDGfW0q
        TBPB5BfdkxalwS75lZK03dwq2ZpS9oU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-fNQX-vtsNBSMFy3s4__saA-1; Fri, 17 Feb 2023 09:52:02 -0500
X-MC-Unique: fNQX-vtsNBSMFy3s4__saA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C40758028B0;
        Fri, 17 Feb 2023 14:52:01 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D94D3492C3E;
        Fri, 17 Feb 2023 14:52:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/3] ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers() helper
Date:   Fri, 17 Feb 2023 15:51:57 +0100
Message-Id: <20230217145200.31821-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

x86 ACPI boards which ship with only Android as their factory image usually
have pretty broken ACPI tables, relying on everything being hardcoded in
the factory kernel image and often disabling parts of the ACPI enumeration
kernel code to avoid the broken tables causing issues.

Part of this broken ACPI code is that sometimes these boards have _AEI
ACPI GPIO event handlers which are broken.

So far this has been dealt with in the platform/x86/x86-android-tablets.c
module by it calling acpi_gpiochip_free_interrupts() on gpiochip-s with
troublesome handlers to disable the handlers.

But this is racy and sometimes too late. This series adds a new
acpi_quirk_skip_gpio_event_handlers() function to drivers/acpi/x86/utils.c
using the existing DMI table for this to avoid duplication of DMI matches.

Patch 2 adds a new x86 Android tablet model which needs the new
SKIP_GPIO_EVENT_HANDLERS quirk.

Patch 3 uses acpi_quirk_skip_gpio_event_handlers() in axp288_charger.c
to deal with there not being a ACPI event handler to disable charging
from Vbus before enable 5V boost output on the tablets micro-USB conn.

Sebastian (sre), since patch 3 depends on patch 1, it is probably
easiest to just merge the entire series through the linux-pm tree.
May we have your ack for this ?

Regards,

Hans


Hans de Goede (3):
  ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers() helper
  ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 7 B1-750
  power: supply: axp288_charger: Use alt usb-id extcon on some x86
    android tablets

 drivers/acpi/x86/utils.c              | 34 ++++++++++++++++++++++++---
 drivers/gpio/gpiolib-acpi.c           |  3 +++
 drivers/power/supply/axp288_charger.c | 15 ++++++++++--
 include/acpi/acpi_bus.h               |  5 ++++
 4 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.39.1

