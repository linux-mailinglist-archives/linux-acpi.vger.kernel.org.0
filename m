Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12847722AE
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 13:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjHGLhK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 07:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjHGLg4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 07:36:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B8D4234
        for <linux-acpi@vger.kernel.org>; Mon,  7 Aug 2023 04:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv3S+pmHO2LoTgmX0DjgZ3bTGXaJg2GQU+lid7IGLr7XQBKKtFW2r4gSe+PsiPXU9cDDJvVnd+W260d8dNP1aRLvNFny025IndZNzIDi/kHuc+UWDN3nY92ZfVkNl/NsT+272PpaZP35MQE/3yzpF9/zTz/X8ZG2pY7BZZEUwmirtjn1G5ZsxBxwE6AoU3cVtquZn3YBoGivDj161gR78xoHHoBnHUcw61tpxwZc0kA9DlQwZqpc8m3XLKxX1Yfv7usXXhxKxxdbWys/rw89kK1ouayeEiLDct7dMYGQDLADlzWrW6FxCVg5URdyJ022qCDTuOVNdQqfVVjDSivMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1bZRGGKMa7R2tTWYkZrxL/pwyq/wjicWiU9dFQ/iP4=;
 b=mYDSV3gSlOE4q8DOhuAbWSIbSmjAr1aiBZCsmt/pKYw/ZhL1RLe1LLQD+HxHIJPaQAo9ZbqckJiFvKImQiYjx58VfojnpPgkpaE6wp/M2uji38aExL1jaMGfMKLwVoU79sYtjLYF8DPzExyAcxqf0cLjZNelMHGr8wdC23v8Fgz3Yjk9Ma7nYpm1S8dpttQ6ICi0LRE8ZDyqVdyiLEx+TB4eK4XCNkoG94WCDK2zjqPOy4dBPb2QZo3+Z6GNuJFXC0kqQVkqXs33I8E30LG8/OqXyvzHulGn/+OC7/r7k8SlnN+yX+3D6By3dvOGOAxBw9fBobaHqmDWMuUJsVgU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1bZRGGKMa7R2tTWYkZrxL/pwyq/wjicWiU9dFQ/iP4=;
 b=pjGWBLd+bNCHzWzTGxAyLch0GQ/niqM+j45Kq9GRjXCjYGCUQFH/memWEeSg+vEVn25VcQsfyMnlpra9Pr+mLV0B8HgIgvKI/kd2r/dfTQwQqfBS+7spEAkW7wAV7z14zC84F1Gyazve1uh9++H4SAFJ3Yu5Nqrh7Q+jcEcdquY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 11:32:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 11:32:32 +0000
