Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEC0274DF3
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Sep 2020 02:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgIWAnP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Sep 2020 20:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgIWAnO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Sep 2020 20:43:14 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037AC0613D0
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2020 17:43:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so18025939edq.6
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2020 17:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63NW9gk7HRpDHGoorZLXSxJtBEzJkCrOurZGFYdeq1s=;
        b=QEiJCmMJ+abH4jXWF874MeS11eIiKXKE3h+n39sqAGLPIycrn0MxhLfS6Wo+aHjo6o
         BgjErpz4dkHZ481e5ATkWq93dIaYf6zudSHfhcDNkoV5W8p3tDbaqO0s4spGS+JLBOVL
         xn4KEw0MJ1HUUzUo1qdlmI3HLQin57sr4yXqNNwLYhvbPhHVBqnKcLDYDRBfUSirJosj
         6VaWUYcV9FK1rBmUDtcRLgsOTXJ8dZ55TiXMjedniQ+O9jvUR4qfgY1xDTm4+TC3Ugui
         fAgPDzIRGT2lufyhiDkf+4OuUSwYygqW1DEk06diJYWny7csi55q33hB6fNRubbxlgJ1
         Vk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63NW9gk7HRpDHGoorZLXSxJtBEzJkCrOurZGFYdeq1s=;
        b=JI9HQ9jRc/LXehmu45D3lPg/S25YDKlnU6kfcfOThkqAQO+jpOnMxFD6NqqAy4MQpv
         EOG7XugA6Vp4jC5HMs6CvGLdBDikFRsl1PVyHAuqz/Njirc4vhyjRFh2kqaAmeNqLez6
         IGKSNwebLYc2SjNxk5pSqnFF/UtmtpzFDakbq7QGpBfI20N8b90vH67aDBONSv/9PpTV
         RSuMPuFgflFskHTLVE/086iF086rHBt4oKZLBfgI5l3bc+Phnze/F83vutrrG0Z09JCD
         ibgcEVMa+nOIuBHjix2p6btlAZTNwqJ7zfvW6lWyA7/aEQOUmuqJyO4ouSV59Qso1fWf
         wg2g==
X-Gm-Message-State: AOAM5311nddQfADI2jTWOJ+9o5bFocz6NaoFr73eDoW75lZGmQoeBAqO
        jx6QUysaJraztTY76m4ygjcH+QaV7vX1/ymEgthFOA==
X-Google-Smtp-Source: ABdhPJxEyMjaWBOlTNqZq+aOqsUhRrRJuhmMZTQc6iiISsny0Ld0R8ZOQAu5Co8gVaeeYbMO5GjUCtpLRRG7qTwcHRY=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr7090354edq.300.1600821793001;
 Tue, 22 Sep 2020 17:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com> <CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
 <20200821162134.97d551c6fe45b489992841a8@linux-foundation.org> <7d51834a-9544-b2e8-bfba-1c3e2da0e470@redhat.com>
In-Reply-To: <7d51834a-9544-b2e8-bfba-1c3e2da0e470@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 22 Sep 2020 17:43:01 -0700
Message-ID: <CAPcyv4gfBj66Dwy0yn2CX=cCT=yqR9wHE2gY1Q5_Nq2vnh0zPg@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jeff Moyer <jmoyer@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 8, 2020 at 3:46 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.08.20 01:21, Andrew Morton wrote:
> > On Wed, 19 Aug 2020 18:53:57 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >>> I think I am missing some important pieces. Bear with me.
> >>
> >> No worries, also bear with me, I'm going to be offline intermittently
> >> until at least mid-September. Hopefully Joao and/or Vishal can jump in
> >> on this discussion.
> >
> > Ordinarily I'd prefer a refresh&resend for 2+ week-old series such as
> > this.
> >
> > But given that v4 all applies OK and that Dan has pending outages, I'll
> > scoop up this version, even though at least one change has been suggested.
> >
>
> Should I try to fix patch #11 while Dan is away? Because I think at
> least two things in there are wrong (and it would have been better to
> split that patch into reviewable pieces).

Hey David,

Back now, I'll take a look. I didn't immediately see a way to
meaningfully break up that patch without some dead-code steps in the
conversion, but I'll take another run at it.
