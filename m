Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0554A5E35
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Feb 2022 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiBAO0F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Feb 2022 09:26:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239249AbiBAO0E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Feb 2022 09:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643725564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPLhPOdNSB7PJok3SKPVCTJi2bZZQJ/Ip1kdffjANMc=;
        b=T2+f3U/XK/O1yNl7SdPedniBDrW1Q4f+k8t730aoBuBOGT5GkLD2qMcSzsUiaPUmxCUT/Q
        6FxcXLtkbjuRLJyMS3eYidRjr2fIU5EhOQIqtplACOU0fZDwsAcVD6TJACd/TRSS+OT3ZT
        eaZMsckRxa1CapEk2gOPpR79t385OV0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-HbFRJDL3PfKzfWNIcEnDCA-1; Tue, 01 Feb 2022 09:26:02 -0500
X-MC-Unique: HbFRJDL3PfKzfWNIcEnDCA-1
Received: by mail-ej1-f70.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so6570478ejw.9
        for <linux-acpi@vger.kernel.org>; Tue, 01 Feb 2022 06:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rPLhPOdNSB7PJok3SKPVCTJi2bZZQJ/Ip1kdffjANMc=;
        b=lcKm8YFEToZsW24RGL0cQ09rDCJmZzBY2gLKY04L1tf9CSO94jFdViNFqlanenCCmR
         toHAoBIudUwZEwsh8eggywdECvwVcD/rchv/OAflYw4Ql/dPbBSgVlT2fEmLxjof9cxx
         aPBDoUZ4GTobcQk/zAwJY+P5YNlAqvT+9koHk4ra/X/seDUT6UI732YEDJj4Y83xOu7G
         hvLn7DE9d+XrnfNgW18TAW/KEasRT97k1cPkb8I5E7gVnSoRCDHZ9210czFQvJ2TYEgQ
         DDKrzZNPXQ4+oNcFXWeYRuN/8GQS9obdR1H51hHBy3SK1AqdjQSD1eCp+C7yYbHq4vSD
         CBYA==
X-Gm-Message-State: AOAM5301K2GxKfIdG6fjTxND3dIAC8u49IrL1jcqeCttScxACo98Sgrv
        gJUgVtfaczv/P7X0wBj7OvJpBv0dBGupcmntzYY+fJjnV43j6DIxsQ4j6KOccDrtOzaa0A8aLWb
        tIlbvYTEE7Ty/v9k3ZzQK3Q==
X-Received: by 2002:aa7:d312:: with SMTP id p18mr24728915edq.49.1643725561650;
        Tue, 01 Feb 2022 06:26:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQcDKGpASKFAHDWC+uv1+s0squ1+FRZAslqH6LoVgn8BgVh44QX+sA2dPzucd6pM4miRcZ0g==
X-Received: by 2002:aa7:d312:: with SMTP id p18mr24728900edq.49.1643725561429;
        Tue, 01 Feb 2022 06:26:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id op20sm14709161ejb.68.2022.02.01.06.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:25:58 -0800 (PST)
Message-ID: <f8d94992-67a7-30c0-f59b-f4d2b448260e@redhat.com>
Date:   Tue, 1 Feb 2022 15:25:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 0/9] Support Spi in i2c-multi-instantiate driver
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Stefan,

On 1/21/22 18:24, Stefan Binding wrote:
> Add support for SPI bus in the i2c-multi-instantiate driver as
> upcoming laptops will need to multi instantiate SPI devices from
> a single device node, which has multiple SpiSerialBus entries at
> the ACPI table.
> 
> With the new SPI support, i2c-multi-instantiate becomes
> bus-multi-instantiate and is moved to the ACPI folder.
> 
> The intention is to support the SPI bus by re-using the current
> I2C multi instantiate, instead of creating a new SPI multi
> instantiate, to make it possible for peripherals that can be
> controlled by I2C or SPI to have the same HID at the ACPI table.
> 
> The new driver (serial multi instantiate, smi) checks for the
> hard-coded bus type and returns -ENODEV in case of zero devices
> found for that bus. In the case of automatic bus detection, 
> the driver will give preference to I2C.
> 
> The expectation is for a device node in the ACPI table to have
> multiple I2cSerialBus only or multiple SpiSerialBus only, not
> a mix of both; and for the case where there are both entries in
> one device node, only the I2C ones would be probed.
> 
> This new serial multi instantiate will be used in CS35L41 HDA new
> driver.
> 
> Changes since V5:
>  - comment, commit message and Kconfig description fixes
>  - minor fixes in serial-multi-instantiate
>  - use lowercase for SSIDs in patch_realtek.c

Thank you for the new versions.

I gave a bunch of:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

tags for v4, unless you make big changes, you are supposed to
collect this tag and add it to newer versions of the
patch-set (just above your own S-o-b).

I'll resend the Reviewed-by-s for this version, please
collect them for the next version (I noticed there are
still some small issues, sorry).

Regards,

Hans



> 
> Lucas Tanure (4):
>   platform/x86: i2c-multi-instantiate: Rename it for a generic serial
>     driver name
>   platform/x86: serial-multi-instantiate: Reorganize I2C functions
>   ALSA: hda/realtek: Add support for HP Laptops
>   ACPI / scan: Create platform device for CS35L41
> 
> Stefan Binding (5):
>   spi: Make spi_alloc_device and spi_add_device public again
>   spi: Create helper API to lookup ACPI info for spi device
>   spi: Support selection of the index of the ACPI Spi Resource before
>     alloc
>   spi: Add API to count spi acpi resources
>   platform/x86: serial-multi-instantiate: Add SPI support
> 
>  MAINTAINERS                                   |   4 +-
>  drivers/acpi/scan.c                           |  16 +-
>  drivers/platform/x86/Kconfig                  |  12 +-
>  drivers/platform/x86/Makefile                 |   2 +-
>  drivers/platform/x86/i2c-multi-instantiate.c  | 174 ---------
>  .../platform/x86/serial-multi-instantiate.c   | 349 ++++++++++++++++++
>  drivers/spi/spi.c                             | 137 ++++++-
>  include/linux/spi/spi.h                       |  20 +
>  sound/pci/hda/patch_realtek.c                 |  43 ++-
>  9 files changed, 551 insertions(+), 206 deletions(-)
>  delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c
>  create mode 100644 drivers/platform/x86/serial-multi-instantiate.c
> 

