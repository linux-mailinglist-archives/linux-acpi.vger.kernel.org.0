Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E036EB5B5
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Apr 2023 01:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDUXY7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Apr 2023 19:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjDUXY7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2023 19:24:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C80E76;
        Fri, 21 Apr 2023 16:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682119497; x=1713655497;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L+EsobrZxreSDv+BWEMf6VhzAGe7lYyZemTHArjpKV4=;
  b=P+UhtgQ3K6uXlil48oqiIcWq8IPTgHTGHI9jxVyO7wOWHQ/OoTiji7JL
   Ka2v8krcTAfKIVk7EUzMhmVyT3pwf9Y1C2K35vqntpdtc7OOW7i4R3jXg
   zQyPdktOxt+RYNjXGgOUE3R1rQ+xXK7R93F5E4k8xSdCU97fvYOUgYEd8
   okso7R5PHnTpAX7hEKctqdVl289pyKYMAv2Wy12BmtNR7iQ2AVPHfNiNV
   45xHZJoJ8RAZ10yhtpPL0oTOudlXHC8Aqe+Bm0FM2vV95jbbfJa0p4Oiy
   Wo5qWschjkGchVfAD7V1zzQLhOM4PHF1DWeqbXvZKyUlmbcuxUvFhpUhB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348899515"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348899515"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 16:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="816589046"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="816589046"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.19.203]) ([10.212.19.203])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 16:24:56 -0700
Message-ID: <2ebf1d0f-84b4-7867-1b04-b391b5e73f55@intel.com>
Date:   Fri, 21 Apr 2023 16:24:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 09/23] cxl: Add helper function to retrieve ACPI handle
 of CXL root device
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193571575.1178687.18078745201457493723.stgit@djiang5-mobl3>
 <20230420130602.0000413f@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230420130602.0000413f@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/20/23 5:06 AM, Jonathan Cameron wrote:
> On Wed, 19 Apr 2023 13:21:55 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Provide a helper to find the ACPI0017 device in order to issue the _DSM.
>> The helper will take the 'struct device' from a cxl_port and iterate until
>> the root device is reached. The ACPI handle will be returned from the root
>> device.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Question inline.  If the answer is no then this looks fine to me.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
>> +/**
>> + * cxl_acpi_get_rootdev_handle - get the ACPI handle of the CXL root device
>> + * @dev: 'struct device' to start searching from. Should be from cxl_port->dev.
>> + *
>> + * Return: acpi_handle on success, errptr of errno on error.
>> + *
>> + * Looks for the ACPI0017 device and return the ACPI handle
>> + **/
> 
> Could we implement this in terms of find_cxl_root()?  I think that will
> end up giving you the same device though I haven't tested it.

Yes I can simplify this. Thanks.

> 
>> +acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev)
>> +{
>> +	struct device *itr = dev;
>> +	struct device *root_dev;
>> +	acpi_handle handle;
>> +
>> +	if (!dev)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	while (itr->parent) {
>> +		root_dev = itr;
>> +		itr = itr->parent;
>> +	}
>> +
>> +	if (!dev_is_platform(root_dev))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	handle = ACPI_HANDLE(root_dev);
>> +	if (!handle)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	return handle;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_acpi_get_rootdev_handle, CXL);
> 
> 
