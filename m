Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC968720396
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjFBNlS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjFBNlR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 09:41:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B875136;
        Fri,  2 Jun 2023 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685713276; x=1717249276;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ALsFaJueP2KZEXAXHN48AIfmS4tUH31SgWNBMC4VOS8=;
  b=WvSMuVT7zxlCia9FUIoRo2YmYqH+SXNuGUS5ahwJPiDoLWYiQ8YvEUAb
   HFoPCsBAg2eXFBkHG3eJB7yzr/SYG5Dw+usvJYLZgtkNhtOA2z0l22AmO
   UW574JxrEHJs+7tPjq9deHtnnBm3Htt7KNyHdvzicwfmGUvViBzXRSRaC
   tirWhDwNldyqtGtEooab7n+7WMTXxEkbBo7AxUM7c9bf/fB8aKEoTixfB
   EWVguPr6GAhOfWUBQkkf0B09xVN/FabANZYm9l+p+9KxQfBdoYPsdX6DW
   S/pXha7zA7ODqvHQPvZ7vXpGD4adLBt5XQu1bWQLYbs8tBkU0mWzTamFs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="353364333"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="353364333"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="701969914"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="701969914"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 02 Jun 2023 06:41:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 06:41:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 06:41:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 06:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRFxyK9p+mKTOL+s2AiF3FiYzfQw8gZRPs2iXm6mENugTF8/cI7ApDWZWAx6oW7LHKN9QgZIqX7MCe1iv2kis+ViACt8q8amNEzFd3NcN0cOty3npmr5WoM1QMAzRW81ix7JcUc47BDGFn3aw0Dv4lwRDBK3gtXzaNdFffrjMIHogruoBU4GwC/66BJxdftBgfE64Ayc9nJB3nui7R8oTroP26aWK8zvmOZc7eN0mctcfknX6BqvJpMbWGo9WUF0BHhVMi8NT/0jM65bO52HHImhCwtpY3coZOFjbirrFaYdVCTluVUxCE2VoOYhpkWEhgLJdqnjZLmuV8YccpVW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLGuT1oXVb00Xy9Vn1Ui7juHYTbnIw/y1513Kvox+bw=;
 b=G/w4wkWkX5f8ujBS3RoV0YaJ0T3M8WxVof4Hri91mOi1UKSp1yI/8SPpqVDFjaT7miOvXEgw8gj38svCkr7Qx+FEeJn5cud+IqUN5zPyV6RbX7GN0hn96ijl68wqtd3VdWjwrQfXfHrKQmpCko3pjPLnMEo648diE7c8LruO9GOuAOZEGANQNNnZ0JhMu5zOI8L3pX4nHGyTZ87uy+lFGEOlhjVR/V+U0vuXXil8T3VB/8Ch83bdR27eNNMS0QNFwG9jWBkJdIYHqKDvf24iwFq2fzURUEXmwtk6iyz/Z7Po/r5TyuSmJo3sSMgKnT0EI19mrYuLx51Dq5kagG0wUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 13:41:13 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 13:41:12 +0000
