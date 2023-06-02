Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D27203B8
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjFBNt5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjFBNtz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 09:49:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC421B6;
        Fri,  2 Jun 2023 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685713794; x=1717249794;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N7oWLXRHLDAHjKEzB4561LnhXORzxOXVY0ejVUtoNJs=;
  b=eroKWNN8SaT/SPj/0VaewChE+RMpdJpX7G9/wqRbA+Pu4LH+Vdb+JM8N
   qGNDl7qtELa+6WeprPDXORoz6JcC8vQ/nLfshoceebeNzucpXBq8V+3Rl
   9hB79Rvb7na+aaU4/5Z1sNHhZymzb4WejSeOyXuTCUzw7D9Ut3rMz7zLl
   /BghsHUf1k2wQzTS1/w5TdGiMqiZgaMfclwbVsIZ2yvr9w8TzcAf8DDI0
   E+ZtmFO52WHQwon/IW3DtqbBk4DjQAEmT2SVviXRqWYTU16k5WWvWQ+bx
   BeJ5ot5gY+/OHNLGRJ0xWzKj+Jtt9eLSVv40uJDDZn9mpeWwN/wyGVFVR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="336234763"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="336234763"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:49:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="772889926"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="772889926"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2023 06:49:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 06:49:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 06:49:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 06:49:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 06:49:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMiaz+pDX6pC3Frt4JDi0aPqaN3PTQqUfSwNhIVIqyeHxoWNUetFPPMzEzLJQus981cyRTHkyYtr7DcghhRMEgxD32nOabijhgRfWVQFILD9S/bI+89xdOOjV4Le+5xJhzpqKWVlZ65m9sZ7GLhTTAGk6rrAiLkleJGMrcJWjsBeadVFtH5eohq88r5DZclzU4D9f7x2ALkFVTLIC5aH6UusHxSnxhfTEYeuVyQ5BymLs6C9KxA9ct6AmQfGuQniQREEeZtDbw7KtcbBL3WTp01VJAYkdOw1q3YJFizqwiXPmVsvQrxr6ZfRhNcx2PQbw07T7SlPc5v+/BdStyahJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVieT5J8Qk4LfU46Iq3NEr+1A18rNke8Vauc1YhFR2s=;
 b=F23KfXbQgeS4C57P6twszAJPYy7AfR4mgAfE3+A39DsEtfMgrP18LoYk2Sxece0ChozV9ilI7N5BUPEf1DjWyEnGf13i0Nuzs2AzeT6b3SJc9DNCd2QTP/MG8ssozX+f25/g5MfuK03KFedpgJcI5/QHQ8sbMLlWR3SG+g/Yb1hQ45elMwwz56VLQcYxU3TtSrnn7K1ZU6V10yw99mnzdbdnBXtRyNarYjgoMLIgOHoKwfeti0cqu6Gkce8iOsAUDyRMwE4SN4EwM4n+mJIS7J5nYCt2ev2naPH11p7k/qGeAeUfHH3ssquFGc5vg2YNtKdjjjeWKfH2BJieH5msTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 13:49:47 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 13:49:47 +0000
