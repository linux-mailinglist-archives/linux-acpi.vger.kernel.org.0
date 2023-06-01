Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4D71A3B6
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjFAQFp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 12:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjFAQFn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 12:05:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967BF13D;
        Thu,  1 Jun 2023 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685635537; x=1717171537;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G4G0BJE6LUqKa8Tsma8geYTtCmwZAdUvSfjtC5TxPwk=;
  b=JyjTSvYrqVdB7M3brMNYj9OOMMX8dP/Tuuzl+yOypkmmULC8viv0ha2g
   M/XFCLubyNza46wyxIS7+NerxoqdTRGAN+JHM8CzJM7WguT6Aj6XW8ETY
   VyaS8Xj8+qLIKXDGggDlUR14b2FZYFzZ1bYwGYVlbsMUNLNWXddD5AWfN
   fuktzgBnMWqjDEz5vlsr3//15InzmY7joCi5E733icVp4M1HQlVH8Uq15
   YzHptyKCN3o3jjrwWvezM6csXKzrPDaGjBaMtTEQdF3HibORu6ZrDU07J
   rLCpeK/bZuw3q/Hx6mSZ/MWJ5/Q+ayMiJC7xxcbAOumJSVoIWw+p+GgTp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358897843"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358897843"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="1037558028"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="1037558028"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2023 09:04:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 09:04:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 09:04:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 09:04:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 09:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1HGHGhGwez7og4OiuLePfEOpYWdg6txAjT71Pcta8KdTOe0yrx1YEbG9IlPnV3zWNmz3Yr2CsV0OgspSyVhu7X+gozuJTgv+Vps28RGyO7E6Yd8i/olDjHfuJ6MNPlSAOuqdgdsKR3PrTgZ0ac18BqwCiz9dWZFexo8pD0Y7qlPSEbXHxSWSccbtMcBa32Aenl4bsnKYVsl4qwX71e21h5Tz4nMpl3oFAtjInQVicd3RHQGqFRnuEtHlHJuSEQina+O0WNluvXfsGhj0wBCzTHKy6pMgi4R2LVcpKJSMjuYPop50jUOZ3qs85Z4fFilnpXz54EZ5DRfIXpUrJWDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnzecxC2TlsiPA4sH3s9+Gj1iJf1K/UCYc7PEyWUc2k=;
 b=JnjIM1ruf8Vplgjjl+gsy+UHmodmYaS14b/1gjioPB0k7NVAxiq44gQ6390NW84QwMYpsRDIT/lwnaBA0o9X7fcs+ymaYMkUBE17MgIVdjp88Dmtm2S8LETbkKJR8ULDlDxd5XTLuAh3hPONm6QTea+5TpBADHN+AqCTMUa8vkMIumF0wvQ3VJGabYpThIxBkTZCGz/ZexYE3eOAwg+LM5DVHzCTxbl+I+InDGSzRZ5DIGirFZ/Dnq2UKVMneNn2WcbAN/NjhuRu9pkpQGu8BOJegIUVfnVVCkhnzGZSI5/QFD+MiEkvmZiLJuyi6KjztheRoJQeXiSIYWetQrgoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA0PR11MB7694.namprd11.prod.outlook.com (2603:10b6:208:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 16:04:39 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 16:04:39 +0000
Message-ID: <c04beb16-07e5-1e15-332d-c2f0137cda5f@intel.com>
Date:   Thu, 1 Jun 2023 09:04:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v2 3/4] acpi: numa: Add setting of generic port system
 locality attributes
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
References: <168451341624.3465146.15355962690295941676.stgit@djiang5-mobl3>
 <168451347867.3465146.10428399827479313906.stgit@djiang5-mobl3>
 <20230601153844.000071fc@Huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230601153844.000071fc@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA0PR11MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: e16db056-6279-41e2-31b4-08db62b9e714
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKgk+m4TR8TFN0seuFiVGhym4CdlaPKz/7BnfGq/BB9csRFt58R6avW85Pj4D/zGa6PFTcW9LqP6DSxnDpSAxRcQdItcjVMU4i5WdVkn8T8xxIgCJI91JVyGsYEUM+3ZAb9Z4B/hC9dNiIFdIvb0Z9+qYPDexP1lwHgmHs8MpQfk8RPUxYBHn8ZPLr7crpG8hJ6pWjJ6EcM0b6uV5o8KxRXOBeetlYy1pjKuYwjnvv4dDooDjt6vOk/ZK4TjVbQwmVm7QGPd8R4UbS8fY7bMJ/JvYoH/IgyT9n4yNtxWxGS8bRi9xkvwmXwFxUbWtmbJS1O0p1Bqfz3cIlVysSPRVgSZCvj8OVEPHV2BA20EOmLq7C1yBEjhJl2c+fJ0Sj9ww4BE1aq1gEd4xcocev218v+kmd7RDVQdS7j5+UdHCEcfnZJQ2TXb6noJdpkVw/NrHe99kUgUxr1j+h9hWattwvWMfmIf0bm6Uy82XyVqWe8Yj/iUPQM2mPWu9QnVeQc1V2hO9HsSxnJ9JWuOQbLSMMnSrph3pXH1dg7j8bT/QQczFKV0ToGG++BTlsXDpVeDCgIzUqiNGoarYXmfRnQPNp+mcjwHw8nONWyMQnv2B+dtx0Fzulbk2M3yrmUsmdM4hhHsnJzDutmSrqrGE2qO8OUjEvnoC2CERRB6IWSqTlg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(8936002)(83380400001)(186003)(2906002)(2616005)(4326008)(6916009)(66556008)(66946007)(6486002)(66476007)(6666004)(316002)(478600001)(53546011)(6506007)(44832011)(5660300002)(26005)(6512007)(41300700001)(8676002)(38100700002)(82960400001)(36756003)(31696002)(86362001)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGY0RUVNRjZwOU9Renp4NDkrYlVOdXFzV3NSbnIrM2F4Zk42Q0pJY0NhNDdl?=
 =?utf-8?B?cVd5SCtQRkFJTUJya3lDRVlMRXcwcG5Fc1p1YkF2Q2xlRk9oWE9iUXljbkNU?=
 =?utf-8?B?eDZBUGdLS0VKOTJlTjFjK1U1R1JwMnhXTkk1dVRTb0Y1Z1hHcUhCOXIvWDFk?=
 =?utf-8?B?bVVRMXFGblJUTDNxb2JhNVVLNHdwYXh0UE42RFN3TVVXcjJEQlJFMi8rTlNS?=
 =?utf-8?B?eWR1WXcrUTZqcjNrOFB1Wnl0bUM5MCtJU0pkOVl2T2pjNjNIeXdQQXpDS1Z5?=
 =?utf-8?B?U0ZrY3U1bG04TnBBR1ZWUkcvVGpkb2dMOUxGY2tIV2FKeUtUYWhyV2NjUlc4?=
 =?utf-8?B?ZTN3ZnRjY3BOUTI2YytEVUR2c3FiQlJid2N5bFFMbnJWY2JndU1mY3hSMW1I?=
 =?utf-8?B?dGFzdm1Takk3MnVwTDFseEp2Ulhrd05kV2ovaGFPOGZ4WU53TXBJckFvaTkx?=
 =?utf-8?B?QWlIZllPUFhMUFJiOVdacDRLdHBqNzBzWURiRUg2VDhFMWd2cytYTU95U2R4?=
 =?utf-8?B?UmZGcnZaVmREUlpOcmMvNUR4VjRja0t5VFc1WnNaaHZWVGtUU1F3cXVETXBU?=
 =?utf-8?B?dlFMTVJQdWhoU2lXYWVheHJMVVhTa0FoY2FaeDFmM25xV1BnTWlBcTJuK3VS?=
 =?utf-8?B?cEg4cW9zRkFNL25jUHZKRDkyZlhEQkVaN1FrNVAxdUtCZDQ4b2NERzE4R01X?=
 =?utf-8?B?bDhJd3d5WWNwMlFEWkwzWDUyVEZGNmJod0RmaTQrRTRXNUJ2eG9KdDNyT215?=
 =?utf-8?B?ck5uZm9TTk5reHNIdVBUT0NsSVJ6VUNsSDRzdWg0S0RKZUhBZGdjenlhV2hz?=
 =?utf-8?B?OFlhb0dvOFZSaUQ4TXc4QStKaVJXdTlhTE91Uk9VZ0F4dHljMGw3MzZUZURB?=
 =?utf-8?B?S2lJeWt5NkowdVBDLzZWQzg5QVhzYXVJZFN4Uk03NGN2NXRrV2tEOGJ0eUlz?=
 =?utf-8?B?cjhpbFlIMUpXVWJRUW8wRmQ2SW5DNUJCZU1hbUluWEhSN2ZYTFByV1ZnL0th?=
 =?utf-8?B?VENkc1Y0ZHhxOFlFYU1hdnVhdmg2c3dlb0NDZDdJc2Zma1RhVlhHRjFJdUNV?=
 =?utf-8?B?U0t5VG1XMWI3RktsZUJWSDMrblQ3K2xGbkFvK3RWQm5HOHBPNW01N2JiVStK?=
 =?utf-8?B?RTFpbUxSaEFnU2Jhd01VOXNpdnc3V1FnWVJtc0FoME83ei96M0VZNUdYZXdC?=
 =?utf-8?B?UysxUWtNVTUyVGZSL01RWXlZYklaNWhHYjFQMVJiRFk2MmtmNlZPSnRxQVJu?=
 =?utf-8?B?WERpU3RKYmNRcW4zUGo1TUpzRitQbG8wRTV1bmJvUUVYUGhUZ3E1MVZRTE1X?=
 =?utf-8?B?NFZyWVNmU09iOTEvUVZsVDB3R0diNDRia0JHK08vTk5ncmlaMlBqWllrbWJZ?=
 =?utf-8?B?UFdsNHdOb09LdHBBS1NqY2FOWlY0R1RYUUptNGRRR1dkS2JzR1I2V2NtVUs2?=
 =?utf-8?B?azdjN1FFazJQR3hXODZlREpSd2hlYmx3TGtJa0ZYS244T2lFQVFtVmZiRGls?=
 =?utf-8?B?eFNOSjlqTG4rVy9sQnZSZjVYUTFsSzFUbTZwWGRyRlhITUlWTWNQaUdjSWFD?=
 =?utf-8?B?NDN4MC9nQ2N5QTBHNUIwSVBNR2JkSXpIYWtpMFNoMHpEMG5GdDZ5eC9qcjZN?=
 =?utf-8?B?Mk9ieFZvaDlWdTQzMm04TE10SmxrT05xYWpOV1RnOEpZTzc5S3pEUG1aRlh3?=
 =?utf-8?B?dS9GdkNWWlMxbUpJZ3Y2eE1LRTlXbWVmQTkycFljNTgvb0dGS1FYUVVaWUtN?=
 =?utf-8?B?R3lEZUlMdUlVQmcvckhWeWpCSmc2NHpYN0lUbFJFRHBpc0RjbklZeVluamgy?=
 =?utf-8?B?bS9TdUZZRFMvUnVHcEd5d3ZQdEtScjFYVDVxd1ZZOXpOZmhmbXFKdVl6UXZV?=
 =?utf-8?B?UnlmQktCRXlLMXl2WkhmTHFieTZZYzJvT0NaWmFnVnVEYVBqUTZrVTZwK0N5?=
 =?utf-8?B?aDgxeXp1YWdQcGE4UkFWVU9LampndEZBVi9SNDJveTgwRFlIeXJReGJRRFpS?=
 =?utf-8?B?UEYreldiTTR5ZnhET1RLNEhod0Q5UkxIemRiZFpQeFdxczNSMDRMeCtGWmNU?=
 =?utf-8?B?cTdhS0ZWNmIxRU5IU1NwakJoeFI0cnpPK2JObHRTT0xJdkR6d25wUU1GcWpH?=
 =?utf-8?Q?DBnVnT237VXwVqNn+Dw6vMUJ9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e16db056-6279-41e2-31b4-08db62b9e714
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 16:04:39.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhP/Fgl19J+gd5A2GyOqmEe2g7iSrrZc6KpxCzPPebjR4Jgs6rxUSAmOR22j7h9S5Eb4xGSgpAwI8oycp4z5PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 6/1/23 07:38, Jonathan Cameron wrote:
> On Fri, 19 May 2023 09:24:38 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> Add generic port support for the parsing of HMAT system locality sub-table.
>> The attributes will be added to the third array member of the access
>> coordinates in order to not mix with the existing memory attributes. It only
>> provides the system locality attributes from initator to the generic port
>> targets and is missing the rest of the data to the actual memory device.
>>
>> The complete attributes will be updated when a memory device is
>> attached and the system locality information is calculated end to end.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Missing
> ---
> here
>
> As a passing comment, hmat_parse_locality() is awfully deeply nested
> - maybe worth looking to see if some of the deeply nested stuff can be
> factored out...  That would be a new patch however


