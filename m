Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201BC1B8F9D
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Apr 2020 14:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgDZMA6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Apr 2020 08:00:58 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:33837 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDZMA5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Apr 2020 08:00:57 -0400
Received: by mail-oo1-f65.google.com with SMTP id q204so3222802ooq.1;
        Sun, 26 Apr 2020 05:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ybWhQKicq3BRCiYVQDh4zWliFFrm/KJg+jIJlyUI9M=;
        b=ej2BtiMWjS/6fppDztqzCZYy09Qnh4QSrZLZKOUCDxkrg/uDfa1bWAQFX0sBhxJ2Lr
         1s5Ntg09X10k284ICoJ2f0XZIYt0GUV7In/MCOWmQfX591iAdfB7KD+oulO+Nh79D8LZ
         gRvux9h0Bx72Yoechl3a6gyrpxeDG33nGI4ybjcvfwMLA8IkPufktewWeYICZhOjXGkL
         HLVufYEibkdAslV6cllqQrx7EWF+jjjBEwn7eBonNeVAwzKZB5lp3lxfw0xBvbN/o2Lg
         wKOUg0/Pk6FY3153/rGO6CsCBkUJv6IxYrTRojThhPjKjHn0GqFgb4yc25HaemDy/uq8
         7sVw==
X-Gm-Message-State: AGi0PuZsO3kQr/1FIm1vbrOT4RSq0Y27NQhQiYF9jnHkyRs6X/8nrG5Q
        L+cSNpdqfb8cmFnqZt04XiGkEJWxnMIkAoH6c2o=
X-Google-Smtp-Source: APiQypKyZxkcHfEhyM8+pOq/fmWQIy9udg2kWP9Mm+fknlDDSKT2EaVjrffZSGqWcxhe2HznqDzwgkIT3THf3/jVgJ0=
X-Received: by 2002:a4a:a286:: with SMTP id h6mr15108432ool.38.1587902455878;
 Sun, 26 Apr 2020 05:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104713.216896-1-hdegoede@redhat.com> <20200426104713.216896-3-hdegoede@redhat.com>
In-Reply-To: <20200426104713.216896-3-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 26 Apr 2020 14:00:44 +0200
Message-ID: <CAJZ5v0iZ-8rnC3fLsYYb4ieAVKXc6_W3_Cnxfy3vQR3CEufucg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI / scan: Create platform device for CPLM3218 ACPI nodes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Apr 26, 2020 at 12:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some CPLM3218 ACPI nodes also put the SMBus Alert Response Address (0x0c)
> in their ACPI resource table; and they put it there as the first entry,
> here is an example from the CPLM3218 device in the DSDT of an Asus T100TA:
>
>  Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>  {
>      Name (SBUF, ResourceTemplate ()
>      {
>          I2cSerialBusV2 (0x000C, ControllerInitiated, 0x00061A80,
>              AddressingMode7Bit, "\\_SB.I2C3",
>              0x00, ResourceConsumer, , Exclusive,
>              )
>          I2cSerialBusV2 (0x0048, ControllerInitiated, 0x00061A80,
>              AddressingMode7Bit, "\\_SB.I2C3",
>              0x00, ResourceConsumer, , Exclusive,
>              )
>          Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
>          {
>              0x00000033,
>          }
>      })
>      Return (SBUF) /* \_SB_.I2C3.ALSD._CRS.SBUF */
>  }
>
> The actual I2C address of the sensor in this case is the 0x48 address
> from the second resource-table entry. On some other devices
> (e.g. HP X2 Bay Trail models, Acer SW5-012) the CPLM3218 node contains
> only 1 I2C resource.
>
> Add the CPLM3218 to the I2C multi instantiate list, so that the
> i2c-multi-instantiate.c driver can handle it.
>
> Note in the case where there are 2 I2C resources we simply instatiate
> i2c-clients for both and let the cm32181 driver figure out that the
> first one is not the one it wants.
>
> Doing things this way is actually desirable because on devices where
> there are 2 I2C resources it seems that we first need to do a SMBus
> read of the 0x0c address before the sensor will respond to I2C transfers
> on its actual address.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the scan.c change and I'm expecting platform/x86 to take care of
this series.

Thanks!

> ---
>  drivers/acpi/scan.c                          | 1 +
>  drivers/platform/x86/i2c-multi-instantiate.c | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 6d3448895382..937d72fc212c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1544,6 +1544,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>         static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
>                 {"BSG1160", },
>                 {"BSG2150", },
> +               {"CPLM3218", },
>                 {"INT33FE", },
>                 {"INT3515", },
>                 {}
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index dcafb1a29d17..e1cdc44e6f57 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -180,6 +180,12 @@ static const struct i2c_inst_data int3515_data[]  = {
>         {}
>  };
>
> +static const struct i2c_inst_data cplm3218_data[]  = {
> +       { "cm32181", PASS_FWNODE },
> +       { "cm32181", PASS_FWNODE },
> +       {}
> +};
> +
>  /*
>   * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> @@ -187,6 +193,7 @@ static const struct i2c_inst_data int3515_data[]  = {
>  static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>         { "BSG1160", (unsigned long)bsg1160_data },
>         { "BSG2150", (unsigned long)bsg2150_data },
> +       { "CPLM3218", (unsigned long)cplm3218_data },
>         { "INT3515", (unsigned long)int3515_data },
>         { }
>  };
> --
> 2.26.0
>
