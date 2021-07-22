Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2EE3D2BDA
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jul 2021 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhGVRnP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jul 2021 13:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhGVRnO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jul 2021 13:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626978229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mllG7d1EaiDhtZiE6tYfjx4vNuapQGemGteuRu7CwuU=;
        b=UHYQ6+aJWlAEhrKjgUy7mmt5jfIu17i+jUj1aIfK1hIZw7+akpwjVQPzJLaql6/TUXUICI
        hihGXIKNpo6AXrnPwwNo861s0Ob3LmM5BF5qdmVesuB28b8JqHtKLtkz6DERnwkZLYM0S2
        IX+sXHAr8z/RCP5xCBBUV9V6FLWaJV4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-RR086hY9N86gWogLxyC7dg-1; Thu, 22 Jul 2021 14:23:47 -0400
X-MC-Unique: RR086hY9N86gWogLxyC7dg-1
Received: by mail-lj1-f200.google.com with SMTP id b13-20020a2ebc0d0000b029019a7d06c3caso2862387ljf.21
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jul 2021 11:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mllG7d1EaiDhtZiE6tYfjx4vNuapQGemGteuRu7CwuU=;
        b=hhjIfx3KE432OJaAGPNp+4FsRvtO8qs6i4qjGZ7zW6BQKZkD2BLfM7wwppAkaG5sJ0
         mxjBmqHTYbdEb5Bsf18SXF8QObzzpHybEbi0iaSRhKDbyXn08GCtloiMlTxAfNB1TGWx
         F+3+qV0UcfKhmY2CX4dB/RObgCZz2VsQ8Vyt2rJ9AuIdJCOfxRrO+0ZrvFBb7wvq7ic/
         aW9JU0jedcgSadbwvilP/7vQMLqF1qyZqWMgVfyuKfCs/jR6KWNFtT7qh055VSl+Et5O
         Ottc0r88X8rzAoSsXEsBh6JReRz1clrcCuLXwiXszfBVPSgkS9ICdzZ46b4SlHBVlv2H
         R2hg==
X-Gm-Message-State: AOAM531A4Y1O6GDOUIgptzLENT58y768JYKTgJiERJd49isjScgHfQGu
        nUKLQdRW2SE0MvsmakYjD0AiIYa57n/ZJksvQRZmvbbHcVM6le/jS8SZpLJdGCXTTH30VEfHWBX
        4AVeWQKADLRxxoOa3+Pa6OpfKv5egWzFjWXhfQw==
X-Received: by 2002:ac2:510c:: with SMTP id q12mr478939lfb.185.1626978226314;
        Thu, 22 Jul 2021 11:23:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNZy/oBXASJV2l/O02VerLeWpfZtg00jnlbaIAspv0hTSDQ55+neC2Tqf0vVaG/dz7OGzdj3Zhmnlym27KKpM=
X-Received: by 2002:ac2:510c:: with SMTP id q12mr478924lfb.185.1626978226126;
 Thu, 22 Jul 2021 11:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210629144415.GA28457@lpieralisi> <14ca6f72-9b0f-ebd7-9cf8-a5d6190c8e5d@arm.com>
 <20210629163543.GA12361@arm.com> <20210630103715.GA12089@lpieralisi>
 <e548e72c-83a4-2366-dd57-3e746040fea9@arm.com> <CAMj1kXH=Q+WNgGsbApiq94z5OpJOnNLcFk_dyoVm_-VQunv3MA@mail.gmail.com>
 <20210630154923.GA16215@lpieralisi> <CAMj1kXHgPmJV6sPO8OWYj84Ncts00fzn+gJ=+xzcXYhCxvm-aA@mail.gmail.com>
 <20210705161715.GA19877@lpieralisi> <CAMj1kXHQKKnzJUEXMMzt3D1NUodeik8FZN1OTpD9zf8ZWrp6Lw@mail.gmail.com>
 <20210716162617.GA1403@lpieralisi> <CA+tGwnmu-uL1v3vWO1yzH1i1ru6+EbVdEKnGOifoS6fLuTTGoQ@mail.gmail.com>
 <3422218f-73cc-ed3d-025a-ccf809075968@arm.com>
