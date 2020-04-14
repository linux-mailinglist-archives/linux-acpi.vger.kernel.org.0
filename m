Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BA11A7FD5
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Apr 2020 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390935AbgDNOc0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Apr 2020 10:32:26 -0400
Received: from foss.arm.com ([217.140.110.172]:56984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390932AbgDNOcX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Apr 2020 10:32:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B553E30E;
        Tue, 14 Apr 2020 07:32:22 -0700 (PDT)
Received: from red-moon.cambridge.arm.com (unknown [10.57.27.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A55293F73D;
        Tue, 14 Apr 2020 07:32:18 -0700 (PDT)
Date:   Tue, 14 Apr 2020 15:32:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, ard.biesheuvel@linaro.org,
        ioana.ciornei@nxp.com, diana.craciun@oss.nxp.com, maz@kernel.org,
        jon@solid-run.com, pankaj.bansal@nxp.com, makarand.pawagi@nxp.com,
        calvin.johnson@nxp.com, V.Sethi@nxp.com, cristian.sovaiala@nxp.com,
        Stuart.Yoder@arm.com, jeremy.linton@arm.com, joro@8bytes.org,
        tglx@linutronix.de, jason@lakedaemon.net
Subject: Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
Message-ID: <20200414143211.GA14905@red-moon.cambridge.arm.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
 <20200325125109.GA5430@red-moon.cambridge.arm.com>
 <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 25, 2020 at 06:48:55PM +0200, Laurentiu Tudor wrote:
> Hi Lorenzo,
> 
> On 3/25/2020 2:51 PM, Lorenzo Pieralisi wrote:
> > On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com wrote:
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> The devices on this bus are not discovered by way of device tree
> >> but by queries to the firmware. It makes little sense to trick the
> >> generic of layer into thinking that these devices are of related so
> >> that we can get our dma configuration. Instead of doing that, add
> >> our custom dma configuration implementation.
> >>
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> ---
> >>  drivers/bus/fsl-mc/fsl-mc-bus.c | 31 ++++++++++++++++++++++++++++++-
> >>  1 file changed, 30 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> >> index 36eb25f82c8e..eafaa0e0b906 100644
> >> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> >> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> >> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> >>  static int fsl_mc_dma_configure(struct device *dev)
> >>  {
> >>  	struct device *dma_dev = dev;
> >> +	struct iommu_fwspec *fwspec;
> >> +	const struct iommu_ops *iommu_ops;
> >> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> >> +	int ret;
> >> +	u32 icid;
> >>  
> >>  	while (dev_is_fsl_mc(dma_dev))
> >>  		dma_dev = dma_dev->parent;
> >>  
> >> -	return of_dma_configure(dev, dma_dev->of_node, 0);
> >> +	fwspec = dev_iommu_fwspec_get(dma_dev);
> >> +	if (!fwspec)
> >> +		return -ENODEV;
> >> +	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
> >> +	if (!iommu_ops)
> >> +		return -ENODEV;
> >> +
> >> +	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	icid = mc_dev->icid;
> >> +	ret = iommu_fwspec_add_ids(dev, &icid, 1);
> > 
> > I see. So with this patch we would use the MC named component only to
> > retrieve the iommu_ops
> 
> Right. I'd also add that the implementation tries to follow the existing
> standard .dma_configure implementations, e.g. of_dma_configure +
> of_iommu_configure. I'd also note that similarly to the ACPI case, this
> MC FW device is probed as a platform device in the DT scenario, binding
> here [1].
> A similar approach is used for the retrieval of the msi irq domain, see
> following patch.
> 
> > - the streamid are injected directly here bypassing OF/IORT bindings translations altogether. 
> 
> Actually I've submitted a v2 [2] that calls into .of_xlate() to allow
> the smmu driver to do some processing on the raw streamid coming from
> the firmware. I have not yet tested this with ACPI but expect it to
> work, however, it's debatable how valid is this approach in the context
> of ACPI.

Actually, what I think you need is of_map_rid() (and an IORT
equivalent, that I am going to write - generalizing iort_msi_map_rid()).

Would that be enough to enable IORT "normal" mappings in the MC bus
named components ?

Thanks,
Lorenzo