Message-ID: <7fcb9041-9a78-ac9e-6a23-47bbccdfd30a@intel.com>
Date:   Fri, 2 Jun 2023 15:49:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 21/35] platform/x86/fujitsu-laptop: Move handler
 installing logic to driver
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Jonathan Woithe <jwoithe@just42.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <rafael@kernel.org>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
 <20230601131739.300760-22-michal.wilczynski@intel.com>
 <f0e58bde-c1e6-872e-3879-ab3c2dadfd7@linux.intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <f0e58bde-c1e6-872e-3879-ab3c2dadfd7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5c33f8-b646-4c7f-2ce3-08db63703a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dcee0eup/sR+3lEPHctNLcVppr48klRdz4uZCUl/OlqIxkX72iEKP+x4DWlhw7m2W/2CZMqfVW+jHelKRCmVmgvL7MmjpvTy6neEEE33acbjVQv3/nBBFpW42OE9srSemp7jGita1de18KNinm1GopYI7jkOcDgLltti+KEmuF4aUb1+ogQAq2TI+c+EYLoGWBSPcv/6Da56J4B5m9itL9csadzWpeHT10rvqDlHG2DOubcRGGixnHtKj0G23sKnMNXOtBb+7yVnR/raG8a8lVxNwJPziPU3kfOVeawFl1JOiatOUDM3X/qf/QQdbjNjq1y/9FY2/9Gl6mkVHQbJi6ROVkZ18gPsOlORv199e3YuFwbkm4kXmwiiCmVzZ9r4zyafEJ1mWZxGcI7NM+LLkrgGvqrgw3hCA7GKxpZxQhdP+DGMhw0Hw2QCcpjfk6hUv3jPm06rTAOLh/kWU5o+8CjxFO2FkwcONg1KB6oQXxdX5QD55wkc2+Salq2QFJKEmVocMHm0pMbHG3rPJWtqJfgN2vn8eeTPvUL2EmcxEN3zYfZlJQ/EcTa6U45RsqACT2lgIwwKxJ0i6K+8wyA+oEQ6EBzIJXvzJbMS/ylOJoaxIsHll2DnbkCPo+U9U9li0hbtL2UL73rSrBAvdtgXgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(82960400001)(36756003)(38100700002)(86362001)(31696002)(31686004)(66556008)(41300700001)(8676002)(6506007)(5660300002)(26005)(53546011)(6512007)(2906002)(8936002)(186003)(6666004)(2616005)(83380400001)(478600001)(6486002)(66476007)(316002)(54906003)(66946007)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJQSE5pTXVBZ0h3dWdCQXhpS29lZnVRRXZMbHJodVVUQ3JXYW9KcXF1bjBG?=
 =?utf-8?B?elRKWXF3ZlgvY29tQ1R1M1IrVWtQbUc3QWc2UWd4c085ekJsMjQyN1ZMVXRN?=
 =?utf-8?B?aU1vaWw0UVNYNlVORDBRQVk3c3FIdjBnUjJCa2dVUVZ3SVgwbjVUTWdjVjlP?=
 =?utf-8?B?b2VFL2p0MWg0QWZEdlJ4N01rcVdWRWF1eHppaEsyYW9MWm5VWThKV3QrRnhQ?=
 =?utf-8?B?U29zQlEwbk1HVjZQdTVGVjVvTloxbEVuYyswWGRveVpVblJVeXoxUTNiUnU4?=
 =?utf-8?B?TjZaUFF3bld3UWtTa2d5NHdpV2hIUmlwMCtMVTJqcW9WWlBJMTlzaENPZDk5?=
 =?utf-8?B?N3lkZVUrTGRZMDdHZFNRTlBpNDczdktZR0psVEtJL0hTWGxpWmN5YmxLUGVi?=
 =?utf-8?B?RHRLdnBTSU9uUFc1R080YmZZaWkrN2FxV2VVdkovSXYvcEJ5UjZJc0VXSXBj?=
 =?utf-8?B?RFJQMU5Rb1lnNGVRS1ZBbGxHUHJDTlUvcVA0Zk9KQnV3eERUMjlsdm9NaTBL?=
 =?utf-8?B?ZVBGSDhEc1VJMmh2dXA5UlVmaVNLVGtpT0RUVk8vOVFPbUQ2SFJCU0cwelpY?=
 =?utf-8?B?UDJPTXZCSzVabDNsOG9XMDRuRFRaMEJzQ21iYUx0Q2tHMjJBWG1nQUdpU0Nu?=
 =?utf-8?B?Mk9VbHoyWnRJQ2ZtTVhlS3g0TXl3WTV3WGEvT2FuM0lGVHJvZzZoeS8zSjQz?=
 =?utf-8?B?S1JObmk1ZG92TEZzWUxxR1Y1N3lzclp6dU13TElLVWRZMnBFN0VCNSsxNVpS?=
 =?utf-8?B?YVFSbCtjdnlPV1I2U1B5RXNscDBJMXgzUU91a1ZrWmVEV24xTll3emFMYnhS?=
 =?utf-8?B?c3htbFFKbHhqejVWNEVNbFppS3pVcXhzUkhrRDYyNWxTK1hNaUpVMzVLQ09x?=
 =?utf-8?B?Rk1RWVZlWW13eXVpQVVyTHhhaThLdU1jMmQ3ajY3VE93WUFXcUlEVGdpQzN2?=
 =?utf-8?B?cE8wSWZEcGJGeXV0d3hQVUNuQzJHOEsvcHpDc2R6MS9JYUc1S1BHMTEwTjZv?=
 =?utf-8?B?RjFCbFowSmtvT25lVFBJOUZUa28wMWVGNERieVZ3UjlPUmhNTUVZaHFEN0Qr?=
 =?utf-8?B?QkFPN0xoOFd0TE15T1NUN09vbTBSUEgvVmZBSk5LMCtPcnZSWEdxMGVEOFJI?=
 =?utf-8?B?ejJORGp3eVYyekpsSGUxbzJtbHlCZXRQcXBNWEFhdVNWSmJBSWlUd3VFY2lJ?=
 =?utf-8?B?NTBFWnJJMnhHM0N0SDBXRElmK0pUUFNHSDNIdWx2QkFNUHBEbXJVZ0pBYVhq?=
 =?utf-8?B?Y0NodCs1K2JVSHo1UkdKSWpLZ0xqUGZrMjZ3bXRtd1BMWGVlS1lxMTBHckxL?=
 =?utf-8?B?ZTMzU1RPbXFzeFV3UXd6dkttOTZQTjlKS2E3YmtWelNFaWM0eEZNK3NJcVJX?=
 =?utf-8?B?V2pTQ3dseUwzbmM2dWxTUHlKRDNnMGhQa0RYUkplQmxEV3lLZDdlZklTTmNH?=
 =?utf-8?B?RDArdTMvNkJLRjZkUFRqdGxKR2IxMmJxNStyam9wT0wwNVJLMFN0T3dCbW5T?=
 =?utf-8?B?L01Nb09QNXVNcWR1L29GazRsU1liQzFSaFNNWEpMSERMQnZTemk5RkFjNzI0?=
 =?utf-8?B?NnU2Nlp2emNsdkdOcndTV21QSjhWMDd1Tk8zSkhmOVJncGJSTFUyVXFUTHB4?=
 =?utf-8?B?bkVyMDhwd3ZlazBuS01qNnpWL0VFeEFxRGRFLzVTM0FraEw5Y3BZY2pnRWxG?=
 =?utf-8?B?bDFsbFM2S3B3aEtSc3RlUnVnL01FZUdVbG9PckNFcXBzKzREWEpPS3E2c2Zk?=
 =?utf-8?B?QWF5enptNnZ0cDArdFZSV1FCekNJUEp0R0N2UFFTZ0lwUm9OTXREeVA3d01K?=
 =?utf-8?B?RjFPU0pUSlV1M0laWTBPMi9qakh3Q1hxSk5ielNmcWUrdHdiUXlxZ0pzeTBM?=
 =?utf-8?B?TTJEcWEwUXA1WHRKWGNJRTIweU9UaVlKMHpYUG1PU0I5V1dHSHlXMW0zelZr?=
 =?utf-8?B?Rm1aUGNJb3ZCU3AvSzhLeG1SRzk5VVVUNGNScHZTNG0rQ1crbmxsVzZvY1NM?=
 =?utf-8?B?N3JzYzZzVW5tdVBmNVNLcnZjbER5QTRwVTFpTUw4dlg5MmFYK0Z4d05VUnUy?=
 =?utf-8?B?WlV6eDA1eDNrQWhybmNwVVRrL1laeGZyYkVhUk0wVVVZMXMwaE9GM2J2YzBa?=
 =?utf-8?B?bi93YVg5WWdadzZKdTBCNHlERHN6MTBmQkNrd2g4S21qS2ZiaXBZT3huZjlz?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5c33f8-b646-4c7f-2ce3-08db63703a5e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 13:49:47.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBIPI3C+355cseRW81eYMUHIKQDLFEftjsBhM89SbVvwjtwLFR8dDC8PwgjKlGDGnYgESSihPdcujWQlHrUr9uteW83kmnwHyzsHRNskCSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/2/2023 3:30 PM, Ilpo Järvinen wrote:
