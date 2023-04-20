Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C306E93A8
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjDTMGK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 08:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjDTMGJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 08:06:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4044C10;
        Thu, 20 Apr 2023 05:06:05 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2GYf1nGkz67ZCl;
        Thu, 20 Apr 2023 20:04:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 13:06:03 +0100
Date:   Thu, 20 Apr 2023 13:06:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 09/23] cxl: Add helper function to retrieve ACPI
 handle of CXL root device
Message-ID: <20230420130602.0000413f@Huawei.com>
In-Reply-To: <168193571575.1178687.18078745201457493723.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193571575.1178687.18078745201457493723.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 19 Apr 2023 13:21:55 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a helper to find the ACPI0017 device in order to issue the _DSM.
> The helper will take the 'struct device' from a cxl_port and iterate until
> the root device is reached. The ACPI handle will be returned from the root
> device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Question inline.  If the answer is no then this looks fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +/**
> + * cxl_acpi_get_rootdev_handle - get the ACPI handle of the CXL root device
> + * @dev: 'struct device' to start searching from. Should be from cxl_port->dev.
> + *
> + * Return: acpi_handle on success, errptr of errno on error.
> + *
> + * Looks for the ACPI0017 device and return the ACPI handle
> + **/

Could we implement this in terms of find_cxl_root()?  I think that will
end up giving you the same device though I haven't tested it.

> +acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev)
> +{
> +	struct device *itr = dev;
> +	struct device *root_dev;
> +	acpi_handle handle;
> +
> +	if (!dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	while (itr->parent) {
> +		root_dev = itr;
> +		itr = itr->parent;
> +	}
> +
> +	if (!dev_is_platform(root_dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	handle = ACPI_HANDLE(root_dev);
> +	if (!handle)
> +		return ERR_PTR(-ENODEV);
> +
> +	return handle;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_acpi_get_rootdev_handle, CXL);


