Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3042AF7A
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 00:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhJLWGU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 18:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhJLWGT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 18:06:19 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5788AC061570;
        Tue, 12 Oct 2021 15:04:17 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g6so1747427ybb.3;
        Tue, 12 Oct 2021 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=auG+UMx9zytYp9lINzhPZO9u/TFK5cE+R08OejH5B0w=;
        b=ne7652o0LqsXxa1F1cgXnxgCK2bxwNWHDrsyhUBtlAmcbIV/AtPK8pJIgvmbUIbEaD
         h92TyPmec2iTl0SXhH/vi63WZzRK7W9caxUYKHcMVdC227jK67QU7owKiG83zjMU3MBb
         bb61mGP/yDMpyVAZSY0IJkRZEr5mk50g0hAEHr7RL+q8EBT1w+cNjzMVs2cIG0y5xbic
         0W86qaLtxTeBPyMXA9tztIq7/maRwyqxexf/TqB2kPSdB0xbM9RVHUrOajFjEvlJyYQ0
         dktD5Gp41bhoYKK2kIZbhi3WP5OQSlqIMuFHUEaAawTV36hlLtIqFepSObHS1+HC79YP
         Ogiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auG+UMx9zytYp9lINzhPZO9u/TFK5cE+R08OejH5B0w=;
        b=TgVVpCFeeQ/vQKCJOJ4iQ8J/rUKOflS5NOQ4+8PWCVLXWt5a8KXQjIE/5V5V89Wsnn
         J7GckFl/P5kaxqpxoNsoGT645gB5zGXaX8gFpQqWQGhF7UiVQB6qw6G/Ln3vHyYSFC4I
         cI1HKbLrGc3SVSlctH50+Y8QO/S6xE5GkMmF2T/QPZ/6DMsclhLXWaAyzMq3XAC/jcpd
         BSnvKuZGF4QDLU88pfrDLNCjRh2+ecuDgexjMBavV6kN0mnE8Cj8nnqEwgihFI0YQ7SF
         OmDAEUMM/35yLYPgaJmU7EIlzFpu3I1BEFnlVgNAuDpSoF1XsHjvtAz0y3an2NnWenwW
         7SOg==
X-Gm-Message-State: AOAM531zKIk+pDt4q7UKMdtOOIzAnkeKv9nRlj8MyJ1LC/TIc2YbDjTG
        4f7kJMH0fUpMHRX9x3/QZd1fIooEkC+yIRiKW8k=
X-Google-Smtp-Source: ABdhPJy122ifGFhlEjzoGnOh1Y838UQ+5VnA3gX7zYtFxeJ4IZzHKXhB7X/f+krIMq3PbEeKYpoBnJ7DKFa3wwIoKco=
X-Received: by 2002:a25:9a81:: with SMTP id s1mr32001654ybo.230.1634076256610;
 Tue, 12 Oct 2021 15:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <4369779.LvFx2qVVIh@kreacher> <21245442.EfDdHjke4D@kreacher>
In-Reply-To: <21245442.EfDdHjke4D@kreacher>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 13 Oct 2021 08:04:05 +1000
Message-ID: <CACAvsv4-MUEuoq0cb3mQ2PK3u8jnD7U2yPHVM++57X6QZEDX2w@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] nouveau: ACPI: Use the ACPI_COMPANION() macro directly
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 13 Oct 2021 at 03:58, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael@kernel.org>
>
> The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
> macro and the ACPI handle produced by the former comes from the
> ACPI device object produced by the latter, so it is way more
> straightforward to evaluate the latter directly instead of passing
> the handle produced by the former to acpi_bus_get_device().
>
> Modify nouveau_acpi_edid() accordingly (no intentional functional
> impact).
>
> Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nouveau_acpi.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/gpu/drm/nouveau/nouveau_acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ linux-pm/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -364,7 +364,6 @@ void *
>  nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
>  {
>         struct acpi_device *acpidev;
> -       acpi_handle handle;
>         int type, ret;
>         void *edid;
>
> @@ -377,12 +376,8 @@ nouveau_acpi_edid(struct drm_device *dev
>                 return NULL;
>         }
>
> -       handle = ACPI_HANDLE(dev->dev);
> -       if (!handle)
> -               return NULL;
> -
> -       ret = acpi_bus_get_device(handle, &acpidev);
> -       if (ret)
> +       acpidev = ACPI_COMPANION(dev->dev);
> +       if (!acpidev)
>                 return NULL;
>
>         ret = acpi_video_get_edid(acpidev, type, -1, &edid);
>
>
>
