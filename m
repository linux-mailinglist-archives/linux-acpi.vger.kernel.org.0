Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101173A862
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjFVSmK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFVSmJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 14:42:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63771FF5;
        Thu, 22 Jun 2023 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687459328; x=1718995328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kiCY8PgKdIT2e/BkeDK2yrXD4WGhnBAJXt5rG6Y75ys=;
  b=jdK8nXlKnKuDIPzfHvlKn4lfT2/XtIN16cdg1+LdOvKM1W2K73ajKgSc
   2z0JKnETTbaWWxBEVnnDoWmVr9vwoAEEE4Q9QgkY5+30hHPXoNC6Prlnh
   OPoUELfYINJ8uhutQfjQT5yK6VYECuT2uPWtjFK6GGWRSb+aJmQV8UazR
   7UDyXNLVAgesXdHRtaeABiTLpm3c+v/aMKvV6YiFSio6m/Xwo/2+XMasW
   y6NeEnG84SQbvhB/g9MIaMaijZdE4wEwtLvdnA2nKMj1XdrT8cA51nAQn
   JljhHdbosFTw+HAZTrD10qjWJFCVVimQe2m5VPpeE/8X4atuLc8vxG4wd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350337955"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="350337955"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:42:08 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="749446354"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="749446354"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 11:42:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 11:42:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 11:42:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 11:42:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuKqN3n97QjkiubdFQBadkcv30RwVkOGZJNt6AaL4WR+N/2aBtFk5oUu70tuKY9zXtjSJzf9ckvnn6EkTUFFeUseQaKcGTOSOPeAcc8Va8oxksy89CBQI4rZO/D61/XilqE3CgVDIdpSfugK4BdbwvnwUNMJJSY5VQGOjARwrRx6GszHqm1i8Q1u5k5npdUYhupwhjQ8fuCNJWsUI5fYwL0EeHmH1sz7bieB/KuzExUDHf0zYB4a8f/jPk8SwyUTbsjBT9ab15wy7H5ZO0mXoD+eKF5VMXEjxPqMm3VF2mH1Rnz7KZorGLJmh+wasN3+P0KOhtlGCB6Qk/B6vPGBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcDVPnFgm7I5vB47LDL2Vc/CXOWm6r9C56IoZ7WXt/U=;
 b=MyiRqmI9XP55niidx7cAuYqcq5gxLwf9+zAcCoJznToretKh4F4wL9gFAd+zHsax56BDCrsRg8Hd/KEE0FLAuUeHY/gupSeBb7qGfoojHBmVv8JasdXq6F5IF/SC29JFngcnBPQt5WkPO4JV/SPvOMAq34//mMwAwmZS0DOb7voiiPG2fU78503HgcxNbtNAs387ymjMeGsiXTAMr5xIQI3UDVKZYPbRYgdm7xaIP+w7WIG8ULOArLy//vNW+a7CimI+rCyukkBibkFrtXncqgFgNy58GAcZo5Sn8rveUFjVoU+lB5SBfs3dz2J/FgfERny7Cp7Ij/x26jD6ZjCwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 18:42:03 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 18:42:03 +0000