Message-ID: <d7e2577e-b6c3-a392-4331-5ff16e68a609@intel.com>
Date:   Fri, 2 Jun 2023 15:41:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 19/35] platform/x86/dell/dell-rbtn: Move handler
 installing logic to driver
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <rafael@kernel.org>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
 <20230601131739.300760-20-michal.wilczynski@intel.com>
 <ba90f648-6f29-57f3-b1cc-91b929fda393@linux.intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <ba90f648-6f29-57f3-b1cc-91b929fda393@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::13) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 48877076-8dec-4f4e-6ce4-08db636f0760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: poKsuFDfHuJdXV+O2SoRlbT4hIKNP9cz8NwDcLqJG2Vm1SDGPxZ1FuKbIjjFP8MsJGKZundXgqF7LyYn1mUK4dEjK3roBGSC1craPe3gGIvIg0c3qKsONKjx/yuJH1eE9gxCv6AlxrdInzcoZVF5S3z/I4fditbumwLEYzILFkobLNhOkpr1Ku74MTwyyFS8GTiohH0EnoWun76As9DIhMemEupu2fMds5uEvSJPwbexfXH2rXHn+kGGkiWes4dD3GbqWszNvExjvPGx+s97Le8EECylqRCbmQrqFqo2GHiGWsLL4uWEQLeQ2m1t4dLTlsaWEMdSXNkMnGsBBqQUJq3CEYepXoBcjPQKdmd8Sqo4l4WIf+ve726sPnuzhZZDTs8fdYhSdXhe6M32moWPCQjAkJFkX1v6KXn5DNjf5gIm6ntkpoatoLUdArkudky6ANqs5X+X0OwcLZNucowJfyA0dEdzOywdZWCfcUjiaTqOMoYjkJfkaIq4kiu8gBxT4BIQQgjkqQIzQsQcXVmzCNPiQNSaGasBODf+DZzfjk79XGxklR5zIuWRBS7yuS624k6wa2ouGWHPgHuhhqYIVJ/RZ6+Ej14oEp9coNoYtpItodh6zu25OBxbHluQKwMk6nsnsRcuQ3HGysjmCH3dPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(82960400001)(36756003)(38100700002)(86362001)(31696002)(31686004)(66556008)(41300700001)(8676002)(6506007)(5660300002)(26005)(53546011)(6512007)(2906002)(8936002)(186003)(6666004)(2616005)(83380400001)(66574015)(478600001)(6486002)(66476007)(316002)(54906003)(66946007)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHcxdjllZ2loK1FPUzQyZXllZmI1elVIQ09za2lPQy9aKytrRitxc282WSto?=
 =?utf-8?B?TGdIaG12WWFTNGF2dFQ2VUt6blFwanpuWWpxT3BSZTZWOXlBTGpiMFkxNGNk?=
 =?utf-8?B?VGhRbVlVMkFrekRpMG1leUNGZzlJRko0T2V3QTFuMmcrbFFua3VEd0ZpRXpr?=
 =?utf-8?B?N0N6N3psQnkrWHVvTlBJRmhmUUxFWjFrR2RZUWJHaEhqZHhiZTB3Njk0ZUtU?=
 =?utf-8?B?U0wxczdaN2pTaTRxMTdXY0pQK0U0ZnVaRHE2MHVuMHM1R1BFQjd3RFcwYUtj?=
 =?utf-8?B?UE1hQ3lpVDZHTnhuMmhGTU5zSEtGcElpN254TG9jUWc1bjkwTHBJTWFyYUVk?=
 =?utf-8?B?NXMyQUVKYXZ3UWd0UnJVR1RhN1gwYlRtQThlMm12VTB2c2lrbWJtMS9GUWdO?=
 =?utf-8?B?a3FDa0dORk9FVlFIOEJUeC8wUDlOYmlDemEvU3p2UURHd0dmUHJRdmtoVEp4?=
 =?utf-8?B?b1hhVGtQZ284V2V5REpSb3dVczJDQmd5RWxEVmJ1anhiYnB6bWlNcXl0MlFI?=
 =?utf-8?B?dGRjdWJITVlGYjVWdnUvcGp6L0RBa1ZHc2dVN2lidnJKZkNqS0RJVlh4eGY4?=
 =?utf-8?B?QkVIcmJaNGV6TVlWMzB1aHVnQktuZ3FKTUNvdmZ0TzExeENzenhwNmRlY1Mr?=
 =?utf-8?B?T1ZsS2JUZjRwRXVrS3N2MTVvMjBGT3dpN3lYY2FjNTVITlY1TC8vMnJsQnkv?=
 =?utf-8?B?UW5kUTlEa0xSbmVRbFVsUE1pMlh4N0tqQS84OEU1aFhZTzNCM2VDTnd0cTli?=
 =?utf-8?B?MWMrMUZuQW1WSk1kVGtUMlh1Um41NHhwM2tiUGNWMFQ3Rm9xejJCOXdPQnBH?=
 =?utf-8?B?b3h1OGRoZ2xWUURDaFRKS002bzI3R0tkNGhySmhQTVUvY1JDWkJ2aTh0N1Ry?=
 =?utf-8?B?Yit4TEZLSDFhSnFZcHg3VXc0d3hhMHZTVkdvUVV0ODZhNVRYRmh3SmR4M1JI?=
 =?utf-8?B?WGVQTmVGN09qQmRUWHlGWGhNOFhHL0FWWEtFZkVhWjczelRJc2czQXVKWEpM?=
 =?utf-8?B?azdHWXoxMi9vdjVRamhpWXk1em9wV0llYjBwSGJibkFwMGpWTVpMcmhjQlM0?=
 =?utf-8?B?cStrQ2tWQjVUWU8ra3VxaHYvKzBQZGRMcEM1Q0dpS2JFajdFd3JWUUQ4dUdG?=
 =?utf-8?B?OEpCZXdnZzFNaUtyR3BzRHlFT3czTWVMZlZLT1dmVGI3anRPU1I3a2svMzRz?=
 =?utf-8?B?dFc5MDBvWUs1cStCeVFua1dicHgraTZkYjVEQ3lzeDBEMG42Y0ZBbFNobVNj?=
 =?utf-8?B?YlNCbFRFUVNYMzlLZWNtaEpiejlTY3ZoZ0JIb1VXblErOXdYNzVLQVFzbHp4?=
 =?utf-8?B?aCtTS1FEc2gvV1NaRThYRXZoMFcwQm9HSTEwc1FzWHBXeVRhSk83d3p3dXNL?=
 =?utf-8?B?KzRMSkppY0R2L3NRVnVLUTRGbzB6Q1BCQlV4aE1IcTRwRXJVUERqWEYyS0VR?=
 =?utf-8?B?TVF2SThmRHN4WXVSeUJKeHF2ZU10RzRNQm1xV09UdW9sODRieXJ1V21BenZR?=
 =?utf-8?B?NS9mUFlib09RWktXSWRtK1JlVzFiNkI3N09BeTREUzgxZVdLMjM0cCtHVGJw?=
 =?utf-8?B?OVFIMGg4bXZxL3lIelVFMkk5ZUZsVjR5em5DUWVIdzYvOHVyOExOSllieWpM?=
 =?utf-8?B?cnVqOGdTdWprdGs0UUNlN20wQVIwR3hyNHZSclFYcUhwWXZZOWR4WCtMdzVa?=
 =?utf-8?B?QXF1TjNSbVJBdCt1NGVWNmNUd1RBSzJkSWRhVjVxYjdvN3dTbUVaRnpvVmVG?=
 =?utf-8?B?cFFlWFJ0K0ViS2ZxUDFVbi9mME5KTWl2cGV2Y3VQeEJQcGNlYXVVdWtlMnh1?=
 =?utf-8?B?a1U4eFFISEVzRU1yeXFEdnFhRXR2SzQ2Q21QektGa1h0OS9tQ0Fnb1hwSWpT?=
 =?utf-8?B?RzQ5M1k3UG9YNktqTmlJMzRTYktlWXJkSk4xb2dSRlprMGthN1JFck90VWxB?=
 =?utf-8?B?YnpIeG5ySHVDTS91NXdEV09Ob2kyUW9SMFFJdDZQUjhSR0RMZTc5cmVEODJX?=
 =?utf-8?B?K21CR2M4SUFHcURkOGo2NlFBbW5ZbjZ6QndCbTJrVTZpSjg0ZHBCNitFRWpR?=
 =?utf-8?B?cVQxb3JwczR4dks3T3pxSTB4N0pZUjl6U3NjOWpKSU9wT25QNHJOVkhPY0ZZ?=
 =?utf-8?B?SUVWbmtPVHFhQXYzNFNWTnp6VEU0Zy9EUktRQ1FCSlA1WVNPL29yMFpTS2hp?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48877076-8dec-4f4e-6ce4-08db636f0760
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 13:41:12.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ql0QK/9dSGaFfz/ebaqzh+3xluIfsXuNARfJoZO/JuvcnfmkWrqWE+uLpRQKxMirhv9P/s1CUXnnWrEYjj4Fslegwgco4Jbq9zM6pCkJ5So=
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



