Return-Path: <linux-acpi+bounces-18680-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF6C41F0B
	for <lists+linux-acpi@lfdr.de>; Sat, 08 Nov 2025 00:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF7D3B56C7
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7239230FF3A;
	Fri,  7 Nov 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kmfQXG3X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022130.outbound.protection.outlook.com [52.101.53.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8530FF2E;
	Fri,  7 Nov 2025 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762557782; cv=fail; b=vFcgRPmwkairbd7dsvdwsIP9F1IDUEPiE+ESKMTtrRq6dfZudE1dnbj1bal09be2WJpvmm30iXNOeIsexy1x5u7GvfhxVWg8lnbxUxMfjwMpGwgPjfPBsbQJIGoSgbyz5CfdGkadevxxDCUiKSH96dLJxtJq1/scRSC1Dh2I3mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762557782; c=relaxed/simple;
	bh=zhxjdS4teH3F6FAcWa5YeOhbypVUm+7DwFMPQvb1PFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=RBrjFuiLFbygAdw93ISVim0phMBFJ8dSQUNhQGE7hKadkeEjt0Yuu6Pvb5doatWozynO3OZqK2Z2LSllgaXLii7Mya9xPQin29mvhVolB7JHeStdvWKY7iy6Zvvht56US27iPja/8jO0TPSyr4KpYbt63N9GJ3OByOenaYn4fI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kmfQXG3X; arc=fail smtp.client-ip=52.101.53.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr/pxxHEabgxO1FymyGGkRxTi4tvKlXLqi2C1I9d5O+WomhKxrv/4Pl+pWeN2VyvP4KwznSTLHX543r9iyMTp18wQ37AIkQkpAwMMlkT4rkg0vy99jpOhRUr9EcK0W4q2krkVnfnqnONE5jhw5LQYgCeTmt/Z+2isI178ekMzVlJ8KBmvCFVVClzEAQ+aa21ZtMkMjtqEBK7nHGR0CocoegLZ70DMroEVd/nC24OE26g8c3bJKfiekY54dUaBwwnkHGIgQE5tV1WRUqMv5lVXGVfVkV+WyyKBPytCoThiBQXqdxW5+iRRWYUDIgR+WbyoArpKK/GjTRyiYgdtrFydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANMYD83H8FGur216UUMrpjKfvdGNWRF6bDKSKDrkM7s=;
 b=KcL9RSJyKEKK8M8LjjQlHmILecHUIc0/eYRQRc9zya15oeskQHVvAWZBqz76hY7OSAmgatOa0xvhqetpiTuqrs+GiQC40QagGAHBLVEWsMJiqvmh3PbitE23G8wHAGZODlhFFphF8iYA/OgISFANuYeQZdeFyl28IzcGKYRU5oN5Vdz3xkZNzOvcZOM1s2H2ifUiC1ms0E8eUtOVUSQfCYG1l+ecjI849m1/r/HykWAIQu/Ei8N0yUU0KCzas/O7E1qzC1HXEVZZpkMafLYCLVRNH9sQwG2CzCrmm6t1mqgaze+KPNZF0WbbqvF2PCILMwgfYXASpRcwWFF58954mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANMYD83H8FGur216UUMrpjKfvdGNWRF6bDKSKDrkM7s=;
 b=kmfQXG3XjPz9zcluKoUp+R7PwmesUwiENpMPdOtUMi4Df4kfqaAEJEYT5K9u7Zdo0coe3MYd/ttTM2UsGt2T7UxIxJvaP3+ZX3ws+WoS8VIyqnxb1gA8T+qoIqEk8gpRG+GQVMOW2BUzGpQv4oA5cpFozb5dAx2D653dtY5XNkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 SA1PR01MB994236.prod.exchangelabs.com (2603:10b6:806:4a1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.13; Fri, 7 Nov 2025 23:22:57 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%2]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 23:22:57 +0000
From: Carl Worth <carl@os.amperecomputing.com>
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 catalin.marinas@arm.com, dakr@kernel.org, dave.martin@arm.com,
 david@redhat.com, dfustini@baylibre.com, fenghuay@nvidia.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com,
 sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, will@kernel.org,
 xhao@linux.alibaba.com, Ben Horgan <ben.horgan@arm.com>
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
Date: Fri, 07 Nov 2025 15:22:45 -0800
Message-ID: <87y0ohbf7e.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::29) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|SA1PR01MB994236:EE_
X-MS-Office365-Filtering-Correlation-Id: 27169ffd-2574-40d8-db05-08de1e5495d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNiHbzB1wG22Qd4fxQODgNHU5iPdydT/dCpDt67CiMeQiLY+3FJcFYg2ryPm?=
 =?us-ascii?Q?WBnJ6+frErQlFq1eeeh5RvFL8wX24/Fbi10kapBTb9m7roYD0IwbteAcikHV?=
 =?us-ascii?Q?pKTYhEnqBq2m4LLUyUmBwDdK80I20fr6kFe3LBbIrrGJUIfijcqtxa35FzRz?=
 =?us-ascii?Q?iSeIHWR956PWPi6y8TDJ3hEpPFqoVUedbizZlOfOK+c3b+6p51HF0a88cY6S?=
 =?us-ascii?Q?QlZfF96jedBy98bkktTcMuwcqUMfaKMc6gFd7LUrY9xILhtlfL80CufjRj/O?=
 =?us-ascii?Q?HNNWsv0rkAI9QxVXo+oSIpAo4d0A0Fot0qLvE1QDYZFxW3lGZQ9BHFV3dZn8?=
 =?us-ascii?Q?RncqggRTIpFEmyzXsO3YgXRggx+sqbTYRwDoNAUYufvJ7UVGCDW5d1sxJf9W?=
 =?us-ascii?Q?zA2rarIZ9HexiPz/01jYpwpUmaCJKVbItl7ptMetrNTmnJFsj0hW1QuetQ0N?=
 =?us-ascii?Q?ahmOLgM0rWhzhMvJMAxz95Wcq9X5MeNDcoRkyYBDsAEJh9CCfRoI7dgqdvcd?=
 =?us-ascii?Q?XwzWLLIZiF3NhtMxEgenEvd2lr34o7DK9qTUk7IEYh4qCLHahJLl7VJ5wC5y?=
 =?us-ascii?Q?ihBYXjKEj+tVxYfapl/PEOZsDZMIICJONj4Vtyp2vHYpPY9Lzwt6roeqHVYg?=
 =?us-ascii?Q?dN1Z1BXv2iygnLQYuXg7d1lWUGanNVBB2EHo9U/+L6s66hl+uYYPiuCiB+S7?=
 =?us-ascii?Q?I2a1KW0mS/Zg0yel2evUKGPeguFMi50aLFGhJMa9H1qtQsO7GQdD6qweZQyR?=
 =?us-ascii?Q?a0/06m7Jp78pRppXEU02IkM0CjLZFhxWJQcgBPmpHvG8McTofPiS6rOh4d7X?=
 =?us-ascii?Q?ktkVf1q9CHImGOuURehkl+fESafsHgloBBmikrTzojdUQpNcD9jNFuVwm9bA?=
 =?us-ascii?Q?kS5XQKNXyldnWxHeGYcudqkFqx/zYOaSJdXnHZOduVInvqIH/v4Cas0KvP67?=
 =?us-ascii?Q?/Fw9WPuisi7bV5jt1ipuedBXTuBQSRiCCoE4aE6xvKaNSgnWnUDQbI2OB5or?=
 =?us-ascii?Q?Tv6hMCdpZ7hC9N5u20VFbnxpGw9S1/Xwqb9ccKCYlJ1pzmBlpmiyDaKxrXim?=
 =?us-ascii?Q?KVh74YQI9xKi1UNRdbxQ4j4+xHa36v33V8E1m0tN2FBK1P50J7+OMaf+LlVi?=
 =?us-ascii?Q?dgCuLN8ROdV4GMp15G6feMvgpa5Fqvse9kIr+8fU+Pc4j+QeQY43YCgGUaSI?=
 =?us-ascii?Q?iZ9xMAeC3ZLFZEgd0pZrDiEgKWmPrccBFFv2iFNF+qbYpe7xm2qaPEB7IGMf?=
 =?us-ascii?Q?2ih4ZknxqdewauJGpao0wGMl6TGygUhW0vYhR7LWUym3aCHxOTTHo+eJDZ3p?=
 =?us-ascii?Q?eJ/x+2+33GeTvSeiISYnP5Kn3Os3lPc6agqE1aZYJc0e1al/fLwrF1ErLL5G?=
 =?us-ascii?Q?CAygsuWQ3wEEQ7Tdk3AAb3sVGh+q2HAeKt1lMz4yH5Vi9ov9J8HUufRR2TJd?=
 =?us-ascii?Q?iKIcPhLNnQDUCR/WcQegdYTnk4wrdkO4XZhYlexopaBq+19BL+NHYwQUsG0j?=
 =?us-ascii?Q?ixxgsHZJhCZGut3Y7nhHe8dQECDbSskffaJD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ekMQarHADsYro1vZ/62GwK1sD6aFRvq36EiKHeUKJlRcG/G9BEPXAYBebW2p?=
 =?us-ascii?Q?a8yANesczj6FHAdw1FcaR+m0RYxgwzOL20W00xEIeIun7MtCoL7abniW9sir?=
 =?us-ascii?Q?EvVqi/RtrwY0AIbFMRbodWUx+Nzv5A/Eys75aI27kOr0PVSFoF71Jew+Nc1N?=
 =?us-ascii?Q?zu0oTQ3wFs6T1Qm+LlSc1fmnp8p6iitdJK8m+iEZS0due4UNMQxW3d7MKlPH?=
 =?us-ascii?Q?EI1gIpwb1HU8kFtPJ73JjlyWxE1IViUauzzGfi8nIJE3Lrl4QpCwzrgwDQlH?=
 =?us-ascii?Q?/TuOlRgrlahq7MGLlGuaamTTfLM0ecklBhWvSfG4I/yl25zEFXsl4pXzdTci?=
 =?us-ascii?Q?/XZjD9OmH4Wujksh/+k4t5WTdT3SRYUbRXneZAz6ap0UR6yG3n6/Jg3K2B5X?=
 =?us-ascii?Q?mBd7Ohcvpfse/3JUJx3Q3rU1aGgg7+UhqsNThTVOyJej3Epu01d0BBIQ9CP6?=
 =?us-ascii?Q?17jzZpKmjzO9NJGRPiQYmDbHDC/x5oJEOpnOpBtJ9kOzOagDpTlEnXRVdrAB?=
 =?us-ascii?Q?kpHW6t2PGMw+nDQDVvJhtBWi0fbh7Euco7/tMwAgr3rMn8liybww9LRpVxl3?=
 =?us-ascii?Q?tpSMi+RwWLz9gPuSuB4CIPxJzs85fScEmzmjauIbKBIo31wKEG+yHODj7w4F?=
 =?us-ascii?Q?C++JJaUqzG3PzHJtYFYhgbO2TJwZfQENk9ZUYIMTvo4E84m41KKkoV4K44Nc?=
 =?us-ascii?Q?OboEOImn116NLenhHNpUqDOW+Z+vRt1QtBFWLuEy50z1hY0kVKUHgp+S7UQ+?=
 =?us-ascii?Q?bVGjeqfJwS8RrX+BweqrdhmMaLYe0eTyNkfFdPRrr3xQb+VBR6eZ6T1pJdm4?=
 =?us-ascii?Q?tbrMQ1JmSWNYtQNB/PFRFI4jh8mEcCXKpStNlkZ1LkPl5LFWacrbvUEPnkrN?=
 =?us-ascii?Q?AcQoEGg6QtFsPmN/TQb5cd4Z9qIpS+yayLPW5ok+xmYD+ZnYG+JKK5J7fhen?=
 =?us-ascii?Q?ozQJnBC8rpOyQk+PdLa71rhfViPojz93ykIRuuZWg+9OdDI868PuCKQ7pGKP?=
 =?us-ascii?Q?9KChSmMLMrNS0WRAileofxA1LkR25LTmBJBH4X1AwJXF1jpc2cmheE9TnSBu?=
 =?us-ascii?Q?39yI9BUa/3oRq2t5Y35q7MD21M7+BlIXxo9L1B9DUkJ6cuvVp7Cnh0FAerpQ?=
 =?us-ascii?Q?XLv9Z8h5rHVrefFKzOJI1x5lx68WUX7iOdSpMdEXwmB3kFmLERGgABK6+Y/K?=
 =?us-ascii?Q?D/bx2UAtpoAg7p7MDWPa/B9eBtJsgpU3lwgkYkhoxMU2GnxsgUeg/GDtvNYu?=
 =?us-ascii?Q?hbphjokhksKNg/sfIBJGyanpQY9CDiNLuq2gxPaXDZOnyUCGB2kJ4fzdy3z/?=
 =?us-ascii?Q?ksLyBUowImynM1n4cWjv8sas8mdINCnGAyhyqChU/8jlK15PaCTd7QLk8mpS?=
 =?us-ascii?Q?kH0dcz0jjcfAksZzRFemVrV/TejV4DY9fdWDvD7zwKjctNLx1sGKotc2zQ99?=
 =?us-ascii?Q?+4VBUhxAHGM1gf62R74cSdK+55vJ8QBtziR/CmwioJ8hfuX1L/L+xIYn0Boj?=
 =?us-ascii?Q?KkZKtjPOD/StApb4eLWFM2qyyOde5SecDvxO5S521EdmPTWBKe6rqIMVfhVT?=
 =?us-ascii?Q?VYT9uEoCZbISEqgNzz1qjpwPSVIqcm9G6FoFfhaz4KkL6jHmyLHyeW6XH2DL?=
 =?us-ascii?Q?Fat894Dd3fJgVQ9yDb2hR9o=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27169ffd-2574-40d8-db05-08de1e5495d5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 23:22:57.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHqSydiYINQTiZb3CB8vCxwd4UpwzBp7FwLm69bCi/qATymQsm66qKbg5NnnhfYgnTLBdgD7y/20Ja4hjE5e06ODfeSnhB4nuTVA2a0jxVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB994236

