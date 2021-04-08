Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369D43580F4
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 12:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhDHKi7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhDHKif (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Apr 2021 06:38:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E21EC061762
        for <linux-acpi@vger.kernel.org>; Thu,  8 Apr 2021 03:38:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d12so3102795lfv.11
        for <linux-acpi@vger.kernel.org>; Thu, 08 Apr 2021 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Dzt19+hlPVIz0YLN8KJuct972F2r6QsHkf1KVpok9Jw=;
        b=n34jYnTBB8NufKCgd4r73nOWY8Zo+Ioc4UlGa4V6hZFtot9PHH2xcCur9owLtx6bGV
         W3Vsu/DIwnNi9ZhB6KlGy1eIMMgJNENIZJD66Svt3WJpONRJD5CGEAPS7rBndmoVv5ot
         2psZzJWTdH37sbcXMn9x1A73Ym0/08JeWS6KMx0xKq/e06iycNsDOahHCeDHWc7KPMyr
         YzOLiA1MkpRfGOa0fMmVYh1cFoQZcqT1xKnW/x1pp/JNTgvL9NvxResstFLhek/EsYGL
         XuOkj9A/R600WGKrVNhOWWHKQPkRbvAvg/fWmBpASeS71t3kFcefRF2B8ttRar2sqJzv
         DQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dzt19+hlPVIz0YLN8KJuct972F2r6QsHkf1KVpok9Jw=;
        b=G89XJ7Lf+MAyknz4cQQtBxUQaeTcNBMJ0M0+Uke26Bpntjji3s/CCxfICqAy33je7V
         rTXGkrBwX4Zec8TB1eUsJUrmkPuab7KMCxJlTWf+jFhSoxY/qrokmPFWNwAyIurD9J+1
         MbmCh6PJwCBExH5zYaclrJiyRHI+KDRVyw28cInDOTdVsMDAWu61bpcgUQ/r+n63dTaz
         lJRyS1uIAUlcSe+F9FvXNZsF9chB0RD4tjW2k5TC+eOzmOKK4j+rg8xuYaiPsOphYebA
         iARrhnCTAoHAUn8Rj6S5CFeGLatYRyYH4QVUF3/ezOOFaq04DjdhcYFoN29UVXXoZmuP
         P4qQ==
X-Gm-Message-State: AOAM530f8SeOy1dD7k18yoLwaQoqmb6bk1L39pQbp/O56uV5RfgopIRd
        pHw3BvY5bFXbg7G/33RJ9FIdLjUO6lCQe0NV2rg=
X-Google-Smtp-Source: ABdhPJwn/pOXaFJBOM0BIWP7SFp+d3De64BLW7csc9wdZn7T0ke25IZdFjm2OyWOtB5yvTmOQE3fSw==
X-Received: by 2002:a19:b81:: with SMTP id 123mr5777130lfl.553.1617878301489;
        Thu, 08 Apr 2021 03:38:21 -0700 (PDT)
Received: from localhost.localdomain (host-193.106.246.138.static.3s.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id c9sm2863007lfv.10.2021.04.08.03.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 03:38:20 -0700 (PDT)
From:   Angela Czubak <acz@semihalf.com>
To:     rafael.j.wysocki@intel.com
Cc:     akpm@linux-foundation.org, mika.westerberg@linux.intel.com,
        john.garry@huawei.com, linux-acpi@vger.kernel.org,
        upstream@semihalf.com, dtor@chromium.org,
        Angela Czubak <acz@semihalf.com>
Subject: [PATCH] resource: Prevent irqresource_disabled() from erasing flags
Date:   Thu,  8 Apr 2021 12:37:59 +0200
Message-Id: <20210408103759.32866-1-acz@semihalf.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Do not overwrite flags as it leads to erasing triggering and polarity
information which might be useful in case of hard-coded interrupts.
This way the information can be read later on even though mapping to
APIC domain failed.

Signed-off-by: Angela Czubak <acz@semihalf.com>
---
Some Chromebooks use hard-coded interrupts in their ACPI tables.
This is an excerpt as dumped on Relm:

...
            Name (_HID, "ELAN0001")  // _HID: Hardware ID
            Name (_DDN, "Elan Touchscreen ")  // _DDN: DOS Device Name
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (ISTP, Zero)
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    I2cSerialBusV2 (0x0010, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C1", 
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    Interrupt (ResourceConsumer, Edge, ActiveLow, Exclusive, ,, )
                    {
                        0x000000B8,
                    }
                })
                Return (BUF0) /* \_SB_.I2C1.ETSA._CRS.BUF0 */ 
            }
...

This interrupt is hard-coded to 0xB8 = 184 which is too high to be mapped
to IO-APIC, so no triggering information is propagated as acpi_register_gsi()
fails and irqresource_disabled() is issued, which leads to erasing triggering
and polarity information.
If that function added its flags instead of overwriting them the correct IRQ
type would be set even for the hard-coded interrupts, which allows device driver
to retrieve it.
This patch was originaly sent to linux-kernel@vger.kernel.org.
I am resending it to linux-acpi@vger.kernel.org as per request of
Rafael J. Wysocki to gather more visibility.
Please let us know if you see possible issues with not erasing the flags or this
modification seems acceptable.
Best Regards,
Angela

 include/linux/ioport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 55de385c839cf..647744d8514e0 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -331,7 +331,7 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
 {
 	res->start = irq;
 	res->end = irq;
-	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
+	res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
 }
 
 extern struct address_space *iomem_get_mapping(void);
-- 
2.17.1