Message-ID: <c89c3be5-b7cb-98ff-f92f-b5920cca871e@intel.com>
Date:   Thu, 22 Jun 2023 11:41:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v3 3/6] acpi: numa: Add genport target allocation to the
 HMAT parsing
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
References: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
 <168686424175.2950427.1861604402516465647.stgit@djiang5-mobl3>
 <20230622144511.0000319d@Huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622144511.0000319d@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ccd8b9-adcb-4921-5154-08db73505ecd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ifHNmGguGt7vlo2mAQEDxM42uTepRoaHBcXU+kSvy2P0EW2WC3Zsk1ep0hC7RIs3GEcr5TUel/8jVpj4DiSXhme1yxRokMM2SmyXaW3CsR7pQ7gN7x2DZfm/EDHHoJine9aave6m3uNIJ4MGRUOhPWVYSfuQYqeadERTtLNV4T8agruBJigu9eAHRCdgbylNAPQs7OFZt55wibfDjNkmJIWFV0OpszYp9NPydUF8a/rAvrO9LsGNPzHBcbXdxAt8V5bG/zDZAuy8VkdmW/hN9qI/TT+56eCPRK+1+PUdO+CyAUF/Gjhsk2cUmL/q0M4KmKw1pZR2Cir0b3siYT1RaX9lqGogkZJxPuAK4TRceOnNH2MivUMy4nrKZ7t/6CrmIBNlRZoA49amBo4QocsFdcL3dkIqGf9+JNupJ26c/dfvorcT98/i0eWafk6SoijRsc4fWnkmlb6FzOK6aTxAr+ns0wChw8RdBobnK9QFK7rrl+//+V8nxLZQ1tHnLPFcIg69foKvbcQku11i0HNEMyyWBTk7+2JPsq+8QNzxBk/7+FnvUSH/XEzcouuFHxNfu86X+8PPGEzBluE8mqNYYmOBBJ91ZBcMGMxjmmaHn8nm9SvGUYfP36jw3zPWiOpAXaB4xjeg15HBJ/i5XzbBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(8936002)(2906002)(38100700002)(2616005)(66556008)(6916009)(66946007)(66476007)(4326008)(86362001)(36756003)(6486002)(83380400001)(316002)(31696002)(41300700001)(8676002)(5660300002)(186003)(82960400001)(31686004)(6666004)(6512007)(26005)(44832011)(6506007)(478600001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXU1eWtqaUtTNjFWdFN5Rm01eDZEOVRUdzhKTk5seDZrdWdNWlJ2MUVCMUsz?=
 =?utf-8?B?bkxSNk5ENzNSYXM5cVBWVkdlQXkybElVWHhNb1pDaEkxMnA3T21CTlRsZUxv?=
 =?utf-8?B?ZzBLUkhRLzRjS1dYNW1IdHRyekwvbGwzeTNySTZQMUZuMnUycHNoVFAwNFV3?=
 =?utf-8?B?aTh6cXlmQTZSTDg5cDRrYWFDS29NSVk4cVFZYXVjMGllZGVPUVZHYVA2UGRp?=
 =?utf-8?B?WDNZZjZrci83bVV1d1FWcU5UQWJocVcwVGFCcnh4bEJubDhmOHpTU05OdCtZ?=
 =?utf-8?B?MTRBVnlHU1ZsRlNsSFdleGtEdGpMT0VSMFNnclpqZm05S0h3blJJTEVwODBh?=
 =?utf-8?B?eisxcWJnUWFGU2pwa0VFWVVHNnpHK3Fhbm5UYzZ5Q2krckd3N003SmVNeUxU?=
 =?utf-8?B?czBsZ0RiUERGb3RvRGJmZ3YwMUJpQmFYQ0F0SjBLcUhKak9HRThrSEtKN000?=
 =?utf-8?B?YmhnZlJwYlRFYmRlMUhiVTFFZWc1aXhiU1JaWDREMFBFT21iSTlYWkNQa2x6?=
 =?utf-8?B?a0VpT0ZQM3RnaXZzYnNJNStUMEE1TU9CS3VNNnlmWk83NXpRamM1a1J5eWR3?=
 =?utf-8?B?UFNzN3h1eXAva0FjL1dJWG9GVDhpWGVtNzBlYzNZdTVkRVpJYnhtS1FOaUdJ?=
 =?utf-8?B?WkgxaUxSOU9pNG1qK3VLem85elgrYjBRZ0p0WHpTanlaSVpMaDBKaTdWblls?=
 =?utf-8?B?MkRYbFRZaUpuRGNsTkVwWUQxMFZ5NmdXbXlrMDkwbWg4RW9Eb3NQWFhZQXdq?=
 =?utf-8?B?aG1RUFJwUDBOMUdpQkhEUlJkaG9RL2drWkNWc2JWRGJtQi81aFF6YmhNbVgv?=
 =?utf-8?B?czhTN25jUm1hMU5PK3VkQTU2NCtVNk5GVDRZTTRmZVlhcFE2UVRaaXozWHdB?=
 =?utf-8?B?NWxNVWdBQi92ellOZnJTdE94THh0R3p4cHFJSlFucVNjZThFYm9SaUtqZ2Vt?=
 =?utf-8?B?RjVBQmM5UUNkVTRuV2ljMUNZNmhEN1VGNXg3VHFydWZlYUdSY0d5WXlqWjJa?=
 =?utf-8?B?aGs5elV2WDIwUDhTaTQxZDNxNGNhc2pmd25uNWU2R09PZzRGY0NmQWdXUFFO?=
 =?utf-8?B?K0xORkY0T3phdm5wY3FVQlNlZTltTUpKSnlCanhpY3FGc0VvQXIxN0FiNmVF?=
 =?utf-8?B?d291SElQUlVhQitXWSs2ek1FbkNta3BFbk8wTjEwMkpnL2k5cC9HWXlSUkM5?=
 =?utf-8?B?anN0WXdGbUt3aGdVSCtlRHk4UzMxcS8remVxYmtLYXJpT2NpbytlREUySG1x?=
 =?utf-8?B?VGVpZXBrQVQxeXdNd2tRNGFodEcvN3A3UVBDcUNGNE9pc0hDM0Y3Y3pPRU5n?=
 =?utf-8?B?ejJoSGNoMHhkSS9DckpNcWIveThRVGtoYURROHJXVUU1eVQ3U3Bjb21xWHFE?=
 =?utf-8?B?VFR2MnFUVGhtS3o5RTdHRHdUelQxS3NtbnR3OTdsNURxRUhwS2NhUkNjbkhE?=
 =?utf-8?B?K2hLUFdwWXEzeXh5V3JwbWxtTlVkd1lTOFRzMzEycUFFcTR1UlIwMklxc2Qw?=
 =?utf-8?B?ZFBUZTlKam5kdmhpeXhWUWJDZU9SbGhoVEUzcFVHVFNMNzEvb2FVR2hDNTFw?=
 =?utf-8?B?eGpZZk5YNnBOVkthWFFwQWdGaEFnbEQzWUxkZ0s4aG1nemFnR0F6UklkNjZl?=
 =?utf-8?B?NFlDTkR0R2lWdkl3Yk9uTFJnRWtTTVVlazFVL2NNTE5BaUxYZC9kUU50WVh3?=
 =?utf-8?B?d1RtMGNlLzZCZ3ZYUmtaY2IvbXVsQmg4Q1BQSk8rdWZReWQ3R2xkUk5pNVht?=
 =?utf-8?B?WXIrWFdZUXVWMmJtRFIyc3NXTE9sVWNjbXlkTEJuWEpQZkpYSVdtWWdYdTI5?=
 =?utf-8?B?NndzSlVQL2RTZFkrVlFaT283c0Zqc2IrSkgvaTMydUc3R0NFREtTbU1KMjV4?=
 =?utf-8?B?cjVuazVnUWEycWYxSGozUjh2VzVDN2lJUHErcUpMS2pnVUlNOHRaRU5nSCtU?=
 =?utf-8?B?OWNuanpoUlNqVkdDRmVMTTRGUTd3djZCT1ZGVXBwZE15ZVF0elR1YThpTnBj?=
 =?utf-8?B?NkFkdDNPYVd4VDFIUHdkRXhhTWl6N2w3TjdvK2VXb3g2UTVodUQ0c09QeTdK?=
 =?utf-8?B?OHJ6bTlBZEIyb2hJQ3FvNHI0MXhvbHptNUswOUVOeS8vVVVMWTEweHorQksz?=
 =?utf-8?Q?wWEUEZ3ICWogc9fR87fZWlAd0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ccd8b9-adcb-4921-5154-08db73505ecd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 18:42:02.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDq26weKmOW3/c+qZ4+kyiNfeSUGcPVSpN8UnOMwdl38Tuj7ba51SZsEXwYz9xl1Fy2fyxmesUsw2LzpKHL4bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/22/23 06:45, Jonathan Cameron wrote:
