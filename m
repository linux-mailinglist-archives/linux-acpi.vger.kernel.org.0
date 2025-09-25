Return-Path: <linux-acpi+bounces-17295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E36B9D327
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 04:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A6C3AA79C
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 02:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82CA2E5B08;
	Thu, 25 Sep 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ud2Uy565"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0852E54BE;
	Thu, 25 Sep 2025 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767442; cv=fail; b=NLnZQEi/qzigk87Z51wPtwxdCr7bp6V+xSdN8ZIMqehUA4Loz7jKmknr6McqEh9P3xmtiuwSMEx1/deOAwFOaHaMTK7FoF0DQGOI2zNayQjTN0g20R/Oh6BQuEhtHaiOecXoQz1ZWAWsLBu/tOvTn1cHc9Keirn8sgpp72v4Jcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767442; c=relaxed/simple;
	bh=kBYVXEDcF5bRY81X1pnigBEbSI6SQ92F8QmzsFqCeMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QFvZUhrUQ6eWU2ia50F3n/h9pyAWPa5GTCITswmVDgS+1zOx00zfi6kxPBBwMcA2ruM9FEEaNh+fQkPB7SuRj5svGtcPFsD0BT5E2m9SHr7Mcri57Exkq1scZFjuLY0SXeKB6zi27EoCA+FtCytsvvbU9y2coAZ0BAvXdmj2s4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ud2Uy565; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngHCdTMmAe6FawaG01qh6ZkieENyYnVyUF2ttm8/AbyqOPADWzaTXRNOmEtdf9U/a+OnwsdWb/x0adG7BxmMQivqMsMnpfj73gKGDN+pbFDZPN9Nnpyy/74UpisJlUox/YQ1CnwKq/IOLa8Z/r5LwBFtS9vIdJz5jddMKcEjnM3c1+2zlCgnqq9zdENLXsPM+4DkZKElOMoSDsot/qKwIVdrGZfH0mSLbqIpaGIhg7AfeVigIPNANypG7V3SiuLgKoFWSkqZS/FUCm0QyFCrnIqae/Qo3JSaLIOexzCwtEFFdzdquIoMR2nPb9aryRj2il0oah5SAcTqPWenN1BNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U6DXi55r/KNz0Nl1z/KlRHhCSFLtANbYerJf6nVsWE=;
 b=R9TK+TRIrST9NvFaWHDz4fnPEK5E2jBAQtSfa5m3ddUMGFkTQBRlkUjuJMZq7wfG4Wafyi97aEp0w44DT0KJMJf/9wnWcKof2o1TrQEhtQHaz7ipUttn5WTtlfrG/BH4VmPFYBhS9AHdCwzoPHKqwgsFsXNx0+4de+yQyw1sy7Ytijd2pn0A669ky+hYfKlfRDVMFpVGxMC/u3JJSXx5ogtGoBk+NfecuRCiKvHx9o5vhCfaNwJPgB4Ksyh4yax9K0c/IRfd6Y34pIkAeOHhgrR4KwebC4d3gpp8lA0ju36JhJSwNf9926wFTjrBnRDs3nGqkUSaJmtWRI2dFz5UQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U6DXi55r/KNz0Nl1z/KlRHhCSFLtANbYerJf6nVsWE=;
 b=ud2Uy565UiMQZU0pHshK4/GVVvvWUYsZuZ0o0rFP5+/lVn6ytFUYuOHX8SHpwHvxiFcYWcaR0hN2k8L7Maqglh6LeJ3lpzYjUkCjtx36+m3H6H72Eor5m3gZoZJO6yNQ5zJvMFUjFG47FzIeBsTKcihV9m0yVFbyyYqcH2DAbQxcLtSL7B9I4XWlXRCi1oIehYWUhfeciK5zYXQw/Aa7SS+Q1wSRGRNd+qHLhq7ql4tnTTyN78sfgjO/+XSv3MRslMempZclNfhM6S0E9QWD//PcdOMbNYu22cAnxAHYEds3K+WuctdqaDKq7zKSHf6nDQ6k7na9w8ZJlSYlhRLlyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 02:30:36 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Thu, 25 Sep 2025
 02:30:35 +0000
