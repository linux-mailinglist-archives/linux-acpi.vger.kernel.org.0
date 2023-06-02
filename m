Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC77202F6
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjFBNRl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 09:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjFBNRj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 09:17:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D9E4D;
        Fri,  2 Jun 2023 06:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685711847; x=1717247847;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v3Bf0HMKhcpUSA1NaOjX/3pQyCZzeJZ8bXJKM4BvQNU=;
  b=mFp9LFbg52yK/pV5+mZkHzrMShx4Q6+Ig2p39AJfUmc1MICd1LZlIYG+
   kKqfo62T8YIeUYW7LNG+AON4iHSigHEYqpvTeWTM4JVWoLMJluZd+cT4/
   zueYFP+KHiYjKoO/svOJ1QwK9JkdggV0snpZylnDo/DqRk+S3LWFRHpHW
   Dv0LGuv35SpvfEdzejA44qcEbQ65f6+pKPV2WhodyOyfhsJbbrnwhQib6
   sjb2I7pWJiriRqWnWmY2RnH2WAPW5Afe5sXhuTZlhwkjQn1IA5y6Oe5NR
   5LKbVSYGm+p2VjVQ8eUdx//OZpsdCRtJFg7vyuVp3WvKv7FwKSmMvxUYx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442240059"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="442240059"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="797593623"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="797593623"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2023 06:16:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 06:16:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 06:16:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 06:16:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 06:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LReJLBdcFjWF1sx4FyYdCfBY2nSwAkGwZ8XABgo44zc4Xv6+ENZa38dircYtqRO1um4w4FDZHWBPz2sYCdNp/AvwKoSEGG9RQxMVBCrq61mcTTuaXg2YaYlpMttX9KUc9TJCyoQMeNmskTfqILba3BxLWhDTZK6KD3eLvylDRMnZb+K9riTMVORySRpPyEE2Ks8dVlv/KmgDo9rT5JXuoqS192lRNtPS6IXj0wOXxw+Z6uXEqQR12ebZgm3CRlJ0xkOEIxNbmDGFA3oQPs8b9blaxe11O3wD9W7aHjoWYI3Mc19Yj88ULQ2ossPSh2sunddNYznMpbOVK4gdSppmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma/0RSVNMOujLJVAuUsdEU1cS0SfnL33LZ4rhr1qChM=;
 b=HwHTzHdJ2jfL9+I4BBOeezjhH1xWdb3qB39LFtON7QmoFjijBLKD+MGwoY8Ia8pXchP0HWp8Lrr3RXFqK+NETt7c6DTSqEEAsT0yw74MSl/Cm6zC82OMdZDZvKQPHyuol93nPgSr0aU9TKoSaYgJ2e0dNs0r7PQj/W0GCWdq9/Esfkvw2L6TKV/J0yYNaT1UfMy4V5C3jULBRziRc09Hq4C9fZv/05E1nh6lT6v5T5Oy0TaD1U7rvnJhno445tPLgShwvIZVJ5X3IxnLohEHqdnohHxO7/Hv153us4K/n7vu7G0tBYeS77uw1UF2nE/Wa2UCNHMFyamPA7LcUstnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 13:16:36 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 13:16:36 +0000
