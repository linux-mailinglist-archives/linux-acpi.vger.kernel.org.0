Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEF41C70F2
	for <lists+linux-acpi@lfdr.de>; Wed,  6 May 2020 14:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgEFMza (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 May 2020 08:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbgEFMzZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 May 2020 08:55:25 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2400E20769;
        Wed,  6 May 2020 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588769724;
        bh=hOEa8M2o2GKkO0H6+efDl9rCOdcYeheD//h24pzNdQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIRtzLVP863khnT7pZ+po91AuV7aLKyKLxF7+vpN69Uu0uYB06h5G/hVOf6cNA6tN
         O8ysp4ZIhy8zPojiBWvZYUzCDAJN2mX4oo1ZR1ZP2c7fwA9FjPHFpppi8FjXMKCl0J
         SF9HUCCh0ARwmuc6oMT6ZH2tMKvrY2xru4A+IZlY=
Date:   Wed, 6 May 2020 13:55:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/2] ACPI/IORT: work around num_ids ambiguity
Message-ID: <20200506125519.GI8043@willie-the-truck>
References: <20200501161014.5935-1-ardb@kernel.org>
 <20200501161014.5935-3-ardb@kernel.org>
 <bbd56b89-643a-2f86-79af-f65ef46822ef@huawei.com>
 <CAMj1kXEuV_Lmhu-2zZhD-YgL-zu+o0v+vooQTK30cemJW5dfNg@mail.gmail.com>
 <86c60895-365e-9166-8f70-7a353bbc4e86@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c60895-365e-9166-8f70-7a353bbc4e86@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 06, 2020 at 08:44:55PM +0800, Hanjun Guo wrote:
> On 2020/5/4 15:36, Ard Biesheuvel wrote:
> > On Mon, 4 May 2020 at 06:32, Hanjun Guo <guohanjun@huawei.com> wrote:
> > > On 2020/5/2 0:10, Ard Biesheuvel wrote:
> > > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > > index 98be18266a73..9f139a94a1d3 100644
> > > > --- a/drivers/acpi/arm64/iort.c
> > > > +++ b/drivers/acpi/arm64/iort.c
> > > > @@ -300,7 +300,7 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
> > > >    }
> > > > 
> > > >    static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> > > > -                    u32 *rid_out)
> > > > +                    u32 *rid_out, bool check_overlap)
> > > >    {
> > > >        /* Single mapping does not care for input id */
> > > >        if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> > > > @@ -316,10 +316,34 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> > > >        }
> > > > 
> > > >        if (rid_in < map->input_base ||
> > > > -         (rid_in >= map->input_base + map->id_count))
> > > > +         (rid_in > map->input_base + map->id_count))
> > > >                return -ENXIO;
> > > > 
> > > > +     if (check_overlap) {
> > > > +             /*
> > > > +              * We already found a mapping for this input ID at the end of
> > > > +              * another region. If it coincides with the start of this
> > > > +              * region, we assume the prior match was due to the off-by-1
> > > > +              * issue mentioned below, and allow it to be superseded.
> > > > +              * Otherwise, things are *really* broken, and we just disregard
> > > > +              * duplicate matches entirely to retain compatibility.
> > > > +              */
> > > > +             pr_err(FW_BUG "[map %p] conflicting mapping for input ID 0x%x\n",
> > > > +                    map, rid_in);
> > > 
> > > As we already applied a workaround here, can we add "applying
> > > workaround" in the error message? This will make the customers
> > > less uneasy to see such message in the boot log. Once the product
> > > was deliveried to customers, it's not that easy to update all the
> > > firmwares entirely.
> > > 
> > 
> > Sure.
> 
> Since Will already merged this patchset, I would like to send a patch
> on top of it, what do you think?

Yes, please! I figured I'd queue it, as I could always revert it if your
testing came back negative but extra stuff on top is always fine.

Will