In-Reply-To: <3422218f-73cc-ed3d-025a-ccf809075968@arm.com>
From:   Veronika Kabatova <vkabatov@redhat.com>
Date:   Thu, 22 Jul 2021 20:23:07 +0200
Message-ID: <CA+tGwn=FzyWzZ6VOamc0wLOmbA3b0vcE3RumcADyFKJD+U2b4w@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOKdjCBGQUlMOiBUZXN0IHJlcG9ydCBmb3Iga2VybmVsIDUuMTMuMC1yYzcgKGFybQ==?=
        =?UTF-8?B?LW5leHQsIDhhYjliMWE5KQ==?=
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Memory Management <mm-qe@redhat.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        skt-results-master@redhat.com, Jan Stancek <jstancek@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jeff Bastian <jbastian@redhat.com>,
        James Morse <james.morse@arm.com>, lv.zheng@intel.com,
        CKI Project <cki-project@redhat.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 22, 2021 at 3:52 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-07-22 13:38, Veronika Kabatova wrote:
> > On Fri, Jul 16, 2021 at 6:26 PM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >>
> >> On Fri, Jul 16, 2021 at 06:16:01PM +0200, Ard Biesheuvel wrote:
> >>> On Mon, 5 Jul 2021 at 18:17, Lorenzo Pieralisi
> >>> <lorenzo.pieralisi@arm.com> wrote:
> >>>>
> >>>> On Wed, Jun 30, 2021 at 08:18:22PM +0200, Ard Biesheuvel wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>> In current code, even if the BERT were mapped with acpi_os_map_iomem()
> >>>>>> this would change nothing since it's acpi_os_ioremap() that runs the
> >>>>>> rule (backed up by EFI memory map region info).
> >>>>>>
> >>>>>
> >>>>> Indeed. So the fact that acpi_os_map_memory() is backed by
> >>>>> acpi_os_ioremap() is something we should fix. So they should both
> >>>>> consult the EFI memory map, but have different fallback defaults if
> >>>>> the region is not annotated correctly.
> >>>>
> >>>> Put together patch below even though I am not really satisfied, a tad
> >>>> intrusive and duplicate code in generic/arch backends, compile tested
> >>>> only; overall this IO vs memory mapping distinction is a bit too fuzzy
> >>>> for my taste - there is legacy unfortunately to consider though.
> >>>>
> >>>
> >>> I'd say that this does not look unreasonable at all. Is there any way
> >>> we could get this tested on actual hw?
> >>
> >> Sure, I was meant to follow-up and was caught up in something else,
> >> sorry.
> >>
> >> I will clean up the log, push it out in a branch on Monday, CKI
> >> should pick it up. I will also think about other possible testing
> >> options.
> >>
> >
> > Hi,
> >
> > thanks for the patience with the testing, the stress-ng test couldn't
> > deal with a new glibc version and had to be fixed and this week
> > has just been crazy.
> >
> > I managed to do 2 runs of the updated tree with the stress-ng test
> > and it didn't hit the problem. Given how unreliably it reproduces it
> > doesn't mean all that much. I still have one more run pending and
> > can submit more if needed.
> >
> > However, we ran into a panic with this tree on a completely
> > different machine:
> >
> > https://gitlab.com/-/snippets/2152899/raw/main/snippetfile1.txt
>
> All the warnings from arch_setup_dma_ops() there are (unfortunately)
> pretty much legitimate for that platform, and should be gone again since
> rc2 with commit c1132702c71f.
>
> > The machine also hit a hardware error during LTP:
> >
> > https://gitlab.com/-/snippets/2152899/raw/main/snippetfile2.txt
>
> Hmm, if "access mode: secure" in that fault report implies that the
> firmnware itself has done something dodgy to raise an SError, I'm not
> sure there's much we can do about that...
>

Thank you for checking!

In the meanwhile, the last test job completed and passed as well.
Let me know if you'd like more test runs or if there's anything
else I can help with.

Veronika

> Robin.
>

