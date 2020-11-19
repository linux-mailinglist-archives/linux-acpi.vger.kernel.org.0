Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABE2B9A52
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgKSSDx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 13:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbgKSSDw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Nov 2020 13:03:52 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D56AC21D46;
        Thu, 19 Nov 2020 18:03:49 +0000 (UTC)
Date:   Thu, 19 Nov 2020 18:03:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Shiju Jose <shiju.jose@huawei.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, linuxarm@huawei.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] ACPI/IORT: Fix doc warnings in iort.c
Message-ID: <20201119180346.GI4376@gaia>
References: <20201014093139.1580-1-shiju.jose@huawei.com>
 <20201119180120.GA25142@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119180120.GA25142@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 19, 2020 at 06:01:20PM +0000, Lorenzo Pieralisi wrote:
> [+Catalin - I hope it can go via arm64 tree, trivial doc fixup]

Or Will if you want it in 5.10, otherwise I can pick it up for 5.11.

> On Wed, Oct 14, 2020 at 10:31:39AM +0100, Shiju Jose wrote:
> > Fix following warnings caused by mismatch between
> > function parameters and function comments.
> > 
> > drivers/acpi/arm64/iort.c:55: warning: Function parameter or member 'iort_node' not described in 'iort_set_fwnode'
> > drivers/acpi/arm64/iort.c:55: warning: Excess function parameter 'node' description in 'iort_set_fwnode'
> > drivers/acpi/arm64/iort.c:682: warning: Function parameter or member 'id' not described in 'iort_get_device_domain'
> > drivers/acpi/arm64/iort.c:682: warning: Function parameter or member 'bus_token' not described in 'iort_get_device_domain'
> > drivers/acpi/arm64/iort.c:682: warning: Excess function parameter 'req_id' description in 'iort_get_device_domain'
> > drivers/acpi/arm64/iort.c:1142: warning: Function parameter or member 'dma_size' not described in 'iort_dma_setup'
> > drivers/acpi/arm64/iort.c:1142: warning: Excess function parameter 'size' description in 'iort_dma_setup'
> > drivers/acpi/arm64/iort.c:1534: warning: Function parameter or member 'ops' not described in 'iort_add_platform_device'
> > 
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 9929ff50c0c0..770d84071a32 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -44,7 +44,7 @@ static DEFINE_SPINLOCK(iort_fwnode_lock);
> >   * iort_set_fwnode() - Create iort_fwnode and use it to register
> >   *		       iommu data in the iort_fwnode_list
> >   *
> > - * @node: IORT table node associated with the IOMMU
> > + * @iort_node: IORT table node associated with the IOMMU
> >   * @fwnode: fwnode associated with the IORT node
> >   *
> >   * Returns: 0 on success
> > @@ -673,7 +673,8 @@ static int iort_dev_find_its_id(struct device *dev, u32 id,
> >  /**
> >   * iort_get_device_domain() - Find MSI domain related to a device
> >   * @dev: The device.
> > - * @req_id: Requester ID for the device.
> > + * @id: Requester ID for the device.
> > + * @bus_token: irq domain bus token.
> >   *
> >   * Returns: the MSI domain for this device, NULL otherwise
> >   */
> > @@ -1136,7 +1137,7 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
> >   *
> >   * @dev: device to configure
> >   * @dma_addr: device DMA address result pointer
> > - * @size: DMA range size result pointer
> > + * @dma_size: DMA range size result pointer
> >   */
> >  void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> >  {
> > @@ -1526,6 +1527,7 @@ static __init const struct iort_dev_config *iort_get_dev_cfg(
> >  /**
> >   * iort_add_platform_device() - Allocate a platform device for IORT node
> >   * @node: Pointer to device ACPI IORT node
> > + * @ops: Pointer to IORT device config struct
> >   *
> >   * Returns: 0 on success, <0 failure
> >   */
> > -- 
> > 2.17.1
