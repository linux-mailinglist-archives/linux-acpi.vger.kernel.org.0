Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669D755DED
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 10:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGQIJo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jul 2023 04:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGQIJm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 04:09:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D11737
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jul 2023 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689581359; x=1721117359;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oYw/KNBBlFvOsV4iJB5sy01KVXGMGVg7naWiyJcK/7Q=;
  b=GJrlZPs6EfoE7nX9o+eawcpcwW35Ff2tGSsWgJ3U59S+uGhBiY1O4DDQ
   YzN9tStDnhVXLrX1BijQ7IQcmm6uxsXJxGVhPTYqKDcjgKEwcGqZi0YXV
   MhGPqJtiSl3oWv1SwP6Y1aORFHuk215Vx4ESTzXkNXXTzzf3x2K/7v1cX
   ratNVOL5HnKkjHMGcmd2O69dKlTteK8tiopx+Dsqy3KEhEKM8RPVjlDOD
   As6CZi4R9PBDtsBB7gjtsgpjxrmnQuNbLsmkJMxbg+/6jTIUyFtGy3Qg2
   B8yzQv6nx1le9AeB2w4bBxMXqTWllAs1xEGdW/A0bEY1NBMcsP8lIctZ4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="432042520"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432042520"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 01:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="726465392"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726465392"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 01:09:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 01:09:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 01:09:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 01:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYURVToEkVjVU5HKR3E10M62lKS1IM6wKTDhda8o7nsgQQlyyCHEROQl0h69zrikjflyCXkG3nd1FUkkePBB2ATd9WGTbefTM+uUgTt9ZsvuXrn+BPzngnzKLt1e/M47qEsdOkXhdsPlXvmyM/6XHNjFvQvlkNow/YRFCJFnoapVvgtLHBXodtKeEPKATvDrg0srkvJsNwghJJ6gQnB29taxKnXTo17Ph6j7MWxpKabi8FAa+BIjwyvSh2qDsAgFHhNizpfeFQPO4iMxDywiWL5fgbZ77vc8bDSo/YaRqiJQrX4SU+3Pjp72WPIVWxeOoFaXm++oZxhOp2uGS5Gn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXCe4wgyfuZcr1kRrNuR5VleWMvxBI24O/434m+volw=;
 b=m1l40cFrBrKayxlnnCabS1d8j/ba3FGHNiNVWvxm0eAxjoWV2YUr7OByWjtbhKtCp5NV8JxC6JPfBh005Az+Y94gEKFr7p/JDw2F409/UUjXjBdIOL2euJoWfXpFg1AQK9G10jd88eW6rF3W9fC2lvwahyGKzFnQF/c+HolE1MmAmPf5O7TyQYu5PTemh/JSs6jogJHwvYndmP85NS7cchJzfvabZZX28JBAqlUe7ujpdhMFNSSpLuLIpuutXV3jcQ+tsyR6v+Z2ax9SMK5lhvqxnpoB4ILjDWYUHzLuPBFMKNhfOAPTaViBSiOmtMRmeH7hueg0gnquPf0ImH0alQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 08:08:59 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Mon, 17 Jul 2023
 08:08:58 +0000
