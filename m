Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254FE3463AB
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 16:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhCWPyH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 11:54:07 -0400
Received: from foss.arm.com ([217.140.110.172]:48316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232867AbhCWPxp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Mar 2021 11:53:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47F1FD6E;
        Tue, 23 Mar 2021 08:53:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B47EA3F718;
        Tue, 23 Mar 2021 08:53:41 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:53:36 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Message-ID: <20210323155336.GA1639@e121166-lin.cambridge.arm.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
 <b7a2424941214b33803e34ba3e532440@huawei.com>
 <MWHPR11MB1599238526CF0529394CD9D7F0659@MWHPR11MB1599.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MWHPR11MB1599238526CF0529394CD9D7F0659@MWHPR11MB1599.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 22, 2021 at 09:57:58PM +0000, Kaneda, Erik wrote:
> 
> 
> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>
> > Sent: Monday, March 22, 2021 3:36 AM
> > To: Kaneda, Erik <erik.kaneda@intel.com>; linux-arm-
> > kernel@lists.infradead.org; linux-acpi@vger.kernel.org; iommu@lists.linux-
> > foundation.org; devel@acpica.org; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Moore, Robert <robert.moore@intel.com>
> > Cc: Linuxarm <linuxarm@huawei.com>; steven.price@arm.com;
> > Sami.Mujawar@arm.com; robin.murphy@arm.com; wanghuiqiang
> > <wanghuiqiang@huawei.com>
> > Subject: [Devel] Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
> > 
> > [+]
> > 
> > Hi Erik,
> > 
> > As this is now just merged ino acpica-master and based on the discussion we
> > had here,
> > 
> > https://github.com/acpica/acpica/pull/638
> > 
> > I had a discussion with ARM folks(Lorenzo) in the linaro-open-discussions call
> > and
> > can confirm that the IORT Revision E is not the final specification and has
> > some issues
> > which is now corrected in the latest E.b revision[1]. Also there are no current
> > users
> > for the Rev E and it may not be a good idea to push this version into the Linux
> > kernel
> > or elsewhere.
> > 
> > So could you please revert the merge and I am planning to work on the E.b
> > soon.
> Hi,
> 
> > Please let me know if I need to explicitly send a revert pull request or not.
> 
> Please send a revert pull request and I'll remember to not submit Linux-ize the IORT patches.
> 
> From all of the activity that I've seen with the IORT specification,
> it looks like this table is nontrivial to design and maintain. The
> difficulty I have with the table is that I do not understand which
> table revisions are in active use.

Possibly all of them in firmware in the field - I am not sure what you
are asking though; if you can elaborate I'd be grateful.

> So my question is this: which IORT revisions are being actively used?

See above.

Thanks,
Lorenzo

> 
> Thanks,
> Erik
> > 
> > Thanks,
> > Shameer
> > 
> > 1. https://developer.arm.com/documentation/den0049/latest/
> > 
> > > -----Original Message-----
> > > From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On
> > Behalf Of
> > > Shameer Kolothum
> > > Sent: 19 November 2020 12:12
> > > To: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > > iommu@lists.linux-foundation.org; devel@acpica.org
> > > Cc: Linuxarm <linuxarm@huawei.com>; steven.price@arm.com;
> > Guohanjun
> > > (Hanjun Guo) <guohanjun@huawei.com>; Sami.Mujawar@arm.com;
> > > robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > > Subject: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
> > >
> > > IORT revision E contains a few additions like,
> > >     -Added an identifier field in the node descriptors to aid table
> > >      cross-referencing.
> > >     -Introduced the Reserved Memory Range(RMR) node. This is used
> > >      to describe memory ranges that are used by endpoints and requires
> > >      a unity mapping in SMMU.
> > >     -Introduced a flag in the RC node to express support for PRI.
> > >
> > > Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >  include/acpi/actbl2.h | 25 +++++++++++++++++++------
> > >  1 file changed, 19 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > > ec66779cb193..274fce7b5c01 100644
> > > --- a/include/acpi/actbl2.h
> > > +++ b/include/acpi/actbl2.h
> > > @@ -68,7 +68,7 @@
> > >   * IORT - IO Remapping Table
> > >   *
> > >   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> > > - * Document number: ARM DEN 0049D, March 2018
> > > + * Document number: ARM DEN 0049E, June 2020
> > >   *
> > >
> > >
> > **********************************************************
> > ******
> > > **************/
> > >
> > > @@ -86,7 +86,8 @@ struct acpi_iort_node {
> > >  	u8 type;
> > >  	u16 length;
> > >  	u8 revision;
> > > -	u32 reserved;
> > > +	u16 reserved;
> > > +	u16 identifier;
> > >  	u32 mapping_count;
> > >  	u32 mapping_offset;
> > >  	char node_data[1];
> > > @@ -100,7 +101,8 @@ enum acpi_iort_node_type {
> > >  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
> > >  	ACPI_IORT_NODE_SMMU = 0x03,
> > >  	ACPI_IORT_NODE_SMMU_V3 = 0x04,
> > > -	ACPI_IORT_NODE_PMCG = 0x05
> > > +	ACPI_IORT_NODE_PMCG = 0x05,
> > > +	ACPI_IORT_NODE_RMR = 0x06,
> > >  };
> > >
> > >  struct acpi_iort_id_mapping {
> > > @@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
> > >  	u8 reserved[3];		/* Reserved, must be zero */
> > >  };
> > >
> > > -/* Values for ats_attribute field above */
> > > +/* Masks for ats_attribute field above */
> > >
> > > -#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root
> > > complex supports ATS */
> > > -#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root
> > > complex doesn't support ATS */
> > > +#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex
> > > supports ATS */
> > > +#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root complex
> > > supports PRI */
> > >
> > >  struct acpi_iort_smmu {
> > >  	u64 base_address;	/* SMMU base address */
> > > @@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
> > >  	u64 page1_base_address;
> > >  };
> > >
> > > +struct acpi_iort_rmr {
> > > +	u32 rmr_count;
> > > +	u32 rmr_offset;
> > > +};
> > > +
> > > +struct acpi_iort_rmr_desc {
> > > +	u64 base_address;
> > > +	u64 length;
> > > +	u32 reserved;
> > > +};
> > > +
> > >
> > >
> > /**********************************************************
> > *****
> > > ****************
> > >   *
> > >   * IVRS - I/O Virtualization Reporting Structure
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > iommu mailing list
> > > iommu@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > _______________________________________________
> > Devel mailing list -- devel@acpica.org
> > To unsubscribe send an email to devel-leave@acpica.org
> > %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
