Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF258BCEB
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Aug 2022 22:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiHGUfD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Aug 2022 16:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHGUfB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Aug 2022 16:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D00E62EA
        for <linux-acpi@vger.kernel.org>; Sun,  7 Aug 2022 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659904499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9S8tMgCeuvRURVZv8465o/agnrJOZSatFDbcWNas7q0=;
        b=TkwL5w882F52zsEh/QmMwOmsLjSNN35xMeSGAaoUEe1yTqHtPrYmVe69FldVp2XbL2X0z1
        HuoZ60auEus6It44TeBVWeN7UYJeFye4BLrmI1S5VxLfcGL0n5kc7o4k5ZZICRf99opQhk
        2q7WE/dTme5EML3pEJo+HtpvhQ+meWY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-X_iIpdYXNHWh_DdaOSWqHQ-1; Sun, 07 Aug 2022 16:34:57 -0400
X-MC-Unique: X_iIpdYXNHWh_DdaOSWqHQ-1
Received: by mail-ed1-f71.google.com with SMTP id w17-20020a056402269100b0043da2189b71so4591437edd.6
        for <linux-acpi@vger.kernel.org>; Sun, 07 Aug 2022 13:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=9S8tMgCeuvRURVZv8465o/agnrJOZSatFDbcWNas7q0=;
        b=dSB3GOy1XeaOtklp5EADa5s2WbcptodNasJR6dh7rmP2XcGfaUa22I6mmokBEZUe66
         t6gu4oP+xncCtNEBUJcpsPv5e3Zp9+4IGiji3Hyxw83TD8+RWEhZZtZzravr2fwLZTVr
         k8HLQ9lYw/qlz+T5+xwa/DHEV90gWcL98om8aYuJPGQMq+ox2sSfCBZUyVvGZ/vpRbJP
         iukZH2BfZ9snyPKUYmzOFdV1+qujjIevsA4Cw0e7kXea+BQrunXsRqnudotWVr3G9SN/
         MUmK0lW6lOtP1SBC1wgsFcA/q0u41G2hmPJbei+h8loKOMwraiHunP9UUvcXuHV1R9kv
         pnDQ==
X-Gm-Message-State: ACgBeo1UlcsDHbBCRt8YHDYY75bUOkiby5VLx1t34LOhnLjwVyas9tZ/
        /q4T43PNx+2T2rvnUB/fuZGV/4hNABFcHt8yv/raBxeO5im/x3lVOeDEm9L+6xPMYu900bB1Xby
        0wrln7nG4Ak/KwZEoBhqmVg==
X-Received: by 2002:a17:907:6090:b0:72f:3dc3:f0c8 with SMTP id ht16-20020a170907609000b0072f3dc3f0c8mr11040228ejc.539.1659904496565;
        Sun, 07 Aug 2022 13:34:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6NJSwO4NChXXLqQtxTzj/NLjRfxQibKluL0XsLgY+/uxJGt9XrxHFGjh+zeVx34jsp2iHwgw==
X-Received: by 2002:a17:907:6090:b0:72f:3dc3:f0c8 with SMTP id ht16-20020a170907609000b0072f3dc3f0c8mr11040222ejc.539.1659904496314;
        Sun, 07 Aug 2022 13:34:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id v4-20020a1709062f0400b006f3ef214daesm4151861eji.20.2022.08.07.13.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 13:34:55 -0700 (PDT)
Message-ID: <a385b626-217f-25be-f076-7478da3d1147@redhat.com>
Date:   Sun, 7 Aug 2022 22:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Riwen Lu <luriwen@kylinos.cn>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: "ACPI: video: Drop X86 dependency from Kconfig" is causing config
 issues elsewhere
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I just noticed this change:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=038275d227841d4978ceceb397b584b4b39f2b50

--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -210,7 +210,7 @@ config ACPI_TINY_POWER_BUTTON_SIGNAL
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86 && BACKLIGHT_CLASS_DEVICE
+	depends on BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
 	select THERMAL
 	help

I think this is going to cause random-config build errors because
at the nouveau driver calls acpi_video functions and it expects
those functions to either be there or to get the stubs.

This is an issue when acpi_video is build as a module and the
i915 / nouveau code is builtin.

To avoid this issue nouveau does a select on ACPI_VIDEO,
here is the code from drivers/gpu/drm/nouveau/Kconfig

        # Similar to i915, we need to select ACPI_VIDEO and it's dependencies
        select BACKLIGHT_CLASS_DEVICE if ACPI && X86
        select INPUT if ACPI && X86
        select THERMAL if ACPI && X86
        select ACPI_VIDEO if ACPI && X86

notice the if ACPI && X86, since ACPI_VIDEO can now be selected
on ARM, this can lead to ACPI_VIDEO being enabled as
module (so no stubs) while nouveau can be builtin which will
lead to unresolved symbol errors in nouveau when building the zImage.

I believe that to fix this the conditions after the select must
be changed from "if ACPI && X86" to just "if ACPI"

Riwen Lu, can you please submit follow up patch to fix
the conditions for the ACPI_VIDEO (and dependency) selection
for nouveau?

Regards,

Hans

