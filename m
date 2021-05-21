Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AAC38CB83
	for <lists+linux-acpi@lfdr.de>; Fri, 21 May 2021 19:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhEURHY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 13:07:24 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40712 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbhEURHY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 May 2021 13:07:24 -0400
Received: by mail-ot1-f53.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so8086847oty.7;
        Fri, 21 May 2021 10:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhGZ7NI9ZeLvK46YxnKVRZc/2Rywq66p60+gUbU2hm0=;
        b=LI3Ci57yN6m3XY+/dp1HHXYDIKeswQ9b/5EODViU6DhjUE7St72cUh4LiZHD4+dg7t
         1l3COT5qjI3+sWsEcfKl9kYerfSZFqeH4/1nRjGEX97RH0r/6DyGAvZeTAf7e4dQaVAo
         10WU3DNDvaQiH5fR9h6rCN+YE4U8U1Mjr7XNzTcG07wBBi0alXWHPgb2B7a9LZqPW+7Z
         b86jDTa+aCmuzxr1twR5m+JqIdB97AVe0WotborAqoBkq/nwVkBiPCEKw3L550kjwu6V
         QwpWTSZYUohgi5I3+L8cduKaGcmoEVwFVhT8ElqsvDdwcrW3wBZHHqFxqZnAGV8B6lM+
         MtQA==
X-Gm-Message-State: AOAM5333Y7HBunQrGOTVtP3rXajFcAkgluTBeObLmqg2LslbfaGZOWrB
        EybtFaCyTkF1fSdG3W2gDacNrScqxFHdlymSNYM=
X-Google-Smtp-Source: ABdhPJxQPk6S3dm3u0ToWhctkV6q8gSUbtc+5SXPBvA7ZPeyeHTNSjtUcqKtH7hajH4ufwToKT4eIYY8gWFt7IYAzCc=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr9576270otc.206.1621616759559;
 Fri, 21 May 2021 10:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210517232312.GA43474@embeddedor>
In-Reply-To: <20210517232312.GA43474@embeddedor>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 19:05:48 +0200
Message-ID: <CAJZ5v0ivxriijonzQP=8Z-ctHaFMYw4ro4DGMeBcExLv1RDnEw@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: Fix fall-through warning for Clang
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

On Tue, May 18, 2021 at 1:22 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> fallthrough warning by simply dropping the empty default case at
> the bottom.
>
> This contributes to the ongoing efforts to globally enable
> -Wimplicit-fallthrough for Clang.
>
> Link: https://github.com/KSPP/linux/issues/115
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Link: https://lore.kernel.org/lkml/CAJZ5v0hLYWKX__oZdcCY0D20pNqpw8SkiTPOCNOtpqe--QLp4Q@mail.gmail.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/acpi/sbshc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 53c2862c4c75..5c021c3b81d9 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -231,7 +231,6 @@ static int smbus_alarm(void *context)
>                 case ACPI_SBS_BATTERY:
>                         acpi_os_execute(OSL_NOTIFY_HANDLER,
>                                         acpi_smbus_callback, hc);
> -               default:;
>         }
>         mutex_unlock(&hc->lock);
>         return 0;
> --

Applied as 5.14 material, thanks!