Message-ID: <cb768e9b-0977-7165-6684-5ba3bb90761d@intel.com>
Date:   Fri, 2 Jun 2023 15:16:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 17/35] platform/x86/asus-wireless: Move handler
 installing logic to driver
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <acpi4asus-user@lists.sourceforge.net>,
        <linux-acpi@vger.kernel.org>, <rafael@kernel.org>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
 <20230601131739.300760-18-michal.wilczynski@intel.com>
 <de33f84-8774-9d8-5d6c-ea6a31343fab@linux.intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <de33f84-8774-9d8-5d6c-ea6a31343fab@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|DS0PR11MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b99b75-1132-4fc1-35f8-08db636b97d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcMO1H0a4GEm9DIxLmpgbCI24FO5V7sf5TrxRiZJG9MNTHa2kSe63Bqy3RV/R3kZgEVbfRFsMZuz6+3kLpaZ6OGIVnJvPi/rnbzUa89lr08UL2dO+BBYGiQAEg0BaaFVVVSaCxHo+iTzRWtnuNyXyXO5IooQ6hiNAg5a3bRTPsM0p7NMl1BTr1w7l0SQbuPJt64T69g/H/ILBhr3a0XntonrUOb0oY2cITV5kFVOBRcEnMSmEUiNpWpmzPWUr+QIRmTgpq2QVJROBE85Mx377romwaBqLeBBcXR4gCr3gXu/v8MTzQctP6tyJhWTcibmjlDoSzrSWYh4qnItDB3taISmzKo33SApZUNCxdNDLkJvV3DN3SEHlhg/m51tikiQp+3gRdJ4lmjBBKHKOru+HUdwKoDH9R53iYuhhfZuEoC5hKOTQRkdMW8ttSWi4bYc2+qPhPS/F99c9MiSslmEBpAC9qljtGqyHtpV13voDNmm7dZRjXo13+kujkoTRtjGnh+0RNyHXjv55tszQO5vCNM4gy0yvAKZ4yGfzW6zp/3bRi8/beIlRiB/Mh4Y4YUi1HaYvnhbPBVfK0ifw6w2hhvDprXsAFv8XFn8NcDS3ArelxvFJ40DmVmYKupEFu2Is34j8jcKsixCZmfQig4Arw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(36756003)(2906002)(86362001)(31696002)(5660300002)(31686004)(66476007)(66574015)(83380400001)(6666004)(6486002)(186003)(26005)(53546011)(6506007)(6512007)(82960400001)(478600001)(54906003)(66556008)(6916009)(41300700001)(38100700002)(66946007)(2616005)(4326008)(316002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2c2em1QSk1XVVZGTXM0TzdWMG8rMDdObU9wQjdvQXlmek4yYTZLRWFZUjlR?=
 =?utf-8?B?Mk5DUStNVkdVdERXSFRIdmNqTk9JLy9DOXN5OVpXY0gybW9ROTlOVlEvcGoz?=
 =?utf-8?B?eXRuZFdJSnAzaWpTZ0pWMVc3TFVrdzNQSVpLeWhZaHRjVnI2MDU0ZFA1M2pt?=
 =?utf-8?B?aVpmUi9USS9Sa29qMVFIT2tQT2NtbEhXUUVSVmV2YTQ4Vm8vc2FoeCtVV056?=
 =?utf-8?B?QXlMTy9VNFRtdThBL0V6eG1CNnc4TkVBdDhOdXFwTzkwOE9vUWRpY05lWE5T?=
 =?utf-8?B?QXc5K0FkVUpkbHZndnlPV05ydDEycURxVTFMSlorakxiVmdnUzJRcVVqbGtk?=
 =?utf-8?B?bnJodk51ZWxOWlNDb21kdDJhZjlDMUxoeFVVSTVZVzlOVmcySGZhZ2dFTGpY?=
 =?utf-8?B?TWt2cnhoL2EybUFpSlJ1M1lNWktRdVdzcVo2d2FUTk1iVEtzcHk5MGRTMkZi?=
 =?utf-8?B?T0xwM2lDSXFSdG1iaGY1T2kzc3V2dzFTWjYxeVhxV21ZckQrQVlnelVzRlR5?=
 =?utf-8?B?Snh2bnBuL3hWdTFLbTU2eXpzbkxkTzE1U1ZFd05DcmFpTHhDUE02Z1Q2ZWJq?=
 =?utf-8?B?NEdjRFBQeW9rQ250WnE0ME1TTVVWMnRsbyt4MXpHNVNTVmJYZDdGNGxuZE9l?=
 =?utf-8?B?QVdaN2wrYXM5bkRXWUlPL0JJdkxHdUtJam9MUjErRHd4MXhrVHhobXB5VWZ3?=
 =?utf-8?B?ZzFycHdBcXZpbUVKV0VCR1Zmd1pWSTc3dkNydTI5RjkyNC9Od29BYndlZFVU?=
 =?utf-8?B?TXVZUVNYbk5oNnp2TWlKamxjZEJOdThOWElORHdxVVkzdEV2eVUyQUFLSGpa?=
 =?utf-8?B?bHlyeHA4d0tqWmg5UjhnUk5FbE5TdVNwWng1SkRMZGxWcGhuSUorWnhnMExR?=
 =?utf-8?B?UkNWUTBsbGtBd1lUeU13MTZUbTI2M21QWUFFTFB3a2ptUUNRMzBHMnNneWpR?=
 =?utf-8?B?Z1QxcWMwOFJ3RTFacncrTTBYVDdjUWRrQTBaa1BTZ3lsd0NJd2duT205WDRW?=
 =?utf-8?B?VkdKVU8rNXFkM2ZhVXdBYytjNlk1NGo3MWxVa3RrV1NmZFl3cGVDS0NIYUNZ?=
 =?utf-8?B?aUFVSitVMnlMb0wyY29SRXovMndPNmx2SXcya1FmdDV1K0ZEaGJSSWE4RGwr?=
 =?utf-8?B?T1hIOVpEY1FRZXRqSGd3dXNXK1ptaVhXSWZCOTFQcVdTank2SGwwSWJ0L0lP?=
 =?utf-8?B?QyswWHlxeDhUYWNCbXZJczVrNk5YUDBQSnZMYmR4NkV0V0F3N002UDVJQWlU?=
 =?utf-8?B?Z2xXOWVidmNHQzhBYWlDUDV3UjRyUDI5Vy9LbEhkQXFxWTg0VW5hVnJZbnlI?=
 =?utf-8?B?M3RWaTYxcGVNcHIrVjNDbEVIREZyd0JQSGc3aE5OM3F1VlVyUWpjejh0anV5?=
 =?utf-8?B?VEhFTlQ4UWtuaDA4NjIvcW5QK0NHa1VwQVFIdWhXRG9aWmkvQS9LUHZkdjR3?=
 =?utf-8?B?OGQ5cGZqNXlYYkFMRXRxdEpwdmZpK0tONkltUTVJRHJDNXh4UmRxZGp6VnRl?=
 =?utf-8?B?Rk5Sdno0Y1hWZ3RGMDZYVWFaWVNKd2taK0dGMzY3ajVqdUxkL1NSVTZRZ1pU?=
 =?utf-8?B?MjJPZEVCclpBUk5OejVxWDBwOEdhTTFTN2dBbnlUMVJBSk1oRTl3N29VZ2VX?=
 =?utf-8?B?ZTMwVXV0OXhOck9veTBBNFZDQ2VJWHBaY2YrK0cydVkvVGRxNEp0ZGlMUjh4?=
 =?utf-8?B?OHp3U2dCNWVKVFZsUmkrSGJTUGppa2RUZFRRWm1abnVmYUU4TkpTU3ZtUG5N?=
 =?utf-8?B?M1dhaXNVUzU2VjBPZE1HZ2dteWlKQy82S29nUS9nYUQ1aUkxVms0WHgyc2w2?=
 =?utf-8?B?L0gxMWtjOU9zVFpFM3QwU3NMS3d3Wm10bDRSVmRqRWluRnhSOXptNnF3OHNl?=
 =?utf-8?B?VCtidXl2eWdnbVlCbVZLV1FBS3QvWE1ESDRVdTlaaHJGMmgwWjdEcHFWSzBQ?=
 =?utf-8?B?T3JVWkQ0Ty9DM0NvVWZXelMrUHpwcC83MW5BUjZydUFTTnJtTmF3ZlBITm1k?=
 =?utf-8?B?TVN4RHArSHVkc01sRVJuREhTMkFMbitmM0U3VEhlTWlIMjljaW1HQ2RRVll6?=
 =?utf-8?B?U0FmN3hEQkZsaWtERks0eTI4OUVWT3pJREdaZHNrT1EvbVpUaU1WVldXK3Ew?=
 =?utf-8?B?YXQ0aDk5U2xIU3JFTWUvdGdlOTN1UlNNKy9MSWtmYUV2NkRFZE80TlpueFB0?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b99b75-1132-4fc1-35f8-08db636b97d4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 13:16:36.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxGxX62Jv3mhLygXfMuKtLXZGAV8ljgWNNPwL80fzyvEbHfV2iQr09AZfxrHfGRBsItyjhItPq+PcWgX84D9kjo6cI86YAzjN8t/icTqLpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651
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



On 6/2/2023 3:09 PM, Ilpo Järvinen wrote:
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
>>  drivers/platform/x86/asus-wireless.c | 24 +++++++++++++++---------
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
>> index abf01e00b799..6544e3419ae4 100644
>> --- a/drivers/platform/x86/asus-wireless.c
>> +++ b/drivers/platform/x86/asus-wireless.c
>> @@ -108,19 +108,22 @@ static void led_state_set(struct led_classdev *led, enum led_brightness value)
>>  	queue_work(data->wq, &data->led_work);
>>  }
>>  
>> -static void asus_wireless_notify(struct acpi_device *adev, u32 event)
>> +static void asus_wireless_notify(acpi_handle handle, u32 event, void *data)
>>  {
>> -	struct asus_wireless_data *data = acpi_driver_data(adev);
>> +	struct asus_wireless_data *w_data;
>> +	struct acpi_device *adev = data;
>> +
>> +	w_data = acpi_driver_data(adev);
>>  
>>  	dev_dbg(&adev->dev, "event=%#x\n", event);
>>  	if (event != 0x88) {
>>  		dev_notice(&adev->dev, "Unknown ASHS event: %#x\n", event);
>>  		return;
>>  	}
>> -	input_report_key(data->idev, KEY_RFKILL, 1);
>> -	input_sync(data->idev);
>> -	input_report_key(data->idev, KEY_RFKILL, 0);
>> -	input_sync(data->idev);
>> +	input_report_key(w_data->idev, KEY_RFKILL, 1);
>> +	input_sync(w_data->idev);
>> +	input_report_key(w_data->idev, KEY_RFKILL, 0);
>> +	input_sync(w_data->idev);
>>  }
>>  
>>  static int asus_wireless_add(struct acpi_device *adev)
>> @@ -169,16 +172,20 @@ static int asus_wireless_add(struct acpi_device *adev)
>>  	data->led.max_brightness = 1;
>>  	data->led.default_trigger = "rfkill-none";
>>  	err = devm_led_classdev_register(&adev->dev, &data->led);
>> -	if (err)
>> +	if (err) {
>>  		destroy_workqueue(data->wq);
>> +		return err;
>> +	}
>>  
>> -	return err;
>> +	return acpi_device_install_event_handler(adev, ACPI_DEVICE_NOTIFY, asus_wireless_notify);
> So if acpi_device_install_event_handler() returns error, should you 
> rollback something here like the error branch above? If that's the case, 
> use goto to rollback as you'll have two places calling destroy_workqueue() 
> already.

Oh yeah, this error path is leaking workqueue now, will fix as suggested,

Thanks !
Michał

>

