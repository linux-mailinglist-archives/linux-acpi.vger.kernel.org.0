Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681493CD462
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jul 2021 14:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbhGSLal (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jul 2021 07:30:41 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36734 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhGSLak (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jul 2021 07:30:40 -0400
Received: by mail-ot1-f51.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so17954599otl.3;
        Mon, 19 Jul 2021 05:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2moxWKKaPa9ZFExfempOvPi7aHjsJs/En8lY3f7yAtE=;
        b=owUxVM+dO9F6z5rFjUJEV5vQKegcYHWmBHXgH+UyyzbXAddaGHZRbCgMLM6Lz2xYT/
         LpaLqTRh0xosQ2w/jc284zZVBA4iSLS3XCGM+elvkyN3FZZYazYX120LFURxcyITsnTJ
         bMlLWl28nKaTkKjDkZ+MHx+lgvAIIP2YtO732CoMlf7pUipb83X5DIeUQVdC1ijGlVdO
         WJ3D9Ls/sLdp8Fddy/L/0ffFOS9vekvWiAYGWxFoxHx5bERbY180yccLXfAobI7DdWXn
         yUtlUH1vmeSwRls0UTsMfZLU2mVOdIbWoRz+q1mka8wQyRoopT6gz6fV61nLmo1Jk4i9
         1okA==
X-Gm-Message-State: AOAM53102r4yy3fm2TcKdsJHx8X1vXzQjXXsEtJFbV+3pQ2ORbF/umph
        Z22ofFoq/Q6b//5HEqKJt+VulwCKh+pHFFQnklFqSKtuBkw=
X-Google-Smtp-Source: ABdhPJxNOKlU+YwP89jrbWPKr9XB0U4es4cykMcIG5GYp2Qcj9p0FLrxZy4Wd61E9LXcchZSNnjpKAAKpU0pflyoK3w=
X-Received: by 2002:a9d:2968:: with SMTP id d95mr18293090otb.321.1626696679462;
 Mon, 19 Jul 2021 05:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210717031806.29866-1-wangrui@loongson.cn>
In-Reply-To: <20210717031806.29866-1-wangrui@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Jul 2021 14:11:04 +0200
Message-ID: <CAJZ5v0hWiLWHk2_CQ0uytP28ab26Atm-MU5YvUWWwHWdKS5c-A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Kconfig: Fix table override from built-in initrd
To:     Rui Wang <wangrui@loongson.cn>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jul 17, 2021 at 5:18 AM Rui Wang <wangrui@loongson.cn> wrote:
>
> The commit 65e00e04e5aea ("initramfs: refactor the initramfs build rules")
> had dropped the CONFIG_INITRAMFS_COMPRESSION.
>
> This patch updates INITRAMFS_COMPRESSION="" to INITRAMFS_COMPRESSION_NONE.
>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Len Brown <lenb@kernel.org>
> CC: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> CC: linux-acpi@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Rui Wang <wangrui@loongson.cn>

I've already applied an alternative patch making the same change:

https://patchwork.kernel.org/project/linux-acpi/patch/ad9c50c54887bde41ae5de782248231c06a527c0.1626262835.git.rrichter@amd.com/

> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 9d872ea477a6..8f9940f40baa 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -370,7 +370,7 @@ config ACPI_TABLE_UPGRADE
>  config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
>         bool "Override ACPI tables from built-in initrd"
>         depends on ACPI_TABLE_UPGRADE
> -       depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
> +       depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION_NONE
>         help
>           This option provides functionality to override arbitrary ACPI tables
>           from built-in uncompressed initrd.
> --
> 2.32.0
>
