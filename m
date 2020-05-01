Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854481C17D9
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 16:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgEAOfm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 10:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbgEAOfm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 10:35:42 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668B620708
        for <linux-acpi@vger.kernel.org>; Fri,  1 May 2020 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588343741;
        bh=6NUvGuaTDSMVj4qz+KBxnE+JAksZFk4f6Iv9jSnlUZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TlDdEKxxlD8jm4XUhfjKoUh2mceH5p2OcQJzY49/D0HtRUhSsGZMV85QBDPYhWvjE
         qqJVf0PQk7IV+wf7PIBWcydPBOBdFyoV1l1VLfizlP7rjRxuSwu23tsSvBo5Lu1R8M
         5w2I4O1lJlvVksPQJvIYC9FXeyazaZZchCmd4DK0=
Received: by mail-io1-f45.google.com with SMTP id b12so5030842ion.8
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2020 07:35:41 -0700 (PDT)
X-Gm-Message-State: AGi0PuZqAt2xmL/4qonmjpK3b/MMW0Ln8H0CUUTkY7cHAxCqh4w2d5hY
        7COYYQqYbuQAZcbmH2OyJci3rWvgY2ICqiQSk6c=
X-Google-Smtp-Source: APiQypLwhBDEmnaMcXebnspgXs7BXbv7TduzzmXypCOd0BLkDs+9E9QeSlW3gfYhkiPvIZWsbTJNJ+l+urnlvWQtt10=
X-Received: by 2002:a5d:8045:: with SMTP id b5mr4065467ior.16.1588343740813;
 Fri, 01 May 2020 07:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200501095843.25401-1-ardb@kernel.org> <20200501095843.25401-3-ardb@kernel.org>
 <e3c7bdab-a2b0-d7c9-5c7b-eee680509338@arm.com> <CAMj1kXH0mcK3N94=uOuiL2_iy=eWhsnoXhvfiXv_kQ_j=F2a_Q@mail.gmail.com>
 <18e01ac7-974e-8308-c18c-67aa3fd7ad4e@arm.com> <CAMj1kXHsXEmaLuVBo7cgdzHju22WKksu7s3B3-hBE4mYhnuJ=Q@mail.gmail.com>
 <20200501134956.GA7240@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200501134956.GA7240@e121166-lin.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 1 May 2020 16:35:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGL-P_jNprTZSpLyEMMmHCcPq5-LcZeaRj5NtCeUKaJUA@mail.gmail.com>
Message-ID: <CAMj1kXGL-P_jNprTZSpLyEMMmHCcPq5-LcZeaRj5NtCeUKaJUA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] ACPI/IORT: work around num_ids ambiguity
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 1 May 2020 at 15:50, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, May 01, 2020 at 03:10:59PM +0200, Ard Biesheuvel wrote:
>
> [...]
>
> > > >> If we silently fix things up, then people will continue to write broken
> > > >> tables without even realising, new OSes will have to implement the same
> > > >> mechanism because vendors will have little interest in changing things
> > > >> that have worked "correctly" with Linux for years, and we've effectively
> > > >> achieved a de-facto redefinition of the spec. Making our end of the
> > > >> interface robust is obviously desirable, but there still needs to be
> > > >> *some* incentive for the folks on the other end to get it right.
> > > >>
> > > >
> > > > Agreed. But at least we'll be able to detect it and flag it in the
> > > > general case, rather than having a special case for D05/06 only
> > > > (although I suppose splitting the output ranges like those platforms
> > > > do is rather unusual)
> > >
> > > Yup, in principle the fixed quirk list gives a nice reassuring sense of
> > > "we'll work around these early platforms and everyone from now on will
> > > get it right", but whether reality plays out that way is another matter
> > > entirely...
> >
> > The reason I am looking into this is that I think the fix should go to
> > stable, given that the current situation makes it impossible to write
> > firmware that works with older and newer kernels.
>
> Yes. If we do remove the quirk the sooner we do it the better to
> reduce the stable patches.
>
> > Lorenzo said he wouldn't mind taking the current version with ACPI OEM
> > ID matching back to -stable, but it's another quirk list to manage,
> > which I would prefer to avoid.
> >
> > But I don't care deeply either way, to be honest, as long as we can
> > get something backported so compliant firmware is not being penalized
> > anymore.
>
> Question: if we remove the iort_workaround_oem_info stuff but we *do*
> keep the existing apply_id_count_workaround flag and we set it by going
> through all the mappings at boot time and detect if any of these
> off-by-one conditions apply - would the resulting code be any simpler ?
>
> The global flag would apply (as it does now) to _all_ mappings but it is
> very likely that if the off-by-one firmware bug is present it applies to
> the IORT table as a whole rather than a single mapping entry.
>

This particular issue is based on a misinterpretation, so I agree that
it makes sense to have a global flag, as long as we only set it if the
mappings are fully consistent in every other respect, or we'll run the
risk of hitting issues like the one Robin describes, where things
happen to work, but will fail once we apply the heuristic. Such an
issue could exist on one end of the table, while we could spot the
off-by-one issue somewhere else.

Which brings us back to a point I made earlier: do we really want to
validate the table and ensure that it is fully internally consistent?
Or do we want to be robust in the face of a single known issue that we
helped create?

So in my opinion, just fixing it up when we run into it is fine. I can
add the extra sanity check to reduce the potential fallout for other
broken systems, but beyond that, I think we shouldn't do too much.
