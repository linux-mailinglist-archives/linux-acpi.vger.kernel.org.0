Return-Path: <linux-acpi+bounces-19028-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EBC6AB79
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 17:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34C613A2D87
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8C827C842;
	Tue, 18 Nov 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJ6fysDp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8839270EBA;
	Tue, 18 Nov 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483418; cv=fail; b=fysTvJxi4GePnc0f1keaTiQE2ziSyjlFL2Dj1nb+dMukOHBXDj8Wkwey/u4vmJSA2q9SpeqvOi8sLErhaW0O1r4cfdJQyCHbxX1svVJTyhFD/F+SAH/WlbGi2fmLazVtVSdCEN9HtAvtOlEzAIP8V55H3Y6Nux4Tf315vBSJZFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483418; c=relaxed/simple;
	bh=tc+Vy9DCSnMf4+Hk3GVkB8TQJOQ+KMg81h3ZZPDss/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uhDr2P92uqKYpTtOgsRKQd2NYSo8IMehxwMN8i56f+ChhnZfi5XCwTO0ZPVNzwxatohaJwmDdvPkXzt+Z2kryzvS7y7B12Jw5pR9PgsxONH3AFXqcZNuOAdWXne7WboJbMXcxulR/SatUH3NkB0eVV4+CXV/mTiDTikn5YzQWZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJ6fysDp; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8iODaqQ+InIO9BrHKVetFhrhOxqkb2Ke5mzCSpMAhUyJRHfsrNeqEvkQi0X7Jqy9XbYPqvSJoASMrTdU/5+2JXY8rFdFbli8m5jZCIKoM9kvHfGfqIiqUGJ8xa8BAqJPXMPfwkJgM1i80/pEi3R9f03riKH2Y2xMaepjH9yKZOn7iIS3qfT16gH3BGF3Tv/z8rlZmDcGNgVqOwVeqRvLS9ya/ZzOuCReLoOLl59UWxw+3o887wMLI4tRTgQdeC5mD2EaM2588lVe5t+HM1vSUhRy3NG/i/XmGTC2saTSNxpD7iUzPvo8N8OnjSRl/vzwjtGMsAey31jyA/ZC69VwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6deo1Mtt6Un2nnWmHORPbJ1lXq3HNhvK5NUmye6waKI=;
 b=gTsnjigqUTy/yaCpZXnCFVEP/H8fN/NMi1sGJ6/UCw0lFHB220iIrJ1HHP0lI0a91JpMklTGaUq8qOC60k1pgyiC6SqoZspXPiJV3UK8UH8peae9cHo1wM/HAGCdQxXzhLJQZARjn0ATU6GOF9aJE8GkDl4luh4gLvKeb7JuF0tIBeLMgSWl+6dS/skW2KO27c0jYZjjzgD1SeUKtsvOhs7lYg4kks1ylEVnl3okFhbSHNR2GWciKIPKpuF5uP1Fc2icu3bFY6siEbeDcRnNhEbhPBQxaVESjFdOc5n4igufVDXnZdW4/o7Ows3WjkGO+0HwQBgExIjNDtsKcWmFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6deo1Mtt6Un2nnWmHORPbJ1lXq3HNhvK5NUmye6waKI=;
 b=iJ6fysDptWi5/rT5AMioCxIGaIhiIcLlXYRBiNobOLJOLgC5drBh7w5RXhfsMpAB8JZOrAeIvuu1+kMI/diiZkfQWduTAnT56ThOYWFAr6GXVmPjJFtqLEkYyVEYAOGqMAp/kKao+DWcHOhL15REXL3bzwQIFQdepFbx76pae0R4/31WFPnf7lBETxBvYuJWzzG0IbLzY+4tIVd8wZgMrqoyRdSZY6GXBc9QtCEfpcpRBQ1veiah8mf6MG77HgoTV69pgKnX0xB6U1BRfVmfgljdSLdatUnTvLHjMEuVLsZNfIYNQqLQlPQsxs+rEUR66uA+oKcchpgnYs6cpVuhvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Tue, 18 Nov 2025 16:30:11 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Tue, 18 Nov 2025
 16:30:11 +0000
