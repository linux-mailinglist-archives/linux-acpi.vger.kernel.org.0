Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABB6E9FD4
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Apr 2023 01:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjDTXZM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 19:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjDTXZI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 19:25:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660B1BCE;
        Thu, 20 Apr 2023 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682033107; x=1713569107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gKuB4fkbxM/X2ZF8RluPJYQs0Lbws5bhBzabycmU+cE=;
  b=Gdpd9KYmYC9VVqwjasaNjo7kgjrlVt1m0t7cCtftvb8qbGP8E/G4fD7E
   lpTyvDv9owYiAEJPwtGmF21LS0duC4GiOma4g96+A/eTDSWQjm2k/BCij
   WBkb2BFz36nO2E9hBbjcs4TamDHz7byeVCy9WR/Eh/TAX/k+kmFlfT/xC
   tUCCLC6qnhKKso8IT/7/3znUsyWyAoi77HLcu+qNmRYEJNNURjV32rvwO
   qLzhnQkQ5aW3QMqe9NuuGlX3FFzw77v642awoM0CWLkrHhOUgvC+Xo48e
   VXSA7pPj208LEBBI4aEaQlseeeB7VeCqMQv1kfcmC+32MMjyAsCyp94V3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="344628125"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="344628125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="722566847"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="722566847"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.11.57]) ([10.212.11.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:25:06 -0700
Message-ID: <d21b6411-f3ab-9c39-8606-bc68d472241a@intel.com>
Date:   Thu, 20 Apr 2023 16:25:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 05/23] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193569130.1178687.11664485128816659216.stgit@djiang5-mobl3>
 <20230420123350.000061b1@Huawei.com> <20230420123512.0000650b@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230420123512.0000650b@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/20/23 4:35 AM, Jonathan Cameron wrote:
> On Thu, 20 Apr 2023 12:33:50 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
>> On Wed, 19 Apr 2023 13:21:31 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> Provide a callback function to the CDAT parser in order to parse the Device
>>> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
>>> DPA range and its associated attributes in each entry. See the CDAT
>>> specification for details.
>>>
>>> Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
>>> Structure (DSMAS)
>>
>> I'm not sure what purpose of this is. If it's just detecting problems
>> with the entry because we aren't interested in the content yet, then fine
>> but good to make that clear in patch intro.
>>
>> Maybe I'm missing something!
>>
> Ah. Got to next patch.  Perhaps a forwards reference to that will avoid
> anyone else wondering what is going on here!

Ok I'll clarify.

> 
>> Thanks,
>>
>> Jonathan
>>
>>>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>
>>> ---
>>> v3:
>>> - Add spec section number. (Alison)
>>> - Remove cast from void *. (Alison)
>>> - Refactor cxl_port_probe() block. (Alison)
>>> - Move CDAT parse to cxl_endpoint_port_probe()
>>>
>>> v2:
>>> - Add DSMAS table size check. (Lukas)
>>> - Use local DSMAS header for LE handling.
>>> - Remove dsmas lock. (Jonathan)
>>> - Fix handle size (Jonathan)
>>> - Add LE to host conversion for DSMAS address and length.
>>> - Make dsmas_list local
>>
>>
>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>> index 615e0ef6b440..3022bdd52439 100644
>>> --- a/drivers/cxl/port.c
>>> +++ b/drivers/cxl/port.c
>>> @@ -57,6 +57,16 @@ static int discover_region(struct device *dev, void *root)
>>>   	return 0;
>>>   }
>>
>>>   static int cxl_switch_port_probe(struct cxl_port *port)
>>>   {
>>>   	struct cxl_hdm *cxlhdm;
>>> @@ -125,6 +135,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>>   	device_for_each_child(&port->dev, root, discover_region);
>>>   	put_device(&root->dev);
>>>   
>>> +	if (port->cdat.table) {
>>> +		LIST_HEAD(dsmas_list);
>>> +
>>> +		rc = cdat_table_parse_dsmas(port->cdat.table,
>>> +					    cxl_dsmas_parse_entry,
>>> +					    (void *)&dsmas_list);
>>> +		if (rc < 0)
>>> +			dev_warn(&port->dev, "Failed to parse DSMAS: %d\n", rc);
>>> +
>>> +		dsmas_list_destroy(&dsmas_list);
>>
>> I'm a little confused here.  What's the point?  Parse them then throw the info away?
>> Maybe a comment if all we are trying to do is warn about CDAT problems.
>>
>>
>>> +	}
>>> +
>>>   	return 0;
>>>   }
>>>   
>>>
>>>    
>>
> 
