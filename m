Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25E72ED539
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbhAGRL7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 12:11:59 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36194 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbhAGRL7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 12:11:59 -0500
Received: by mail-oi1-f170.google.com with SMTP id 9so8133215oiq.3;
        Thu, 07 Jan 2021 09:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PbEYJF/MvWbGrN60pFdKWGcw422aT1Ml4Xjt2II+jk=;
        b=pjrcQ8HIDqRPH8mr1fYsOYySO3QPQbMefiPXc0F1DgM5O9yYrWrXWpqWrKc46H1oJV
         2C7YbsVKZIu27UBMzNPWEI5Yj0YWBfZUp3HQZjM75tmOnCNe673/CYH4zLdejFCqlLUe
         Y9OjHgDR0rBgs0BxUoyGgpn9GvMsB8twdzT9hW4Q0vWGfxre6/9licxs/X89iidgzhnZ
         ZGF1rLgUkwQadPz1udTxS/qobsqih7U4chiQzF1GcbrHy4RgzNF3MW+qWCqrmG/jViG+
         xd/FTrYQcJJYmNA7UK9jUt6Ih4yI1JpzZnX0oiiRAt11a4Wtj42mDTHOuwlzYqBx+vTw
         f65Q==
X-Gm-Message-State: AOAM532Cyzkb4VJyRBWq2zJRUH+POUle67WcpTCKz/35uf4ty2Ukt8cT
        DKx6XTQI4qzmxWutmDlcWkS/wGF9LY5/4gArS60=
X-Google-Smtp-Source: ABdhPJwvt9RljOaJcwc//OOXu96K4s2vVFASiWCVYzOY7QE13L5vHON4PHIPfkcAKUzSL6SijcimmyHoyMuJHe8Vo8M=
X-Received: by 2002:aca:4892:: with SMTP id v140mr1981608oia.71.1610039478172;
 Thu, 07 Jan 2021 09:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20210105131447.38036-1-jiaxun.yang@flygoat.com>
 <20210105131447.38036-2-jiaxun.yang@flygoat.com> <683c8358-fd71-cd27-8e39-19fdf3e1f71f@redhat.com>
In-Reply-To: <683c8358-fd71-cd27-8e39-19fdf3e1f71f@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 18:11:07 +0100
Message-ID: <CAJZ5v0jHFqGu1hmFwkfWsvP37hQnhBiG4M_Pa7TTHYL4C1VgMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: platform-profile: Introduce object pointers
 to callbacks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
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

On Tue, Jan 5, 2021 at 2:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/5/21 2:14 PM, Jiaxun Yang wrote:
> > Add a object pointer to handler callbacks to avoid having
> > global variables everywhere.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
>
> > ---
> >  drivers/acpi/platform_profile.c  | 4 ++--
> >  include/linux/platform_profile.h | 6 ++++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> > index 91be50a32cc8..bb4d7b0fe2ac 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
> >               return -ENODEV;
> >       }
> >
> > -     err = cur_profile->profile_get(&profile);
> > +     err = cur_profile->profile_get(cur_profile, &profile);
> >       mutex_unlock(&profile_lock);
> >       if (err)
> >               return err;
> > @@ -104,7 +104,7 @@ static ssize_t platform_profile_store(struct device *dev,
> >               return -EOPNOTSUPP;
> >       }
> >
> > -     err = cur_profile->profile_set(i);
> > +     err = cur_profile->profile_set(cur_profile, i);
> >       mutex_unlock(&profile_lock);
> >       if (err)
> >               return err;
> > diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> > index 3623d7108421..43f4583b5259 100644
> > --- a/include/linux/platform_profile.h
> > +++ b/include/linux/platform_profile.h
> > @@ -28,8 +28,10 @@ enum platform_profile_option {
> >
> >  struct platform_profile_handler {
> >       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> > -     int (*profile_get)(enum platform_profile_option *profile);
> > -     int (*profile_set)(enum platform_profile_option profile);
> > +     int (*profile_get)(struct platform_profile_handler *pprof,
> > +                             enum platform_profile_option *profile);
> > +     int (*profile_set)(struct platform_profile_handler *pprof,
> > +                             enum platform_profile_option profile);
> >  };
> >
> >  int platform_profile_register(const struct platform_profile_handler *pprof);
> >
>

Applied with a modified subject and some edits in the changelog as
5.12 material, and I'm leaving the [2/2] to you.

Thanks!
