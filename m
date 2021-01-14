Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3062F60F6
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 13:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhANMRS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 07:17:18 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37309 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbhANMRO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2021 07:17:14 -0500
Received: by mail-ot1-f47.google.com with SMTP id o11so4977632ote.4;
        Thu, 14 Jan 2021 04:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKPfJLF9iRxoYE42LhdNndZuWy7KRy7TVrhbL4lB9EY=;
        b=Nxmw/D3cxghbMimlroGS2RMwLgvDp0Z9h15qy4CSos/EC4MvGRmvO571eP8cGqVno6
         Z8URQCLwBdagbERpnAt4+YMKQX2XkNJmWASP10LoCOiuWuloDRh8KWvHLEKWS6d09UlP
         IWIgR74u0Zv1br5oYt8rSwJfNbjX8nedYwSTleqMitp+7Wj6/qAQyaYxW7JECAnOsIwk
         63heWMGZ224+lkfepcyze/v1jyVkYGZ9FR4cuo0UKMIqYX+wnsDRV6XBZ9BNVKF1KIkb
         XGcefIx8NJFyKNib4gs+6GrCzQMU7IBlfG0I21+YVLGaAEJ4wQ5DiQCgZHLRLTSXl+Y7
         G56Q==
X-Gm-Message-State: AOAM530n/+akNNfEXbZE60JRpTIIw857+en4brvY3wqrYtzdROdFqIXB
        0gTSebJBTA4ZrO6j/lBvpiq9lfV8yS13XXK6Lgs=
X-Google-Smtp-Source: ABdhPJz2/t2VsrTR/UXGRJS3p8JAoj5C7JxHIUIkWs9Brhqo4wVBpeFy+EFfZOT/dyDuJ4IitI4gSjMhZa7dmBkD0L4=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr4502295otk.206.1610626593091;
 Thu, 14 Jan 2021 04:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20210114073429.176462-1-jiaxun.yang@flygoat.com> <20210114073429.176462-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20210114073429.176462-2-jiaxun.yang@flygoat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jan 2021 13:16:20 +0100
Message-ID: <CAJZ5v0i=bFw7WJA615UyLXnZ4kgK4E+0ZB=Ykgge+o3+9onnPA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] ACPI: platform-profile: Drop const qualifier
 for cur_profile
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 14, 2021 at 8:42 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> All planned uses of cur_profile have their platform_profile_handler
> defined as const, so just drop const qualifier here to prevent build
> error.
>
> Link: https://lore.kernel.org/linux-acpi/5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com/
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/acpi/platform_profile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 91be50a32cc8..9dddf44b43d4 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -9,7 +9,7 @@
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
>
> -static const struct platform_profile_handler *cur_profile;
> +static struct platform_profile_handler *cur_profile;

I think that it's not just here, but also in the
platform_profile_register() argument.

>  static DEFINE_MUTEX(profile_lock);
>
>  static const char * const profile_names[] = {
> --
> 2.30.0
>
