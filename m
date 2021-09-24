Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DC2417872
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347297AbhIXQXj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 12:23:39 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41584 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347172AbhIXQXh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 12:23:37 -0400
Received: by mail-ot1-f49.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso13805912ota.8;
        Fri, 24 Sep 2021 09:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcKXSgBtoVcxtHCKOtPHnRdujaEI6ZLYYWV1g18BTr8=;
        b=Lr/U/Ma205yjlXaM0Q7YccOIBZrpkkX4OEJXiguhRHjeGd/m9nvFyEMhHYpI/xCy15
         ZNwvNo6fGInC/kY04QuvnlXLL+PmxrsaLIb7/5CY5m/C5B8izVMSBf8lcwpuFNbqKrIT
         xlzF12jTGJZuga0SSzuTxMzgNl9hE+bCoBe1wivej9dM8ke+rckqTUQI+0we7Mj3/6BY
         dN9PdnQ4JLKUeZ5odPQQvT3XkbxOfkoTzTXe7HUhGo3qGRprIy0aWPnjH3eymsHjNGs2
         mcUohMxIXpksmWpvHtl/vLlb9xRxTliur0obBr6S/7zIA6OpCcARBxtl9+aVjxOENGKv
         dcBg==
X-Gm-Message-State: AOAM531UYPgj+kcbtaM4XS08JqYvh14Ch1nMAE42InMCp5B7kUQFWAcW
        G1I5XYa7uijo4gJG+9JpybkcRA55cqV8xbAJJ0c=
X-Google-Smtp-Source: ABdhPJxjjGGJ3jArOANw1ZAOou2DF9Wa1ntjMZBW0pdESRYxjxL0t/0yjAeEoYELHdGqUVIAPcTvF4Gn/qtQ1rGAcEM=
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr4806932ots.319.1632500524066;
 Fri, 24 Sep 2021 09:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210920185028.18738-1-colin.king@canonical.com>
In-Reply-To: <20210920185028.18738-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 18:21:53 +0200
Message-ID: <CAJZ5v0jH9PXm-abLj7MzC--OH+2kgwR8TBF0EcV8=Xh87215Xw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: Fix spelling mistake "Millenium" -> "Millennium"
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 20, 2021 at 8:50 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the documentation with the Windows
> Millennium edition. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  Documentation/firmware-guide/acpi/osi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/firmware-guide/acpi/osi.rst b/Documentation/firmware-guide/acpi/osi.rst
> index 29e9ef79ebc0..05869c0045d7 100644
> --- a/Documentation/firmware-guide/acpi/osi.rst
> +++ b/Documentation/firmware-guide/acpi/osi.rst
> @@ -74,7 +74,7 @@ The ACPI BIOS flow would include an evaluation of _OS, and the AML
>  interpreter in the kernel would return to it a string identifying the OS:
>
>  Windows 98, SE: "Microsoft Windows"
> -Windows ME: "Microsoft WindowsME:Millenium Edition"
> +Windows ME: "Microsoft WindowsME:Millennium Edition"
>  Windows NT: "Microsoft Windows NT"
>
>  The idea was on a platform tasked with running multiple OS's,
> --

Applied as 5.16 material, thanks!
