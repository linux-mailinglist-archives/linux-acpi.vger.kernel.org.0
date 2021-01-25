Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA03027F1
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbhAYQdq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 11:33:46 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46082 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbhAYQdj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 11:33:39 -0500
Received: by mail-ot1-f52.google.com with SMTP id d1so13264548otl.13;
        Mon, 25 Jan 2021 08:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l55QVF4VrL6ocZmUHtkJ6otUfGepGD+auScc838i8ms=;
        b=rdUDzWIotTUdI2138mTtTkt9Leqg7bqD9rY4G8jK2BRBVNPiFNZXsMfHm17K3kYIY5
         ni3sUArQnGN84EJWIfnyMcmC5eF28Z8ZHnp5QicRpJWmBd+/F0eNnRyYLE2trF8JrbjD
         4fQ3RRRf8kARb/qjAM9oLVjsC3y6JUvu0cpjx5kJuDLVa6wAMFDNB/dT7H93SqdEwmzX
         eztQRxOHBsUBiZY1jwMsdjAIswOKiAXjd7jpHK2qWM/VhCm0JxGhz9RaE4aAkVxWSEnT
         AKUnTYbzlh50ZHtU6ZEhCzVJRdH28lMFQjGjJzvA29G0F2/BGZzLGsjdRD2undOSkr/6
         q3lQ==
X-Gm-Message-State: AOAM530g+GUbapo3UfyMfEgzOKmoHQDm2tS4uk8EggOqLYYPr21NWCpm
        A44OOx77HLhtW0TrerXDyb/uWiQcXzmMrkMnr7A=
X-Google-Smtp-Source: ABdhPJxDggu17RQsj5ezHxbssaJ0G0xkX8skGmiLJ4XwvCSEtU+yqVITvuYtWcbIFkRxSeFqVpjdEYZHRObYovk0qQ0=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr1009172ote.321.1611592373746;
 Mon, 25 Jan 2021 08:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20210125115957.3292-1-hdegoede@redhat.com> <20210125115957.3292-2-hdegoede@redhat.com>
In-Reply-To: <20210125115957.3292-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jan 2021 17:32:42 +0100
Message-ID: <CAJZ5v0hfd_c9jWZFQVN4tHioXez1buBv2pdne+6zYEXoPLQgRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: platform-profile: Drop const qualifier for cur_profile
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

On Mon, Jan 25, 2021 at 1:13 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> Drop the const qualifier from the static global cur_profile
> pointer declaration.
>
> This is a preparation patch for passing the cur_profile pointer as
> parameter to the profile_get() and profile_set() callbacks so that
> drivers dynamically allocating their driver-data struct, with their
> platform_profile_handler struct embedded, can use this pointer to
> get to their driver-data.
>
> Note this also requires dropping the const from the pprof
> platform_profile_register() function argument. Dropping this
> const is not a problem, non of the queued up consumers of
> platform_profile_register() actually pass in a const pointer.
>
> Link: https://lore.kernel.org/linux-acpi/5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com/
> Link: https://lore.kernel.org/r/20210114073429.176462-2-jiaxun.yang@flygoat.com
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> [hdegoede@redhat.com: Also remove const from platform_profile_register()]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2 (Hans de Goede):
> - Not only remove the const from the global cur_profile variable declaration,
>   but also from the platform_profile_register() argument
> - Reword commit message to match

Applied as 5.12 material on top of the previous platform-profile
commits, thanks!

I will expose a separate branch with these commits when they get some
linux-next build coverage.

> ---
>  drivers/acpi/platform_profile.c  | 4 ++--
>  include/linux/platform_profile.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 91be50a32cc8..f65c61db7921 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -9,7 +9,7 @@
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
>
> -static const struct platform_profile_handler *cur_profile;
> +static struct platform_profile_handler *cur_profile;
>  static DEFINE_MUTEX(profile_lock);
>
>  static const char * const profile_names[] = {
> @@ -132,7 +132,7 @@ void platform_profile_notify(void)
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_notify);
>
> -int platform_profile_register(const struct platform_profile_handler *pprof)
> +int platform_profile_register(struct platform_profile_handler *pprof)
>  {
>         int err;
>
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 3623d7108421..c797fdb3d91a 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -32,7 +32,7 @@ struct platform_profile_handler {
>         int (*profile_set)(enum platform_profile_option profile);
>  };
>
> -int platform_profile_register(const struct platform_profile_handler *pprof);
> +int platform_profile_register(struct platform_profile_handler *pprof);
>  int platform_profile_remove(void);
>  void platform_profile_notify(void);
>
> --
> 2.29.2
>
