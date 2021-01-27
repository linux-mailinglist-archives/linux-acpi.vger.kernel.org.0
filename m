Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C66730628B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 18:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344274AbhA0Rsu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 12:48:50 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38127 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343847AbhA0RsZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 12:48:25 -0500
Received: by mail-ot1-f54.google.com with SMTP id s2so2520130otp.5;
        Wed, 27 Jan 2021 09:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdHwbl73abB6VMNWToTNpqvH4TxI0Xt6czMeP1SSONU=;
        b=er5OIGZ1kW43ICfaAkQzJpytcPP1dgk+bpk7ontLmrmYEf8JTmJFyUIxah0NA02Q/h
         ZcxHroDwtGkyO7bpSvr+GHjGMU3DuC+ILUAeacI9nNQFxeNgnizJ28nUvNQRvCqySmPG
         xa0p53orHk2l6tTrHwCC/CLHnlz9xs5sFGzQpbOYM/8Ou+lTtIqLLPTPTSavse2HcHtR
         190Po2XTmd2vXjC1Jdz6jbz0w/iTpg/f/jgfv9TBmPFPU9dUSx5p4ucL4E0yGeXRvmQ1
         2qzHs9Xc+39dU0rkjY17b2iSSQNuYj1YgNeBUjhGiXj3Hj5ttwppvySH4VAYobRTljih
         u1wA==
X-Gm-Message-State: AOAM530+CDd5MzOINjK7Uf0IBrdiF21fOqvzTlHH6RJExBBxeO5WeRRH
        ovQeEmcROL7gAYEiIy4jZHDnkTYBbe8iLA7HASI=
X-Google-Smtp-Source: ABdhPJw6u6KdfHzrO2hRhAY3DwystwML/VIEMZE1ZlXSpGH7GLROPx503G79S+aeNM16cQlyOHZImsR58roCK+rTu+U=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr8426465ota.260.1611769664581;
 Wed, 27 Jan 2021 09:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20210125115957.3292-1-hdegoede@redhat.com> <20210125115957.3292-3-hdegoede@redhat.com>
In-Reply-To: <20210125115957.3292-3-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 18:47:33 +0100
Message-ID: <CAJZ5v0iVGpUxUVMAO4R9bz8dogFRoYun-9-4G_Mgzq0_WP305Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: platform-profile: Introduce object pointers
 to callbacks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 6:58 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> Add an object pointer to handler callbacks to avoid the need for
> drivers to have a global variable to get to their driver-data
> struct.
>
> Link: https://lore.kernel.org/linux-acpi/6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com/
> Link: https://lore.kernel.org/r/20210114073429.176462-3-jiaxun.yang@flygoat.com
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied on top of the previous platform-profile patches, thanks!

> ---
> Changes in v2 (Hans de Goede):
> - Tweak the commit message wording a bit
> ---
>  drivers/acpi/platform_profile.c  | 4 ++--
>  include/linux/platform_profile.h | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index f65c61db7921..80e9df427eb8 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
>                 return -ENODEV;
>         }
>
> -       err = cur_profile->profile_get(&profile);
> +       err = cur_profile->profile_get(cur_profile, &profile);
>         mutex_unlock(&profile_lock);
>         if (err)
>                 return err;
> @@ -104,7 +104,7 @@ static ssize_t platform_profile_store(struct device *dev,
>                 return -EOPNOTSUPP;
>         }
>
> -       err = cur_profile->profile_set(i);
> +       err = cur_profile->profile_set(cur_profile, i);
>         mutex_unlock(&profile_lock);
>         if (err)
>                 return err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index c797fdb3d91a..a26542d53058 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -28,8 +28,10 @@ enum platform_profile_option {
>
>  struct platform_profile_handler {
>         unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> -       int (*profile_get)(enum platform_profile_option *profile);
> -       int (*profile_set)(enum platform_profile_option profile);
> +       int (*profile_get)(struct platform_profile_handler *pprof,
> +                               enum platform_profile_option *profile);
> +       int (*profile_set)(struct platform_profile_handler *pprof,
> +                               enum platform_profile_option profile);
>  };
>
>  int platform_profile_register(struct platform_profile_handler *pprof);
> --
> 2.29.2
>
