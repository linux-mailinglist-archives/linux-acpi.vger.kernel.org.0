Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64153A2D02
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhFJNbI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 09:31:08 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:34492 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFJNbI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 09:31:08 -0400
Received: by mail-oo1-f48.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so6775109ool.1;
        Thu, 10 Jun 2021 06:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usI/+u4XtISFZVHRz7Nuoee8ZW5mOj7emFTwtljSgXE=;
        b=MUoOo+XzHjn7QZ80fSGELN9sAxIl86paFnEYtXWWlpUHv8QYUn9ousZ5oeK0VZHJXL
         picEvHYR4QsJ1v1Yprr1nOtW5s3ngLxbzG8mihYkyDdZzdfJzziblXFt/uFRWZeH+eNH
         Qu1cLUXEVu/iNxSt86Mzkb0yGiMcUt5mbm8x+hcziAwT0sLWF5UrSCHWkp7SWj+JIHvh
         kzzzABOF1XOty8gwkUA5VrIm9yDG6qKt2/qMszg3AC7WDmhM0CJwTRIXwS5Daw9ZBUlV
         I6n9gGJ+e8gjZrw32R6i9vYW4/Y5EtPzHFtOAy9iuIxmV1X8B8p1fvVGZjHnIxbmb11r
         7xAA==
X-Gm-Message-State: AOAM533AGR9U+Q+lURTxZpqxaH+qXGTI8qdSfNKp+y7lY+4XQfEqogsF
        Tx+tLzpgs8c7g4dzfgBqGKaQqxOu0KoVIzc3yq8=
X-Google-Smtp-Source: ABdhPJwBqjvhtrkp9WPzbG4Hw6L1O3KdsOrTkXommgDsWYtjLFOkEkfFrWR46znrKMXBXhvLcon3WaON28lz8M1ia7s=
X-Received: by 2002:a4a:a9c8:: with SMTP id h8mr2410450oon.1.1623331736507;
 Thu, 10 Jun 2021 06:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210609173312.298414-1-colin.king@canonical.com>
In-Reply-To: <20210609173312.298414-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jun 2021 15:28:45 +0200
Message-ID: <CAJZ5v0h962RaReLhKSkOMxb6BT44GAwrFq9qLqChfTH3v__toQ@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: scan: ensure ret is initialized to avoid
 garbage being returned
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 9, 2021 at 7:33 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> In the unlikely event that there are no callback calls made then ret
> will be returned as an uninitialized value. Clean up static analysis
> warnings by ensuring ret is initialized.
>
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: a9e10e587304 ("ACPI: scan: Extend acpi_walk_dep_device_list()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index c3067e8bfc47..0945d952f0fc 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2151,7 +2151,7 @@ int acpi_walk_dep_device_list(acpi_handle handle,
>                               void *data)
>  {
>         struct acpi_dep_data *dep, *tmp;
> -       int ret;
> +       int ret = 0;
>
>         mutex_lock(&acpi_dep_list_lock);
>         list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
> --

Applied with some edits in the subject and changelog.

Basically, if you make changes like this, please specify which piece
of code you change in the subject/changelog.

Thanks!
