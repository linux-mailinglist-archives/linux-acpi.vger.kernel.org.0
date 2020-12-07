Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020852D1150
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 14:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgLGNEm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 08:04:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34928 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgLGNEm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 08:04:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id s2so5805283oij.2;
        Mon, 07 Dec 2020 05:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ut/OIWcow1J1PvHgj0c7ammj9jk0luua/Mc152cxEy4=;
        b=EfZN0d/Z6zQ44rfFsUdAR7X8lHd6vfsgkpXfgT6HPyqTSOpXdtciZn9jk1wsL2FKfc
         KHQOwtdzkxr7cul7lvFHwikMWizZmRvgUjLHO0x2F4hIlw1g1ooOBVbImVqiCN6qkJwZ
         s4xlq0NtdG7zHIAc92Jyj1Ack/cL7Ha/MeTU6LZXb1YQhuT3GEswKm9ROZXo6MkU8vMf
         Dp9BRdMUE/G87AToUy8TWC+emN69yOKt3qsrdrfOYMj8hNpKIYPmCD4+g9RhNbeGyDD5
         L8g/g5R8bZt1VFRkxC0Vhp0aojlTaop62FnqM52MGM1m+k7LuRLnFySAE5eGTBJrmePs
         72tw==
X-Gm-Message-State: AOAM533lmEKYkrK+tyluNOMRVvS0jmAOfatwJbq4ECQ2hqd1SnYppmKP
        ZQLMT60TkpcyxIjQzSj+Zy6pxmnwp74bmycEVZQ=
X-Google-Smtp-Source: ABdhPJwV+W1n5BWDJ0nTI3mLI5J0M90gUs6wmLPAH66XyN1CQ6Eq5MlP79FHkY8HpNBQ29hMlMw42dagE5GAch7qZ0A=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr11747869oib.69.1607346235827;
 Mon, 07 Dec 2020 05:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20201205170403.31827-1-djrscally@gmail.com>
In-Reply-To: <20201205170403.31827-1-djrscally@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Dec 2020 14:03:39 +0100
Message-ID: <CAJZ5v0hWD0BgHQPZXqpzpVq2hfLnt3vmK2tOeNFyKdUNMYdSQw@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "ACPI / resources: Use AE_CTRL_TERMINATE to
 terminate resources walks"
To:     Daniel Scally <djrscally@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 5, 2020 at 7:42 PM Daniel Scally <djrscally@gmail.com> wrote:
>
> This reverts commit 8a66790b7850a6669129af078768a1d42076a0ef.
>
> Switching this function to AE_CTRL_TERMINATE broke the documented
> behaviour of acpi_dev_get_resources() - AE_CTRL_TERMINATE does not, in
> fact, terminate the resource walk because acpi_walk_resource_buffer()
> ignores it (specifically converting it to AE_OK), referring to that
> value as "an OK termination by the user function". This means that
> acpi_dev_get_resources() does not abort processing when the preproc
> function returns a negative value.
>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
>  drivers/acpi/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ad04824ca3ba..f2f5f1dc7c61 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -541,7 +541,7 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
>                 ret = c->preproc(ares, c->preproc_data);
>                 if (ret < 0) {
>                         c->error = ret;
> -                       return AE_CTRL_TERMINATE;
> +                       return AE_ABORT_METHOD;
>                 } else if (ret > 0) {
>                         return AE_OK;
>                 }
> --

Applied as 5.11 material, thanks!
