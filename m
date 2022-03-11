Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312054D64C4
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Mar 2022 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiCKPin (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Mar 2022 10:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244558AbiCKPim (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Mar 2022 10:38:42 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFEDE9D
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 07:37:38 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2dc348dab52so97382287b3.6
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 07:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R13CzUlFxudiMHktPal88PrIFgreX5W8xU7TSwXI2zY=;
        b=NO3e9AOv5aNooh8Ng92Y2PUtql8RGZJrUlMuyxn/H6ZVXv62hRC0u27YzGQcgyL0Wr
         4TWGfIOLKBX6YM10xouqq2BAVg7Fn+D7ZIVqAkrCQt5DDYwVF7j9i8u+5D0HVaA7cZ2J
         2D4om2K8GSakx71fIIoA1FeWRpsSiYfmUF/N8SeSgk4BPmuFP/GWLexQg1PWBn93wNrA
         C5aPOwxY9Vns7Ute4MCdYifNJJojFCn4Tp1k8yN4orr0G+sV88/fUDeOrnNbwY1fuF06
         bzX2PG1nvyE4BhlvKsj+PbkoAogymr2k40K6NC/U+Sx+zpCyo/E6KiH4c1LnivFIvhUI
         X0OA==
X-Gm-Message-State: AOAM530wuAFeFMVgyY0dn75fM/RxEL/xEZbI+8Z/2t/IKPqwYsQwG92/
        +9KYzPXJkkvf5CGwm/hSSzWykdn4nf04KGX3S2M=
X-Google-Smtp-Source: ABdhPJywzUJTsSXENrmtc2ErotPbiqcfcQOqoaS2C9/jgJ2rxKDmOpjJNOtmfSPXgB/TloLzKVu5YyBho6+47gwQNU4=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr8698108ywm.19.1647013057714; Fri, 11
 Mar 2022 07:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20220310212805.3786-1-mario.limonciello@amd.com>
In-Reply-To: <20220310212805.3786-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Mar 2022 16:37:26 +0100
Message-ID: <CAJZ5v0ibnaZZu_Gxngjbu5vzdQaJog8XZnJP6_msLqV_gi4Zig@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, Huang Rui <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 10, 2022 at 10:30 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> According to the ACPI 6.4 spec:
> It is strongly recommended that the OS evaluate _OSC with the Query
> Support Flag set until _OSC returns the Capabilities Masked bit clear,
> to negotiate the set of features to be granted to the OS for native
> support; a platform may require a specific combination of features
> to be supported natively by an OS before granting native control
> of a given feature. After negotiation with the query flag set,
> the OS should evaluate without it so that any negotiated values
> can be made effective to hardware.
>
> Currently the code sends the exact same values in both executions of the
> _OSC and this leads to some problems on some AMD platforms in certain
> configurations.
>
> The following notable capabilities are set by OSPM when query is enabled:
> * OSC_SB_PR3_SUPPORT
> * OSC_SB_PCLPI_SUPPORT
> * OSC_SB_NATIVE_USB4_SUPPORT
>
> The first call to the platform OSC returns back a masked capabilities
> error because the firmware did not acknowledge OSC_SB_PCLPI_SUPPORT but
> it acknolwedged the others.
>
> The second call to the platform _OSC without the query flag set then
> fails because the OSPM still sent the exact same values.  This leads
> to not acknowledging OSC_SB_NATIVE_USB4_SUPPORT and later USB4 PCIe
> tunnels can't be authorized.
>
> This problem was first introduced by commit 159d8c274fd9 ("ACPI: Pass the
> same capabilities to the _OSC regardless of the query flag") which subtly
> adjusted the behavior from 719e1f5 ("ACPI: Execute platform _OSC also
> with query bit clear").
>
> The _OSC was called exactly 2 times:
>  * Once to query and request from firmware
>  * Once to commit to firmware without query
>
> To fix this problem, continue to call the _OSC until the firmware has
> indicated that capabilities are no longer masked.
>
> Furthermore, to avoid the problem that commit 159d8c274fd9 ("ACPI: Pass
> the same capabilities to the _OSC regardless of the query flag")
> introduced, explicitly mark support for CPC and CPPCv2 even if they
> were masked by the series of query calls due to table loading order on
> some systems.
>
> Fixes: 159d8c274fd9 ("ACPI: Pass the same capabilities to the _OSC regardless of the query flag")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> changes from v5->v6
>  * drop mika's tag due to changes
>  * negotiate until support result is empty
> ---
>  drivers/acpi/bus.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index ec83c4f6d628..351bac98f70c 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -330,14 +330,29 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>         if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>                 return;
>
> -       if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> -               return;
>
> -       kfree(context.ret.pointer);
> +       do {
> +               if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> +                       return;
> +               capbuf_ret = context.ret.pointer;
> +               if (capbuf[OSC_SUPPORT_DWORD] == capbuf_ret[OSC_SUPPORT_DWORD])
> +                       capbuf[OSC_QUERY_DWORD] = 0;
> +               capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];

I would do

if (capbuf[OSC_SUPPORT_DWORD] == capbuf_ret[OSC_SUPPORT_DWORD])
        capbuf[OSC_QUERY_DWORD] = 0;
else
        capbuf[OSC_SUPPORT_DWORD] &= capbuf_ret[OSC_SUPPORT_DWORD];

so that the loop terminates even if the firmware does strange things
and then it would only be necessary to check capbuf[OSC_QUERY_DWORD]
in the loop termination condition.

Would that work?

> +               kfree(context.ret.pointer);
> +       } while (capbuf[OSC_QUERY_DWORD] && capbuf[OSC_SUPPORT_DWORD]);
>
> -       /* Now run _OSC again with query flag clear */
> -       capbuf[OSC_QUERY_DWORD] = 0;
> +       /*
> +        * Avoid problems with BIOS dynamically loading tables by indicating
> +        * support for CPPC even if it was masked.

What exactly do you mean by "BIOS dynamically loading tables"?

> +        */
> +#ifdef CONFIG_X86
> +       if (boot_cpu_has(X86_FEATURE_HWP)) {
> +               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
> +               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
> +       }
> +#endif
>
> +       /* Now run _OSC again with query flag clear */
>         if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
>                 return;
>
> --
> 2.34.1
>
