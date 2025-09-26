Return-Path: <linux-acpi+bounces-17327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF9BA25F1
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 06:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FB8188BAEA
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 04:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40126D4C4;
	Fri, 26 Sep 2025 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J//9iodB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED51534EC;
	Fri, 26 Sep 2025 04:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859916; cv=fail; b=Q3NGeM5RT9YfyHB6lFQ63+bWaUQCrK1F1HiT4tT00p4V0qBohfdf5vuvhNl+jYaRYeQlc4oSHR7mL4VTahJ32e0ZCTAXFmmFTHxMfpYXzqs8xjRf2eFz5lxBsFiy7gN37KDTSh6h7qN0vVYNBZZh1DWWNgwGZz1PpjjIJ3pP4qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859916; c=relaxed/simple;
	bh=NkimsT8cOkhLtdKfFCOMWtLhzv+UcFUPGIOXinQwhw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XCcNOw5wVpueoam1vXhGqJCnh4McinyxDuaIVv1HchDjEBz8wPHsI/yKeHCLYP7VjVkYfV9F0uXBi3HNVurLSPhwqWErfTpfJLJi3sNrlj8Cf5PoeEmrYKjR35U78XeBodRzLzawAanQb+5NmQbsVRkh+36+28uOvuu+lNNUE5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J//9iodB; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDwMaVsckhwwWNFBAoeBiGThK4ka0OBCofW7VKomCMzyAhTYAuFMY1sh5N14RTeszDX2Ghgnk/7WUUcOs1QvtTg0N+RMjWhdEHDF49j24OelNvAwpJxkxOnPGJynzT1oBBev/vYeopjRdrdCOL6smcpR22F3Aubg0s/SJFryBBJhTL0lyd+zCMl7ixhRDwxBOoVYWQ15Nb0uNmFlrZczQRGL2g9H9qVmVfvyKQiyJQ6Z00B1kzMaRYf3DYLYppgVesQycvcBqqEgRFRQvg1QXIJlnXeadH8U/sM4cjZeAkCniL1scWuz3ypnWIU+6X5kKwS3IH+9n/U0Iwqi97lmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0KykNiN7nTVL615e7gDF9MrqlXh6AisCCM0rm6yyCo=;
 b=IbGCDpaBFWQFSNPhYlZoeMSi5kWaddoMPxOrCHDLp56JQuJybGGbfrb3yrpHB7CRSBgGqd2bMemts2d39c0of37AEvlhYgR1VHAjDmTfT0T8GdleVElth/2UGSHCnJdSJsZMkb5aw/aB3vX3cDGjHf8eXdnFvmoHy1oGPyR6Rc/v1nq8efYErfoxPoUpax222v59BByPm7tdpAxOyy12Ba/Nn50xXotBNpOuespGS/rZEatkzsqjRTQvlyXh3Bch69TUXRUn+cY8klXYUEJu7sEXi4kZMEo1vSUOn14ZXEHCoNjIxFI5BVFvmbiOX/6gfhJwGPPZdFtIqaV+UBJK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0KykNiN7nTVL615e7gDF9MrqlXh6AisCCM0rm6yyCo=;
 b=J//9iodB+PFjXzbxE6yD6LI/zaEh7kMH8040EukZ1Tl7peaXQeJUHz0Ru3MR6Yk/hmfLsmYuTKRsLkhKNow2FOOgLTqO+VkikxFadlXwWpdmrQnYaTbcGKty77CwsI/ktx+La1OPxnpzZM7Vr5CY8X30G5ztyxo5VEd3tvhvYs5VtlFDewGFtvNvKHIMj/vsX7tq6az+QfZX+R3c3G5bmnyY0GK1+YnRb+HixWchVnIh557ptgPzvj2os8nmoWXynX++STq+g+Hn6sKE8BWpMDxxQs0VfZJa/mLLzVTBM5dp+Ux2xLhbv3Lbg1LvfxbsqtzE391peIo1K3fhY7KlXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 04:11:49 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Fri, 26 Sep 2025
 04:11:49 +0000