Message-ID: <bef76508-830c-497d-a539-6110686b412f@nvidia.com>
Date: Tue, 18 Nov 2025 08:30:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/34] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use
 pptt cache as one structure
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-4-ben.horgan@arm.com>
 <88795f32-bfb7-4bec-b1fb-752b3e72ffbb@nvidia.com>
 <d31067ac-7400-4a0c-b1ed-5f1cc5ae9e1e@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <d31067ac-7400-4a0c-b1ed-5f1cc5ae9e1e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::27) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 38af6fb1-0b7f-4489-de9c-08de26bfbe5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UndlallSTW5uMVBKRWlIMHVVNjk3S0Q3dnRjS3Z3NHc0U1BjWDQ3MlZCcWli?=
 =?utf-8?B?ZjEyZUN5UmZzbzlHa0wzN3U0d0phTnhBTHpRV1BuUXY4UHIzWElta1djVmtp?=
 =?utf-8?B?MStranBlczFYSTU0eXJzTDFyZlJsdXkzQXBFUWt1a2J5QUhDOHVJbko0VUxR?=
 =?utf-8?B?bzZraUtaSXN4MGVGNzJmbmE0dFVzczVRWVBTbEJoTGUzL3Z6b1JlaTNQMk13?=
 =?utf-8?B?emphcnljS3lyRGx0bDBTd1M1MjNNMjlERndhb1FrckIzU2plRkNoZlZPK01Y?=
 =?utf-8?B?NmZDb3IrSVFWV3N1SkFmYnhNbXU3TU5iWFRtOVkxUEZQR2JSWUJWSmpUL0Za?=
 =?utf-8?B?cDZNQlJMUitOdTdtWG1kY01lK3kvcENCbUJFajlWMUVPL1lyNU5mSkJlcU5U?=
 =?utf-8?B?dEYyN2UvYkdxY1ZpeVN4MlE5eTljNExQTW8wQ283RWVCekd3Tkk4ZHBEeC9C?=
 =?utf-8?B?QzZrK1ludElaN0RSdVdUajFBZUpGS0JzSzZ4WmRBR3RXL1pMU1hiNTVIYVpn?=
 =?utf-8?B?ejNaU09Qa1JGQW5LdFhrV3hkOVVzVEhEazVlY3JRaE42THQ0TDdiMjloWnMz?=
 =?utf-8?B?bHpVdThGcmk0a01WRi9qUGppdWlVU0JzUnpuS3dGaVNPK29MdjNhTmRtZE4r?=
 =?utf-8?B?ajFjZkN2TzlobTFsUyt3VEtFU0xaZFdEZi9TU1BTL1F1d0dpOFFCN1ZUSjBY?=
 =?utf-8?B?R09RYjlyMHl3SG1iMm5UT0hmTkZxZVlSRkxtQlI5bXBKVzZneGg2MFI0d1pD?=
 =?utf-8?B?aGpYTTA2ZkZSSEJLQXVNQXQ1OUhtejZYZS93S3IzMjJ0Snh0b1grZEVPZUds?=
 =?utf-8?B?cjg5MlV0YU1ES2cwTjJsR1FXNjBMSjE2RGMzOWozb2N2TnhZRm1CMVk4ZC9S?=
 =?utf-8?B?VTJhVFcwK1ZEeUVkcXVlc010YkdYVG5uN2sxdHh6UVBXOUtOMTA5UEZKMzJB?=
 =?utf-8?B?NzN2VTkvbnRxbzI0MnNXckVob2RVVEtjZDVNRFM1RlNPa2JwK092TFdYWjZB?=
 =?utf-8?B?djNBV2N4aVhLNmNRUFVBNjRuaFhjU1p5RG1IenBsbTZjRjNRQ0x3VENkUTZj?=
 =?utf-8?B?YkNTbW84YVFMaTB2RnAyOU5RR1JRUHlIeG9zc2RRdjVneFNzZDJnVXlSQUVZ?=
 =?utf-8?B?R1BvNm4zNFdCMnBTL0daa2xpWmF3WkRBWk1nL0NXc3NFb280WFR2bnJnd1pH?=
 =?utf-8?B?bGhWZGdLZnpjTm5CTU9nT1NERE5XdCtWTHU4V1BFb05OSVY3bXN3N0RhVHBD?=
 =?utf-8?B?Z2F1d0lpUTNMTXpnT2FsNFZmV0JrSDAxckhxNDFlMnJNSTRaMEl0d3lyTWZD?=
 =?utf-8?B?a3VneVhjWDNkMXVRTEpTQnNVZ1NiNFNORXlYazJseGVTRWRCdU15YnRSNzZB?=
 =?utf-8?B?OFJPSVgybXBGTURvemVOU1dJWDFPY0k5UnF3b1B6aTc2Z0ZIaUZmWWUySFlG?=
 =?utf-8?B?QmdvK2VNdmNJVk5iQnhHNzJFaHZCZ0h1aFU0UFhWdnpNOWVXaU90anBJczRR?=
 =?utf-8?B?UHlyblJSOHhWbDVaSURoRTBZOWo3OEM4ZkpIVkg3ZzhMemR6L0MrbWF2TDdj?=
 =?utf-8?B?dTdGRk04NEN3Q0tiSkIyZDdEOW5EaDJFbklyTEdKYjJxRlZUSnhvaGF4cWZM?=
 =?utf-8?B?a0d6di83Rk5SMnN3VVVZNGF4aW5jT1VzNGVrR2hQd29DL1J1SmlsREFETnd3?=
 =?utf-8?B?UEs3cjlkOGJhME5Sa2VrdHRnK0g5OFgvV2N1U0JLMlZIdTYyL0RDa3dmOXpR?=
 =?utf-8?B?My8rTGZvb1grNlhxQjFNdDdFeWRDUHdTU1BhRkZya2dtbXMxcVc4NXFMOVl5?=
 =?utf-8?B?bDZQTlNsTzlNQUpNRUhGL3Y4ZXFrSjBvejFxejdyVDFaakhKbTA4WUJCM0NH?=
 =?utf-8?B?dVNCKzlmS3l3OGZoRXJKNWFCQjNmUGNRcGtUYlE5UW5MVktMNmVIRVE5bzVG?=
 =?utf-8?Q?l6bLRqT0DWw2T2KV/7rltUDz/zORZkBi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWQ4YWM1bFpDUU1HOVE4czBJSE8vZW5JbW1mVmlReVdNUFZROG5XaTJLREdY?=
 =?utf-8?B?aXlXSGZMUXlsbTNqeC9Lb3FuaUpsYXhZWXlFbFFNMjJkem9KakJ4TlU1Z0Vo?=
 =?utf-8?B?czVSbFZ6M3hkSW0rTGM2TDFpckx1ZmtHWnBiWFczc2cySHAxRmUxNkJ1Zi90?=
 =?utf-8?B?RXFDZittODdwK0UrWGl3K1VmZFFSeDF5RThCeXh2MVlGVkdod2RzcnhJdTJC?=
 =?utf-8?B?anhwM01IcS81ZFRURGttMkFzb1Nvam1lK1d3b25lS0xrU0g4UUNHRUgrTWo0?=
 =?utf-8?B?UFF2UGxzcktnbTdwb0NFTzFXdUxiRDBGYi80dHZONzhkUk5LMjJEZEU1c0dF?=
 =?utf-8?B?cGU5Sk5jY3BYR0ZKZlJYcUdNbWRjbzlyaVB0VUwvaTd1QXBsYmdKcXZMQm0z?=
 =?utf-8?B?ZWlJOVlDT0NCRmw5aUp6U3dTVnY3Uyt2ZU9FSllJRlpnUXBPZk5lQTJoZnRZ?=
 =?utf-8?B?dXhPUUhoRExSSVZvY3FabktJa1NiUmlodXRna2ppa0pQZUNPV2lMSHRJVWxP?=
 =?utf-8?B?dkZnWlQwZXFWZ0M4OXZMdWIwUldqVXN1b0Q5c05EdnRIZUJQOFNlTElXUzh2?=
 =?utf-8?B?Q1JHb0hxR054cldUTnFZanJuYkVkSkpjOHFRU3BFV3ZUTUtUUVdSK241c2hE?=
 =?utf-8?B?azJvd1JSWUpnRWc2Uk1EbC9kNlBCbStrWXNWaWgvdTZmMDU0eFByTGhhckZp?=
 =?utf-8?B?di9NTHNrd1IvUUIyYWdxUXpjRWQ4ckU5bmV0a0R3SEp2OE9nRjVUMENEbWpn?=
 =?utf-8?B?YTNieDBnZmxBRWlqQTZ2QnM1d3pDaFUwZGNNR3llU0xKN1hWV2lNMWIzMlZu?=
 =?utf-8?B?MEhYekxqVVhUMG8vOGk3TjAvUjh3OU1iRHF2UFF1emY3bWM2Y1pYMWV5U0Jk?=
 =?utf-8?B?R253OWlNUlJQL1JWUmJkTDdSYUo3dWNYRndTVzA5RUNDM3N4L2R6QzBGZ3NT?=
 =?utf-8?B?VGg3Um5hbnVpRkRHK2o4QUZMSlM4SWtBbkM2QUxSNWNpY2VwTjNxYSs4R0ov?=
 =?utf-8?B?SmdFSEFqc2tiZWh4VFZVbDh0VmNPaDdEUkJJMU9PcklqRmVmaDFUTUZPVDBJ?=
 =?utf-8?B?V0lXMFRPNnFKbXVuL1lNT2xsU3pJU1ZQa2MyL05OMXVDWlkwcWR2WjlQOS9m?=
 =?utf-8?B?TGI3Q1pSNCtsd0RvUjR1UldvdW9WTDQ0ZTVZaGZtd3VSMXdRWkNBa1U4OG1I?=
 =?utf-8?B?SjRVRm4yTWhkWWVBYXlzYTU4eklPSStFaGtxOGpHMUxZbDR2ZzBrSFhvZkZV?=
 =?utf-8?B?MVM5N3dtSXdQazZVeVladjMvejZnUTZNajgxVThDNDR0Z3k5S1dYRHVuR3lG?=
 =?utf-8?B?S3hxVHZFekRsQVo1RnRvc3J0Tzl5dEFocmQvZjJ4Z1ppYVpFVHJkNFRQTmM4?=
 =?utf-8?B?M3FTL3pJTENDMmdzTEpieWMxVng2a0k0NnpsRW8rb3JmSFFiRzlRVkthMXl5?=
 =?utf-8?B?MG9ud01Jc2JjSUxNaU1VeGM4N2liMVQ0cklvdWtVNlNQNGlOekNqMndybDQ4?=
 =?utf-8?B?T2FYVnlGOSsrUytTZE10RWVUeUZ2TFJLTS81bjhjZFJZWmwyUXJqZjFnbHBE?=
 =?utf-8?B?RU90aUN2NmduQnNXQkpaUE12QTduVnhES2xpME9mQ3J0QVRlcWU3SENnbU1G?=
 =?utf-8?B?dXgvVTc2cjdHTk1vdGdUaXFXVFFqUjBuSVBkU0IyOHZhcGdjaHowb0tab3dU?=
 =?utf-8?B?OTBNRkJpL0VyR0hoblp4VXZMS29qNjNrQndxMGxLeE1xMGR6UVhiWHhOZS9M?=
 =?utf-8?B?cEE3ZGhkWnBJU0E2ZS9XM2dsSnpidnV3WkM2aEJ4SCtVQ3NzNkdobnkxY2JW?=
 =?utf-8?B?WkUrcDR2dys5dEYwR0tuUjB4VCticGJPMWNIZm45dlNIU0lOMGFvRGtpT1BU?=
 =?utf-8?B?aVluQnNCTHExenc3MHhGQVN2eGo2bGtmU0ZqRkhhY3VtTGF2WHRJZ3d4OWF6?=
 =?utf-8?B?VnVrUTFGdUFvUW9rTDRkVVFYMEZwbzVLYmNlWDdIOTdDSnZhZDQwaGhMQXBS?=
 =?utf-8?B?dVg2TGUwcndhaFFjZFZQOGZ5VjJqVDlsVVhBWE55SmFQWHg0eStGTFBVV1E2?=
 =?utf-8?B?OHBQbC80REJLby9LRUJGaUduMzJBandjODdZZ2lka3Vhd0xuOE9VVWdydWl0?=
 =?utf-8?Q?cGDAY5RfhUlBGaVxLI7dVtl5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38af6fb1-0b7f-4489-de9c-08de26bfbe5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:30:10.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jgge8vTKlpdxi7e7lH5kk3NNpTvJLLkFMQZQ14Rps6o5eaFjXoxfTR6/RsKiKuVXVV1DH/wW19LEPwO3bFCU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076



