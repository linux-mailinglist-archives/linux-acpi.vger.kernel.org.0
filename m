Return-Path: <linux-acpi+bounces-17497-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CFABB27F7
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 07:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61540422AD6
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 05:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76AE42056;
	Thu,  2 Oct 2025 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OLULUWzu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7A288AD;
	Thu,  2 Oct 2025 05:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759381422; cv=fail; b=pkB8DevGceTG+hNtPx6bRIyQmw8mMMgx4f2ANQ9tGHD/aGX0Pe//YRwiJyh/8BdsBsK2OE4zfbGvxb81lvYZ00HnGDHJN8j9tN0oAImTd88NGxhRfZv8JNGOPpmsPXELrNcvUpqOpztS7hLcPXNNJl9l67drmq+hktloyHi1GI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759381422; c=relaxed/simple;
	bh=VhyOp9Tr4DEDeGQCv0Zwwmkzyo6e111zPLl7tr2y/Gg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FQiZ41m+Zvn/UZOv/FzRQACnmb0e0pPFlPPE24hunm9eyGgfQPaw4LwIPLwRNNwcJgf9ffbTYInezvHRUpcehBOpS8uuxMOQGSw/A3o3/4OSFEGIx1G+BC/wip5QNRjscU9RGwoPZ1ZkxD7vSyThoYvODK0IDIe6io421It/TFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OLULUWzu; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRKDQasi82/I1gN243lAgFR714jBd9KChS5g5kPmINyrv+5U0+Bfe6ht+e9UmM7e6fzrKmr8x4N1gG6EvxmGaxUXEKiL5Hh0S0ENDbwc4XelUz4uWA3WljY5hc+K4Z8QFptLf9ziAFSkYT8DfiKbLhriLn+w4WqN3p7aYWMcIC7Lwk22OcjCyAKu8hP5m/+GRSeeZWpn+mrxyNtIc3+6P9jZBIHOkTejYXg8oxUhX4/ffa1QBvLLlV74tF/3hPdEvSkezzKnl0qXmdvzeiWj1z22Q5qLAnKlnX1AHKxn2y34xMlI58u7ascZQYk4kb6hXPrkH28qiX1KeMtbI0SVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMkCyBdk9PECzXs6gZ/N17zKh5eFT65rtzdmnIWS5N8=;
 b=wVAN/S3YRRIFwkWWYWyJnC5Dxs2ZTGjfqlUZcpgswVwyJeJXjKp1hm9Xf5zH2+n+9fM1i3T+vHuKV1GYE9PczNJH2SGnJW9atZtPErU8GPwp9zW0XMDJ9up24CGNL0s7tMjyrLQ1TB8Pah1rm1MAT+gCsvlym8Uqq6J5NK2dy17VGJ/kbG3SZpgyJ1N9r97Xvdux1tym4CGNw9ysoKl6Fi4aNIdKscKaBa0TUvgqNeeFnvqh5oCbMT7HDvbR8bdqmSwVqaLyLwgTwViw5KPZ/5XNf9H3PMbSGNlpBcRK7dOwYAeX9fR8cFy5e7yOI/qm8QiYJCrOTcvGsyma0o9ioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMkCyBdk9PECzXs6gZ/N17zKh5eFT65rtzdmnIWS5N8=;
 b=OLULUWzuXbc3Nb8Y02/Ld4ZZ4cbFha+dc/wIrjfkUY5Q22yWHepn5T0BIOP4bhbQHkhr5T6D6H/F25cGvG/fpAE1z5RyZyK/0JGFcF3Bx2HLYqshHNVYO/lLR+g9XV4/wF82jhfjgA4U0QMoFfQA8hF7oeG7y7VH7YKKEMvJWAcRukqT8U5h4P1Q3S3tRrrBY8crzhB52EyTc0qLmnDKqWJgIYNKn3Lj64CWUJEMyWbSB/B3UbjyJbIo3O4L8A3ja6ABlbJFc1NRTOsMbeY9lkJfGEfJKifrP7kkU8EAFYHp48U+DyUPMYW87oZgTgGR1FQVSKJ5plearbJV3HRZ3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 05:03:36 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 05:03:36 +0000
