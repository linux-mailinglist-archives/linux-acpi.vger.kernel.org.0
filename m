Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6468A450FC
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2019 03:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfFNBDn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 21:03:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbfFNBDn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Jun 2019 21:03:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2D40C8FC07ADAE7E2CF3;
        Fri, 14 Jun 2019 09:03:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 09:03:15 +0800
Subject: Re: [bug report] ACPI: Add new IORT functions to support MSI domain
 handling
To:     Robin Murphy <robin.murphy@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, <tn@semihalf.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
References: <20190613065410.GB16334@mwanda>
 <425b5d78-b38f-270b-94e2-7ece1e5498e5@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <5f9fecb1-66de-b550-3f8e-097795a08efe@huawei.com>
Date:   Fri, 14 Jun 2019 09:03:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <425b5d78-b38f-270b-94e2-7ece1e5498e5@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/6/13 17:30, Robin Murphy wrote:
> On 13/06/2019 07:54, Dan Carpenter wrote:
>> Hello Tomasz Nowicki,
>>
>> The patch 4bf2efd26d76: "ACPI: Add new IORT functions to support MSI
>> domain handling" from Sep 12, 2016, leads to the following static
>> checker warning:
>>
>>     drivers/acpi/arm64/iort.c:628 iort_dev_find_its_id()
>>     warn: array off by one? 'its->identifiers[idx]'
>>
>> drivers/acpi/arm64/iort.c
>>     589  /**
>>     590   * iort_dev_find_its_id() - Find the ITS identifier for a device
>>     591   * @dev: The device.
>>     592   * @req_id: Device's requester ID
>>     593   * @idx: Index of the ITS identifier list.
>>     594   * @its_id: ITS identifier.
>>     595   *
>>     596   * Returns: 0 on success, appropriate error value otherwise
>>     597   */
>>     598  static int iort_dev_find_its_id(struct device *dev, u32 req_id,
>>     599                                  unsigned int idx, int *its_id)
>>     600  {
>>     601          struct acpi_iort_its_group *its;
>>     602          struct acpi_iort_node *node;
>>     603
>>     604          node = iort_find_dev_node(dev);
>>     605          if (!node)
>>     606                  return -ENXIO;
>>     607
>>     608          node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
>>     609          if (!node)
>>     610                  return -ENXIO;
>>     611
>>     612          /* Move to ITS specific data */
>>     613          its = (struct acpi_iort_its_group *)node->node_data;
>>     614          if (idx > its->its_count) {
>>                      ^^^^^^^^^^^^^^^^^^^^
>> I wasn't able to find any information about how its->its_count is set
>> but it looks to me that is off by one.
> 
> its->count is read directly from the firmware table. Currently it seems this condition can never be hit anyway, since this is only ever called with idx == 0. TBH I can't really see how the code could evolve such that this check should ever be necessary (i.e. it makes no sense for callers to pull idx values out if thin air, so they'd presumably end up being derived from its->count in the first place), but if we are going to have it then I agree it should be ">=".

For now seems we only got systems which map a device to a single
ITS, but in the IORT spec, it assumes that maybe there is a ITS group
for mapping, so I think we can just use ">=" as you suggested to
align with the spec.

Thanks
Hanjun

