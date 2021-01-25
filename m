Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE73028FB
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbhAYReA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 12:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbhAYRPS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 12:15:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBEFC06174A;
        Mon, 25 Jan 2021 09:14:38 -0800 (PST)
Received: from zn.tnic (p200300ec2f09db004bb0ee0cb7e01378.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:4bb0:ee0c:b7e0:1378])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A95061EC030D;
        Mon, 25 Jan 2021 18:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611594876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z7eyGpYXFzkDPUB8M1I4KekEb4xSMFxcKNImwrUUnPA=;
        b=J8o+WmHJ/hSYwQxW0OjiInNeLcqECsll5NhQ8U3kbCV4OZp02EUAX08csasWTWx1HBtj0V
        SENQiLpW5olp8akoLBPk1wmL8j/uPcoXZKX5j1/z4A6zZKAXh2V3aUfA57I9DdUptY2ebP
        M6pIt0QNFCdLIAcZjASs5+D+jPtTaI4=
Date:   Mon, 25 Jan 2021 18:14:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Terry Bowman <terry.bowman@amd.com>,
        James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jon.grimm@amd.com
Subject: Re: [PATCH] ACPI / APEI: Add is_ghes_type() to identify GHES sources
Message-ID: <20210125171431.GI23070@zn.tnic>
References: <20210122180322.1720413-1-terry.bowman@amd.com>
 <CAJZ5v0hoMe=XbwD-oRGiRxAia94JB1CfBiqEXGwan+pN5_pzqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hoMe=XbwD-oRGiRxAia94JB1CfBiqEXGwan+pN5_pzqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 25, 2021 at 05:41:04PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 22, 2021 at 7:05 PM Terry Bowman <terry.bowman@amd.com> wrote:
> >
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Refactor duplicated GHES identity logic into is_ghes_type().
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > Reviewed-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> If Terry was a co-author of the patch, please add a Co-developed-by:
> tag for him in addition to the s-o-b.  Otherwise the meaning of his
> s-o-b is unclear.
> 
> Boris, James, any objections to the changes below?
> 
> > ---
> >  drivers/acpi/apei/hest.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> > index 6e980fe16772..bd702e0ef339 100644
> > --- a/drivers/acpi/apei/hest.c
> > +++ b/drivers/acpi/apei/hest.c
> > @@ -49,6 +49,12 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
> >         [ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
> >  };
> >
> > +static inline bool is_ghes_type(struct acpi_hest_header *hest_hdr)
> > +{
> > +       return hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
> > +              hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;

I realize that this is supposed to test whether the table point to a
generic hardware error source but everything in our code pertaining to
GHES is called, well, "ghes".

So I'd prefer to call that is_generic_error() or so.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
