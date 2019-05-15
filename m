Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F371F8DB
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2019 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEOQn2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 May 2019 12:43:28 -0400
Received: from foss.arm.com ([217.140.101.70]:48622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfEOQn1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 May 2019 12:43:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31B9B80D;
        Wed, 15 May 2019 09:43:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 870C83F703;
        Wed, 15 May 2019 09:43:25 -0700 (PDT)
Date:   Wed, 15 May 2019 17:41:10 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        guohanjun@huawei.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Hulk Robot <hulkci@huawei.com>, joro@8bytes.org
Subject: Re: [PATCH RESEND] ACPI/IORT: Fix build error when IOMMU_SUPPORT
 disabled
Message-ID: <20190515164110.GA22536@e121166-lin.cambridge.arm.com>
References: <20190515033406.79020-1-wangkefeng.wang@huawei.com>
 <20190515034253.79348-1-wangkefeng.wang@huawei.com>
 <20190515101534.GF24357@fuggles.cambridge.arm.com>
 <20190515120652.GA27269@e121166-lin.cambridge.arm.com>
 <a7efd571-d82e-1d8f-147f-3bf8d1152d0d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7efd571-d82e-1d8f-147f-3bf8d1152d0d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 15, 2019 at 01:46:28PM +0100, Robin Murphy wrote:
> On 15/05/2019 13:06, Lorenzo Pieralisi wrote:
> > [+Joerg, Robin]
> > 
> > On Wed, May 15, 2019 at 11:15:34AM +0100, Will Deacon wrote:
> > > On Wed, May 15, 2019 at 11:42:53AM +0800, Kefeng Wang wrote:
> > > > drivers/acpi/arm64/iort.c: In function iort_iommu_configure:
> > > > drivers/acpi/arm64/iort.c:1079:21: error: struct iommu_fwspec has no member named flags
> > > >      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> > > >                       ^~
> > > > drivers/acpi/arm64/iort.c:1079:32: error: IOMMU_FWSPEC_PCI_RC_ATS
> > > > undeclared (first use in this function)
> > > >      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> > > >                                  ^~~~~~~~~~~~~~~~~~~~~~~
> > > > drivers/acpi/arm64/iort.c:1079:32: note: each undeclared identifier is reported only once for each function it appears in
> > > > 
> > > > If IOMMU_SUPPORT not enabled, struct iommu_fwspec without members and
> > > > IOMMU_FWSPEC_PCI_RC_ATS not defined, add new iommu_fwspec_set_ats_flags()
> > > > to set IOMMU_FWSPEC_PCI_RC_ATS flags to solve build error.
> > > > 
> > > > Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > 
> > > What's this "Hulk Robot"? Does it report things publicly?
> > 
> > AFAIK it is Huawei CI system, I had some doubts about leaving
> > that tag for other patches I dealt with, I am not sure it is
> > really useful (other than giving Hulk some credit).
> > 
> > > Anyway, I can pick this up if Lorenzo acks it.
> > 
> > Actually I think we should compile out iort_iommu_configure() for
> > !IOMMU_SUPPORT unless I am missing something, so that we are
> > removing this source of errors.
> 
> Indeed, much as I like the compile coverage of not having things #ifdefed
> out in general, this particular case seems like a fairly atypical
> configuration so I'm not sure all the extra fluff of struct accessors is
> really worth it.

Ok, I will send a patch shortly to address this issue, if Kefeng
does not object I will drop the CI bot as reporter and add him
instead.

Thanks,
Lorenzo

> 
> Robin.
> 
> > If that does not cut it, for this patch:
> > 
> > iommu_fwspec_set_ats_flags() should be iommu_fwspec_set_ats_flag()
> > 
> > The commit log should be fixed (it is pretty weird to start with the
> > build error and then explain it):
> > 
> > "If IOMMU_SUPPORT is not enabled, struct iommu_fwspec is an empty
> > struct and IOMMU_FWSPEC_PCI_RC_ATS is not defined, resulting in
> > the following build error:
> > 
> > drivers/acpi/arm64/iort.c: In function iort_iommu_configure:
> > drivers/acpi/arm64/iort.c:1079:21: error: struct iommu_fwspec has no member named flags
> >      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> >                       ^~
> > drivers/acpi/arm64/iort.c:1079:32: error: IOMMU_FWSPEC_PCI_RC_ATS
> > undeclared (first use in this function)
> >      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> >                                  ^~~~~~~~~~~~~~~~~~~~~~~
> > drivers/acpi/arm64/iort.c:1079:32: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > Add a iommu_fwspec_set_ats_flag() helper function (that is an empty
> > stub on !IOMMU_SUPPORT) to fix it."
> > 
