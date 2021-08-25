Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37753F7BDE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Aug 2021 19:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhHYR7I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Aug 2021 13:59:08 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40575 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhHYR7G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Aug 2021 13:59:06 -0400
Received: by mail-ot1-f43.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso46115otu.7
        for <linux-acpi@vger.kernel.org>; Wed, 25 Aug 2021 10:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJKdl7QPuJGT7gssJP54/BAC6vLeOMdcvaNMVtHKo7c=;
        b=FkXEjFUDjnUIriRHmxe5F9Vej30zPbr0zaJtEw+m3HHeP31C3CH6xgczvXJSrlxbMU
         82Me8wQ2d/mvjXy1ahoXbk9Nx4OyrM79HuIKbfzxEwAhHyCS0TVtTY7iWwj+MdoYIipR
         vLOvnmv7qkjSjpfCI5OGDJr55Y7M1gDek/yqgg8RSkR5UrlN3Ag4XXHi/f/rNEB0Lw0K
         c9nAiZLQ1vsffk/g+ICjBeQ78IKD+jMXSGNiRV13WLxy+0x0OR/dBERboCP0Ely3KX5x
         jwUbe/U7S4on3DgQjndXJY5Y5Ahz7v1QWNFC5OKdMO9J4SOgGawHN5nrYd8r19vTghSJ
         WoSA==
X-Gm-Message-State: AOAM532ZVFNHf67NAQN8P/4bYAmnimyTccF71sY6UNuYZBJcmYKcZGbA
        Bs2Ddt8AogiGU8x49lD95h2eBILzNGhQ0ngLzMs=
X-Google-Smtp-Source: ABdhPJxUCkRaWkrHcBTEBIkQA+Z6G3YjbH0+beOQrir2agH+PJ7f4ryUtzc1QD+oBZFeBzq8rDneCurBIzAvBcOIdEs=
X-Received: by 2002:a9d:a57:: with SMTP id 81mr24652419otg.260.1629914299765;
 Wed, 25 Aug 2021 10:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210824125744.11125-1-ulrich@huberulrich.de>
In-Reply-To: <20210824125744.11125-1-ulrich@huberulrich.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Aug 2021 19:58:08 +0200
Message-ID: <CAJZ5v0hxoRc0CqmEccf+N045GK6b_7WrPyJ_peVaNTobsH+AQg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Add DMI quirk for Lenovo Yoga 9 (14INTL5)
To:     Ulrich Huber <ulrich@huberulrich.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 24, 2021 at 3:03 PM Ulrich Huber <ulrich@huberulrich.de> wrote:
>
> The Lenovo Yoga 9 (14INTL5)'s ACPI _LID is bugged:
>
> After hibernation the lid is initially reported as closed.
> Once closing and then reopening the lid reports the lid as
> open again. This leads to the conclusion that the initial
> notification of the lid is missing but subsequent
> notifications are correct.
>
> In order fo the Linux LID code to handle this device properly
> the lid_init_state must be set to ACPI_BUTTON_LID_INIT_OPEN.
>
> Signed-off-by: Ulrich Huber <ulrich@huberulrich.de>
> ---
>  drivers/acpi/button.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index f25bd336113b..1f9b9a4c38c7 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -77,6 +77,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>                 },
>                 .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
>         },
> +       {
> +               /*
> +                * Lenovo Yoga 9 14ITL5, initial notification of the LID device
> +                * never happens.
> +                */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "82BG"),
> +               },
> +               .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
> +       },
>         {
>                 /*
>                  * Medion Akoya E2215T, notification of the LID device only
> --

Applied as 5.15 material, thanks!
