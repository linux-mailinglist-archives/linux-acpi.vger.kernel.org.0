Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AB16D4E1E
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Apr 2023 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDCQjQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Apr 2023 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjDCQjG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2023 12:39:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BD72691
        for <linux-acpi@vger.kernel.org>; Mon,  3 Apr 2023 09:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT/f1ybkedz+9lnvQgilSo/cEp1hzaYaFgX+y0D8489/7S08cwmHRrV8hW8k+4kctg5wBcakwpFwbrf5zLiHWpGF5STDEgPDDRP0ZJXVPlz0z0TVtlUj88wUcStTe1bIfQAU3L7TcX1QngvAiyZlDEy4CQ/6u6sRhUcR12jYmk3ThPrtjgqVqPWrWRlKpWK3pgw7jlT1swdqxUL1Lo7aioHT6//03wehhavYS8OBDidABmHne8D6+XDExSAU/AKc2iaM7iSKqF9Ja68v3zI/CK6ycymiqkeR9ahrywWk3EXlfoy7z7s8utacpSjKXhfWkmd9+GxRjq4fs7mdGi4+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wo9nMIMmcYffS6eT4RYHT+ZDgfo98R7tZV3GW1TSXw=;
 b=JQPVELd5qUdL+LmXOqqwNob4TIyNvHbCfq0Yu4XKAomjcHmsY3CB51mnuX0XR23JZs73yU1iOJ2eYy56QcLyCwM0ERThcl5aFJYR+IWrtjRl6ORcDBvzVyNwdEA6OakgYUuhG+PzJrSkV7zJx8w5kH4PYXDUmiIsKyCW3kvj4xso6Rr8BMf/SSND0eQiITwhsAG7vIfX6E6mV6ZmOvEMXLcRjbTKE+rnhM0zKF9sJJhdOluqSO904BOEEn/XcFE+IphpJ0QBcgwiUp1porR5+yLEE3Mf0zcVvNQHzhVA2FOiOQDLrg7R/7Vm3uvXwFJkj4NMihmdj2rMxFSpxe7OSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wo9nMIMmcYffS6eT4RYHT+ZDgfo98R7tZV3GW1TSXw=;
 b=Rw74gLVrDiS6CZ4nTBf2resCDRTb4RkESQ+X0+sgctqGs9VQ09PjzAWF6LRzYLImGN+BjJCZg4vfDSmtA72LwCZhSTNVEf/UV90J9uyR4TD7NJNyYxniWuyTS475TRcJiQUXR8Mv2JgzwXjL/o+KFZ8UtLeLQfX/vOKQBmlKmBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 3 Apr
 2023 16:38:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 16:38:50 +0000
