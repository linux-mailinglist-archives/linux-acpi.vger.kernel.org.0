Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB61AAC1D
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Apr 2020 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414809AbgDOPnc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Apr 2020 11:43:32 -0400
Received: from foss.arm.com ([217.140.110.172]:47474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1414835AbgDOPn2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Apr 2020 11:43:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145191FB;
        Wed, 15 Apr 2020 08:43:27 -0700 (PDT)
Received: from red-moon.cambridge.arm.com (unknown [10.57.31.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 562743F6C4;
        Wed, 15 Apr 2020 08:43:24 -0700 (PDT)
Date:   Wed, 15 Apr 2020 16:43:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Makarand Pawagi <makarand.pawagi@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "jon@solid-run.com" <jon@solid-run.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Calvin Johnson <calvin.johnson@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        "Stuart.Yoder@arm.com" <Stuart.Yoder@arm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>
Subject: Re: [EXT] Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
Message-ID: <20200415153901.GA21296@red-moon.cambridge.arm.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
 <20200325125109.GA5430@red-moon.cambridge.arm.com>
 <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
 <20200414143211.GA14905@red-moon.cambridge.arm.com>
 <DB7PR04MB4986A8A3427DBA096628D6FBEBDB0@DB7PR04MB4986.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR04MB4986A8A3427DBA096628D6FBEBDB0@DB7PR04MB4986.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 15, 2020 at 05:42:03AM +0000, Makarand Pawagi wrote:
> 
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Tuesday, April 14, 2020 8:02 PM
> > To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org; linux-arm-
> > kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > robin.murphy@arm.com; ard.biesheuvel@linaro.org; Ioana Ciornei
> > <ioana.ciornei@nxp.com>; Diana Madalina Craciun (OSS)
> > <diana.craciun@oss.nxp.com>; maz@kernel.org; jon@solid-run.com; Pankaj
> > Bansal <pankaj.bansal@nxp.com>; Makarand Pawagi
> > <makarand.pawagi@nxp.com>; Calvin Johnson <calvin.johnson@nxp.com>;
> > Varun Sethi <V.Sethi@nxp.com>; Cristi Sovaiala <cristian.sovaiala@nxp.com>;
> > Stuart.Yoder@arm.com; jeremy.linton@arm.com; joro@8bytes.org;
> > tglx@linutronix.de; jason@lakedaemon.net
> > Subject: [EXT] Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
> > implementation
> > 
> > Caution: EXT Email
> > 
> > On Wed, Mar 25, 2020 at 06:48:55PM +0200, Laurentiu Tudor wrote:
> > > Hi Lorenzo,
> > >
> > > On 3/25/2020 2:51 PM, Lorenzo Pieralisi wrote:
> > > > On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com wrote:
> > > >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > >>
> > > >> The devices on this bus are not discovered by way of device tree
> > > >> but by queries to the firmware. It makes little sense to trick the
> > > >> generic of layer into thinking that these devices are of related so
> > > >> that we can get our dma configuration. Instead of doing that, add
> > > >> our custom dma configuration implementation.
> > > >>
> > > >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > >> ---
> > > >>  drivers/bus/fsl-mc/fsl-mc-bus.c | 31
> > > >> ++++++++++++++++++++++++++++++-
> > > >>  1 file changed, 30 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > > >> b/drivers/bus/fsl-mc/fsl-mc-bus.c index 36eb25f82c8e..eafaa0e0b906
> > > >> 100644
> > > >> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > > >> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > > >> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device
> > > >> *dev, struct kobj_uevent_env *env)  static int
> > > >> fsl_mc_dma_configure(struct device *dev)  {
> > > >>    struct device *dma_dev = dev;
> > > >> +  struct iommu_fwspec *fwspec;
> > > >> +  const struct iommu_ops *iommu_ops;  struct fsl_mc_device *mc_dev
> > > >> + = to_fsl_mc_device(dev);  int ret;
> > > >> +  u32 icid;
> > > >>
> > > >>    while (dev_is_fsl_mc(dma_dev))
> > > >>            dma_dev = dma_dev->parent;
> > > >>
> > > >> -  return of_dma_configure(dev, dma_dev->of_node, 0);
> > > >> +  fwspec = dev_iommu_fwspec_get(dma_dev);  if (!fwspec)
> > > >> +          return -ENODEV;
> > > >> +  iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
> > > >> +  if (!iommu_ops)
> > > >> +          return -ENODEV;
> > > >> +
> > > >> +  ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
> > > >> + if (ret)
> > > >> +          return ret;
> > > >> +
> > > >> +  icid = mc_dev->icid;
> > > >> +  ret = iommu_fwspec_add_ids(dev, &icid, 1);
> > > >
> > > > I see. So with this patch we would use the MC named component only
> > > > to retrieve the iommu_ops
> > >
> > > Right. I'd also add that the implementation tries to follow the
> > > existing standard .dma_configure implementations, e.g.
> > > of_dma_configure + of_iommu_configure. I'd also note that similarly to
> > > the ACPI case, this MC FW device is probed as a platform device in the
> > > DT scenario, binding here [1].
> > > A similar approach is used for the retrieval of the msi irq domain,
> > > see following patch.
> > >
> > > > - the streamid are injected directly here bypassing OF/IORT bindings
> > translations altogether.
> > >
> > > Actually I've submitted a v2 [2] that calls into .of_xlate() to allow
> > > the smmu driver to do some processing on the raw streamid coming from
> > > the firmware. I have not yet tested this with ACPI but expect it to
> > > work, however, it's debatable how valid is this approach in the
> > > context of ACPI.
> > 
> > Actually, what I think you need is of_map_rid() (and an IORT equivalent, that I
> > am going to write - generalizing iort_msi_map_rid()).
> > 
> 
> That would help.
> 
> > Would that be enough to enable IORT "normal" mappings in the MC bus named
> > components ?
> > 
> 
> But still the question remain unanswered that how we are going to represent MC? As Platform device with single ID mapping flag?

No, "normal" mappings, that's what I wrote above and it is not a
platform device it is a named component in ACPI/IORT terms.

Thanks,
Lorenzo
