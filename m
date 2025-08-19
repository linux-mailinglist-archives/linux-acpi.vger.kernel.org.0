Return-Path: <linux-acpi+bounces-15842-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57831B2CA38
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE5F3ACD09
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3782D248A;
	Tue, 19 Aug 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hErvLQcZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C21C2C3251;
	Tue, 19 Aug 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622847; cv=none; b=FH/HzYi9LX8yvrhOHkDjUQQYvgl0z4257pR63PCbyPNRMnCLWPa3gtlCJLBHGdwsXzbVYxVPw6Nwfdz9O1eXzF5qmqipF1MmF+5iqu44NqGub17AjLYdsDicHv57ECoRbXF0NvUqMpCJxaluA8AaUr1q5HHNWEeyjsXCIey3SnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622847; c=relaxed/simple;
	bh=xiU5oRgSMxK8MyzWGKDSyVfiCDxHG1djlZcPWGpqMfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaelJguAj+czOVxaAMKMQneUMuxMD/gTxbXCUg6/Ic6pRH0tVKHQYpF4E2zzdepTjuiNXs2pMyUqOl2imDxtSCDv2g/CTYT2BX9hs/VJv+nBQWoBBT8Mn1KIU19iG4M1WE9493bX+aKYxpQwMO+PIMwp6XSyZoqdA4qNPbk1a9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hErvLQcZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755622845; x=1787158845;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xiU5oRgSMxK8MyzWGKDSyVfiCDxHG1djlZcPWGpqMfI=;
  b=hErvLQcZ0BLMcBOYM78IyqwqS33FIFeloLuBCc11+4na/s8nX/SU0lRp
   8T6gbLZdanxO4gtWgy59l2HzyMMDjtnpePxSm4Zf1WqUvmPKSx857+JQl
   RYqKQWPEZHx0EWjQDUX783ckrIasjiTlI2auOBzNOgUm/KxEJcpyONXKB
   cQee6B5Ou8Q0OW+ZHeFf61qMnetPQ1IU/hR/XUdozJpbx5hf6+ngQeVE2
   x9wfwJMGIqsRpWyDJMjYkr24vQTACMUPTKxrHER0UmPEPcWOV/cOlyP/Z
   S4P73M8WlkVS1KcsqBwB3Bx4VEJ+drU+Uf1BXbqSnPiKIV8Kmrmn3Ca0H
   w==;
X-CSE-ConnectionGUID: to5kdY66TNaBBOKrqYbg7g==
X-CSE-MsgGUID: 4MummMR3TzKhnrDIKh/nIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57939815"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57939815"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 10:00:44 -0700
X-CSE-ConnectionGUID: 3yXvRdrmTEWL9XnLI20t0w==
X-CSE-MsgGUID: xICEYJtuSfmHp85psMMl6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167391015"
Received: from unknown (HELO [10.247.119.200]) ([10.247.119.200])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 10:00:36 -0700
Message-ID: <a9fa7e25-b3a1-425d-97cb-206f218aa1af@intel.com>
Date: Tue, 19 Aug 2025 10:00:30 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drivers/base/node: Add a helper function
 node_update_perf_attrs()
To: David Hildenbrand <david@redhat.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 marc.herbert@linux.intel.com, akpm@linux-foundation.org
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-3-dave.jiang@intel.com>
 <c0600abd-18fd-4bfa-ba8d-45303ee3a9ee@redhat.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <c0600abd-18fd-4bfa-ba8d-45303ee3a9ee@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/18/25 2:49 AM, David Hildenbrand wrote:
> On 14.08.25 19:16, Dave Jiang wrote:
>> Add helper function node_update_perf_attrs() to allow update of node access
>> coordinates computed by an external agent such as CXL. The helper allows
>> updating of coordinates after the attribute being created by HMAT.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/base/node.c  | 39 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/node.h |  8 ++++++++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 3399594136b2..cf395da18c9b 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -248,6 +248,45 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>>   }
>>   EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>>   +/**
>> + * node_update_perf_attrs - Update the performance values for given access class
>> + * @nid: Node identifier to be updated
>> + * @coord: Heterogeneous memory performance coordinates
>> + * @access: The access class the for the given attributes
> 
> "the for": there is probably something missing

looks like extra 'the'

> 
>> + */
>> +void node_update_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>> +                enum access_coordinate_class access)
>> +{
>> +    struct node_access_nodes *access_node;
>> +    struct node *node;
>> +    int i;
>> +
>> +    if (WARN_ON_ONCE(!node_online(nid)))
>> +        return;
>> +
>> +    node = node_devices[nid];
>> +    list_for_each_entry(access_node, &node->access_list, list_node) {
>> +        if (access_node->access != access)
>> +            continue;
>> +
>> +        access_node->coord = *coord;
>> +        for (i = 0; access_attrs[i]; i++) {
>> +            sysfs_notify(&access_node->dev.kobj,
>> +                     NULL, access_attrs[i]->name);
>> +        }
>> +        break;
>> +    }
>> +
>> +    /* When setting CPU access coordinates, update mempolicy */
>> +    if (access == ACCESS_COORDINATE_CPU) {
>> +        if (mempolicy_set_node_perf(nid, coord)) {
>> +            pr_info("failed to set mempolicy attrs for node %d\n",
>> +                nid);
>> +        }
> if (access == ACCESS_COORDINATE_CPU &&
>     mempolicy_set_node_perf(nid, coord))
>     pr_info("failed to set mempolicy attrs for node %d\n", nid);
> 
> or
> 
> if (access != ACCESS_COORDINATE_CPU)
>     return
> if (mempolicy_set_node_perf(nid, coord))
>     pr_info("failed to set mempolicy attrs for node %d\n", nid);
> 
ok


> 
> With both things sorted
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
Thanks for the ack

