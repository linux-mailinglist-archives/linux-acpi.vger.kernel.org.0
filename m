Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949504CB529
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 03:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiCCCyN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Mar 2022 21:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiCCCyM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2022 21:54:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52292C105;
        Wed,  2 Mar 2022 18:53:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er9sDj5mnBBlnNgA1X4AOMwu+XmGgSPhsUIMGbHLKd1DfGL+B3jjcFme4IiWmIBqRLjAwIGV9/1sXvvoDwNMpK98gymSoUnjVzfqEfK2YPhpLKVZQMS+38OnlzUKFCVp5gxg/FhITpLvH0w2ueozHXxFchERgsJ1uOYgE3qc971OI4SeMS6Gze/b9iR86FxxklmooIU1p79Usm/gokSYgHH5tPuUzjMWzuToZWZbMsudj/2smzYzMPYH/PMYszS4KrP6gy1/6/l8SYfJ1ix4eZpCx5g6FeLi+0Ll31DEtf9574Qksp3SJ38lU+Q5wX9gx3UD4fYnNWit6oYMd0bfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SArLsEojJ1J+coAh9qiAg74gXFPOYL5wZGAMc20Wcks=;
 b=VnoxasYRTbqwSfdmQe9lYUCcBZfPW1U2RnW2LxIwhzcM9S9JjS2NRZjPpnb6TneaKuotjQhdbmNHSjNuBRZfx7eOck6kh4qJp66ehaHMjAiiUQwFxov7Swr5O5u+PZZgABa/scZz96Xje9nCqyvkqoUSrgZ23bbrZWn33fH+2329wU3nbUif/l7nifpmGm7QipaoiobthLLuuxpqu/d4+4Gy9o55GOAew3KIt5PRuemuVARoEDXgKYItA0lcayGJf0opt8sDFMotaX4uLWuhEloCrJMBt7zG6sgauotdepoRh5bcz8/ewCEFF7P9xLUfe1LEZY5IZCaSj3E+iDvC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SArLsEojJ1J+coAh9qiAg74gXFPOYL5wZGAMc20Wcks=;
 b=vo2I99jO64UIySH3lHEVeCGzm4oIO6UY71/ZGL7ELlk3sPuzzPQaHFyxrvgTZvR3emCh02mRCdNlx0oLoLw2DEtiKeXUixj0Y5RUjFkwJExUSmiURI1i7KDOLNqB44PUd3NUPXBi9RLZQQRKoyh+6kPUgy4MzrwsJ9O7EWClreE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MWHPR12MB1295.namprd12.prod.outlook.com (2603:10b6:300:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 02:53:24 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 02:53:24 +0000
Message-ID: <e6a3380d-dcc4-8e61-cba0-813d2404ee1e@amd.com>
Date:   Wed, 2 Mar 2022 20:53:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC] ACPI: platform-profile: support for AC vs DC modes
Content-Language: en-US
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     rafael@kernel.org, hdegoede@redhat.com, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220301201554.4417-1-markpearson@lenovo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0030.namprd07.prod.outlook.com
 (2603:10b6:803:2d::23) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6b0a637-8f08-43e6-2875-08d9fcc0fbfe
