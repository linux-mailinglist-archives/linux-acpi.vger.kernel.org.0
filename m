Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173922EB139
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 18:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbhAERT3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 12:19:29 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33098 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbhAERT3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 12:19:29 -0500
Received: by mail-oi1-f176.google.com with SMTP id d203so350061oia.0;
        Tue, 05 Jan 2021 09:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6rJskTc4hEuFh9sBz5GYGc9LX37ZTG1VymDOHA5oC0=;
        b=l7vHBKjXB0oCWlck/jjxi1DHyejdBSriTWQQJgkBgCrzISw1wz/9Q6hDzqWvBmc1fW
         hH7lXSEicSvh0VMSBwXjUqZ4T50tIMSjwlcDH0ODOr+lGOOeQx6UJJP9tdSb1/73hCrr
         G2bSqOIB9MlUAiK7ZzXaKAaPyfOPdpM83UrrBJjJqYbO9cuL22dOGYrV2fLssVPMsEL7
         eIq9vkc60skqxDTUuYjUHtruWNezb+i46Ko+WCFx7K9OfYJZ8nIwIZX/qeD5/yJBMgro
         h8Msn4dzIxD50R9yhR11/SVdBaJHHwaEmIr4vjg4z3iMStU5HsZkQOaMD5WFQUXM1Saq
         twsw==
X-Gm-Message-State: AOAM533MbVrkunFZ4ps0CWbbG1n6gXKUjWrhCaVQauRaSQLB4lv3XTIc
        P5p0uizig+6YDpBIyNmrjoU5slIux6RUPaHGPRM=
X-Google-Smtp-Source: ABdhPJyeLw9qLKGDfXEat5y3Fu4ARdx1irTIcueXHn8PgQMkxdz03DWfT4YQb+KCnNSWSo2WsrQfBTIdi8X1XnO7U8A=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr389256oig.69.1609867127808;
 Tue, 05 Jan 2021 09:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
 <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com> <CAJZ5v0jcCD3qWUJQcS+nFVJWSCQEbq2eN3i07mN8yFr3WZD9dg@mail.gmail.com>
 <6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com>
In-Reply-To: <6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jan 2021 18:18:35 +0100
Message-ID: <CAJZ5v0je41iXQnr3m-RY9fD_C-qnqbLdqYMvUzp0qgBwEvVoJA@mail.gmail.com>
Subject: Re: [PATCH 0/2] IdeaPad platform profile support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 4, 2021 at 9:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/4/21 9:33 PM, Rafael J. Wysocki wrote:
> > On Mon, Jan 4, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 1/1/21 1:56 PM, Jiaxun Yang wrote:
> >>> Tested on Lenovo Yoga-14SARE Chinese Edition.
> >>>
> >>> Jiaxun Yang (2):
> >>>   ACPI: platform-profile: Introduce data parameter to handler
> >>>   platform/x86: ideapad-laptop: DYTC Platform profile support
> >>>
> >>>  drivers/acpi/platform_profile.c       |   4 +-
> >>>  drivers/platform/x86/Kconfig          |   1 +
> >>>  drivers/platform/x86/ideapad-laptop.c | 281 ++++++++++++++++++++++++++
> >>>  include/linux/platform_profile.h      |   5 +-
> >>>  4 files changed, 287 insertions(+), 4 deletions(-)
> >>
> >>
> >> Thank you for your series, unfortunately the
> >> "ACPI: platform-profile: Introduce data parameter to handler"
> >> patch causes a conflict with the pending:
> >> "[PATCH v8 3/3] platform/x86: thinkpad_acpi: Add platform profile support"
> >> patch.
> >>
> >> But I do agree that adding that data parameter makes sense, so
> >> it might be best to merge:
> >>
> >> "ACPI: platform-profile: Introduce data parameter to handler"
> >>
> >> First and then rebase the thinkpad_acpi patch on top.
> >>
> >> Rafael, do you think you could add:
> >>
> >> "ACPI: platform-profile: Introduce data parameter to handler"
> >>
> >> To the 2 ACPI: platform-profile patches which you already have pending for 5.11-rc# ?
> >
> > I'm not sure why that patch is needed at all, because whoever
> > registers a platform profile handler needs to have access to the
> > original handler object anyway.
>
> True, I was actually thinking that instead of the data argument, we might
> pass a pointer to the original handler object like this:
>
> @@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
>                 return -ENODEV;
>         }
>
> -       err = cur_profile->profile_get(&profile);
> +       err = cur_profile->profile_get(cur_profile, &profile);
>         mutex_unlock(&profile_lock);
>         if (err)
>                 return err;

I would prefer this approach.

>
> And then the driver which has registered the cur_profile, can get to
> its own data by using container of on the cur_profile pointer.
>
> With the code currently in your bleeding-edge branch, there is no way
> for any driver-code to get to its own (possibly/likely dynamically
> allocated) driver-data struct.
>
> E.g. a typical driver using only dynamic data tied to device_get_drvdata,
> might have this:
>
> struct driver_data {
>         ...
>         struct platform_profile_handler profile_handler;
>         ...
> };
>
> int probe(...) {
>         struct driver_data *my_data;
>
>         my_data = devm_kzalloc(dev, sizeof(*my_data), GFP_KERNEL);
>
>         ...
>
>         ret = platform_profile_register(&my_data->profile_handler);
>         ...
> }
>
> And with the change which I suggest above would then be able to
> get the struct driver_data *my_data back from the profile_get callback by
> using container_of on the struct platform_profile_handler *profile_handler
> argument added to the profile_get callback.

OK, fair enough.

> I know that the platform_profile stuff is intended to only have a
> single provider, so this could use global variables, but some
> drivers which may be a provider use 0 global variables (other then
> module_params) atm and it would be a lot cleaner from the pov
> of the design of these drivers to be able to do something like the
> pseudo code above. Which is why I added my Reviewed-by to patch 1/2
> of the series from this thread.
>
> Patch 1/2 does use a slightly different approach then I suggest above,
> thinking more about this it would be cleaner IMHO to just pass the
> cur_profile pointer to the callbacks as the pseudo-code patch which I
> wrote above does. Drivers which use globals can then just ignore
> the extra argument (and keep the platform_profile_handler struct const)
> where as drivers which use dynamic allocation can embed the struct in
> their driver's data-struct.

Agreed.

> > Also, on a somewhat related note, I'm afraid that it may not be a good
> > idea to push this series for 5.11-rc in the face of recent objections
> > against new material going in after the merge window.
>
> That is fine with me, since this did not make rc1 (nor rc2) I'm not entirely
> comfortable with sending out a late pull-req for the pdx86 side of this
> either, so lets postpone this to 5.12 (sorry Mark).
>
> Rafael, once we have the discussion with the passing a pointer back to
> the drivers data thing resolved (and a patch merged for that if we go
> that route) can you provide me with an immutable branch to merge into
> pdx86/for-next so that I can then merge the pdx86 bits on top ?

Sure, no problem.

> Note this does not need to be done right now around say rc4 would be fine,
> so that we have some time for the patches currently in bleeding-edge to
> settle a bit.

OK

Cheers!
