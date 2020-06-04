Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F661EE357
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 13:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgFDLWz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 07:22:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35236 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgFDLWz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2020 07:22:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id k4so3193468oik.2
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jun 2020 04:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsCRunjZvZ0+jqjVBlLQx5aTyOTiJGMhS0LgHnlrXqg=;
        b=ESXyRlwPxA/kkEzzBk+OnfTbOv0EVrtBXQSxiWOOn7VtVbU9Y2xLOT/aot3Co0ma5r
         bwBKUvwaTvSUjIL1Onq5xpAOgJULINmjOAKvH//VhtvVfaZccUo0z+r3Rq0IqIbzKbGk
         PNIV37GovU/iG8BpCaylhE7ObLRbxRBk3gG2IFmc9WHP9AbB6UrRty5WuVPNKfWQVJyn
         4s/3s9i1IchrK+KNY0Me5UM09dNBwHySt64xSDM0fuQwP6mOs/yoROUd18jdzWcFTB+/
         v3NV6Jg5K/AqMN4DLj6g24S0XtvyUdPt2k3BA+71oSX3ZR1W0XBHd6/fFtIgXcEXAj4W
         0g+w==
X-Gm-Message-State: AOAM533WCO2Ic9nj3egnuBogEDyRt8pYbPyM8cHDI7DEzZAtbRecjOd5
        IcHlQn+zgRvIQHJewA3eFWN56WCND59DhE8t4Aw=
X-Google-Smtp-Source: ABdhPJy6dB4zm9CZoYpSYJXTKyr2byP4wGB8MxNBHc+KN6WGoMYobygFNlIySIl8HyQ4VlDTVX/ozw7NCaTAjPAr3vM=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr2855675oie.103.1591269774462;
 Thu, 04 Jun 2020 04:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200603194659.185757-1-hdegoede@redhat.com>
In-Reply-To: <20200603194659.185757-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Jun 2020 13:22:43 +0200
Message-ID: <CAJZ5v0g7rhiWs0ZeGGS5OoSMH7DiVT1D-EUgX5HFXYkcvXcm2Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PM: Do not infer power-state if there are no D0 power-resources
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        youling257@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 3, 2020 at 9:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some devices do not have a power-resource-list for D0, but do have a
> power-resource-lists for e.g. D3 (_PR3).

This looks like a bug in the firmware.

It is hard to imagine a design in which some power resources only need
to be "on" in the D3hot power state of a device and not in D0 (which
is implied by the lack of _PR0 and the presence of _PR3).

So when the device goes from D0 to D3hot, we are expected to turn some
power resources "on"?  What sense does this make?

I'm guessing that this only works at all, because we only use D0 and
D3cold with the affected devices and _PS0 simply turns the power
resource(s) in question on.

> On these devices the "if (device->power.flags.power_resources)" check
> in acpi_device_get_power() succeeds because of the presence of the _PR3
> resources, so the code used to try and infer the power-state.
>
> In this case since there is no power-resource-list for D0, we can never
> infer that the device is in D0 even though it very well might be in D0.
> This results in the code inferring that the device is in D3HOT and on
> the first suspend acpi_device_set_power() skips calling _PS3 for the
> device because it thinks the device is already in D3.
>
> An example of a family of devices which are affected by this are
> Bay Trail based devices. The ACPI device for the XHCI controller on
> these devices does not have a _PR0 method, but it does have a _PR3
> method. The problem described above causes the XHCI controller's _PS3
> method not getting called on the first suspend of the device, which
> causes these devices to not reach the S0i3 power-state during suspend.
>
> Since we cannot infer if the device is in D0 or not when there is no
> power-resource-list for D0, the best thing to do is to change
> acpi_power_get_inferred_state() to return ACPI_STATE_UNKNOWN in this
> case.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205057
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/power.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index fe1e7bc91a5e..db54393a077b 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -807,6 +807,17 @@ int acpi_power_get_inferred_state(struct acpi_device *device, int *state)
>         if (!device || !state)
>                 return -EINVAL;
>
> +       /*
> +        * Some devices do not have a power-resource-list for D0, but do
> +        * have a power-resource-lists for e.g. D3 so we do end up here.
> +        * In this case we can never infer that the device is in D0 even
> +        * though it might very well be in D0, so return ACPI_STATE_UNKNOWN.
> +        */
> +       if (list_empty(&device->power.states[ACPI_STATE_D0].resources)) {
> +               *state = ACPI_STATE_UNKNOWN;
> +               return 0;
> +       }

Well, this makes things work on the particular affected platform, but
that seems to be just by accident, because _PS0 does something special
on it.

IMO this needs to be addressed elsewhere and in a different way.

Namely, it looks like if _PR0 is not present (or its return package is
empty), but _PR3 is present, we should use the _PR3 list of power
resources for D0 as well as for D3hot.

Let me cut a patch for that.

Thanks!