X-MS-TrafficTypeDiagnostic: MWHPR12MB1295:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1295834FFB94E4A50951683CE2049@MWHPR12MB1295.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9N0ZTb0pBiMaIZXM2mA9dApUEmxl7OMZQIrlhG8im4GnmJZLP5ChOu+0cZSql9Dfe1kbADpYbVmqm//itSQn8V/yQilFCtML9LWuk/thziaAot/3mPAOpQ0/R7McU8hFpqG3Z6H8V1x2F3GjMepjJdVcY/0fH1pgHSSwwly+jscsEJ5BJRU3v2xCylP2bM0mU1qIt40VBoxZSOtiyaHNp3MgtxNF6rI0UDCQQTWvaA9VneKc+ooE30q2tTZjxQvbvTT8QCFMVFe+bMFQ3u/IUEOe7esSJypSROYJsDMQkYX5UF4no142U4eUD0L1Vo1/xxM3vrVger173n9XODg3aG4EGbUlJlR+V1/uH1u8F2XQIuhqo/d0H73uOFpZkinwo+2NPuBHIFOC0glj31CSMSPOFmTi9yi9nQQAB35+L8Lqb9aUeLrkwgfkp5Y+IAdNETRptn44cRS5S83qFVRHNMNT42pbk7b3I0AK8chwd8sWpLHeLaKIFx+5hwBT0fN25nS6ytxk/CC1Yk083aHFeKBSdtNHxQ/Z7XEJ2m1aKB3T42KmqVKw5CkkNuY86X4tflcq9LT6P4i1tGx2xYUA1dvOwHOzPSkLKbmXH6TTVgiJKeVeigfxUKFhQzQjwdNOC8rLLhz2Kvmstl17Wt3Y33Pq+Fy4Q7yjesZkkVrurqkS/u7A8smtgfeNFnMp472bzUhOFyrD7bmUrT+C5hgCzrnmTNBDRphHQDB4i6VTnM/UsyVN5edHiGMyH0vH84+c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(86362001)(6916009)(6486002)(316002)(6506007)(53546011)(6666004)(83380400001)(6512007)(508600001)(2616005)(44832011)(8936002)(5660300002)(2906002)(66476007)(66556008)(66946007)(186003)(38100700002)(31686004)(36756003)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ty9yOHNoM01IMVlJK25KSCtNaWFtczhRc0huRytxMlhVVmsxRUExSERJZk5Q?=
 =?utf-8?B?SlhiUDFnT204RFc1cnJtQ09XOHVwc0FRK1NQZjNHNWRhNVRVb3MyejFuL0tJ?=
 =?utf-8?B?TGd5UTlZVlc2Vy8zV20xRnRJeWFBeWRMLzlodmljaVZsclQ1eHo0VUM5NFA3?=
 =?utf-8?B?VlZ2RWdDVGRTZFNwN2NDcjVyYU9aMDJFa0hQRzBJMkZ0RFBERllRMFMvTEJY?=
 =?utf-8?B?ak1WK3hUTWdlRG8wTFFFeFhaQ1JvdUNySUtYUW81STRMREF6OHkyK0gyY05R?=
 =?utf-8?B?SThxbWtLUnRsU1JuNmlNQmZMa291YkRua01hYUdhQ2hYamtWUWRoMFBwNjFG?=
 =?utf-8?B?WEVuSEtTdjFKOFFlNW9xYldrcGdVTXNXUm1PUVdYUVVSL2hWNjdvN1RXdmZZ?=
 =?utf-8?B?UmtLMVVpK0dLcTA4UThoZ2JlcFVvR2JGYmpLME9lUUFhK3FLb3l2c01nV3Yw?=
 =?utf-8?B?ZnhoZFBjdFk5QlRrSHRHRGRsWWI5aFZ2eEZ4eHhhTU5NNFRxU2xZRmlqZzNT?=
 =?utf-8?B?c2Jadnd3aUVHOHF4UE5HMCtXMmh3T0oyV0g5aFoxci8vMCtiREFsdkJNZ2xx?=
 =?utf-8?B?YUpSY3dpU05sMDl1OTdXODdLL3JVbldaVXVadjhYVTRyczJuSzdSb2dmRGh2?=
 =?utf-8?B?R2FDUWNuaFdzdlZ3KzB2anRqWXRBZURBU1pRdU4wWUorVHk1djRvWWxWdGN3?=
 =?utf-8?B?SWRZZUtvZmJHaTU2Q3lPNVVsT3F1eURsd2p5Mk5YL2pzMW1ha2YxemFYb0tl?=
 =?utf-8?B?eFRnTlM4ZmRSeE1IZWluR0hOaGRZL1RPaGYyYUxpYmJFYWptYm1SUUZrN2Ew?=
 =?utf-8?B?VDRhOW9QbUhUN201UVlEd25uRzVRL2RaS2NwV3dBVjZCbUVYV2RXTmVtd1Zu?=
 =?utf-8?B?aGY5ZU13MnNoQm9vME8rZ0xMTDZpU2NQNko0endGQm1HYTlySHdrRDdoVmc3?=
 =?utf-8?B?K2MyeHNPa1p3LzRESjR2bDRtK1UyYm1HdU13c0FHa1RaWFgraFVUZ1BjenlY?=
 =?utf-8?B?R3FTYnc0ek80ZkxaM09kRGtQWlI0cWMxeEFRYU5OeExRNDY4UjRaL1cyZTU5?=
 =?utf-8?B?bDh2WGp5WFFCZWhIUC9ZclpkeFp3Nk9EMUhMQWhxam56YUwvNks1OWdvUDVu?=
 =?utf-8?B?akYvdDAzT1FPb3dKOEg1Vzl1R041d2FydVIrYVNidFNJMUhJekpmR0J1ckF4?=
 =?utf-8?B?ZGcyazl2cHJkUGRoTDZzR29GSjJleStIT0hKa1Y3K2NWdVNFOHFYdG4zSSti?=
 =?utf-8?B?RExRNU5PZVRHNXdITEltdHJLZlFRaW9GWnRHcnY2aW9Qai9MeDJnRVY1bFNX?=
 =?utf-8?B?VDdURTMyOXlwNUd3Q0k5WWEzTUVZc2RoR2ZIeEVrK2R0UlpqaVJWeksxdHMv?=
 =?utf-8?B?cFNzSVRRYkgraXhOcnBpb3Y2SjJvK2cxRlo3bmxqb1RqQ1dHamhFWXFwOHJj?=
 =?utf-8?B?RVFMdk5qanJ5SkJPSlEzS0o3MVBNR2hQMFpieVkzTXFpalg3aUxEQm94QXNa?=
 =?utf-8?B?bUJsS1Z5djVpTEpBUFJlRVlhTis1T1BrYkd0WW9tdnVzZHkvVGp2Uko1Yi8z?=
 =?utf-8?B?d0cyVkk4NXlYSXljNFNiZzE1TDE0amF0M2RSOFBmUkhaTnF3WlAyQ0xGQ005?=
 =?utf-8?B?RmNBbFVPS1ZUUXovU3BGUTYrU3FHaUp6amUvdVlOSWpJV2NTMWpheVdIeDhT?=
 =?utf-8?B?bWdqQ04yd0RCMEsrWko4Wm1YM3V4L20zUkpnRDZ4aG1qMWxicFY4OXVuZVAw?=
 =?utf-8?B?NG9CdmhOM0FpdnlPajVLTkZYRG9qTFBJM2VBc09NK0lXY0NTdFJVcHRYMjFh?=
 =?utf-8?B?VFl0TzREdGgzSDZTRG8zT2dNT1lRRzQ1cFhKSHZWRVhCTkZtdEpwazd3ZDJr?=
 =?utf-8?B?WFpmQkNSS2IyK09GTFFsK3l5L0t4V2dQN2xOU0xwSjlleUVVUFkzUE5LT3J1?=
 =?utf-8?B?NVNZR0ZrRmNKcUZTSlR3Q3FmcmFMV3p3LzN6STR4YVRmUDN5ZEwweTlWK254?=
 =?utf-8?B?eDFLNkF6SnRBNk02TEVyYllEbml0S0RkY0NSdmx0bkRkei9rNnpHVWoxaUNQ?=
 =?utf-8?B?aHVlT1Y3YmxLUEU4d3hjMDNYenhiQk9NdzQ0dEt3LzEvZ3l1Smk0TUNNd2wz?=
 =?utf-8?B?S2dFU1djK1VXcHpEM05senEvbXNKbHpjblV2MUlyQ2NoalNCc3h3cjVhOVd3?=
 =?utf-8?B?WXMreHlDcnlYTnBaYWFlRjNiai9ONkx3ajhMNmNIMVlWRDR5YlpGaUZ3OTdX?=
 =?utf-8?Q?CXIV0REN98uPQivYpk+VRE2MWwh1wqYAJja/uQqPS0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b0a637-8f08-43e6-2875-08d9fcc0fbfe
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 02:53:24.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6D1qYjRy42ObETNLILy+gQPNTOBc4w0z/FNypoyaI0qCJRxVojLNRH8EaQUht7+GCd/RhTRORwll601Zd8OfyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/1/22 14:15, Mark Pearson wrote:
> Looking for feedback on this feature. Whether it is worth
> pursuing and any concerns with the general implementation.
> 
> I've recently been working on PSC platform profile mode support
> for Lenovo AMD platforms (patch proposed upstream last week).
> One of the interesting pieces with the Lenovo PSC implementation
> is it supports different profiles for AC (plugged in) vs DC
> (running from battery).
> 
> I was thinking of adding this support in the thinkpad_acpi driver,
> but it seems it would be nicer to make this generally available for
> all platforms that offer profile support.
> 
> This implementation allows the user to set one profile for when a
> system is plugged in, and a different profile for when they are
> unplugged. I imagine this would be used so that performance mode
> is used when plugged in and low-power used when unplugged (as an
> example). The user could configure it to match their preference.
> 
> If the user doesn't configure a DC profile it behaves the same as
> previously and any ACPI power events will be ignored. If the user
> configures a DC profile then when a system is unplugged it will
> automatically configure this setting.
> 
> I've added platform_profile_ac and platform_profile_dc sysfs nodes.
> The platform_profile and platform_profile_ac nodes will behave the
> same when setting a profile to maintain backwards compatibility.