Message-ID: <ae9b7a47-9b04-2f62-e3bc-8dcdbf5286fc@amd.com>
Date:   Mon, 3 Apr 2023 11:38:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/6] ACPI: video: Remove register_backlight_delay module
 option and code
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20230403160329.707176-1-hdegoede@redhat.com>
 <20230403160329.707176-6-hdegoede@redhat.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230403160329.707176-6-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:610:e4::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: f028d3af-99a5-4004-e36a-08db3461e74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZGPomAx8lxXai3DUDxwjmsihSZGR51mjyjwSk8jrGdggSEsFHtjRau1oj7UJxysn4etecjwGmM7lfGdwes5152Qk1WwO94kW+pXe+20MDauY4+dJyDuc5yYu1QZ9SNF1+puSVP2Y0qYi0bDbjs1Z8iPY3Oq7x8cjvbzpKY6jRiuXFc0naEqoCLPUoWhDz0pPSsfaCKb/oCgwe6J77p53jHiDYKr04duTFKQddFYw3Nmxv61of6qtD8Vlg1qt0JZdVC79Xo9oOKxlSFh139KfZOsa+lqBaZus66xd1+Q29eLlum/J+/qd1xXo1hDSeU1iq5Arz6zS8Q0Ibe4+VFffnYkdCGzp2yvdtewEZk4I9CJCaInENOHr2DLGEOtXLnG6XjA6MRvxtNJabD7xVJBdUsAaqapQDC7ZS3elbD+uY0ZNGO/iRbgOpQrm0iwn7SmPBY8iZWFVPcNzdvtbw/AovoJIEHWFin1N5mwHZhRS8MnlIaAdB4IgJyK0suVoi+JxXKgvfVVGemyJxO83pRD9tiE6YB+/nfJE9KSYnEWxmho/HOTkI9LGHSZ5a3F96lqA7sC75lfJNaToB4o4e0XnnbHwNdJsrm2F8qOh0MbZAUbX2nmLko1Okly4F0RKkKb0dfIQ0YUOcoEPco8DKXa4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(5660300002)(86362001)(2616005)(6666004)(83380400001)(186003)(31696002)(53546011)(6506007)(6512007)(26005)(38100700002)(8936002)(66556008)(8676002)(478600001)(54906003)(66946007)(6486002)(66476007)(4326008)(36756003)(316002)(110136005)(41300700001)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW85UmxEcnRsb0lRRXBjWlhwdjFFV3FNRFZLdFJ4MUxMTGIvSXJEaGtMTTE1?=
 =?utf-8?B?a1N0OThFRlR1SDErRGpVTUliM3FnakNLM2h2N2RzMDRkV0lnUGRPdU1Na0hZ?=
 =?utf-8?B?MVR4T0kyS1pTWGpzdjJ3RjlLWHQzT0w3RElQUGFYVjNYRVNIWmxHa2dDenRW?=
 =?utf-8?B?UnhFL2YycDdNaXdyL0tQZ3Yxc1M0U0hCOHFCMGh0SUF6UENRWTc4TnNSNXhN?=
 =?utf-8?B?eE40STQxWjlJUTM2c1JBT2lZeDNDaC93Y3ZhMWhvTlg5YldYU2FheGFNKzFL?=
 =?utf-8?B?KzhnR1JzclF6WWZkdE0yRXYzQjV2eXg0OWU1RU1wcjd2TUpCR0gybVlEUHlL?=
 =?utf-8?B?YTF2N2x5VFFSRFdOeFFXWTNoYXI2ZnhTczBzNVhnQzFZUk9ZYlNSbWhoQXFI?=
 =?utf-8?B?NHVxbjkzcGdDRXFBcXJCblpocWFPQndIWmRnd2RGUjZ1V3FiM1cyOXFOOGlY?=
 =?utf-8?B?aHlZRTQyTUdUVno2Tzd4TjM3UUZBRGFFT3hoSHVQaWNsTkVEeGowT0FnVGNu?=
 =?utf-8?B?ZkJxSjgzdWlUVTZ6NFZxdjNTR0pRTVErSVZFM2VmT0Y0V09lMlRId0I0TzFi?=
 =?utf-8?B?NzBjUXpQVE4rWGhkQnJ2NSt2aXZLSVptc3EyK1BrdkdGSVF1WHN0YVk5dWw0?=
 =?utf-8?B?c0RaOW54c2NiMzBlNkxXQnYzdXRLTFBWYUtxMFo0Q2haZ0I3RkZQeUZUWjZu?=
 =?utf-8?B?N2NtbElJSjdvMTZZdnJ2emtxK0tqUzZCYVF4eEk2R1pETXhzOUFtQi9RaWVP?=
 =?utf-8?B?VUExdFhQTzQ5TzZ5NjlPZXdWclEraHBocTZ3QnBYYlVqQ3dPdUdxTEZ4OHd1?=
 =?utf-8?B?ZXlFODVrTm01T05oekZ2NUZKdVpnZUxRbmx4SnpEZUN4a0NqV053WjJEWFQ5?=
 =?utf-8?B?S1E5cmtQME5yL0hwUHQ0SGRRV2hZd1krTTljUGpHcEIyZ1RZRXNqdFcyR2lJ?=
 =?utf-8?B?S3pNYmw3azFqOHpWTTJYNUQrWkI4M0tIWXkvRlQ2WVRTTHV5YWtibUZpRzI1?=
 =?utf-8?B?SjhXZ2g1eWNXcmV4aXM4T2NRaGs5L25UUlc1MERhcUV6dHkyaFpUVDZIeTdR?=
 =?utf-8?B?cGZmUnhxaFRYSE52Q2JnRnh0OTVlOGRCb2Ezbm41Q2E0MDMzRTBWQStBMThw?=
 =?utf-8?B?MGptQlJkTWRyYmVtVW1Wdm85a0g1OUdLSk9tbStYdFUvYjF6WjliT3g3M2hi?=
 =?utf-8?B?RnNaakhzOE4ydkllY281ZEM5aWM2czNrVzlZdmorUjVKQkxwS2Y0dE5LQisr?=
 =?utf-8?B?dStaNGMwRzVwRzBRd1Nvcy92M01uSGtWWndxbDdkdjkyU3liYjVPakxiUDNH?=
 =?utf-8?B?aFFuT3VPTGw1OTAvejVQcUROaStUbnBYSnlGSkFpSmFrc1FaeHpWRXM2enA5?=
 =?utf-8?B?ZDhXRWRodytkcHVMNFdRcUZlaVU0KzJFUmU0UXRRdnVNVU8vbjlhVTlwTXhL?=
 =?utf-8?B?SlFmYVJVbDRDcGRtS25LTUlOc01OK05XODFkSXdKckVNWVpHUmZMQ2VJL1pU?=
 =?utf-8?B?OWhZU1FIU256dXgzRVhMUVpTZnlNTTMvNzAzS3c1SituNi9nRjZrNXhTTThh?=
 =?utf-8?B?aE5zTjFZR04xdk5udFFaQTVLRVZNbzNwRnpjdFRVSEFJemJwa1Iycnh1MUNK?=
 =?utf-8?B?N1N2Qnhaak5uK25XaUNXeE4vWEpNekZqMWY0Qmg3QXEyVXRIWnhmbllScTNv?=
 =?utf-8?B?eEhJbExvcUxPMnRmdFE1NVNHaWxiMlFVYlZ5NmRXbldyUDJIcUVpY3ZWMis5?=
 =?utf-8?B?NlNNeTQxditmS1hQcHo5Y1hmT2QvQjczWU4xcG4rMDc0djlJdkJoMlQ3Y1o0?=
 =?utf-8?B?ZW5OZFhocDkrTk1KOE1CVU1qcjNLcjhvb0dSVUp4MEdsMjF2MW9vQ1ZxS3FM?=
 =?utf-8?B?VS9pc2RZaHNLL29aejltNjRyN0NyM1RlVXFtbUE5QmRxbUw3bHMwcEJSbmpQ?=
 =?utf-8?B?R0dFTTdSUlh6bXdQVk5OQUN3YXVmbzBmaWxNSCtHa0FoZXJXR1NoZmVKKzBY?=
 =?utf-8?B?MjBhdHdzcHRqQVUwOUE4OFlJdFZtYzBWQzU0K0RZUlM4VU1qVUNXM2E3OXRy?=
 =?utf-8?B?RW9GanJHZjljYWhqQm9NZktJeFEvVGVETGRWbnkySVIrM3I0ZzYyNm9JTTB3?=
 =?utf-8?Q?gRiKuLlPN29wAUDr502u/CgTk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f028d3af-99a5-4004-e36a-08db3461e74f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 16:38:50.2127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMUMsqlv3Pr94hd4ko35W4LFLJ+Y1PH4Vy9hnuYJ/RoavtpKu8EsKqvRYyQu+34P7nSMRUaUOYdED7QuUvJSaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/3/2023 11:03, Hans de Goede wrote:
