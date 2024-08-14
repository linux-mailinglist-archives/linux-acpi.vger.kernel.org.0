Return-Path: <linux-acpi+bounces-7576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9047951CF7
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D989B1C20965
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0A1B29DC;
	Wed, 14 Aug 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Swa1MQ2d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837431581E5;
	Wed, 14 Aug 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645350; cv=fail; b=E+pRJWHunGlwt48pdHI0k5XqZIWdub2TLNYfTDuJbdSgS5KGhyddNyZc1bBcIfME4aHebWkhO53EsalHPMMc14qt9Yu0pxDbFT0pIHO4T/YVlYiRC2Qu6/pxZKUE8jwvmRCgOqnPqQcu4RaaWsteYxjR7H56RwGNhmS78UkF6b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645350; c=relaxed/simple;
	bh=XXO5OPYLDFhuFyeLnMXremMCY29o47Pr1x0oO439+6k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sAtaph5O4tBVn2wMTAkN9BCHmnh4XsJVciNyDkoywKx4uuEx56TJRtwIrB4Z5Nf0XV9ckzUlVwL7BAF6+YcQh0tL+LvHEcatLVNVDnzlLFVjgwNpvqraoq/d3WcDmsvuwtwvbANL0uDH582d8NLmxE+VpsVTnngJKGW0kSoN6Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Swa1MQ2d; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT215fO1rdOtD0PgmEyfV691t7K5VPpzR9QFiTDQ3xeJ4Fe5X4254xLhdkrQu/n4dNuDDiIICPmDc4O7yv9EvEDoQYcWNz9Eq1AeM4ZgBuhz1jrZa+yNRiN+tEVJhAI30sf+9/4OltlNsCxj9H77nkWRYBgEPHQhvdjzed/CSOrPRu3EnkEldisTcMj29f+Qs6HDu7+jKnm96zrhpOFjtvQyZSYUVHp70ssMUw0miMB2Z/jFaTHCC+mJ99hKpD23AMwnIVra/WGbYc0cUhmzI/t5h3IT4VbXrO9o2QVKUEFJurgHTXA7gspQpnzD7FFuKuE/L9pJxytvebbTU92OTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVGPwIwmPTz/ECchCg+rTJpWeMeSWI5HoqSpSTfZ5xM=;
 b=L1S1CUZJRPLf6BzDe1jcOOt5JUshpKYFl4t6Gxa6eEFMHHj2n5LMt3swhvxkWr5e/cvT9bXXSfDj1pMRoL4/3Zg4Okseicns4Za34apXMzg0wPQIJV7LEQ6iMDkk+PQYwuGtVRwEP0MFa13pKfGXfpXXPj1Xhg4O+6LglM8PKFwKKEj6HXbHy7Qh6DH/KvVFbuAo4bTrxp19GgioZ4wm+y6EmA0Ck4RQMXLmd/G4YfzTURwof1aVYfBVoJLwQd/jarGyYnuBU5pcWnoA5BDsNYRShEVYh47m1vbY7UDNEBfognfINI+GFv1cCIFJUqUe+XBz76vZJiNrFRJHaXynAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVGPwIwmPTz/ECchCg+rTJpWeMeSWI5HoqSpSTfZ5xM=;
 b=Swa1MQ2dGS+3nQjB72RJ+7Nrc5GGP68dBuNEa8FrRFXTF86R5RNmA00cUQpVYEzOAba2L0/uddalnR56GXfzz23zJiwfES1RdAnoqr1cVHRYwVZ47Zr9UjkbEgP0eoKUPUmvArz7GWFFY4lRRHi2L+uV7wa0Y0LnraMJK+ZJTuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 14:22:26 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 14:22:26 +0000
