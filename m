Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8960743E471
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Oct 2021 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhJ1PA5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 11:00:57 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:17985
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231388AbhJ1PAy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Oct 2021 11:00:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdm773L1+3VgrenQWopwBcvVGiKk3mcDN1ep0pHj87EoOOuT+fyLg5SVPOeeSjGQ9sPWXo4YnRu9TTeOXm4lsjFUeJD+nmlve5LVFeF/JBVbxkWMYmv6LVNARMSn8Ab74yNnOlmWkVZpPvn2SkKH1I2Q9v+yZMd1VAprot26aKkvNIHUcTFVlBe9LwGRbGVxsOnkiqD8AsjThxivC5MtX1n5UBkQNLVcMbc8pXi3i0t7fBM5t6qqFAbF8BgUoX+dMU3HIzVk2Hvla4vPl0zm8F7cHZfFfXfuy+A1NYe64+hyN/5YoUWOb9Z0PkU4Tsyv0GZaz+JOxfWRJ/CnLAkpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rie5S/Oar01wzGmG3XlPvTc7s2reCeyQZKHjFHHPYgA=;
 b=IifbFmIbi34nfzEJzTOP+CltzlEfqMjSo8wGW1E/ARI7gy/NWRdJztUOG4Zitn4P5+Hh95TLAz7eOz1l3Nk1r0XSvgA4/mao91RI06wGIZEOrGDKWnxczBtUBXN3mL3c47ToKl5Mvl4wHnDKsOdj1cvDIUsvLxZ5fpx55gDIUAuclju2Syp2zgINzUk6iXNXd0746ImFUXPHgP2EiEiOC1pzaw+RaO9pDL5zfl1gjFiFu2dNDPPxlbZdqo0W9VnL3auaShYtp3MQ2DnqBCV+NWJ+B7SLETdivcZ3uw61+0uCraoNAYvMPYXvCnCdjg5NNhKE9rNsUVpLkvBftOO5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rie5S/Oar01wzGmG3XlPvTc7s2reCeyQZKHjFHHPYgA=;
 b=muFdwBA10OalhK6eWJCbv2M28WA4tRNMHjnoc8UFuOIWu5oH+M8ADSw4HKhz7SOVdqQFnJVBBWgHx/g5ug5s5Y1zewsHSZdLmqE79qlcVbSSlDAsNztT3tLZ5dZ2bZlBJbI4lmhXornOlCRgtl80b0nyZTbDVWOa/YUe1T+9BRg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 14:58:26 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%9]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 14:58:26 +0000
Subject: Re: [PATCH v5 2/2] pinctrl: amd: Fix wakeups when IRQ is shared with
 SCI
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        stable@kernel.org, Joerie de Gram <j.de.gram@gmail.com>
References: <20211028144541.12617-1-mario.limonciello@amd.com>
 <20211028144541.12617-2-mario.limonciello@amd.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
