Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0EE1C33B9
	for <lists+linux-acpi@lfdr.de>; Mon,  4 May 2020 09:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEDHhI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 03:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgEDHhH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 03:37:07 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5A321835
        for <linux-acpi@vger.kernel.org>; Mon,  4 May 2020 07:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588577827;
        bh=t8IlpBfd5v4b7aMW8w5EYYQ13kNx8+iPpKqLXfYgEX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WrYuWPdBY8fvLD5rbLiGy0wH80w2hjNz3+iAC/SbnwB5lZ9YIx3OOJsW3aF69ek7B
         wKQr1XQtN3+eGQ9VDcOHZzZpyX2dOFiu4lDdjrF/hM6fozqiGbnVYwwrfP4q+jBMrL
         mB1tg9Cq801T8u7SgEvoOwMFYN4dQ39Bw4298jnA=
Received: by mail-il1-f181.google.com with SMTP id i16so10325177ils.12
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2020 00:37:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuZaZ/4qpXvezpbANI8am0rSNXylC2OZKUCaExa7Sl1GaRyjKjQr
        vPk6AWWRxscbYa/E61IInmR/5H1rOyPwm3dryoo=
X-Google-Smtp-Source: APiQypKNPYX7ad+kctS/AbY8KuKLDocsFDox+qQJT05gRIgyhoBoUx71Nx7bevStf4WtJv25L/UBUkyl2JKmOvnuE44=
X-Received: by 2002:a92:3c55:: with SMTP id j82mr15500599ila.258.1588577826285;
 Mon, 04 May 2020 00:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200501161014.5935-1-ardb@kernel.org> <20200501161014.5935-3-ardb@kernel.org>
 <bbd56b89-643a-2f86-79af-f65ef46822ef@huawei.com>
In-Reply-To: <bbd56b89-643a-2f86-79af-f65ef46822ef@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 4 May 2020 09:36:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEuV_Lmhu-2zZhD-YgL-zu+o0v+vooQTK30cemJW5dfNg@mail.gmail.com>
Message-ID: <CAMj1kXEuV_Lmhu-2zZhD-YgL-zu+o0v+vooQTK30cemJW5dfNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI/IORT: work around num_ids ambiguity
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 4 May 2020 at 06:32, Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2020/5/2 0:10, Ard Biesheuvel wrote:
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
> > To prevent potential regressions on broken firmware that happened to
> > work before, only take the subsequent match into account if it occurs
> > at the start of a mapping region.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   drivers/acpi/arm64/iort.c | 40 +++++++++++++++++---
> >   1 file changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 98be18266a73..9f139a94a1d3 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -300,7 +300,7 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
> >   }
> >
> >   static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> > -                    u32 *rid_out)
> > +                    u32 *rid_out, bool check_overlap)
> >   {
> >       /* Single mapping does not care for input id */
> >       if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> > @@ -316,10 +316,34 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> >       }
> >
> >       if (rid_in < map->input_base ||
> > -         (rid_in >= map->input_base + map->id_count))
> > +         (rid_in > map->input_base + map->id_count))
> >               return -ENXIO;
> >
> > +     if (check_overlap) {
> > +             /*
> > +              * We already found a mapping for this input ID at the end of
> > +              * another region. If it coincides with the start of this
> > +              * region, we assume the prior match was due to the off-by-1
> > +              * issue mentioned below, and allow it to be superseded.
> > +              * Otherwise, things are *really* broken, and we just disregard
> > +              * duplicate matches entirely to retain compatibility.
> > +              */
> > +             pr_err(FW_BUG "[map %p] conflicting mapping for input ID 0x%x\n",
> > +                    map, rid_in);
>
> As we already applied a workaround here, can we add "applying
> workaround" in the error message? This will make the customers
> less uneasy to see such message in the boot log. Once the product
> was deliveried to customers, it's not that easy to update all the
> firmwares entirely.
>

Sure.

> I'm out of reach for D05/D06 hardware as it's holidays in China,
> please allow me to test this patch set in Wednesday this week.
>

Yes please
