Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26A2B240B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 19:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKMSwQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 13:52:16 -0500
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:37857
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbgKMSwP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Nov 2020 13:52:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAVFaPvJlFX+j0pYQvyfWqDl0+2xGPykM7oXg574YhMzr+XfsoN8z/XEOxIG6mYDri5Tgf5FMth2bsz0VFRzqW6Uk8wmQohGOueHXc9gTMV43PyAu6E9UIomaUT9/MScupFAjPoRf49lHEENPwPjutfkgbh8CaUqPkg/7Kb+8lugcSuLFqlgU8c//f/rBiQ4asZGbc++KzE8vQ3Up4IZKRPeLLjG0WSU/EKZbzsJyMkzU85BoGm0lPFexfGeKMyL6Z4iJQZw97PxxvSRrPy2nvKTCQ+hBTn/sfw1CcuRAtEv99z3wNHAo9lO5ZMeU31TaI7Z1wUkKWlKF78OnzhzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brlAgpFXkJXf/zd9GLMD6T4mAXnaxzXTuV0A6Add0QE=;
 b=LUN9OPklLCxaDX8oTiyaa9KtlT8UacQGkRuZUn1g7qtK3HhG+p37zo36L2I+KQ7+b5lTDTCLLIK0o4WcULIOz6zsQBSVwJOLGanXPU9JsmmkU7/0bvM0oEYVOumaDeQxxTNfF80dIOXtXZVGCHxfa4Qo/1DqkeBjXpHWKHIg9MCFStHZGnXKZM1vsJC7dSt5bcKsceXKNVBn0QxPgrDPnpHzr861Ybce9AoXLzXb6tgj9h9sDRpKC1CMnaIvq6gefuTWSGuzj/NFGEMG3yAnO2g2g8EMQfpLelRgRPX8zqL6I4/k27SzfD2AX7VfZjUkcjezGOh6AzVLH6l+gzbgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brlAgpFXkJXf/zd9GLMD6T4mAXnaxzXTuV0A6Add0QE=;
 b=YlQIRMGwsy9Dv48J2LOUpKo0DDhLztgKExlEWJowaNXKolybdSOq+vA3RQnzTxnU39/Go85lM9vrdcFTKP7Jn1qZNS3vYzJIXdgEXen5DXb/TbkB4gpQL3n0upyW4PzhW1zHxEvtUWJKOqr0com736VPV4RLtSPC5+OGCaj1f+c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 18:52:12 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 18:52:12 +0000
