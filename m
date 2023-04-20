Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524306E938C
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 14:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjDTMAP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 08:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDTMAO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 08:00:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD8125;
        Thu, 20 Apr 2023 05:00:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2GNx6WKWz6J7C1;
        Thu, 20 Apr 2023 19:57:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 13:00:10 +0100
Date:   Thu, 20 Apr 2023 13:00:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 08/23] cxl: Add support for _DSM Function for
 retrieving QTG ID
Message-ID: <20230420130009.000048c0@Huawei.com>
In-Reply-To: <168193570968.1178687.16632681494857661844.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193570968.1178687.16632681494857661844.stgit@djiang5-mobl3>
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

On Wed, 19 Apr 2023 13:21:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)
> 
> Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
> an input of an ACPI package with 4 dwords (read latency, write latency,
> read bandwidth, write bandwidth). The call returns a package with 1 WORD
> that provides the max supported QTG ID and a package that may contain 0 or
> more WORDs as the recommended QTG IDs in the recommended order.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 

A few minor comments inline. 


> +/**
> + * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
> + * @handle: ACPI handle
> + * @input: bandwidth and latency data
> + *
> + * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
> + * the QTG IDs that falls within the performance data.
Falls within is a little vague.  Perhaps something like

the QTG IDs that are suitable for the performance point in order of most suitable
to least suitable.

> + */
> +struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
> +						 struct qtg_dsm_input *input)
> +{
> +	union acpi_object *out_obj, *out_buf, *pkg;
> +	union acpi_object in_buf = {
> +		.buffer = {
> +			.type = ACPI_TYPE_BUFFER,
> +			.pointer = (u8 *)input,
> +			.length = sizeof(u32) * 4,

sizeof(*input)?

Also, ACPI structures are always little endian. Do we need to be careful of that
here?

> +		},
> +	};
> +	union acpi_object in_obj = {
> +		.package = {
> +			.type = ACPI_TYPE_PACKAGE,
> +			.count = 1,
> +			.elements = &in_buf
> +		},
> +	};
> +	struct qtg_dsm_output *output = NULL;
> +	int len, rc, i;
> +	u16 *max_qtg;
> +
> +	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
> +	if (!out_obj)
> +		return ERR_PTR(-ENXIO);
> +
> +	if (out_obj->type != ACPI_TYPE_PACKAGE) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	/* Check Max QTG ID */
> +	pkg = &out_obj->package.elements[0];
> +	if (pkg->type != ACPI_TYPE_BUFFER) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	if (pkg->buffer.length != sizeof(u16)) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +	max_qtg = (u16 *)pkg->buffer.pointer;
> +
> +	/* Retrieve QTG IDs package */
> +	pkg = &out_obj->package.elements[1];
> +	if (pkg->type != ACPI_TYPE_PACKAGE) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	out_buf = &pkg->package.elements[0];
> +	if (out_buf->type != ACPI_TYPE_BUFFER) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	len = out_buf->buffer.length;
> +
> +	/* It's legal to have 0 QTG entries */
> +	if (len == 0)
> +		goto out;
> +
> +	/* Malformed package, not multiple of WORD size */
> +	if (len % sizeof(u16)) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	output = kmalloc(len + sizeof(*output), GFP_KERNEL);
> +	if (!output) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	output->nr = len / sizeof(u16);
> +	memcpy(output->qtg_ids, out_buf->buffer.pointer, len);
> +
> +	for (i = 0; i < output->nr; i++) {
> +		if (output->qtg_ids[i] > *max_qtg)
> +			pr_warn("QTG ID %u greater than MAX %u\n",
> +				output->qtg_ids[i], *max_qtg);
> +	}
> +
> +out:
> +	ACPI_FREE(out_obj);
> +	return output;
> +
> +err:
> +	ACPI_FREE(out_obj);
> +	return ERR_PTR(rc);

Why not combine these with something like

	return IS_ERR(rc) ? ERR_PTR(rc) : output;

I'm fine with leaving as it is, if this is common style for these
sorts of ACPI functions.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_acpi_evaluate_qtg_dsm, CXL);

