Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346DF771643
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Aug 2023 19:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHFROG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Aug 2023 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFROF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Aug 2023 13:14:05 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FADAC2;
        Sun,  6 Aug 2023 10:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoaN9I8zQJPxWtBbhQiiuNPipb91Zwmyz+tg83FEQFduKTqcm0ms42phFuj+cqa6TSzG9Jya50SJFl5aNsxq+HpMAbEUCh3aULJ0siFx43wH3I3oajY21kw9CnQEzJdGZGABsX/SxbA7GAqPykRLZqlsaSSnyxe35iQcC+XHlUqu2Fs0CqERGRx3iGiOYrIIKsMWpRLZtQ34LcRB7o/CxmfXXhMBsTdb1c/tVbCi09lrIzOvdrpc8BoGIdIZR6/oUgr8+8xExGWJYApPCDloCD2MdTIy6rXGqYt1RhhKtPQTq3AqA7pZKiE5m9D4k4InkeR9K3cmZAvzDTj7QJBATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a59zSG+lLoDz0IyW9JhKZT91aks40tkpx1k0Vy5uEak=;
 b=PcZQuop2ayHPHMkFfIUI2mns6f5PWaIlfdeybYekBvmWJjWvxsqH6Kql1wAnnEClXNPkrK1CaWcXA1e7SMPXCGtLM2kkc1d5KSyiGJpAzJAl9/iyA4h6JotOD0MkPAsc7oEwexhLDjJOzZu8qBWOGidGjFYNgmGujEDo+I9cfGrkfEdHxAs55GhOngHGtTdzV4rpxh8VUu3x3ryLhcSjUovPqqGcpi+gdmIdanRm+iNHsLoekwKOBmnokRM7pl0d3pfbmK+FpVOKa5Nkr7p6ZGlQ4fDgp5DI3jHNGfAkiBHt+KBQnyTXd+181o+ZXIcpBSwHXkkjzYs7kZ1eXihziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a59zSG+lLoDz0IyW9JhKZT91aks40tkpx1k0Vy5uEak=;
 b=msEGECUHfH7OU3wwqVdENvcdB8Kqy+ffCo3KwrA5uwBFFAoh1rZTVrggEXKhWZK0XmKGGnLPkykVlsIRQT1REf/0CJBL1/F5xkctWNdg83sPJsyU2EjacPjIzZC/omejTNfA468nYsDuqv7eAYxJKj7hRhbnKQOlDj+9wmWf9JY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 17:13:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 17:13:56 +0000