Message-ID: <ca260931-8cb1-b588-2ac3-f1151c3df438@amd.com>
Date:   Thu, 28 Oct 2021 20:28:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211028144541.12617-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::33) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
Received: from [10.252.90.200] (165.204.159.242) by BM1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 14:58:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0e28eb9-bc23-4c7b-3494-08d99a2364fb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5344:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5344A9532C468E1738245571E6869@DM4PR12MB5344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5ANwOGbYD3gdGC5iPdm8SQeMnVyxVJWDR6Cz79ewW16I4OUTJJVnttao07DwFj0R7HcFrHQuOQzoSRkTMEalWCq9+IIjgyNVN+jLJ64x93AVYQ9cb+OnQglTinbNifWzr70z/4h/gsjuzYCSqwRU1osO0NTFgi86Io9VhXodJQMAavKaUL4BnPY31eOgKEKvVNbUP24tSTbv+jYU0PcFRfghU1ockKjQyD6x4aVmRfxGRrkNDvye085XdgFl4iTxTAPv1Vdc7QwAR2TsE80EYJFia/e0JoSjjlgNsM6w86/l3Rao+e0AIY1IVYvtcPNJ+90Lv1QoTL6z/R6sDkE/Q+23j1CZSPDe0qsJx2xHyuNJ7tzWVuklEgK7cdzlfPREy0/KAIS4KR030CWLZ1tMHHy2xkOXbrTDtYvtSC8HI0yBV8DBm1nFH65Wdmap7z+SzM2aB8sOpb5RHflZFlSU1pNsmVpCEB88t0WegE3f7B2ZCF5v+/FZ8wcwMewAyiovaoP+AeZm5JilWF2jcaYpVI7m5kBF6kWvMfLuX95pRhPGO6fQZiLyE8wgycspIhRJl3H7RHF6Z6oSMG9Tx06MXKsU85ovSvEpxDHjz0fKyqfYi/0w4ZZkvdH9OlKDv+EgD1Ft3NxvgPop2UJLjJwbVB9Boofekbwcb6iWuDOVQf7KSS5gLlUHLNN+dJ3xQM6lus/Bf7CQkpmdSaHvgBbf6AizIWmOStD3OC+auAJa6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(36756003)(66556008)(186003)(26005)(2616005)(956004)(53546011)(6486002)(31686004)(5660300002)(31696002)(508600001)(66476007)(4326008)(6666004)(6636002)(8936002)(66946007)(110136005)(316002)(54906003)(38100700002)(16576012)(966005)(2906002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2V5K0F5Y215cVhlOHZnSGVDLzUxdjVJTnpqT1R1S3RPc0VySFpxbWdhL29O?=
 =?utf-8?B?VnJHWTBRam9IaGhHTWFDNk9OYjczbXBvVndwQ25OdHkyUGFyUmtoVmtnRFZz?=
 =?utf-8?B?WStqZkpiNW0ybHllRHJZQmEvUFNMdExBMWxWN3BPUnhhV0tmSzF1NUo0MVBt?=
 =?utf-8?B?WXp4WVNhc3dwK1lURk9objVOK2ZMNU42eU9tM3h0TVZBSFR0dWpZajl0SFJo?=
 =?utf-8?B?WW1qYnd3SkxTVEZmK2lyYVpOOU03NFA1Z3pkU2dUc3dvUisvUnNwWnc1VUVa?=
 =?utf-8?B?TnByaWdDby9OMlNseXIwK2dxMEtRbmd3dGhrOEp0U0Q5UkpuTlR3Y0FkSU1V?=
 =?utf-8?B?SHAzaURURDdEUE5wR2xxaVZ4c2hCZjFOVkxNZGVsYXhFL0xKcnNmZUtUayt5?=
 =?utf-8?B?VVVvMjE3VDJvdThyN2lRTmg2M2JrbkpzU3JtTW5UaWRhYzh4alNESndZbldz?=
 =?utf-8?B?K3l6WjNSdmxFbnZvOU9kditmUTNKWnFtU1o1T09tc1FraTN4NmZRbTVLZFRX?=
 =?utf-8?B?YjhsODBSNUx4YjFJSEtRdzFQaWVKalVvaWh2S1JSMkJhYmNPVXBvTGhVYjJX?=
 =?utf-8?B?VDc5ZVZudEwyWWJrYS9UeGV0Z2QvNzdqbFdWOUlJek44cGtKbjhGOEVUUCtP?=
 =?utf-8?B?cmQ1WldSU0o4QmhPMzJUSFM2U09UKzdCL3pDQzBzRUEzMS81RHJNQ254amhl?=
 =?utf-8?B?dXQ0dHI0Q3o2MEFqYkFRUEZ4VWNQT253YmkxQUcwd1YyS29tQ3dqWFpPQUJZ?=
 =?utf-8?B?RFdHU3pTMGsxdi80bnltZS9EckRqQUJPUkNyb2g3UHpqSklwQWFseThhN1J1?=
 =?utf-8?B?Q3ZKRitCV0ZHenpPZnNtdjJ0d3ZvSitJU1p3WDg2KzBtMTgvajFQcEZHWHVh?=
 =?utf-8?B?UHVteTcyVFp6Z2JNWmVLQURMZGtvM1o1dDBMRWNsUG11ai9ZcTdDTjY0QTUv?=
 =?utf-8?B?NnRqK2lnTm1KbTYzR0I3Z0RnTWQ5VTg3UG4wR2JhZDZNa1pNNWpWUU5QMXVm?=
 =?utf-8?B?c1hCRXlFY0JXeDZYR0JFbnNLTkttajBYN0NTWWtGb3VXbjBEdm1ESDBmUStE?=
 =?utf-8?B?MEkvUjFZUjFqMGRGSVRjbDQydnZLbGhkK1lubWFWRGZyeDB6MVl4YXNXd2lB?=
 =?utf-8?B?ZHJ5L2Q5a0lFWkUreUl6dXd4dGVFNVdTdDh3MVp1WU9xRUJhVmJwZitFdmo1?=
 =?utf-8?B?MzRlci9ScnlsMkVRdzNpWElXajE0MGpkWjFYYkRpSC9GZkRJOVBSMkl0WW5I?=
 =?utf-8?B?UGxKdzBrTmw3VXpTbjBpcEdmaFB5ZE1VMkdDbzNNMnRYR3lBWG9UT05IQ1Jy?=
 =?utf-8?B?TTYzdWU2OWdsdk9yakdNQVBlQ2VDRklDZWQzM2xiSzZNU2xrcHlHWlA1MWFq?=
 =?utf-8?B?dWlNQ0xUL3phK2VIQ3gvR1dFQ0VUK1NqdnlsYnlRMVgrRUl1bTRkdS9qVkxX?=
 =?utf-8?B?ZmdRZXdWNEV2L3NZa2ZNaWw4TzduMjVVVU5ZRldQOGpONmxRRnIwUmdGVW9O?=
 =?utf-8?B?d0dDS08xdGluOEY0NXMyQi9ncDN2cUJLR05CT0pKYklZQjhBcnA3Z1FndkpC?=
 =?utf-8?B?bjVnS2ZDcUkxOHlDMFg1SjhKTEpaUjVYLzR2WVc2Q0hSbUlRTjM2amZGNHNY?=
 =?utf-8?B?ZkMyc0pGVkZuVDR6RjJSeDIxQnNnc1MxQS9pakU1Q2lZVEFOcldaY1p3MmhU?=
 =?utf-8?B?ajRtQ1NBZGkrdGZ1Y0NnaU1IYmIxVUVaL3Z6UDZDb2pqdDkvU1BrNXN0aklZ?=
 =?utf-8?B?UE54dGloOHZEdWxrdldwUUMrYnl5YlpFMzNLS3NMSDFNTmgxaUFOaTdQbWp2?=
 =?utf-8?B?RVdoMEFVWGlVYnI4MDF3NDZOMUd1bURBd1M5eGlUU0lrVi82UzVkcGs4WkRQ?=
 =?utf-8?B?TUR4ZlNFZUR3K0JzRGtGQ050NnZrQ3hoL2FQZjJZTml0OEVGQ21EVVloSmZl?=
 =?utf-8?B?cjdicnZwWDRENCtSajhmTTMwZ0ZkOEh2V0FZRGxvcE83VnBsdjZ6Q2NNNVhN?=
 =?utf-8?B?bW0zdXk0TGJkSko4bFJqd2JXSEtHWnFqR2swM0Z5aFZnR3FXKzZHczlhZnlh?=
 =?utf-8?B?akZabGszMm9acjgrSjFVWWFyazZGamVGTkI3aCtSRFB5R1dCU1V1S0tLa3dv?=
 =?utf-8?B?MXpPUy9ISEpoRzNleTZqOGd6RllQZXFwdVFDWkZPeUZOd0JrUlZaaU9qTWt2?=
 =?utf-8?Q?ZwLIiMaLIg90rhrAzUXky3g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e28eb9-bc23-4c7b-3494-08d99a2364fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 14:58:25.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8euxLKuyIQpFStBr8GfkvxEiuQh5wjyor/ZDMpfFKfSX0QFIkmogFVLJiJ4mo1u6nlBt+FgQ2mo5K5qKMXrLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 10/28/2021 8:15 PM, Mario Limonciello wrote:
> On some Lenovo AMD Gen2 platforms the IRQ for the SCI and pinctrl drivers
> are shared.  Due to how the s2idle loop handling works, this case needs
> an extra explicit check whether the interrupt was caused by SCI or by
> the GPIO controller.
>
> To fix this rework the existing IRQ handler function to function as a
> checker and an IRQ handler depending on the calling arguments.
>
> Cc: stable@kernel.org
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1738
> Reported-by: Joerie de Gram <j.de.gram@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Note:
>  This is *possibly* a fix from fdde0ff8590b, 56b991849009 or other
>  changes in the acpi_s2idle_wake handling, but AMD didn't support
>  s2idle across the kernel widely until 5.14 or later. This is the
>  reason for lack of a fixes tag.
> Changes from v4->v5:
>  * Correct debugging statement that was obfuscated by kernel %p behavior.
>  * Instead show actual GPIO number, which is much more useful for debugging
>  * Target to stable as well
> Changes from v3->v4:
>  * Adjust to reverse xmas for newly added variable
>  * Add a debugging line to show the values in the register that caused system
>    wake to allow for debugging of spurious wakeups
> Changes from v2->v3:
>  * Add new precursor patch for fixing missing ACPI function stubs
>  * Add __maybe_unused for unused function when set with COMPILE_TEST
> Changes from v1->v2:
>  * drop Kconfig changes to drop COMPILE_TEST, instead #ifdef CONFIG_ACPI
>  * fix a logic error during wakeup
>  * Use IRQ_RETVAL()
>  drivers/pinctrl/pinctrl-amd.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index d19974aceb2e..83fbcdad0904 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -598,14 +598,14 @@ static struct irq_chip amd_gpio_irqchip = {
>  
>  #define PIN_IRQ_PENDING	(BIT(INTERRUPT_STS_OFF) | BIT(WAKE_STS_OFF))
>  
> -static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
> +static bool _amd_gpio_irq_handler(int irq, void *dev_id)
>  {
>  	struct amd_gpio *gpio_dev = dev_id;
>  	struct gpio_chip *gc = &gpio_dev->gc;
> -	irqreturn_t ret = IRQ_NONE;
>  	unsigned int i, irqnr;
>  	unsigned long flags;
>  	u32 __iomem *regs;
> +	bool ret = false;
>  	u32  regval;
>  	u64 status, mask;
>  
> @@ -627,6 +627,16 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
>  		/* Each status bit covers four pins */
>  		for (i = 0; i < 4; i++) {
>  			regval = readl(regs + i);
> +			/* called from resume context on a shared IRQ, just
> +			 * checking wake source.
> +			 */
> +			if (irq < 0 && (regval & BIT(WAKE_STS_OFF))) {
> +				dev_dbg(&gpio_dev->pdev->dev,
> +					"Waking due to GPIO %ld: 0x%x",
> +					regs + i - ((u32 __iomem *)gpio_dev->base), regval);
> +				return true;
> +			}
> +
>  			if (!(regval & PIN_IRQ_PENDING) ||
>  			    !(regval & BIT(INTERRUPT_MASK_OFF)))
>  				continue;
> @@ -652,9 +662,12 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
>  			}
>  			writel(regval, regs + i);
>  			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> -			ret = IRQ_HANDLED;
> +			ret = true;
>  		}
>  	}
> +	/* called from resume context on shared IRQ but didn't cause wake */
> +	if (irq < 0)
> +		return false;
>  
>  	/* Signal EOI to the GPIO unit */
>  	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
> @@ -666,6 +679,16 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
>  	return ret;
>  }
>  
> +static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
> +{
> +	return IRQ_RETVAL(_amd_gpio_irq_handler(irq, dev_id));
> +}
> +
> +static bool __maybe_unused amd_gpio_check_wake(void *dev_id)
> +{
> +	return _amd_gpio_irq_handler(-1, dev_id);
> +}
> +
>  static int amd_get_groups_count(struct pinctrl_dev *pctldev)
>  {
>  	struct amd_gpio *gpio_dev = pinctrl_dev_get_drvdata(pctldev);
> @@ -1004,6 +1027,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
>  		goto out2;
>  
>  	platform_set_drvdata(pdev, gpio_dev);
> +	acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
>  
>  	dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
>  	return ret;
> @@ -1021,6 +1045,7 @@ static int amd_gpio_remove(struct platform_device *pdev)
>  	gpio_dev = platform_get_drvdata(pdev);
>  
>  	gpiochip_remove(&gpio_dev->gc);
> +	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
>  
>  	return 0;
>  }

Looks good to me

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>


Thanks,
Basavaraj

