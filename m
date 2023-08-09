Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1D677631F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjHIO6G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 9 Aug 2023 10:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjHIO6F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 10:58:05 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF82108;
        Wed,  9 Aug 2023 07:58:04 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-56d26137095so1011826eaf.1;
        Wed, 09 Aug 2023 07:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593084; x=1692197884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guzu/+wE2xbeIQCNFGsUh3J9zEJsNU71gsPXh1jGfuo=;
        b=V63XWq8UqOVV5IiO05wdp6cmqByXb8rJ5FoAP38u+gJVO3HWUCp9ExLOgRyuC1VO12
         gka2v+ZkKoM1YMfJc/rNQgeC499kDaLAs8CQncNwm0EN19UuzHD8XKg0tSBqK6EgPPC9
         7I12fFz7T5IbaflRCNEHizndBz6DW4lT3cqzUhQWG36HQK9c+VlW4b/DpoIod1ehRBHS
         o3D0ONMf/bLd3KDWZbRXxO+8IcWKm9/sMrZU5uLFnmHL2whCAPfOAhAwcG7G1/0tXBTa
         Fd2/xSFXWmhTUlPp0arfqRNDB35bYLBxkZdjOyxjGnE8DEeRTXjMHuOCS22gUrFLBNeY
         Fb9A==
X-Gm-Message-State: AOJu0YyCe4bL+lnsPnuU2OVbn1xeKANIQTLpXAvIwgRDb9wug6dFvsI6
        7NtUJQIRl/aXRQgOGxKBEpaTQbvnpAfZWqkO84Qg5hyb
X-Google-Smtp-Source: AGHT+IF/p/GEZe/16sVQWpg2UzPaOiKB7HX/MaLebIpIA3z/PKH4Zd/5EhPlCpND4aoMBTPmF3+nbZVYe6CwaKIR368=
X-Received: by 2002:a4a:c816:0:b0:56d:72dc:5410 with SMTP id
 s22-20020a4ac816000000b0056d72dc5410mr2262417ooq.1.1691593082993; Wed, 09 Aug
 2023 07:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230809085526.84913-1-hdegoede@redhat.com> <20230809085526.84913-4-hdegoede@redhat.com>
 <f133d401-1975-6c85-47c5-f9464d5ef06f@kernel.org> <3fe197da-c26e-e826-4ea2-c13d2880046d@redhat.com>
In-Reply-To: <3fe197da-c26e-e826-4ea2-c13d2880046d@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Aug 2023 16:57:51 +0200
Message-ID: <CAJZ5v0garg=icaM5f0JNvY+ip7PX1omMRWDS-UvF1_1f82SYZg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings
 for IRQ1 on AMD Zen
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 9, 2023 at 4:40 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 8/9/23 11:20, Jiri Slaby wrote:
> > On 09. 08. 23, 10:55, Hans de Goede wrote:
> >> On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
> >> settings over the MADT settings.
> >>
> >> This causes the keyboard to malfunction on some laptop models
> >> (see Links), all models from the Links have an INT_SRC_OVR MADT entry
> >> for IRQ 1.
> > ...
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ...
> >> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> >> index 21b542a6866c..b88e5e0135ab 100644
> >> --- a/arch/x86/kernel/acpi/boot.c
> >> +++ b/arch/x86/kernel/acpi/boot.c
> >> @@ -52,6 +52,7 @@ int acpi_lapic;
> >>   int acpi_ioapic;
> >>   int acpi_strict;
> >>   int acpi_disable_cmcff;
> >> +int acpi_int_src_ovr[NR_IRQS_LEGACY];
> >
> > So why not to use bool to make it clear this is not an irq number, but a state?
> >
> >>     /* ACPI SCI override configuration */
> >>   u8 acpi_sci_flags __initdata;
> >> @@ -588,6 +589,9 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
> >>         acpi_table_print_madt_entry(&header->common);
> >>   +    if (intsrc->source_irq < NR_IRQS_LEGACY)
> >> +        acpi_int_src_ovr[intsrc->source_irq] = 1;
> >
> > And "true" here.
>
> Ack that would indeed be better.
>
> Rafael, can you fix this up while merging or do you want a v4 series ?

I think I can do that.
