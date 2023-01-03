Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FCE65C7EB
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jan 2023 21:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjACUPC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Jan 2023 15:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjACUO7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jan 2023 15:14:59 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315DDE80
        for <linux-acpi@vger.kernel.org>; Tue,  3 Jan 2023 12:14:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQIlhwNizA7QzGocJSNgzp1K0uw5Bgihpsv3L1FtFFT6lyqCDWm58+aUi8Iywj+iB/Fp5uWh6J/ohY3NOVAvkALbdQOl9cSSsbPaUq+y/roJGWIDgYswcskNkoZVYSZm0aq+ddl18C5/FwJhE9Kx2mXIGdd3DXFgM6guCbS/sbk6GknpWJAlypdyaDMq0oRoJ2yen2JaCLuvL8jCGC/MmS/mvAVuNF3qysYFeIdsHNZEcCqa4VDxAKIcAXywBhEW+tKrk2Ceulu/or9Gv/dC0GQjRXYs89W0uavYTTSM2gv3Z5xxT2XGejZIkW5btc1M64of4KRwB4447o/wSlkTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPigudCWMY9rIL96RoxPF1BLO942J0wpKWgfXepyguk=;
 b=GgWOfF9RvXErnuYDtT4RzveTIl9KOmO7gOV4b008AUOvnGNgyvZI7wzJEEF1zDgAIBzqH7TArgQQcTXx9BCiu/Tk+vWMzU5v7ay9R71Y6Q1xH7Vf0bKqgG3VqGp80FfA94gGkb7IeGJjWa3v9OT367JLPRG3m5t8JYcXNDtk1wmQG1mYJDcXZKUJBAkJ6/QcwuMFzYC8HNTMi9ntbqgN8ByJWXRNmsq5eUHcnfWf9axnsgD28+iv7GAP16vH/clsCsTgJDoDB+DVehzjFoXDy3JFREB716Cgagb49cu2dCbIiZf0p7jjuGxKZhuciW+eVeaGldtTV3TzmH//lw0RCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPigudCWMY9rIL96RoxPF1BLO942J0wpKWgfXepyguk=;
 b=PUsQhST8GALwQPud9ZQrTutfcrZpFBVyQOaID63JTBf4nG+gHN9Cr7r7dzSe1VmiAaR0ypNTv3HOym+AFEzlsHXLyJXgDBqGxvuEpXDXgXersI+MJUjHn5a4cJh9U2E+/nB0nMiZXe++zIbV7hx8Z/aGTxwqIgyA0dep2C8AuQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 20:14:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::152b:e615:3d60:2bf0]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::152b:e615:3d60:2bf0%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 20:14:56 +0000
Message-ID: <892da99d-7bb6-a202-adbe-0d6e5a3c0a0d@amd.com>
Date:   Tue, 3 Jan 2023 15:14:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/3] drm/amd/display: Report to ACPI video if no panels
 were found
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Daniel Dadap <ddadap@nvidia.com>
References: <20221208164207.13518-1-mario.limonciello@amd.com>
 <20221208164207.13518-3-mario.limonciello@amd.com>
