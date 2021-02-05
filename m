Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577D93115FD
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Feb 2021 23:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhBEWr2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 17:47:28 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44896 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhBEMwo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2021 07:52:44 -0500
Received: by mail-ot1-f45.google.com with SMTP id e70so6722549ote.11;
        Fri, 05 Feb 2021 04:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGqkrEgNEbwyuEnroBfCsFjA2YPiRlVAv0Joa5oyIcA=;
        b=N86DwBbPk8GHTGiEfue+U44SxaRE5sD2xXxCvdNaiiuLzLIc62nGjLskJATtQaXG6a
         juZLpMBDmbTXO1G3C7gY20te4P74zf2PvUZNnjojOR8IQyzk5kKnORmweqg6B0ZETitk
         itUYK9bcJsjICMyNLKmYINkkMsHWlGfOSB36NFdnWCBPlIR7Sa7eYXRj+XkF8tU6SckL
         o8rCduT8H7PZtbiLkHdNN1+rhN4rZgLswR8yBzo3J06d3LP1RUjEwiHaK6ttCc0jyKjP
         5sCAQMuBXQJme0q+z9OqKEQlY4NR+pORwTl19wWxrm4TPlh5xCxBo3bCRc6A3im/ZmSB
         TcZA==
X-Gm-Message-State: AOAM5339EyTUAmjqyXSLSbgBppznB0/ZVneTDk71K9uNzLLqO6fUYNzE
        mYVqvP/g4zAT0A5FGw1kiTQTfgFrm+sU2B34ZK0=
X-Google-Smtp-Source: ABdhPJz6YvGqmzQlhvQuZW++IADvfpIP+xjTMAl9mGCJMC6jFOwb24kHOuiYrMXnmYGIqA+gbL4EHEia53JcGJgqVcM=
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr3252660otq.260.1612529523506;
 Fri, 05 Feb 2021 04:52:03 -0800 (PST)
MIME-Version: 1.0
References: <1612248702-49626-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1612248702-49626-1-git-send-email-yang.lee@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 13:51:49 +0100
Message-ID: <CAJZ5v0hOv6w3ZHq0JkW4tk4yp5w3ssYiGyg_-uvLm1NzPwKPvg@mail.gmail.com>
Subject: Re: [PATCH] apei: erst: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 7:52 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./drivers/acpi/apei/erst.c:691:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/acpi/apei/erst.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 2e0b0fc..b959721 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -688,7 +688,7 @@ static int __erst_read_from_storage(u64 record_id, u64 offset)
>                         break;
>                 if (erst_timedout(&timeout, SPIN_UNIT))
>                         return -EIO;
> -       };
> +       }
>         rc = apei_exec_run(&ctx, ACPI_ERST_GET_COMMAND_STATUS);
>         if (rc)
>                 return rc;
> --

Applied as 5.12 material, thanks!
