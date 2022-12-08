Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6518647536
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 18:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLHR4c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 12:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLHR4c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 12:56:32 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BA4AD309
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 09:56:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGjgh09lkrz8R0qAWlv5hqZz0XTFIgwUGSKDDsEcpOX4B33f1r+cDF8IWXpjHhgtE4XICAEFUjqnxw4KALyTEyjbPg2XfyObV4DLAAbRUZLOhe8LvmxCckTvjA9Ha8Hvv5bktyeRy5YTRw1MGkiltiqMhzei+wMyBb2vQrNExkYB2HLrLM37yqKhSD2xJVjJ75UGU/6ubBidwHB8gTNiFuJNYjmAbcvx94xqItXp4LhMfGCRhYqhC43Aq+ziFJo5YPOC0EZZZZe9ZcJMHBRxviTusuWkQx5urA4cy8Rovk4+xeyffyiEuLqWj939aVLrLEd8H0Xlb309NsvBkyAdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrNC2nvOq3McZXt25R/uFKYFlRwpz9dgm5AUD2B1KnY=;
 b=UrR/aDNIUVccZs5GL2dqebAhJBDX7lpM6aZPgnip3OxaLjNmf4dN6bJ8dkNETF3CJYSkhkpyW4flTh+TlvAWc3pqtzQLS24M+DnbH9b9rfVR3OpZIOi4nfhykRakdeIMtbDSwEDIzq7kNFT32MtH7qcuQmurUMRZtJRCeUeCHm8lzhT4+sSCtQT9s3lDFF76+xyDR848uXPoloJ26ruTmGTM82QqxtS/u3CT7W1SqfnA++2gU+S0tucRmzDlu2ujx8Gue8n8tO6Nt1+8qThrckwDHfXEtaTBUdOkTH8pEExXZi+dUBWgUBDQI8S4WLiLK1/g6Balfvr28+g0yUdFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrNC2nvOq3McZXt25R/uFKYFlRwpz9dgm5AUD2B1KnY=;
 b=OGCa+CI+ZK9KqeCcPIOPJxXBwS2dLXeObVKoBHCIrFrguQ1a6Kjdim4ovYFI8rbRWOwQbRZGGMkFLydi6pVtuBH8b7HZ38BWUfX1Y6LBX0sTVg0R3TMlFg4hc593Op2Vyivbbh3gf+PqnHHTHqej4d2YCvt3I2uQVgjsM0mfHv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 17:56:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 17:56:28 +0000
