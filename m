Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8A243E15
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfFMPrY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 11:47:24 -0400
Received: from foss.arm.com ([217.140.110.172]:37030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731766AbfFMJa4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Jun 2019 05:30:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC43C367;
        Thu, 13 Jun 2019 02:30:55 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FF5A3F694;
        Thu, 13 Jun 2019 02:30:55 -0700 (PDT)
Subject: Re: [bug report] ACPI: Add new IORT functions to support MSI domain
 handling
To:     Dan Carpenter <dan.carpenter@oracle.com>, tn@semihalf.com
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190613065410.GB16334@mwanda>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <425b5d78-b38f-270b-94e2-7ece1e5498e5@arm.com>
Date:   Thu, 13 Jun 2019 10:30:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613065410.GB16334@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 13/06/2019 07:54, Dan Carpenter wrote:
> Hello Tomasz Nowicki,
> 
> The patch 4bf2efd26d76: "ACPI: Add new IORT functions to support MSI
> domain handling" from Sep 12, 2016, leads to the following static
> checker warning:
> 
> 	drivers/acpi/arm64/iort.c:628 iort_dev_find_its_id()
> 	warn: array off by one? 'its->identifiers[idx]'
> 
> drivers/acpi/arm64/iort.c
>     589  /**
>     590   * iort_dev_find_its_id() - Find the ITS identifier for a device
>     591   * @dev: The device.
>     592   * @req_id: Device's requester ID
>     593   * @idx: Index of the ITS identifier list.
>     594   * @its_id: ITS identifier.
>     595   *
>     596   * Returns: 0 on success, appropriate error value otherwise
>     597   */
>     598  static int iort_dev_find_its_id(struct device *dev, u32 req_id,
>     599                                  unsigned int idx, int *its_id)
>     600  {
>     601          struct acpi_iort_its_group *its;
>     602          struct acpi_iort_node *node;
>     603
>     604          node = iort_find_dev_node(dev);
>     605          if (!node)
>     606                  return -ENXIO;
>     607
>     608          node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
>     609          if (!node)
>     610                  return -ENXIO;
>     611
>     612          /* Move to ITS specific data */
>     613          its = (struct acpi_iort_its_group *)node->node_data;
>     614          if (idx > its->its_count) {
>                      ^^^^^^^^^^^^^^^^^^^^
> I wasn't able to find any information about how its->its_count is set
> but it looks to me that is off by one.

its->count is read directly from the firmware table. Currently it seems 
this condition can never be hit anyway, since this is only ever called 
with idx == 0. TBH I can't really see how the code could evolve such 
that this check should ever be necessary (i.e. it makes no sense for 
callers to pull idx values out if thin air, so they'd presumably end up 
being derived from its->count in the first place), but if we are going 
to have it then I agree it should be ">=".

Robin.

> 
>     615                  dev_err(dev, "requested ITS ID index [%d] is greater than available [%d]\n",
>     616                          idx, its->its_count);
>     617                  return -ENXIO;
>     618          }
>     619
>     620          *its_id = its->identifiers[idx];
>     621          return 0;
>     622  }
> 
> regards,
> dan carpenter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
