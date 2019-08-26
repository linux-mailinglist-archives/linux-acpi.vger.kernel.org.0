Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1789D9BB
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2019 01:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfHZXCj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 19:02:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36368 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZXCj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Aug 2019 19:02:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id n1so13475515oic.3;
        Mon, 26 Aug 2019 16:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bM3r1pTqEi+HxfYIg7pyghSTfjbPEtK6ZwhKa2foIGo=;
        b=kC3UC7M+9P+1dooFAh5AJKnb++IdshXs9nlQCkpNzp/4Ic074hfXCNnQk+apCtoKpC
         3m8AdfCgvfjxW6x+/R58nDO2SdtV4mneBuGD9KY60izX9/2dxGbKTzK+4te1QxIUng+X
         lDQFBXUECb4kPFA3LcwQHjiiCttFvX6M6TxwbyHEDzGkg7fsP6UHzgCJMw9pxbmgUaWd
         wYLsenZWjvNhRoaEecRtnYLqjgwfFSbM/MuqsE0AOP+Jrts+louC2lblW3svVMktcEB9
         AOgjaiu78PxfHDly7nfzCK4O45MdqoGsOE0xqPZXotHUJUU0L2LjZUmEjvUGuaYO3dFQ
         azOg==
X-Gm-Message-State: APjAAAXySUOHzZie1Z4xtyQpD6PTdDVVY+Oxjab215oAZcFzEGrZSstQ
        xHSoBV2X+2KTIDnMzcpEBfck0a5WOHjkn+MHzX4=
X-Google-Smtp-Source: APXvYqyEE9Bphe+b0EtIWWcArlEfiuq0bTlSoTYTdzCplUwF1R1TVDG3F4jaGUatIjl6BzqllJ8xB+wssKi1HFAQ1ik=
X-Received: by 2002:aca:4dd8:: with SMTP id a207mr13516360oib.115.1566860557966;
 Mon, 26 Aug 2019 16:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190826223047.13146-1-ahs3@redhat.com>
In-Reply-To: <20190826223047.13146-1-ahs3@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Aug 2019 01:02:26 +0200
Message-ID: <CAJZ5v0hXJNa3Z14MQgvNcVF8YxH+M46mMyC5U6vZqrpBZUjOgw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / CPPC: do not require the _PSD method when using CPPC
To:     Al Stone <ahs3@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 27, 2019 at 12:30 AM Al Stone <ahs3@redhat.com> wrote:
>
> According to the ACPI 6.3 specification, the _PSD method is optional
> when using CPPC.  The underlying assumption is that each CPU can change
> frequency independently from all other CPUs; _PSD is provided to tell
> the OS that some processors can NOT do that.
>
> However, the acpi_get_psd() function returns ENODEV if there is no _PSD
> method present, or an ACPI error status if an error occurs when evaluating
> _PSD, if present.  This makes _PSD mandatory when using CPPC, in violation
> of the specification, and only on Linux.
>
> This has forced some firmware writers to provide a dummy _PSD, even though
> it is irrelevant, but only because Linux requires it; other OSPMs follow
> the spec.  We really do not want to have OS specific ACPI tables, though.
>
> So, correct acpi_get_psd() so that it does not return an error if there
> is no _PSD method present, but does return a failure when the method can
> not be executed properly.  This allows _PSD to be optional as it should
> be.
>
> v2:
>    -- verified simple check for AE_NOT_FOUND was sufficient
>    -- simplified return status check per Rafael's suggestion
>
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/cppc_acpi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 15f103d7532b..7a946f1944ab 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -365,10 +365,12 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
>         union acpi_object  *psd = NULL;
>         struct acpi_psd_package *pdomain;
>
> -       status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
> -                       ACPI_TYPE_PACKAGE);
> -       if (ACPI_FAILURE(status))
> -               return -ENODEV;
> +       if (acpi_has_method(handle, "_PSD")) {

This doesn't look necessary any more.

> +               status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
> +                                                   &buffer, ACPI_TYPE_PACKAGE);
> +               if (status == AE_NOT_FOUND)     /* _PSD is optional */
> +                       return 0;

And what about the other possible errors?

> +       }
>
>         psd = buffer.pointer;
>         if (!psd || psd->package.count != 1) {
> --
> 2.21.0
>