Message-ID: <094cc278-d488-4d22-a1f4-73616f4b99d5@nvidia.com>
Date: Wed, 1 Oct 2025 22:03:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a cache_id
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-5-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-5-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:a03:40::44) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: b268bdc3-a68b-4772-1958-08de01710b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEhiaENYU1dUOWNPZVdudHhwTE1XVkZsZVlrNlgveFkzZ0dKVzYwdXRybno0?=
 =?utf-8?B?OUU3ckI1SFNWWFZvWlFRUXRGYXUzNFdvQ2JaUUMwdDNUNnZBalZNa2NsWXNa?=
 =?utf-8?B?RGFMQ3IrS0k5SkRmRm8xUmJWcFlQVkFlL2U3RENPeG0zVWsycmxxeTE3YXNN?=
 =?utf-8?B?ZXA4VGoyamozUDY5Si80bzBHd3g3Q2xLRktwMlV0VzZxSmZhUm5kV2FVSjdn?=
 =?utf-8?B?V0p3TzZ0b1piMnAzOEMvQlhWQnAwQ1o5Q3lnYVZFNElmVSs5SytlYnNuQXFE?=
 =?utf-8?B?S3pmc3l5U3paYldCSHVIRDBkTCtBVjFYMUNzMkFrT29ZV0h3ZnlVVUtvTFhm?=
 =?utf-8?B?d2xqMDJOaXkvV2U0NjdJbEtMMnl2eTdCNlRVMUQzZjhYVGhhN0pXb0J4Y3FF?=
 =?utf-8?B?WXVPek0vSnBUbkVGN2o4MG9OZStSS1NvbXNuVjN3MDgzNzlrMUFhOWtxejg2?=
 =?utf-8?B?b3ZwZzdkNko2QWN2eW0yR0p2V1BtZ1pBVS9LMEY4UVV4b1oxNHhVREMzckRI?=
 =?utf-8?B?bHN0ZFdUa3d3bUFQWWtyUDdzTXVORnd5TjZMcGVSbDFVYjlON3lCZDUvcUk4?=
 =?utf-8?B?Kys2MXVpUVV2ZGJPcGZTYWxZa3ZQVUVidGk1aFhhN3R4ODBPTEx1elRzL2RV?=
 =?utf-8?B?YkFQenY1STZ3MnpjYWk4SzZjRlkrZUJFcjJmUld2MVVoVmpmR0lXNlFNZ1h5?=
 =?utf-8?B?aUJyV1IyWEhpbTRXZ2ViQTdvK3ZlcDY0S0ZEYUYwV202RXg2OWRwN3ZVY1hX?=
 =?utf-8?B?R2IwSWlrOVNqNzlaTzdFZndTZWc3TElkQ25qeW9iSVAwcjN4b2NuM2J0SHZC?=
 =?utf-8?B?dThhOG9qQlJpc2hac0FpYnpYS3lWM3BIQUxpU1V1WDhLVHFNQjdPSlI2a2lS?=
 =?utf-8?B?akkrcGd2TzFkdVJWeGEraTBUMTB4dXVYdzJwOW55VWkwZnFEaFNSdlkrdEtI?=
 =?utf-8?B?ZXhLKzZ0SWJKaE5ka0tkelRJMmNEbVRXaGVRd0tVT3pya3krSE05YldKdmhk?=
 =?utf-8?B?RUhwNkliUEJaMDZMMmtyRWNMdzFqR2IrcGVDS2hoUEdBSVVDYTg3ejdqWkhJ?=
 =?utf-8?B?TU44SnM3TXJzQnB1NXJnZkp4ZHZ2TTlFZExaLzdZNmJvTitnSHpqYXU5Z01k?=
 =?utf-8?B?amhmNDJWK2hQbnBGN1dITlFDS2s2M2NEais4SjE1Tk9LV2RDRmoybzdVWHN0?=
 =?utf-8?B?ODBHUng1dFlTbEk0U2k4eCsxcTk2MHdCakw2UnVkZXMxcUVWK3B3dzlldmtw?=
 =?utf-8?B?NmNFV0NtUlVsLzFwTnFOOXVrbUxDcCtOMkp5YVRQZ1FYNUtrOFd0WW1MZGFI?=
 =?utf-8?B?SWpaNDRQQnRNNEx0Z1RiejZiWjdWcmNRc01mb2hMYWxUQ3JBcFh2QXorWWNx?=
 =?utf-8?B?d3Y1S1BNZGhqTi9OMmVybXBNTnFvVFBqSmNsR1dPZkdwK1djMHV1aVJMckt1?=
 =?utf-8?B?ME5ENUVsZnJmWFpRT2lmSEtvb3orUkZSSVNDcEd3bDlJSmtMV0gyWm9KT0Vi?=
 =?utf-8?B?VWdzSVphMjV2RktLMU0rNVkvNk1nRXVYc1M4WTNob2FJTTNXV0xOeGJ1Wmp3?=
 =?utf-8?B?SEJ3UEY1QUhTdjRpdnVISW1tWUIzR01PMnNlSmttTVcydVo2RVFjWTlac2R1?=
 =?utf-8?B?cnByZUZzemdTVUZlaldmWGdhYWt0Ui9WV2x0djFXc2ViUXhmRGdraGx5VmFl?=
 =?utf-8?B?bmRRTTAzVU55WnRod0w2YnE5ZHhRZE5RRXBwNTEzMWtMQ2duMUNXTEpPMk9n?=
 =?utf-8?B?UkdoZlpRQmp4OHdSa0wyRkxRNjRyU09CYWV4bkhpMVBYVHZNWEpGbkdibmJP?=
 =?utf-8?B?YjZVaTVaejQ3UkdGQzNqNVhKZTNVZGVpTVpDOHV0NXkxWC9UbFlwRmRIQllr?=
 =?utf-8?B?dGJnTmM1OWJYZWxjV1dITmg0QTVxL1FUWE1JTmpmNWRqUkVmOVVWdllpZk5T?=
 =?utf-8?Q?/x716rTvUV1vUoyXge7PPWvVpLf4ZLlX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2V4ZUwxTklNaEVyTzFXVlN4YUlZRzlJaThiL2Q4clRwU3dHMmdLb1M0RzNx?=
 =?utf-8?B?OXUyejZGdDVVR3I0TkRid1RFZVN3RGhnVUZiVVhSOTI0WG9vVkFxM3ZRN05v?=
 =?utf-8?B?SFl5SldpSHNNQzA4blB4QmJZRldqbXIyYjVDT0I2R3l6NEhZZkJaOFZZTlJE?=
 =?utf-8?B?SVFkMkh4N00wZzZHQTdxMGN0c3hveWdOQ3h2UXd6cTJKbDlIeWRueUNNVVVr?=
 =?utf-8?B?aG5sMHpmVDN1bWRJc3VNbmo2N2ZJSHl2UVN2bkszWDNaekVTMFQ3czZIVXBJ?=
 =?utf-8?B?S3NiZlY1YkgyUmRUcHp5OVpkVTdqYkxHWGVUMVJZYldKU2JlUHhQTk1VSDRa?=
 =?utf-8?B?aEgrc2FNbHo4ZnhiWWNJck9IMCt6Nmg5SUFDQnNNS3V4N0E0YzdjN2lHakFw?=
 =?utf-8?B?bHdoUzlNR2ptUGhuVmxqVTg1ckJ4TGZGUWw4WE1EVkFTODRjVmhnbGF5Q1Az?=
 =?utf-8?B?MzE1eHJCKzBZSytHTDFBY1owaHR0VmQzMUc0VlpBVzJKZkJGMzFYajBTaUhS?=
 =?utf-8?B?SzFyR3BZR1cxOVNtSVhFZnZ5WGhvYmZBaUxOYlF4cm9MU3JsVnpyYW1UMlNG?=
 =?utf-8?B?ejBGVjNUMXRZdStFalNoaDBpRitFUkhWNENRUnRjUUlSb3RXb05qR05PbUpY?=
 =?utf-8?B?MTYwcEp5Z1d0ZVRwMi9KQ1FpTVQ4YUx2a3FWK2ZZdGxjekdUekQ4ay9OU21H?=
 =?utf-8?B?OWZjd0dQdWZ6MlRyMUF0ZkFxVWFreHJTOFRId1JZNllvVDQ4bGJxSzVwcEoz?=
 =?utf-8?B?OHZUcnUwbE5SMGtENUI3MGowZWFKNXJGbmJHUDFYWGhmMHVFY1kyZG15Q2xv?=
 =?utf-8?B?WHhJV05jSmZrZlUrRnRiU0VkY0xVaXJpLytQSEFUM1QxUGNsdWZTakVPek9Y?=
 =?utf-8?B?SGpOUFVqZCswaVVEM09VVXNjUngvQ3N4bHpGd09NTHFwYVR0TGMvN3UyNFVx?=
 =?utf-8?B?Sno5T3lRNFhzb3BPdmNIL2lrM0VJTkg4bFFFc3dJclRGVS82WmRqMlNQTEJp?=
 =?utf-8?B?TUg1ZXlKOXp3ODZKQ3U1QWh6OVNJRmJiV21hWng0T3ZMUzkxbm1SRS9sQ0hF?=
 =?utf-8?B?K25Uc1BDUDUycWtLcEZ5YlQ5djliWjlEK1QzeUFNNHZxUnNtaWlYVlAxKzhQ?=
 =?utf-8?B?OFlodE01MUo3aklSb0RYWlBIYUxXdTY5VmhuSWlIWTVzdlBRaUozZUNYQ0xz?=
 =?utf-8?B?WEZFbnlwbDducWJ3Y2ZFRnJKOVZ3cWNqRGd6TGRMNTV2dVlMblZjU2p5dXNp?=
 =?utf-8?B?b3dUNlNUQmNHb2xuVmtaZlc3NFVoR2NPYzNnNmtrczYwbCtoWXlrMTA4Y2Y0?=
 =?utf-8?B?MVU0OFE2eGxMR0R2M3d3WFJWSlFmUXh5ZEtoK3d6U2xGV0Q2RWN1dmdzaGJW?=
 =?utf-8?B?SnVHaG53K2twM3VQOHFVakQvcVVGNXQ3bXNPVHNkeWdHdDRsUTNRb2tPQUk4?=
 =?utf-8?B?VWZXUHNtTnJOMkFjT3IrRDNGSnBYcVNlVVR0U0pIbm5LYk41SkZERkJmcjM1?=
 =?utf-8?B?M245MXNvM2ErcTgzdmhjYUl3S05FTmJZM2lYUHBSSkVobkRKN21CMWloWmo5?=
 =?utf-8?B?eXhHajgzUEx5QXpVeVFYclhJbGxwM05RcFo1cHR3WGwyeERGUFRZQ1JQVFU1?=
 =?utf-8?B?VUdDdWR3aHdaL1ZNNFhwdjZYM3lpQ2pDSXNubVlCVjNQdDV1QVZQRjNUUk5B?=
 =?utf-8?B?TDFjR1hib1l4dnFiSm1lMGFnM0I5L3hyS2Frb0pBZUQwaXAxYWIzWFhIL3Ft?=
 =?utf-8?B?MW10bnBVK0g0MkxOaXpyYjlHOW5jSVlEdFdsM0xUWWxUUkRGR2NnTVNlbEp2?=
 =?utf-8?B?bjhaRkdNdkt1RDBSNThZWkQ5Y2VTM09rQmdvQWZPWjVYWkQwRkhmVkN4M3Jq?=
 =?utf-8?B?YXlSOCtqbDhMUjV5VzlzK2dvby9QejYzWS8wTWJ4ejVoZ280eHFKN3JRRkZZ?=
 =?utf-8?B?RFhqaSswSW8wZGs4NE1NaTBvTTZqVjNqUXVOMlpkTzNvUWlUZ1dFVCtVZi9R?=
 =?utf-8?B?emZoZGpZczQvb0hqMDVRTk9oVFk3M1pQQ1VqdXZISURrbEVFbnNLcVJXTG9K?=
 =?utf-8?B?TUJXZzMxQXBlQnA5bytoWEZpekxUc1VCSlN1MEZHRWZhMFRtN2ZJME9pYVBV?=
 =?utf-8?Q?O9pZMIRq+BOa8BSblGPVkrVbT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b268bdc3-a68b-4772-1958-08de01710b28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 05:03:36.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHv3oWRvOuEZ8uacbWC6MhUH94SEObX7JiMalMvf0uutwc+rQFalGlmXfcipiFuoB04EDkzv0sdRztDK/r0nTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221