Message-ID: <130cb2e0-90b4-7d7b-1633-3469c859b30f@amd.com>
Date:   Sun, 6 Aug 2023 12:13:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and
 quirks"
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
References: <20230806151453.10690-1-hdegoede@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230806151453.10690-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:5:333::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 452a6a69-51a1-46d4-456d-08db96a08455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B11pSM86sKuO2iXWyge3bQarttJZdSnmdwy7MtWEga++dlyOJll9Slp3Oo0n6i8lQ/Ul24kjIWTCts/xMcRYKCQDYLtz1f7yYLa5Bjfr6CGrMPcE8rOCZaq4YFE/GBVRLzOXjo4b5ExJ0ns3HD9FpRI5XVAHa26IIqkUYTfzpTiTghBcnz3ZyqUEfSB6M95Yc+tYzLywJUV12LhnbQI7fw2mpib77VdnwagXlpkqxA5dRLKwDstCGDXFfpr5Of/I0abAlp1vNam4McUmnG278JUVpFB0SwXeIJga7utpEjTbuzTjkVleMPmPphdYWNFp0BtD9rSnl2K/9PekE8Q97IoauhsA7uoBA0fK4P11r3sWI597oj1nmIrCXojrdru1fO70zKwxEJPYpCI6Sp4Ymmv+7BeAuulLRBNDLL1FNXSYXV0hhCbr9hZ3nhLftOTGy7Uo/dJ0waZULA1FqYpgxMXWZisMz2F1jqE4N8Oe5R7QUm7k/1m57/ZmUxLCfUY4+a5RDndpl7ukEYFiuNZZpZPKyJEEElo9LlnCYcqDF06zzdrq5qcGDwBdU2JEvggdoA9lehjxRRkrjAdmcx8baQs28mnGXy48P08pF0wnMqK3qDjoaKNGSpLJ/CLaDbmda4cADBlXHG/bZkP6KNIahauALxxC/2qzXBCkx26hESB+dH7ZX75jQH8xN5d9mag0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(186006)(1800799003)(8676002)(8936002)(478600001)(110136005)(31686004)(5660300002)(41300700001)(44832011)(4326008)(316002)(38100700002)(66476007)(66556008)(66946007)(6506007)(53546011)(2906002)(31696002)(86362001)(966005)(6486002)(6512007)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUkvNnEzdFNlZkp1MVFqTUU2UHkzODBwdGxQdElNdEc5V1BZdlFHVFNzL1dU?=
 =?utf-8?B?cjV1Ri9kYWVCY3NmY3o3dGRoaUFjc1RMNFNIclhTOEtJU2RtdDZwNGg5NkRj?=
 =?utf-8?B?bHFkVFdhankxSWxlQXg2enRuK1M1amppUlM1cEEvUjNvL2ZmSlUxN2c1QXFl?=
 =?utf-8?B?ZzRYQkRXalp1YklGcHlZSjAzTjFxUE1ZcUVXakR2S0IzOGRIOXludklRbmNx?=
 =?utf-8?B?N29iaUJHSGM3R2dMT0VzUDJQdU4vaDN5N0hsOWs2MGs2b3ZzajBBUHFVRjZN?=
 =?utf-8?B?citxZ2ZNWUErZktMVU91UXNLT2NGWjJGQmNqdGVnZGR1SzJkbTJFMGV4TlIw?=
 =?utf-8?B?eUd5eGswdi92SDl0clAySTA1QVlPTVRsSTEvb3N2SUcxdkxqVmZYRVpiQUY5?=
 =?utf-8?B?U3RQSTB3ZC94VUNZOU0vWGxBdDNEUjk2cnoxUzVpY0NQVXBkN0hPNjFPamZM?=
 =?utf-8?B?dXF4UFloWkpxOVhRaEdDNVBOQ0hmaHdERS9hMWRFWmhVQkEzTXZBanpEYkRS?=
 =?utf-8?B?T1hGTWpoYklFWWowbWw2U0xyVzZQUWpiR2ZyblNTaG9XcHNISlFadG91Z1hF?=
 =?utf-8?B?V0dwUWhsb3lHWmNidmpzRXJDbDdmT0dOS0VsZHE5NHM3bW8zZ1BYbk95eU93?=
 =?utf-8?B?aHZhdDhkODhQeGVqSmVEVTFVQXNmM0RoWTlzUG1VTmhNdUY2ci9UMGx6bG5H?=
 =?utf-8?B?RGk4b3pYSS9xczBuc3k2K1JlcXlqVWpjTkFqY2ttMWJxdWRaWWRHOGdHUVNO?=
 =?utf-8?B?SWlFblg5SDRabStPQjU5bnczdHBVdy92VEdEQVBZZ2tGZlBXOXFWV1RKUHpJ?=
 =?utf-8?B?Kzk5RFFveEVBRFd1c3MwT3BZUzEyMzJlZ2NZYW9lWlFtOXdKUnRJdTh0YWJS?=
 =?utf-8?B?cVhVU1kzZDN4VGV1RFhRVFRXRi9GUVhtY3VHT3dJUnlObXptRW5UM2lFSmFU?=
 =?utf-8?B?dlIvVExmN1JZZ3NaZjhhS2dQQittMTg5RzBvSHMzTVM5R3I2UXRQK2l0b1p6?=
 =?utf-8?B?cGZRNitObzRpdVRIZmJ5a21OYk9nSzR1c1RhYXg5dFpuVHA5VDFjS0dSN09I?=
 =?utf-8?B?VXRwY21CTmdUNjhRODdpSEducHdEY1F3YTJsYkpaejlEMzY5UkZJUkJjekdp?=
 =?utf-8?B?azkweVhlVmFSOHJ5MDR4NUpsaXBsSFhUMFEvTWNHTDBOSW1qYWJrS1ZGczU1?=
 =?utf-8?B?UFAzQkpiU0Q3bEQrVHJLRHh5dExROTdqWDJ6R2poM2VZY3ZseGlZTWI3bXFj?=
 =?utf-8?B?VXo3TDZWYitwUlU4MisvbkdEV1dNS1JOMlpSRWF5azFLMFZCNUdwdFhKVkFV?=
 =?utf-8?B?Yjhrak41cjRNNjNZbDNSUkIxaHZqNTVrcXdJK3hXTTNNdEUyZ1V6MnNHalBM?=
 =?utf-8?B?clR1QUR4WmVOdVkwOUdibVVrNWkxdFJMOStKOXUvTG5HQm9YQ1U5RUFzNVp1?=
 =?utf-8?B?cjFRcUdkSVVmRE5JZU56UW5yak80cE94cGFOamJpRXowajFyYXg5cWpKdFJ0?=
 =?utf-8?B?M2VIVjlrWEJKbEc5N3cwYWN4Zi93WnZKcEVLejlEMjUvbG9JS281dUpkUnJk?=
 =?utf-8?B?RE10Tmw1Y0hNQlRQOE0xODZNeVBrcTMvM1lzN3lNMFF1S3hiU1FlZHkvOS94?=
 =?utf-8?B?UGhQaVYxNis3ZFdDSllyam83WnQxNjZIWDE1Ylg0akZReFFxUlQ5WUF5TXlm?=
 =?utf-8?B?WXdBVEw2RkUrT2t2SStqVitUanlYMDU0Y2tZSnlqTHBydGwrNFArMGJFSEda?=
 =?utf-8?B?Q0dOK2RnQk1HUjk5cURMeFYrSXNjSytQdGl1Z1U4VVZabVhIMDNhajZBaldk?=
 =?utf-8?B?RDBUZ0ZhVXFBazlKamhWUVBPM1ErdUxVMjlQZVFWT0VCTFVxdERML3hJODcw?=
 =?utf-8?B?UGpTUUc5K05XOVJGdWorbFFIU1ZzT29HRnJtU1YrVnNvZlhOdEpTUzF6bGJr?=
 =?utf-8?B?dHdXY3FuWE5rK3FSbUI2aG1UUHBQRUxoYTI5SlQwVURTRWdBb2ZZdFkzakg4?=
 =?utf-8?B?b0c2U080emJIYnVFa1hhVGw3VVV2enFSSlM5VFRkYTRRdmJtcmk1TVFWTk5x?=
 =?utf-8?B?djA4SVI3c1FPVEZJTkJwRmQ5THdJRzVPS3NhcEdhSngyRm93SWZEUDVYUE11?=
 =?utf-8?B?WnM5OE96dENHUFV4OEk3c243eFJjbVNxbmFFaWZlai8vTlVWTVdaRUtNS3h5?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452a6a69-51a1-46d4-456d-08db96a08455
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 17:13:56.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOPumof3or+Das2Rh27Vb1B+Q2HXk5YnachqOTECQe5kpT57TzMmg4ZlKR3nhQxglrvd+5OMD1TP7ym0w6zR6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/6/23 10:14, Hans de Goede wrote:
> Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
> quirks") is causing keyboard problems for quite a log of AMD based
> laptop users, leading to many bug reports.
> 
> Revert this change for now, until we can come up with
> a better fix for the PS/2 IRQ trigger-type/polarity problems
> on some x86 laptops.