Message-ID: <37253231-82bb-4f31-a9d8-1b74e7806282@amd.com>
Date:   Mon, 7 Aug 2023 06:32:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Apple
 iMac12,1 and iMac12,2
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org
References: <20230807094408.242069-1-hdegoede@redhat.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230807094408.242069-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 3905fcca-95d4-4d63-614a-08db9739fd4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PmRmNfXQLc5zDLWpToBKREk3Ts0F4EuHVvfUdeRcdU6xX62j4YfQ2nPzajFyPANVXt79eE5EL7AXHZBu3DT6/spR5iBPQ+De4yp2GxzRomR9xsVrM/hPZDWxD68K7jU8rEKSYPu3pYyDYPzlXzWWYBmxaPZJJjsfcRfKsM0D4jKnJcet5IicIcYkOviGz4AEq4+5HYeQa2o+o8x40KiEGNM2Nb7fyl1JqHCTd4c6MKvl5a6Ur5a8DFE3eTG6ztIwZ4I61Vqv1PoVSD48721zWrr6qLp86PIH4IRCbD+XLTt1HT6PZfq1jeBaFsIg8yd1f4UfZLV+f7M9dn4vvEELDBNA7ryUrUcU/BOI/+4niGOUk6+K47CzWoWfOCkfj9h91Uo7eO5H8hbYraiDf0p6qaeeizmj8HgOw0IqFcMvcCMPv+zX8ejWPkeHsA7sp9sG+F9ExRkdwSkH2HEQLl6Z1rw8Osc+Egi6ck+/ku0exkGd2iI8swo/fnLHN6usEshItLVCIF2S87NqskCAWQKUiNcIU7LQLfhkltUEjI/oY3OoHE6iwlVoAAUjOAqGN4qp0WdgOijYM22ss/rvMaMRPx+dXpT0h3xiOJAth94FWncAfXbc6g/AHvlwv0Px++PuRD2pFHVWrn1PTmMGX7y7RHLC1TglAkrxW9KAZFTap5+vQoBTUEVkwvglWF2zsLqpQTf/DqgEhHXCz0EWTkpqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(47660400002)(186006)(1800799003)(451199021)(66946007)(36756003)(66556008)(66476007)(4326008)(2906002)(31696002)(478600001)(44832011)(31686004)(8676002)(8936002)(5660300002)(41300700001)(316002)(110136005)(86362001)(6486002)(6666004)(38100700002)(966005)(6512007)(53546011)(6506007)(2616005)(83380400001)(46800400005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDE3U2dnNFdEUU4raTRvZ2dReHJlSnlkaE9YTzJXRlJOYjF3WmlmRDk5OE4y?=
 =?utf-8?B?VTF5eVowZDBrVW95UHJnQVlWdU5EcFV4SjJ3T3B2eGliWUNkU1dlTWYxekE4?=
 =?utf-8?B?ZjRDSGNvSlp1bURpYnh6WFBkU2FSdUxkbEVoUWxqOXBuWEFwVEloT0JTKzdF?=
 =?utf-8?B?NXhmWWFsMXU4eXMvazhRZ0VNZVhDZ1YxZVNpOFpQUGFuZEczcnNnUUJmRU50?=
 =?utf-8?B?NDhOdW80UTFPUlZETGFyRS9yNU02RzVBazJraDNIdHk4UmVEYmM2Tm9taXdz?=
 =?utf-8?B?ZjBWWEZVc0JjY2x2OGJMbjkwTisvaWpldlFnNFBmUTErcE16dUl1eHRaVmdS?=
 =?utf-8?B?YjRWNitjeVh2ZFVHY05uLzZiSUQrQWFpWUZmZnJsdktEUXVvRWhHUXN0Znd0?=
 =?utf-8?B?bTQ1VGxWaVFKcms3cTJxbWZrT2tLODdUajF3azRpQmk1MjZ4Vy8yaXR3YnRX?=
 =?utf-8?B?TW5mMjZIbnBsM2djUEJmeTZLNWRQZ1d1RFNQakppZjludkJUVEZGQStqTEdT?=
 =?utf-8?B?NnR0eWZkcnJJOWcrUTlGbm5WRTVkZ1o4WUtqN1RjNVlvRjFGSFhLTWJ6a2xM?=
 =?utf-8?B?a2NiV0p0SFhIeWJpWFJsQXJSR1RMbjY2YVNPUWlWcFc4WFlmVHY4TXluRTU4?=
 =?utf-8?B?TUdGUHZ0Mk5sT2tXalhsZG5RWVFCTXk2TnlScGFuUS82VEZuN3NnNS9STFpn?=
 =?utf-8?B?NVlVY1lkNUlhSjU5bEZJKzlBSTV6TU4ra2pGZDR4SzRsZWtSMmpkSENFc0pv?=
 =?utf-8?B?MHBRb2ZaekxVS2MybVFrT0hDTlhWMjNIMTUrTDZPbTlhNkRSQjdOV1d5RUxX?=
 =?utf-8?B?b1hBdkNaYVBBSzRLYWF2dTh1ZFFlZzNob2VnNkFjUXhiVUJacXdhNUJiR2xi?=
 =?utf-8?B?eFF0MnlqY1dIVmM2am1hM0hwSS80R3g0dWhMTGFaNGhlSE4rVVlIMDRjWktt?=
 =?utf-8?B?UmI1bit4RThWNE1GamJXdldJMWtLdzZlQkZUSnhJVE8xR1BwaWIxRjFFOWxl?=
 =?utf-8?B?MlZOZWdERWdXbGM1cmhvM0lWU3RTbVhldzFFVjJCbnVoUEFSTDJmVVhMalRt?=
 =?utf-8?B?aG5abTVpcGIzbUNtL2tOWEsrT0ZkOEJ3RU12UVhVZVBqaU1SaWpPT3lQNnNL?=
 =?utf-8?B?ZlBqVXNxcGg5Vnp6U29aRVdpMkpNWjNLSVVhTW5qMFFTYUUzY25nem9zdXJy?=
 =?utf-8?B?dG5TVFZhSHB5Y05scm55cTBvL2g2a0JPZlIyRmpIcHd3cHg4eHZIbU5pQUhO?=
 =?utf-8?B?N3lYY2JHUnBUQlN5MFBmSXgxUTVDM2RxdGV3UEFuMFp2dGFnYUFFUHlXY1Z3?=
 =?utf-8?B?QzNxcDRlbE1GQnB6QUozYkorM0cvSXdkOXA5bWc0QXo4RHBDV0ZKZWxYTnZK?=
 =?utf-8?B?UGhPcFBIU0RpQ29nZ2oweGFBQmlxR2c4czd3bm0rbUFHTkQ1Z0wzeFkwZUpW?=
 =?utf-8?B?dnhCdWozd2VYMk9SeGtwMzFyOGVXLzh3U09YVnJuMitwU0ZtYW9pVkF2OFpp?=
 =?utf-8?B?VVM2VVZRNEQyK2xPa29CclVVbkRQd1YrMFJMTTJjRmRJYVFOS0x3bnE4clJL?=
 =?utf-8?B?bHZXRGlzdlNSUTlPaVBOMU1vR2w0SlJnL09uaklONUwyN1NFQkxVY1F1ZG5V?=
 =?utf-8?B?eTBLVTBMNTQzSzRJczFwZjNtQlpLQndhb0ZwZEk0b2dQcUNRaHY3NUVDclVo?=
 =?utf-8?B?Q1VvcHl0Y0dvNGZ6bzNlZFBOb25pdURRMGVLd0ROcUJqeFBCZjVWcmZzSTZz?=
 =?utf-8?B?c0w2OS9mNVkyVDJVbFFRQXZ6SnlYTVRFUEtuanh2MVFYbEg0ZFdYQU1xbHZR?=
 =?utf-8?B?VDE5TFNYQ0FIM0ZFNE5KTU1wWE5WZGNXc1cwVTA4SzEwNWNmeThadTc5S0Vn?=
 =?utf-8?B?YzN4VS9oN25QamVXVDdLZkFERUdYN0RiZ202M0FwbnpsRWxMcFQ4K3ArV2dn?=
 =?utf-8?B?REs5MGxxTFlTOE1tVzdDZEhFNGd5My9nTUU5ejRnNEcvSHk4RmV0NDJyV1Vp?=
 =?utf-8?B?WGFucm11Qkp5dTF4U09HTXNJdit5VUVoeFFvMzQ2TC8wMG51SWJXZmxBNHkr?=
 =?utf-8?B?NFptZVNBOVRoRGpQMVhNcUpteG13YitSTW44czFFeXJZMVhoQjV2di94TmRl?=
 =?utf-8?B?WFgzQWg3V1B3UVFsTDlIVjRNenRJMFVEdEVMQ0RjTEJBcjlNb0NvNVQyQXkv?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3905fcca-95d4-4d63-614a-08db9739fd4c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:32:32.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hnsYmcy9Epc0ADFBuRiwdNQnsuJBBa/F6yznNmeHcPALLaN5mcb1PaoCHJ5xDo0WUR+I6v/E8QkGBfiTQuCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/7/23 04:44, Hans de Goede wrote:
> Linux defaults to picking the non-working ACPI video backlight interface
> on the Apple iMac12,1 and iMac12,2.
> 
> Add a DMI quirk to pick the working native radeon_bl0 interface instead.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1838
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2753
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/acpi/video_detect.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

I'm wondering if you also in the same series should be reverting these 
two commits?

05eacc198c68 ("drm/radeon: Fix eDP for single-display iMac11,2")
564d8a2cf3ab ("drm/radeon: Fix eDP for single-display iMac10,1 (v2)")

> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 18cc08c858cf..7cceaf31d928 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -486,6 +486,24 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>   		DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
>   		},
>   	},
> +	{
> +	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/1838 */
> +	 .callback = video_detect_force_native,
> +	 /* Apple iMac12,1 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,1"),
> +		},
> +	},
> +	{
> +	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/2753 */
> +	 .callback = video_detect_force_native,
> +	 /* Apple iMac12,2 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
> +		},
> +	},
>   	{
>   	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
>   	 .callback = video_detect_force_native,
