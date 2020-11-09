Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84042AC323
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 19:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgKISEY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 13:04:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33385 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKISEY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 13:04:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id i18so9850474ots.0;
        Mon, 09 Nov 2020 10:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5hjK7wVSPpJfduMzhDHI5uww5U0DautuPSacV0o9N0=;
        b=Y8NXe9C18hUfgeOuB00Azn/rYZElFFdo+UgZmgzjNYae0n5l4Dsb9uMYpPos0u6Zib
         qS/nai+p8CP6S6+3EnLLwyx/saceA94S53J8O6IKd9zDKHUOnZUROtACysCYERnXnnbe
         WfTn0vFGfZGEqf5DbHGpeNI1bGh/FkKy3/XA6eOHBlfXRoWlzPDDrCN/gU6LFtcLBq/6
         OE0mA7A+r9YrgzJU7T/4w88wpgqtbt8PIhmH1LHf3GWD1tyA0aItlKJjbIpd0bPX5r93
         +8EVC+2vsfBPg03JWEd55REwToAypTY/7onPk2HliMV15fHMHPLbzHTm5xI/lxC6YrvL
         +4ig==
X-Gm-Message-State: AOAM5311jMJvxlAMJ+fbv5SPPUwXet3dFIkiqBCcsWhMf23M4gvZfsTe
        KEr1vwNZpqGfhkyWpQrlrwd8YtrHUyr6/0C5w4A=
X-Google-Smtp-Source: ABdhPJzE/GmebSR4aNBeUZDpd8ZDYfpEEIkZd6ZkwDKaP2oQZ6SeNgDMz9HlNjmplw1ReNT3FW6V59edXG6+iovd+PM=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr11504113ota.321.1604945062613;
 Mon, 09 Nov 2020 10:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20201029193243.61546-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201029193243.61546-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Nov 2020 19:04:11 +0100
Message-ID: <CAJZ5v0jtpSbWDZ-NeAVSqniDAgq4GsPKzj3nXxsS2uHKpqhxtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation: firmware-guide: gpio-properties:
 Fix factual mistakes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 8:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Fix factual mistakes and style issues in GPIO properties document.
> This converts IoRestriction from InputOnly to OutputOnly as pins
> in the example are used as outputs.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: elaborated the mistakes the change fixes (Mika)

Whole series applied as 5.10-rc material, thanks!

>  .../firmware-guide/acpi/gpio-properties.rst   | 29 ++++++++++---------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index bb6d74f23ee0..e6e65ceb2ca1 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -20,9 +20,9 @@ index, like the ASL example below shows::
>
>        Name (_CRS, ResourceTemplate ()
>        {
> -          GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
> +          GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
>                    "\\_SB.GPO0", 0, ResourceConsumer) {15}
> -          GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
> +          GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
>                    "\\_SB.GPO0", 0, ResourceConsumer) {27, 31}
>        })
>
> @@ -49,7 +49,7 @@ index
>  pin
>    Pin in the GpioIo()/GpioInt() resource. Typically this is zero.
>  active_low
> -  If 1 the GPIO is marked as active_low.
> +  If 1, the GPIO is marked as active_low.
>
>  Since ACPI GpioIo() resource does not have a field saying whether it is
>  active low or high, the "active_low" argument can be used here.  Setting
> @@ -112,8 +112,8 @@ Example::
>    Package () {
>        "gpio-line-names",
>        Package () {
> -          "SPI0_CS_N", "EXP2_INT", "MUX6_IO", "UART0_RXD", "MUX7_IO",
> -          "LVL_C_A1", "MUX0_IO", "SPI1_MISO"
> +          "SPI0_CS_N", "EXP2_INT", "MUX6_IO", "UART0_RXD",
> +          "MUX7_IO", "LVL_C_A1", "MUX0_IO", "SPI1_MISO",
>        }
>    }
>
> @@ -137,7 +137,7 @@ to the GPIO lines it is going to use and provide the GPIO subsystem with a
>  mapping between those names and the ACPI GPIO resources corresponding to them.
>
>  To do that, the driver needs to define a mapping table as a NULL-terminated
> -array of struct acpi_gpio_mapping objects that each contain a name, a pointer
> +array of struct acpi_gpio_mapping objects that each contains a name, a pointer
>  to an array of line data (struct acpi_gpio_params) objects and the size of that
>  array.  Each struct acpi_gpio_params object consists of three fields,
>  crs_entry_index, line_index, active_low, representing the index of the target
> @@ -154,13 +154,14 @@ question would look like this::
>    static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] = {
>      { "reset-gpios", &reset_gpio, 1 },
>      { "shutdown-gpios", &shutdown_gpio, 1 },
> -    { },
> +    { }
>    };
>
>  Next, the mapping table needs to be passed as the second argument to
> -acpi_dev_add_driver_gpios() that will register it with the ACPI device object
> -pointed to by its first argument.  That should be done in the driver's .probe()
> -routine.  On removal, the driver should unregister its GPIO mapping table by
> +acpi_dev_add_driver_gpios() or its managed analogue that will
> +register it with the ACPI device object pointed to by its first
> +argument. That should be done in the driver's .probe() routine.
> +On removal, the driver should unregister its GPIO mapping table by
>  calling acpi_dev_remove_driver_gpios() on the ACPI device object where that
>  table was previously registered.
>
> @@ -191,12 +192,12 @@ The driver might expect to get the right GPIO when it does::
>  but since there is no way to know the mapping between "reset" and
>  the GpioIo() in _CRS desc will hold ERR_PTR(-ENOENT).
>
> -The driver author can solve this by passing the mapping explictly
> -(the recommended way and documented in the above chapter).
> +The driver author can solve this by passing the mapping explicitly
> +(this is the recommended way and it's documented in the above chapter).
>
>  The ACPI GPIO mapping tables should not contaminate drivers that are not
>  knowing about which exact device they are servicing on. It implies that
> -the ACPI GPIO mapping tables are hardly linked to ACPI ID and certain
> +the ACPI GPIO mapping tables are hardly linked to an ACPI ID and certain
>  objects, as listed in the above chapter, of the device in question.
>
>  Getting GPIO descriptor
> @@ -229,5 +230,5 @@ Case 2 explicitly tells GPIO core to look for resources in _CRS.
>  Be aware that gpiod_get_index() in cases 1 and 2, assuming that there
>  are two versions of ACPI device description provided and no mapping is
>  present in the driver, will return different resources. That's why a
> -certain driver has to handle them carefully as explained in previous
> +certain driver has to handle them carefully as explained in the previous
>  chapter.
> --
> 2.28.0
>