From:   Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221208164207.13518-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0070.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BN9PR12MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: d674ca02-40d6-453f-8c4e-08daedc72ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NCsReOLqJjuSltwgeNBPJl9sbQACvtu5A/FsDF0Sk5FRsO4J7eayodnupHNtFGsWpKbwjqWctKQU7cUPyUuSnB50Tzd+T9FR6CfrEz2UK/zWwJEnwKFhEQlSFdmo4MDNke/LKoFmkbM38WvKUffMvIfmZSVw/MiijFxUffI1SG7bSlPJDRiZSspXW7mB6Spa4E8fW1eJHs9hmU7ijKPnOlqLkh5fxmDpRMF1VJcUhUkBSEkNMz3NpcjXSCeNPXlqHbhkBXasIfxy6PaicHM956znVgdbQaYtjvKpszBYgCa5B6LhX8kpi/k2BCvk2gq1CBPZp94mwX7QTAF0Q5leJr6SWM9WePIURgSvAdCI1Uk9/HbkxrvrYcP5WnG28rwo2kajTanrbmy7D/QZ0WLWHAJDrGq0MfoCQRjW0jUgzeBv4KI1MtVf22qhshvOOw1OOnrAn0IVodMsNv4/7AvgoIzsDf4wXauU9l12dFD5QrYLkcui6Dg8BcKO4Cr0tAnLNDJqYbUGL0nZWcieNO1FTg3gZvhMsGL+1A8kBnjZ8qr+Sg52Qq6BwDXiCk/lcuiym84qxTTBf2PgF//h7T/r3GhSlndBBnqpBcr4cmTPJU8NRyCNoB93fd8GVeCew/0eKw5UIKjzMMBaWdy4ZH0DsR4nYJJdcC2X1s0pWwFsH+l7+SGD4+nm8QR8gmg53GoKI/D8w/USSxClV22DuBplvBU7Pr1hSZFXEu2Ae6v+iu6eNxdhqjAN5HM+nNycuSuZ5BEyKDB4T79mDvc+rHGUFDjeCHWngRHBFF29zRFui4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(5660300002)(2906002)(8936002)(44832011)(8676002)(4326008)(41300700001)(66476007)(66946007)(110136005)(316002)(6486002)(966005)(478600001)(31686004)(66556008)(53546011)(6512007)(186003)(26005)(6666004)(6506007)(83380400001)(2616005)(38100700002)(31696002)(86362001)(36756003)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhuMGx3VDBrWFZyc3dSUTdvd3phYmxPNE1hV2xWZkUvUTZpYUpBTzQwK3Vt?=
 =?utf-8?B?R28rbWpCMGhGemhTaFpDRjZyNElwQmdmS2FPbnZyMGplOG5oMS92Wm04L1E0?=
 =?utf-8?B?OVJEbytsWkFYNXZvV1k4Qm56di83MitzNVpSSFMvSmErMEk3Q01rM1lBUmNM?=
 =?utf-8?B?UzM3UkVvZSszQlRaVCtWTG5OWnh5bEpRb2F4bFB2cmMyK1NJdTNJdTFxek9k?=
 =?utf-8?B?dlQ3V1lGTzhRekJKYVdrMDFWejBEWmY1NU9mNk9WR1I2ZlVZUHMxOWNMTTRs?=
 =?utf-8?B?QllEQXBsbCt1NUJnNmxpNFY5cUkxWWhJQkczVmJkVkJPczhyYU93ZzJrZFhB?=
 =?utf-8?B?UUFURVZRdTJuY09SZUkvQnlPbG55OVNMVW5Jb1Y4MmhGWU5QOU9LSlc1blAy?=
 =?utf-8?B?Y1VCSkFUWDQvQmJnekZBWlRuYXArUE5RcVFLbWpkL3g0d3VRL3IyMmFOcnoz?=
 =?utf-8?B?WHA4S1Z5M2EyTW90VDVQSU1Zd1VmYmF1bUJVUkhWNjFBL1VuOS9HUU5SMDFP?=
 =?utf-8?B?ZERaQ21VMit2RnlrMEhrNEw0a3JTdnR4RWhwWXFIV2lua1FKakN2VkdleG9r?=
 =?utf-8?B?MEt2UzEzbkRzMVRQVit4a2JBU0RlWGJnTi9HK2RIeEw5Z2pmOEZCeXIrNjJN?=
 =?utf-8?B?bUlyUDFPS0ZmNlNoSkpMaWtxSEg1V21NRzRxTzFMZkJoTUFEbE9iR2xMRSth?=
 =?utf-8?B?b1NERVdJRDhVRkdCNEhUYVhLcWRNK3o4bktCdUJXMGsrc2dwbXVsLzM1RFkz?=
 =?utf-8?B?L28zV0trY2grakNBNWhoc3RYMml6akQwSzhnS3lkQklsb2NPZWIvNHY5M3pk?=
 =?utf-8?B?aFJoWjV5WE5xT1c3N1R3ZmtDL2N2Ujk4eHRldVNmUlhlYXorNlBIbkZiM1NC?=
 =?utf-8?B?TE05UkxSQTZTTHI5Vm5BbVNBd0R3VlFNa3hWNTBuNDhsZzgvcEE4WThEMjlT?=
 =?utf-8?B?a1BlOXRqY3FBaVJXcDc5WEd6eXk2K2x0MzJQYzdpaEw0dEJ1Zi8yTTdvZEti?=
 =?utf-8?B?UnJXYTVMbUgxQ29tTXBYVENVWGRNTFQwOEo1NUh3M2tkd2gzdTFrd0Rway9X?=
 =?utf-8?B?dlJnS1RkcHJlVkJ2K0pMMElWdStSY004RHdvRGpyakZSMmFzdEJsSU1qOEdy?=
 =?utf-8?B?ZGZqd3JEUWliYzZpRHNyaTJOWGtjb1NvdTUyYVR4djc4Skx0WVFKNTdZblF4?=
 =?utf-8?B?dWtvTTJpTVRuUmlPejZDUU1EaWNFUHc2RHBLWjhvRVhYbm1HeS9oUkpud0JG?=
 =?utf-8?B?Z0ltWTU3T0pNU3cvNGRNTFJCU2F1bFdPRzR6OVpOcmNET21NUHdNTjVlbmt6?=
 =?utf-8?B?NTZ5Tjd4QkJuQ2ZJWTQ0NjRXOW1Qc2Z2citGMVJrRDVCUFE3Y3dpbjVuaVpk?=
 =?utf-8?B?Zm5MdVdHejNtOFozWnBCRWo1czIvTlFBK2h3WUJsZWdyZHBsRSt5K0l2Y1ZF?=
 =?utf-8?B?UDZXbUpXNkpqbStyTC9TYVM2TFhpek5TWDREbzl3Y1NFdStoVWlId1pkL3RP?=
 =?utf-8?B?QkhXb1RsSjNINTh2ZFBUT2xvNXRaamZ6bndnU1QzYmVka3RkSGQ2VnVwOW5l?=
 =?utf-8?B?SnlvdGt1akUxQTRNYnNRNS8xMHo1S3lzS0IzUVMzeHR2bStxSzZlMmJPcmZP?=
 =?utf-8?B?U0VxMnJSOUYrMERJZ2UxM1VDWVQ1VXcwaC9DZDUvYWNQVTM0MTF2NDRrVHk5?=
 =?utf-8?B?dXJhbkVpMVlDNFJUSzljclRtNnVoTjE4NHJMa1lFWS8xeFY0N0JxTGJjYmgx?=
 =?utf-8?B?aFJjckhtSS9Fd3hTUG50dU5ET0RkNFZCeGJGcTNxZzh5MWczQy9FbGVmc2VR?=
 =?utf-8?B?U3JuT0MyLy85Wi9WZ2Q2ZmpDMUZKZ1pqSFl4NklMcjhnazc1dlRxd1NISklG?=
 =?utf-8?B?QVVDaDNpNi9HZ1A0TnNGbmhSRk0wMCtER3RCd0tVbWxNV2p5TFlHNXJLbnAw?=
 =?utf-8?B?SWVyMnJaWjJ2VUZ5YlBoSFUxWmNwc2RPMng0OUttWlFlOGVNTVhDMnFYbFZw?=
 =?utf-8?B?dERNNTIwTC9XMEkyY0drQTJEc0lEUTF6ajF6eTR5NWZ1N3dZUGhkazNxZVRB?=
 =?utf-8?B?ZXIyQmJhZnFhRWtiOHE2em9wc0ZUQ3J5UTBzRmJvQUdHdlh5TENUbHk2OFEy?=
 =?utf-8?Q?G3xYMpPJaYdX7KspWqlj0QsZE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d674ca02-40d6-453f-8c4e-08daedc72ec2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 20:14:56.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhxBj98T4BcvTkYlgTnhgORMjm0WaBxWtOzkNMnu82QIlHtoUQeoBApodvQ+qPDQokVP4zGVpj/kTrOLjwdo5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/8/22 11:42, Mario Limonciello wrote:
> On desktop APUs amdgpu doesn't create a native backlight device
> as no eDP panels are found.  However if the BIOS has reported
> backlight control methods in the ACPI tables then an acpi_video0
> backlight device will be made 8 seconds after boot.
> 
> This has manifested in a power slider on a number of desktop APUs
> ranging from Ryzen 5000 through Ryzen 7000 on various motherboard
> manufacturers. To avoid this, report to the acpi video detection
> that the system does not have any panel connected in the native
> driver.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1783786
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
> v2->v3:
>  * Add Hans' R-b
> v1->v2:
>  * No changes
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 512c32327eb1..b73f61ac5dd5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4371,6 +4371,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  		amdgpu_set_panel_orientation(&aconnector->base);
>  	}
>  
> +	/* If we didn't find a panel, notify the acpi video detection */
> +	if (dm->adev->flags & AMD_IS_APU && dm->num_of_edps == 0)
> +		acpi_video_report_nolcd();
> +
>  	/* Software is initialized. Now we can register interrupt handlers. */
>  	switch (adev->asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC_SI)