On 6/2/2023 3:20 PM, Ilpo Järvinen wrote:
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
>>  drivers/platform/x86/dell/dell-rbtn.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
>> index aa0e6c907494..4dcad59eb035 100644
>> --- a/drivers/platform/x86/dell/dell-rbtn.c
>> +++ b/drivers/platform/x86/dell/dell-rbtn.c
>> @@ -207,7 +207,7 @@ static void rbtn_input_event(struct rbtn_data *rbtn_data)
>>  
>>  static int rbtn_add(struct acpi_device *device);
>>  static void rbtn_remove(struct acpi_device *device);
>> -static void rbtn_notify(struct acpi_device *device, u32 event);
>> +static void rbtn_notify(acpi_handle handle, u32 event, void *data);
>>  
>>  static const struct acpi_device_id rbtn_ids[] = {
>>  	{ "DELRBTN", 0 },
>> @@ -293,7 +293,6 @@ static struct acpi_driver rbtn_driver = {
>>  	.ops = {
>>  		.add = rbtn_add,
>>  		.remove = rbtn_remove,
>> -		.notify = rbtn_notify,
>>  	},
>>  	.owner = THIS_MODULE,
>>  };
>> @@ -422,7 +421,10 @@ static int rbtn_add(struct acpi_device *device)
>>  		ret = -EINVAL;
>>  	}
>>  
>> -	return ret;
>> +	if (ret)
>> +		return ret;
>> +
>> +	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
> What about the other things that are done in rbtn_remove(), should you 
> rollback more?

Yeah you're right, but the total lack of rollback in .add() here seems to be an issue on
it's own i.e even before this patchset .add() was leaking resources in case of failure.
I wonder whether to add missing rollback in separate commit ?

>
> I suspect there's a pre-existing lack of rbtn_acquire(device, false); 
> here to begin with.
>