To make it more deterministic I would say configure it like this:
1) If you write a profile to `platform_profile` and the backend supports 
both DC and AC profiles make it the default profile for both.  This is 
more like "backwards compatibility" mode
2) If you write a profile to `platform_profile_dc` and the backend 
supports both then don't do anything in `platform_profile_ac` and vice 
versa.  Require a user to write both of them explicitly.

That means you have a new state of "unset" for the profiles, but if you 
don't include the state then I think it can lead to confusing behaviors 
if userspace writes one vs the other first.

> 
> If you read the platform_profile it will return the currently
> active profile.
> If you read the platform_profile_ac or platform_profile_dc node it
> will return the configured profile. This is something missing from
> the current implementation that I think is a nice bonus.

Yeah nice bonus.  Some inline comments on this.

> 
> User space implementation could potentially be used to do the same
> idea, but having this available allows users to configure from
> cmdline or use scripts seemed valuable.
> 
> Note - I'm aware that I still need to:
>   1) Update the API documentation file
>   2) Implement a disable/unconfigure on the profile_dc setting
> But I figured this was far enough along that it would be good to get
> comments.

If backend doesn't support AC/DC I think you should return an error for 
one of them rather than trying to hide the difference.  Think about 
userspace - it might want to have say two sliders and hide one if one of 
them isn't supported.

