Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99817145F21
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2020 00:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVX2e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Jan 2020 18:28:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34274 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVX2e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jan 2020 18:28:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so1069203otf.1;
        Wed, 22 Jan 2020 15:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YfEIxuF6PBjCYKAOaWqNOw3eBB9MiPAy/z1gh+EZB8=;
        b=XrATJb9zWSIBeAdOaNZoEZO9vgeUBiyE0EtQGR+XKD9fs3ZQzDawuaNPFipIzn8H43
         MZrIY4THLXcxNE8n18YJsjyRQIgLev8ghFyMX0WVUhCulxxCjCcyO77VKXCQCpeDerLm
         7LAmv186AoAyMzZ/Fe4qoRBAO5gASr6CnMenL6Szb0L2hOAY6UIS9B9wOexeCpzq81EV
         SoPvqEtHNklBBv4jl4XVspRNtXYQoJUJ41Mrh6bxgyzQoVojGkEI1ABQ5Du5lk8lINi1
         qPjsmvV0Na1ll6bRJWSibXIb1DWnZe24jXpPpuZG7FF/wikr6u90cLx0Kiurwt5YHjNG
         C3JA==
X-Gm-Message-State: APjAAAWgtZ5ZuYeFQMWoQmMSc9rmbJUeomreKTzrqA3f1jTTr6znbfvH
        iAMEnsYukeR5O/x9rNtjTsugkdtGfV368vxIeoIY/w==
X-Google-Smtp-Source: APXvYqzuGSTRn74Jzegk9rwZkBTRqUh+H/zx6eedV+Do2DDj7eVBFbB9obAJse6pC3NImlePnnQY1EJsMIdk0PY17fA=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr8916113otl.118.1579735713802;
 Wed, 22 Jan 2020 15:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20200120012331.34776-1-yukuai3@huawei.com>
In-Reply-To: <20200120012331.34776-1-yukuai3@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 00:28:22 +0100
Message-ID: <CAJZ5v0g4GYmnkYKBNmt+HbuqBGxWwxG-1SW8s-shD=eU4dDF+w@mail.gmail.com>
Subject: Re: [PATCH] PNP: isapnp: remove defined but not used function 'isapnp_checksum'
To:     yu kuai <yukuai3@huawei.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yi.zhang@huawei.com, zhengbin13@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 20, 2020 at 2:24 AM yu kuai <yukuai3@huawei.com> wrote:
>
> Fix gcc '-Wunused-function' warnning:
>
> drivers/pnp/isapnp/core.c:752:29: warning: 'isapnp_checksum' defined but
> not used [-Wunused-function]
> 752 | static unsigned char __init isapnp_checksum(unsigned char *data)
>
> Commit 04c589f35bc5 ("PNP: isapnp: remove set but not used variable
> 'checksum'") removes the last caller of the function. It is never used
> and so can be removed.
>
> Fixes: 04c589f35bc5 ("PNP: isapnp: remove set but not used variable 'checksum'")
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  drivers/pnp/isapnp/core.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
>
> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> index 179b737280e1..6c457006e84b 100644
> --- a/drivers/pnp/isapnp/core.c
> +++ b/drivers/pnp/isapnp/core.c
> @@ -746,28 +746,6 @@ static void __init isapnp_parse_resource_map(struct pnp_card *card)
>         }
>  }
>
> -/*
> - *  Compute ISA PnP checksum for first eight bytes.
> - */
> -static unsigned char __init isapnp_checksum(unsigned char *data)
> -{
> -       int i, j;
> -       unsigned char checksum = 0x6a, bit, b;
> -
> -       for (i = 0; i < 8; i++) {
> -               b = data[i];
> -               for (j = 0; j < 8; j++) {
> -                       bit = 0;
> -                       if (b & (1 << j))
> -                               bit = 1;
> -                       checksum =
> -                           ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7)
> -                           | (checksum >> 1);
> -               }
> -       }
> -       return checksum;
> -}
> -
>  /*
>   *  Build device list for all present ISA PnP devices.
>   */
> --

Applied, thanks!