> Since commit 5aa9d943e9b6 ("ACPI: video: Don't enable fallback path for
> creating ACPI backlight by default"), the delayed registerering of

registering

> acpi_video# backlight devices has been disabled by default.
> 
> The few bugreports where this option was used as a workaround were all
> cases where the GPU driver did not call acpi_video_register_backlight()
> and the workaround was to pass video.register_backlight_delay=1.
> 
> With the recent "ACPI: video: Make acpi_backlight=video work independent
> from GPU driver" changes acpi_backlight=video can be used to achieve
> the same result. So there is no need for the register_backlight_delay
> option + code anymore.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/acpi/acpi_video.c                     | 38 -------------------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 --
>   include/acpi/video.h                          |  2 -
>   3 files changed, 44 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index c7a6d0b69dab..62f4364e4460 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -70,12 +70,6 @@ module_param(device_id_scheme, bool, 0444);
>   static int only_lcd = -1;
>   module_param(only_lcd, int, 0444);
>   
> -static int register_backlight_delay;
> -module_param(register_backlight_delay, int, 0444);
> -MODULE_PARM_DESC(register_backlight_delay,
> -	"Delay in seconds before doing fallback (non GPU driver triggered) "
> -	"backlight registration, set to 0 to disable.");
> -
>   static bool may_report_brightness_keys;
>   static int register_count;
>   static DEFINE_MUTEX(register_count_mutex);
> @@ -84,9 +78,6 @@ static LIST_HEAD(video_bus_head);
>   static int acpi_video_bus_add(struct acpi_device *device);
>   static void acpi_video_bus_remove(struct acpi_device *device);
>   static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
> -static void acpi_video_bus_register_backlight_work(struct work_struct *ignored);
> -static DECLARE_DELAYED_WORK(video_bus_register_backlight_work,
> -			    acpi_video_bus_register_backlight_work);
>   
>   /*
>    * Indices in the _BCL method response: the first two items are special,
> @@ -2096,11 +2087,6 @@ static void acpi_video_bus_remove(struct acpi_device *device)
>   	kfree(video);
>   }
>   
> -static void acpi_video_bus_register_backlight_work(struct work_struct *ignored)
> -{
> -	acpi_video_register_backlight();
> -}
> -
>   static int __init is_i740(struct pci_dev *dev)
>   {
>   	if (dev->device == 0x00D1)
> @@ -2183,17 +2169,6 @@ static bool should_check_lcd_flag(void)
>   	return false;
>   }
>   
> -/*
> - * At least one graphics driver has reported that no LCD is connected
> - * via the native interface. cancel the registration for fallback acpi_video0.
> - * If another driver still deems this necessary, it can explicitly register it.
> - */
> -void acpi_video_report_nolcd(void)
> -{
> -	cancel_delayed_work(&video_bus_register_backlight_work);
> -}
> -EXPORT_SYMBOL(acpi_video_report_nolcd);
> -
>   int acpi_video_register(void)
>   {
>   	int ret = 0;
> @@ -2222,18 +2197,6 @@ int acpi_video_register(void)
>   	 */
>   	register_count = 1;
>   
> -	/*
> -	 * acpi_video_bus_add() skips registering the userspace visible
> -	 * backlight_device. The intend is for this to be registered by the
> -	 * drm/kms driver calling acpi_video_register_backlight() *after* it is
> -	 * done setting up its own native backlight device. The delayed work
> -	 * ensures that acpi_video_register_backlight() always gets called
> -	 * eventually, in case there is no drm/kms driver or it is disabled.
> -	 */
> -	if (register_backlight_delay)
> -		schedule_delayed_work(&video_bus_register_backlight_work,
> -				      register_backlight_delay * HZ);
> -
>   leave:
>   	mutex_unlock(&register_count_mutex);
>   	return ret;
> @@ -2244,7 +2207,6 @@ void acpi_video_unregister(void)
>   {
>   	mutex_lock(&register_count_mutex);
>   	if (register_count) {
> -		cancel_delayed_work_sync(&video_bus_register_backlight_work);
>   		acpi_bus_unregister_driver(&acpi_video_bus);
>   		register_count = 0;
>   		may_report_brightness_keys = false;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7c96faa73426..d832f9ac43d4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4436,10 +4436,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		amdgpu_set_panel_orientation(&aconnector->base);
>   	}
>   
> -	/* If we didn't find a panel, notify the acpi video detection */
> -	if (dm->adev->flags & AMD_IS_APU && dm->num_of_edps == 0)
> -		acpi_video_report_nolcd();
> -
>   	/* Software is initialized. Now we can register interrupt handlers. */
>   	switch (adev->asic_type) {
>   #if defined(CONFIG_DRM_AMD_DC_SI)
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index ff5a8da5d883..4230392b5b0b 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -53,7 +53,6 @@ enum acpi_backlight_type {
>   };
>   
>   #if IS_ENABLED(CONFIG_ACPI_VIDEO)
> -extern void acpi_video_report_nolcd(void);
>   extern int acpi_video_register(void);
>   extern void acpi_video_unregister(void);
>   extern void acpi_video_register_backlight(void);
> @@ -81,7 +80,6 @@ static inline bool acpi_video_backlight_use_native(void)
>   	return __acpi_video_get_backlight_type(true, NULL) == acpi_backlight_native;
>   }
>   #else
> -static inline void acpi_video_report_nolcd(void) { return; };
>   static inline int acpi_video_register(void) { return -ENODEV; }
>   static inline void acpi_video_unregister(void) { return; }
>   static inline void acpi_video_register_backlight(void) { return; }