Message-ID: <74afb5d1-850c-4e30-a9bb-9903a5193280@nvidia.com>
Date: Wed, 24 Sep 2025 19:30:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/29] arm_mpam: Add mpam_msmon_read() to read monitor
 value
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
 <20250910204309.20751-24-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-24-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c71c59-881b-413b-3078-08ddfbdb8223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzhWditHOHZIQmpML2Q4OFlJdWR1NHNRdFlrcFhhTW9Yb0Vxclc4MFd0eGRa?=
 =?utf-8?B?N2FFUktyZ2lNV0lBbUU5RktjbExROURCRDB6eHhWaGlUeUlBcmI2dVNxWVoz?=
 =?utf-8?B?K2Q1Tzd2SVZ0Q1FDMC8wSU9HVk5WcE5MTmRHcVQ2enF6akUrZDBrZjBNa0pt?=
 =?utf-8?B?dldVZ1ljZTQ3bkRtWGtubHVIcUZBekRtVm9YUzF3bEZMY09QN25tTnBORmZn?=
 =?utf-8?B?Z3ZuczlROEMyWXRFd1hSd213UkdRcTU5VXVuTnduOW5jMEllTFF6TVplZzYx?=
 =?utf-8?B?QnhyTU93UStqVjkzT3hzMVhaWUFKR0hmUW1sRVE1VlBmWjlKVkZTdFN2VVRi?=
 =?utf-8?B?NXpIVit3aEk0SmUvOVFxYVNrV1NSRjcxSmlwakpaTTNicVpEY3FwTUJwRDZU?=
 =?utf-8?B?TEFROHRkWXhMSkE2Z1ZHcEdaL1ZTTDF1LzBpNng4VWFYdmZwNkExYkw5N1VO?=
 =?utf-8?B?ZXlZd1ZXSGtnMGl1bCtpdytuTmM5TE53c3RiYzJwSVA2YmF5TGFWOG1jVGNp?=
 =?utf-8?B?dzluc1A5dmFpOE9reFdpWStKZ0d1bllxNzJaNTRvaW9ueURMUXo3dUJMaDBX?=
 =?utf-8?B?cEtSU2srK2hKa3BQSi85RVNCRzFiZ1g3ckx5U0JCam54cWpERDg0dklLcTVw?=
 =?utf-8?B?Lzg0U2pJeVZFYkdHelRNTHFOc2E2WFNFSkc3RVcvN3d0UTR5bGZFLys0dllG?=
 =?utf-8?B?TktKaHdwZTcraUpMNkVtT1hVVG9EN1paNHl3em1rVUpwN0dZZ2NSR1g5aW1P?=
 =?utf-8?B?VVFmL2xicWFUS2pSd2QzTlloUUZ1Y2hpajVGQkhRMU5xNk5FSTFvM0h2U1o2?=
 =?utf-8?B?WW1UeE9iYjF5aFE3RmpnOGFDQWhxTXFYVXZqdCt1Y0lySUhDa3dHUHZISWhY?=
 =?utf-8?B?QW1LWGlJZ0JvM3pncGk3dVpoNFhKYjhWQUJCQWNVMXk3K0NNeUtrWFhGTTlp?=
 =?utf-8?B?NE9HNjhKajhTMVVvM216dlJqclNvcjNYZ1FjU08ycndSK1hSbFI1VlN4UzUz?=
 =?utf-8?B?UFpqZVZhaDdXMnpvalN3YmhrUFE4a2ZZVWdQL2FnK0tOMlZLd0MzV2t6eEMv?=
 =?utf-8?B?VHVPZk4ydVIxTlZRcForWklPODJLYUFucHo4dHY1Ri9ieUFHMUxJTVY3eUhi?=
 =?utf-8?B?NzNmWWJ4QkU4ZktocStyVjF5QjBDdnRmVGR0WEg1UlRITVNncjZVdDYzcklX?=
 =?utf-8?B?VWMvNWw4SnEwM2pUMmlLNC80UEtJd014aEFHVUtiejVLbURyaFZyc2h6ank3?=
 =?utf-8?B?bU1lbFBJakpFQWgveFlHdWZ3M2o5V09jb25UdEtDVnJpUjJaNDRUaW12c2M3?=
 =?utf-8?B?UG45aEtKalJUOXdySTBjOCt1ZFpxZUxPMHl0RE85YkVSUGh3aUlUS01mdzQ2?=
 =?utf-8?B?Zk8renV1Z1dJSC9YajUrcVREWXBzUlk2ZWFaQmRIZFlOSHYzU0lhRXRTMUds?=
 =?utf-8?B?RVJUY29OZVl3d0NvWERWR2xUWnVndkNjaDdHbEZvQm9ObHA5YUdGK0p6NWkw?=
 =?utf-8?B?dFd4SUFlL0xlWXRIK2x1TThPRjZNWXA3aWYvNk1WcjRTMnBhcVJKTGhqbDFC?=
 =?utf-8?B?M1FkQ0xxay9MZEVLV0RrYURiVlBlVzlEMG5HVEo3b09PUDBpYlVsNWlYNVlE?=
 =?utf-8?B?STV1TkpSSjN5Z1o5TmJlS3dvK25oeFpwZCtJNURXaXQ0eFBCUHhkNk5tTFQy?=
 =?utf-8?B?MGRBMTZuMmt6aTg3VzdVL1BzSHVJT3orUGhOemFJRDU4YzUzYlBpRHVYRjFS?=
 =?utf-8?B?M283Q3pOTGI0S2RmUGJrYWRWcXoyeUZhZ3ZNZWlYcmk3dmE2SU5LbjJwcHRF?=
 =?utf-8?B?cUpxUU1WdjNEbDRNdkpRd1NTR2pFY1o5M2c1VEpscXZzM0ZKbTd5WXYwMVMx?=
 =?utf-8?B?cWE2TlZBUlZQVWtyZGdYQWJ1OEpjc1gxSVU0WXpRbjJhWW5KUXBjUlZueTN1?=
 =?utf-8?Q?hX5cy29PhgY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDR6UEp4U2FSS3dDb1orQWtRcVZoMUZtRDVTWDdYdkJFZC8xSnpnNmdxai8v?=
 =?utf-8?B?NDdDVmkyRGRKZmtRM3JFY3NSWWVBaGxhdVdjTnhUamMxT3VtME82NFVuUm90?=
 =?utf-8?B?b09kZktsS2VyNkJCbG1nY1hZbjUrZyt4bDBPd2VSdURIdkduWFRmRDJXRncx?=
 =?utf-8?B?TGNvSXpNTlZDcGEraC81U3FKUEpoejJWTVFWeURkcTdCdUVoS0ZtR0NHTHNI?=
 =?utf-8?B?eGdhL0tOajFDVmxsYTFtN3NjcFBQczZBNDNjUTZ3VkpxV3RyM2lVQzVjMm1G?=
 =?utf-8?B?dURXUFRQbE0reElOdDBnQXozT1BxV0todDdZSGhJM0JyMm5BYXVqQ0pMVWM1?=
 =?utf-8?B?UGcvTVUxY1BLakZscTRhZnN4MllOaUR6cjBTekFFd3g3dFg3MVFHVXNTYmd3?=
 =?utf-8?B?bDZSSEJkdlkwdVhuckNDSkpoMGl6bDVZWGtJZ213VFRaT2ttT1NFejAvSHp5?=
 =?utf-8?B?V0gydFk3T1dVQTdvRVRXUDZJeWhCSTRZNThjWWFnNGdqNm1hWVBSQU93WWVN?=
 =?utf-8?B?Y2hoSjdudzIyS0JBWkZCalRBUW9sZTcvSGphdkJyaHNsNE9MOVVyMWJsL0w1?=
 =?utf-8?B?RGNOZGhnYkVsSkU2Zm5XUHd0RytwYWREaVpybzUra0l6aStBSjhTK0ZmVTNP?=
 =?utf-8?B?ZThka3FMbnN1TktQRTJTa2JPZ1dzcHYwN3N0dVlSRlBYb1pIQzhmUlR2YTFE?=
 =?utf-8?B?R21TTzdrTG9DN1FrZ0h4OGJxaHp1alZMM0xRZUZTOXdsR24xOG9ENlRGcGwx?=
 =?utf-8?B?SDVDdUZsdWE5bzdWWEJMUGpuL1hMSVJPK00yZWJzT2NsYlBOdFk2ZHVLclRR?=
 =?utf-8?B?Mm9LdWVJVXVleWlOZUNsWW1sbVdNRG0xd1hYNUdFL3BnWmNOL2VPNm9jRVJr?=
 =?utf-8?B?bE5Ib1dsZEhSTlBTRnB6YVJiUmZZMHU0TENFbitIdnE2SFh6eUh1N0NtWXRE?=
 =?utf-8?B?c0pRbFFlRVdUa21id01EWTVieUhrNURobHNKRm9hRTRjZk93ZDY3c1JRNFdl?=
 =?utf-8?B?b1RZelU3L0ZPTnk3b1VyRmp5dzQ0ZWtzWjFURWJURTVrdFlzTHpJblMxdFFm?=
 =?utf-8?B?UUw1cjZHS1RPaGNQVndBN0RzYk5IYmRja0pDL25hT1JkOUVEYllXRklvU1gx?=
 =?utf-8?B?a2JjdmV2bnB1Z0x0aXI0NEZuK0NmTUxsSFZ1empBdURsTy91bDBRL0dQQjds?=
 =?utf-8?B?eWhJVGUvMWNvWnpSQ2hYam8rQ2wrOXdtYVNhTlBwQW1LQ1NPM0V0VUhuekRv?=
 =?utf-8?B?a21hM1VLOWRwSlVWeGNtZEwyR2VUcVJOTENPdVRETVlGcmJwd2hERWFjdk93?=
 =?utf-8?B?a1dmVDhzMkNFWW51RkpybE1GUjZJWEIwRjBaUW14N2tWYkJjdDZpTE43bC9o?=
 =?utf-8?B?N2xKRys4dkRwYzV3OVIrdTQya3BHemlhUXpPWC9QamptRFJ0YXdDUHUrVGFL?=
 =?utf-8?B?UUVSMW1HdVY1NytxT0kvUGVlbHp1NmdKZHlaRzlUM3VxNnJZWXk0c1JocWZT?=
 =?utf-8?B?dWR0NS8yZWd0MHhPT2hobEFjT0RGcjk4UWIwNmZUVnZhaDBCb3VXTVlhUDJB?=
 =?utf-8?B?RlJqSGthU0ZKY2srWTdXaWNzS0pMSjd3VGJPbEYzZTJOb2ZkMEdBVnN0WmRH?=
 =?utf-8?B?SkxoK2tKbGZxbWhDQUtPRGMrdlh5VWl1T1VmZXJ0UzZCZXg3S245cHF4OStZ?=
 =?utf-8?B?UjVkQjluWVFJWTlodzdNMnB4VGY1NUhSQlpUaG5pb2ZYOUxOL0hXaG1aenRK?=
 =?utf-8?B?OVNWSElsNG5LQkk3aHRCb1ZZTi9vYlE3c08zd1JQeDFOa2t4bGhoRy9NTE4y?=
 =?utf-8?B?T3Q0UHJZZktPLzRXdWJFYjFFSEo4OHdEV1dlT2Q5dWxYd1IraDNaeDFBNGJ1?=
 =?utf-8?B?Z2o2bmIyc29mU3B4b0JjYyttbVlWRjNoSjJ1MCtXZG4yWDdWSDA3M3pFTXJ6?=
 =?utf-8?B?cjRqVkUzZlExSGY2TmMvZklqMTdlL0d4VWlqOXNSZzZYbW9lS1h5MkZCdGF6?=
 =?utf-8?B?bUNSK2lYS29HUXhjWGUyZ0NzMVcwQ0RGRjZtMytxT0ZjY2JmVjBsZkwrZGdF?=
 =?utf-8?B?OHlQSlluUzBqS2VDb2pTN1ArRlUxUnYrVHJVZVNiWmN6ejhPZWtGczB5Nzdl?=
 =?utf-8?Q?xA6GA28NGkUZFN/Z/wSfs8OBL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c71c59-881b-413b-3078-08ddfbdb8223
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 02:30:35.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: engGFI6+9OU++xHV3PAbbdC3Sl3TnPDE6cW/c8dQd1wKxLLzfERETG62R+a1xxqmPGw+Bi+JkmCiYq8M6vrb5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749

