Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045792C07CC
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 13:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgKWMoS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 07:44:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39786 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbgKWMoO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 07:44:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id f11so19526227oij.6;
        Mon, 23 Nov 2020 04:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDOKs+LWZAEtXD019s6TRQMEMxS8eHoo7U7CRierk2c=;
        b=YiS9//Z3mUEXyXBHc5XXGo5MPnpXdETZZOdyRPQ9C43jYrW/ibph6ellZbdHMhFL3i
         h8lXNZAupaNggopbIo0c2dpXtBotA3aD/U+jWpPOkvdmjnxoBseCd0lhcd8PpAx4/0Gl
         1BHaRTOcgiMq/Ry8jdzGTQj45tACjEEuuu70dbuPCtHI6UYJB6Azfmgxd+r4ZnCPBaz+
         /fmarJZzNu40IuwaekXLz+kkzow1hLbtnHn9Dz0GfLXdGLsECcKk9rTzcB0RmEhP8sXn
         uKJCkmBmulvynLHe5vu5Y4CSgzCdbaUFqSoAV9iU1E2qXbYhQrWntinFzNvd/DlgttH7
         v8og==
X-Gm-Message-State: AOAM533zBaiTAc68b34yTSmtlLyfHsc9klGzctg48Psb8033B3wESXNF
        N6YCAULHCc+gjOURwOEb2UxeaEAHbnbOvVfdrZTehS8C
X-Google-Smtp-Source: ABdhPJxlUELhJljvvZ8/43jcv4X43NR3x85e0tSj0AnNyAy02FR5lVITsJI179Pshd4f9slg0NLuAJGyfQb8NdS9GSo=
X-Received: by 2002:aca:da02:: with SMTP id r2mr10052427oig.157.1606135454539;
 Mon, 23 Nov 2020 04:44:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <1e081610a68043fe89ca5a2795963cbee6d5fc0f.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <1e081610a68043fe89ca5a2795963cbee6d5fc0f.1605896059.git.gustavoars@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 12:43:57 +0100
Message-ID: <CAJZ5v0hLYWKX__oZdcCY0D20pNqpw8SkiTPOCNOtpqe--QLp4Q@mail.gmail.com>
Subject: Re: [PATCH 064/141] ACPI: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 20, 2020 at 7:34 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/acpi/sbshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 53c2862c4c75..0b3de0e63633 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -231,6 +231,7 @@ static int smbus_alarm(void *context)
>                 case ACPI_SBS_BATTERY:
>                         acpi_os_execute(OSL_NOTIFY_HANDLER,
>                                         acpi_smbus_callback, hc);
> +                       break;
>                 default:;

Why don't you simply drop the default case below (it's empty anyway)?

>         }
>         mutex_unlock(&hc->lock);
> --
> 2.27.0
>
