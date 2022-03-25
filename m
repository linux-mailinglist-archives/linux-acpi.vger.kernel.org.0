Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A54E79B8
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Mar 2022 18:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiCYRPb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Mar 2022 13:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbiCYRPb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2022 13:15:31 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4E4E7295
        for <linux-acpi@vger.kernel.org>; Fri, 25 Mar 2022 10:13:56 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id j2so15225107ybu.0
        for <linux-acpi@vger.kernel.org>; Fri, 25 Mar 2022 10:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTI0sut7n/2DTyYW4vwVsNTfXly/P/m6WqJKzy12y1M=;
        b=YhprLn2RNBr5fKHZb2g3YdxnERpcmXclmiRx9P0HiQuQdYIN+JRssEhO07N1YodIU2
         6yGM73KGKz0pL+PUWMxH9LuvszC4U6J8+zMRIXUj3nppcyQ8EQh69K4WfMYM4O2/i3/5
         sqoMjduXwZz6ilIBOTpeKdeUrdkcY4ogWAELUobd66NZ/jPL8B4htzd9Ojuns0IMzwvI
         EGVCokWuW0a2rIsEwmmpqRAjXUsRPpuYxa24jcX8vCNzjl7CuwNl8poyifuTlZsYoQqn
         99GSZg17A9OIMfivNahhhz5De4JMXsw8gdA10H0rrmuDorPfTPKDgb+/RhJqxv/Hc8wA
         LUoA==
X-Gm-Message-State: AOAM530ddsUnYnfFTGOl2+K8YP0B7iS3pr9nBGPHgTB8cE0f9PuCNZIC
        KgZy+XyIPZAEPFOgNXq/yasdnq05Ve1KPq60VEw=
X-Google-Smtp-Source: ABdhPJzp4MdvUpmuA9HAieDpqasrvRGJUnlb00CHqnvTBHAziLqLYDCfWU+U7mYWXXdbJsj8lhlKm7loR1SSjSLX5Jk=
X-Received: by 2002:a25:508:0:b0:633:bcf2:d29a with SMTP id
 8-20020a250508000000b00633bcf2d29amr10426553ybf.81.1648228435924; Fri, 25 Mar
 2022 10:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220317064220.287048-1-vasant.hegde@amd.com>
In-Reply-To: <20220317064220.287048-1-vasant.hegde@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Mar 2022 18:13:45 +0100
Message-ID: <CAJZ5v0gqNRMU98=D9DXO3R2XsrKeMjTJc+RSgxYMZWs1S8snWg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Fix LAPIC_ADDR_OVR address print
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Thu, Mar 17, 2022 at 7:42 AM Vasant Hegde <vasant.hegde@amd.com> wrote:
>
> Without fix:
>   [    0.005429] ACPI: LAPIC_ADDR_OVR (address[(____ptrval____)])
>
> With fix:
>   [    0.005429] ACPI: LAPIC_ADDR_OVR (address[0x800fee00000])
>
> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> Changes in v2:
>   - Added Missing Co-developed-by tag - Thanks Rafael.
>
> -Vasant
>
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

Applied (with an adjusted subject) as 5.18-rc material, thanks!
