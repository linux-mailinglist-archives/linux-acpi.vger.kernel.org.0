Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280BF35CF6A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 19:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbhDLR1r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 13:27:47 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37805 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbhDLR1o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 13:27:44 -0400
Received: by mail-ot1-f46.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so13536438otr.4;
        Mon, 12 Apr 2021 10:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6klGD9EcUWmrr+BBKVaADkc8y5yUlNEislrWiLvoVCY=;
        b=P3BdB4mHbQ1+OVcwgTiruAHgY3QKYjkVGMZb4b1zLmswbWdN1vbwo7T+kVbGdddfY9
         D0SLiGk8PMu63ngIqBZW2okDV8lgon8jyjrtl5KsN8oUwmFMgnUbyQAQ9wN2Jib2952d
         qoZkxWo13II3+aMQOoKzGW8KNAixzCenJUg9E0Vxt+rX2m5hNOFAoqhFU0LxGprR3H7M
         H/Bq5+7w21Xc/ML5iSMODmisU7K5jbeops0n990eRTV8EZVwWuvDMv6WV7uN8+PYc1Uq
         n6pOYa+RTiy2uUkwQdFcjG1BGheYIG9kKq0zlrd+bHB6J6XTCi9pr2yaefwcIq06lU8o
         Q1SA==
X-Gm-Message-State: AOAM532xf3PEI73rxQ+f7yvTIWKzYa1/CkYOtDPk2NcNgZx+5PD+nvFU
        VyOC8NE4oZlCKxC/4BdXMJZ7stTk1k2vsf5rNZE=
X-Google-Smtp-Source: ABdhPJx0EQX6K4l1kMzTdAv37j5nDWDkEKrMDdnZsl56lHkLPYVqwPRKEbVAR1NGzOcXUCyH/cjaw2bzjShSUeBixD8=
X-Received: by 2002:a9d:6951:: with SMTP id p17mr12000140oto.206.1618248445538;
 Mon, 12 Apr 2021 10:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210410131304.1858623-1-andy.shevchenko@gmail.com>
In-Reply-To: <20210410131304.1858623-1-andy.shevchenko@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Apr 2021 19:27:14 +0200
Message-ID: <CAJZ5v0jJoWnnx7ce82trnzsnBTMEDf1oXwFBDc0RUj-=p7hjLQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: utils: Document for_each_acpi_dev_match() macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Daniel Scally <djrscally@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Apr 10, 2021 at 3:29 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> The macro requires to call acpi_dev_put() on each iteration.
> Due to this it doesn't tolerate sudden disappearence of the devices.
>
> Document all these nuances to prevent users blindly call it without
> understanding the possible issues.
>
> While at it, add the note to the acpi_dev_get_next_match_dev() and
> advertise acpi_dev_put() instead of put_device() in the whole family
> of the helper functions.
>
> Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro")
> Cc: Daniel Scally <djrscally@gmail.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/acpi/utils.c    | 12 ++++++++----
>  include/acpi/acpi_bus.h | 13 +++++++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index f1aff4dab476..3f3171e9aef5 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -811,7 +811,7 @@ static int acpi_dev_match_cb(struct device *dev, const void *data)
>   * Note that if the device is pluggable, it may since have disappeared.
>   *
>   * Note that unlike acpi_dev_found() this function checks the status
> - * of the device. So for devices which are present in the dsdt, but
> + * of the device. So for devices which are present in the DSDT, but
>   * which are disabled (their _STA callback returns 0) this function
>   * will return false.
>   *
> @@ -838,7 +838,7 @@ EXPORT_SYMBOL(acpi_dev_present);
>
>  /**
>   * acpi_dev_get_next_match_dev - Return the next match of ACPI device
> - * @adev: Pointer to the previous acpi_device matching this @hid, @uid and @hrv
> + * @adev: Pointer to the previous ACPI device matching this @hid, @uid and @hrv
>   * @hid: Hardware ID of the device.
>   * @uid: Unique ID of the device, pass NULL to not check _UID
>   * @hrv: Hardware Revision of the device, pass -1 to not check _HRV

The two cleanups above are not related to the subject of the patch.
Please separate them.

> @@ -846,7 +846,11 @@ EXPORT_SYMBOL(acpi_dev_present);
>   * Return the next match of ACPI device if another matching device was present
>   * at the moment of invocation, or NULL otherwise.
>   *
> - * The caller is responsible to call put_device() on the returned device.
> + * Note, the function does not tolerate the sudden disappearance of @adev, e.g.
> + * in the case of hotplug event.

"of a hotplug event"

> That said, caller should ensure that this will

"the caller"

> + * never happen.
> + *
> + * The caller is responsible to call acpi_dev_put() on the returned device.

"responsible for"

And I would say "responsible for invoking".

>   *
>   * See additional information in acpi_dev_present() as well.
>   */
> @@ -875,7 +879,7 @@ EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
>   * Return the first match of ACPI device if a matching device was present
>   * at the moment of invocation, or NULL otherwise.
>   *
> - * The caller is responsible to call put_device() on the returned device.
> + * The caller is responsible to call acpi_dev_put() on the returned device.
>   *
>   * See additional information in acpi_dev_present() as well.
>   */
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index f28b097c658f..834b7a1f7405 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -689,6 +689,19 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const cha
>  struct acpi_device *
>  acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
>
> +/**
> + * for_each_acpi_dev_match - iterate over ACPI devices that matching the criteria
> + * @adev: pointer to the matching ACPI device, NULL at the end of the loop
> + * @hid: Hardware ID of the device.
> + * @uid: Unique ID of the device, pass NULL to not check _UID
> + * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
> + *
> + * The caller is responsible to call acpi_dev_put() on the returned device.

As per the above.

> + *
> + * Due to above requirement there is a window that may invalidate @adev and
> + * next iteration will use a dangling pointer, e.g. in the case of hotplug
> + * event. That said, caller should ensure that this will never happen.
> + */
>  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                   \
>         for (adev = acpi_dev_get_first_match_dev(hid, uid, hrv);        \
>              adev;                                                      \
> --
> 2.31.1
>
