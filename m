Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8D4C9433
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 20:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiCATZ1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 14:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiCATZ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 14:25:26 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE9E2DD61
        for <linux-acpi@vger.kernel.org>; Tue,  1 Mar 2022 11:24:45 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id x200so3985338ybe.6
        for <linux-acpi@vger.kernel.org>; Tue, 01 Mar 2022 11:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9nlcVaGWQLFrDhQZ2wPL1I45PMx8RueeXg3KijTrVQ=;
        b=lk/Q0Z2xzwBDYwH5eh1jIhRAhjTX1yXAMDXymjQDmjA9xYVFLRIr6/0UK5Ju14kf4S
         tdXLwE8D1+A4/HqKHLsS7wbi6qA9Y3jd0xzoMCLxzBwr9z9oStHTzsm3T88VEfwalsUX
         GnKLXb/oMimh0uPYSwTynnVcrNrdpCKaNpIljiilLfRBygZ0cMs5e19wjrJHvpuYiwb3
         Fr2Mb7BOZK3f7qdttZVpwlslWV7xRZspKtvNeOezzBWWtt9ydZeliPDC+m2KYdJFOFyO
         COMAIcRbg4dqJHkMI+sxVDrYdGlcirYsy4UePd6canhwYXz9rk0D2FyS1OFEBbzACuut
         SX/Q==
X-Gm-Message-State: AOAM533GI1CjLViY7NrHhZIp9ohJfpzpRXWFaFtb1+zgFawwEpz9ypvS
        tBvnhjRdCkkRMcEMx4Me75tvkRd7MyYalVF98D8RNmvL
X-Google-Smtp-Source: ABdhPJyfbEjyvR5S1z0whIFUaGanPzDW/UvZItFKQREZ5K23QNLkT6VnRUrqOOcC0/RKGKk5rgMk9X2ASKwpbwbnluY=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr23593741ybe.365.1646162685017; Tue, 01
 Mar 2022 11:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20220221044333.19149-1-vasant.hegde@amd.com>
In-Reply-To: <20220221044333.19149-1-vasant.hegde@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 20:24:34 +0100
Message-ID: <CAJZ5v0jkSZjYeNCbsQMj6GGAarnirDi0k0PRtXi3ED++s4_hxg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Fix LAPIC_ADDR_OVR address print
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
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

On Mon, Feb 21, 2022 at 5:44 AM Vasant Hegde <vasant.hegde@amd.com> wrote:
>
> Without fix:
>   [    0.005429] ACPI: LAPIC_ADDR_OVR (address[(____ptrval____)])
>
> With fix:
>   [    0.005429] ACPI: LAPIC_ADDR_OVR (address[0x800fee00000])
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The meaning of this sign-off is unclear.

If this a co-developer sign-off, please use a Co-developed-by tag to
clarify that.

> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/acpi/tables.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 0741a4933f62..550e9512534c 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -151,8 +151,8 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>                 {
>                         struct acpi_madt_local_apic_override *p =
>                             (struct acpi_madt_local_apic_override *)header;
> -                       pr_info("LAPIC_ADDR_OVR (address[%p])\n",
> -                               (void *)(unsigned long)p->address);
> +                       pr_info("LAPIC_ADDR_OVR (address[0x%llx])\n",
> +                               p->address);
>                 }
>                 break;
>
> --
> 2.27.0
>
