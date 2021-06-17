Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07303AB342
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhFQMJU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 08:09:20 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42911 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhFQMJU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 08:09:20 -0400
Received: by mail-ot1-f42.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so5850017oth.9;
        Thu, 17 Jun 2021 05:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70Prv0Q9PiR2Mu1RsII1XZ4V8W5RAajPqngPjwLFOeo=;
        b=qIbPRxZ8VNE3CIqpmpIntA6oA9+tF5RH6xhHHSJ+x353HDab4UWxE2F7aaNlnISNnp
         2by1hLfkHE3X9H/+vPDDqCgmK3GuPMcvndvMCLllEekzC8TiEvb69vYFEya1gzi2+fpH
         cy8ElREI9Db9HIQ/FyfgFgGd5OpSZchlFFzBWAVdbOgZ+tkqnFZABfvR+y5X/VMaC8F1
         oDEP9Nvv/7nO94T9TOLhN4s/ySjvgSm8C3KbaxdouzHCPHLZjsN9cFk8tzmIBwftwscx
         aGreh8u4jMtSMQbwWzKLTfUicb4cOyD22fMIm82RngXAHQuVc+1KD33ytf9ZSkuNzvhw
         d7mw==
X-Gm-Message-State: AOAM533fxxku2SZx8bsmE/sEVQ6ETCJDGV9M+sUKhqb0JDQwa6bpD199
        qP5FRAm7+DsxRvN9EVZW2wd4FUMuvTFR0BLLL4w=
X-Google-Smtp-Source: ABdhPJz7lh+lT2LPBBP08RYxXR+wg480zZHpwCz0fatQfQ+GHy+L8yGM+nwGS6GgAMByJ5ZW3peHoLOa1q+GzGkCN8s=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr4450235otb.206.1623931632819;
 Thu, 17 Jun 2021 05:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <1623415027-36130-1-git-send-email-tanxiaofei@huawei.com>
 <CAJZ5v0gvzZ-64AJuEsOg2M=veZYz+9ciG5wFEQT7ghki2SNpPA@mail.gmail.com> <d38b018d-2adf-9549-ba55-44289c816fed@huawei.com>
In-Reply-To: <d38b018d-2adf-9549-ba55-44289c816fed@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 14:07:01 +0200
Message-ID: <CAJZ5v0jRrow5nXF3mXCVKerzaURKqDJBMp_PDfQDLF2OVpEeGA@mail.gmail.com>
Subject: Re: [PATCH v7] ACPI / APEI: fix the regression of synchronous
 external aborts occur in user-mode
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 15, 2021 at 5:47 AM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
> Hi Rafael,
>
> On 2021/6/14 23:46, Rafael J. Wysocki wrote:
> > On Fri, Jun 11, 2021 at 2:40 PM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
> >>
> >> Before commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
> >> synchronise with APEI's irq work"), do_sea() would unconditionally
> >> signal the affected task from the arch code. Since that change,
> >> the GHES driver sends the signals.
> >>
> >> This exposes a problem as errors the GHES driver doesn't understand
> >> or doesn't handle effectively are silently ignored. It will cause
> >> the errors get taken again, and circulate endlessly. User-space task
> >> get stuck in this loop.
> >>
> >> Existing firmware on Kunpeng9xx systems reports cache errors with the
> >> 'ARM Processor Error' CPER records.
> >>
> >> Do memory failure handling for ARM Processor Error Section just like
> >> for Memory Error Section.
> >
> > Still, I'm not convinced that this is the right way to address the problem.
> >
> > In particular, is it guaranteed that "ARM Processor Error" will always
> > mean "memory failure" on all platforms?
> >
>
> There are two sources for ARM Processor cache errors(no second case for the platform that doesn't support poison mechanism).
> 1.occur in the cache. If it is transient, we have a chance to recover by doing memory failure.
> If it is persistent, we have to handle in other place, such as do cache way isolation in firmware,
> or trigger cpu core isolation in user space. I think most platform can't support such feature,
> so the most simple and effective way is report as fatal error and do isolation during firmware start-up phase.
>
> 2.error transferred from other RAS node. If it is from DDR, i think there is no doubt, and this is
> the most cases we met before.If it is from other place of SoC, such as internal SRAM(the probability is very little compare to DDR),
> the error is still in the hardware. But the RAS node that detected the SRAM error will also report the error.
>
> To sum up the above, it is effective for most situation, and no harm for the others.

OK, so applied as 5.14 material under edited subject.

Thanks!
