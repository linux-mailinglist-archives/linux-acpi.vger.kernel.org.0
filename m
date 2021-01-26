Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14050305C5D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313054AbhAZWrr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 17:47:47 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:46116 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391180AbhAZRWA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 12:22:00 -0500
Received: by mail-oo1-f52.google.com with SMTP id n127so4293219ooa.13;
        Tue, 26 Jan 2021 09:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPQdBJqdYP+qjgNaEERsih40G8gcGBWaXApD47b4ab0=;
        b=sJeWnktIr47xO0D5JsPzu/8l/za2M+V7XQkb4jKuhAzapyj7hDwoIAy0z+Aq8FVchp
         ouq2ZHMrZAwj6VRkwDRT3wyg0vFfG9Ty5iObELf13U1yA9YpcIilRkvc1FqXbcL1d3D9
         8AdQlG3YPlwdhrxoUoK10PgFkmLQRGpxUhGtFNmDw5cGozyaVcEgahFkAE7qmrXXL4uw
         7NCZIo/aLhGyt+08ny/qmRRbZKn5OlaRj67XAL9L+mRUEKSSzla39NB6XVGORzV9IHN3
         NK+T3JuAItrvnwlfHV6cVVEKoQBj6vgpCoJK8gQfoNwYkI0BF7brxyZDNxZGZ1io46LB
         SjvA==
X-Gm-Message-State: AOAM531fyHEIWaVIPYZTOUTkW8nHVdRDqMGuxBOd6As4pwyRin/L/kU6
        ioOvaO6Wq3BhYifr3ryF1g+tuLWMOsZMjj+JC9M=
X-Google-Smtp-Source: ABdhPJxzN3Vcgug7hAy03MdX9gmNg4LeJVwDsLrr/J+QfPOD4Fh1+RoiZaAX+fHDULYI/9pIjb7W32My19sL/x1R3Bc=
X-Received: by 2002:a4a:cb87:: with SMTP id y7mr4754105ooq.1.1611681679111;
 Tue, 26 Jan 2021 09:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com> <20210126155723.9388-5-mika.westerberg@linux.intel.com>
In-Reply-To: <20210126155723.9388-5-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jan 2021 18:21:08 +0100
Message-ID: <CAJZ5v0i+wCOFZOhyx6i=TUGMeWyQR4vXzDN06G6xheFwC66Tuw@mail.gmail.com>
Subject: Re: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit clear
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 5:01 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> From: Mario Limonciello <mario.limonciello@dell.com>
>
> The platform _OSC can change the hardware state when query bit is not
> set. According to ACPI spec it is recommended that the OS runs _OSC with
> query bit set until the platform does not mask any of the capabilities.
> Then it should run it with query bit clear in order to actually commit
> the changes. At the moment Linux only runs the _OSC with query bit set

And that's because there was nothing it could ask to control using the
_SB scope _OSC.

Today it is just reporting what features are supported by it.

However, with the upcoming USB4 CM support it needs to ask for the
control of that feature and that's why the _SB scope _OSC support
needs to be extended.  So it is not a fix for a bug or missing spec
coverage, which this part of the changelog kind of implies, it's just
enabling a new feature.

> and this is going to cause problems with the USB4 CM (Connection
> Manager) switch that is going to commit the switch only when the OS
> requests control over the feature.
>
> For this reason modify the _OSC support so that we first execute it with
> query bit set, then use the returned valu as base of the features we

s/valu/value/

> want to control and run the _OSC again with query bit clear.
>
> Also rename the function to better match what it does.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> ---
>  drivers/acpi/bus.c | 43 +++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 1682f8b454a2..ca7c7b2bf56e 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -282,9 +282,9 @@ bool osc_pc_lpi_support_confirmed;
>  EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
>
>  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
> -static void acpi_bus_osc_support(void)
> +static void acpi_bus_osc_negotiate_platform_control(void)
>  {
> -       u32 capbuf[2];
> +       u32 capbuf[2], *capbuf_ret;
>         struct acpi_osc_context context = {
>                 .uuid_str = sb_uuid_str,
>                 .rev = 1,
> @@ -321,17 +321,36 @@ static void acpi_bus_osc_support(void)
>                 capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
>         if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>                 return;
> -       if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
> -               u32 *capbuf_ret = context.ret.pointer;
> -               if (context.ret.length > OSC_SUPPORT_DWORD) {
> -                       osc_sb_apei_support_acked =
> -                               capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> -                       osc_pc_lpi_support_confirmed =
> -                               capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> -               }
> +
> +       if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> +               return;
> +
> +       capbuf_ret = context.ret.pointer;
> +       if (context.ret.length <= OSC_SUPPORT_DWORD) {
>                 kfree(context.ret.pointer);
> +               return;
>         }
> -       /* do we need to check other returned cap? Sounds no */
> +
> +       /*
> +        * Now run _OSC again with query flag clean and with the caps

s/clean/clear/

> +        * both platform and OS supports.

s/both platform and OS supports/supported by both the OS and the platform/

> +        */
> +       capbuf[OSC_QUERY_DWORD] = 0;
> +       capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> +       kfree(context.ret.pointer);
> +
> +       if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> +               return;
> +
> +       capbuf_ret = context.ret.pointer;
> +       if (context.ret.length > OSC_SUPPORT_DWORD) {
> +               osc_sb_apei_support_acked =
> +                       capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> +               osc_pc_lpi_support_confirmed =
> +                       capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> +       }
> +
> +       kfree(context.ret.pointer);
>  }
>
>  /* --------------------------------------------------------------------------
> @@ -1168,7 +1187,7 @@ static int __init acpi_bus_init(void)
>          * _OSC method may exist in module level code,
>          * so it must be run after ACPI_FULL_INITIALIZATION
>          */
> -       acpi_bus_osc_support();
> +       acpi_bus_osc_negotiate_platform_control();
>
>         /*
>          * _PDC control method may load dynamic SSDT tables,
> --
> 2.29.2
>
