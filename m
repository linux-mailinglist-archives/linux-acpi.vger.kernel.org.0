Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8725B2EBDC2
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jan 2021 13:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbhAFMdV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 07:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbhAFMdU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 07:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609936313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hNC7fGuAHLdLTCHh50Knb0xeK117OKEfP5RFQW5xt7s=;
        b=EloDgkUaAgdAAxVizzV2n3TCVXYBMzZHi1sJZRqnc1ro/c4iQlxj4ZTLImxqnLknKhS757
        AzGJloppYonDoFdB9sYwH/s7fjT4O2be+9S3SOwu3OQP2PotOKKdWuaB0rcw4dCYUS2Yjq
        UczXNRCJxJ+EnsmU2xi0RYEQmeEYbpo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-KtygJInPMZ-3k07YwmJGBA-1; Wed, 06 Jan 2021 07:31:49 -0500
X-MC-Unique: KtygJInPMZ-3k07YwmJGBA-1
Received: by mail-ed1-f70.google.com with SMTP id u17so1874483edi.18
        for <linux-acpi@vger.kernel.org>; Wed, 06 Jan 2021 04:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hNC7fGuAHLdLTCHh50Knb0xeK117OKEfP5RFQW5xt7s=;
        b=bILfsDdENVnBL2pXbMP3KfsfGO2HMiwPbVgHAGafTMYJq1GiOGOcYVXJx7hXMsFE9M
         WKwmxTvCuvFkA+FMJ3Fws0vFBihSGV3yONZJ0pt7LPItvLDyu7ElITSVe2LRG3MmBhUF
         tYsignq8BQDEn5I9wBXLX+U7OWTqblMcQrYez+CAHwbordYegNzdnNcjC7G6TNR1ahjg
         i+8HU+KiXZnFsl+iDRFReFuJt/qg/BwFaXfC2v/SQl6hvwGELAJ8/Eanp2hW8arGNPnW
         rIhh06qCxG+Qcqfd2cfQ1pTVsYgpFjpp9t2OxCa22sqYCsQ0rty8a6396EoDDcnWvUgA
         KSzg==
X-Gm-Message-State: AOAM531kZPDEHDv+ODS6s7U1GS8NAIGr7g0AqU+hsHdNoCPUkKvxXQjG
        Ff25S88wUdLWa1aLlnI5q/uYP74U4IQaISzviMwSPCKR2gxDRpo3d1ipZBKA9otPs1A7hy2vuaX
        +d+IhiApAg/sTdcAgnO29EA==
X-Received: by 2002:a50:b586:: with SMTP id a6mr3836469ede.206.1609936308184;
        Wed, 06 Jan 2021 04:31:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXu409zDlILrFHdgW9Ot4OtDnpZpCDLR0OErS8iHdk6Anaj52W8RRwkkUPK1cEOTAwBY5Ehg==
X-Received: by 2002:a50:b586:: with SMTP id a6mr3836451ede.206.1609936307847;
        Wed, 06 Jan 2021 04:31:47 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id ca4sm1392626edb.80.2021.01.06.04.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 04:31:46 -0800 (PST)
To:     Andy Shevchenko <andy@infradead.org>
Cc:     linux-acpi@vger.kernel.org, x86@kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: How to detect Cherry Trail vs Brasswell inside the kernel ?
Message-ID: <37906985-e026-48d3-cda8-6e63696e72aa@redhat.com>
Date:   Wed, 6 Jan 2021 13:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

I've 2 different kernel bugs where the fix requires differentiating between
Cherry Trail vs Brasswell, just checking the CPU model does not allow to
differentiate between these 2 since they are both using Airmont cores.

I have the same issue with the Bay Trail laptop SoCs vs the
Bay Trail-T tablet SoCs, but for now lets focus on
Cherry Trail vs Brasswell since that is less confusing:

https://ark.intel.com/content/www/us/en/ark/products/codename/46629/cherry-trail.html
https://ark.intel.com/content/www/us/en/ark/products/codename/66094/braswell.html

So I see a number of possible solutions here:

1) Do a (substring) check on the CPU model-name checking for "x5-Z8" and "x7-Z8"
2) Check for presence of some embedded peripheral which is present on one but not the
other. E.g. The Braswell devices have HDA audio where as the Cherry Trail devices
use the "Low Power Engine (LPE) Audio Controller"
3) Check for acpi_gbl_reduced_hardware, but I'm not sure if that is a reliable
indicator of running on the tablet versions of the SoCs.

1 and 2 will work but neither is very pretty, I guess I could try to spend some
more time investigating 3. But I only have limited access to the non tablet versions
of the Bay Trail and I'm not sure if I have any Braswell devices at all. 

So I was wondering if anyone else has any better ideas here?

Regards,

Hans


p.s.

Just FYI the 2 issues which I want to resolve are:

1. Prevent drivers/platform/x86/intel_int0002_vgpio.c binding on Braswell
(non "tablet") SoCs. The INT0002 ACPI device is used for some wakeup
events (from S2idle) on the tablet (Cherry Trail) versions of the SoC.

The current code will also bind to the INT0002 ACPI device (if present) on
Braswell, this is causing suspend/resume issues on some devices.
ATM we are working around this by setting the IRQCHIP_SKIP_SET_WAKE on
the irq-chip for the INT0002 vGPIO pin. But this in turn is breaking wakeup
by USB peripherals on Cherry Trail devices. If we can just stop the driver
from binding on Braswell devices all together then that would be better.

2. Deal with non functional /sys/class/backlight/acpi_video[0-7] devices
showing up on BYT/CHT based media-boxes / hdmi-sticks. These devices do
not have a LCD panel, so there will be no "native" backlight driver causing
drivers/acpi/video-detect.c to select acpi_backlight_video as backlight-type.
drivers/acpi/acpi-video.c tries to avoid registering non-functional
/sys/class/backlight/acpi_video devices in cases like this, but that depends
on a DMI chassis-type check (to avoid suppressing the backlight interface
on laptops where we likely do want it) and many of these media-boxes /
hdmi-sticks are derived from BYT/CHT tablet designs and often the DMI
chassis type still says "Tablet". Actual Cherry Trail devices with a LCD
panel always use the native intel_backlight interface, but I guess some
Braswell based devices might use the acpi_video interface.

I would like to be able to add some code the the ACPI video code which
simply ignores the broken acpi_video interface on Cherry Trail devices,
while still using its normal detection logic on Brasswell devices.
The alternative would be an ever growing list of DMI based quirks which
is undesirable.