I'll take a look

>
>
>> v2:
>> - Fix commit log runon sentence. (Jonathan)
>> - Add a check for memory type for skipping other access levels. (Jonathan)
>> - NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK. (Jonathan)
>> ---
>>   drivers/acpi/numa/hmat.c |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index e2ab1cce0add..82320c92abed 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -60,6 +60,7 @@ struct target_cache {
>>   enum {
>>   	NODE_ACCESS_CLASS_0 = 0,
>>   	NODE_ACCESS_CLASS_1,
>> +	NODE_ACCESS_CLASS_GENPORT_SINK,
>>   	NODE_ACCESS_CLASS_MAX,
>>   };
>>   
>> @@ -368,6 +369,15 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>>   			if (mem_hier == ACPI_HMAT_MEMORY) {
>>   				target = find_mem_target(targs[targ]);
>>   				if (target && target->processor_pxm == inits[init]) {
>> +					if (*target->device_handle) {
>> +						hmat_update_target_access(target, type, value,
>> +								NODE_ACCESS_CLASS_GENPORT_SINK);
>> +						if ((hmat_loc->flags &
>> +						     ACPI_HMAT_MEMORY_HIERARCHY) ==
>> +						    ACPI_HMAT_MEMORY)
>> +							continue;
> I'm confused.  Isn't this already what was checked for with
> if (mem_heir == ACPI_HMAT_MEMORY)?

Yes. Do gen target show up as not memory? I couldn't tell from the ACPI 
spec. I wonder if I need to move the setup outside of the (mem_hier == 
ACPI_HMAT_MEMORY)?


>> +					}
>> +
>>   					hmat_update_target_access(target, type, value,
>>   								  NODE_ACCESS_CLASS_0);
>>   					/* If the node has a CPU, update access 1 */
>>
>>
