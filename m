Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90DCFB5B5
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 17:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfKMQw6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 11:52:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43649 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfKMQw6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2019 11:52:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id l14so2200337oti.10
        for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2019 08:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVs75VZBcY9S0Y5srgopU4beZRbRSaSe1fH2IBEEzVk=;
        b=ssIxIeeIslCiIJXffnM/puPFNeNmqyOWWUWtDbvqe4d/BOtTR/zgDVzI5AzNkOXmek
         d5nc5yKCwdpjNhJbj9X5bsPU3H+lpjXv+S41FpkAjafu/1ILKgYSNIw2YJGDDibDOGDm
         iTXa5j1XEcQEaGqtyExlnhGu7ZABwiMrrBp/NEh42TS5RELZjjcY2rG8aq+EO8xPu0/7
         YjBvENhMkWS/hqSYnuOJuNFQgWDohADDi8v8UzWFS7ovBAkCbFzxXr5d9EYLgL/55pis
         97SdNjAs5pm7As0sJuK/MBKxP83CWf52Z8Zcsl/4mp4LBamQZO7kYC3mpyycgVGUjrX5
         B1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVs75VZBcY9S0Y5srgopU4beZRbRSaSe1fH2IBEEzVk=;
        b=bbCrpRura6FOs3/QWTvwK+keXL/J0n0ENCwKadKPkzFEQ5qXKqzlaIKvwBsbp0l82R
         mP9VgCUeP4o9C46cYZulyeECLrn/uov3BtRWESKt1HQL67M9Wx1ch29bqgraB2xddUCZ
         cG7pSWpW1iLILAOJ8fkfqjpomQZTwUFczoQsXvCvdWoetJdQD0EWObWSNFZ4RRtZBX7X
         sMV/Y7tc5fRg4ay32/g+szpVegedxQfC6y00sWfdhs6vqfASXuObvTjAEEwol0qm5IfW
         f+gAMlvIwS5cfOIqu3oOeAhw1xsQnObN9clXMQbTJnmmdsI7JKofWGFxPaeNWT2xJR49
         bkyw==
X-Gm-Message-State: APjAAAWTfKhcbZgg1elwNSHG2//2OXtkTUQN9hphk3/qc3LOxB0Pr1lL
        Fh459dR0mc3gXqKiIqb43Zoqs95Ho9QVRFIPeyxO8w==
X-Google-Smtp-Source: APXvYqzqgVb0Dn3nghpgE0JOdTaxD1sSLXcYeBJ5SaBwI3JLusskqPp89fKtEBxxBB3bkmRTm/7hKGIUPIpcjOs3bko=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr4241297otg.363.1573663976870;
 Wed, 13 Nov 2019 08:52:56 -0800 (PST)
MIME-Version: 1.0
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
 <20191004114330.104746-2-Jonathan.Cameron@huawei.com> <CAPcyv4jZG-5s6NsS-_-oNG45y0Qb1mVD_s8cCGqLYtzvHqEo+Q@mail.gmail.com>
 <20191113094742.00000dc4@huawei.com> <77b6a6e8-9d44-1e1c-3bf0-a8d04833598d@intel.com>
In-Reply-To: <77b6a6e8-9d44-1e1c-3bf0-a8d04833598d@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Nov 2019 08:52:46 -0800
Message-ID: <CAPcyv4i=Kkycy3YtU7FS-qG02CFjAQTcN7UaGjbKwDnNHDZCEA@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
To:     Tao Xu <tao3.xu@intel.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, Keith Busch <keith.busch@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linuxarm <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 13, 2019 at 5:57 AM Tao Xu <tao3.xu@intel.com> wrote:
>
> On 11/13/2019 5:47 PM, Jonathan Cameron wrote:
> > On Tue, 12 Nov 2019 09:55:17 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >> [ add Tao Xu ]
> >>
> >> On Fri, Oct 4, 2019 at 4:45 AM Jonathan Cameron
> >> <Jonathan.Cameron@huawei.com> wrote:
> >>>
> >>> Generic Initiators are a new ACPI concept that allows for the
> >>> description of proximity domains that contain a device which
> >>> performs memory access (such as a network card) but neither
> >>> host CPU nor Memory.
> >>>
> >>> This patch has the parsing code and provides the infrastructure
> >>> for an architecture to associate these new domains with their
> >>> nearest memory processing node.
> >>
> >> Thanks for this Jonathan. May I ask how this was tested? Tao has been
> >> working on qemu support for HMAT [1]. I have not checked if it already
> >> supports generic initiator entries, but it would be helpful to include
> >> an example of how the kernel sees these configurations in practice.
> >>
> >> [1]: http://patchwork.ozlabs.org/cover/1096737/
> >
> > Tested against qemu with SRAT and SLIT table overrides from an
> > initrd to actually create the node and give it distances
> > (those all turn up correctly in the normal places).  DSDT override
> > used to move an emulated network card into the GI numa node.  That
> > currently requires the PCI patch referred to in the cover letter.
> > On arm64 tested both on qemu and real hardware (overrides on tables
> > even for real hardware as I can't persuade our BIOS team to implement
> > Generic Initiators until an OS is actually using them.)
> >
> > Main real requirement is memory allocations then occur from one of
> > the nodes at the minimal distance when you are do a devm_ allocation
> > from a device assigned. Also need to be able to query the distances
> > to allow load balancing etc.  All that works as expected.
> >
> > It only has a fairly tangential connection to HMAT in that HMAT
> > can provide information on GI nodes.  Given HMAT code is quite happy
> > with memoryless nodes anyway it should work.  QEMU doesn't currently
> > have support to create GI SRAT entries let alone HMAT using them.
> >
> > Whilst I could look at adding such support to QEMU, it's not
> > exactly high priority to emulate something we can test easily
> > by overriding the tables before the kernel reads them.
> >
> > I'll look at how hard it is to build an HMAT tables for my test
> > configs based on the ones I used to test your HMAT patches a while
> > back.  Should be easy if tedious.
> >
> > Jonathan
> >
> Indeed, HMAT can support Generic Initiator, but as far as I know, QEMU
> only can emulate a node with cpu and memory, or memory-only. Even if we
> assign a node with cpu only, qemu will raise error. Considering
> compatibility, there are lots of work to do for QEMU if we change NUMA
> or SRAT table.

Thanks for the background. It would still be a useful feature to be
able to define a memory + generic-initiator node in qemu. That will
mirror real world accelerators with local memory configurations.
