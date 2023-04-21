Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2D6EA077
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Apr 2023 02:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjDUALY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 20:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjDUALX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 20:11:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C714233;
        Thu, 20 Apr 2023 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682035882; x=1713571882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gpxoOgNQ66xfasHJnG29Y8SQVMbJD82v/+JhJ9WTWzw=;
  b=cSyuYcnpBeqhsNZDNEXXIUIQFlSOWkAlSO6fFCmf6BTBy60Q561jJPbB
   c8jubwV3SYwwjPsCxdn4rrdL/fZN7nioml1MTiIa5oSZdISnxtfnyJb+M
   9TFL4iJeJ3kAzwsp4QrPJTZyYoUX/bB5LPso3whJVJY1XfM9DIB/VnkdM
   FtH7ZOkQAaPSZfA/xPgcCCiLMU4+WyGyxuprvQUyhCcpuESf19OWlzFnU
   Rd0aZ2I8K5aleQFF/vmUkhp0/pnHHWdHoaVlCWcvr2fV3Ffqs4ogOe120
   BR21FoPTR6sESUjsvhQMdcupJbl6AHvBfeNg7Cq24o0SFI2mlaneDF3G1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="343373315"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="343373315"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 17:11:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="938278820"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="938278820"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.11.57]) ([10.212.11.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 17:11:03 -0700
Message-ID: <58afc53f-6050-56bb-25ef-1799ca28c34a@intel.com>
Date:   Thu, 20 Apr 2023 17:11:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 08/23] cxl: Add support for _DSM Function for
 retrieving QTG ID
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193570968.1178687.16632681494857661844.stgit@djiang5-mobl3>
 <20230420130009.000048c0@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230420130009.000048c0@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/20/23 5:00 AM, Jonathan Cameron wrote:
> On Wed, 19 Apr 2023 13:21:49 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)
>>
>> Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
>> an input of an ACPI package with 4 dwords (read latency, write latency,
>> read bandwidth, write bandwidth). The call returns a package with 1 WORD
>> that provides the max supported QTG ID and a package that may contain 0 or
>> more WORDs as the recommended QTG IDs in the recommended order.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
> 
> A few minor comments inline.
> 
> 
>> +/**
>> + * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
>> + * @handle: ACPI handle
>> + * @input: bandwidth and latency data
>> + *
>> + * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
>> + * the QTG IDs that falls within the performance data.
> Falls within is a little vague.  Perhaps something like
> 
> the QTG IDs that are suitable for the performance point in order of most suitable
> to least suitable.

Thanks. I will update with your suggestion.

> 
>> + */
>> +struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
>> +						 struct qtg_dsm_input *input)
>> +{
>> +	union acpi_object *out_obj, *out_buf, *pkg;
>> +	union acpi_object in_buf = {
>> +		.buffer = {
>> +			.type = ACPI_TYPE_BUFFER,
>> +			.pointer = (u8 *)input,
>> +			.length = sizeof(u32) * 4,
> 
> sizeof(*input)?

ok

> 
> Also, ACPI structures are always little endian. Do we need to be careful of that
> here?

sigh yes. I will add in endieness handling for the patch.

> 
>> +		},
>> +	};
>> +	union acpi_object in_obj = {
>> +		.package = {
>> +			.type = ACPI_TYPE_PACKAGE,
>> +			.count = 1,
>> +			.elements = &in_buf
>> +		},
>> +	};
>> +	struct qtg_dsm_output *output = NULL;
>> +	int len, rc, i;
>> +	u16 *max_qtg;
>> +
>> +	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
>> +	if (!out_obj)
>> +		return ERR_PTR(-ENXIO);
>> +
>> +	if (out_obj->type != ACPI_TYPE_PACKAGE) {
>> +		rc = -ENXIO;
>> +		goto err;
>> +	}
>> +
>> +	/* Check Max QTG ID */
>> +	pkg = &out_obj->package.elements[0];
>> +	if (pkg->type != ACPI_TYPE_BUFFER) {
>> +		rc = -ENXIO;
>> +		goto err;
>> +	}
>> +
>> +	if (pkg->buffer.length != sizeof(u16)) {
>> +		rc = -ENXIO;
>> +		goto err;
>> +	}
>> +	max_qtg = (u16 *)pkg->buffer.pointer;
>> +
>> +	/* Retrieve QTG IDs package */
>> +	pkg = &out_obj->package.elements[1];
>> +	if (pkg->type != ACPI_TYPE_PACKAGE) {
>> +		rc = -ENXIO;
>> +		goto err;
>> +	}
>> +
>> +	out_buf = &pkg->package.elements[0];
>> +	if (out_buf->type != ACPI_TYPE_BUFFER) {
>> +		rc = -ENXIO;
>> +		goto err;
>> +	}
>> +
>> +	len = out_buf->buffer.length;
>> +
>> +	/* It's legal to have 0 QTG entries */
>> +	if (len == 0)
>> +		goto out;
>> +
>> +	/* Malformed package, not multiple of WORD size */
>> +	if (len % sizeof(u16)) {
>> +		rc = -ENXIO;
>> +		goto out;
>> +	}
>> +
>> +	output = kmalloc(len + sizeof(*output), GFP_KERNEL);
>> +	if (!output) {
>> +		rc = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	output->nr = len / sizeof(u16);
>> +	memcpy(output->qtg_ids, out_buf->buffer.pointer, len);
>> +
>> +	for (i = 0; i < output->nr; i++) {
>> +		if (output->qtg_ids[i] > *max_qtg)
>> +			pr_warn("QTG ID %u greater than MAX %u\n",
>> +				output->qtg_ids[i], *max_qtg);
>> +	}
>> +
>> +out:
>> +	ACPI_FREE(out_obj);
>> +	return output;
>> +
>> +err:
>> +	ACPI_FREE(out_obj);
>> +	return ERR_PTR(rc);
> 
> Why not combine these with something like
> 
> 	return IS_ERR(rc) ? ERR_PTR(rc) : output;
> 
> I'm fine with leaving as it is, if this is common style for these
> sorts of ACPI functions.

I'll combine it. But if I just set output to ERR_PTR(errno) for all the 
error cases then we can just return output directly without checking?

> 
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_acpi_evaluate_qtg_dsm, CXL);
> 
