Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556A5720332
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 15:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjFBNZO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjFBNZN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 09:25:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1400C0;
        Fri,  2 Jun 2023 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685712311; x=1717248311;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GdDXHr32fG0Sv9UzshE1BB9GXQgg4KWmL1j2TZNDGDE=;
  b=QSZ1/LTDo65qbtJcfJicPZVYZv5WXuyQhSvhtovB3dyzWYMpOaL0AJkt
   bVBjkRVEBp4ohRP5dqdnGp4EmweZzHuwT1xfJEL5FhkakKdwxn0V+SBWF
   hOg3irIVSj20z/w7qxEyqtQLIz0CFX1X/k/J7XsCcXOLpOQuPhoD4g1kr
   aPYAqUPCsV/S9M7ZRliTlzhCY8O4XtAwE0riirsV+HE3dYnQ396PIJ4KF
   EiLcyrqz0vIL5MFgapmPxsDa1902x47lgKQVRj/2ge5ZgExGe6sSzAnHe
   CT7muRl62EkDrItDifdWKSXHQT5NSnjrngD7Iw+bUABYnygVhXCGPrJ0i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="384149189"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="384149189"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="707853276"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="707853276"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2023 06:25:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 06:25:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 06:25:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 06:25:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+XQlFP789jE6VXDum3WPRCWMMbFw6xCwmkKPebo50c3Oh837GRW1qQw59qqzlztaX9LgNvJ9C9nOBgZpGak0IvJcKRrJMvjXlo6Bo/2tQubXVKjRBkVxusFDQQcrkZHRTRXOJPZO0nAcl5zScVXM871Taj22SuM2HBs9x/UrDo61y+123nqEMbr6OnlKHwWxa4YW+VQAr8LaGNeN+otyQatLeTsICAuqhs0/OgcwhQ7KBSmhwCkh++f4h9bjGwMo/0ihPX2kx6uUBLfxVKNl/hdkizG/69y0g1SLA9DgRXdteG0xWNwPgTxuXNiIzTPqpl1Pd/KWSJfTuWnAIYWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dsJYG/5MO6NMbxlSOzgdF5lAwkPjKUCvlRi/g2xwL4=;
 b=mTf6bKILhf7wWrao17AvkzxabYfNcRKRbOsBR75iTPca8uBf+NSyFXnEvwaqjDVcDHi+58nvUB9bnHLH3NhHzGnSowuztoXA9w2t341Gqs67EH89evjXT1M8nV90aWFxea9vxtq16yfYAQWqh1wBK1oPk24zGNyHVRf8XXz8OImKaBGpUES/CFdIRTC51JhswbHmHLGGAHfV1RWnKOKpLKKeYTAoORyd0HZsv/uenVCnmsN1W2bL5rg+ObS4JjpUQfoa2M0E6Arkgu1tTbMme+tZ/wqrxpoiHJdapfrKA5WVqlv7+rDf+GokteCuz2IJrqdINJqAZbcswygBRzWtQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 13:25:08 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 13:25:07 +0000
Message-ID: <4234a6d5-767f-3e79-783f-22bbc8cc864f@intel.com>
Date:   Fri, 2 Jun 2023 15:25:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 18/35] platform/x86/classmate-laptop: Move handler
 installing logic to driver
Content-Language: en-US
To:     Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
CC:     Daniel Oliveira Nascimento <don@syst.com.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <rafael@kernel.org>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
 <20230601131739.300760-19-michal.wilczynski@intel.com>
 <ZHnEpDRJfywWP3mB@siri.cascardo.eti.br>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <ZHnEpDRJfywWP3mB@siri.cascardo.eti.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH0PR11MB4792:EE_
