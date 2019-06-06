Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3277936F9F
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2019 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfFFJOf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jun 2019 05:14:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43605 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfFFJOf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jun 2019 05:14:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id i8so1260167oth.10;
        Thu, 06 Jun 2019 02:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLgX6p7FhBmmKONiI7LCn0aMrjrfUyvH31neB/9dEKA=;
        b=qZjGCI/5XDLmFNQoTBT9YbNsMlM1sqDz6XyFWL8/DEUMOIrkevO54QXCzaWfvPNX2g
         JsW+UjKuPpbLQp4oX3CBm47P8ApY5Pr7lnHw66HAS09Ctq7MiWLnZ/0fsH6eBN1YCAYH
         2kyqMwQSZJpS5KCPugmGoYiSe11OWaAP+sB081IPHcrC3AJgv6VVzO8t9hd3SutVIm+a
         Kt8SDBVbA23ipABFvX488hdXecMtsTKJRhju+5sApjCQGV4mhM0nNmn8tJFczyviv5+g
         qKJIa4sfmQj5JKcc1F4RIX1F8j+4wGQcVMP6wUMYFD5JWZSO0TUgRHl01SU26Xop4Yk/
         FysA==
X-Gm-Message-State: APjAAAVs1F/NYvkWH9nPOwW8c1JmcXU84rfjTCzJa6KjkqChUJK3x6dQ
        hx/P5gR57oumsIiO8H5LM5pA7lB9hhxWkpHkp2g=
X-Google-Smtp-Source: APXvYqy++HcZt297Ay5ufKhRDZFFYnOmnirWeW/j9fQjPz8m5P5ukmUPlKPpAzI8bGDJR+EEITO/3hrqGIpsCzsX7VE=
X-Received: by 2002:a9d:6414:: with SMTP id h20mr1125746otl.118.1559812474315;
 Thu, 06 Jun 2019 02:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com> <1559747630-28065-2-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559747630-28065-2-git-send-email-suzuki.poulose@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jun 2019 11:14:23 +0200
Message-ID: <CAJZ5v0iRfsLDezWAnr+PcOKOGYQuFFX3bTyhvxoqJ4mN6sGOYA@mail.gmail.com>
Subject: Re: [PATCH 01/13] acpi: utils: Cleanup acpi_dev_match_cb
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 5, 2019 at 5:14 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> acpi_dev_match_cb match function modifies the "data" argument
> to pass on a result which could be easily deduced from the result
> of the bus_find_device() call at the caller site. Clean this
> up in preparation to convert the "match" argument for bus_find_device
> to accept a "const" data pointer, similar to class_find_device. This
> would allow consolidating the match routines for these two APIs.

This changelog can be improved IMO.

In fact, the final goal here is to pass (const void *) as the second
argument to acpi_dev_match_cb() (which you could do right away in this
patch if I'm not mistaken) which is because you want to modify the
prototype of bus_find_device().

So why don't you write something like this in the changelog:

"The prototype of bus_find_device() will be unified with that of
class_find_device() subsequently, but for this purpose the callback
functions passed to it need to take (const void *) as the second
argument.  Consequently, they cannot modify the memory pointed to by
that argument which currently is not the case for acpi_dev_match_cb().
However, acpi_dev_match_cb() really need not modify the "match" object
passed to it, because acpi_dev_get_first_match_dev() which uses it via
bus_find_device() can easily convert the result of bus_find_device()
into the pointer to return.

For this reason, update acpi_dev_match_cb() to avoid the redundant
memory updates and change the type of its second argument to (const
void *)."

>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/acpi/utils.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 7def63a..1391b63 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -725,8 +725,6 @@ bool acpi_dev_found(const char *hid)
>  EXPORT_SYMBOL(acpi_dev_found);
>
>  struct acpi_dev_match_info {
> -       const char *dev_name;
> -       struct acpi_device *adev;
>         struct acpi_device_id hid[2];
>         const char *uid;
>         s64 hrv;
> @@ -746,9 +744,6 @@ static int acpi_dev_match_cb(struct device *dev, void *data)

And why not to change the type of the second arg to "const void *data" here?

>             strcmp(adev->pnp.unique_id, match->uid)))
>                 return 0;
>
> -       match->dev_name = acpi_dev_name(adev);
> -       match->adev = adev;
> -
>         if (match->hrv == -1)
>                 return 1;
>
> @@ -818,7 +813,7 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>         match.hrv = hrv;
>
>         dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
> -       return dev ? match.adev : NULL;
> +       return dev ? to_acpi_device(dev) : NULL;
>  }
>  EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
>
> --