Message-ID: <9b82e8c7-9308-1f99-a144-2cd2a770db73@amd.com>
Date:   Thu, 8 Dec 2022 11:56:25 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/3] ACPI: video: Allow GPU drivers to report no panels
Content-Language: en-US
To:     Daniel Dadap <ddadap@nvidia.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
References: <20221208164207.13518-1-mario.limonciello@amd.com>
 <20221208164207.13518-2-mario.limonciello@amd.com>
 <Y5IjqZH8ocDkG2hx@ddadap-lakeline.nvidia.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <Y5IjqZH8ocDkG2hx@ddadap-lakeline.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0022.namprd15.prod.outlook.com
 (2603:10b6:207:17::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3d90d0-5765-4b93-3f5c-08dad94587af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EShImsYqpDsY9FZkTiCWwEvbsQuoqY9foVlnVWMEHLpzfnCGoFIwUIt8CADKjDxkNhGSr4BnFwrJC0xF4RqjJT6WUJhP92l+fKSitfFwnrtytk6jBiIg6wdUAANPguV9wpcj+89JtZuhJhUEbKaOqxi84JqYvMCQ1pfvIf47VbhaIqzZUiDrpzd7xvzNHdOot+AH5vLVW2i403Ms0sQag5q4JHcWKpskTPcSDa0tcUN9kmml3pD7vTdV3lzDn/omLLvW9Trk6argHDzmofGVoD0yM7KqiJzIjrnVoM1NrrZatfAqW8Knjl28IGXWoeD+naoEMj/X/izTbGDxystqEdi3rTaT446/i3uSVVxJg2eLBOi/j6adJ9hxAHxb7xXyrxXnqgwkmWzf4doiEV2LX6oBGYg9xPAUToan8JEB/y3Vl+t4Cju0cty/dRq5s0g+EXxctrI8p3YZDN6MHvoobTxanJ37pvGqaK7Qze32Pkjh85lVGUIaXkHEx0A5qJ3zdSqKvdFKDMfkiotoS5abSPhzifnIYOeh5kwhvgAYeWUJ4q0i+tpzPDug49PZLougrVJvvnuKdLmreEvhg1HBjvcZOX4/Dgw+E8cRZhvjYA0Zkg+uQINu67M3dn6xlylnhmAn48Xnf7ityeMa+OG+mwv7ni/Yajdc3KDebfIROGkYMVefwBr4aOv8zlRWEtaasiF8XCtwiKf3vhTKjUAlbcuR8w67ZShui6zmNBJPPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(66946007)(83380400001)(31686004)(86362001)(41300700001)(31696002)(2906002)(5660300002)(8936002)(4326008)(6666004)(8676002)(26005)(186003)(6506007)(6512007)(53546011)(2616005)(6916009)(6486002)(316002)(478600001)(66476007)(54906003)(66556008)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmNmb3VDQlVRWS9LcVZYdTkzRlBGdHNqTmU1L0hQT3puVkVVa1VkeGVBelhs?=
 =?utf-8?B?M20ra1JiUEx0QmRHUXVhUEFpRU8ySlkvWEpURVpyd2NzYUR2alA2VFIrSFlL?=
 =?utf-8?B?TCticThCNnJ3S3RCS1pBSmtCUFhZdWljZzZwd0dqWGpudTJkQUpKQ002OTNn?=
 =?utf-8?B?QzgwVXBZSzhwem5QbG1rbktuQ3ZnYkllMU5aT0VOYlFuZTZwM2hLM0hEdzFW?=
 =?utf-8?B?WWQ1dGl0VXRaRmRrSVFDYjBxT2EzYVhhWjJPZ3ZTV1ptK0Rmem5BT0lSMW0z?=
 =?utf-8?B?L0lORTRRSVVYcjE0R20rWXVQQXpVd3JFbVRrTFl3SUxoclJVT3I2cXBkMDR1?=
 =?utf-8?B?Mk9aQ2JiUDFFeU8zd00vQlN6MzZHdlBUbWZrMHY2a2ROeFpYUDB2bWE0ckZ1?=
 =?utf-8?B?bG5ob3BqNVAxZERVTjhrRThLbG1Da2FHeWJjT2FBVjVobmJ5Z1lQUCs3TUIw?=
 =?utf-8?B?RWZKT1UwUEVMaUJNY2t5bFBWR1FXWTlxL0xYcEdhZ0lWdTNwUDNsLzZjZDQ4?=
 =?utf-8?B?YkFpeUVPZDYxcXU4TStubW5IS2JuM0R2S0YyV0dlUjRpanI3cWJzbFJWeTBt?=
 =?utf-8?B?dTByckV0M2hHUzdDOUxxZXpQbUdGblU4cGZBQlJ6aDlvdW90MXI4eCtIY0wy?=
 =?utf-8?B?UUNjZjNhbVhkcC9MRVFvd3lrcUwxcWJaM0NwMHdweTVhNHZoRXZVTHNNbjZy?=
 =?utf-8?B?dDRUQ1hxMXptYlJ1M1RCTFhZemtHeThFaFgwT2lrSDByYU5SR0hsaSt4aDU1?=
 =?utf-8?B?eG5GYUJETmFvenZxbmh6NTNHUzNDMnhEWXArUFhBcnpic29KVFRHWWI4K2pW?=
 =?utf-8?B?YmMxOE4wTzBJL3l2QzloTG5WM3ZuOTh5UVpLYUNqT2VwYjRaemR6cmUrdVBv?=
 =?utf-8?B?K3ZvajhNQ2ZCY05yVTdDU2FMSXNKVGVnMWJrclZwekhreEVLZVNrdFZsRk5v?=
 =?utf-8?B?WmZyTnFHYzZlWWx1dkFLMlljcHJpalM2OUUzN0Z6YjlLSDdveHpWOE1vZUlt?=
 =?utf-8?B?NTVSNzdLNjk2T2hWQllpb0Z5ZzhhS25NRmh6YmVyR1BUMmJERGlnS1FUdzhX?=
 =?utf-8?B?T1p4SEN4ZUNqVXErNnYwLzNtV0JUYThDcm8wN3F3T3VwbDVjdGFZWndaQitC?=
 =?utf-8?B?elRpTWsrVklHT05CeFFNZVVoNWJIU1daUStDVHp6MVdtK0U5Z3hRVUdGbnVD?=
 =?utf-8?B?dExtVnRaMFNUN3ZXdklDVzFoZzhsL2E4OHRXTEw1UkpyL1hPQlBmemZiZzhy?=
 =?utf-8?B?OFRBdU5STlpEWmNzWGlHMVowVGdxSXBkdFJHbHorbGFhMXg4UHZsVjdyOEJh?=
 =?utf-8?B?T2tST0VENk14YWNoUkV6MHh6NjBwNytaVmxlSFJwQVg2bERnUy91elM2UWZh?=
 =?utf-8?B?Um03R3VlK1lmamxEUit4dGorb0daYVNUTW1odllaZVNmVFZGRmlwbHRMc1Jy?=
 =?utf-8?B?UzAzbE0zQVNwTjhROE5NWTVOSHhYa2M1QkJibzRoUlJ6Yzl2aWlrQlI5MHJq?=
 =?utf-8?B?R3gxNk1YTzgrN1hrQnkzQWtyRXlGQzg3MjVLdlo5ekQ3clloenhjTno0S252?=
 =?utf-8?B?NWVOaWczQ3J6OFFYdldNWTU4VG11UEc5VSsxSmgxZFdXbUMvcHVMNms3SXBx?=
 =?utf-8?B?N1g4a0JucVE1QzRQMlpDbXYzN01XQ3dHU0ZwUmxyZHBtYkdwZy9Ibk1YZTEv?=
 =?utf-8?B?N1ZBUk9ZckpWdERmK1hucUhuajBNR2VXUGdjOStsaTJtZGN6cnNnSE5DejFR?=
 =?utf-8?B?KzhZVTVOR2hRQ2d1ejNiSXIyTU1CNnNJOEx3WFBRWUVCNG1qYUUwR21UeUJK?=
 =?utf-8?B?ckJpbkZnUWRqakk2RlpqU0tydXpWb1hkSmd0Y2xJdGFJUjdkenl6cGN0L21V?=
 =?utf-8?B?MytVLzYyTDBBUUljWjZrcEZ4UmNjSWVnbGNQVGhUL3RCMjg0N1JUcG44SlJ2?=
 =?utf-8?B?NnhwalRkekw5c3FJNEFXZm9zeE9pU3F0OHYwNHErVDZOektJSGdBb1NnbjBK?=
 =?utf-8?B?Qkh1SXZSUXdQOWNWWDZQM0N2UEFOWEY4dkdrN1FucTNqdFQ0dXZMOVl5azJp?=
 =?utf-8?B?N3NHRTY0QTdpZlNVSmtaaGNSdHJmUWd6TFRuckNKR0ljMFYxMTI2N2Y0bDRK?=
 =?utf-8?Q?jSq0rAdMzAM3B8Aihxitprfaj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3d90d0-5765-4b93-3f5c-08dad94587af
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 17:56:28.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex0iujTexd1uxdw9X44GdyIs/yK4VBMmM8dDVXjcxnIAGGTjQFQPYhlKOWdDe1lWVpLOMiOa8e+bhHtFxU/gtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/8/2022 11:49, Daniel Dadap wrote:
> On Thu, Dec 08, 2022 at 10:42:05AM -0600, Mario Limonciello wrote:
>> The current logic for the ACPI backlight detection will create
>> a backlight device if no native or vendor drivers have created
>> 8 seconds after the system has booted if the ACPI tables
>> included backlight control methods.
>>
>> If the GPU drivers have loaded, they may be able to report whether
>> any LCD panels were found.  Allow using this information to factor
>> in whether to enable the fallback logic for making an acpi_video0
>> backlight device.
>>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> v2->v3:
>>   * Add Hans' R-b
>>   * Add missing declaration for non CONFIG_ACPI_VIDEO case
>> v1->v2:
>>   * Cancel registration for backlight device instead (Hans)
>>   * drop desktop check (Dan)
>> ---
>>   drivers/acpi/acpi_video.c | 11 +++++++++++
>>   include/acpi/video.h      |  2 ++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index 32953646caeb..f64fdb029090 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -2178,6 +2178,17 @@ static bool should_check_lcd_flag(void)
>>   	return false;
>>   }
>>   
>> +/*
>> + * At least one graphics driver has reported that no LCD is connected
>> + * via the native interface. cancel the registration for fallback acpi_video0.
>> + * If another driver still deems this necessary, it can explicitly register it.
>> + */
>> +void acpi_video_report_nolcd(void)
>> +{
>> +	cancel_delayed_work(&video_bus_register_backlight_work);
>> +}
>> +EXPORT_SYMBOL(acpi_video_report_nolcd);
>> +
> 
> Thanks for removing the desktop check.

