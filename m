Return-Path: <linux-acpi+bounces-7577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01078951F35
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 17:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680071C214F4
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C01B5831;
	Wed, 14 Aug 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tRP+2tR9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5401B5838;
	Wed, 14 Aug 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650941; cv=fail; b=ierCmTNGuyNxPTveNHX9kP60uQFWOyQkW2qFTpZiNZ5Do57PVwvHoivyBgU40nYQcZiMxnDV7em3pu1tIEPaQ5gLZlQuKMt/JNgfChXG2zdZzPmAPJ9ADpr03g17PKuD49CiJmV84sxLLrBIagFHWOifgkB+sBSYfIhJKuuMSxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650941; c=relaxed/simple;
	bh=1FbasmwtcwcywMnw3bpGSmtDK/4bnsufyLoaH6Z5lWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L9d6Y2lDNY1djyCpiDPp+m69xjV2Yr9dp2hwcMR9pHeKrgzmzR7kqoRve4KikyvqbnNh24GiZ9JCknc8TiCoGhv0gtcJJNoDfWqcekyuz2fHTeUcaKxkNbVcN4hJdiDETkUvj37SFH/2aqqdvIB8BEdsgXffESf9pVanw2Y/UwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tRP+2tR9; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8YMqrb9gPMuti5VK26FdiImroCBxVuEy9X3tdEldcT0sXOcMdyXYkkVSj1XgtarMXT9ZPk+JXh2Bqeu14s9ziUvc18DdA4NWD/Z/dzLeqxoxAfUi6VLBCHdNxyh/GaXv02zU9tcgPBaXYysX2GzYUg4UiKR5N+Yg4I2lFGbtZhHuqUsOWH+w9LmI0Ot540zzvlXjiAzYBamgy7khhpxlmf9oUFtH9dmvBzy8LoUrix8PBw69H5kVBDOxX5VjZj6RXQhCoKPrNKCnNSFT7EgVdudQUfXiK/3H08aSiexZG2njmpzHLfI8v7kZ1Gi1LjX5laOv0DKwY4yxKOBGMyrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsrxbzHMolwZIALIFuf200HLjiAB8ixCdg2nybgZgdQ=;
 b=BA4klhmDKLTgFSClA0q52L3ALBuhqzxJOoO8V0NUYz004Ji8EJb4IVFYKx5KXTSXjW/z6AAcH6MwcEVLiW4Dcr27rn8IQMMZ9dMi2RctErEtHh182y7iics36Nx5lZ94IB7Lri8ydd/Uennpp+aB2H9Bd0XY1H4hmPLzZTmkGCN1fTHJSbC48N1rve8AVVaBTD8rq6KqeZ96l+44XUmRGAr2AneknWxnnIeekDac+wQQaykUDpN9btbeMUAfhFhfyVfTAQaU6Olq1Btj0NXR72hVvV5+EyacOs/kGI/a/2QPHqcCY2qku7SWcAQw9NJirBuf1ENWx6hPiqKic64KNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsrxbzHMolwZIALIFuf200HLjiAB8ixCdg2nybgZgdQ=;
 b=tRP+2tR9CeU+B+VNPqwb9LGHZwBfMWK5wy3ySQeUaEbrRGqd9+fXXZe86s9CsRGfpQWGThSwd5clvrRy8dVVwJYwsvg7bWXBy+MBQzRLPbOOIkx8pgfa9f5TUe3cyMfNJJopCX6KY/1gIK/KZ//CTd+V2TSMILV7Vgq5u03xMBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 15:55:32 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 15:55:31 +0000