Reverting it is going to help a bunch of machines but cause regressions 
for others.  How do you prioritize which to fix when it comes to a 
regression?

> 
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229165
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229317
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217726
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/acpi/resource.c | 60 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 1dd8d5aebf67..0800a9d77558 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -470,6 +470,52 @@ static const struct dmi_system_id asus_laptop[] = {
>   	{ }
>   };
>   
> +static const struct dmi_system_id lenovo_laptop[] = {
> +	{
> +		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
> +		},
> +	},
> +	{
> +		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static const struct dmi_system_id tongfang_gm_rg[] = {
> +	{
> +		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static const struct dmi_system_id maingear_laptop[] = {
> +	{
> +		.ident = "MAINGEAR Vector Pro 2 15",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
> +		}
> +	},
> +	{
> +		.ident = "MAINGEAR Vector Pro 2 17",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
> +		},
> +	},
> +	{ }
> +};
> +
>   static const struct dmi_system_id lg_laptop[] = {
>   	{
>   		.ident = "LG Electronics 17U70P",
> @@ -493,6 +539,10 @@ struct irq_override_cmp {
>   static const struct irq_override_cmp override_table[] = {
>   	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> +	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> +	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> +	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> +	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>   	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   };
>   
> @@ -512,6 +562,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>   			return entry->override;
>   	}
>   
> +#ifdef CONFIG_X86
> +	/*
> +	 * IRQ override isn't needed on modern AMD Zen systems and
> +	 * this override breaks active low IRQs on AMD Ryzen 6000 and
> +	 * newer systems. Skip it.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_ZEN))
> +		return false;
> +#endif
> +
>   	return true;
>   }
>   