> 
> Thanks in advance for any feedback.
> 
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> ---
>   drivers/acpi/platform_profile.c  | 130 +++++++++++++++++++++++++++++--
>   include/linux/platform_profile.h |   1 +
>   2 files changed, 125 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d418462ab791..e4246e6632cf 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -7,6 +7,7 @@
>   #include <linux/init.h>
>   #include <linux/mutex.h>
>   #include <linux/platform_profile.h>
> +#include <linux/power_supply.h>
>   #include <linux/sysfs.h>
>   
>   static struct platform_profile_handler *cur_profile;
> @@ -22,6 +23,51 @@ static const char * const profile_names[] = {
>   };
>   static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>   
> +static struct notifier_block ac_nb;
> +static int cur_profile_ac;
> +static int cur_profile_dc;
> +
> +static int platform_profile_set(void)
> +{
> +	int profile, err;
> +
> +	if (cur_profile_dc == PLATFORM_PROFILE_UNCONFIGURED)
> +		profile = cur_profile_ac;
> +	else {
> +		if (power_supply_is_system_supplied() > 0)
> +			profile = cur_profile_ac;
> +		else
> +			profile = cur_profile_dc;
> +	}
> +
> +	err = mutex_lock_interruptible(&profile_lock);
> +	if (err)
> +		return err;
> +
> +	err = cur_profile->profile_set(cur_profile, profile);
> +	if (err)
> +		return err;
> +
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	mutex_unlock(&profile_lock);
> +	return 0;
> +}
> +
> +static int platform_profile_acpi_event(struct notifier_block *nb,
> +					unsigned long val,
> +					void *data)
> +{
> +	struct acpi_bus_event *entry = (struct acpi_bus_event *)data;
> +
> +	WARN_ON(cur_profile_dc == PLATFORM_PROFILE_UNCONFIGURED);
> +
> +	/* if power supply changed, then update profile */
> +	if (strcmp(entry->device_class, "ac_adapter") == 0)
> +		return platform_profile_set();
> +
> +	return 0;
> +}
> +
>   static ssize_t platform_profile_choices_show(struct device *dev,
>   					struct device_attribute *attr,
>   					char *buf)
> @@ -77,9 +123,34 @@ static ssize_t platform_profile_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>   }
>   
> -static ssize_t platform_profile_store(struct device *dev,
> +static ssize_t configured_profile_show(struct device *dev,
>   			    struct device_attribute *attr,
> -			    const char *buf, size_t count)
> +			    char *buf, int profile)
> +{
> +	if (profile == PLATFORM_PROFILE_UNCONFIGURED)
> +		return sysfs_emit(buf, "Not-configured\n");
> +
> +	/* Check that profile is valid index */
> +	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
> +		return -EIO;
> +	return sysfs_emit(buf, "%s\n", profile_names[profile]);
> +}
> +
> +static ssize_t platform_profile_ac_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	return configured_profile_show(dev, attr, buf, cur_profile_ac);
> +}
> +
> +static ssize_t platform_profile_dc_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	return configured_profile_show(dev, attr, buf, cur_profile_dc);
> +}
> +
> +static int profile_select(const char *buf)
>   {
>   	int err, i;
>   
> @@ -105,11 +176,50 @@ static ssize_t platform_profile_store(struct device *dev,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	err = cur_profile->profile_set(cur_profile, i);
> -	if (!err)
> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -
>   	mutex_unlock(&profile_lock);
> +	return i;
> +}
> +
> +static ssize_t platform_profile_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	int profile, err;
> +
> +	profile	= profile_select(buf);
> +	if (profile < 0)
> +		return profile;
> +
> +	cur_profile_ac = profile;
> +	err = platform_profile_set();
> +	if (err)
> +		return err;
> +	return count;
> +}
> +
> +static ssize_t platform_profile_ac_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	return platform_profile_store(dev, attr, buf, count);
> +}
> +
> +static ssize_t platform_profile_dc_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	int profile, err;
> +
> +	profile = profile_select(buf);
> +	if (profile < 0)
> +		return profile;
> +
> +	/* We need to register for ACPI events now */
> +	if (cur_profile_dc == PLATFORM_PROFILE_UNCONFIGURED)
> +		register_acpi_notifier(&ac_nb);
> +
> +	cur_profile_dc = profile;
> +	err = platform_profile_set();
>   	if (err)
>   		return err;
>   	return count;
> @@ -117,10 +227,14 @@ static ssize_t platform_profile_store(struct device *dev,
>   
>   static DEVICE_ATTR_RO(platform_profile_choices);
>   static DEVICE_ATTR_RW(platform_profile);
> +static DEVICE_ATTR_RW(platform_profile_ac);
> +static DEVICE_ATTR_RW(platform_profile_dc);

My opinion here is that if you are keeping the existing one in place to 
show "current" active profile and make the new ones to show you 
"selected" profile they should have a different naming convention.

Some ideas:
- selected_*_profile
- platform_profile_policy_*
- *_policy

Something else that comes to mind is you can rename "platform_profile" 
as "active_profile" (but create a compatibility symlink back to 
platform_profile), but I don't know that's really needed as long as it's 
all well documented.

>   
>   static struct attribute *platform_profile_attrs[] = {
>   	&dev_attr_platform_profile_choices.attr,
>   	&dev_attr_platform_profile.attr,
> +	&dev_attr_platform_profile_ac.attr,
> +	&dev_attr_platform_profile_dc.attr,
>   	NULL
>   };
>   
> @@ -161,7 +275,9 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   	}
>   
>   	cur_profile = pprof;
> +	cur_profile_ac = cur_profile_dc = PLATFORM_PROFILE_UNCONFIGURED;
>   	mutex_unlock(&profile_lock);
> +	ac_nb.notifier_call = platform_profile_acpi_event;
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
> @@ -169,6 +285,8 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
>   int platform_profile_remove(void)
>   {
>   	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +	if (cur_profile_dc != PLATFORM_PROFILE_UNCONFIGURED)
> +		unregister_acpi_notifier(&ac_nb);
>   
>   	mutex_lock(&profile_lock);
>   	cur_profile = NULL;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index e5cbb6841f3a..34566256bb60 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -15,6 +15,7 @@
>    * If more options are added please update profile_names array in
>    * platform_profile.c and sysfs-platform_profile documentation.
>    */
> +#define PLATFORM_PROFILE_UNCONFIGURED -1
>   
>   enum platform_profile_option {
>   	PLATFORM_PROFILE_LOW_POWER,

