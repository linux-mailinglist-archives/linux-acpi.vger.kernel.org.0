Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12995BE399
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Sep 2022 12:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiITKnw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Sep 2022 06:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiITKnY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Sep 2022 06:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF36447
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2022 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663670594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMA0rQs86FOwfocxFPVrINYPjkbq3Q1x9nWeAx3V0gI=;
        b=XJRcFM/7JleadmrIzyWBPpynEM4IVNS0GmN53d7jLcXd9+7eQsBoeoRzwi41Z4fztM/0EY
        N4d6mnCkh1lUpYtBjdPsamXWicrIerp/r4+nLaKhE7ypXUFjJMWXTZKaa68yHIpRPDGvGa
        /p6pYxPa91xknlukEC++2g4ygxdzcaY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587--FWCSMT4NGGT7ses63f3jg-1; Tue, 20 Sep 2022 06:43:11 -0400
X-MC-Unique: -FWCSMT4NGGT7ses63f3jg-1
Received: by mail-pl1-f197.google.com with SMTP id l2-20020a170902f68200b00177ee7e673eso1496907plg.2
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2022 03:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qMA0rQs86FOwfocxFPVrINYPjkbq3Q1x9nWeAx3V0gI=;
        b=yh7eKCDqUdmuXwqi+7FUU5orqjtqkjGcTPLs6BCHWWScDm4tDuA3bc6srUshCRrxqb
         uOEG5ffJlFprecWNCjfMS0vFNG+QChS2odQ8Ay+nt55JfPU3wGxOILI95sQZmAP891SQ
         aCvxANG+mskFyi1Jf7bh4yOj+CRbTTbtn40SZHE8I22961OS+BqtuRYI6UvWW96NrG5z
         iSlbckWwtf66OSZ1zV1UcbZHsORtUap9m6iE3VwErBd4pbAO0aKm0TMQh9kfHyAba2IE
         j5oH34+os/7V2Eqnhom1I0lwYS78mryXFxS6T+SrLA3UvD8KoNvchWq78S3G4yUF2iSH
         WSoA==
X-Gm-Message-State: ACrzQf3CTe2pvhebCb5vmxyhS99N+L4ysVwVQT5mHP8Oqq2VnW8i9Tw/
        Oyu0NcISkVxAKFYhPygeEVmb4+P3mF06IgdN+WKqimGHDP8ieOs9ji4uh5OAS4MSY62H9Z5N0By
        peihKAcsOW1LfjESv1Evh1JAuoYyWk7WdLUvffw==
X-Received: by 2002:a17:90b:1d12:b0:200:461c:fa7d with SMTP id on18-20020a17090b1d1200b00200461cfa7dmr3254636pjb.38.1663670589901;
        Tue, 20 Sep 2022 03:43:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4LwOlWM+owfEUV010mJfgetj3SukXN+Y26a36gzyfhur973qtqvZjOgY/ZWBiyAeoxHSdwI2HqG3nq0p7A1iQ=
X-Received: by 2002:a17:90b:1d12:b0:200:461c:fa7d with SMTP id
 on18-20020a17090b1d1200b00200461cfa7dmr3254615pjb.38.1663670589623; Tue, 20
 Sep 2022 03:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220919155916.1044219-1-rrangel@chromium.org>
In-Reply-To: <20220919155916.1044219-1-rrangel@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 20 Sep 2022 12:42:58 +0200
Message-ID: <CAO-hwJKcpXQjvLuQK+wfqkU0LHxKbbAyNCZnQGxe47fm1o6LQw@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] acpi: i2c: Use SharedAndWake and
 ExclusiveAndWake to enable wake irq
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-acpi@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        timvp@google.com, Hans De Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rafael@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        jingle <jingle.wu@emc.com.tw>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alistair Francis <alistair@alistair23.me>,
        Angela Czubak <acz@semihalf.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Dan Williams <dan.j.williams@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Wolfram Sang <wsa@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-gpio@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 19, 2022 at 5:59 PM Raul E Rangel <rrangel@chromium.org> wrote:
