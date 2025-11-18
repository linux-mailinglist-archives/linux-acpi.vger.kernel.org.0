Return-Path: <linux-acpi+bounces-18989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CA8C67384
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 05:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1529B29C32
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 04:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BB6274670;
	Tue, 18 Nov 2025 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nm3lXD1y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378011E86E;
	Tue, 18 Nov 2025 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439070; cv=fail; b=BAnkcWdrQUEj98k1uL+nawTBfHh8ex0UGFoWlaEJwIdxGf/YG8g1nP7atQHbHETyQjuaJXA4K3erFPFDANFrF7KL3OnWnEnEpDbCUbU2VpDtQ6R25T+YJ/Xefu4JBG+/2dk6S/OoMPJvoH6vUG5e8negXxUDpF0Jc0L3xpVGWi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439070; c=relaxed/simple;
	bh=dVy3dj3FAeU09jts7CMNLr5prdhNieWs0tPelMGXNw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NGLAEK0v+jotIMTTMvCDEsiI3RiBU61UqfZ9PClxUQFzY9C5/Dxjkabu/OF0eLm5FpcpwwHPATiFk4NfRUvG81FVA8OVOzlCaw9KoOGPMfl990nM5NHa+zGOvJmr1NYm60vp7IZJ3NcdHn4lcW4i2/DjWtRleUvwiUHJJMmLkAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nm3lXD1y; arc=fail smtp.client-ip=40.93.196.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYrPdaOaBfPuAj6XDdGPO0grQl8yxwlI1elqLmAc+NK1mOK+q0r+Uknvd1PhWzB4giFSrCpL0ooGz4LayGoUwcLDBnmWoplz3x9+Vkn9tQLask3h68PDCx4bdGcLwFd9NC89QTN57QY8ERcQeLUp9S2DPGWZZOqb1bdbCGcCkrLkYcfda63994uNdrByc9fBhJaegiD1zP9wJ0vcZU2ewx+m7fP7WzH1bz0f+MBlervQOy+ZfQ1fKYMtOCGLqieiNukfTUC7Kp2Fy1qYmtM/UnhaZqCjgOWb5lRiFnqHDZDvQfUKhBUYwsSmVXmJuMVSTjDUPMIaHmXvM4LBsmDsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJAAZ8QMh2+1ObzRefRAZZ/DtTvKi8IFcC7MmBnJUYY=;
 b=Wyb5UYGrtoGlBf6k3qugyvyGc2igVLC4Oyck2LQx5JUNFrhyxI4r6P9jib5TUyMSYHf9XYtQvBfmoAsB4prhPfzKbRp+WREe8banoJpCG0duVNARxQZMOi1CJydCksVfrBeYzchBflK9iOKynRBtDALrTVU5x+gtKAuoAhHobiRZAU2WtZWgNLfGkBXCXDqpyGBOQImCsVn47LkYczRqZdAUvIerpjzxaOHmWRAUL9EZMWewtmPdPim3ZlXik1ZsmXaEkXHvtOCTvSobKuWIZqDo3oKlV3C8yVW/UWOXY9pP7pmADJwRp87VgyCp1pweUTtOXKPg0QnnR/iFpQBymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJAAZ8QMh2+1ObzRefRAZZ/DtTvKi8IFcC7MmBnJUYY=;
 b=nm3lXD1yDOSw6ub3PVUhvkrIlDcU8bqgBbYzduXA0QWmgyNkqJqg62oFHcMzkR1jVldn7Shk9wSi4+s/PpeshV5wB4hTJmRhoh8o0UMR1dVpX2hSDSslimqV4G1mlhX0/N0ygR7J9UceEP8mjtGBeV4ehTJYsyBF/7XU9IyCp3umk/vdf7pc0ictObvPivQuAyRyGGTNefVdDPojkFmWjWqkhK6owxlW7ZVFAWe4uvNxkCeFZ/bgZuaNNq6jT+2MHKdZJE9iSNmv/MmCd7RlgZyAitXLY5KbUIlmXKQbmrhX9W4L7DoiVdQjMyK0X4S8zOoY/pc7ztSepbF/q2/3sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.23; Tue, 18 Nov 2025 04:11:05 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Tue, 18 Nov 2025
 04:11:05 +0000