Message-ID: <60582be6-e4e1-f3c5-63e7-5ff7016c87a9@amd.com>
Date: Wed, 14 Aug 2024 09:22:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv2 1/4] x86/mm/ident_map: Fix virtual address wrap to zero
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Kai Huang <kai.huang@intel.com>
References: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
 <20240814124613.2632226-2-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240814124613.2632226-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:806:28::27) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c16caf-e9b2-43d0-7070-08dcbc6c8537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	vY5vXpp7xOlHnogXlPJGWViBhegTo7aRrq5ACNZF/9PbdamR41EtaxZF7bDbQ61M7US6JeBxzsk2NPugIepzoNCbXxP+WaSNVRVqSBEP8Bz9L8IMXLcehBmHBsnYxfb8pkb62RT7KNeGT2ace0+iZyYeSCJ5IDeTDYUW9qNKKfWrLwz+WJru+ysc7cIYNX3XdqZo9rf5eFAvegSwKJUthL341ie+slP7b55giJii09LHRYvbxupjQIOIBhcA7sXfzp+DPI07rHqYqTJ3+zq8aNaZ3FbBju5hJMsnfb74OHr4DcDmuiO4pkyplffjB9KFVyQUHDKdV8WApacUuxsvyqR2n9ZFlrSTGCZzJuA7fA62JmHp6hBxV5ZQ/e9zqY4EAbnlzeXKjODr57sjYrXpmSWjrJWvwneGW+luMgzuxzSp1ZR6yQryPfKc9mGK8KWUWYuOafN8BH08gG89nNHqkBIRfhwNlfsjEW4wrsPUlshwjTlXF+5iEPkCkdmd6iLWIFM1fDwDbZMy93FH20CbhZHTPoPGok+2yAJlGBMjKb4fBjXZ7iJR1gsEvqNSzosySCkkGE+NLupVDsbAuOeLRr/5eeYXOw+6BD4jg8/oT7qaip63RR5c8EDxPmg1ji1l6/7w9/MRmVbtL7vGYS997S6Xjh2SxqeI7oKzXzgZ6RSDl2dkpd74UdD2kZwz6xS5bN3AscKuVobbQdNwCBcHYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1FKd21CdTE3NTgxbGpGUHdHQzdTOW9GZkZGdUsyWENwQnYyZmwzRGlSaWtB?=
 =?utf-8?B?dEdEUUZwUnVDL3FOeUd5SDZpKytTQU11aHIvWjlHV1RmSFVBNXZJQzZabGRm?=
 =?utf-8?B?RU5mOU9xSlhiR3kvMEo5R2w2Z2dYWlgxak1peTgyTXQrUFlTKzBjWHd4OFJw?=
 =?utf-8?B?NEFlVkVDNEdlNStISGxrQU5XQkVWZEM5N1F3ZkVSdFBKUEhwZ1JUNHVqbFZE?=
 =?utf-8?B?N0VId3dIUTNMWm0raDNqUU1jZVlhenE2QWdmQWlQdEg0dkJGL04vajdYSlE3?=
 =?utf-8?B?WmF4RGNVZTkyVDFNdWVDejhNYllIckRreXhCeXVnNzFrSHFnb21mNHIvTXpF?=
 =?utf-8?B?YVN5RkJjVkc2dDFKTGRxdFBKNzV5d2ZEZ2c1OFE2ZHgzaXJqTTg2UHVqempk?=
 =?utf-8?B?aVNzQzhvcjZBWlNsMi9TQ1I0U1Nxbyt6ajJLL3pKMXc4VnRVdXhaYkhzN2RU?=
 =?utf-8?B?RWgvNnlFdHZqbGcwYmErZDMyMElKblZRVU9Cd2JHZ2EyemwxRHFFWC9tYUN6?=
 =?utf-8?B?cXlWcHduUHoyYlFFSE9qWmlGVitiR0pvc1JkR2xTMVBnQ2RObEwzdlVaYkZy?=
 =?utf-8?B?dnNUVExNak1yNDRMSjY5RFJvL2RQUzN6ckt3VEZEQVUxd1ZXWXBJZmF4ekta?=
 =?utf-8?B?UTRaRUUxa3JXTTJnVnpidURTajVyb055d2lVQlRJaDBmU3dTNDh0WHoxUm1l?=
 =?utf-8?B?TUhObXlRZHkvVlJlZE56blVRcTYzV1hDREFmT0FGZFpmV0NFNUVxN0h2Ykgw?=
 =?utf-8?B?WkJVUlAzVnBMaVl0UWpJWVBldnhOTWhsVVl2WXUraE5ydEthcGxKemtLbHlR?=
 =?utf-8?B?UHZ0V2ZPcElTUmpnQjZyU1MxR3IvZ3ZibmxUYmsyK3Z1enJiak41cTA1NHpM?=
 =?utf-8?B?blRtWGo0Z0RWUVgxdFdCTWxLeDFTZW5ibUNMaWVrdVArZlZ5V2VUd0FwVnlk?=
 =?utf-8?B?QlNobGZwS2JuNGVKVTBGMVFoMy9Mak0yRWV2a0MvNmhBbVRFWldQYkg0aUZv?=
 =?utf-8?B?Y2F4V09WQndpdjl2NFRQcEt3SnVDbkNZTVFBcTYrT3l0YUxUZTBiVGh2S3FR?=
 =?utf-8?B?aVNqQncvLzd6RDVYRkk0eitiV2RHV1VkTUNDeGpmcVFRcnF0d2JWL2FGOTVx?=
 =?utf-8?B?cVQ1LzQ1b3pCY29uaWQzZmY3Y0xoWW5vblp6eExiR01taEtoRDIzWlU0UGpu?=
 =?utf-8?B?clE2Z09NWGxERHFSNExuY1cxNFpXdWNUV0pVak5BYVVCN3o0dlJCenpOQW5B?=
 =?utf-8?B?OFVrVTJGRVlPQ0VxQXN2Z3RvREpFUnBaWlNxMVpRRmVsQ1NydkVHN2t2Rmln?=
 =?utf-8?B?TjBBMmtYbGM3NkFsRWdTaForZzhrZWdDK0l6SlVoN1JzNnAybytSY1BNQ3lT?=
 =?utf-8?B?VXBJODZveWN4Zlh5RE5xQUJRV21tdkhYZWdDK1J6QkVEd2tqRHNpcncwc0g3?=
 =?utf-8?B?TjVpODF0NnYrUmxzQ3RTSUhwcmdqWjBJTStyaEJocjUxNXZuOVcrYmNtWmFV?=
 =?utf-8?B?OVRxL1hybGEzbFRVUFI5R1dhc2s2YVo3Y0oxT09kSDdJZ2pqUXhMbmR2Vm5i?=
 =?utf-8?B?eE1TVUYrUCt1M3d4TW0yRVNEaVN5eW5vbXdHcVEraU96eEg4RmRaK05pSk5C?=
 =?utf-8?B?Q2xQMVVNRG80MnU4N3UwUEJ5WElyYTB4Qy8vcFFzMTJ6OVRhdXZ1NTBzMFJy?=
 =?utf-8?B?bDMwdnhaRDFrRmMrdkFScUZrOXZ0SnZDSUh5UGRqaDFRZGxYWWRLN3lWSkx0?=
 =?utf-8?B?YWc1WXRET0R5ZXg4bUZNTmorazFWYXBHVENkeVZ1UWR4NlN1R3pKa0NKdUR4?=
 =?utf-8?B?SWU2TFQzczFDakR1NmVRSWU4Q0hmZ09jVHl2SC82eVJKQjRWZE41MU41bWlI?=
 =?utf-8?B?bTcrOXQ2RXUzN1l6bWpOV3JlczNvRmRMNXJXVGtNRkd1OXBVK1BWekVjRkZE?=
 =?utf-8?B?VWl0VDRPc05mM2x2Z3FqTkViWUdxYTNRRHRaQWNNUU9welFVdktOb3Bsd2Ur?=
 =?utf-8?B?TnBjdUdGL0RXMEZBNzc2czhHS2hwek4wbjQwazdHZVBxRWtyNklZWHpzN28w?=
 =?utf-8?B?Z1lLdzlBemxzNjVyTkplMGljcDNUN2gzL1VISld6ODR5SFlmdnJtM2lCVUJW?=
 =?utf-8?Q?mGetdvP5RMQEpeTmS4RAPgNQx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c16caf-e9b2-43d0-7070-08dcbc6c8537
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 14:22:25.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18uQZJSXF5IcG+vLu/6HwIFVIX/zqgJ28x4pcyQH+bFvEheTYZ5UvnbJjVp4UpTx2qM3OGhlGQGk7uNE+7oD9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000