Hi, James,

On 9/10/25 13:42, James Morse wrote:
> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
>
> The driver needs to know which CPUs are associated with the cache.
> The CPUs may not all be online, so cacheinfo does not have the
> information.
>
> Add a helper to pull this information out of the PPTT.
>
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Changes since v1:
>   * Added punctuation to the commit message.
>   * Removed a comment about an alternative implementaion.
>   * Made the loop continue with a warning if a CPU is missing from the PPTT.
>
> Changes since RFC:
>   * acpi_count_levels() now returns a value.
>   * Converted the table-get stuff to use Jonathan's cleanup helper.
>   * Dropped Sudeep's Review tag due to the cleanup change.
> ---
>   drivers/acpi/pptt.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  6 +++++
>   2 files changed, 65 insertions(+)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index c5f2a51d280b..c379a9952b00 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -966,3 +966,62 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>   
>   	return -ENOENT;
>   }
> +
> +/**
> + * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
> + *					   specified cache
> + * @cache_id: The id field of the unified cache
> + * @cpus: Where to build the cpumask
> + *
> + * Determine which CPUs are below this cache in the PPTT. This allows the property
> + * to be found even if the CPUs are offline.
> + *
> + * The PPTT table must be rev 3 or later,
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.
> + * Otherwise returns 0 and sets the cpus in the provided cpumask.
> + */
> +int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
> +{
> +	u32 acpi_cpu_id;
> +	int level, cpu, num_levels;
> +	struct acpi_pptt_cache *cache;
> +	struct acpi_pptt_cache_v1 *cache_v1;
> +	struct acpi_pptt_processor *cpu_node;
> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_PPTT, 0);
> +
> +	cpumask_clear(cpus);
> +
> +	if (IS_ERR(table))
> +		return -ENOENT;
> +
> +	if (table->revision < 3)
> +		return -ENOENT;
> +
> +	for_each_possible_cpu(cpu) {
> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +		if (WARN_ON_ONCE(!cpu_node))
> +			continue;
> +		num_levels = acpi_count_levels(table, cpu_node, NULL);
> +
> +		/* Start at 1 for L1 */
> +		for (level = 1; level <= num_levels; level++) {
> +			cache = acpi_find_cache_node(table, acpi_cpu_id,
> +						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
> +						     level, &cpu_node);
> +			if (!cache)
> +				continue;
> +
> +			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +						cache,
> +						sizeof(struct acpi_pptt_cache));
> +
> +			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> +			    cache_v1->cache_id == cache_id)
> +				cpumask_set_cpu(cpu, cpus);

