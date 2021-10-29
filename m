Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E78440229
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 20:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhJ2SmY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 14:42:24 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45811 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2SmX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Oct 2021 14:42:23 -0400
Received: by mail-ot1-f53.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so14764895otq.12;
        Fri, 29 Oct 2021 11:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbJJ3sirvGO1Q5qzFIR+Qcm5nvITBleUPONekunq9do=;
        b=FPP9oLtujVqmUWWVn8s4bQ+1chwHt7/d0CuFHFKZVC5ldkNpNcWrn4CYL4hUK5liJx
         KAo7IYHTdqQXnPjZUlRei26k2+PfDTokieFRl2OhHTNxAmKD+EP+JuXb1UiehJjOkqWg
         te8hK0Y31PAYGUSXexM4JhA3EgV8xM62gGqU9gC76V5bpUuxeLEe9NTksnuIoOu5Dr89
         /GyxAl8+k9wjJSBMK8mOXf690txd44+aymZgXMBTD82V7VzHdcLAtsr9laSmrYm+05Jh
         1k8KMQbVu7xUOcAKgG/ZzSd5Jjy9gIqlzULStbtQkHmqAuZ9UAzrGZrLiJ657epbOg6k
         wezg==
X-Gm-Message-State: AOAM532Nmr2c+jWUkD0DNzsdfR6s4OnxCGIh6fCwlVvv/6/9ieyO3Rop
        CQTdw/W8sGJx3cLTlEYm61UChq2Vfnc+BjdcpaU=
X-Google-Smtp-Source: ABdhPJzzT6cB8eCDJmpVcRiVJH/HJQE931S3wWY6YLrIMln0JVWc33duNyd4uacmLGMUV1B0MfAnmK1v5Cm4HHKIGks=
X-Received: by 2002:a05:6830:90b:: with SMTP id v11mr9843423ott.254.1635532794570;
 Fri, 29 Oct 2021 11:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211018202542.584115-1-tony.luck@intel.com> <20211026220050.697075-1-tony.luck@intel.com>
 <20211026220050.697075-8-tony.luck@intel.com>
In-Reply-To: <20211026220050.697075-8-tony.luck@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Oct 2021 20:39:43 +0200
Message-ID: <CAJZ5v0gAuqf6RWhgiKvZ5W30p3+cZxnROPP_CzDDNY8ufyFGYw@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] x86/sgx: Add check for SGX pages to ghes_do_memory_failure()
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 12:01 AM Tony Luck <tony.luck@intel.com> wrote:
>
> SGX EPC pages do not have a "struct page" associated with them so the
> pfn_valid() sanity check fails and results in a warning message to
> the console.
>
> Add an additional check to skip the warning if the address of the error
> is in an SGX EPC page.
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0c8330ed1ffd..0c5c9acc6254 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -449,7 +449,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>                 return false;
>
>         pfn = PHYS_PFN(physical_addr);
> -       if (!pfn_valid(pfn)) {
> +       if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) {
>                 pr_warn_ratelimited(FW_WARN GHES_PFX
>                 "Invalid address in generic error data: %#llx\n",
>                 physical_addr);
> --
> 2.31.1
>
