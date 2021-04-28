Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0967336DE05
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 19:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhD1RRd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 13:17:33 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46065 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhD1RRd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 13:17:33 -0400
Received: by mail-ot1-f53.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so53914662otf.12
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 10:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyRyWCJoR7jvAgrHjyaW328lF37QzDafBmUsSRwvGhM=;
        b=tr86fRH6wcnJhu5QEHMsYu+4psECDbo+PXJ7RXWqWS9UqzpTA5c447SMB+LiSscVHU
         jgRDVl6MPVgjUiApzvNH0YzwmM6AD6c9xGmpebjoHE3MDLZaSvxY+fPtvlbKAP8dK40w
         VICp5fDmCRoy0IAf42DeJqJP1LPvPhyfQ7e1DyIbMrkk3e/ZkWNtVgXIMdQOFguoD7wd
         kC6PuiiCm6CzppAEwzna8TE2j8oHDuqf4QlU7+vmlCcEdZ3GZ+b3nU7+fC/7teeuzSGY
         ShBakLTMTxC1wg5ptdM4afwIgQARZS8Rw74ZI0QbMssF02evZUfVmNJRHi5mrNini1Cw
         9TbQ==
X-Gm-Message-State: AOAM533TSJRZrC3hWbVIBopSXFNg0mfoTKIMZ6utw5Z9K5gGzXDviYRl
        zYP2zmlr+ANLJYYjxlpunQZ2/7ncSJpuxoASFbdg8UQN
X-Google-Smtp-Source: ABdhPJyb1IISThdwBS9+y06hZE7ijB1FH8/ACX62zlm+Ih3PhiPVwnU6o45i84bMUW5NfITsdpWygq5CR8gLfbnrtpU=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr24650131otb.260.1619630208410;
 Wed, 28 Apr 2021 10:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210423152818.97077-1-mlangsdo@redhat.com>
In-Reply-To: <20210423152818.97077-1-mlangsdo@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Apr 2021 19:16:37 +0200
Message-ID: <CAJZ5v0iROtMxULP+tnYnqA911uRKJ7wdspvJvAJurW13keZTWA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: custom_method: fix potential use-after-free issue
To:     Mark Langsdorf <mlangsdo@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 5:28 PM Mark Langsdorf <mlangsdo@redhat.com> wrote:
>
> In cm_write(), buf is always freed when reaching the end of the
> function.  If the requested count is less than table.length, the
> allocated buffer will be freed but subsequent calls to cm_write() will
> still try to access it.
>
> Remove the unconditional kfree(buf) at the end of the function and
> set the buf to NULL in the -EINVAL error path to match the rest of
> function.
>
> Fixes: 03d1571d9513 ("ACPI: custom_method: fix memory leaks")
> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
> ---
>  drivers/acpi/custom_method.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index 443fdf62dd22..8844f895f9be 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -55,6 +55,7 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
>             (*ppos + count < count) ||
>             (count > uncopied_bytes)) {
>                 kfree(buf);
> +               buf = NULL;
>                 return -EINVAL;
>         }
>
> @@ -76,7 +77,6 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
>                 add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
>         }
>
> -       kfree(buf);
>         return count;
>  }
>
> --

Applied as 5.13-rc material, thanks!