Sure.

> 
> It's not entirely clear to me what happens if you try to cancel a
> delayed work that was never scheduled. I got as far as determining that
> del_timer() in kernel/time/timer.c will probably return 0, but I didn't
> really feel like walking through the rest of try_to_grab_pending() to
> figure out what happens next. You've probably already tested this with
> the default disabled timer, so as long as nothing bad happened there,
> this seems fine.
> 

Yeah; I did test it and nothing blew up during my test.

> This is probably overly complicated, so if you think it's worth doing, I
> would definitely add it later, but I wonder if it might make sense to
> pass an acpi_handle to a _BC[LM] method or one of its parents, so that
> this could be scoped to a particular device. Looking at the ACPI table
> dump from a random multi-GPU laptop, it looks like there are two
> instances of _BCL, one under _SB.GP<number>.VGA.LCD for the iGPU, and
> the other under _SB.PCI<num>.GPP<num>.PEGP.EDP<num> for the dGPU. The
> caller would pass in handles for methods/devices that it will handle,
> and then the fallback, if it runs at all, would skip any handles that
> were registered with it when it crawls for _BC[LM]. Or the equivalent
> inverse logic, or something else like that. I think it's probably fine
> to keep the current unscoped design and just assert that any other GPU
> drivers that want the ACPI video driver to handle panel backlight should
> register it explicitly; if for some reason that ends up not working out,
> we could revisit scoping it then.

