Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61CF6EAEDE
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Apr 2023 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjDUQNN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Apr 2023 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjDUQNI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2023 12:13:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA314F75;
        Fri, 21 Apr 2023 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682093583; x=1713629583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dDNnSFNrcC+fU68jZKfY8qcCncyrq02YdgYqi/7ZFe0=;
  b=SJ061jUmtq2ru/+yPqp5z2d7TCkNhdCkAxKpwLDHSYKug7wlfnVTg8fu
   fwGB3oq/4lvSiy4KaZNllSKxlsG6tNEX14sEN0/FXS1fOP68FI09NVUw9
   tfluGjYdjbqvMJZUUsrQvcIQUHFJDExmEpGGPfFgtN7f0jJaNwAh0YwrB
   zdtlwVqFurMEQhWfz5o/VQwmzTwg0YTYw5d6nXvJX6OYT42CNbEtWfRIj
   ocfCDClhN58MulQpFRah8u6tAIimJUVppv5LEmUXVBssiSLSYQ2rqzay9
   cQbO9dmubban6jD1vo3ffP7I0//PSFTGNbWrW0CvgZeGvlXSw6rp8MSmN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="344780653"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="344780653"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 09:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="685764739"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="685764739"
Received: from thusain-mobl1.amr.corp.intel.com (HELO [10.212.19.203]) ([10.212.19.203])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 09:13:00 -0700
Message-ID: <50cf5206-bcf9-a82e-55b4-bd8c780bb27e@intel.com>
Date:   Fri, 21 Apr 2023 09:12:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 04/23] cxl: Add common helpers for cdat parsing
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3>
 <20230420104104.000065dd@Huawei.com>
 <71fb1962-7029-119f-f12a-32849dff659a@intel.com>
 <20230421170605.00000f5a@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230421170605.00000f5a@Huawei.com>
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



On 4/21/23 9:06 AM, Jonathan Cameron wrote:
> 
>>>> +int cdat_table_parse_sslbis(struct cdat_header *table,
>>>> +			    cdat_tbl_entry_handler handler, void *arg)
>>>
>>> Feels like these ones should take a typed arg.  Sure you'll loose
>>> that again to use the generic handling code, but at this level we can
>>> do it I think.
>>
>> while DSMAS and DSLBIS takes a list_head, SSLBIS takes an xarray. I can
>> create a union.
> 
> I don't understand why,  If you drop the macro usage introduced in
> a later patch you can just have each one take the right thing.
> That macro isn't a huge saving anyway.

Oh I think I understand where you are trying to get at. Ok I'll update.
> 
> Jonathan
> 
>>
>>>    
>>>> +{
>>>> +	struct cdat_subtable_proc proc = {
>>>> +		.handler	= handler,
>>>> +		.arg		= arg,
>>>> +	};
>>>> +
>>>> +	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
>>>> +}
>>>    
>>
> 
