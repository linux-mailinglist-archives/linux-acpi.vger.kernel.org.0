Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C625A617F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Aug 2022 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiH3LSh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 30 Aug 2022 07:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiH3LSf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2022 07:18:35 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2856F439B
        for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2022 04:18:33 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-340f82c77baso148917887b3.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2022 04:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SJESypJb05BwXkl2bW12JaYLlSGdP0ULIXZIzs9jeyQ=;
        b=CPQueJMr4i3eSKeU48nUMA3/bUprtMDd2D/onsXOGKPOrS/cVIClvEFiDLwcmGklqz
         4IqoaRwgqpA3mvBLXiKr1hBMZuv5M8mbp1O9UcdYKGmbEg0pv+6zKjfRANKMz+dgTu23
         RdWTA8lL5zRdjKT5aPlXP1t8qtK158S0fS/4UIKAjBtuMvOnk9vxfB19eZu4JcmzmrU4
         HFV5MYaef5bRxTXzoovoKrxkXnHiS2RaLHRX1hLYFG9DFbqEvltQi4ZYVMdeDe6JnzO/
         6ZZzdQUZul1Fh6cIIcPWgSzd0cuEV0a/F4Rpy7N5n41OCohOjd58/x2HQqP1xDkmnqcv
         q9uQ==
X-Gm-Message-State: ACgBeo2xV6EydjlAZ2E8OCsC7amTuS0qObcY1bflvejtNtlUFqscnYCv
        Aq6Oh2guGmpgJvOW0dCAWunn3BND2Mp68VZZIhw=
X-Google-Smtp-Source: AA6agR63boSqPY/Hln4Bba6y45iarWnGdIedHNhpCR06302O8aXHq6tP2MtZlUI6AAw+hn6ZcZcs5xym612uhLPh1I4=
X-Received: by 2002:a25:664a:0:b0:695:e7cc:9a20 with SMTP id
 z10-20020a25664a000000b00695e7cc9a20mr11704955ybm.153.1661858312238; Tue, 30
 Aug 2022 04:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <1cf5ec82-0f1e-3bc7-4367-dcba1ee0f64d@semihalf.com>
 <CAJZ5v0gHMO42xiKsN5+QRM0FBN=Z1NfEQFCTzRWdwGuOmd+PZg@mail.gmail.com> <85fa3a0c-cee9-3aaa-cd41-7d4ca9d90235@semihalf.com>
In-Reply-To: <85fa3a0c-cee9-3aaa-cd41-7d4ca9d90235@semihalf.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Aug 2022 13:18:17 +0200
Message-ID: <CAJZ5v0jcxnWt14RL0Cpj_LWdATUH2yMV9cu5uphV=DeOg0oayQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Synchronize disabling wake mask and servicing
 wake-up IRQ
To:     =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mm@semihalf.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 30, 2022 at 8:14 AM Marek Maślanka <mm@semihalf.com> wrote:
>
> On 29.08.2022 16:12, Rafael J. Wysocki wrote:
> > On Mon, Aug 29, 2022 at 12:21 PM Marek Maślanka <mm@semihalf.com> wrote:
> >>
> >> The GPE interrupts that are the wake-up source are "turned off" by clear
> >> the “enable_for_wake” flag when the kernel resumes (suspend_enter() ->
> >> acpi_s2idle_restore() -> acpi_disable_wakeup_devices() ->
> >> acpi_set_gpe_wake_mask()). On the resume path the kernel also resumes
> >> the interrupts (suspend_enter() -> dpm_resume_noirq() -> resume_irqs())
> >> which process the GPE interrupt that woke-up the kernel (... ->
> >> acpi_irq() -> acpi_ev_sci_xrupt_handler() -> acpi_ev_gpe_detect() -> …).
> >> The GPE interrupt routine stops in the acpi_ev_gpe_detect () function
> >> when the "enable_for_wake" flag is cleared.
> >>
> >> As the interrupt servicing might work simultaneously on SMP, it’s
> >> possible that the “enable_for_wake” flag can be cleared before the GPE
> >> interrupt gets chances to be processed. It might happen when the CPU
> >> processed other IRQ before the GPE IRQ that woke up the device.
> >>
> >> This issue is seen on low-end Chromebooks with two cores CPU when HPET
> >> IRQ is triggered while resuming the device and is processed before the
> >> ACPI GPE interrupt on the same CPU core.
> >>
> >> Before clear the enable_for_wake flag we need to make sure that the
> >> specific wake-up GPE IRQ block was processed.
> >>
> >> Signed-off-by: Marek Maslanka <mm@semihalf.com>
> >
> > First off, if you want to modify ACPICA code, the way to do that is
> > via the upstream ACPICA project on GitHub.
> >
> > Second, I'm not sure what the problem is.
> >
> > Yes, acpi_ev_gpe_detect() will bail out early when none of the GPEs in
> > the given block is enabled either for wake or for run, but since the
> > system has been woken up already and the GPE is now disabled, it will
> > not trigger again until enabled next time.
> >
> > Is the problem that the GPE will signal wakeup spuriously on the next
> > suspend or is it something else?
>
> In my cases the problem is the GPE STS flag that cannot be cleared
> (acpi_ev_gpe_detect() -> acpi_ev_detect_gpe() -> acpi_ev_gpe_dispatch()
> -> acpi_hw_clear_gpe()). If the status bit is not cleared before the
> next suspend, the device will not wake up.

Interesting.

Have you considered modifying acpi_set_gpe_wake_mask() to clear the
GPE status after clearing the bit in the enable_for_wake mask if the
corresponding bit in enable_for_run is also unset?
