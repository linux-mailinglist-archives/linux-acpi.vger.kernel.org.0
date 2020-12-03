Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF182CDD3E
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 19:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgLCSV0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 13:21:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34947 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgLCSV0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 13:21:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id t9so3200422oic.2;
        Thu, 03 Dec 2020 10:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKbocZqpUKzqfWPXVVR9WnhiikwQgnOhMm0mHx3Z858=;
        b=gwA4px5qXHcyYHvTgtQPESviufigpbtlAHEfO5kN06aY9pd0zUnfSnH/8GXCSHL/YV
         HKGjnUM/ZPcu+G4giw3Y7dtRtDzv8HYoCIa6J7PLk4i6lxCGx1W5fHkG9IVqft/l7pyx
         doMvHZfM4UgA+pKrpnJ3JPRli1G7VJHUOJUk5pteSHQpq5RhwTh3FMzGvuwnIB5YSb/q
         XgM+ndUkNwSMBi59rmY/rsRWT/Qg1P8zC/DyJCcPAa6OO0lmuyIBjxCJtcfj4l7DyPYo
         HXQFiDNVJu44/Y84FYNDP4+6gNup4TyeFsSI1vgzdljMibTgQVxBXHhh4uTQah4uCWiM
         jXOw==
X-Gm-Message-State: AOAM5324tlLVL4P055jH4gVRI6wNkN5id2ZdMQBR4bWsdH/pXBqwGiKB
        h1tDsU++U1KclD77HV4jS73H2Q7OKyf2MTlXsw2Y0Jd9
X-Google-Smtp-Source: ABdhPJzgfipBP0HdWDRTIUsPEJsbcdGH16Ex+4mGd3D0bkryAFppfM8bmtU5Cn008X2SzWFoH3mxktpqAc8880S7OQA=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr167767oib.69.1607019645213;
 Thu, 03 Dec 2020 10:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20201203174453.12084-1-info@metux.net>
In-Reply-To: <20201203174453.12084-1-info@metux.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Dec 2020 19:20:31 +0100
Message-ID: <CAJZ5v0j1UEHK65AR7xqZKzFYbn=MRhB9c0vL5Sdh0APSZZRC8A@mail.gmail.com>
Subject: Re: [PATCH] drivers: acpi: add opt-out of Apple-specific property parsing
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 3, 2020 at 6:47 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Most x86 machines aren't Apple machines, especially VMs.
> Therefore allow opt-out, making the kernel a few KBs smaller,
> eg. for embedded or high-density VMs.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/acpi/Kconfig    | 9 +++++++++
>  drivers/acpi/Makefile   | 2 +-
>  drivers/acpi/internal.h | 2 +-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index edf1558c1105..cc47de4f2b18 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -79,6 +79,15 @@ config ACPI_DEBUGGER_USER
>
>  endif
>
> +config ACPI_APPLE
> +       bool "Apple ACPI properties support"
> +       default y if X86
> +       help
> +         Extraction of Apple-specific ACPI properties.
> +
> +         Say N if you're sure the kernel won't be used on an Apple machine
> +         and wanna save a few kb of memory. (embedded or high-density VMs)

Do you mean bits of bytes here?

If the latter, please spell this as KB.

Thanks!