Hi, James,

On 9/10/25 13:43, James Morse wrote:
> Reading a monitor involves configuring what you want to monitor, and
> reading the value. Components made up of multiple MSC may need values
> from each MSC. MSCs may take time to configure, returning 'not ready'.
> The maximum 'not ready' time should have been provided by firmware.
>
> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
> not ready, then wait the full timeout value before trying again.
>
> CC: Shanker Donthineni <sdonthineni@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Added XCL support.
>   * Merged FLT/CTL constants.
>   * a spelling mistake in a comment.
>   * moved structrues around.
> ---
>   drivers/resctrl/mpam_devices.c  | 226 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  19 +++
>   2 files changed, 245 insertions(+)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index cf190f896de1..1543c33c5d6a 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -898,6 +898,232 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   	return 0;
>   }
>   
> +struct mon_read {
> +	struct mpam_msc_ris		*ris;
> +	struct mon_cfg			*ctx;
> +	enum mpam_device_features	type;
> +	u64				*val;
> +	int				err;
> +};
> +
> +static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> +				   u32 *flt_val)
> +{
> +	struct mon_cfg *ctx = m->ctx;
> +
> +	/*
> +	 * For CSU counters its implementation-defined what happens when not
> +	 * filtering by partid.
> +	 */
> +	*ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
> +
> +	*flt_val = FIELD_PREP(MSMON_CFG_x_FLT_PARTID, ctx->partid);
> +	if (m->ctx->match_pmg) {
> +		*ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
> +		*flt_val |= FIELD_PREP(MSMON_CFG_x_FLT_PMG, ctx->pmg);
> +	}
> +
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		*ctl_val = MSMON_CFG_CSU_CTL_TYPE_CSU;
> +
> +		if (mpam_has_feature(mpam_feat_msmon_csu_xcl, &m->ris->props))
> +			*flt_val |= FIELD_PREP(MSMON_CFG_CSU_FLT_XCL,
> +					       ctx->csu_exclude_clean);
> +
> +		break;
> +	case mpam_feat_msmon_mbwu:
> +		*ctl_val = MSMON_CFG_MBWU_CTL_TYPE_MBWU;
> +
> +		if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->props))
> +			*flt_val |= FIELD_PREP(MSMON_CFG_MBWU_FLT_RWBW, ctx->opts);
> +
> +		break;
> +	default:
> +		return;
> +	}
> +}
> +
> +static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> +				    u32 *flt_val)
> +{
> +	struct mpam_msc *msc = m->ris->vmsc->msc;
> +
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		*ctl_val = mpam_read_monsel_reg(msc, CFG_CSU_CTL);
> +		*flt_val = mpam_read_monsel_reg(msc, CFG_CSU_FLT);
> +		break;
> +	case mpam_feat_msmon_mbwu:
> +		*ctl_val = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
> +		*flt_val = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
> +		break;
> +	default:
> +		return;
> +	}
> +}
> +
> +/* Remove values set by the hardware to prevent apparent mismatches. */
> +static void clean_msmon_ctl_val(u32 *cur_ctl)
> +{
> +	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
> +}
> +
> +static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
> +				     u32 flt_val)
> +{
> +	struct mpam_msc *msc = m->ris->vmsc->msc;
> +
> +	/*
> +	 * Write the ctl_val with the enable bit cleared, reset the counter,
> +	 * then enable counter.
> +	 */
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
> +		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
> +		mpam_write_monsel_reg(msc, CSU, 0);
> +		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
> +		break;
> +	case mpam_feat_msmon_mbwu:
> +		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
> +		mpam_write_monsel_reg(msc, MBWU, 0);
> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
> +		break;
> +	default:
> +		return;
> +	}
> +}
> +
> +/* Call with MSC lock held */
> +static void __ris_msmon_read(void *arg)
> +{
> +	u64 now;
> +	bool nrdy = false;
> +	struct mon_read *m = arg;
> +	struct mon_cfg *ctx = m->ctx;
> +	struct mpam_msc_ris *ris = m->ris;
> +	struct mpam_props *rprops = &ris->props;
> +	struct mpam_msc *msc = m->ris->vmsc->msc;
> +	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
> +
> +	if (!mpam_mon_sel_lock(msc)) {
> +		m->err = -EIO;
> +		return;
> +	}
> +	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, ctx->mon) |
> +		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> +	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> +
> +	/*
> +	 * Read the existing configuration to avoid re-writing the same values.
> +	 * This saves waiting for 'nrdy' on subsequent reads.
> +	 */
> +	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
> +	clean_msmon_ctl_val(&cur_ctl);
> +	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
> +	if (cur_flt != flt_val || cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN))
> +		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
> +
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		now = mpam_read_monsel_reg(msc, CSU);
> +		if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy, rprops))
> +			nrdy = now & MSMON___NRDY;
> +		break;
> +	case mpam_feat_msmon_mbwu:
> +		now = mpam_read_monsel_reg(msc, MBWU);
> +		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
> +			nrdy = now & MSMON___NRDY;
> +		break;
> +	default:
> +		m->err = -EINVAL;
> +		break;
> +	}
> +	mpam_mon_sel_unlock(msc);
> +
> +	if (nrdy) {
> +		m->err = -EBUSY;
> +		return;
> +	}
> +
> +	now = FIELD_GET(MSMON___VALUE, now);
> +	*m->val += now;
> +}
> +
> +static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
> +{
> +	int err, idx;
Can err be initialized to some error code e.g. -ENODEV?
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
> +		msc = vmsc->msc;
> +
> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
> +			arg->ris = ris;
> +
> +			err = smp_call_function_any(&msc->accessibility,
> +						    __ris_msmon_read, arg,
> +						    true);
> +			if (!err && arg->err)
> +				err = arg->err;
> +			if (err)
> +				break;
> +		}
> +		if (err)
> +			break;
> +	}

