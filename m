Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3774127EDCB
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgI3Ptr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 30 Sep 2020 11:49:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37953 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Ptr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Sep 2020 11:49:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id y5so2283503otg.5;
        Wed, 30 Sep 2020 08:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mTrSgX4Tixqu3kTctGZ5BfKCOM+BJ2wQmL4YVycvE/I=;
        b=eaLDnJOWUIodjpL+nsZUE1H6hR732WP6J6mehaPNbMKBMgGGzkzK2bsc2mXKdEs46e
         Zbb5wo4ncf78xGLrsM08kFx+DsRiHuXEqIjdoeFYUCcuvPSNXCNIGIWfckSQDwSrpAwo
         wb8UNTaQtPo5eadTwhE/erkMBKOOXkRUmzFIVVG0iwkqO6KrdRKKA60gjd7SXVTPEvOp
         FYQ2abPPCUyxC5GX8rGIzk9WEf7EKMT2fk/LYigG37JKTqARY5R/k7hKWMr+vxr6EiST
         I3tbSweEsU1VVShFbgM1uGPF0mblfna0Kzemcy/iLXTnTtxL/QYnW/wbKqQG/17N+kBF
         cWIw==
X-Gm-Message-State: AOAM532HgvxswYdcwvtb5MMTucgwKX+MP1cWdUYKk4YLWT2Li7ZUSTdd
        UrkdrZW/Y/EROhadPx8k9thzxWeRbJ9Erihb7Vo=
X-Google-Smtp-Source: ABdhPJz3hWxJC7Wv+mdN7W+4UBYuXRGDar9sH2m/ddSlwtkNcPtwBYe6OJbDp6W+rpGzPUTBMAx+pa5fdCsf+KDNuSQ=
X-Received: by 2002:a9d:718a:: with SMTP id o10mr1956739otj.262.1601480984876;
 Wed, 30 Sep 2020 08:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200928194554.3423466-1-natechancellor@gmail.com> <a39af625-6e2e-3cb2-ece5-ea2b2dbb7c21@huawei.com>
In-Reply-To: <a39af625-6e2e-3cb2-ece5-ea2b2dbb7c21@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Sep 2020 17:49:33 +0200
Message-ID: <CAJZ5v0hno=F9yuJHRQNix7eiLzP=WtY1rB3xxmmBzLYxW62-tg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / NUMA: Add stub function for pxm_to_node
To:     Hanjun Guo <guohanjun@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 30, 2020 at 11:07 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2020/9/29 3:45, Nathan Chancellor wrote:
> > After commit 01feba590cd6 ("ACPI: Do not create new NUMA domains from
> > ACPI static tables that are not SRAT"):
> >
> > $ scripts/config --file arch/x86/configs/x86_64_defconfig -d NUMA -e ACPI_NFIT
> >
> > $ make -skj"$(nproc)" distclean defconfig drivers/acpi/nfit/
> > drivers/acpi/nfit/core.c: In function ‘acpi_nfit_register_region’:
> > drivers/acpi/nfit/core.c:3010:27: error: implicit declaration of
> > function ‘pxm_to_node’; did you mean ‘xa_to_node’?
> > [-Werror=implicit-function-declaration]
> >   3010 |   ndr_desc->target_node = pxm_to_node(spa->proximity_domain);
> >        |                           ^~~~~~~~~~~
> >        |                           xa_to_node
> > cc1: some warnings being treated as errors
> > ...
> >
> > Add a stub function like acpi_map_pxm_to_node had so that the build
> > continues to work.
> >
> > Fixes: 01feba590cd6 ("ACPI: Do not create new NUMA domains from ACPI static tables that are not SRAT")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > I am not sure if this is the right place or value for this. It looks
> > like there is going to be another stub function added here, which is
> > going through -mm:
> >
> > https://lkml.kernel.org/r/159643094925.4062302.14979872973043772305.stgit@dwillia2-desk3.amr.corp.intel.com
> >
> >   include/acpi/acpi_numa.h | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> > index fdebcfc6c8df..09eb3bc20ff5 100644
> > --- a/include/acpi/acpi_numa.h
> > +++ b/include/acpi/acpi_numa.h
> > @@ -22,5 +22,10 @@ extern int acpi_numa __initdata;
> >   extern void bad_srat(void);
> >   extern int srat_disabled(void);
> >
> > +#else                                /* CONFIG_ACPI_NUMA */
> > +static inline int pxm_to_node(int pxm)
> > +{
> > +     return 0;
> > +}
> >   #endif                              /* CONFIG_ACPI_NUMA */
> >   #endif                              /* __ACP_NUMA_H */
>
> Looks good to me,
>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Patch applied, thanks!