This function is almost identical to find_acpi_cache_level_from_id() 
defined in patch #3.

To reduce code size and complexity, it's better to define a common 
helper to server both of the two functions.

e.g. define a helper acpi_pptt_get_level_cpumask_from_cache_id(u32 
cache_id, int *lvl, cpu_mask_t *cpus)

This helper has the same code body to traverse the cache levels for all 
CPUs as find_acpi_cache_level_from_id() and 
acpi_pptt_get_cpumask_from_cache_id(). The major difference is here:

+			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
+			    cache_v1->cache_id == cache_id) {
+				if (cpus)
+					cpumask_set_cpu(cpu, cpus);
+				if ((level) {
+					*lvl = level;
+					return 0;
+				}

Then simplify the two callers as follows:
int find_acpi_cache_level_from_id(u32 cache_id)
{
	int level;
	int err = acpi_pptt_get_level_cpumask_from_cache_id(cache_id, &level, NULL);
	if (err)
		return err;

	return level;
}

int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
{
	return acpi_pptt_get_level_cpumask_from_cache_id(cache_id, NULL, cpus);
}

> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 5bdca5546697..c5fd92cda487 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1543,6 +1543,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu);
>   int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>   void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
>   int find_acpi_cache_level_from_id(u32 cache_id);
> +int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus);
>   #else
>   static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>   {
> @@ -1570,6 +1571,11 @@ static inline int find_acpi_cache_level_from_id(u32 cache_id)
>   {
>   	return -EINVAL;
>   }
> +static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
> +						      cpumask_t *cpus)
> +{
> +	return -ENOENT;
> +}
>   #endif
>   
>   void acpi_arch_init(void);

Thanks.

-Fenghua