Subject: Re: [PATCH v3 1/2] drm/amdkfd: Move the ignore_crat check before the
 CRAT table get
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1605237074-58920-1-git-send-email-guohanjun@huawei.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <981ee1d5-072c-d1b8-af1c-2277b3e075b1@amd.com>
Date:   Fri, 13 Nov 2020 13:52:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1605237074-58920-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.117.63.22]
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.63.22) by YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 18:52:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b8a1b5e-08df-4317-c11c-08d888053b5a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4333:
X-Microsoft-Antispam-PRVS: <MN2PR12MB433372EBE9E053F00278E7DB92E60@MN2PR12MB4333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Rktbx+w86XleBZ3sARwFZDtejH1EqBoAxgE5PCN8GHa8Io91OjSXLXLZbFEa5fdr3QQaX6M68Y1TOhRTije2olG48PgoW9yj3LVUApyl1vNH82ez+LvBZvbBDNFuBkLyEh5fUpb5SkUuBDUc6UIr5LYdA+rMWS8beoSh95NR+9IhcNjKegUppNf98SpPlB5gDmIANyXz05BxF533sI4mTUCrc5h8a2ureGVMs5B/0V250hor03cK1F+s/FDndrNo7e7N5apoSHDLFm+xB39R4WDCkb/Q+w4mKLqmrK9tMkjc9GxRHu/cnlAmbT1M94RuXEwueaOlIQeuMrORBO+wULNmthwiCWS8XDfqBqOuKJxtQNjx8lq+iJHqCaNRVev
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(86362001)(26005)(52116002)(186003)(2906002)(36756003)(5660300002)(66946007)(4326008)(66556008)(478600001)(66476007)(31696002)(44832011)(8676002)(6916009)(16576012)(6486002)(83380400001)(4001150100001)(8936002)(31686004)(956004)(2616005)(316002)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zNhbJu8u3O/2WkhxVSK2nVdezLzOcjEr4VqDK6ecsV4Oak/Y+NluyGQyWGBss9tYh5aLuR5fJbXGGwz083LeCLVrEp+9vs+szLNSb/+EpFd0m2ml+jxfPiAk7zmTO8x+QzpGOV+nGMrMmP4v/mZaezrYGzZQNzjFR0t7dNSUJAtQCjnQ0phEQu2xDxhSyxgyov9v7p/5/a5w4vTxPCqcJYKmEvWK2dZNDQXhKxITX90Y/m3U5m+NUc8IlVskd7TRM3x7p68mOF2x4a4O5vxInjqfPxg33KhFx+sHnEm17GSILAWlkZreck68SI3JT01jXNyOelZAyePOkKUpKRdf3ugg+c7cmH2f+pfc72oSU6Kv7XdUNdq6At2jZg5VNYZpC8jaUkaNyfiNyEvrfiqJN2zCz0QcPnjTJ27VgJba7TKNQ0ASE6dmxZht0v37XXzNhQNIyfQEQkgLSOUHmN0szuHNnbuSZ05618+WUuqEE7/j7128YEtzKPJHTmy1T7dAxErO012K4hI7atL1knaqLvQJK3VoToolxx4ZFyjRzUeJpwG7eAjWetd/3ITtBclW0A8bV7BDvPWoR48kQX/XWa4hp9O9hc07Yx13SFcInQAgAW3HM3Xjw3hzG8iZcOnZkRd7BvPmOv/flEIuPsbxAql6lN9W5hJXRuzkQK5/Kt8SpCfeZkYID324fdJzP+jxY4LcaCd7CGMNJVSwzrfYNdhco0RLESwR28AjUNnOxFgQG3+BPkGGe25MmnoxmZjAn8Og3BtHkE/Rj+S/807DqPXIPXBfXEq74JSjUC/mQT3vEDksjvbcg20YDg0v+lk+jlbx9RsE+SfiVENjV1I5Qh1WjzDNM+tpNlOsfqbBm33USe2yC92TvawSZPbusq+OjILQAIyX0V5y7n4E4k8Ltw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8a1b5e-08df-4317-c11c-08d888053b5a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 18:52:12.8019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmcMFLk6phAxkmVUJ86s2VcAQL4jdtwE4WVqDY5UivDbXD1h52SGvJ9VEoCQ6HJBaOf1VB5kwmBO/jTa7s0WlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am 2020-11-12 um 10:11 p.m. schrieb Hanjun Guo:
> If the ignore_crat is set to non-zero value, it's no point getting
> the CRAT table, so just move the ignore_crat check before we get the
> CRAT table.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

Thank you! I applied the patches.

Regards,
  Felix


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 3de5e14..c23e571 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -780,6 +780,11 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  
>  	*crat_image = NULL;
>  
> +	if (kfd_ignore_crat()) {
> +		pr_info("CRAT table disabled by module option\n");
> +		return -ENODATA;
> +	}
> +
>  	/* Fetch the CRAT table from ACPI */
>  	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
>  	if (status == AE_NOT_FOUND) {
> @@ -792,11 +797,6 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  		return -EINVAL;
>  	}
>  
> -	if (kfd_ignore_crat()) {
> -		pr_info("CRAT table disabled by module option\n");
> -		return -ENODATA;
> -	}
> -
>  	pcrat_image = kvmalloc(crat_table->length, GFP_KERNEL);
>  	if (!pcrat_image)
>  		return -ENOMEM;
