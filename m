Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277AE460BB
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2019 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfFNO2x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jun 2019 10:28:53 -0400
Received: from foss.arm.com ([217.140.110.172]:35322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfFNO2x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jun 2019 10:28:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCE8E344;
        Fri, 14 Jun 2019 07:28:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11F03F246;
        Fri, 14 Jun 2019 07:28:51 -0700 (PDT)
Date:   Fri, 14 Jun 2019 15:28:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tomasz Nowicki <tn@semihalf.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [bug report] ACPI: Add new IORT functions to support MSI domain
 handling
Message-ID: <20190614142845.GA23116@e121166-lin.cambridge.arm.com>
References: <20190613065410.GB16334@mwanda>
 <425b5d78-b38f-270b-94e2-7ece1e5498e5@arm.com>
 <5f9fecb1-66de-b550-3f8e-097795a08efe@huawei.com>
 <40cc7b22-d5e6-ffcf-d6ec-a74f3fbe906c@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40cc7b22-d5e6-ffcf-d6ec-a74f3fbe906c@semihalf.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 14, 2019 at 12:09:17PM +0200, Tomasz Nowicki wrote:
> On 14.06.2019 03:03, Hanjun Guo wrote:
> > On 2019/6/13 17:30, Robin Murphy wrote:
> > > On 13/06/2019 07:54, Dan Carpenter wrote:
> > > > Hello Tomasz Nowicki,
> > > > 
> > > > The patch 4bf2efd26d76: "ACPI: Add new IORT functions to support MSI
> > > > domain handling" from Sep 12, 2016, leads to the following static
> > > > checker warning:
> > > > 
> > > >      drivers/acpi/arm64/iort.c:628 iort_dev_find_its_id()
> > > >      warn: array off by one? 'its->identifiers[idx]'
> > > > 
> > > > drivers/acpi/arm64/iort.c
> > > >      589  /**
> > > >      590   * iort_dev_find_its_id() - Find the ITS identifier for a device
> > > >      591   * @dev: The device.
> > > >      592   * @req_id: Device's requester ID
> > > >      593   * @idx: Index of the ITS identifier list.
> > > >      594   * @its_id: ITS identifier.
> > > >      595   *
> > > >      596   * Returns: 0 on success, appropriate error value otherwise
> > > >      597   */
> > > >      598  static int iort_dev_find_its_id(struct device *dev, u32 req_id,
> > > >      599                                  unsigned int idx, int *its_id)
> > > >      600  {
> > > >      601          struct acpi_iort_its_group *its;
> > > >      602          struct acpi_iort_node *node;
> > > >      603
> > > >      604          node = iort_find_dev_node(dev);
> > > >      605          if (!node)
> > > >      606                  return -ENXIO;
> > > >      607
> > > >      608          node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
> > > >      609          if (!node)
> > > >      610                  return -ENXIO;
> > > >      611
> > > >      612          /* Move to ITS specific data */
> > > >      613          its = (struct acpi_iort_its_group *)node->node_data;
> > > >      614          if (idx > its->its_count) {
> > > >                       ^^^^^^^^^^^^^^^^^^^^
> > > > I wasn't able to find any information about how its->its_count is set
> > > > but it looks to me that is off by one.
> > > 
> > > its->count is read directly from the firmware table. Currently it seems this condition can never be hit anyway, since this is only ever called with idx == 0. TBH I can't really see how the code could evolve such that this check should ever be necessary (i.e. it makes no sense for callers to pull idx values out if thin air, so they'd presumably end up being derived from its->count in the first place), but if we are going to have it then I agree it should be ">=".
> > 
> > For now seems we only got systems which map a device to a single
> > ITS, but in the IORT spec, it assumes that maybe there is a ITS group
> > for mapping, so I think we can just use ">=" as you suggested to
> > align with the spec.
> > 
> 
> Yes, should be ">=" and the error massage should be fixed as well:
> 
> /* Move to ITS specific data */
> its = (struct acpi_iort_its_group *)node->node_data;
> if (idx >= its->its_count) {
>         dev_err(dev, "requested ITS ID index [%d] exceeds max permitted [%d]
> index\n",
>                 idx, its->its_count - 1);
>         return -ENXIO;
> }

I will pick it up, reformat and resend it.

Thanks,
Lorenzo