comp->vmsc or vmsc->ris usually are not empty. But in some condition, 
they can be empty. In that case, uninitialized err value may cause 
unexpected behavior for the callers.

So it's better to initialize err to avoid any complexity.

> +	srcu_read_unlock(&mpam_srcu, idx);
> +
> +	return err;
> +}
> +
> +int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
> +		    enum mpam_device_features type, u64 *val)
> +{
> +	int err;
> +	struct mon_read arg;
> +	u64 wait_jiffies = 0;
> +	struct mpam_props *cprops = &comp->class->props;
> +
> +	might_sleep();
> +
> +	if (!mpam_is_enabled())
> +		return -EIO;
> +
> +	if (!mpam_has_feature(type, cprops))
> +		return -EOPNOTSUPP;
> +
> +	memset(&arg, 0, sizeof(arg));
> +	arg.ctx = ctx;
> +	arg.type = type;
> +	arg.val = val;
> +	*val = 0;
> +
> +	err = _msmon_read(comp, &arg);
> +	if (err == -EBUSY && comp->class->nrdy_usec)
> +		wait_jiffies = usecs_to_jiffies(comp->class->nrdy_usec);
> +
> +	while (wait_jiffies)
> +		wait_jiffies = schedule_timeout_uninterruptible(wait_jiffies);
> +
> +	if (err == -EBUSY) {
> +		memset(&arg, 0, sizeof(arg));
> +		arg.ctx = ctx;
> +		arg.type = type;
> +		arg.val = val;
> +		*val = 0;
> +
> +		err = _msmon_read(comp, &arg);
> +	}
> +
> +	return err;
> +}
> +
>   static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>   {
>   	u32 num_words, msb;
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 81c4c2bfea3d..bb01e7dbde40 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -196,6 +196,22 @@ static inline void mpam_clear_feature(enum mpam_device_features feat,
>   	*supported &= ~(1 << feat);
>   }
>   
> +/* The values for MSMON_CFG_MBWU_FLT.RWBW */
> +enum mon_filter_options {
> +	COUNT_BOTH	= 0,
> +	COUNT_WRITE	= 1,
> +	COUNT_READ	= 2,
> +};
> +
> +struct mon_cfg {
> +	u16                     mon;
> +	u8                      pmg;
> +	bool                    match_pmg;
> +	bool			csu_exclude_clean;
> +	u32                     partid;
> +	enum mon_filter_options opts;
> +};
> +
>   struct mpam_class {
>   	/* mpam_components in this class */
>   	struct list_head	components;
> @@ -343,6 +359,9 @@ void mpam_disable(struct work_struct *work);
>   int mpam_apply_config(struct mpam_component *comp, u16 partid,
>   		      struct mpam_config *cfg);
>   
> +int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
> +		    enum mpam_device_features, u64 *val);
> +
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   

Thanks.

-Fenghua