On 11/18/25 02:57, Ben Horgan wrote:
> Hi Fenghua,
> 
> On 11/18/25 04:03, Fenghua Yu wrote:
>> Hi, Ben,
>>
>> On 11/17/25 08:59, Ben Horgan wrote:
>>> In actbl2.h, acpi_pptt_cache describes the fields in the original
>>> Cache Type Structure. In PPTT table version 3 a new field was added at
>>> the
>>> end, cache_id. This is described in acpi_pptt_cache_v1 but rather than
>>> including all v1 fields it just includes this one.
>>>
>>> In lieu of this being fixed in acpica, introduce
>>> acpi_pptt_cache_v1_full to
>>> contain all the fields of the Cache Type Structure . Update the existing
>>> code to use this new struct. This simplifies the code and removes a
>>> non-standard use of ACPI_ADD_PTR.
>>>
>>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>>> ---
>>> I have opened a pull request to acpica to update acpi_pptt_cache_v1 to
>>> include all fields. https://github.com/acpica/acpica/pull/1059
>>>
>>> Change since v4:
>>> Use fields directly in acpi_pptt_cache_v1_full
>>> Delay the casting
>>>
>>> Changes since v3:
>>> New patch
>>> ---
>>>    drivers/acpi/pptt.c | 47 +++++++++++++++++++++++++++++++++++----------
>>>    1 file changed, 37 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>> index 2856254e29d7..53fde9bd8140 100644
>>> --- a/drivers/acpi/pptt.c
>>> +++ b/drivers/acpi/pptt.c
>>> @@ -21,6 +21,25 @@
>>>    #include <linux/cacheinfo.h>
>>>    #include <acpi/processor.h>
>>>    +/*
>>> + * The acpi_pptt_cache_v1 in actbl2.h, which is imported from acpica,
>>> + * only contains the cache_id field rather than all the fields of the
>>> + * Cache Type Structure. Use this alternative structure until it is
>>> + * resolved in acpica.
>>> + */
>>> +struct acpi_pptt_cache_v1_full {
>>> +    struct acpi_subtable_header header;
>>> +    u16 reserved;
>>> +    u32 flags;
>>> +    u32 next_level_of_cache;
>>> +    u32 size;
>>> +    u32 number_of_sets;
>>> +    u8 associativity;
>>> +    u8 attributes;
>>> +    u16 line_size;
>>> +    u32 cache_id;
>>> +};
>>
>> Should "__packed" be added to this table?
> 
> Yes, I missed that.
> 

With this fixed,

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

>>
>> Should this table be defined in include/acpi/actbl2.h? Seems defining
>> the two cache tables separately in two places are not natural?
> 
> Indeed. The dificulty is that include/acpi/actbl2.h is generated from
> acpica. I propose a fix for this in the  pull request mentioned above:
> https://github.com/acpica/acpica/pull/1059 This extends
> acpi_pptt_cache_v1 to include all the fields in the new version of the
> cache type structure (not just cache_id).
> 
> One thing I could do if it looks like the acpica change will be accepted
> is to temporarily delete acpi_pptt_cache_v1 from include/acpi/actbl2.h
> and rename acpi_pptt_cache_v1_full in drivers/acpi/pptt.c to
> acpi_pptt_cache_v1. When include/acpi/actbl2.h is updated the conflict
> should be evident and the version in drivers/acpi/pptt.c can be dropped.
>   I'll keep it like it is for now though as this would be an api breaking
> change for acpica and the maintainers may prefer to handle this a
> different way.

Right. Thank you for your explanation!

-Fenghua