Yeah that is a lot more complex but complete setup.  I think if we end 
up having to revert the 3rd patch and having GPU drivers call the 
registration explicitly isn't a good idea for some reason it's worth 
considering.

> 
>>   int acpi_video_register(void)
>>   {
>>   	int ret = 0;
>> diff --git a/include/acpi/video.h b/include/acpi/video.h
>> index a275c35e5249..a56c8d45e9f8 100644
>> --- a/include/acpi/video.h
>> +++ b/include/acpi/video.h
>> @@ -53,6 +53,7 @@ enum acpi_backlight_type {
>>   };
>>   
>>   #if IS_ENABLED(CONFIG_ACPI_VIDEO)
>> +extern void acpi_video_report_nolcd(void);
>>   extern int acpi_video_register(void);
>>   extern void acpi_video_unregister(void);
>>   extern void acpi_video_register_backlight(void);
>> @@ -69,6 +70,7 @@ extern int acpi_video_get_levels(struct acpi_device *device,
>>   				 struct acpi_video_device_brightness **dev_br,
>>   				 int *pmax_level);
>>   #else
>> +static inline void acpi_video_report_nolcd(void) { return; };
>>   static inline int acpi_video_register(void) { return -ENODEV; }
>>   static inline void acpi_video_unregister(void) { return; }
>>   static inline void acpi_video_register_backlight(void) { return; }
>> -- 
>> 2.34.1
>>