X-MS-Office365-Filtering-Correlation-Id: 20638462-f168-4061-dcf8-08db636cc86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6D5p5BD25oukMiap1F3i2W+aBvrePS5SRwiEcFp77j3pZe1odVvBDwbdRZDgtyXjF4d4ds+UnJ8pSMCxk+1b+rLHDGRl9xohpMiT27ifmsOO7kMWNXIIsCAyxnccT1GvM4bMcBkmfN3onypsZcqUQrxplT+UwAD1mjDnI+bO4iMLu8yojNBUzIEJwavw5Y1sZGEdUmHcrfasaVWSte7EXB9ozZpM2z79JSqTE6x9aZZ7sCG/LXnGgELSqPQ5XO2GhuYGneHM8z/lAwpw2Nh3adISDYa0z2HLsdQxkccSFfSCQ14TL6DO1Ze+TUObE4A0tn3zotXUJgXb09z5ivHo5B2cjEePRUZGj0CHKz6b5zaaoK98i3cM4C8U8Qj25KkJWX9a/hIj0qOJJvHnndT5kKne2s51Ot5pHMnBPqy7j+YrRhS4ZZcp0qaRXWfTrFFOSSaD5EZDUPWmrW0w9JrF05IU4HNezC45O3T8R8Fe+dahHYQYIzlAC1+MlcU6UnE7qidzgD4Z0Wm6t5QcDyS22sJcgbXMjt/nKtFanvf6mZR/Lo3k9fISKcuIVctH9DHfC/YjAd2nGctHvMPbAGo79xJDidNWWCJCizqyxkLlYVCQRVQEw14pJ/1NZRu7/KhMP6qD3V31KDkZgTPg2Dqeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(31686004)(83380400001)(6512007)(26005)(186003)(53546011)(6506007)(41300700001)(38100700002)(6666004)(2616005)(6486002)(478600001)(54906003)(4326008)(6916009)(66476007)(316002)(82960400001)(66556008)(66946007)(5660300002)(8676002)(8936002)(31696002)(2906002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5TMEtGUUtzczdJY3pyZExJYmtMeXczM2x3OW1NYVE2MUdQRTVacUJiWGlR?=
 =?utf-8?B?WDljOFJ2dXYyRWUyK1E1cTNaL1JESUdUb2dJV0NtaTVUN0d6cDdDQVFBZEs3?=
 =?utf-8?B?V0dER0tNbjJGVmNOcEtPU2VTQ1ZQWjFmbWExa1FnYUF0Z2VTZEY5cGlNUU5x?=
 =?utf-8?B?UWROUnVCNS9pSkFRSkV6UmJkSUJaNVdhVDdEaFRnRGt2WGg2T1JGOFgrY2FV?=
 =?utf-8?B?Y3VFRlJwRlJ3bE5mZUhlWEVrbHMvYWdDS2JZZlFvMnd2bjlDZWd2STc2bDB4?=
 =?utf-8?B?a2hMY0pzMG5uVXYrZUw5Q1FmWFN1dGlJR3d5cThlNStwVjRLcnljT0Jpa2pM?=
 =?utf-8?B?UWxEdlJnTEJvdU85ZUdvY2xOWVFXM2VpVUY3WW80Umk2MDhUYXlvUTkyRmx5?=
 =?utf-8?B?OVpsaWsrL2hzZTA4Z0pLWmZ3eXdhUS9pMjRwcFRDQXcwRnQ2WEVWVUlXWmY0?=
 =?utf-8?B?M2xoNUZkemdpa0tOR21WYUdnSlRyejdVN0dJTWZPS094RzNteXhWZ0FyL2t0?=
 =?utf-8?B?eVJVUlp6Z1JxanZCd01aZmc2em5nUk5HdDdibWdXN1hhSVMwamFCNXhvOGNu?=
 =?utf-8?B?UzVDd1o2ODdxNktHZElFYUYvU0pXRkRRRElJWnhQWVNuRm01Uzd4VzY5ZSt2?=
 =?utf-8?B?cVY1MTJsRDdtUEJ1bVozOGhNR1lpdzB6K05mOE1oSUtTbUp5L1R5NXQzWkxJ?=
 =?utf-8?B?UjFvdjRvSXZCMWJZeHArdml2aXdGMTRIblZCaDZYTEpsR0xmYk8zWnJuSjl1?=
 =?utf-8?B?ZjBIY3l2L3FSZXA0RjI1b2UvbmU2aHZZS05CeXlCemRmRWVjcU9MdmZSblBl?=
 =?utf-8?B?aHJ5d001d0pDZUcrZUFCNGxQV2FSWjQzakxrTEZVbVBoODcwa1VEUjUvR29Z?=
 =?utf-8?B?OFhuWDcwT1J4aVFCc1dMbFJ1Q3Y4TUtzalZWSDY0YUp0dUNyUUZybUFxZnVh?=
 =?utf-8?B?VXBRNUJ2QzB2bDZCdTJoVVpzeEpSdkR3NWp2cThvejkwclUwczZpTTI4ZkhQ?=
 =?utf-8?B?YWo3ejI4NVJPU2tXYXFUeUR4cStoZnhJQmozMWE5NFlTZzNORmljdHJGUW1C?=
 =?utf-8?B?SHMxOW5mb0xOempWWjNzWWUzRVZTMVpRNGUwMFVGd0piVG9CS0EzRy92SlR4?=
 =?utf-8?B?TzZyMGtNNmNoWGpIU3BLaUVJbHhGZVBaN1JqMXh1VDRjNG4wVFJlRUhFNFRJ?=
 =?utf-8?B?OWtGU1ByaGFFSkJOVkwzaEVHdHNRKzNBVXpqOGozVXA2dU5oa1d2dEhwMGF2?=
 =?utf-8?B?RDQwR0JENGdUZURnUU5aTndHeWRvb00raERLYVRTOC9DOUVJOEJmWHdXWXph?=
 =?utf-8?B?ZFFpUVBiRm5uRVdlV2xKdW5Mcys1TXJEV0lhMCtCYWpINVBEYVhPR0xWdEZZ?=
 =?utf-8?B?U1VsVldPRUY4Nlc1a0lpZEw2blJ2UmlyK2xSWUZPMHN0b3VjOHRZMXdJdWRs?=
 =?utf-8?B?NCtOeFZzQm04TWJTalJHN3hIL1YrYnZkZkozNUl6U0JVWjkrZlBGN0tVN3lN?=
 =?utf-8?B?QyswZW42RnMrSUpmRGR5SmUxRTQzMWdkK0FqeVJOZWxocEo0STVoOGdnMnVm?=
 =?utf-8?B?YWlEanJIdlpRemVEd2VWR1Y5WThPSVBVMU0vOTlHWFlJaTRsZXhVSWIrYk9Q?=
 =?utf-8?B?RFVxRGdLU1h3YU0zWGFMdUlvb093ZXhFNExETnV5YnBCeWszNGQvWXArN3li?=
 =?utf-8?B?b1k3NEJkQis3WnluQWdNekpDdFdRK0J6N2x4Z2VRcjFFMVA3aktGNXVsZytx?=
 =?utf-8?B?Qjd1SDZmai9PeFArY2U5UmZXcHZPeW5vY0VtQ0xya09mTTVUSUt0MjZZM0Q4?=
 =?utf-8?B?U084UHQxUmRpUXR2NWEwK0tLVERhcFNTbzN6em1PQU5lRTg2MHhoTVErcjlk?=
 =?utf-8?B?OGU0YVVoSkhkSFdxQ3JvUEtnWThIWXRxMkdGQmxrZ0lncFFFQWVGM2lqVE03?=
 =?utf-8?B?aVRMM2ptSzBtd0ZGcTdEbVhLVkEwVldBRi9HWTVnZ09FOGloWXJNTThqSW1N?=
 =?utf-8?B?cFpxNndUQUlFakd1N0dFdkJuUlBFNWpDb3BJZ09zTmF6cVlJdExpSGgzeE1k?=
 =?utf-8?B?ekNHM2RYYWx6ZVdUNDk1Vm5FT1hBNU5aTlhCbC94TEZGQ2d6SEFPSjRqMSt4?=
 =?utf-8?B?L2R1V3lGYlVhRlRGSm1Jek5RZVVlMWpHSDlNNFBtQmQzZnJ2OHk3VVFocGN4?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20638462-f168-4061-dcf8-08db636cc86f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 13:25:07.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLWazPY38s+RIui81y7llQQdY3Bf2cwEAYp20uTO855qq7adOWqR0CGoDZ1GDkXC3LUWTIC0MJ+UB/9XZUsm946SP5KIFN/7fKnHy/RSH6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4792
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/2/2023 12:29 PM, Thadeu Lima de Souza Cascardo wrote:
> On Thu, Jun 01, 2023 at 03:17:21PM +0200, Michal Wilczynski wrote:
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
>>  drivers/platform/x86/classmate-laptop.c | 53 +++++++++++++++++++------
>>  1 file changed, 41 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
>> index 2edaea2492df..2d36abf5ecfe 100644
>> --- a/drivers/platform/x86/classmate-laptop.c
>> +++ b/drivers/platform/x86/classmate-laptop.c
>> @@ -180,8 +180,9 @@ static acpi_status cmpc_get_accel_v4(acpi_handle handle,
>>  	return status;
>>  }
>>  
>> -static void cmpc_accel_handler_v4(struct acpi_device *dev, u32 event)
>> +static void cmpc_accel_handler_v4(acpi_handle handle, u32 event, void *data)
>>  {
>> +	struct acpi_device *dev = data;
>>  	if (event == 0x81) {
>>  		int16_t x, y, z;
>>  		acpi_status status;
>> @@ -407,6 +408,11 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
>>  	inputdev = dev_get_drvdata(&acpi->dev);
>>  	dev_set_drvdata(&inputdev->dev, accel);
>>  
>> +	error = acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
>> +						  cmpc_accel_handler_v4);
>> +	if (error)
>> +		goto failed_input;
>> +
> In all cases, acpi_device_install_event_handler is being called after
> cmpc_add_acpi_notify_device, which allocates and registers an input
> device.
>
> You should cleanup in case acpi_device_install_event_handler fails and
> call cmpc_remove_acpi_notify_device.
>
> Cascardo.

Hi Cascardo

Yeah I see this now, I'm not freeing the resource in the error path properly,
will add another label for example 'failed_notify_install' that would call
cmpc_remove_acpi_notify_device,

Thanks !
Michał

>
>>  	return 0;
>>  
>>  failed_input:
>> @@ -420,6 +426,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
>>  
>>  static void cmpc_accel_remove_v4(struct acpi_device *acpi)
>>  {
>> +	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_accel_handler_v4);
>>  	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
>>  	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
>>  	cmpc_remove_acpi_notify_device(acpi);
>> @@ -441,7 +448,6 @@ static struct acpi_driver cmpc_accel_acpi_driver_v4 = {
>>  	.ops = {
>>  		.add = cmpc_accel_add_v4,
>>  		.remove = cmpc_accel_remove_v4,
>> -		.notify = cmpc_accel_handler_v4,
>>  	},
>>  	.drv.pm = &cmpc_accel_pm,
>>  };
>> @@ -523,8 +529,10 @@ static acpi_status cmpc_get_accel(acpi_handle handle,
>>  	return status;
>>  }
>>  
>> -static void cmpc_accel_handler(struct acpi_device *dev, u32 event)
>> +static void cmpc_accel_handler(acpi_handle handle, u32 event, void *data)
>>  {
>> +	struct acpi_device *dev = data;
>> +
>>  	if (event == 0x81) {
>>  		unsigned char x, y, z;
>>  		acpi_status status;
>> @@ -639,6 +647,11 @@ static int cmpc_accel_add(struct acpi_device *acpi)
>>  	inputdev = dev_get_drvdata(&acpi->dev);
>>  	dev_set_drvdata(&inputdev->dev, accel);
>>  
>> +	error = acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
>> +						  cmpc_accel_handler);
>> +	if (error)
>> +		goto failed_input;
>> +
>>  	return 0;
>>  
>>  failed_input:
>> @@ -650,6 +663,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
>>  
>>  static void cmpc_accel_remove(struct acpi_device *acpi)
>>  {
>> +	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_accel_handler);
>>  	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
>>  	cmpc_remove_acpi_notify_device(acpi);
>>  }
>> @@ -667,7 +681,6 @@ static struct acpi_driver cmpc_accel_acpi_driver = {
>>  	.ops = {
>>  		.add = cmpc_accel_add,
>>  		.remove = cmpc_accel_remove,
>> -		.notify = cmpc_accel_handler,
>>  	}
>>  };
>>  
>> @@ -693,8 +706,9 @@ static acpi_status cmpc_get_tablet(acpi_handle handle,
>>  	return status;
>>  }
>>  
>> -static void cmpc_tablet_handler(struct acpi_device *dev, u32 event)
>> +static void cmpc_tablet_handler(acpi_handle handle, u32 event, void *data)
>>  {
>> +	struct acpi_device *dev = data;
>>  	unsigned long long val = 0;
>>  	struct input_dev *inputdev = dev_get_drvdata(&dev->dev);
>>  
>> @@ -723,12 +737,20 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
>>  
>>  static int cmpc_tablet_add(struct acpi_device *acpi)
>>  {
>> -	return cmpc_add_acpi_notify_device(acpi, "cmpc_tablet",
>> -					   cmpc_tablet_idev_init);
>> +	int ret;
>> +
>> +	ret = cmpc_add_acpi_notify_device(acpi, "cmpc_tablet",
>> +					  cmpc_tablet_idev_init);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
>> +						 cmpc_tablet_handler);
>>  }
>>  
>>  static void cmpc_tablet_remove(struct acpi_device *acpi)
>>  {
>> +	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_tablet_handler);
>>  	cmpc_remove_acpi_notify_device(acpi);
>>  }
>>  
>> @@ -761,7 +783,6 @@ static struct acpi_driver cmpc_tablet_acpi_driver = {
>>  	.ops = {
>>  		.add = cmpc_tablet_add,
>>  		.remove = cmpc_tablet_remove,
>> -		.notify = cmpc_tablet_handler,
>>  	},
>>  	.drv.pm = &cmpc_tablet_pm,
>>  };
>> @@ -1026,8 +1047,9 @@ static int cmpc_keys_codes[] = {
>>  	KEY_MAX
>>  };
>>  
>> -static void cmpc_keys_handler(struct acpi_device *dev, u32 event)
>> +static void cmpc_keys_handler(acpi_handle handle, u32 event, void *data)
>>  {
>> +	struct acpi_device *dev = data;
>>  	struct input_dev *inputdev;
>>  	int code = KEY_MAX;
>>  
>> @@ -1049,12 +1071,20 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
>>  
>>  static int cmpc_keys_add(struct acpi_device *acpi)
>>  {
>> -	return cmpc_add_acpi_notify_device(acpi, "cmpc_keys",
>> -					   cmpc_keys_idev_init);
>> +	int error;
>> +
>> +	error = cmpc_add_acpi_notify_device(acpi, "cmpc_keys",
>> +					    cmpc_keys_idev_init);
>> +	if (error)
>> +		return error;
>> +
>> +	return acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
>> +						 cmpc_keys_handler);
>>  }
>>  
>>  static void cmpc_keys_remove(struct acpi_device *acpi)
>>  {
>> +	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_keys_handler);
>>  	cmpc_remove_acpi_notify_device(acpi);
>>  }
>>  
>> @@ -1071,7 +1101,6 @@ static struct acpi_driver cmpc_keys_acpi_driver = {
>>  	.ops = {
>>  		.add = cmpc_keys_add,
>>  		.remove = cmpc_keys_remove,
>> -		.notify = cmpc_keys_handler,
>>  	}
>>  };
>>  
>> -- 
>> 2.40.1
>>

