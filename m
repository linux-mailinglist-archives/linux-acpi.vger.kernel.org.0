Return-Path: <linux-acpi+bounces-3420-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188F28516D0
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 15:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D1C1F25A20
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C353B2BD;
	Mon, 12 Feb 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XMiCaPKH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E283B293;
	Mon, 12 Feb 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747247; cv=fail; b=kkpbPmKO5xHKNhnHyAnbTAgWYllaIZ9rNkzoV8MQTRsR4JjoiWkJf7r4i+RlS6kD3SWAXPirea5oedUFV4XKnhaIUOgtfLJ7BB1ZPtCZILPJB6sM1iYcAruemPhIVpM2fNQDSa2UIiGVO3zeTzSiRV7GUBWZGAgzQ4FUmw2h3Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747247; c=relaxed/simple;
	bh=zWDXMu38MbdglA5fqEwDY9oKwQHMXG1yyXjfsU5Vk0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VKIlcdgvFuigWqXu9Kt5z0OUxvmjFQQkaEhTuhUsckAFctU19XpQyqKX7j1u4ItI2r9Mv5ivg6dsU8u9sSfrZxQX2TP+G6BhjVt2z6oG4rC3t/jZgh/YzKPhEz+Ydvpl3+yY4KbsZ+55TK/rJJkIC4+AWUL+ej1YVdqCQ5/MSzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XMiCaPKH; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRnLYcZgEsPHbssCWURZG1giPFe50Kq8RjmKCEj6l3h/6CdzsvMEqYX/QEkmNG0VMEmA0SfsToqhvZuifJo+92dHb48oFkD9f/PR0w6ofcAnTI8ckoxoK9GEAk43nRXW1h4N4kgMVuryObsPI/zc28onqNfUjMcaAXI2/RbKuLw1jSiKxzBmLOxnzIKllVHBBiZqxIC0d3DSM+CbcyI46WsSp1nOJbTU3YTA6VxtwuqVpzXn7WdaGqKLSZOr2xBdwfRsy2z2Vn5LioUDNZNvIljks3wuHZwFebot4ixe47jRJ/9f0whvkB/mCV3e4RqZBCs2cp0gNHrRYB6M5JeWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu1mqxWJW27kWlrMZZ8/KwnAvfZ7mtfcrIQ1qCNO9VY=;
 b=OAqeCYyzoxF/Jvp9asy7HfQIQoatLOEbSAXPt9l2+N4GwKCFt57ttfDV4Mm5X/gnxmQSVLKA+xn+FJKbs49TspOtulN71zoqfSDN++a8dA5UDo76Ywu3Zcl5EMXWjV4ksdgClcuATRSmDcRiLJ7DAcF3MbOluaxdXALBc9T97SgKKlaHRWYKl/YEBpm6OZ+zzqPeiue5SzKZ6GdvDgsK6+YOM5F7mt8Ax6fMbmvBx9yTZW+bfVJVF573uI5ulwNvYJ8cjL84YGv6SsdTMdlat8Isgui4N+H6JwsGOcB1a0BDGKY9Bqq6ZOlppZxLE+3T9aIryqsHS4Q9qYt7G4SpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu1mqxWJW27kWlrMZZ8/KwnAvfZ7mtfcrIQ1qCNO9VY=;
 b=XMiCaPKHrWWAnnHx29Wi3WcOkzQ3LkIiAtiq3dS5RJ/oXZsxDz4TUz0dPg81Uf79QX+z4zSUZiUMnOyaL2SXJzBe06s8ThF3JHQBbHm/1GYBDznE2wdL+JVwhscty8FCLtxX18b+8GI81hDdqEEAfxJFv1Le0XUZm83w0oIY8F8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.17; Mon, 12 Feb
 2024 14:14:03 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7292.018; Mon, 12 Feb 2024
 14:14:03 +0000