Message-ID: <d6f0c0df-4807-4d60-a1eb-1939e6173f15@nvidia.com>
Date: Mon, 17 Nov 2025 20:11:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/34] arm_mpam: Add the class and component structures
 for firmware described ris
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-12-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-12-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 47581b81-1404-42bc-bfd1-08de26587e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzVyWUFYVkNVaUw2UHJYUE1kRFdDZ2dnUisyR1dWdXQ3OENpUnFXaW1CdEdy?=
 =?utf-8?B?NUt5QjNWYko0Z2NybTFLSHJDRXpWZGFJU2U0cE54NEJlNlgwcTdqTjR1YXRN?=
 =?utf-8?B?NEFyZVV0d1kweFFNNDc4bmRsV1hyTUVDRm9JaXRFYnNpRC9Md0xZeThGeDQv?=
 =?utf-8?B?aTFQK2txVklNSUJDanEvbHFUNzhNS1BKY082YlFQMzZvazFuNUdZZ2RxSERU?=
 =?utf-8?B?MkhIbG15RGFMaUN3UFRZWVBjTDBzZzlNbFEwRTM0UTVQTHZRdTRIWWVCazhu?=
 =?utf-8?B?cWJ1UE85Slc3cnA2NHpTZlFOTlRlK3NyUWp6UVBhdXBYa2ZhRHBYQ1oxZUkr?=
 =?utf-8?B?YTlIRDJnZERnSGxJNTRqZFAzMlpZeWJ4ekR6UzRNMFFwK3U3Z3A5c1l6d0VM?=
 =?utf-8?B?Wk5GVUoydUtuc0tsRkhNQkpjbSsvWldxS3l1MVY3OUgveU9kQlFFM0o0aDBU?=
 =?utf-8?B?RE5BRjZJN0tzZGRzZ29nUmg2RGFOODE1Y01SSmtFWFlMMmpjS1dxQlJpNE5t?=
 =?utf-8?B?ZWxHRGUvSzJDNEIzZjhydEViZjFsSlNjWDc4d0xGTzZZRGdOTXFqUE5TVTRz?=
 =?utf-8?B?TGN5U3ZCOE90T1JRNkluZnZMRllVTGNhSWNCVlJid08yV1RlMVU0ckoyVFE5?=
 =?utf-8?B?dnhENEU4aitEbDBJQVQrTXZzbjU3a0QzZ0hrQnhoNy9yMWNNMDJsUkNuZ2JC?=
 =?utf-8?B?NWU3cXNRUEtld050WTdYYzUxaVRBYm1aa0dRZURGemJ1SFMxTUdhWTFpMmxq?=
 =?utf-8?B?V09sOHQ3VWRXWWwvUWJta2dOeGZBbzZTTHdhbVVYV2taaUR3ampHaWdlM3dj?=
 =?utf-8?B?eVd5dWIwSW9hVXAzUytJdTROd0ZqWmtkWlpHSFdkMVRxY1VpSUcwZ0pzbmNn?=
 =?utf-8?B?MDM1QlBWOUZKTkl6N2pBbittdW1NSnJteFBzUVF6WUQ3SVJtR1Nqc0l3bldF?=
 =?utf-8?B?a1dhZFFTRUxoQVdhL2xUTWlGTnBDb1MxNCtMeGtVREs5aWVvT1d2eFN0QmJL?=
 =?utf-8?B?clVEMjdpbHN1amE4elhndVgzekJsNXJwY2JtWEtGcXNXVkJKNUNrLzNMenB3?=
 =?utf-8?B?Q2NVVHlDbUtlcWs2N09NaE82R3d6bU1MT3djRCtzbmplVE53cEllZWlIblp0?=
 =?utf-8?B?WUk0SmFMMGdHQU9iVElwMkpFOWZqL1doMmlKVmgzM1FNNXlBdTlObzJDN0hH?=
 =?utf-8?B?aXdEa0I0M1NOSE4zNlZNZkRiY0ZRemI1cnBTdDdmaDlUV0pHOTFHNFRUV09x?=
 =?utf-8?B?SGpqRmVIWDBvUU4xdDdIb2tEbmluSDZTSnFDTjdLRE5HeWY5aGU4ZjdXYWJQ?=
 =?utf-8?B?anZJSkdBM1ZPRmttOGFQeG02R05SbGN4TFEray8yKzlzdnhGZThHQzlTZUJG?=
 =?utf-8?B?d1FPaHhva1JZYlBZZnowbXVXOVNwNUk5L1RublorZzJYS0dyWE15cWVOdE4w?=
 =?utf-8?B?OVhESWZDMEZGN0tvTXZsNW5Kc1V1bXdJbE0zU0pJTWxQT0g2UENLQndEbHFS?=
 =?utf-8?B?RjJZWGZDRTBjZTZLYVl1cmJKd1BEYTkveTQ3Z0FGZllHYkdPVmdJeVBnRWxy?=
 =?utf-8?B?UVdCR0phL2M5N2N2TlhOVHJzdWpTd2VuNUpWZDM0b0xId0dMZSt1RU0yS085?=
 =?utf-8?B?S2ZwaVorQ3NTWXdxSURndUJqTWd2aUhwMGExV2MyVW1td0dZTW5CSmltUkMw?=
 =?utf-8?B?S1dsblVQTlFBUUh0SG8vL0VOcWw1cjFqNHA3RVF6b2lvcnpxNDlOZnJYQ0tu?=
 =?utf-8?B?TFE5YmRUQW5YSS9lS01NNjl3enRsaGJPcUM5TVRBbDBFYVJEYkJlUkJhL2l0?=
 =?utf-8?B?STV3M0NrSEsxMldpbk01TThSUE51V0NiMGtuNzQ1ek05ZVQzVDdJTC9OMklo?=
 =?utf-8?B?Mzdhb1hyZklEdnB5SG1OWWozVmZCbVdRYTlhTERFYU5XaVVzOVJpQTIvVjBM?=
 =?utf-8?Q?wvsGja/GoTQOTdz5CRAqUqtw2RgaGc00?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlFzVkk1OHVqN2RmWXFqQ2JrZFFBdng2VGt6eFdkVE1OaHA0VjZ5aS93Y3hT?=
 =?utf-8?B?VVVkOE1YY2ZPblF3UUNVYm9FTTI4YTg2azE3eE5WYUc4YS9LL0pVREp1cmQ3?=
 =?utf-8?B?eEg2eDUyRUtQNmxNb01SUlV5QVZ1Y0VvZ3pXaGxtaW4vdnlQS0xpeWFQb0pa?=
 =?utf-8?B?L2svRFJrTGF4Z2htZGN4bUtvNTdBUnhwTC9wdHdiNmhhNnpoQ0JaRkNDQ2sy?=
 =?utf-8?B?ZDdXNVB2a2FHdjBQSWFMTVgrMENTRXJaUCtaUXBkQVBYRlFmWTgyU3hJLy9B?=
 =?utf-8?B?TWs1ckRKYkF4cGhJdThTMGJFNWxKcnNCTmQzaXJ0bEphZjYrTm9LM2grakFC?=
 =?utf-8?B?THBDSC9NV2VJbStVOTduRkJweGJhWVVWNGFWQXJFdHZnQndQaldFNDdmS1Rl?=
 =?utf-8?B?bnZBQSszUHRRQWYrU3UwbTNpcnVQS2RqL0dDYS9UenZMK0ZUNy9JakVqcWZr?=
 =?utf-8?B?UzRVd2N5dDFqV1U3RmE0ZG5ySC9lZEpteEozcUdncEdQY3VtaUVvYzNUaEtv?=
 =?utf-8?B?WEc0MVk1WEI0R2N5bXlTTVdsSXVXNDBHNWd1MmJ2YUNqOVFncXFZaGJ4STJD?=
 =?utf-8?B?N1BKQXFSYytsMTlUa0pzMHdxZ0pxR2QyRWxpTklaOG9mQXRMaGRpais3Um1H?=
 =?utf-8?B?UnlmTlhaU3VwMDBla2l2cVAxTjJKS01UUDMxcXB3S25ZU2tlMkVPS2NYOTRp?=
 =?utf-8?B?YmVRcFlzYnVnaEdlSituTU00ZnVnVkZ1OE9IQUpVd0lCejhnR3ZPVnFDcFZy?=
 =?utf-8?B?VlRtTHRvRWk4cEI1bkY0cHFRNUdlWmlqRXo0eDdGNnpKc1k5TFcrL2xqZGpq?=
 =?utf-8?B?U29YWTB0TVRmaEc2eXp0SXFaSDVMWFRRSjJVVUI5bVlSL3dkbzBqYS96UktR?=
 =?utf-8?B?dmNQUFIvb2NhdWNHd3F6TG5IOUh3YUc2dm1IUk9jdG1iUk9kSUtpd2dnSTRX?=
 =?utf-8?B?Nmgra3RYTHJpZXJET05TYnlVZ3FDOUZPdmhheTg4aXBsRWFQUEZOWXljR20v?=
 =?utf-8?B?b0kxWkhtc05ZSUNERVhZcEVZdzc3dDNFY3pvYTYvYTRXUUVnOXdPZElGb3dY?=
 =?utf-8?B?S0FUR3IyRnhJeDN3NkVxRkR0WFNLdmxzMUlUVWJFclZnZzc2cW9qMUg2ZTdC?=
 =?utf-8?B?RjB4Yi90cTJSQ0xaV2hOVldOTlYveU4ybkxMVjBiS0g3U2poZlU4L2ZpMVJJ?=
 =?utf-8?B?QjM3LzhSSlhVb3cyZnZ5RDB2b1Z4T1ZQa3ZZNU5WRUpWSTBYOEFPaUFTQWl0?=
 =?utf-8?B?am9abnJlR1ZBR2hQNVRUU3hkdGdPc2c1OGR5ZjhYS1J5VUpPWGpTSm42Ungw?=
 =?utf-8?B?cTdTQ29wM1d2OXNwcUpYcDVQZ3c2bEFXKzRvRXZXVGlYZXNjQmljSWp3M2hv?=
 =?utf-8?B?amVtbmNQbXBHNmpscVk2RVF6WVBFQVlROERnbFVNT0R0MTlGc0dLQ1EwSEow?=
 =?utf-8?B?OGdzeklTVUtqOG5zZ0N1RGVjK0V0WTYxbVU3RzVnTm9keDhnVG1WZXdMQXIy?=
 =?utf-8?B?enlTa1ppaU1oOXZkMmhnRFNMR2xISkppb2tCMVN1VFN6ODlBckZaSjFNZ2tD?=
 =?utf-8?B?dzVSTEt1SkZDOUgvc2FMOHNCT2Q3YTdqMG5Td1ptUCtVSHhiZnljdDdOeU1E?=
 =?utf-8?B?a1lsNnVkWHFqRnBESTcxNXhZTTBhL2hZU2VwYU1oUzA1NW1YdGVWb1NleE8w?=
 =?utf-8?B?cWhzdkFpY3A1NXF3b1RqSjFJemtwV0hBN3RjMWN2VzJWQ3U5djJuSkJxK0N3?=
 =?utf-8?B?TnFyWGMzaVZDeUhwb282aVZwMWlEZ3lmS01tcmdRdlpjMDVoQVBUYjErRzEv?=
 =?utf-8?B?emhrWDQ0bmlsejVsMnBsRmFRaEZhQnpDZUpESi84M1RRNHdVL3BjRjRYaExI?=
 =?utf-8?B?TlhBcHdIemxsY2VUUFdYM3ptWGd1ZFNRak9BQXcyN01QVHJKSmluY3ZlalV1?=
 =?utf-8?B?dWJmZVJnakdCUGxxdFpxcHUyZFFyZjBaUDJTaDF6dXlRZUhnS3RJQ0w4MWxn?=
 =?utf-8?B?eTRBaERaK1hCU3p5cUt5RFNjbS95dmhmMVA5SzZ0Z2xBb2NXN0JjQm9IRG0z?=
 =?utf-8?B?ZTZSSWxVVnVHUzZ6TmVJQ1Rva29keWhxZHZ6V0pNVldDVUUwWi9pVlFpLzFX?=
 =?utf-8?Q?zQ4uQmGTA138NLsWj7Jvp0MRc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47581b81-1404-42bc-bfd1-08de26587e12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 04:11:04.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTC6Vt3K8dD4eNV52aaz7HAwS25AqDaYMEzKYiCNdtGZP7vBKoaSFMW5ZsA/o0FinAdaXDfNj3fL3kEzLXMqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294



On 11/17/25 08:59, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> An MSC is a container of resources, each identified by their RIS index.
> Some RIS are described by firmware to provide their position in the system.
> Others are discovered when the driver probes the hardware.
> 
> To configure a resource it needs to be found by its class, e.g. 'L2'.
> There are two kinds of grouping, a class is a set of components, which
> are visible to user-space as there are likely to be multiple instances
> of the L2 cache. (e.g. one per cluster or package)
> 
> Add support for creating and destroying structures to allow a hierarchy
> of resources to be created.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

