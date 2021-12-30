Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A970481E35
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Dec 2021 17:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbhL3Qg5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 30 Dec 2021 11:36:57 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:43796 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbhL3Qg5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Dec 2021 11:36:57 -0500
Received: by mail-qt1-f179.google.com with SMTP id q14so22121472qtx.10;
        Thu, 30 Dec 2021 08:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZgbwrwneUUbI3eKFGGiSBbN6uCV4a8tfPJGMC/xXd1M=;
        b=FdEtWoB5qHGQQpBr/tHrq4epQSqeRelos2IzFW4C3/P84PmkfNmSbDOtKpwmvtKMgh
         CZ6xZfnoYZtO5t3QjxsymJHqitJXWqtDLl2U3AaFpL14kCLzIbJ9wDHPZYlA/ML52r+c
         Nq7an83/9O/uQMydHc3Qfl+aAJJcw5rgy6307NUeBZ7OIT6kTNyrCsocth7qaz8GfdwM
         /RO5oPDD905l/2FY8RN3imbf5VEMg0p07A+a4GpKLNK7jcFyCSvbeDpPQvjtdCwCgt7I
         nee2PbtD6tMq5Du599F3IRcUUAjifF3Nb5bDl1JuAYcB2ZyutidPj5LhMSFnlQ3LwSpH
         4DkA==
X-Gm-Message-State: AOAM532zK7AzKBkcBWj+tby6deXRJxY7MN5sM51BxXWStu0fZbiOTQLy
        1Ta0Y2QNWJFJIoW0M+8DstaT/qwONmOg+40XJzs=
X-Google-Smtp-Source: ABdhPJxDrbYpc15TaUfWdMgXcFUYn3WeBudh8IfpVmSA6Q5kCn0aIexJQ3hsjNZj+AMvokhdd/xba0Q0DwV/FIaszy0=
X-Received: by 2002:ac8:46cc:: with SMTP id h12mr27362513qto.417.1640882216236;
 Thu, 30 Dec 2021 08:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20211230115747.15302-1-hdegoede@redhat.com>
In-Reply-To: <20211230115747.15302-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 17:36:45 +0100
Message-ID: <CAJZ5v0goKmkTwr25FB7EX0kqpO6BdBL12M3hcqrAxS8u9UaLAg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / scan: Create platform device for BCM4752 and
 LNV4752 ACPI nodes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-serial@vger.kernel.org,
        =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 30, 2021 at 12:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> BCM4752 and LNV4752 ACPI nodes describe a Broadcom 4752 GPS module
> attached to an UART of the system.
>
> The GPS modules talk a custom protocol which only works with a closed-
> source Android gpsd daemon which knows this protocol.
>
> The ACPI nodes also describe GPIOs to turn the GPS on/off these are
> handled by the net/rfkill/rfkill-gpio.c code. This handling predates the
> addition of enumeration of ACPI instantiated serdevs to the kernel and
> was broken by that addition, because the ACPI scan code now no longer
> instantiates platform_device-s for these nodes.
>
> Rename the i2c_multi_instantiate_ids HID list to ignore_serial_bus_ids
> and add the BCM4752 and LNV4752 HIDs, so that rfkill-gpio gets
> a platform_device to bind to again; and so that a tty cdev for gpsd
> gets created for these.
>
> Fixes: e361d1f85855 ("ACPI / scan: Fix enumeration for special UART devices")
> Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note there is some work on reverse-engineering the protocol for these
> GPS modules here, but this is not complete:
> https://redmine.replicant.us/projects/replicant/wiki/BCM4751
> https://git.replicant.us/contrib/PaulK/bcm4751/
> ---
>  drivers/acpi/scan.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 526e823a33fb..c5dfbe26a0cb 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1701,6 +1701,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  {
>         struct list_head resource_list;
>         bool is_serial_bus_slave = false;
> +       static const struct acpi_device_id ignore_serial_bus_ids[] = {
>         /*
>          * These devices have multiple I2cSerialBus resources and an i2c-client
>          * must be instantiated for each, each with its own i2c_device_id.
> @@ -1709,11 +1710,18 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>          * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
>          * which i2c_device_id to use for each resource.
>          */
> -       static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
>                 {"BSG1160", },
>                 {"BSG2150", },
>                 {"INT33FE", },
>                 {"INT3515", },
> +       /*
> +        * HIDs of device with an UartSerialBusV2 resource for which userspace
> +        * expects a regular tty cdev to be created (instead of the in kernel
> +        * serdev) and which have a kernel driver which expects a platform_dev
> +        * such as the rfkill-gpio driver.
> +        */
> +               {"BCM4752", },
> +               {"LNV4752", },
>                 {}
>         };
>
> @@ -1727,8 +1735,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>              fwnode_property_present(&device->fwnode, "baud")))
>                 return true;
>
> -       /* Instantiate a pdev for the i2c-multi-instantiate drv to bind to */
> -       if (!acpi_match_device_ids(device, i2c_multi_instantiate_ids))
> +       if (!acpi_match_device_ids(device, ignore_serial_bus_ids))
>                 return false;
>
>         INIT_LIST_HEAD(&resource_list);
> --

Applied as 5.17 material, thanks!