Message-ID: <af6b6827-9bab-4328-ace0-710d7845c2ac@nvidia.com>
Date: Thu, 25 Sep 2025 21:11:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/29] arm_mpam: Add helper to reset saved mbwu state
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
 <20250910204309.20751-28-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-28-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0136.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::8) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b166379-5d53-4456-7e83-08ddfcb2d082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkNDMll0aDJ1eXIzSVU3aFdhSnZ3MllCaHUvM2t6RGVpRHFUTk50aFhDb1Jv?=
 =?utf-8?B?RW1XeWwwRHgveW5Ub3o5OWRKSkM1dGNyUVZjNUlSelp2YzFnNVFXdzVpMXAx?=
 =?utf-8?B?YnF6ejNORlh4d3U4eE1qRjNMOHBtZmRWTlVRTU1CTnJIdlRJQlZTbUlBeUpr?=
 =?utf-8?B?L3RSMm96OVkvT2FDYnA2Q3NhQTFRQXNKSXVOSjlJN3RQQi9qUG9pbkpCQlFV?=
 =?utf-8?B?QzhYalpKT1QzUTArTUNrb2Uya1F0WXRBaGxvclVxYyt3RnFIdWhLSTB4VnN6?=
 =?utf-8?B?cmx5MC8yLy9RcjVFVS9zK05wVE9nb0JVcWJQd0wxdU1EaWIwaFRaOFpUWlZv?=
 =?utf-8?B?dHBYVEVlN0tkQWxLd2I4V3ZwYmRZT2RBK0xpTUpGWlZXMnMzTWF4OGFsbUx6?=
 =?utf-8?B?S3BLcU5iRVV2cnNmTEJ3ZlV5NWc5UG9mYTlyL0pZTVc0bUdScVhrMDNKQTYv?=
 =?utf-8?B?Ni85K1F5RkxqMmovaU9WcUIycDY4MmFoYXFLODVNNkU5WjNqM0JEVWhzYjk2?=
 =?utf-8?B?ZXNoNFJucHlGek92RlgyTnZtUXB1NTR2VHhMeSs0V3lSYVFTME14TkdZcE5k?=
 =?utf-8?B?bE16UGxDVWZZSWUxNlBZRSt4aXh5R2p1RmdzTkN4V3JNc0MwcUppYXdjSldv?=
 =?utf-8?B?L2MvVFdYMUY2eXVIQU5wNzFCamFBNnZCcm4xbTU0K0VBbnB0Szd0dGNJWjcx?=
 =?utf-8?B?bXMyTlIwQ2ZqZlpERGFMQnFyTHQydEVJZTFOTnpMRkJzUStIdjdhbjdlaTZ2?=
 =?utf-8?B?anJDcW5UNGN5UzY0YjQ0MW93MVZ2cGRubWY3VHVyNmtIWmgzQ0VURUZZalFJ?=
 =?utf-8?B?UEcvU0VVK2xqenNCNTRlYUdQb1VBQUw4TTF1V1MxWEJUdjRZUnY5Nkp3NlU4?=
 =?utf-8?B?TjI1UmJWNThmSGNJblZ0dzdEL2NLc1NqajFxaGptV3BLQXRhU3BmRE4yOUR0?=
 =?utf-8?B?WnZhMGVYeUNPT2ZvZUtVWExKY1ZLME44UXFUWjV1NHVCeFZnbWJ0TVRxNk9o?=
 =?utf-8?B?YU56S0VMNDUvNW5xUjhuUkhrU0RneGpscEloUklnTjI2NS9odUJxQlRlMlp2?=
 =?utf-8?B?ei9oZmZqNHcxRE9YT2ljV0xjQVk4N1FhZVpBR0VqVzRvc2lkVWxPa3FoRHVZ?=
 =?utf-8?B?MmV0WHVtT2dXQVlZLzhjUTBlbnA2TXZxMGlucUpQOHZ3Qlc1RUlCbyt5RTk2?=
 =?utf-8?B?VlVRYm1ndGVzTm42NUQzSDBlRUh3NG1Mcm1URjJYUzdSSkh4Vk5BRVQ1cFNG?=
 =?utf-8?B?ZWRBMC9Xb0dPdFU3OFhNSTl4RUZpczkyV2hFKzUzZk56aEdLUTVlYjBMWG5p?=
 =?utf-8?B?dW5kaVo3eUZ4aFNGaWg3RWRxOHZ1TjdtOWpaM3VxSkg3V0ZtcGRrNUpsNnlx?=
 =?utf-8?B?Y01NMUFzSzMyTnlWRmFBRXNtUThaa3hyMFE0alB1UERvWjJnQWJzSTFsWlF2?=
 =?utf-8?B?c2FsRlBScE9JVkpGUFZGdmx5akdRTmVRL0ZzQXF6OXhIbEg5M3I4cmlkdTMx?=
 =?utf-8?B?RExXN253WFU5YXh1RXVBSnpwekV2eXNzZFhOaGtvQi93UHlLYmFIU1p3RlJY?=
 =?utf-8?B?UWdISGQ3dGZDdHZ0aWtyd3RYaHVRc0dlbENwVzZXcEhzWm5IbnRpNTg0eFFk?=
 =?utf-8?B?RTNqMUtHRjVIZytWT3EwY3N2ZWFRMVJjNFB0UjNoRThYaGV6a2pYWnZJWEpF?=
 =?utf-8?B?WVVHK3NJVFRWbXV0ZVB0QVYzVkVXZHd4Z095ZHFXY3laY1BFWE8xK0tzd2N6?=
 =?utf-8?B?Ri9nRWJJaktBRkRYTFZ2NTNRaDdOcEd2VVpHWjBhQnhDZ29SbTUwelNCdEFs?=
 =?utf-8?B?c2g2TXV3VGg3c2k2THFRdTdidUwzY0V1U1JXNlozR0Z0cG5IZnIzVWJzQm51?=
 =?utf-8?B?M0NXYnpJR0FNcHJFVW5aK0NIV005T09VcU8xRjhVWEt0Y0p4QlIrWFFKOUsy?=
 =?utf-8?Q?ocT0XudHnwncuGOMySJq+VBtcbesZ4IM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpxNHI1Z1MxUWYxaGNsMERQUThGUENJbjNvaU9OdFZQNHM0NVIyZUNaMGto?=
 =?utf-8?B?SjZvNjZCa3N2RW02MVplTDFVVWtVVkN2ZjVpRmN3VDgzdlNWZmNCUkpkdHBM?=
 =?utf-8?B?aWQrOGdML2c4Y3BBNWNkTlk3SXdYSlV2Y0dULzl3czkrUlh4dVEvaFcwRU5C?=
 =?utf-8?B?blJIU1ZGQ3BGU1FwS04yOGcvUmMrRHN2ZXc5c3htMHhWcDR2cW9IallpVHBK?=
 =?utf-8?B?cnZZMnVXaUh3UUdzQnJHOWYycnQ1ZnhDbGlsckZ6ejhyOTZsT0FobTRNLytp?=
 =?utf-8?B?SUp2WUwzV0U4cVRMSWlwZ09mQnN0RFJSdHk2d0tvTmJWTU9aMjFuQmNKdWxG?=
 =?utf-8?B?VUUvTWdiTDRGL2pVRXMyWUdhcmR4aE9YbUtyb083OGN4NmJoaG1NWlZZRnlS?=
 =?utf-8?B?UjJLR0pzMjg5blRaMWlBaE4yTVhGTHc5bFRlQVJ2VVZ5MTljYTFiUkVLK2gz?=
 =?utf-8?B?QjhPS255UjlEODhZY084NUlTZEh6SjU1ZkFZMnJvMGJEQWxpNDluZ05qVlBW?=
 =?utf-8?B?MU1tQldqdVpFczhEeE85b2JPRTFaRlJ2T09EYVVxRUhTTEtEZDBIb1pmWlBh?=
 =?utf-8?B?djl3cUZFRlU3SndiMWM3OFBmUlV0eG9UZ0phelFGTU9pbVJSaFZCQStMQlRm?=
 =?utf-8?B?WG1BOVJJR1NQZVZWZ2ptNm1USlB3NnkrN3dUNXd0TkJPbFhMR1Y3MTRlMmRr?=
 =?utf-8?B?bGtTMVhhRk1YaUNWc0JQUmxQdTJQV3Bzb3RjRndFN2d6bXpIWU5NdW1rZVg4?=
 =?utf-8?B?SHMrWkNpbEljQnlpQVJuQ1NlTDZxSnlQRUIvM2JFd1hWMllLNkxNNzQ4Tjg0?=
 =?utf-8?B?c0thVGJ3S1FQd29xREdUdGdEZ1FOQk14V1RNdEt0N0I4MmhaREZXZ1JxcW5O?=
 =?utf-8?B?Vjd0ZGtHTDJ5Y2k0QWRNbm1rRjFOdlNHUWhSUlB4VFd6ZmdRRmY4QmVwY0lm?=
 =?utf-8?B?QnJ3ZFFlNFRJV3Bwdlg3am1oOUZGbXpoYXdSQnZTdmVvbDB3Qlg4Z0V6OGtM?=
 =?utf-8?B?RmQ3emZjOE11V1NMbkdoYlh5TVVZalo2NS9WcnNvcVdNZ0xGLzdNSVFwR0xU?=
 =?utf-8?B?Vm1RRG1pVkR3Ui9NL2RISVg2YjdrRTdxNmdKbzl0dHp2bGR4MXlpVDhYbW5V?=
 =?utf-8?B?bTZSbzVXQURLVWhMSjJDRUVGOW4wY1pjZ2NkcVFrOW5aTG1uaTZGZ0VzOHRz?=
 =?utf-8?B?SUxhVXBtUWdoQ2E5aytNTVBJb3JTQ1NrbGdGNE5YYjVPQkVrOGxwcWQ4cS9i?=
 =?utf-8?B?dlBCalQ0ZkxFMmdsT0pLc1hvbjZna0VtVFROcStMeDVXR2VKdVJDbFo4Z2ZW?=
 =?utf-8?B?aXBNVkxOeUwxYlMrWXVvM2w3N1pXZGZSS0hsNlBTNUtlc0dkNEdoM0R5dWx1?=
 =?utf-8?B?WjVGeHFLbXlEMzE3Y25SaUcyczVVc0tDL2tOS0ZGL0NIR242aUVxR2NsalpP?=
 =?utf-8?B?U0RqdVlXZmdVVThJc2FQUmJnN2FTTS9CNmhJZEsyTVNHS0lhZjhRd2VKeXRM?=
 =?utf-8?B?aWsxSE1uR2d0ZWVLV1liT2ZXNTVsNWNoYmhnSktGOE9vanRMcllmb3YvTFor?=
 =?utf-8?B?L0dpQ0xvNEpsdVJMMTRXdDAzWlNiRmgzdU9Lb3NCc2NUQVJrZmUxaWZ3cE5M?=
 =?utf-8?B?U0F3NlZkdWYvQ1NhSlJyWTh3TVJpaHNjakl2M2Nldi82MzFLUE5MajlXZVFC?=
 =?utf-8?B?ZForYnBpMS9MMVhMUzRWazZNUnJ5S1JVQ0ZUS1JXdmUzM0RINnNZaWZQbVBp?=
 =?utf-8?B?dlcyRnAvSms2RGpwbXN3Vng1WnYxNVBQek5QMjF1SVJzWEhtdDIwazFHTnh5?=
 =?utf-8?B?SzBRMUEwOVkyc0tqL2k5bjN3UFZrUnZmbW9sOEdLM0ZUUWVKRVFUM0lkZ3Zo?=
 =?utf-8?B?RVVvMjZlWHZNOUJEdGtxdEUzTDRjNW1LVG1vWEZQME9YQzBxblZXejgwY3Br?=
 =?utf-8?B?akd5Zi9VWVZLRERnL3N5azYrVTNST0VQOFZTU3o4Z2luSGpHR1VFZ2E5NnVQ?=
 =?utf-8?B?LzA3OTZTYVhoRGNlemNrNE1kTnF3S3NYdFdndWQvOTFTeityTGwvSGRGbjFG?=
 =?utf-8?B?ejkrc0psNDN0Vkl4YkNjVVhlS2hVTUhvRG5UYUF2TXdvelRqbTlISGJBa01Y?=
 =?utf-8?Q?hqMO2xRtVpXhB844g2ECbJc/M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b166379-5d53-4456-7e83-08ddfcb2d082
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 04:11:49.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTAGSBYmZ8FzipSZxwkWdr1US8QDIRWn3QE5NjtXAIf3+hpqc6XKtjLqWc67kRjcn/2nXGvhbmfRhbe2IbWaFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820