Message-ID: <5dd9f90a-604e-b52c-8679-b17d88e14ed5@amd.com>
Date: Wed, 14 Aug 2024 10:55:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv2 2/4] x86/acpi: Replace manual page table initialization
 with kernel_ident_mapping_init()
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
 <20240814124613.2632226-3-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240814124613.2632226-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::32) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc2d250-5cf6-4a30-0e6e-08dcbc7986a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlUwdlpFUUtRa1lPWVhVVE9UQ0hlcUJna1RCOGhHaFkvNmVZcUQvMGJvOGxL?=
 =?utf-8?B?RkR4Q2xKb0JsT0J2YUovTzVkVzFTOWVmemZTdWI4S1VpWWRWbkhmVHlMZ1lK?=
 =?utf-8?B?NFNYNVVtamRsVEYrcmZSazNVYWF2SldVTWRnQmFFWWllbzJHNnRPbjhnNUtW?=
 =?utf-8?B?NHpYN2NLMXpVeGF2NlZVTHdoempwNGtvVDRKUjA1Z2ptK1pqR0tRMjUwMkJ5?=
 =?utf-8?B?cFVPZDQvVUQ3dUtvNGRackloR2pvYTRWZHdBRkovWGZJS3FMQlF3TGtYU3FU?=
 =?utf-8?B?UXkxVFBxZ21HVDN3d2ZDOXEvZEJKRitqNjduS09uT0JzL0lVTHlEY08waWsy?=
 =?utf-8?B?SGVsT1YwZ2JsMjJnUldXQ0VEN2Zydm9TYnRDTG96OGkvUVNGS3F6N3BWVVhN?=
 =?utf-8?B?M3Z4S1FqUmtRd1NvOUVkejVUYklGaEtSV2crcFpIOXIxY29LZWVNZTh6ekdS?=
 =?utf-8?B?QjdMMVFaa1Bjbmc5NVRHOVE3Q3B3Z2ZDMmtZWHhOWUE5WXg5OHlYQW9WTEtS?=
 =?utf-8?B?SENGRGNyWTBOUHdGdlFINVFWTkRZZVI0MkYzeWNienVFQ294S0hITWxLZHd2?=
 =?utf-8?B?M0pvRzc1cGV3a2VGQmlpOEtCRFd2ZkF6ZlNnMlBRQkdXckJqdUVNN3JmdWtx?=
 =?utf-8?B?NVJId3VKemtXTEo2M0xtWjJGaGtQRE82WlhCSk5WN014Rk11T2JuME1JeXlh?=
 =?utf-8?B?K0VHVzMxb2N3bm1YMkNYZlBUMmxDYkVFQmRDQzQrZVE5S1E0L1hnaHNQK1Fy?=
 =?utf-8?B?Tytnd0ZPcElxaU5NTW1uRC9QQkdyL0hNc1NFWkZSUXdFWkRFUVQyZHRSMlYz?=
 =?utf-8?B?NnA0WWhpUGRhVXo4M240bklLSC93a2lDK2ZrTkpCL3lrck96S3VhUzU1aHNx?=
 =?utf-8?B?bDR3RHdSREdTNTRoZ21vaXFvUTN3dTlNZm9meHNKdXhJakJpVjdENFRQdjNL?=
 =?utf-8?B?NnVtTWt4MnFoYWYxaEZzdmI5dHFJNUVDRk40ZDB0cXk5RnVQckNPUlJXZDBU?=
 =?utf-8?B?Y0VIOVJXYXU0ejdBL3RSdFhBUjZBUnRYR3o4bk8zN1VXTDNGUGxaYm9OSzhs?=
 =?utf-8?B?d0FoMUdEU2V6eGFJZ0pMajVqSUNhdFFRM1psUU5DS3pvbTlpM3A1MDJpaFMx?=
 =?utf-8?B?dDNPemh6L1ZQbkFiQkFNZEZDVjZ1cno3ZGZPV1cySkV0eVBjb1BOSEpNeDhy?=
 =?utf-8?B?WTJ3NkNkSTh6a21zT3NnYlB5dHI0bVBLM2R4WERkdmYzWDlhNmF3QmQ3NU1T?=
 =?utf-8?B?VjFZVGFUbEoybnJuV21YeXJjcmdiYTJhSnVLODNHUUh4VDJDalRKYklsWWs1?=
 =?utf-8?B?bVY0cFR3ZzJNbzk4ZjhzSUIzbkpZM0tPeUs1VFdZSzJxaGltUjJzUXRPWVIv?=
 =?utf-8?B?STZHVFUrRGEvVEhOVm5PbStZdlM2VnMrTTU1TDdpUGhHRjRNWW12NGRPTFJ2?=
 =?utf-8?B?Q042akNwM2xvaDRkMW5lbXoxby9PQmptVytKVFlkZlBRQXU3VnZqTDRqNnRC?=
 =?utf-8?B?bXNzeGp4SWVEcGhXNC9FdUZKWFRCUzlqU2ZHSm9DR3I5ZTVRbHd3K0xCTlRk?=
 =?utf-8?B?clE3ZXRhWDNsTG5tOWVTTlcrdUVlU0hpWlVqODZJMDZUaFJxL2t3cHFaM2ZQ?=
 =?utf-8?B?RFdyUkFrRzlqQnpkNGNCQUQ5bHZPS0V1UjJLc0FkYzhXYWNYUXozQmdWYjhh?=
 =?utf-8?B?RjFrdmNyMis4aElkRjZadEp3VVhRdi9xTmJoYTRYK2k4dTVNMWM0bDEybWtv?=
 =?utf-8?B?YjZicmdZMFI3aU1NdEQ2Wi9pcWNiWTZyMFd3QXdGRnFPSlpqMzg5dlpad2FJ?=
 =?utf-8?B?RkRXck81TWMyLzJ1TmFiZ25XdVlqUm1IREZVMWZWa1JRTDBUa1pobXZQTXEy?=
 =?utf-8?Q?irgOjYtTQAa1N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGM3eFlPN09JSTZVQXk4WHNJQ0FCZ0prZmg3SUF1NUxqS2N5bUZoOHZ5cHRM?=
 =?utf-8?B?T252a3B2UnVOLzFYbzZyUVB1RzRKVHRCampVSFNpbklDS0VGU2I1OVNpUkFm?=
 =?utf-8?B?Q0dCY3Q4WnAvSFRXbk9MUEZGU2FCZVJxY0RJcEw3TkprRFVwYk1JUGp0aVpq?=
 =?utf-8?B?UE5ZbGIzUFEyZTRud3RHZmNxR3ZzSW4reTBTS2JZVGNDZXNjK0NlMkhCMU5y?=
 =?utf-8?B?UWpWRk16L0xuVS8vaXc3QWZva2RiUVh3ZjdrRHBsdFZkT3U5Q0pWOXN5aUNX?=
 =?utf-8?B?K0ZLQ2JCS0xGK1daeGRNSkVqSFZTN2ZsSmhEcm8wcnpER1k3QzVaTUJtTGQw?=
 =?utf-8?B?MG5Jb1FYV2dvWHlYZFpNNkwyTmtobWdiRHRSa3lOcHJBbkxjZ3h0a0JzbzRR?=
 =?utf-8?B?OTRUVGlDemNja2U0YitUcDdRZzJmUDFmM1o2SE8zb1p5QW5kZnVRcGhiWGVN?=
 =?utf-8?B?KzlkWEMweGFhbEhybkE0Q3dYUkF3R0dZTURQeTVyRk44anV4VVpqa21xVlJo?=
 =?utf-8?B?Yk96M2RGUG02RWxvaUkza0tiK0NISG10NlNZWUp4SHg3R3VYTWtMMGJncVBr?=
 =?utf-8?B?dWhyS3lmdTgxbGMxaVd1ZFRwNWo3OGZzM0JuUFEvUzZ5V3F4K1VJRGN4Wllo?=
 =?utf-8?B?R2R4Z0syRGUrUFNFdE0wb0ZKRHRWUEtXNkFzZGhMdjBMRFBTcE1qaHNRS3g0?=
 =?utf-8?B?ajFxbkVJZ0F5dlgwT3RiUmJ3ZStQUXo1RGY5YkI0Q1RnSm1YcmRIMzFXTmlW?=
 =?utf-8?B?ckVVMGtxY2prT0NXTVhsVGFKek5NeldFMHRGK3FBKzdWdStsNHFIQWNMODNH?=
 =?utf-8?B?T3BleHdsQTlJcGdsMGZNYVNSK2RsRzdyQ3V5VU5JSlBtNmdEZmZrc014VXY0?=
 =?utf-8?B?Z0tnR1FMVnBnL0tjdFR6OWJIWCtuVWM0alo4YnB6ZTZkb3UxZm8zOHFZV3d3?=
 =?utf-8?B?ZHQyTmJDWTNHZldmOGN3cVZYOEo3aklKM0t0MkZndjFjSEcwT3VZOUV0M0dT?=
 =?utf-8?B?aysrZnduS1phT2xpK1Baa0FTSTFrRG5FZ2pLbENaZlpoKzZSUFdURFFnS012?=
 =?utf-8?B?MTZIL0ZZMDJNWWhPcnluNTdMcmMybFl3OUhUZDk2LzhjODR2aGNMWU5kWU11?=
 =?utf-8?B?ejhQZ1hVRDR6ZUlvTkRkdS8rd09GZjZKK3NUSjJibk9WeVdlRjVWWTA4QmxH?=
 =?utf-8?B?cTRQcUFWa0pCZUZ4a0JlOWk3NnRZcVR0VWJjVHJlZE9sdHRXRXIzZjJpaWJ3?=
 =?utf-8?B?TmRTWnp4L29NcDJLQWhrem9ycTErUENlRkpFdGxCcytzb21uRnNudzV6NVRZ?=
 =?utf-8?B?eU5iMHYxdGVkOHY5aEVwRk9ZVkNYdml5ZlBZL25mNGd0aG5aZHl3UHU3YVFN?=
 =?utf-8?B?MStqVmhvdFZ6Zk1vY2Q1ZzlBZm9FTzdTc0twVUlpL1lQODNwUndRRkhpYW4x?=
 =?utf-8?B?cXhmSlVZNjc0aFlZdDc4RmNhOXk2YVFnZktqbDUremJBVHk3MjNQcUJuRjBp?=
 =?utf-8?B?OGdSVWZLTmxpRm93SG9lQyttSlBGM0xUNyt0TEMzeU1qMWs3YlRHUGx5T0to?=
 =?utf-8?B?ZG1Pa0R3bnNsS2ZjekFoM2RmYVZmRTNNdUZwa0EyaFNXSHluMmN1TnlYeVZE?=
 =?utf-8?B?VGh6dDZrWUd2TTlFbVkrcDMxS1UwTDZiQUtuKzgrdnV3NWl4d0l0NFJER0ZH?=
 =?utf-8?B?dExjUGw5VW4zTXBmMURyQjRURllWYnBZYjE0ZFNjamFsZWxSNzVVMzM0NWQy?=
 =?utf-8?B?UG9BM2svRzE1R3RWLzF2ZWdZdjBtMENMM3F6c0NweDNnby9vYUdUR3UrMjBZ?=
 =?utf-8?B?cGtTbXBOeFJjcHZWTm5VengvWDZGTkRPcU1Td2NWeWpBNExkZjZiajlWY2hS?=
 =?utf-8?B?b1RnUzJrNDhVUkFrS3REc0lRelBVRVF3RnI2YkpGQmxVWGdEYXIxYWZoQ1JM?=
 =?utf-8?B?UEdMZ1pBeWZaRVNKbWZmSExZYmlMTmxSWitjMFArSEpNcjNoY3Btbi9JcU1U?=
 =?utf-8?B?cFh4OTJSODljZE5ZNW1uZzFCdHlkcmJCaklqcVhvWkRpdHFkN01PMlIwekVq?=
 =?utf-8?B?c0VsZzBEMDd3b3BhcStCeUs2Sng4YkRUREdMRDNDa2h0bERubmNJelp3Tjdp?=
 =?utf-8?Q?6mK6Pj9/6JqShFNT0GvMh8z+B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc2d250-5cf6-4a30-0e6e-08dcbc7986a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 15:55:31.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3LgJU96PAErp/JG0AI/4bwFTAEPh88zzn1y167ixj5XVAsSGXAZ6Jrnp7QUgJgXo3ZhTwSw01YZ9SmeonQfYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053