Message-ID: <e248bcbf-06b0-a312-2f35-5e8c148cd218@intel.com>
Date:   Mon, 17 Jul 2023 10:08:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] ACPI: NHLT: Table manipulation helpers
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <robert.moore@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <amadeuszx.slawinski@linux.intel.com>
References: <20230712091048.2545319-1-cezary.rojewski@intel.com>
 <20230712091048.2545319-4-cezary.rojewski@intel.com>
 <ZK7Ig6TPhnnKs3Yi@smile.fi.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <ZK7Ig6TPhnnKs3Yi@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|PH7PR11MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ffd9fe-0c6a-4221-0fd7-08db869d1264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJn/XrN/s+CC9aMskOxJtbqptLOalJNcNfZyPYXl5JgHUFChuS8M6BKCrkN8fHHhG2wSQjc4sYDtVoljaVN9JlZzwkAfpHt2sIPThhPTtpC9Z6/HnGuyjmO2CSUH1x4VN+l/4O94QCqmsmoD37MJ3pIUcaG4iPE6ArEadjKJQQl0hfwLQCtEI68frq90JjotKOA6XOx0eyAIyRHH/IaQRwHqRIPK3J8l871okOR6bau/GqA5fjrHLrm8OyfOcAqDOx/q18+oe+DNfN5ZQAD0IHYGT1ecjRvb2+/8xXF1rqSGqaoEXtSMbpmrt1pRtpmxnEdFipid6aVhNNh9cWAv47u7/jlP1p3gUzCzXRI2zuj77AuWjYFS06qxXXH6/vYMVWnICpNlcQpE4FRXAHOr8vTG7oB+oQU/r/OPZgpewNJFWRTxoBigFri2lWfcrsrAZt79e2oynDu+epI0ZRXqc5b+JAEHFcENl1tOncmlZju4pJjCRgPjg/oFwLSg46ThYKBacuHbR3t3fUoFDh4+pqB07ykfq1ekpmULxNRU8ykSeg3v6R6bFiCauZ1EWEjYb0knEGwpxKLbaDAgj26HbY3F4EADae+ybVsltZByfWOFKYxJ41A4UtGmqeK0bH6HIulHFd+KvQyEbwMw13JBLHwRCEQRmtA7bMP9j3vj0Jw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(82960400001)(38100700002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(8936002)(8676002)(66946007)(66556008)(66476007)(6916009)(316002)(4326008)(2616005)(186003)(6512007)(53546011)(6506007)(26005)(86362001)(31696002)(36756003)(44832011)(2906002)(31686004)(66899021)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmIxVEltNkVMejY4YjZCU0x1NmtFa0FQMDM1WUNqWFRnWHhRdWZydUlxdzhZ?=
 =?utf-8?B?WmlGWEdFaTl5R2dqM2ZYN1A4V3ZBcHNTYnF6RVNvcnVoMEtzLy9WMW8xMmI4?=
 =?utf-8?B?WDFDUEo2bUNxSVBEWEc1OXdjSERONnUya05RRFY0RElnTjUrb2FpWmhhWUVU?=
 =?utf-8?B?ZVUwNnQ3VUJMdlU4WW5Zc0QwdWM5NEFScDNOdU1pa01nUWZPU1V3OUcvZDdG?=
 =?utf-8?B?WTJtdmFhV0xsUlFGTkhlRVNJM2swUE0zaUZYVW5qZUlhK1dPZVVXb1ppMWVM?=
 =?utf-8?B?NlZHVGlRVzJRSzM2V1NjS0x3elhUSkpaTTFRZDVFOFRmN2puTTNpdlR5ZENh?=
 =?utf-8?B?MkcxMHFrbkJrQ0tURVFIeGVPMGdPVTJaSUN5Nkc3YTFwNzN3OWdPT0JMWFor?=
 =?utf-8?B?ZVZJWHgvSjQyVXVuU2wxWDVUeXBpVHB4UDNNdXMyQmJtVWpwK3JLbU95bEk0?=
 =?utf-8?B?Nlcwa2FGZ3h0MUFnOGFPSHcrdkE4WURkVEJlUDhFZW9nNUVQVE0zNkRxRERX?=
 =?utf-8?B?d0Q5NGdMblhMLzdNWEJlVWYzZ1pDaTZOYzM4OTB4Rm4zWFNUSjZXM3M1WTlW?=
 =?utf-8?B?RHNFcW91MFZCRlZMVStXTlBJTU5MeVNhZEFtMVo2MENFWjdDeG5aRGJUYlcv?=
 =?utf-8?B?bVdEOXorUW1RL0U3QkRnU1dKNXR3N3dRN2tmci9ZMm50ZjdWaEJGc0E0RVJv?=
 =?utf-8?B?NFZYL1NON1Y5dnBxbFR2cENOMElNVXMwS2s1RlhFM0tTNlBQWXZyTUZpK0wy?=
 =?utf-8?B?RE8yTHJkanBOZTVzR2d1Y0NUY05JK3F0WHpnM2dtVjY0NjZnMWxrMTI3VlJn?=
 =?utf-8?B?aEhqcWJUSVNhcGNJWmxadXFVSjlvZytwRVppQkZGUnpKSmcxOTJCQjRXWmlE?=
 =?utf-8?B?SmhIOFJldXVVQlBYM1dFMFB1VnB0bjJXWEMwNmQyL1paUjk3VFJZMVhsUTJC?=
 =?utf-8?B?MHBVMFArZVdDRE13YXZIOUduVWVxdmRJZUR0ZEJFSjhRbUdoNjhvNm9mNGVH?=
 =?utf-8?B?ZW4vMnJWS21CSHQvNy9UdytCS2FMMWtJMG55UWp0REtMWkRTcSsxem0rK1Ja?=
 =?utf-8?B?azB3OWtvYWJVVG5vUlVqSVpWNXBtUUVueUo4ampDUGNURDEvTUU1RkVNc0dI?=
 =?utf-8?B?U3RiVlVlWUxlaEM4Q0wvL01BcVlFcERjRFF2cGN1eWUxMEJlZytKYS9vbmlu?=
 =?utf-8?B?OWFzSGpIRGFZMmhCNHB2d09KOWRBSlVuK0srVFA3WTVobmFacFFFdlYyZHFE?=
 =?utf-8?B?ejFrdHo0eURiTUY0Wjh0TmdwbnBiVDdGYXdHcnZoYmJBZ2R1NVhDRUhiRk1K?=
 =?utf-8?B?VkVibTlCOHd1dkVFWC9leTFBcHNMTGg2RzVseTFzUW9jcE9SOWtNcktBNk9L?=
 =?utf-8?B?c0U0NllZdFdwRTlEOGVEUmZrNzQ0enN2N0NzK2hEdHBhcjNRdXdoRS82ZXhN?=
 =?utf-8?B?aFZnT0N2UDBvS0FSaDcza29jNGlEZEE2UTJmYmpLTTlZMi8zMUN4T3pmcEZ4?=
 =?utf-8?B?WFp4TWhqWkVmaSs5bHRGOG5HVXlOSXpzZzVmbFh5VFZXd1U2VElwSFVBSlJw?=
 =?utf-8?B?YVM2UjdrZ1JSbFF4Smd3cXhIcXEzSE1YTkdqSmQ3dlUxWkpWaHFyVk1NMWU3?=
 =?utf-8?B?N0ptNTIzT0J3czFGZUlRUFdkUTJBc0t2MVl5YVZtWVB6d3dKVmUxSGsvaFZv?=
 =?utf-8?B?RGtmOU1lRDlGcmlRZ1NhQ0VjSi9xZlVmSEVpWC9saVduN3VFcUVnTzc4WXBs?=
 =?utf-8?B?Yk5QN1lSak1ZZTRwY1hTSFVHNkZYRmtEZnVSQURIWkFySDlhTkFjVnJ5WUNH?=
 =?utf-8?B?cVBYcmNjN2svZlRueDZwWXBndk1sOFJVQ2dISVp3Ym9pVVlWQmNEWmtlbFRk?=
 =?utf-8?B?V3FjYkFBcjNhd0hURlFQK2JpcUgreE91dTFxSXJiQ2xBcmZ4SlJPVnNqZWRr?=
 =?utf-8?B?UFU0WGxMVE5QZUFJRDMvRWh1cWpqLzdyTEg2Si95d25MZ0ZvV2c0bkgyVit1?=
 =?utf-8?B?OElFSUlkSkpWcVN5SHZkM2lkSlRZN29tV3N1UUpsd2NSQWl3aXRCNVRVN3Ra?=
 =?utf-8?B?SUhVZGhnbzN0SkhRdnk1dUhYZ2tidWlueGxPWTUzRkQ5SzYybVhaSzdqQWFE?=
 =?utf-8?B?TDdpRHlMblVVZ3FUbU8zVGNHbjlvS2UwVWhhU0MzbEpNTjJPdEZsVjdUTXd2?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ffd9fe-0c6a-4221-0fd7-08db869d1264
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:08:58.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAgwqym1vfuHq8HngOKYuiUMmGRAklcYMq0zJjVAM2yDDmYEfi8DI+6YuLGNYITwnMaWPmfWwKKdCDFYkQIMFdAI4mNDF1evhFiFBsska6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6978
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-07-12 5:36 PM, Andy Shevchenko wrote:
> On Wed, Jul 12, 2023 at 11:10:47AM +0200, Cezary Rojewski wrote:
>> The table is composed of a range of endpoints with each describing
>> audio formats they support. Thus most of the operations involve
>> iterating over elements of the table. Simplify the process by
>> implementing range of getters.
> 
> A few nit-picks below.
> In general, LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> (Please, use my @linux.intel.com address for LKML and related)

...

>> +/*
>> + * The for_each_nhlt_xxx() macros rely on an iterator to deal with the
> 
> I would do s/xxx/*/

Ack.

>> + * variable length of each endpoint structure and the possible presence
>> + * of an OED-Config used by Windows only.
>> + */
>> +
>> +/**
>> + * for_each_nhlt_endpoint - Iterate over endpoints in a NHLT table.
>> + * @tb:		the pointer to a NHLT table.
>> + * @ep:		the pointer to endpoint to use as loop cursor.
>> + */
>> +#define for_each_nhlt_endpoint(tb, ep)					\
>> +	for (unsigned int __i = 0;					\
>> +	     __i < (tb)->endpoint_count &&				\
>> +		((ep) = __acpi_nhlt_get_endpoint(tb, ep, __i));		\
> 
> Do you really need ep to be in parentheses?

Agree. Also, checked how include/linux/list.h looks like and it aligns 
with your proposal.

>> +	     __i++)
>> +
>> +/**
>> + * for_each_nhlt_fmtcfg - Iterate over format configurations.
>> + * @fmts:	the pointer to formats configuration space.
>> + * @fmt:	the pointer to format to use as loop cursor.
>> + */
>> +#define for_each_nhlt_fmtcfg(fmts, fmt)					\
>> +	for (unsigned int __i = 0;					\
>> +	     __i < (fmts)->formats_count &&				\
>> +		((fmt) = __acpi_nhlt_get_fmtcfg(fmts, fmt, __i));	\
> 
> Similar for fmt.

Ditto.

>> +	     __i++)
