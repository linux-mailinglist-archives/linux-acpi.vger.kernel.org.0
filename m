Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5751E6FB50
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 10:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGVIaJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jul 2019 04:30:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45652 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfGVIaJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jul 2019 04:30:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id m206so28966986oib.12;
        Mon, 22 Jul 2019 01:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4N0HhwGuXC3mqxfYtAKATut5jBkdVM9gFj5yRqL8TI=;
        b=PpOKQKjnDe7l8YzAv73SytoJ1KOpZRtzA5V7Hzu62N6+vzIzyo6aryjpPHgG+sna4v
         5fleGwCHkFHogZkF/FbD6qrBUqxJnWq/Zhs+Psso3Lmqct0jOPmaix7BEzENlHH57Fn5
         Sic1dyiuKI3zJR3DBJmvbaYoBSpgvWQJfR+THZ1abPGX70NPMKzjzSVmeNa0/tReZohW
         fsGP2lAg+tq/1Jnhoy+X+1+J5XoANDshFcW6WOu0/jG0bjA2lTnvX8kcBTu4/DxO8yju
         a6QoxqzccdhOoIds6I2ApTKnKS8DIUo4KnQwAGfQudLz/z+mZeH3HNYEpOmv7/DV+W8G
         ErmQ==
X-Gm-Message-State: APjAAAUrhBc+AfwDtHcekcH/z/bzrmCR+2KLW7Ojl2fNbvoMVDn4hUXh
        +yGSSuESe/q+aOOSmf9x65XIUPnNOx/NMD02wfM=
X-Google-Smtp-Source: APXvYqxI9yDO+N+DKAFeTYr3C1w2EDGzRVGNRik+xIOJXy8EkGVsjOe5Z6VKJyzTaTYdLzTJN3gfk8jLWQ47Wt64oQk=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr30210012oig.115.1563784207998;
 Mon, 22 Jul 2019 01:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190722023530.67676-1-skunberg.kelsey@gmail.com> <20190722023530.67676-3-skunberg.kelsey@gmail.com>
In-Reply-To: <20190722023530.67676-3-skunberg.kelsey@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Jul 2019 10:29:55 +0200
Message-ID: <CAJZ5v0ix6fe2fj9_mbO5ZdQzkThe8PnkRbJWAuQHjB58x66ixg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: Remove acpi_has_method() call from scan.c
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 22, 2019 at 4:36 AM Kelsey Skunberg
<skunberg.kelsey@gmail.com> wrote:
>
> acpi_evaluate_reference() will return an error if the DEP method
> does not exist. Checking if the DEP method exists before the
> acpi_evaluate_reference() call is not needed. Remove acpi_has_method()
> call to avoid additional work.
>
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  drivers/acpi/scan.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0e28270b0fd8..4f2b0b481cee 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1803,9 +1803,6 @@ static void acpi_device_dep_initialize(struct acpi_device *adev)
>
>         adev->dep_unmet = 0;
>
> -       if (!acpi_has_method(adev->handle, "_DEP"))
> -               return;
> -

As you can see, this just returns.

>         status = acpi_evaluate_reference(adev->handle, "_DEP", NULL,
>                                         &dep_devices);
>         if (ACPI_FAILURE(status)) {

Where this does something more on fallure.

Therefore the code after the change is not equivalent to the code
before it, so the changes is questionable.