On 8/14/24 07:46, Kirill A. Shutemov wrote:
> The function init_transition_pgtable() maps the page with
> asm_acpi_mp_play_dead() into an identity mapping.
> 
> Replace manual page table initialization with kernel_ident_mapping_init()
> to avoid code duplication. Use x86_mapping_info::offset to get the page
> mapped at the correct location.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

A bit confusing on the last change. You have to understand how
kernel_ident_mapping_init() works in regards to supplying an offset
value and how to set that offset value up properly to get the kernel VA
address into the identity map. Otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 73 ++++++------------------------
>  1 file changed, 15 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index d5ef6215583b..78960b338be9 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -70,58 +70,6 @@ static void __init free_pgt_page(void *pgt, void *dummy)
>  	return memblock_free(pgt, PAGE_SIZE);
>  }
>  
> -/*
> - * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
> - * the same place as in the kernel page tables. asm_acpi_mp_play_dead() switches
> - * to the identity mapping and the function has be present at the same spot in
> - * the virtual address space before and after switching page tables.
> - */
> -static int __init init_transition_pgtable(pgd_t *pgd)
> -{
> -	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
> -	unsigned long vaddr, paddr;
> -	p4d_t *p4d;
> -	pud_t *pud;
> -	pmd_t *pmd;
> -	pte_t *pte;
> -
> -	vaddr = (unsigned long)asm_acpi_mp_play_dead;
> -	pgd += pgd_index(vaddr);
> -	if (!pgd_present(*pgd)) {
> -		p4d = (p4d_t *)alloc_pgt_page(NULL);
> -		if (!p4d)
> -			return -ENOMEM;
> -		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
> -	}
> -	p4d = p4d_offset(pgd, vaddr);
> -	if (!p4d_present(*p4d)) {
> -		pud = (pud_t *)alloc_pgt_page(NULL);
> -		if (!pud)
> -			return -ENOMEM;
> -		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
> -	}
> -	pud = pud_offset(p4d, vaddr);
> -	if (!pud_present(*pud)) {
> -		pmd = (pmd_t *)alloc_pgt_page(NULL);
> -		if (!pmd)
> -			return -ENOMEM;
> -		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
> -	}
> -	pmd = pmd_offset(pud, vaddr);
> -	if (!pmd_present(*pmd)) {
> -		pte = (pte_t *)alloc_pgt_page(NULL);
> -		if (!pte)
> -			return -ENOMEM;
> -		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
> -	}
> -	pte = pte_offset_kernel(pmd, vaddr);
> -
> -	paddr = __pa(vaddr);
> -	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
> -
> -	return 0;
> -}
> -
>  static int __init acpi_mp_setup_reset(u64 reset_vector)
>  {
>  	struct x86_mapping_info info = {
> @@ -130,6 +78,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
>  		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
>  		.kernpg_flag    = _KERNPG_TABLE_NOENC,
>  	};
> +	unsigned long mstart, mend;
>  	pgd_t *pgd;
>  
>  	pgd = alloc_pgt_page(NULL);
> @@ -137,8 +86,6 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
>  		return -ENOMEM;
>  
>  	for (int i = 0; i < nr_pfn_mapped; i++) {
> -		unsigned long mstart, mend;
> -
>  		mstart = pfn_mapped[i].start << PAGE_SHIFT;
>  		mend   = pfn_mapped[i].end << PAGE_SHIFT;
>  		if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
> @@ -147,14 +94,24 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
>  		}
>  	}
>  
> -	if (kernel_ident_mapping_init(&info, pgd,
> -				      PAGE_ALIGN_DOWN(reset_vector),
> -				      PAGE_ALIGN(reset_vector + 1))) {
> +	mstart = PAGE_ALIGN_DOWN(reset_vector);
> +	mend = mstart + PAGE_SIZE;
> +	if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
>  		kernel_ident_mapping_free(&info, pgd);
>  		return -ENOMEM;
>  	}
>  
> -	if (init_transition_pgtable(pgd)) {
> +	/*
> +	 * Make sure asm_acpi_mp_play_dead() is present in the identity mapping
> +	 * at the same place as in the kernel page tables.
> +	 * asm_acpi_mp_play_dead() switches to the identity mapping and the
> +	 * function has be present at the same spot in the virtual address space
> +	 * before and after switching page tables.
> +	 */
> +	info.offset = __START_KERNEL_map - phys_base;
> +	mstart = PAGE_ALIGN_DOWN(__pa(asm_acpi_mp_play_dead));
> +	mend = mstart + PAGE_SIZE;
> +	if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
>  		kernel_ident_mapping_free(&info, pgd);
>  		return -ENOMEM;
>  	}

