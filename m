Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530255A4EEB
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiH2OMx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 29 Aug 2022 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiH2OMp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 10:12:45 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86888F974
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 07:12:42 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3413ad0640dso43125527b3.13
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 07:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s3V1NpC/iGO5NDGuVjOi4YCrFZalKVqCeGyDTdvFh/I=;
        b=Ty7H+Z29DcsB6saXRfPqAbAL3Kv/pyVIt4iWr1LYha2VcJzZvF2JckvgTa6GVA1xiM
         n8t0kVLDOLW2OezVsPpYSMqPA17SDUc/JoBJSi5jd5HC1h7PoYgwWEzzC3T2uqruxotk
         vUgWd4qM7XON22CCJTyU++dVF2u5pJaFtKkgMLCf0S0Yatf78oiYLbe8vOG7SFosxWE8
         eZTREoKxQI0qPabzifttoditp3yjsprN7aJtOO1RI1mbfP6gB0uIJIUqrkgkj2sqKg2b
         MtuAglBTIb4HLBF5VtAJGxkcVp7mbXtEYZUS4nUxUB4O+44OdP+NRPPCoAmc8SCvACK2
         76Ng==
X-Gm-Message-State: ACgBeo3gmf0KgIxkIF/AWhzxdlzR5mh+7q98vodcRscRSNRv20/clrVM
        VYe1yaB30KT/SQp49Esj3u7MMcrT1/2qpoIqmlcTUORvo4c=
X-Google-Smtp-Source: AA6agR7Z+6wFf/s58ttLvLdt86z5UzjG43JBhaOUFvIoUKuapIBQuU6wudAKQTtw7WfdE5tKY+p2V8OFOm99aqJMa94=
X-Received: by 2002:a25:ec0c:0:b0:690:d092:2d56 with SMTP id
 j12-20020a25ec0c000000b00690d0922d56mr7896512ybh.622.1661782361877; Mon, 29
 Aug 2022 07:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <1cf5ec82-0f1e-3bc7-4367-dcba1ee0f64d@semihalf.com>
In-Reply-To: <1cf5ec82-0f1e-3bc7-4367-dcba1ee0f64d@semihalf.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Aug 2022 16:12:30 +0200
Message-ID: <CAJZ5v0gHMO42xiKsN5+QRM0FBN=Z1NfEQFCTzRWdwGuOmd+PZg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Synchronize disabling wake mask and servicing
 wake-up IRQ
To:     =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mm@semihalf.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Mon, Aug 29, 2022 at 12:21 PM Marek Maślanka <mm@semihalf.com> wrote:
>
> The GPE interrupts that are the wake-up source are "turned off" by clear
> the “enable_for_wake” flag when the kernel resumes (suspend_enter() ->
> acpi_s2idle_restore() -> acpi_disable_wakeup_devices() ->
> acpi_set_gpe_wake_mask()). On the resume path the kernel also resumes
> the interrupts (suspend_enter() -> dpm_resume_noirq() -> resume_irqs())
> which process the GPE interrupt that woke-up the kernel (... ->
> acpi_irq() -> acpi_ev_sci_xrupt_handler() -> acpi_ev_gpe_detect() -> …).
> The GPE interrupt routine stops in the acpi_ev_gpe_detect () function
> when the "enable_for_wake" flag is cleared.
>
> As the interrupt servicing might work simultaneously on SMP, it’s
> possible that the “enable_for_wake” flag can be cleared before the GPE
> interrupt gets chances to be processed. It might happen when the CPU
> processed other IRQ before the GPE IRQ that woke up the device.
>
> This issue is seen on low-end Chromebooks with two cores CPU when HPET
> IRQ is triggered while resuming the device and is processed before the
> ACPI GPE interrupt on the same CPU core.
>
> Before clear the enable_for_wake flag we need to make sure that the
> specific wake-up GPE IRQ block was processed.
>
> Signed-off-by: Marek Maslanka <mm@semihalf.com>

First off, if you want to modify ACPICA code, the way to do that is
via the upstream ACPICA project on GitHub.

Second, I'm not sure what the problem is.

Yes, acpi_ev_gpe_detect() will bail out early when none of the GPEs in
the given block is enabled either for wake or for run, but since the
system has been woken up already and the GPE is now disabled, it will
not trigger again until enabled next time.

Is the problem that the GPE will signal wakeup spuriously on the next
suspend or is it something else?
