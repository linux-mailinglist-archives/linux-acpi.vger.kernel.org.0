Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8A5750D73
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGLQEd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjGLQEa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 12:04:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7141BF2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689177848; x=1720713848;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U4gm15W3DTrlSfM7uqc2AmUT8R3J5GCK1DDbj+Rzvzs=;
  b=IAgmaNmgewWrO6R8Ki7wyhhwJourGyywaWk+RoL1gPeSX9WBFOBtn0ed
   LLge3Q4jlVgTkVXrRzW2V74PNC9NMnyV92EeteKdhWscJU6IG8I7fLcg6
   zLOcjqvzfgHQ8Fzu7eAcucFIjFY06sWNczg6r4FNG538L8sZW6eRKIyLV
   7LSoRuKza8IWvST1wAgY2aKJHshQVBGrJDifQKsdmWzoDCF6EaIGBHJv2
   5Qe+RYCExYx8IEhVcmM2g6nY5hEoAFz0M7OO/NmsvzingWsQ/nANcRwuL
   wxl92q/oJ+Ds8RkSAEbFDWeeC8D2+waalbUY8r1f3Lm6SUsBXgqYoExet
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367550500"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="367550500"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 09:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="1052250791"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="1052250791"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2023 09:03:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 09:03:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 09:03:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 09:03:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPQTLXQMVl3/SPy3n8EUmuDXRpTt1iy20ZAfPnMGt9jE3dnj4f3yXHgRMlmI4IsnQITurBcpPlGVL3iPjj0FA0ITlwaBLqcY5qB6qUy9tydgeV8HUTawMEZD65bQqRvM1dMU1utY53V7lt6mdmx6V0rqrxh3GxPQIPixFMheFRRnMjopuVhdWQrcAvAuwDUrUWmPC6aKsxhU7tFicvuHBdv4ibhXugSrn5ux3TQ4IhOOb5sFSwrCHut/tqa5m60CrBh7XViMoBcEvC6PiVcTMbP9q6bO6Uda1wDwMx1YsY/UtRlRtK7NPQo906EesXRM5C7mk5xMsMjZl/dGD15Kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGiD1Cvgn7ImjMrteUxW8Dc5wcLy6rJwhz4Ldl0WiDc=;
 b=Sj0SRll6n3NX6KQ0aFtlfJ/aH2Bh1VL0W4NhHbDxKS7ju+f9kxpXlY5Gid/TxR5s7eLyd5lt1Py7pJIN22vmS206xZtSQAJZN5GgMXoTWk1twHG8ylnIzUzlS72lQqCThEoZiALquDzFmR/HEhNBv4YTqCnivl63UnEGTayf5C/1dxQFnkm0bpPegLcnUCG4gnEW2+DUm5yuPwU1GOS7TuurajovW9TvVulpn8t/5pcA6pQiQFYBtEcrcH6KuFfxGZZWUL8frx9bmJrAL4mH8Px2Fk6/p0VsWEgCRVa6A600rnlIqE2ewzRknOvBCm8iHki1DibgH3Es/e71lGB6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY5PR11MB6185.namprd11.prod.outlook.com (2603:10b6:930:27::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 16:03:31 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:03:31 +0000
Message-ID: <9539931c-9bbe-f1b5-7375-a26ab15a8b14@intel.com>
Date:   Wed, 12 Jul 2023 09:03:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [RESEND v2] ACPI: NFIT: limit string attribute write
To:     Ben Dooks <ben.dooks@codethink.co.uk>, <nvdimm@lists.linux.dev>
CC:     <linux-acpi@vger.kernel.org>
References: <20230712115753.20688-1-ben.dooks@codethink.co.uk>
 <0d1bf461-d9e8-88bc-b7e2-b03b56594213@codethink.co.uk>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0d1bf461-d9e8-88bc-b7e2-b03b56594213@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY5PR11MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: a51aa331-c0ba-41fd-bc14-08db82f18991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OCgeRHIoMF3KgZs3BPZ9hNpYK+YdKN0uamt8iNvUTYDHjD0v09Y5xcCmoix4A1yTj1zWQ5KX8Jx411+cRZNlwpimLlyXLQHcd2KI2J6Tey8jiaOIaxYALbA1f2vAek+SYBJpocEOU1XtVaFS+v8KzxIgvEDZ855mU8xu/WTmD3Ud9RDIgtyMVm3hW4vgyu/OF5/oR2n8MBY1FvruBdaRALzLfR6j+IvFjGSJGiKSsC/CvQzAc1Mi7N99Z3lzN/daipMbhUPCEfC/3oWsL3QRXVst+jq8UkU2OnR/3n962XM4fzstrymOWQN7nT4xIFe9V8GRulmVWWCZn38UZLgsUarU/z9uUnWn6ApiEdDotFc64KCszdRQpNppzNRd9VzPfA4S9BvguDO3+KslcjNVq8Y98dTmoyZKE1nCbmT7Uk+9ZEsx3y4ubLbul1pFrEAe0kdtXtW0qygTDt3v3NLsOzMK90IA4xu1HUXCsb9YxLKojWOqDiTRypGasUjVmSlchLAhQ6aYIUL0Uy1RSi33Xx7nS9NBqy71Tm5WurDXZPy6usZqDS6dBqsRL6rsPQgDjgl0OuAxRTaD/FI5NjS4zqEAbq/4bFz0lII7KaOf/s27tLSmX+USeCliD3K2r5eOnAHneaAfEk5TT2lvQt0og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(31686004)(8676002)(41300700001)(5660300002)(8936002)(44832011)(26005)(316002)(4326008)(186003)(66556008)(6506007)(2616005)(66476007)(83380400001)(66946007)(86362001)(31696002)(478600001)(2906002)(36756003)(82960400001)(6486002)(6666004)(6512007)(38100700002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFcrNUdrMXNQK1k5K0ZrTEJRVFMxZkN6VGR3QVdPNXBQblhUYTNmZ2Y5VVhF?=
 =?utf-8?B?TEtuU3l5dmJFUmJSYnlPSUNtUlkxZ01VTWdabWhlZG45RjZYZ1E0UUR1QzJM?=
 =?utf-8?B?a0lGTC9LaGh0VGs4TnFmd09HelpZRzlNb1NvWk9JY0RKeHJHZ1VuWHlINkg1?=
 =?utf-8?B?M0VkNmhBWEo2emc2b2dlUU5Sdmk4VHROMVFJc2wva0hSK3FiQ2dQSWx5cFh5?=
 =?utf-8?B?UTZpak1PMTA0NTU3R1dXY3Erc0djdEZTT084OTRFbHh4eDhjT1pzakRnbFMy?=
 =?utf-8?B?YWtZY25IWEJNT3BUaHMxRTVaUXJ5UkNKMDZnMkRFR2xoRUFxbk5KNXRITnJo?=
 =?utf-8?B?OUlNZ2J0RjhVRVNwWjNFNkJhL2ZjemphKy9JVmZmYlFtN2swZ1hOSVNMcGlW?=
 =?utf-8?B?SUxZTE9sLzlwOVQ3b3M4QkQycW9JNWFIeVN1dWRrZ1hRM3Rack1sVnl4WlJp?=
 =?utf-8?B?bkljajUwd1NEVXdRTmxoQVlvUGRXMHdTWHpuUFU0bC8zZzJEdFN3RzFJOWlo?=
 =?utf-8?B?ZUNwL1hoOERlSGl6aEw3TDJaQ1hTcUdkR1BML2tMS2srWGhXNk4vWU1PQkRo?=
 =?utf-8?B?aWxKZUNSM0pyT2JnYnlEc2JDSHFGWnNnTXVRMW1sUmtwWTBTL0l2MDZMWEdB?=
 =?utf-8?B?VVJ1eXAyRERnZmpXdkN2TjUxbmlxWXNWaHFPWkk4Tm1HdVdic2pNaWpsWWFH?=
 =?utf-8?B?UVl3NkR0K2tuT05KdFlJVVBaRU1pclZxR2VJU1MwVU4xY2VsSTJHalE1dUc4?=
 =?utf-8?B?RHRlNHQraWNyTksxT0JWRVlJMklZU3BRSytqKzZFUUsxdkdORGxqMmw3dk5T?=
 =?utf-8?B?RUJmZXhPUjVxKzJWM2Jsam94dTZraG90T2tzRm9CQ2lmdExDU3FwMi9JREsy?=
 =?utf-8?B?bkpkYmRlWVdYNUxNNktpUlBTZHVHZ2hXQ3BZT2ZhM3lhbS9aYXRtR2dHVzIx?=
 =?utf-8?B?akx6SStJRXpYbm9CKy9xR21uNmdYaXBWbHZqc3hheGJtVzc5am44WFo4Qm90?=
 =?utf-8?B?OWttUkgrTCtuVCtZZkR3UDc2Rk1JUFlPakhqTWtlVTJoSGNua2NyaUdSc2JD?=
 =?utf-8?B?WXNKM1JUZHA2bHlGMGJCRzQ1M2hWYVpIL01pckFvRW9UczhqeW5vYStSVGRy?=
 =?utf-8?B?QUtyeU9mekRVa2pMMXUrbVhLZzdSZFF0Q2J6YmpoTjdLbEgrdnY1ZWhpYlNm?=
 =?utf-8?B?R1JXMjd0OThVTERkdUdQRGt0empvY01jUzFQQTFidC9NUXk3OUVQZ0ZIYnFC?=
 =?utf-8?B?bjhXQkNoV0czdTVES0docW5ScFV1Yys5OWUxMXdjdXcvVVZEWUYyN2JMLzAz?=
 =?utf-8?B?Rm4wRjQyZGNvU3IvM2ViTStaRDZRV3RZaDg3L29vc0FDU0dETkFXZUdvelQ1?=
 =?utf-8?B?WURVSE5sTEhjdGo2UFlETXFlK3RQdVU5aUpVOG1OVE5BRDdpeXBRV1lRWlFL?=
 =?utf-8?B?ak9CemVxOUdVRFN5WEs0ZDIzUWU1QVNudzN6SEZtVGtJWGl3WkhVQzFxVERV?=
 =?utf-8?B?Q0NvWU40QUlnTExLZVc1ZWZ3VnZsVkNvSWVoYVl3RnJJcHZnWTBuMTVuaDll?=
 =?utf-8?B?bEtjVTlkajJyeUltQ1NabjlKR3VYc2lRVklOaTNIanA4RitUVXlwL00vc0ZR?=
 =?utf-8?B?VVFrbFA0YXFSQWpHZXRScENzRVNrK2tuemhodEtteHV6QWNTRjMvN2lSWWZJ?=
 =?utf-8?B?ZnF3UHlJRloyNktxRjgzRW5QOVNLRFZkY0dUSEFnZmEvNUI0YmdnYXo4ZldL?=
 =?utf-8?B?S2ExWFArVm9CcXFHVUtvUllIclg4bWhhUkxUL0k2TysrallGL1lod3hJeWNU?=
 =?utf-8?B?Y1pjUERXRmd0bllZYitxS0lNQzBOenJXYTZpaU02YkMzMDhPZTl5M0NHV3cv?=
 =?utf-8?B?aEIwM2xRQ0h5Y2lkSzduQ3kwZUlhcTgvUDRHVUo2Qll6OVZxSFFGam9XcDVo?=
 =?utf-8?B?NEZGd0pRdmZyWUpRMDY2enhaQ21ISExSRFNTZTZxbTdiazRTbi9ET2FhZkZj?=
 =?utf-8?B?cE1KWktlWk5MRk5zWmFRT3hMUEg2OWhGTTVKSnkwSG8vUy9rNlhUdTUxYlVP?=
 =?utf-8?B?SUhJMWVoTmswTG1DWm1vZ2c0YVpHUWdpM2E0UWhINEpkZnE3UWNVZEo3cDdh?=
 =?utf-8?Q?wsgeIAtOMfKu4Tw1qAocYE9PW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a51aa331-c0ba-41fd-bc14-08db82f18991
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:03:31.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkVLaQLyM3H9C8YCpfNPWQbNxSEU2PLxsIHFr3acd90Vce0eGNTdCOh2OBk7rS2VWwmW/3dpKqyTO8t1vNVVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 7/12/23 05:11, Ben Dooks wrote:
> On 12/07/2023 12:57, Ben Dooks wrote:
>> If we're writing what could be an arbitrary sized string into an 
>> attribute
>> we should probably use sysfs_emit() just to be safe. Most of the other
>> attriubtes are some sort of integer so unlikely to be an issue so not
>> altered at this time.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> v2:
>>    - use sysfs_emit() instead of snprintf.
>> ---
>>   drivers/acpi/nfit/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 9213b426b125..59c354137627 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -1579,7 +1579,7 @@ static ssize_t id_show(struct device *dev,
>>   {
>>       struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>> -    return sprintf(buf, "%s\n", nfit_mem->id);
>> +    return sysfs_emit(buf, "%s\n", nfit_mem->id);
>>   }
>>   static DEVICE_ATTR_RO(id);
> 
> Should we go through and change all the attribute code to use
> sysfs_emit() ?

Probably not a bad idea given they all have the same issue.
> 
