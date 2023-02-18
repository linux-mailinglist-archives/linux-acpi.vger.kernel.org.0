Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF65269B96C
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Feb 2023 11:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBRKdc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Feb 2023 05:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBRKda (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Feb 2023 05:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE641ADDF
        for <linux-acpi@vger.kernel.org>; Sat, 18 Feb 2023 02:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676716361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+trPnWf+vRJ2/iTAVbxTHjHnpzIARmxivvQmHCINeLI=;
        b=Gyhp63s0kTjRNN2qourVdx7qAindjLBUJao5WM3mYYSu+M1nJyx9AbjTLu5r+L3jc4E0Ac
        uKgt3z8kni+eLYEaGxC2E6jF+pUDuGEx3ewqqxpYRrwMyhF/9zmbsqK5HH2OLtNdMA+WOJ
        Nkxf2fshdVOLzIYXz9ry9YSitwUbKiM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-iLrO-an1P6O5kZPaiDdwCg-1; Sat, 18 Feb 2023 05:32:38 -0500
X-MC-Unique: iLrO-an1P6O5kZPaiDdwCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE78B1C05EBD;
        Sat, 18 Feb 2023 10:32:37 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4988B2026D4B;
        Sat, 18 Feb 2023 10:32:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 0/3] ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers() helper
Date:   Sat, 18 Feb 2023 11:32:32 +0100
Message-Id: <20230218103235.6934-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

<Resend with the gpiolib-acpi.c folks added to the To: list>

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

