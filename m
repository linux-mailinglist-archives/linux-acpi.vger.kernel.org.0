Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978347768B9
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 21:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjHIT0H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 9 Aug 2023 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHITZe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 15:25:34 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672722718;
        Wed,  9 Aug 2023 12:24:38 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56d26137095so28072eaf.1;
        Wed, 09 Aug 2023 12:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609077; x=1692213877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6nqZfavj7lPMTgzRnojuEHNFwXHJ0sR2jKpGGcn1g8=;
        b=B89fwSymMMhToB6cP9heP2nI9diISTDFEZrYIvPA1E3Kj+OGLNtaviv4D0Ds+s+SJC
         hMwViZSfLlc5lPPHj1l4S13Wv6MjVhiXY2ZOAcorKVqT3xAM/uEW67qMEERKqRltfMmI
         /OpGyKh5uoCqDb4bsjgufCx0nglpY8rVV+LW5Myu+zotXy/LjsLCPPYc3nX4AhWS/Gmo
         WLDAoag2dKe6NMIWHcsli1EQXfcIyvKvFlDlIO3Z75xHNVAE4cksd6JBo9dXx049WuYp
         e3O/T9FaxZivjqf43QVpfxjPd3Pmngh7Xjs3UVCXrqzjvm5v/BkzCd11A7NGdj7rN0de
         70Yw==
X-Gm-Message-State: AOJu0Yz5jBKw2Q4JP47tB7AZkWJvqsDRBTkzBp1Hkp+yWBQtlvdhxnPh
        y8daKemtvjLg/lWInLVF/Q2GUctzK2HNxYFLYeQ=
X-Google-Smtp-Source: AGHT+IGU8IICmAsS+amt7KaPQqAJIjXzDKMaOEuKUKFxn0mp/ZA9pnGU+wWtlBQomuSsEfqlSb3khKZO8hTNbwkbqXg=
X-Received: by 2002:a4a:dc87:0:b0:56d:72dc:5410 with SMTP id
 g7-20020a4adc87000000b0056d72dc5410mr199666oou.1.1691609077493; Wed, 09 Aug
 2023 12:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230809085526.84913-1-hdegoede@redhat.com> <20230809085526.84913-4-hdegoede@redhat.com>
 <f133d401-1975-6c85-47c5-f9464d5ef06f@kernel.org> <3fe197da-c26e-e826-4ea2-c13d2880046d@redhat.com>
 <CAJZ5v0garg=icaM5f0JNvY+ip7PX1omMRWDS-UvF1_1f82SYZg@mail.gmail.com> <642bc861-f7fa-4c5f-2082-eb26258132a5@redhat.com>
In-Reply-To: <642bc861-f7fa-4c5f-2082-eb26258132a5@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Aug 2023 21:24:26 +0200
Message-ID: <CAJZ5v0ik0pE+HikC+22yKLODvAiCoJ3sFwaSTxHi2yAsN_SLYw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings
 for IRQ1 on AMD Zen
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
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

On Wed, Aug 9, 2023 at 5:00 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 8/9/23 16:57, Rafael J. Wysocki wrote:
> > On Wed, Aug 9, 2023 at 4:40 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 8/9/23 11:20, Jiri Slaby wrote:
> >>> On 09. 08. 23, 10:55, Hans de Goede wrote:
> >>>> On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
> >>>> settings over the MADT settings.
> >>>>
> >>>> This causes the keyboard to malfunction on some laptop models
> >>>> (see Links), all models from the Links have an INT_SRC_OVR MADT entry
> >>>> for IRQ 1.
> >>> ...
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>> ...
> >>>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> >>>> index 21b542a6866c..b88e5e0135ab 100644
> >>>> --- a/arch/x86/kernel/acpi/boot.c
> >>>> +++ b/arch/x86/kernel/acpi/boot.c
> >>>> @@ -52,6 +52,7 @@ int acpi_lapic;
> >>>>   int acpi_ioapic;
> >>>>   int acpi_strict;
> >>>>   int acpi_disable_cmcff;
> >>>> +int acpi_int_src_ovr[NR_IRQS_LEGACY];
> >>>
> >>> So why not to use bool to make it clear this is not an irq number, but a state?
> >>>
> >>>>     /* ACPI SCI override configuration */
> >>>>   u8 acpi_sci_flags __initdata;
> >>>> @@ -588,6 +589,9 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
> >>>>         acpi_table_print_madt_entry(&header->common);
> >>>>   +    if (intsrc->source_irq < NR_IRQS_LEGACY)
> >>>> +        acpi_int_src_ovr[intsrc->source_irq] = 1;
> >>>
> >>> And "true" here.
> >>
> >> Ack that would indeed be better.
> >>
> >> Rafael, can you fix this up while merging or do you want a v4 series ?
> >
> > I think I can do that.
>
> Great, thank you.
>
> Do you have any comments on this series, or is this ready for merging now?

I've applied this series as 6.5-rc6 material and made the change
discussed above.

It has been added to my linux-next branch too.

Thanks!