> On Thu, 15 Jun 2023 14:24:01 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add SRAT parsing for the HMAT init in order to collect the device handle
>> from the Generic Port Affinity Structure. The device handle will serve as
>> the key to search for target data.
>>
>> Consoliate the common code with alloc_memory_target() in a helper function
>> alloc_target().
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
> 
> On second thoughts - device_handle is rather cryptic as a name
> and there are no handy comments on what it is.
> Can we call it gen_port_device_handle or something like that?

Sure. I can update and send out a new series.

> 
> 
>> ---
>> v3:
>> - Move ACPI_SRAT_DEVICE_HANDLE_SIZE to separate patch for ACPICA
>> ---
>>   drivers/acpi/numa/hmat.c |   53 +++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 50 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index abed728bf09d..e2ab1cce0add 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -71,6 +71,7 @@ struct memory_target {
>>   	struct access_coordinate coord[NODE_ACCESS_CLASS_MAX];
>>   	struct list_head caches;
>>   	struct node_cache_attrs cache_attrs;
>> +	u8 device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
>>   	bool registered;
>>   };
>>   
>> @@ -125,8 +126,7 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
>>   	list_add_tail(&initiator->node, &initiators);
>>   }
>>   
>> -static __init void alloc_memory_target(unsigned int mem_pxm,
>> -		resource_size_t start, resource_size_t len)
>> +static __init struct memory_target *alloc_target(unsigned int mem_pxm)
>>   {
>>   	struct memory_target *target;
>>   
>> @@ -134,7 +134,7 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
>>   	if (!target) {
>>   		target = kzalloc(sizeof(*target), GFP_KERNEL);
>>   		if (!target)
>> -			return;
>> +			return NULL;
>>   		target->memory_pxm = mem_pxm;
>>   		target->processor_pxm = PXM_INVAL;
>>   		target->memregions = (struct resource) {
>> @@ -147,6 +147,19 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
>>   		INIT_LIST_HEAD(&target->caches);
>>   	}
>>   
>> +	return target;
>> +}
>> +
>> +static __init void alloc_memory_target(unsigned int mem_pxm,
>> +				       resource_size_t start,
>> +				       resource_size_t len)
>> +{
>> +	struct memory_target *target;
>> +
>> +	target = alloc_target(mem_pxm);
>> +	if (!target)
>> +		return;
>> +
>>   	/*
>>   	 * There are potentially multiple ranges per PXM, so record each
>>   	 * in the per-target memregions resource tree.
>> @@ -157,6 +170,17 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
>>   				start, start + len, mem_pxm);
>>   }
>>   
>> +static __init void alloc_genport_target(unsigned int mem_pxm, u8 *handle)
>> +{
>> +	struct memory_target *target;
>> +
>> +	target = alloc_target(mem_pxm);
>> +	if (!target)
>> +		return;
>> +
>> +	memcpy(target->device_handle, handle, ACPI_SRAT_DEVICE_HANDLE_SIZE);
>> +}
>> +
>>   static __init const char *hmat_data_type(u8 type)
>>   {
>>   	switch (type) {
>> @@ -498,6 +522,22 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
>>   	return 0;
>>   }
>>   
>> +static __init int srat_parse_genport_affinity(union acpi_subtable_headers *header,
>> +					      const unsigned long end)
>> +{
>> +	struct acpi_srat_generic_affinity *ga = (void *)header;
>> +
>> +	if (!ga)
>> +		return -EINVAL;
>> +
>> +	if (!(ga->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED))
>> +		return 0;
>> +
>> +	alloc_genport_target(ga->proximity_domain, (u8 *)ga->device_handle);
>> +
>> +	return 0;
>> +}
>> +
>>   static u32 hmat_initiator_perf(struct memory_target *target,
>>   			       struct memory_initiator *initiator,
>>   			       struct acpi_hmat_locality *hmat_loc)
>> @@ -848,6 +888,13 @@ static __init int hmat_init(void)
>>   				ACPI_SRAT_TYPE_MEMORY_AFFINITY,
>>   				srat_parse_mem_affinity, 0) < 0)
>>   		goto out_put;
>> +
>> +	if (acpi_table_parse_entries(ACPI_SIG_SRAT,
>> +				     sizeof(struct acpi_table_srat),
>> +				     ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY,
>> +				     srat_parse_genport_affinity, 0) < 0)
>> +		goto out_put;
>> +
>>   	acpi_put_table(tbl);
>>   
>>   	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
>>
>>
>>
> 
