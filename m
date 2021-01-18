Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C418D2FA5FC
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 17:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405963AbhARQWM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 11:22:12 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34602 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406483AbhARQWH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2021 11:22:07 -0500
Received: by mail-ot1-f54.google.com with SMTP id a109so16801754otc.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2021 08:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4jlxNEkTIoTCMP+fSJd7J3S1kyMvbFjQpU8fqKb0MA=;
        b=Trk3roGq3ziATIp++9Ly1wkZ/R2PYuN8W/tyi7ytIYFit3bOZJ+gPCM/QU2yPUIrqm
         Ufs096v/qUNdf4UZ+gEBT3OYP2z1LGfOgIayI/E5jU8Ts/HCM054Od4jgOMnPrxwZtpi
         PHCxgpIaWLybVTRCyQCDXgFUt4NG0zngatyFOLMJsvO+WdrZ9L+q6hXDcWlnklLafVtc
         uSPTtTxNyAVrcxq2sUcdpdEMpDnWscItCRzlAEGzpGaa+gqe+zLqENRRdbCzl+y4XAlR
         Mfh02vVB5nZVo+7cS2lIY218ns+lDkxXaB1qEGfo4KvBhIsBQ7pXHGxo1wbnFCRRqf+P
         7zmA==
X-Gm-Message-State: AOAM531/L/gRIibl8Mzk0ySdS2YINHtjA9uP1IiYZqlZAwKHFkLxmGPh
        Pam3It5dw636Dz127uX24H+rwDXmEPECOOdPSZ0=
X-Google-Smtp-Source: ABdhPJxxBD3CtZs1ERlMGycmwZwT24Mf99/iKaN6xK1pydwSKwj+nGwgHKFlpgbqONSEGTAr28g2vWyCtD1hpGHObEI=
X-Received: by 2002:a05:6830:4b5:: with SMTP id l21mr168218otd.321.1610986880271;
 Mon, 18 Jan 2021 08:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20210115215752.389656-1-hdegoede@redhat.com> <CAJZ5v0gk0ninRntm508SAgzSrRe5gjZ+-e5ac1h-Cx2reVOSfg@mail.gmail.com>
 <9e548c41-fdb0-4b4b-ccc3-81dba39d4904@redhat.com>
In-Reply-To: <9e548c41-fdb0-4b4b-ccc3-81dba39d4904@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Jan 2021 17:21:09 +0100
Message-ID: <CAJZ5v0jHpTHRdneq2+bYa69bpJduzH8nomQM9VbytYaE4t7Ymw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Make acpi_bus_get_device() clear the adev ptr
 on error
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 18, 2021 at 5:09 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/18/21 2:58 PM, Rafael J. Wysocki wrote:
> > On Fri, Jan 15, 2021 at 10:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Set the acpi_device pointer which acpi_bus_get_device()
> >> returns-by-reference to NULL on error.
> >>
> >> We've recently had 2 cases where callers of acpi_bus_get_device()
> >> did not properly error check the return value, using the
> >> returned-by-reference acpi_device pointer blindly, set it to NULL
> >> so that this will lead to an immediate oops, rather then following
> >> a pointer to who knows what.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> > This should fix the crash reported by Pierre-Louis,
>
> Ack, sounds good.
>
> > so let me apply it
> > instead of the two debug changes posted by me
> > (https://lore.kernel.org/linux-acpi/98e6ed8e-884e-adb4-a146-a66daefa94a7@redhat.com/T/#md5add2fe554a30e3a929d87a66b435f4cc8bf628).
>
> Note we should still fix the USB case, my patch will make failure
> there more obvious, but the code can theoretically still dereference
> a NULL pointer in drivers/usb/core/usb-acpi.c.

Because usb_acpi_find_port() checks the acpi_device pointer passed to
it against NULL, we're safe here as well.

> And we probably also want this change:
>
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1867,7 +1867,8 @@ static u32 acpi_scan_check_dep(acpi_hand
>          * 2. ACPI nodes describing USB ports.
>          * Still, checking for _HID catches more then just these cases ...
>          */
> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
> +       if (!acpi_has_method(handle, "_DEP") || acpi_has_method(handle, "_ADR")
> +           || !acpi_has_method(handle, "_HID"))
>                 return 0;
>
>         status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
>
> To reduce the amount of work we do checking _DEP-s.

So I was thinking about that, but I'd leave it as is unless we have a
use case in which looking for _ADR is really necessary.

In the majority of cases the device objects with both _ADR and _HID
really are _HID devices and _ADR returns 0.  Of course, that could be
treated as a special case, but unless it is necessary to add a check
for this special case, I'd rather avoid doing that.
