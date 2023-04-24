Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC56ED382
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Apr 2023 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDXRbb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXRba (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 13:31:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582149D0;
        Mon, 24 Apr 2023 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682357489; x=1713893489;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=bRR7rtKWl4sGWdNxIo9fMuQ9SVmlY4+HZqDckGyXmwc=;
  b=U1lbxwyxY/aLe4pP+HDcuDW3MKBk65lvDiJcx5DCTFA/qigK7VAD31Ry
   MOoTYqYLowWF953bvqvRDXHoApARE/UZN5lNOwWFvcr7A4w51tlQM9sB8
   QSLB24aYO8knXQuJQMc+k39GIU0ySAnMaRwDhTx6wvuOXtllvuP7ZX+ja
   yiWeE4Lkw89Q3UtmErL6DabYNahh78GtTlOerBtwFrFemQIW2ZfYeVH36
   7yJ27TNmG0wpHPG7AQxR/5P7JfPtRfLpZ7ZbT7zDvkF7Lm0p8S8sy2jmd
   PQue+2aJXND3lp5lSX3CFWvsJeuphl7Y+0sbAKr4uRlCZJF/zhj0zANqQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="374462033"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="374462033"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 10:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="670579566"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="670579566"
Received: from sridharn-mobl.amr.corp.intel.com (HELO [10.212.106.191]) ([10.212.106.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 10:31:03 -0700
Message-ID: <cae21d42-ab7a-5d6c-a3ef-07f4c585dc9f@intel.com>
Date:   Mon, 24 Apr 2023 10:31:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 11/23] cxl: Add helper function that calculates QoS
 values for switches
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193572747.1178687.13347516490022640531.stgit@djiang5-mobl3>
 <20230420132624.00006334@Huawei.com>
 <86ec4cb5-14fd-9860-0fd9-ed53b474fe6e@intel.com>
In-Reply-To: <86ec4cb5-14fd-9860-0fd9-ed53b474fe6e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/24/23 10:09 AM, Dave Jiang wrote:
> 
> 
> On 4/20/23 5:26 AM, Jonathan Cameron wrote:
>> On Wed, 19 Apr 2023 13:22:07 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> The CDAT information from the switch, Switch Scoped Latency and 
>>> Bandwidth
>>> Information Strucutre (SSLBIS), is parsed and stored in an xarray 
>>> under the
>>> cxl_port. The QoS data are indexed by the downstream port id.  Walk 
>>> the CXL
>>> ports from endpoint to root and retrieve the relevant QoS information
>>> (bandwidth and latency) that are from the switch CDAT. If read or 
>>> write QoS
>>> values are not available, then use the access QoS value.
>>
>> I'd drop the access reference.  You already did that mapping from 
>> access to read
>> and write in earlier patch. Now we have no concept of access so 
>> mentioning
>> it will only potentially cause confusion.
> 
> ok
> 
>>
>>>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>
>>> ---
>>> v3:
>>> - Move to use 'struct node_hmem_attrs'
>>> ---
>>>   drivers/cxl/core/port.c |   81 
>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>   drivers/cxl/cxl.h       |    2 +
>>>   2 files changed, 83 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index 3fedbabac1af..770b540d5325 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -1921,6 +1921,87 @@ bool schedule_cxl_memdev_detach(struct 
>>> cxl_memdev *cxlmd)
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>>> +/**
>>> + * cxl_port_get_switch_qos - retrieve QoS data for CXL switches
>>
>> Hmm. Terminology wise, this is called QoS data in either CXL spec
>> or the HMAT stuff it came from.  I'd avoid that term here.
>> Might also get confused with the QoS telemetry stuff from the CXL
>> spec which is totally different or the QoS controls on an MLD
>> which are perhaps indirectly related to these.
>>
>> QoS only gets involved once these are mapped to a QTG - assumption
>> being that a given QoS policy should apply to devices of similar access
>> characteristics.
> 
> locality_info?

Or perf_data in accordance with this doc:
https://www.kernel.org/doc/html/v5.9/admin-guide/mm/numaperf.html

> 
> 
>>
>> Other than that bikeshedding.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>>
>>
>>> + * @port: endpoint cxl_port
>>> + * @rd_bw: writeback value for min read bandwidth
>>> + * @rd_lat: writeback value for total read latency
>>> + * @wr_bw: writeback value for min write bandwidth
>>> + * @wr_lat: writeback value for total write latency
>>> + *
>>> + * Return: Errno on failure, 0 on success. -ENOENT if no switch device
>>> + */
>>> +int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 
>>> *rd_lat,
>>> +                u64 *wr_bw, u64 *wr_lat)
>>> +{
>>> +    u64 min_rd_bw = ULONG_MAX;
>>> +    u64 min_wr_bw = ULONG_MAX;
>>> +    struct cxl_dport *dport;
>>> +    struct cxl_port *nport;
>>> +    u64 total_rd_lat = 0;
>>> +    u64 total_wr_lat = 0;
>>> +    struct device *next;
>>> +    int switches = 0;
>>> +    int rc = 0;
>>> +
>>> +    if (!is_cxl_endpoint(port))
>>> +        return -EINVAL;
>>> +
>>> +    /* Skip the endpoint */
>>> +    next = port->dev.parent;
>>> +    nport = to_cxl_port(next);
>>> +    dport = port->parent_dport;
>>> +
>>> +    do {
>>> +        struct node_hmem_attrs *hmem_attrs;
>>> +        u64 lat, bw;
>>> +
>>> +        if (!nport->cdat.table)
>>> +            break;
>>> +
>>> +        if (!dev_is_pci(dport->dport))
>>> +            break;
>>> +
>>> +        hmem_attrs = xa_load(&nport->cdat.sslbis_xa, dport->port_id);
>>> +        if (xa_is_err(hmem_attrs))
>>> +            return xa_err(hmem_attrs);
>>> +
>>> +        if (!hmem_attrs) {
>>> +            hmem_attrs = xa_load(&nport->cdat.sslbis_xa, 
>>> SSLBIS_ANY_PORT);
>>> +            if (xa_is_err(hmem_attrs))
>>> +                return xa_err(hmem_attrs);
>>> +            if (!hmem_attrs)
>>> +                return -ENXIO;
>>> +        }
>>> +
>>> +        bw = hmem_attrs->write_bandwidth;
>>> +        lat = hmem_attrs->write_latency;
>>> +        min_wr_bw = min_t(u64, min_wr_bw, bw);
>>> +        total_wr_lat += lat;
>>> +
>>> +        bw = hmem_attrs->read_bandwidth;
>>> +        lat = hmem_attrs->read_latency;
>>> +        min_rd_bw = min_t(u64, min_rd_bw, bw);
>>> +        total_rd_lat += lat;
>>> +
>>> +        dport = nport->parent_dport;
>>> +        next = next->parent;
>>> +        nport = to_cxl_port(next);
>>> +        switches++;
>>> +    } while (next);
>>> +
>>> +    *wr_bw = min_wr_bw;
>>> +    *wr_lat = total_wr_lat;
>>> +    *rd_bw = min_rd_bw;
>>> +    *rd_lat = total_rd_lat;
>>> +
>>> +    if (!switches)
>>> +        return -ENOENT;
>>> +
>>> +    return rc;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_switch_qos, CXL);
>>
>>