Message-ID: <2e38c282-c4e7-401b-abd8-66f451c7cc8c@amd.com>
Date: Mon, 12 Feb 2024 08:13:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/4] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error
 types
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 alexey.kardashevskiy@amd.com, Avadhut.Naik@amd.com, bp@alien8.de,
 tony.luck@intel.com, rafael.j.wysocki@intel.com
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <65c81fc3d3b6c_d2d42946e@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65c81fc3d3b6c_d2d42946e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::15) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ff583f-f698-47c1-9d04-08dc2bd4dd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PKXFe3lSUCJP51VQNH7p38YUvIPaws60nSreLZBgcMUgh6Dfeeo9D/GiYODD4EbCYfBpxKyJqzwtYja7uG4koVHskhwyXnqwxY05jeuiBGvT/oTinLXqTuwxYA8hrVm5F5vCaOMWBi3ZWn91ZvMTnAj7+BM9v2M/p12RGuSmMUHn0MeOtWvOqZpqxwVC32lFpSTovQ+6ZgMlhPGzOnnaeEZ1SK0brRJD5An9JUsmPsTX4vQ+BFvLx//H/NtjHPdnWAdHmrNGCV9W7QznZ9FQRjA+Cj7WpuRQem4g0q8vtH3zxvfUY1gv4I8XhIFLlWX5o21WSRbe+3yGss5cZr7SaxLe3vB3DtnKLyihlym3IfPfVJNo7rfmo2kQ8zKy3hBpMHN39IGdvFNw32IYR/mHWDe524tZ4JM1nA6ZPe5TetVuNREvsPX9PNSCAL8Ah5F77Znc7wWgv5LbRXcMSbbzPF4tOpGOSRChKDvZSgeaaL+2I+QqheP0Z/JzBI1stBTJ/YRqUWgNEAGtFRJ1+kSr+s8Zc/nixz9gc4Iu3lCiO2RMCROkzN+L9kQ+S/+0nsdp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(6486002)(6512007)(478600001)(41300700001)(2906002)(7416002)(4326008)(8936002)(8676002)(5660300002)(15650500001)(66946007)(53546011)(6666004)(316002)(66556008)(66476007)(6506007)(83380400001)(31696002)(2616005)(86362001)(36756003)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnNhZ1hEaDViTTJCUkhIdDhUckVwWEhPSmlXdnZqaHhqeG9oSGw2UGNyUkpN?=
 =?utf-8?B?UTlPcjlHbEU2bTF3VEZyNmZOWmQ0cjl2U2N4N0tJdURJb1VkdG1oazU4VUxD?=
 =?utf-8?B?VUo0SjlrQmV1UndWbDV3TmtibDI1N2ZNZG9hdkEzNk85VlpzL0UxS0JETDNT?=
 =?utf-8?B?VFkrR2JGREttd1VnZVUrdzQ1dXcvRzBsYk9jV080bW5XbjhTMXNHeTlPRXNR?=
 =?utf-8?B?d2pGNTVKZU43MUdKRlZabkJibm85TE5iWHFHaHlDRWZnOEtDeWFic2Z0MTZP?=
 =?utf-8?B?R2VJWjNXaDE5S3NWaUhHdms2aDVlRjZSeXhNWGMreG1zUDVJVkNINVd0aHYv?=
 =?utf-8?B?S0NPRk9vTnJmK3ptTzh5M1NHN25sZ1Y1N3haMU53QWRwNEVwV01wWHlkQ3RU?=
 =?utf-8?B?Wldra1dyNDVwWmVnMjRyRmRxaWtYUVlGMk8xQTNtVG5iYXByZWZzZU1UN2sz?=
 =?utf-8?B?TkJrQlAzQmV1dmxPQXNLOGx3OEYrSFc1OStQWTNQYnhva1pIeEtHczEwWHNJ?=
 =?utf-8?B?TVlOenJSWllKaVpXdExZTWIxQ2F2TUt0N3VnZ0F1OE5nOGM1RXd6cXRlNklU?=
 =?utf-8?B?UVlpUzE3QzdpVU0vT2pRbHdIVlJUamZJcGhhWWlxZGpzcjVTL1JTWG1qQ21M?=
 =?utf-8?B?clk4aU5qaEg5Q3BjVGNTcnpiUFhpdTFOOHFpbWpxK010VHA1US9DNDFSUnhy?=
 =?utf-8?B?Qk5IMDFtYWFlU1pKc2RMdWlkQWJqMUZ6aDhZdlZFRE9KK3FPc1RrRG9CY3No?=
 =?utf-8?B?ZEM3dFlkRHI3SElJaG5ZSG92dGFqTTFRMC9DTnJhR29GUUJ1LzZ5MGQ4MGtj?=
 =?utf-8?B?U1lZMGQybFIrWTU2QnNPWGJTeEhmTDdhVEpod0lMc1RuMkdIREQyVGNPdVpW?=
 =?utf-8?B?UkpRRzYxcGZSc2tvZks2aHhaV0lOWWwwVGVTT2ZZSzc0SFBqYnhFd0h1ck15?=
 =?utf-8?B?cDVTVXVKTzBvdVAvTWJOL2kySUpaaERpQjZJc0N2ZUVQTTlEczZvQ1dkcUho?=
 =?utf-8?B?SGt6d3dEcFFIUDVUMmZ4ZjNkZHpnU0J6Lzh6ZEZ1WC9mdGpZbzlrY2QxNEdy?=
 =?utf-8?B?NEtNbXJtcmNOYkhnaFVuam84VkFBRklqRGpwVTQwSHVHZW84N0JJZzlxQkRS?=
 =?utf-8?B?bGhsQlBYOG5rR0RmdjVMY1oxNWJkMGpFRWcwV2dIY2RFbTc5bFlvQmZscjdI?=
 =?utf-8?B?RzZ6Qm1wV2hTbmRjQnkrNUZrUlZyVUxhaFJLRDIvMlZyTE1SN3F4c1Q4RUlT?=
 =?utf-8?B?eUZRREtBWEpUMDBIbWt2dS9OSnZXSk50aVY2NDkwMlJpMis2TmRmdnZ6ZUZZ?=
 =?utf-8?B?a3ZlSGJySnM0c2FBRVUyVHMzUnlWaVZsSDFwYnZTVzdHSFpzS2NxQlRES0M4?=
 =?utf-8?B?OWthNGM5Rk5hZXh4OVVhUjhUOS9ETmZIZldXT0FodUNiaDNURmpibnE3cTFh?=
 =?utf-8?B?d1lhQWY1QnlybHZ2WXpWWnc0NzBDSGxGU1RJbUFmZlphZXBhelNPWHp4Wjhi?=
 =?utf-8?B?ZnpUR2ZpeFMrQXlGWnBkV3JOMjNsb1o4Vm40akMzN2s1SVRUUVprZU1rZjNU?=
 =?utf-8?B?TGc3ZEE5UUEwV3hhMlBIbTBia2NsYnUyRmFRT2NyNFBVY01VS1haWUpkTFcr?=
 =?utf-8?B?Umg1eCthVWU4Um0rRTk4TEFCdzRlc0sxRWtCR3FEeWJyd0kxWnNxQmoxUHBG?=
 =?utf-8?B?QWtPenU5UlVlQkIxdFFaYTZZSjVtdVZEZUhuNkNsSUYwT2VkY3EyUnhTQUpJ?=
 =?utf-8?B?UTNvUXBqNm51SGpzRGUrSFNQMEt5V3piNUw5N2UrbDlrdEp0QjhYUS83djNT?=
 =?utf-8?B?Q3B1K3RPU2JyU05XSzcvVVBLY213cEliNWMycnY2aFlNQm8zenVOTEhlZG5h?=
 =?utf-8?B?NGNxMTV5c1NxMk5iR28vSFVUWnduUUNEai8xazdyR1NZdnhqazZYU3FFSDNp?=
 =?utf-8?B?aDRZdEdNc1hZd29xdEdyeEl0ajByUFA2aWtiYlUvU1BSeWlvU3Njb1c0YmpV?=
 =?utf-8?B?YUtFdXQyMkQ3OGR1V0c2NUFscGJNR3E3blRRWFMxVG8yZjhwRVNNSHlZbEc3?=
 =?utf-8?B?elJJdEtoUXZPL0dNSmpwaFhoS3hxeEFEbEw5NGZMdzZERWx5R1ZwU3JpTTBO?=
 =?utf-8?Q?ILLt2JExqO+A5b8ZDAB4k2Did?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ff583f-f698-47c1-9d04-08dc2bd4dd78
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 14:14:02.9876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoLRUiy3FvooVEwtJzPUbMeHP02vI7Dm9PuglEVVQLeaSo6rkIU0bXhl7Z8pnbLJmOck8jKbPOj4zcZb+nHahg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902



