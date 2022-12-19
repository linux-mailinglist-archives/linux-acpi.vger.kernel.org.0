Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74D9650D2C
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Dec 2022 15:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiLSOYb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Dec 2022 09:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiLSOY1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Dec 2022 09:24:27 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC81E0FC
        for <linux-acpi@vger.kernel.org>; Mon, 19 Dec 2022 06:24:23 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id s14so6336817qvo.11
        for <linux-acpi@vger.kernel.org>; Mon, 19 Dec 2022 06:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opYfUJfX+t3G1+uTyHf3AAPG5+rUWPpL5GZTT/dz/AE=;
        b=dzyP4DTBwwUcttN0RPgDk4u+y1sPUpUA8DstYwm5c/mTWEZUaL8lTbhs5h0aZRLmt4
         hzWDeTLshCykMOVPyhJPlkqEX7CyqJS7Ye7jJ+gE+G5Mp7ccpArVl/M/C8C89m+Ok+0R
         WzoVfSLG8M0NyyPIk6ltmYl8bDc2p1+6Lrc46Fg4oI8JMJDWLaeSCg1JKGpsBrrSVfjI
         VD/u2Pic7juRBxPpNHaWfbxY6Rs9ShW2ehjlmhfqsgjc08hxOgiUWd9mZzLAbDLIMVW3
         2+Zq4UC2huYzjOgKvz6vE/0CMpSc5oM8N1yHejSfTO37lZ9kPlq+UpoTRWlAsWIXIO5M
         vHqg==
X-Gm-Message-State: ANoB5pmThj47NI991rX7zgxcP296N+0njzYczMkZQZBcNChXAC/HYLQr
        36TRJsgYAlWjRTod0CK2RoF0vG6rfndsMqfzXgVASkYX
X-Google-Smtp-Source: AA0mqf5CEd2a4I9UuSGT2aKUM3aTDIxpt56R/buoLYgscHrbeDrGh9jdCosqijgdnZvh8FImcitEUAvspV7W9jHrnro=
X-Received: by 2002:ad4:534b:0:b0:4b1:8429:a8a7 with SMTP id
 v11-20020ad4534b000000b004b18429a8a7mr71069953qvs.52.1671459862379; Mon, 19
 Dec 2022 06:24:22 -0800 (PST)
MIME-Version: 1.0
References: <a90ed996-95c9-9fc8-93b5-bcc733618eeb@oracle.com>
In-Reply-To: <a90ed996-95c9-9fc8-93b5-bcc733618eeb@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Dec 2022 15:24:06 +0100
Message-ID: <CAJZ5v0iY_TgF2tN2aOK3HrahauxY6DP1rbTumgTmZugBjqfomA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/ACPI: Ignore CPUs that are not online capable for
 x2apic, entries as well
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 16, 2022 at 7:36 PM James Puthukattukaran
<james.puthukattukaran@oracle.com> wrote:
>
> Extending commit aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not
> online capable") to include acpi_parse_x2apic as well. There is a check
> for invalid apicid; however, there are BIOS FW with madt version >= 5
> support that do not bother setting apic id to an invalid value since they
> assume the OS will check the enabled and online capable flags.
>
> Signed-off-by: James Puthukattukaran<james.puthukattukaran@oracle.com>
> Reported-by: Benjamin Fuller<ben.fuller@oracle.com>
>
> v2 : use 'enabled' local variable. Also fix checkpatch.pl catches
> ---
>  arch/x86/kernel/acpi/boot.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 907cc98b1938..35d8c8654b42 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -208,7 +208,16 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
>         apic_id = processor->local_apic_id;
>         enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
>
> -       /* Ignore invalid ID */
> +
> +       /* don't register processors that can not be onlined */
> +       if (acpi_support_online_capable &&
> +           !enabled &&

Is the line break before the "enabled" check necessary?

I think it would be better to check "enabled" first anyway.

> +           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +               return 0;
> +
> +       /* for systems older than madt version 5 (does not have
> +        * ACPI_MADT_ONLINE_CAPABLE defined), ignore invalid ID
> +        */

The formatting of the above comment doesn't follow the kernel coding
style for multi-line comments.

>         if (apic_id == 0xffffffff)
>                 return 0;
>
> --