> On Thu, 1 Jun 2023, Michal Wilczynski wrote:
>
>> Currently logic for installing notifications from ACPI devices is
>> implemented using notify callback in struct acpi_driver. Preparations
>> are being made to replace acpi_driver with more generic struct
>> platform_driver, which doesn't contain notify callback. Furthermore
>> as of now handlers are being called indirectly through
>> acpi_notify_device(), which decreases performance.
>>
>> Call acpi_device_install_event_handler() at the end of .add() callback.
>> Call acpi_device_remove_event_handler() at the beginning of .remove()
>> callback. Change arguments passed to the notify callback to match with
>> what's required by acpi_device_install_event_handler().
>>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  drivers/platform/x86/fujitsu-laptop.c | 86 +++++++++++++++++----------
>>  1 file changed, 54 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
>> index 085e044e888e..001333edba9f 100644
>> --- a/drivers/platform/x86/fujitsu-laptop.c
>> +++ b/drivers/platform/x86/fujitsu-laptop.c
>> @@ -136,6 +136,8 @@ struct fujitsu_laptop {
>>  
>>  static struct acpi_device *fext;
>>  
>> +static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data);
>> +
>>  /* Fujitsu ACPI interface function */
>>  
>>  static int call_fext_func(struct acpi_device *device,
>> @@ -382,6 +384,37 @@ static int fujitsu_backlight_register(struct acpi_device *device)
>>  	return 0;
>>  }
>>  
>> +static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void *data)
>> +{
>> +	struct acpi_device *device = data;
>> +	struct fujitsu_bl *priv;
>> +	int oldb, newb;
>> +
>> +	priv = acpi_driver_data(device);
>> +
>> +	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
>> +		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
>> +				 event);
>> +		sparse_keymap_report_event(priv->input, -1, 1, true);
>> +		return;
>> +	}
>> +
>> +	oldb = priv->brightness_level;
>> +	get_lcd_level(device);
>> +	newb = priv->brightness_level;
>> +
>> +	acpi_handle_debug(device->handle,
>> +			  "brightness button event [%i -> %i]\n", oldb, newb);
>> +
>> +	if (oldb == newb)
>> +		return;
>> +
>> +	if (!disable_brightness_adjust)
>> +		set_lcd_level(device, newb);
>> +
>> +	sparse_keymap_report_event(priv->input, oldb < newb, 1, true);
>> +}
>> +
>>  static int acpi_fujitsu_bl_add(struct acpi_device *device)
>>  {
>>  	struct fujitsu_bl *priv;
>> @@ -410,37 +443,17 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
>>  	if (ret)
>>  		return ret;
>>  
>> -	return fujitsu_backlight_register(device);
>> -}
>> +	ret = fujitsu_backlight_register(device);
>> +	if (ret)
>> +		return ret;
>>  
>> -/* Brightness notify */
>> +	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
>> +						 acpi_fujitsu_bl_notify);
>> +}
>>  
>> -static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
>> +static void acpi_fujitsu_bl_remove(struct acpi_device *device)
>>  {
>> -	struct fujitsu_bl *priv = acpi_driver_data(device);
>> -	int oldb, newb;
>> -
>> -	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
>> -		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
>> -				 event);
>> -		sparse_keymap_report_event(priv->input, -1, 1, true);
>> -		return;
>> -	}
>> -
>> -	oldb = priv->brightness_level;
>> -	get_lcd_level(device);
>> -	newb = priv->brightness_level;
>> -
>> -	acpi_handle_debug(device->handle,
>> -			  "brightness button event [%i -> %i]\n", oldb, newb);
>> -
>> -	if (oldb == newb)
>> -		return;
>> -
>> -	if (!disable_brightness_adjust)
>> -		set_lcd_level(device, newb);
>> -
>> -	sparse_keymap_report_event(priv->input, oldb < newb, 1, true);
>> +	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_fujitsu_bl_notify);
> Please move the function in a separate (no function changes intended) 
> patch to keep this patch on point.

Sure I can do that, however this moving around make sense in context of this patch as
it's necessary to compile with the new event installation method.

>
>>  }
>>  
>>  /* ACPI device for hotkey handling */
>> @@ -839,6 +852,11 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
>>  	if (ret)
>>  		goto err_free_fifo;
>>  
>> +	ret = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
>> +						acpi_fujitsu_laptop_notify);
>> +	if (ret)
>> +		goto err_free_fifo;
> Here too, fujitsu_laptop_platform_remove() is necessary, goto + put it 
> into the rollback path.
>
> Please go through your patches with these rollback corrections in mind, 
> I'll skip looking through the rest of platform/x86 patches until you've 
> done that.

Will do that,
Thank you for your time !


>
>> +
>>  	return 0;
>>  
>>  err_free_fifo:
>> @@ -851,6 +869,8 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
>>  {
>>  	struct fujitsu_laptop *priv = acpi_driver_data(device);
>>  
>> +	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_fujitsu_laptop_notify);
>> +
>>  	fujitsu_laptop_platform_remove(device);
>>  
>>  	kfifo_free(&priv->fifo);
>

