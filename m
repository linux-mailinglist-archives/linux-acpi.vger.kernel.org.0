Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1221DDE8
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 18:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgGMQzC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgGMQzC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2020 12:55:02 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC32C061794
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 09:55:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so14266966edz.12
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgOXhDZaQ0Vm8QAO9SEojO+HqYa4R2CkQWkXTg5E7NY=;
        b=gtc+M+tWYcQvh1sK797pkjo7WfNXIE8olCSzxehn9iEfDXPy4UnYyp2+rSeemkOHd9
         3YCD1bGiwRH6cQssBiZxingdGDUwZDouqVsreN1+gJuIGG6p5wdMSWJUxTsfZgJsaSP/
         EKUruPSgSi5imDehnJ0OoKNYarRo4grmHiicSB3YKJASTXyGDOGVaFs1Xtu7/0rRGn5l
         W9+vrC+x0eOE026JlZDzAPRS9I7c7ZrINzB0baTS0Fv4LSjRTfPGrURIPHkOUcVtnaEy
         84Ykd5bPtW/7cJhsDtttHYS1i4aFielTGd+j2sm60fnPvc5Fai51ccDG/VbXOrStWecV
         ncaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgOXhDZaQ0Vm8QAO9SEojO+HqYa4R2CkQWkXTg5E7NY=;
        b=twukl4+0cjLmvmAC0mHxPA2a1xUC6pYoDX2jGovP2JKdYq6lqzlzWKm5DT/9ryBoso
         I0lqzGLIzmU+4oHVED2yrg5N+sdviLDdJxFliPgHlo/njuAnnZtUZ9yGXC5MeQY6Dw1j
         M6+8mMo2RX1qd5Yojf7NhUsbz36mB6nSicn/ktvIxLGVMq1+QjnQgjrfNVSPm6kgjfY1
         8VVsdNg9ABVxgVV9K6y44Xtwkce197zgl56PeTTn59qL0QW5W27xOTeJ18YdMv1hiqZb
         H0J9j8GZ3MqT+kUa4IYmSkdVwVS7r+WW8tS2Wj/CR7KX54SG4g7HRMJjSZvgej0fo8t0
         VAIw==
X-Gm-Message-State: AOAM5318lz9PYAid48ICTWBynxXGbklc55eqYeBmO04C+SM7a/RBS7Vr
        HQgJi4/PWnELTsHYeXIDaSd6mhAVhwxEJByyv/fO5Q==
X-Google-Smtp-Source: ABdhPJy2i/ttAyiKjR1qbX0QvV/QhWFNtJPFDiAHrxVvIXYFYUkb5Tgr0e/mIqA9cSxtejueFDTinGXoBIyHGcdsgj8=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr299675edj.93.1594659300586;
 Mon, 13 Jul 2020 09:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457126779.754248.3575056680831729751.stgit@dwillia2-desk3.amr.corp.intel.com>
 <52e00a67-b686-8554-8b92-a172ba9f34b6@nvidia.com>
In-Reply-To: <52e00a67-b686-8554-8b92-a172ba9f34b6@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 09:54:49 -0700
Message-ID: <CAPcyv4gQpAjkQ2j9D0pU-0UrmJzf9eLqtFsmqd8v5=+kyR3ZSg@mail.gmail.com>
Subject: Re: [PATCH v2 19/22] mm/memremap_pages: Convert to 'struct range'
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 13, 2020 at 9:36 AM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
>
> On 7/12/20 9:27 AM, Dan Williams wrote:
> > The 'struct resource' in 'struct dev_pagemap' is only used for holding
> > resource span information. The other fields, 'name', 'flags', 'desc',
> > 'parent', 'sibling', and 'child' are all unused wasted space.
> >
> > This is in preparation for introducing a multi-range extension of
> > devm_memremap_pages().
> >
> > The bulk of this change is unwinding all the places internal to
> > libnvdimm that used 'struct resource' unnecessarily.
> >
> > P2PDMA had a minor usage of the flags field, but only to report failures
> > with "%pR". That is replaced with an open coded print of the range.
> >
> > Cc: Paul Mackerras <paulus@ozlabs.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   arch/powerpc/kvm/book3s_hv_uvmem.c     |   13 +++--
> >   drivers/dax/bus.c                      |   10 ++--
> >   drivers/dax/bus.h                      |    2 -
> >   drivers/dax/dax-private.h              |    5 --
> >   drivers/dax/device.c                   |    3 -
> >   drivers/dax/hmem/hmem.c                |    5 ++
> >   drivers/dax/pmem/core.c                |   12 ++---
> >   drivers/gpu/drm/nouveau/nouveau_dmem.c |    3 +
> >   drivers/nvdimm/badrange.c              |   26 +++++------
> >   drivers/nvdimm/claim.c                 |   13 +++--
> >   drivers/nvdimm/nd.h                    |    3 +
> >   drivers/nvdimm/pfn_devs.c              |   12 ++---
> >   drivers/nvdimm/pmem.c                  |   26 ++++++-----
> >   drivers/nvdimm/region.c                |   21 +++++----
> >   drivers/pci/p2pdma.c                   |   11 ++---
> >   include/linux/memremap.h               |    5 +-
> >   include/linux/range.h                  |    6 ++
> >   mm/memremap.c                          |   77 ++++++++++++++++----------------
> >   tools/testing/nvdimm/test/iomap.c      |    2 -
> >   19 files changed, 135 insertions(+), 120 deletions(-)
>
> I think you are missing a call to memremap_pages() in lib/test_hmm.c
> and a call to release_mem_region() that need to be converted too.
> Try setting CONFIG_TEST_HMM=m.

Thanks Ralph, looks like I overlooked these changes since the rebase.

> Also, what about the call to release_mem_region() in
> drivers/gpu/drm/nouveau/nouveau_dmem.c? Doesn't that need a small change too?

I'll double check my config, that one should have been flagged at build time.