>
> Today, i2c drivers are making the assumption that their IRQs can also
> be used as wake IRQs. This isn't always the case and it can lead to
> spurious wakes. This has recently started to affect AMD Chromebooks.
> With the introduction of
> d62bd5ce12d7 ("pinctrl: amd: Implement irq_set_wake"), the AMD GPIO
> controller gained the capability to set the wake bit on each GPIO. The
> ACPI specification defines two ways to inform the system if a device is
> wake capable:
> 1) The _PRW object defines the GPE that can be used to wake the system.
> 2) Setting ExclusiveAndWake or SharedAndWake in the _CRS GpioInt.
>
> Currently only the first method is supported. The i2c drivers don't have
> any indication that the IRQ is wake capable, so they guess. This causes
> spurious interrupts, for example:
> * We have an ACPI HID device that has `_PR0` and `_PR3`. It doesn't have
>   `_PRW` or `ExclusiveAndWake` so that means the device can't wake the
>   system.
> * The IRQ line is active level low for this device and is pulled up by
>   the power resource defined in `_PR0`/`_PR3`.
> * The i2c driver will (incorrectly) arm the GPIO for wake by calling
>   `enable_irq_wake` as part of its suspend hook.
> * ACPI will power down the device since it doesn't have a wake GPE
>   associated with it.
> * When the device is powered down, the IRQ line will drop, and it will
>   trigger a wake event.
>
> See the following debug log:
> [   42.335804] PM: Suspending system (s2idle)
> [   42.340186] amd_gpio AMD0030:00: RX: Setting wake for pin 89 to enable
> [   42.467736]     power-0416 __acpi_power_off      : Power resource [PR00] turned off
> [   42.467739] device_pm-0280 device_set_power      : Device [H05D] transitioned to D3cold
> [   42.475210] PM: pm_system_irq_wakeup: 11 triggered pinctrl_amd
> [   42.535293] PM: Wakeup unrelated to ACPI SCI
> [   42.535294] PM: resume from suspend-to-idle
>
> In order to fix this, we need to take into account the wake capable bit
> defined on the Interrupt/GpioInt. This is accomplished by:
> * Migrating some of the i2c drivers over to using the PM subsystem to
>   manage the wake IRQ.
> * Expose the wake_capable bit from the ACPI Interrupt/GpioInt resource
>   to the  i2c core.
> * Use the wake_capable bit in the i2c core to call
>   `dev_pm_set_wake_irq`. This reuses the existing device tree flow.
> * Make the i2c drivers stop calling `dev_pm_set_wake_irq` since it's now
>   handled by the i2c core.
> * Make the ACPI device PM system aware of the wake_irq. This is
>   necessary so the device doesn't incorrectly get powered down when a
>   wake_irq is enabled.
>
> I've tested this code with various combinations of having _PRW,
> ExclusiveAndWake and power resources all defined or not defined, but it
> would be great if others could test this out on their hardware.
>
> I'm sure this will surface some devices where the IRQs were not
> correctly marked as wake capable. Ideally the firmware can be fixed, but
> if not we can work around this in the kernel by providing a board
> specific `struct i2c_board_info` with the `I2C_CLIENT_WAKE` flag set.
> See `chromeos_laptop.c` for an example of matching DMI properties and
> setting the `I2C_CLIENT_WAKE` override.
>
> Thanks,
> Raul
>
> Changes in v4:
> - Added Reviewed-by
> - Reformatted with 96 char limit
> - Removed unnecessary !!
> - Removed unrelated white space change
> - Renamed i2c_acpi_add_resource to i2c_acpi_add_irq_resource
> - Expanded logic in i2c_acpi_add_i2c_resource to make it easier to read
>
> Changes in v3:
> - Kept `acpi_dev_gpio_irq_get_by` unchanged to avoid having to touch
>   unrelated drivers.
> - Converted wake_capable parameter to bool.
> - Fixed bad indent
> - Convert wake_capable to bool
> - Only update wake_capable pointer once
> - Move wake_capable local into local block
>
> Changes in v2:
> - Added elants_i2c to series
> - Added raydium_ts_i2c to series
> - Fixed call site in mlxbf_gige_probe
> - Added ability to extract wake bit from Interrupt/IRQ resources
> - Look at wake_cabple bit for IRQ/Interrupt resources
> - I chose not to keep the legacy code around since systems without DT or ACPI should be rare.
>
> Raul E Rangel (13):
>   HID: i2c-hid: Use PM subsystem to manage wake irq
>   Input: elan_i2c - Use PM subsystem to manage wake irq
>   Input: elants_i2c - Use PM subsystem to manage wake irq
>   Input: raydium_ts_i2c - Use PM subsystem to manage wake irq
>   gpiolib: acpi: Add wake_capable variants of acpi_dev_gpio_irq_get
>   ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
>   i2c: acpi: Use ACPI wake capability bit to set wake_irq
>   ACPI: PM: Take wake IRQ into consideration when entering
>     suspend-to-idle
>   HID: i2c-hid: acpi: Stop setting wakeup_capable
>   HID: i2c-hid: Don't set wake_capable and wake_irq
>   Input: elan_i2c - Don't set wake_capable and wake_irq
>   Input: elants_i2c - Don't set wake_capable and wake_irq
>   Input: raydium_ts_i2c - Don't set wake_capable and wake_irq
>
>  drivers/acpi/device_pm.c                   | 19 +++++++++--
>  drivers/acpi/irq.c                         |  8 +++--
>  drivers/acpi/resource.c                    | 23 ++++++++++----
>  drivers/gpio/gpiolib-acpi.c                | 15 +++++++--
>  drivers/gpio/gpiolib-acpi.h                |  2 ++
>  drivers/hid/i2c-hid/i2c-hid-acpi.c         |  5 ---
>  drivers/hid/i2c-hid/i2c-hid-core.c         | 24 ++------------
>  drivers/i2c/i2c-core-acpi.c                | 37 ++++++++++++++++------
>  drivers/i2c/i2c-core-base.c                |  6 +++-
>  drivers/i2c/i2c-core.h                     |  4 +--
>  drivers/input/mouse/elan_i2c_core.c        | 15 +--------
>  drivers/input/touchscreen/elants_i2c.c     | 13 ++------
>  drivers/input/touchscreen/raydium_i2c_ts.c |  7 +---
>  drivers/pnp/pnpacpi/rsparser.c             |  7 ++--
>  include/linux/acpi.h                       | 23 +++++++++++---
>  include/linux/ioport.h                     |  3 +-
>  16 files changed, 117 insertions(+), 94 deletions(-)
>

For the HID patches (1, 9, 10):
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Feel free to take those through whatever tree is the best, we don't
have anything scheduled for i2c-hid for 6.1 right now.

Cheers,
Benjamin