Hi, James,

On 9/10/25 13:43, James Morse wrote:
> resctrl expects to reset the bandwidth counters when the filesystem
> is mounted.
>
> To allow this, add a helper that clears the saved mbwu state. Instead
> of cross calling to each CPU that can access the component MSC to
> write to the counter, set a flag that causes it to be zero'd on the
> the next read. This is easily done by forcing a configuration update.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Other than the following minor change,

Reviewed-by: Fenghua Yu <fenghuay@nvdia.com>


> ---
>   drivers/resctrl/mpam_devices.c  | 47 +++++++++++++++++++++++++++++++--
>   drivers/resctrl/mpam_internal.h |  5 +++-
>   2 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 3080a81f0845..8254d6190ca2 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1088,9 +1088,11 @@ static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
>   static void __ris_msmon_read(void *arg)
>   {
>   	bool nrdy = false;
> +	bool config_mismatch;
>   	struct mon_read *m = arg;
>   	u64 now, overflow_val = 0;
>   	struct mon_cfg *ctx = m->ctx;
> +	bool reset_on_next_read = false;
>   	struct mpam_msc_ris *ris = m->ris;
>   	struct msmon_mbwu_state *mbwu_state;
>   	struct mpam_props *rprops = &ris->props;
> @@ -1105,6 +1107,14 @@ static void __ris_msmon_read(void *arg)
>   		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>   	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>   
> +	if (m->type == mpam_feat_msmon_mbwu) {
> +		mbwu_state = &ris->mbwu_state[ctx->mon];
> +		if (mbwu_state) {
> +			reset_on_next_read = mbwu_state->reset_on_next_read;
> +			mbwu_state->reset_on_next_read = false;
> +		}
> +	}
> +
>   	/*
>   	 * Read the existing configuration to avoid re-writing the same values.
>   	 * This saves waiting for 'nrdy' on subsequent reads.
> @@ -1112,7 +1122,10 @@ static void __ris_msmon_read(void *arg)
>   	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>   	clean_msmon_ctl_val(&cur_ctl);
>   	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
> -	if (cur_flt != flt_val || cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN))
> +	config_mismatch = cur_flt != flt_val ||
> +			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
> +
> +	if (config_mismatch || reset_on_next_read)
>   		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
>   
>   	switch (m->type) {
> @@ -1145,7 +1158,6 @@ static void __ris_msmon_read(void *arg)
>   		if (nrdy)
>   			break;
>   
> -		mbwu_state = &ris->mbwu_state[ctx->mon];
>   		if (!mbwu_state)
>   			break;
>   
> @@ -1245,6 +1257,37 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>   	return err;
>   }
>   
> +void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
> +{
> +	int idx;
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	if (!mpam_is_enabled())
> +		return;
> +
> +	idx = srcu_read_lock(&mpam_srcu);
guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
> +		if (!mpam_has_feature(mpam_feat_msmon_mbwu, &vmsc->props))
> +			continue;
> +
> +		msc = vmsc->msc;
> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
> +			if (!mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
> +				continue;
> +
> +			if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> +				continue;
> +
> +			ris->mbwu_state[ctx->mon].correction = 0;
> +			ris->mbwu_state[ctx->mon].reset_on_next_read = true;
> +			mpam_mon_sel_unlock(msc);
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
> +
>   static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>   {
>   	u32 num_words, msb;
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index c190826dfbda..7cbcafe8294a 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -223,10 +223,12 @@ struct mon_cfg {
>   
>   /*
>    * Changes to enabled and cfg are protected by the msc->lock.
> - * Changes to prev_val and correction are protected by the msc's mon_sel_lock.
> + * Changes to reset_on_next_read, prev_val and correction are protected by the
> + * msc's mon_sel_lock.
>    */
>   struct msmon_mbwu_state {
>   	bool		enabled;
> +	bool		reset_on_next_read;
>   	struct mon_cfg	cfg;
>   
>   	/* The value last read from the hardware. Used to detect overflow. */
> @@ -393,6 +395,7 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
>   
>   int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>   		    enum mpam_device_features, u64 *val);
> +void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx);
>   
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);

Thanks.

-Fenghua