Ben Horgan <ben.horgan@arm.com> writes:
> This version of the series comes to you from me as James is otherwise
> engaged. I hope I have done his work justice. I've made quite a few
> changes, rework, bugs, typos, all the usual. In order to aid review,
> as Jonathan suggested, I've split out some patches and made an effort
> to minimise the amount of churn between patches.

I've built this and booted on an Ampere system. It ends up reporting a
successful message of:

	MPAM enabled with 1 PARTIDs and 1 PMGs

So the code seems happy enough as far as that goes.

But the expected number of PARTIDs on this system is much larger than 1,
(MPAM with a single PARTID would not be useful at all).

> See below for a public branch. No public updated version of the
> snapshot (the rest of the driver) I'm afraid.

Looking closer, it looks like the bogus value of 0 for mpam_partid_max
is because the following patch (which does appear in James' various
snapshots) isn't present yet in the code submitted to this point:

	commit 33c1f50970917ac9f2a8e224d850936374df6173
	Author: James Morse <james.morse@arm.com>
	Date:   Fri Jul 4 14:22:30 2025 +0100
	
	    arm64: mpam: Advertise the CPUs MPAM limits to the driver
	    
	    Requestors need to populate the MPAM fields on the interconnect. For
	    the CPUs these fields are taken from the corresponding MPAMy_ELx
	    register. Each requestor may have a limit on the largest PARTID or
	    PMG value that can be used. The MPAM driver has to determine the
	    system-wide minimum supported PARTID and PMG values.
	    
	    To do this, the driver needs to be told what each requestor's
	    limit is.

So, I guess I'm wondering what more I could do to test this code at this
point, prior to merging it.

I'm very interested in seeing this code land upstream as soon as
possible, and I've got access to an implementation to test whatever I
can.

So let me know what else I can do and I'll be glad to contribute my
Tested-by when I've done it.

-Carl

