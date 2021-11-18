Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571E0455E77
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 15:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhKROtW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 09:49:22 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33452 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKROtV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 09:49:21 -0500
Received: by mail-ot1-f46.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso11401183ote.0;
        Thu, 18 Nov 2021 06:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fPLCC/lGDe6nSg2L0GXzk92DuK5SfiaVXrmm2j2MVs=;
        b=Zo7ob7Z44m0Iei370J6/EPmfbWdLBFKxGudkbfkhF/AMq3Q3MePX+eZ30j2KdqMwDc
         9a+uiP9AnyU087MZzlx1ubAZYPAVCshnTJCaM0m0Tlfml2RgkTvCeZA3qxlO/kAUDXlJ
         4z3SjvoFqhPMl6JmvqOzvJCHWCEhokVZWIzqLhPHdH9BmHez1k9g98fymZWrbAjGRSco
         CFo6Fg/2JBmlKgKQ+tUyQkaFKPdyYYXy7I6l6DWHz1xIufJr6eJZmFhHB1R4ztUiW2ik
         OCHq3tZNVGO59vSog8Q7DXHKIsCqXuRYQHGo2/9OieRZpmBk471tKYzV3OhqZx0aYAzV
         XxDQ==
X-Gm-Message-State: AOAM531OsPjdnuVsj6gJ9nj6E1DTD05NShVVCe7wRouMnCNotAh6C4zy
        dYoFz6Us/Dh2tRGe2o3AjhtVwz5/PKfWLH2+NBaqrZrPCMI=
X-Google-Smtp-Source: ABdhPJy8QKzZL1z6g5aFUr30ddDVC64W+lwBHux0Ym4byl/nYpAo2gjoXbsVYpcnAXhv/onfFQfWeM7AeWVkSCP5Bsw=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr21419631otg.198.1637246780981;
 Thu, 18 Nov 2021 06:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109134728.1710-1-guozhengkui@vivo.com>
In-Reply-To: <20211109134728.1710-1-guozhengkui@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 15:46:10 +0100
Message-ID: <CAJZ5v0ixtvzNiAwwLtXXgG-8FdvtWYy7RUh0pFz65sjcmyuNdQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix swap.cocci warning
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 9, 2021 at 2:47 PM Guo Zhengkui <guozhengkui@vivo.com> wrote:
>
> Fix following swap.cocci warning:
> ./drivers/acpi/acpica/nsrepair2.c:896:33-34: WARNING
> opportunity for swap()
>
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

This change needs to be submitted to the upstream ACPICA project via
https://github.com/acpica/acpica/

Thanks!

> ---
>  drivers/acpi/acpica/nsrepair2.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
> index 14b71b41e845..02a904ca4caf 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -8,6 +8,7 @@
>   *
>   *****************************************************************************/
>
> +#include <linux/minmax.h>
>  #include <acpi/acpi.h>
>  #include "accommon.h"
>  #include "acnamesp.h"
> @@ -875,7 +876,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
>  {
>         union acpi_operand_object *obj_desc1;
>         union acpi_operand_object *obj_desc2;
> -       union acpi_operand_object *temp_obj;
>         u32 i;
>         u32 j;
>
> @@ -892,9 +892,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
>                             || ((sort_direction == ACPI_SORT_DESCENDING)
>                                 && (obj_desc1->integer.value <
>                                     obj_desc2->integer.value))) {
> -                               temp_obj = elements[j - 1];
> -                               elements[j - 1] = elements[j];
> -                               elements[j] = temp_obj;
> +                               swap(elements[j - 1], elements[j]);
>                         }
>                 }
>         }
> --
> 2.20.1
>