On 8/14/24 07:46, Kirill A. Shutemov wrote:
> Calculation of 'next' virtual address doesn't protect against wrapping
> to zero. It can result in page table corruption and hang. The
> problematic case is possible if user sets high x86_mapping_info::offset.
> 
> Replace manual 'next' calculation with p?d_addr_end() which handles
> wrapping correctly.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/mm/ident_map.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
> index 437e96fb4977..5872f3ee863c 100644
> --- a/arch/x86/mm/ident_map.c
> +++ b/arch/x86/mm/ident_map.c
> @@ -101,9 +101,7 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
>  		pmd_t *pmd;
>  		bool use_gbpage;
>  
> -		next = (addr & PUD_MASK) + PUD_SIZE;
> -		if (next > end)
> -			next = end;
> +		next = pud_addr_end(addr, end);
>  
>  		/* if this is already a gbpage, this portion is already mapped */
>  		if (pud_leaf(*pud))
> @@ -154,10 +152,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
>  		p4d_t *p4d = p4d_page + p4d_index(addr);
>  		pud_t *pud;
>  
> -		next = (addr & P4D_MASK) + P4D_SIZE;
> -		if (next > end)
> -			next = end;
> -
> +		next = p4d_addr_end(addr, end);
>  		if (p4d_present(*p4d)) {
>  			pud = pud_offset(p4d, 0);
>  			result = ident_pud_init(info, pud, addr, next);
> @@ -199,10 +194,7 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
>  		pgd_t *pgd = pgd_page + pgd_index(addr);
>  		p4d_t *p4d;
>  
> -		next = (addr & PGDIR_MASK) + PGDIR_SIZE;
> -		if (next > end)
> -			next = end;
> -
> +		next = pgd_addr_end(addr, end);
>  		if (pgd_present(*pgd)) {
>  			p4d = p4d_offset(pgd, 0);
>  			result = ident_p4d_init(info, p4d, addr, next);

