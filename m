Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DFD1D55D9
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 18:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEOQYL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 12:24:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37303 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgEOQYL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2020 12:24:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id r25so2720224oij.4;
        Fri, 15 May 2020 09:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACCtTcg1s186xI0wZJ8DSeKuwtaoE6YIF10m8QSgqOU=;
        b=Bz5rKf8mW8lvCMvciLl51asZRueVu9MPRaH67fg+YOcE0DpriaNrPjfglwOZJRvb4c
         cyw1foti/gJesWQdDnzEDN/x4SG1fAEu1YcOkK1c7cyJRzpLv7MVMjaCiLavtMf20wwh
         Ul8SEB7uWqp07mOhJkL87KJV1ArMdFGGrgApYahka52XjNl4kDBRaBO5VnPijtBg2bJS
         PKn/PnEf7ENXFKedPY26U3AKKYRGODpZfrDItwIZ2kKxPXJvc7oVrfoZQ3GV6tzy0B+U
         d5Vn509HIACHrzxrZ895OpyqY0wMkjIVRirsVCOGCxV/lD8vmjMwQGiXqulR8nBKqeB8
         vHpg==
X-Gm-Message-State: AOAM530uNYpeYutHs80OgDLyvxFxwiNhlvnwjrpTwhIdN98b7Ia70OEV
        5xmvcfwcMexAQ3EXilx/shQ5NlLr7NnnGCGEHa4=
X-Google-Smtp-Source: ABdhPJy4Shi2Xe7FSqHjeuRzM4zEpP9ZG1dGi78c/HxUu1cNDBakNavNO7EHk8idZTIVyb4szdp22GWBj9BaBsMO+jo=
X-Received: by 2002:aca:4fd5:: with SMTP id d204mr2797417oib.103.1589559848833;
 Fri, 15 May 2020 09:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200507190638.GA15700@embeddedor>
In-Reply-To: <20200507190638.GA15700@embeddedor>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 May 2020 18:23:57 +0200
Message-ID: <CAJZ5v0hCERp+5m33qhXOkq1LDEj87CbZkiz7t_oD7HmD9cA+Xw@mail.gmail.com>
Subject: Re: [PATCH] PNPBIOS: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 7, 2020 at 9:02 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/pnp/pnpbios/pnpbios.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
> index 37acb8378f39..2ce739ff9c1a 100644
> --- a/drivers/pnp/pnpbios/pnpbios.h
> +++ b/drivers/pnp/pnpbios/pnpbios.h
> @@ -107,7 +107,7 @@ struct pnp_bios_node {
>         __u32 eisa_id;
>         __u8 type_code[3];
>         __u16 flags;
> -       __u8 data[0];
> +       __u8 data[];
>  };
>  #pragma pack()

Applied as 5.8 material, thanks!
