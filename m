Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96C81C1198
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgEALlz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 07:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgEALlz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 07:41:55 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98952208D6
        for <linux-acpi@vger.kernel.org>; Fri,  1 May 2020 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588333314;
        bh=iyLwoYzqmoKLuEytZE1afP8dkuOh3XFkCBz6I0dOsMI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FB7eqTmnke6VgcfaR9T4TBEDImOEy9LnaWkX3YVc2FLoO8Hi4JNfQ/J/Sx84NbXNP
         2P641zPNDRuRHB7YdkZK7sEPk15mlENrcv9MWtKfJiq8uwVSo7E2mtgKP1ns8j80/3
         Z1of9BFke7EJg4yJU27LMrDfKLvzF5PSGzVaZny8=
Received: by mail-il1-f178.google.com with SMTP id c18so4218646ile.5
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2020 04:41:54 -0700 (PDT)
X-Gm-Message-State: AGi0PuYetfTg9KWJG32g5fRfkjNKsR2hHZ4NBXD55lGO3YTa1f/inLTR
        B/SzPtDKjjr72SLelFoz0MWG7lg3eKJ4aAqmazs=
X-Google-Smtp-Source: APiQypKG0QW/F6jnGvP1ldxrRV/5E4ksJZa7kuC9HAnyfRg7KpQCPAmg3NPoYThwdogYXMGTbc6Yl9Ur0mrJ23KNfqU=
X-Received: by 2002:a92:39dd:: with SMTP id h90mr3184152ilf.80.1588333313911;
 Fri, 01 May 2020 04:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200501095843.25401-1-ardb@kernel.org> <20200501095843.25401-3-ardb@kernel.org>
 <e3c7bdab-a2b0-d7c9-5c7b-eee680509338@arm.com>
In-Reply-To: <e3c7bdab-a2b0-d7c9-5c7b-eee680509338@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 1 May 2020 13:41:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH0mcK3N94=uOuiL2_iy=eWhsnoXhvfiXv_kQ_j=F2a_Q@mail.gmail.com>
Message-ID: <CAMj1kXH0mcK3N94=uOuiL2_iy=eWhsnoXhvfiXv_kQ_j=F2a_Q@mail.gmail.com>
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

On Fri, 1 May 2020 at 12:55, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-05-01 10:58 am, Ard Biesheuvel wrote:
> > The ID mapping table structure of the IORT table describes the size of
> > a range using a num_ids field carrying the number of IDs in the region
> > minus one. This has been misinterpreted in the past in the parsing code,
> > and firmware is known to have shipped where this results in an ambiguity,
> > where regions that should be adjacent have an overlap of one value.
> >
> > So let's work around this by detecting this case specifically: when
> > resolving an ID translation, allow one that matches right at the end of
> > a multi-ID region to be superseded by a subsequent one.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   drivers/acpi/arm64/iort.c | 23 +++++++++++++++-----
> >   1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 98be18266a73..d826dd9dc4c5 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -316,10 +316,19 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> >       }
> >
> >       if (rid_in < map->input_base ||
> > -         (rid_in >= map->input_base + map->id_count))
> > +         (rid_in > map->input_base + map->id_count))
> >               return -ENXIO;
> >
> >       *rid_out = map->output_base + (rid_in - map->input_base);
> > +
> > +     /*
> > +      * Due to confusion regarding the meaning of the id_count field (which
> > +      * carries the number of IDs *minus 1*), we may have to disregard this
> > +      * match if it is at the end of the range, and overlaps with the start
> > +      * of another one.
> > +      */
> > +     if (map->id_count > 0 && rid_in == map->input_base + map->id_count)
> > +             return -EAGAIN;
> >       return 0;
> >   }
> >
> > @@ -404,7 +413,8 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
> >       /* Parse the ID mapping tree to find specified node type */
> >       while (node) {
> >               struct acpi_iort_id_mapping *map;
> > -             int i, index;
> > +             int i, index, rc = 0;
> > +             u32 out_ref = 0, map_id = id;
> >
> >               if (IORT_TYPE_MASK(node->type) & type_mask) {
> >                       if (id_out)
> > @@ -438,15 +448,18 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
> >                       if (i == index)
> >                               continue;
> >
> > -                     if (!iort_id_map(map, node->type, id, &id))
> > +                     rc = iort_id_map(map, node->type, map_id, &id);
> > +                     if (!rc)
> >                               break;
>
> This needs a big FW_BUG splat in the case where it did find an overlap.

Sure, although we did help create the problem in the first place.

> Ideally we'd also enforce that the other half of must be the first entry
> of another range, but perhaps we're into diminishing returns by that point.
>

That would mean the regions overlap regardless of whether you
interpret num_ids correctly or not, which means we'll be doing
validation of general well-formedness of the table rather than
providing a workaround for this particular issue.

I think the fact that we got it wrong initially justifies treating the
off-by-one case specially, but beyond that, we should make it robust
without being pedantic imo.

> If we silently fix things up, then people will continue to write broken
> tables without even realising, new OSes will have to implement the same
> mechanism because vendors will have little interest in changing things
> that have worked "correctly" with Linux for years, and we've effectively
> achieved a de-facto redefinition of the spec. Making our end of the
> interface robust is obviously desirable, but there still needs to be
> *some* incentive for the folks on the other end to get it right.
>

Agreed. But at least we'll be able to detect it and flag it in the
general case, rather than having a special case for D05/06 only
(although I suppose splitting the output ranges like those platforms
do is rather unusual)
