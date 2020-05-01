Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0CF1C12A0
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 15:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgEANLM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 09:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728765AbgEANLM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 09:11:12 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7165A208C3
        for <linux-acpi@vger.kernel.org>; Fri,  1 May 2020 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588338671;
        bh=b3tQcd8Yq0ftAgc0rDhPFa6ynGleLes13N9ftbLQhXk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eK1Tsyduvv4rT6xH5SBsC9+8FxfNMW609PhiAfclV3D5LZ/o1vGmHPFaZzGxvv+RL
         WFM2vlKRmOC2ePxf0SsWdi2lu4okDSJyc6ZWXEuwQuHm9zslfSlVgzkSjK9/IumFZ/
         SErJ17ST8xH0ogHpFqRk3l3hyLmAoyJftYeAERVc=
Received: by mail-io1-f42.google.com with SMTP id j8so571555iog.13
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2020 06:11:11 -0700 (PDT)
X-Gm-Message-State: AGi0Pubn03nV+LWNSTsXjx/fsjjavjTBsuf4W/Xsm8508fnsMTbm2pjJ
        EbfTiur6cEvc6vR/eKJg7+I0IJjP7JXITnNr9cc=
X-Google-Smtp-Source: APiQypK3rxCjfL8TPcuz/WQvZAqAlEAiikwycwu/C6Qi6KOo8ImoF6d4IfACWGj2JJoNDG02sfGVORvKlhwA1Y7LDvc=
X-Received: by 2002:a5d:9b8a:: with SMTP id r10mr3665941iom.171.1588338670673;
 Fri, 01 May 2020 06:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200501095843.25401-1-ardb@kernel.org> <20200501095843.25401-3-ardb@kernel.org>
 <e3c7bdab-a2b0-d7c9-5c7b-eee680509338@arm.com> <CAMj1kXH0mcK3N94=uOuiL2_iy=eWhsnoXhvfiXv_kQ_j=F2a_Q@mail.gmail.com>
 <18e01ac7-974e-8308-c18c-67aa3fd7ad4e@arm.com>
In-Reply-To: <18e01ac7-974e-8308-c18c-67aa3fd7ad4e@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 1 May 2020 15:10:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHsXEmaLuVBo7cgdzHju22WKksu7s3B3-hBE4mYhnuJ=Q@mail.gmail.com>
Message-ID: <CAMj1kXHsXEmaLuVBo7cgdzHju22WKksu7s3B3-hBE4mYhnuJ=Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] ACPI/IORT: work around num_ids ambiguity
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 1 May 2020 at 14:31, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-05-01 12:41 pm, Ard Biesheuvel wrote:
> > On Fri, 1 May 2020 at 12:55, Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2020-05-01 10:58 am, Ard Biesheuvel wrote:
> >>> The ID mapping table structure of the IORT table describes the size of
> >>> a range using a num_ids field carrying the number of IDs in the region
> >>> minus one. This has been misinterpreted in the past in the parsing code,
> >>> and firmware is known to have shipped where this results in an ambiguity,
> >>> where regions that should be adjacent have an overlap of one value.
> >>>
> >>> So let's work around this by detecting this case specifically: when
> >>> resolving an ID translation, allow one that matches right at the end of
> >>> a multi-ID region to be superseded by a subsequent one.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> ---
> >>>    drivers/acpi/arm64/iort.c | 23 +++++++++++++++-----
> >>>    1 file changed, 18 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>> index 98be18266a73..d826dd9dc4c5 100644
> >>> --- a/drivers/acpi/arm64/iort.c
> >>> +++ b/drivers/acpi/arm64/iort.c
> >>> @@ -316,10 +316,19 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> >>>        }
> >>>
> >>>        if (rid_in < map->input_base ||
> >>> -         (rid_in >= map->input_base + map->id_count))
> >>> +         (rid_in > map->input_base + map->id_count))
> >>>                return -ENXIO;
> >>>
> >>>        *rid_out = map->output_base + (rid_in - map->input_base);
> >>> +
> >>> +     /*
> >>> +      * Due to confusion regarding the meaning of the id_count field (which
> >>> +      * carries the number of IDs *minus 1*), we may have to disregard this
> >>> +      * match if it is at the end of the range, and overlaps with the start
> >>> +      * of another one.
> >>> +      */
> >>> +     if (map->id_count > 0 && rid_in == map->input_base + map->id_count)
> >>> +             return -EAGAIN;
> >>>        return 0;
> >>>    }
> >>>
> >>> @@ -404,7 +413,8 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
> >>>        /* Parse the ID mapping tree to find specified node type */
> >>>        while (node) {
> >>>                struct acpi_iort_id_mapping *map;
> >>> -             int i, index;
> >>> +             int i, index, rc = 0;
> >>> +             u32 out_ref = 0, map_id = id;
> >>>
> >>>                if (IORT_TYPE_MASK(node->type) & type_mask) {
> >>>                        if (id_out)
> >>> @@ -438,15 +448,18 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
> >>>                        if (i == index)
> >>>                                continue;
> >>>
> >>> -                     if (!iort_id_map(map, node->type, id, &id))
> >>> +                     rc = iort_id_map(map, node->type, map_id, &id);
> >>> +                     if (!rc)
> >>>                                break;
> >>
> >> This needs a big FW_BUG splat in the case where it did find an overlap.
> >
> > Sure, although we did help create the problem in the first place.
> >
> >> Ideally we'd also enforce that the other half of must be the first entry
> >> of another range, but perhaps we're into diminishing returns by that point.
> >>
> >
> > That would mean the regions overlap regardless of whether you
> > interpret num_ids correctly or not, which means we'll be doing
> > validation of general well-formedness of the table rather than
> > providing a workaround for this particular issue.
>
> The point was to limit any change in behaviour to the specific case that
> we need to work around. Otherwise a table that was entirely malformed
> rather than just off-by-one on the sizes might go from happening-to-work
> to not working, or vice versa; the diminishing return is in how much we
> care about that.
>

I see. I think it is quite unlikely that a working system with
overlapping ID ranges would work, and suddenly fail horribly when the
exact point of overlap is shifted by 1. But yeah, I see your point.

> > I think the fact that we got it wrong initially justifies treating the
> > off-by-one case specially, but beyond that, we should make it robust
> > without being pedantic imo.
>
> As the #1 search engine hit for "Linux is not a firmware validation
> suite", I can reassure you that we're on the same page in that regard ;)
>

Good :-)

> >> If we silently fix things up, then people will continue to write broken
> >> tables without even realising, new OSes will have to implement the same
> >> mechanism because vendors will have little interest in changing things
> >> that have worked "correctly" with Linux for years, and we've effectively
> >> achieved a de-facto redefinition of the spec. Making our end of the
> >> interface robust is obviously desirable, but there still needs to be
> >> *some* incentive for the folks on the other end to get it right.
> >>
> >
> > Agreed. But at least we'll be able to detect it and flag it in the
> > general case, rather than having a special case for D05/06 only
> > (although I suppose splitting the output ranges like those platforms
> > do is rather unusual)
>
> Yup, in principle the fixed quirk list gives a nice reassuring sense of
> "we'll work around these early platforms and everyone from now on will
> get it right", but whether reality plays out that way is another matter
> entirely...

The reason I am looking into this is that I think the fix should go to
stable, given that the current situation makes it impossible to write
firmware that works with older and newer kernels.

Lorenzo said he wouldn't mind taking the current version with ACPI OEM
ID matching back to -stable, but it's another quirk list to manage,
which I would prefer to avoid.

But I don't care deeply either way, to be honest, as long as we can
get something backported so compliant firmware is not being penalized
anymore.
