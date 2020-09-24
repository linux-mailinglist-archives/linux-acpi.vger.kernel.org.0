Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E929F277B41
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 23:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIXVuQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 17:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgIXVuQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 17:50:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03246C0613D3
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2020 14:50:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n22so445126edt.4
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2020 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VhJeuoj+rOPSJ4IEGV+fYVhmYT10xm972NsSejdMkBg=;
        b=mpx4PkaUmFFwA1xtz/GJ0EVr677LvVWAywlSsSBXx0ShG6AZt57DEjUoyvLg2RGr7Z
         XcGgHUDzZZ6KrvKq3epkk490qeNIFUZ7WVyzH3k2hV1MN72qalnnNSh1ZNSDRi2MLtBr
         E72zTYmp0vKyrWmKXZxOsV3KnQVii0Sr3ANFsR+bCuFKdWlMgcIpCImgEkZKy8/R+I2s
         sqwBTgWf3Vh9dt4g2rUdVd4/T2tJRyZNBbd2wGucpyMBqUgIUxJmtMstfGcJI553/ICm
         BHqlmsbvM2Oar8F97gSEIPFqlW9TLbnrBzxk9NNJIwT7vjE1gUjc8bXNcqREFCuIjxEE
         vIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VhJeuoj+rOPSJ4IEGV+fYVhmYT10xm972NsSejdMkBg=;
        b=oqp58D0C/r25FhfZ+i6T1CtdSpVfwRe/qWPddZAbGHgtv2xCx4ysonVR8zuNXORs0u
         mODoA2K/cPcOQqLVGkLBYKYISj57F73P2Tw8WzazllRi78Ov7IhuH/dA4Cc63EwgnmfZ
         qfCSG2AynGL/CAYAWAjpTKDr4URyWdb100RIFPUNPUI3mJwFFOcdSsYTFUq+BdtnQ9qv
         6bheqLJTwfggzWnJkQ8P1+DaZvTOqjuB920a+0xLyIwNe0R3AQnoHXpFeD3LU3g20QLI
         urCWEzcIbVyb9HgCxZlyGQV6XrFlE62usCn++lqsN5eIcYWcNRAiewRxwJ9dCnmx4e9M
         ENcg==
X-Gm-Message-State: AOAM532l6iVnzZlikxPWXqHX/MtN1hGnyAi0HqNxgl5OXloRzDsNnwe6
        sLreV5wN3RGkLv9PQ8vg74PwGEBDbQJIf9Qmg7elsw==
X-Google-Smtp-Source: ABdhPJwxLNwMbKBfN2GZNfdh2odn88qLZ8Gba3MAPoetXp02KpOblT44U8/Ptt6lHHhBfbX75bgCKW+Q3RCxXi3Ppoc=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr884128edq.300.1600984214693;
 Thu, 24 Sep 2020 14:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4iQ4VnXMU0+_7rfXwPowgcdoABSFUH4WO_3P9vHtWAzPg@mail.gmail.com>
 <79BEC711-C769-432B-9A50-63C6A3AEB0E3@redhat.com>
In-Reply-To: <79BEC711-C769-432B-9A50-63C6A3AEB0E3@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 24 Sep 2020 14:50:03 -0700
Message-ID: <CAPcyv4jsUiXTqDtnh_fnm_p4NaX2=c3rrjFe6Efa-oWPkTe-fA@mail.gmail.com>
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
To:     David Hildenbrand <david@redhat.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 24, 2020 at 2:42 PM David Hildenbrand <david@redhat.com> wrote:
>
>
>
> > Am 24.09.2020 um 23:26 schrieb Dan Williams <dan.j.williams@intel.com>:
> >
> > =EF=BB=BF[..]
> >>> I'm not suggesting to busy the whole "virtio" range, just the portion
> >>> that's about to be passed to add_memory_driver_managed().
> >>
> >> I'm afraid I don't get your point. For virtio-mem:
> >>
> >> Before:
> >>
> >> 1. Create virtio0 container resource
> >>
> >> 2. (somewhen in the future) add_memory_driver_managed()
> >> - Create resource (System RAM (virtio_mem)), marking it busy/driver
> >>   managed
> >>
> >> After:
> >>
> >> 1. Create virtio0 container resource
> >>
> >> 2. (somewhen in the future) Create resource (System RAM (virtio_mem)),
> >>   marking it busy/driver managed
> >> 3. add_memory_driver_managed()
> >>
> >> Not helpful or simpler IMHO.
> >
> > The concern I'm trying to address is the theoretical race window and
> > layering violation in this sequence in the kmem driver:
> >
> > 1/ res =3D request_mem_region(...);
> > 2/ res->flags =3D IORESOURCE_MEM;
> > 3/ add_memory_driver_managed();
> >
> > Between 2/ and 3/ something can race and think that it owns the
> > region. Do I think it will happen in practice, no, but it's still a
> > pattern that deserves come cleanup.
>
> I think in that unlikely event (rather impossible), add_memory_driver_man=
aged() should fail, detecting a conflicting (busy) resource. Not sure what =
will happen next ( and did not double-check).

add_memory_driver_managed() will fail, but the release_mem_region() in
kmem to unwind on the error path will do the wrong thing because that
other driver thinks it got ownership of the region.

> But yeah, the way the BUSY bit is cleared here is wrong - simply overwrit=
ing other bits. And it would be even better if we could avoid manually mess=
ing with flags here.

I'm ok to leave it alone for now (hasn't been and likely never will be
a problem in practice), but I think it was still worth grumbling
about. I'll leave that part of kmem alone in the upcoming split of
dax_kmem_res removal.
