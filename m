Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6F4D526C
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 20:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiCJTG0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 14:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245757AbiCJTGZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 14:06:25 -0500
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C63615929B
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 11:05:20 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id f38so12812347ybi.3
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 11:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOi4cn58r0eZpnQkiy/hcxzLFxYtfFpSpg3WsG4WRgw=;
        b=z0SJf1VH1YYcWwylXcx0hXCRIfI/QR5day7Ym/NAT1f/VXugQw32ws03fnxmiN8sB1
         7ig8dHbVRUFSniUEvvRlEPttpeTUJrgvJrVbScYGfRKqVHb9ZiKov8wpm9lPaPMZne8A
         Uh7ysZ+bLsLph9g3F31z6vorafSJMWA+CVSALK0Dd2VjHneHtl6Q3RlGovDffSxel3Yx
         XvyAN2Lc9XD/pAWITjRIkqCl/GFg5yJ+q6vUjv5bzGWTdPwaSweqe/AwL/bugRHiJwkN
         NyPK39TVUvPk0CLmtCmGS56BcxRpjKYV2jF9V6nrqOX2MoxXPpZtGnA+HjvVE7Ps8r6G
         PIrA==
X-Gm-Message-State: AOAM533N4bopzKM0sPZfezoZxxJDVKwxRlZ7GB7gHQEPAcfMF3y8WJmY
        4in0l6E2kvKK6XyhVWest1wFddx7rFGs5JE3xEk=
X-Google-Smtp-Source: ABdhPJzzVQRIP9wurCZY76zTFRtZXob7srktxguUruxLrhfgmgpyico8+6P9QWuW3Mev52MjSuxzXJt+EUqr63yS3Q4=
X-Received: by 2002:a25:d7c2:0:b0:628:9d06:457b with SMTP id
 o185-20020a25d7c2000000b006289d06457bmr5149198ybg.137.1646939119358; Thu, 10
 Mar 2022 11:05:19 -0800 (PST)
MIME-Version: 1.0
References: <20220309163749.773474-1-mario.limonciello@amd.com>
In-Reply-To: <20220309163749.773474-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Mar 2022 20:05:08 +0100
Message-ID: <CAJZ5v0gw7z6qwXRYe-_XRTZouJ+gpAWX3W02jiMnaR44T453Cg@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: bus: For platform OSC negotiate capabilities
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Xiaomeng.Hou@amd.com, Aaron.Liu@amd.com,
        Huang Rui <Ray.Huang@amd.com>,
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

On Wed, Mar 9, 2022 at 5:46 PM Mario Limonciello
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
> indicated that capabilities are no longer masked or after an arbitrary
> number of negotiation attempts.
>
> Furthermore, to avoid the problem that commit 159d8c274fd9 ("ACPI: Pass
> the same capabilities to the _OSC regardless of the query flag")
> introduced, explicitly mark support for CPC and CPPCv2 even if they
> were masked by the series of query calls due to table loading order on
> some systems.
>
> Fixes: 159d8c274fd9 ("ACPI: Pass the same capabilities to the _OSC regardless of the query flag")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> This series was accepted but showed a regression in another use of acpi_run_osc
> so the series was dropped.
>
> Changes from v4->v5:
>  * Move negotiation entirely into acpi_bus_osc_negotiate_platform_control
>  drivers/acpi/bus.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index b96c54813886..86d88bd72c07 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -294,6 +294,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>                 .cap.pointer = capbuf,
>         };
>         acpi_handle handle;
> +       int i;
>
>         capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
>         capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
> @@ -329,10 +330,34 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>         if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>                 return;
>
> -       if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> -               return;
> +       /*
> +        * Check if bits were masked, we need to negotiate
> +        * prevent potential endless loop by limited number of
> +        * negotiation cycles.
> +        */
> +       for (i = 0; i < 5; i++) {

Why 5 iterations?

Why cannot it work in analogy with the loop in acpi_pci_osc_control_set()?

> +               bool retry = false;
> +
> +               if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> +                       return;
> +               capbuf_ret = context.ret.pointer;
> +               retry = capbuf_ret[OSC_SUPPORT_DWORD] != capbuf[OSC_SUPPORT_DWORD];
> +               capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> +               kfree(context.ret.pointer);
> +               if (!retry)
> +                       break;
> +       }
>
> -       kfree(context.ret.pointer);
> +       /*
> +        * Avoid problems with BIOS dynamically loading tables by indicating
> +        * support for CPPC even if it was masked.
> +        */
> +#ifdef CONFIG_X86
> +       if (boot_cpu_has(X86_FEATURE_HWP)) {
> +               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
> +               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
> +       }
> +#endif
>
>         /* Now run _OSC again with query flag clear */
>         capbuf[OSC_QUERY_DWORD] = 0;
> --
> 2.34.1
>
