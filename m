Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB102EF565
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 17:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbhAHQCc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 11:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbhAHQCc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 11:02:32 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B3C061381;
        Fri,  8 Jan 2021 08:02:10 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m6so6501626pfm.6;
        Fri, 08 Jan 2021 08:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yS0AQ/iq89KHuEBttzOsrVBcJm6DSFlGJhHRYYlq9Vg=;
        b=vZXv3fwD7kPl/XbGIAAO3uTKrrphORulHDQgEvscSYFdJ9vBEVlAK83ndyS+c2QTSa
         fO1RMSVdSMepPSh/ylXacQHZHkGi8WuBGvzkOxly81Smjj8G9exLp9/qMAMUkQaJ7I1y
         Jvx/HllplJfdCEYBpyeINjBXG1oyRxQ8Ng97NcUmZKiOCQ0WHjiDCbfYoqbxTDoSVQDe
         IkW/UmNkzUqUqVDp1cFxbMcGqahU8MM43ZZcsUfzW3Dw+LNAyUXFz0QpyAypZkrpvvzL
         Blh9hNleVXMB9Z7xKYvVAm9SRm4CLNMp+pOtJc7C/pINVrvUBIPdsVho9zhLMxSdX1yN
         Yc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yS0AQ/iq89KHuEBttzOsrVBcJm6DSFlGJhHRYYlq9Vg=;
        b=PPW8+NMroo8dl5OL09PxXnF3fQop/PEsfeAm4Qhuzu5aeVJ1wVJFobOjTbOUZMTnIH
         KAE8qrGFXIh42aPVsvk9/78rLKjcqd+1UQZRagTlPGz6UwgHbNOv3B+H37qnzeGHWBmn
         yW5i1M6J2CgoCbE0SznZwqCLLsHAxZeizOQPMqTX7RI097sYcCvoLUzwkLXWfpZCK671
         igW3aWFyGZiLYzSkGBoOCu9ubUyeC41OZdgDvJAmOFiMUfPwGNTniQOOeqAPa7KeuOj5
         qKXgbKJYjMPZl8AMclnyenq3en03A95e7BOJAGEznFokD66xV5XCHk9fWtLcb/YMVvES
         E5Jw==
X-Gm-Message-State: AOAM531dP3yDu+BTD12/n1wVh8X974xRS8sYrqRNazDEPoKLYdFEALj2
        tgWIhsmsxL2DiOsbK1F0aDXmuuKNI1CqKEc/C919wLQVWbY=
X-Google-Smtp-Source: ABdhPJzSDvErGMVOwr8SEzKwOjPck/i7G6MoaXyJluKS4BDsjfS+yG0yY5PPGRgSqqMbBxwg/F+qglIJMdUnjUqw+08=
X-Received: by 2002:a63:4b16:: with SMTP id y22mr7622914pga.203.1610121729822;
 Fri, 08 Jan 2021 08:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20210108152447.116871-1-f.suligoi@asem.it>
In-Reply-To: <20210108152447.116871-1-f.suligoi@asem.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jan 2021 18:02:58 +0200
Message-ID: <CAHp75Vf54TTXr4HH6TxMo0QRTBa5V3=La1LCDxSizaYZjJM9Qg@mail.gmail.com>
Subject: Re: [PATCH v1] Documentation: ACPI: add new rule for gpio-line-names
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 8, 2021 at 5:28 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> The gpio-line-names lists must respect some rules.
>
> This patch adds a new rule in documentation, to avoid
> the use of duplicate names in the same gpiochip.

Thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  Documentation/firmware-guide/acpi/gpio-properties.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index b36aa3e743d8..4e264c16ddff 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -146,6 +146,7 @@ following rules (see also the examples):
>      other words, it is not mandatory to fill all the GPIO lines
>    - empty names are allowed (two quotation marks ``""`` correspond to an empty
>      name)
> +  - names inside one GPIO controller/expander must be unique
>
>  Example of a GPIO controller of 16 lines, with an incomplete list with two
>  empty names::
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