On 2/10/24 7:15 PM, Dan Williams wrote:
> [ Cc all the signers of 709f3cbd652e ("ACPI: APEI: EINJ: Refactor
> available_error_type_show()") ]
> 
> Ben Cheatham wrote:
>> v11 Changes:
>> 	- Drop patch 2/6 (Add CXL protocol error defines) and put the
>> 	  defines in patch 4/6 instead (Dan)
>> 	- Add Dan's reviewed-by
>>
>> v10 Changes:
>> 	- Fixups in EINJ module initializtion (Dan)
>> 	- Add include/linux/einj-cxl.h to MAINTAINERS under CXL subsystem
>> 	  (Dan)
>> 	- Replace usages of IS_ENABLED(CONFIG_CXL_EINJ) with new
>> 	  einj_is_initialized() function in cxl/core/port.c (Dan)
>> 	- Fix typo in EINJ documentation (Dan)
>>
>> The new CXL error types will use the Memory Address field in the
>> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
>> compliant memory-mapped downstream port. The value of the memory address
>> will be in the port's MMIO range, and it will not represent physical
>> (normal or persistent) memory.
>>
>> Add the functionality for injecting CXL 1.1 errors to the EINJ module,
>> but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
>> Instead, make the error types available under /sys/kernel/debug/cxl.
>> This allows for validating the MMIO address for a CXL 1.1 error type
>> while also not making the user responsible for finding it.
>>
>> Ben Cheatham (4):
>>   cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
>>   EINJ: Migrate to a platform driver
>>   cxl/core, EINJ: Add EINJ CXL debugfs files and EINJ helper functions
> 
> I think the above that go across cxl and EINJ can just be prefixed:
> 
>     "cxl, EINJ:"
> 
> Also please rebase this on v6.8-rc3 to resolve a conflict with:
> 
>     709f3cbd652e ACPI: APEI: EINJ: Refactor available_error_type_show()
> 
> That should also allow you to fixup the missing ifdef CONFIG_CXL_EINJ
> guard around the EINJ driver exports.

Alright, will do.

Thanks,
Ben

> 
> This needs at least one "non-Dan" reviewer for the ACPI side.
> 
>>   EINJ, Documentation: Update EINJ kernel doc
>>
>>  Documentation/ABI/testing/debugfs-cxl         |  22 ++
>>  .../firmware-guide/acpi/apei/einj.rst         |  19 ++
>>  MAINTAINERS                                   |   1 +
>>  drivers/acpi/apei/einj.c                      | 202 ++++++++++++++++--
>>  drivers/cxl/Kconfig                           |  12 ++
>>  drivers/cxl/core/port.c                       |  39 ++++
>>  include/linux/einj-cxl.h                      |  45 ++++
>>  7 files changed, 328 insertions(+), 12 deletions(-)
>>  create mode 100644 include/linux/einj-cxl.h
>>
>> -- 
>> 2.34.1
>>
> 
> 

