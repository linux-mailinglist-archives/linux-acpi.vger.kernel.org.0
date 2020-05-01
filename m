Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EBE1C168E
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgEANuE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 09:50:04 -0400
Received: from foss.arm.com ([217.140.110.172]:40902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbgEANuD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 09:50:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6BB1FB;
        Fri,  1 May 2020 06:50:03 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD9BA3F68F;
        Fri,  1 May 2020 06:50:01 -0700 (PDT)
Date:   Fri, 1 May 2020 14:49:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH RFC 2/2] ACPI/IORT: work around num_ids ambiguity
Message-ID: <20200501134956.GA7240@e121166-lin.cambridge.arm.com>
References: <20200501095843.25401-1-ardb@kernel.org>
 <20200501095843.25401-3-ardb@kernel.org>
 <e3c7bdab-a2b0-d7c9-5c7b-eee680509338@arm.com>
 <CAMj1kXH0mcK3N94=uOuiL2_iy=eWhsnoXhvfiXv_kQ_j=F2a_Q@mail.gmail.com>
 <18e01ac7-974e-8308-c18c-67aa3fd7ad4e@arm.com>
 <CAMj1kXHsXEmaLuVBo7cgdzHju22WKksu7s3B3-hBE4mYhnuJ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHsXEmaLuVBo7cgdzHju22WKksu7s3B3-hBE4mYhnuJ=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 01, 2020 at 03:10:59PM +0200, Ard Biesheuvel wrote:

[...]

> > >> If we silently fix things up, then people will continue to write broken
> > >> tables without even realising, new OSes will have to implement the same
> > >> mechanism because vendors will have little interest in changing things
> > >> that have worked "correctly" with Linux for years, and we've effectively
> > >> achieved a de-facto redefinition of the spec. Making our end of the
> > >> interface robust is obviously desirable, but there still needs to be
> > >> *some* incentive for the folks on the other end to get it right.
> > >>
> > >
> > > Agreed. But at least we'll be able to detect it and flag it in the
> > > general case, rather than having a special case for D05/06 only
> > > (although I suppose splitting the output ranges like those platforms
> > > do is rather unusual)
> >
> > Yup, in principle the fixed quirk list gives a nice reassuring sense of
> > "we'll work around these early platforms and everyone from now on will
> > get it right", but whether reality plays out that way is another matter
> > entirely...
> 
> The reason I am looking into this is that I think the fix should go to
> stable, given that the current situation makes it impossible to write
> firmware that works with older and newer kernels.

Yes. If we do remove the quirk the sooner we do it the better to
reduce the stable patches.

> Lorenzo said he wouldn't mind taking the current version with ACPI OEM
> ID matching back to -stable, but it's another quirk list to manage,
> which I would prefer to avoid.
> 
> But I don't care deeply either way, to be honest, as long as we can
> get something backported so compliant firmware is not being penalized
> anymore.

Question: if we remove the iort_workaround_oem_info stuff but we *do*
keep the existing apply_id_count_workaround flag and we set it by going
through all the mappings at boot time and detect if any of these
off-by-one conditions apply - would the resulting code be any simpler ?

The global flag would apply (as it does now) to _all_ mappings but it is
very likely that if the off-by-one firmware bug is present it applies to
the IORT table as a whole rather than a single mapping entry.

Lorenzo
