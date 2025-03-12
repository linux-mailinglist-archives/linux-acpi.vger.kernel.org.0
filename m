Return-Path: <linux-acpi+bounces-12155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797CA5E76B
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 23:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C744A18993CA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2101EFFB5;
	Wed, 12 Mar 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="i2Ig5dhc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023124.outbound.protection.outlook.com [52.101.44.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E519E96D;
	Wed, 12 Mar 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818481; cv=fail; b=pE6xpSkS6gIoXPxqEOFF31leYI8gWdrqhlP4uKyzuuSwlfrVHFCDcO/NPik0rJ+RM43fpr/yBGVID+MGxBXoKC4lAHiQh0PQDoJy5G1stKhGlxg0J7fUbfkYz4F+B50Onl9KeHquw7U3ijbIh3ihN/pm6AOLnxCHkwbTssjzle4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818481; c=relaxed/simple;
	bh=sQOb8UxCwz160Zh9rhGOKXm4TIoYhrklm2o+90zdHrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XESEoFap3uDdXrK9K+fWotDIi7e1Im7fz6izuCZx4rpPpIaouUbe2wQ93rEwdsGKKSHcub65Cgchge87XyE9ypGUZTIk2UuPse/ULbDQLPgWZlqu9E/N5rymnqJvvLfWUBsAYcUY0yVxN34gMXyPOrc03PyZUbFa/UAgYX5JhpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=i2Ig5dhc reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.44.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/Uj9QPPOq27xH29HJshzVquD936DUZ6QnvyWJlp3PPEqA/4fpNVOYP948cakWNVppQqhQ3s6YorM3kDHH/w8UEzErz/JDntL6pqKPEi/4Aep3ThnIIqVaaVdveq4PATRCAqy18ij8+iTvdHodad1mJno6GkEZs3cywWA9nokZmMkxUIBn1oxr3H7XLgGYVR1cPn0t7sfJWeGeTgvJ6lq4CGUCNynUies/t59jikamgaTTS00NtW/EvyR24YzgpGYjHER4hTyW6/aKoTETYqdq68j54PTzeESXRmkvSszU8RyO48+8yjWLUW3a0DCcaucQ6054b3Vwe/7loV4NVvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD+8t/wI6+bxuSuPdZPchvhwgI+/+3nKPs4A0j8lQJ8=;
 b=g1h/w0hIGyuk3vKVbevYxN2mFKpWgOFdRN7I0T2UKviaJl+LTyeUo8kJnsaT8Nqn0T0Myzx2LqYKCHSasjDKCDBofkXKlz2MoM7Tcb0kfjikm2dYpw4oQPD7FqZherYWZheMVyRLnKPtQKr3DJ6FM/4O1xO284m4oNB5wGZnYEUorN8rF4ibez/i5URz5gMPNCPW6rvZO4dLMPmAQk6wOYVW0kXTk2+ZtVnNSDjiWdmRsgWVY2qgfVGF+5LBe4Ck6hKKDpIgqe3P9xHQleIvDysNeWMCDa9M4ayKmAsQWZemBjGJsxG8/6jWySizM7uKckc0DMMRQ5gWkHRuGMyApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD+8t/wI6+bxuSuPdZPchvhwgI+/+3nKPs4A0j8lQJ8=;
 b=i2Ig5dhckPdwbCJbDnWDpkTgCavt7GKZI384DYTk4Q/TsSD2W12v6s+UtjRkbObXUwXXyqozMxOxlhwut2AuUuFUOYZANQOSw0Ll0vobetKLDNlp8o9wIeFCnlU8OSNNbM0wQ9LB2osBi39nWOjWpyrWnc53Y3XidybNRR9E/m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BY3PR01MB6788.prod.exchangelabs.com (2603:10b6:a03:360::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 22:27:57 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:27:57 +0000
Message-ID: <7066ea08-9476-470d-af11-71325484824b@amperemail.onmicrosoft.com>
Date: Wed, 12 Mar 2025 18:27:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] mailbox: pcc: Use acpi_os_ioremap() instead of
 ioremap()
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-5-1b1822bc8746@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-5-1b1822bc8746@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::20) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BY3PR01MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 164bd279-02fd-45a8-7069-08dd61b523e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXZXdVRYUm1lQkFNNXI5SkZaaFIyK291em5RQmo0Z25TRjlrRFhSeElLSVFQ?=
 =?utf-8?B?SFVQemRFYjhmZC8yZkFFbDdZYzVOMTNNUERFckJBZEZmbk1ud3Y5MzE2TGZM?=
 =?utf-8?B?eWd6K0U3TjJoWWk0Z3p2MnlnQlNGYmEyT0k5OE52RWp4QmhDRko3TmRSQmdi?=
 =?utf-8?B?MWJhRWo5NjBnU0UwcUE0YXNtK0tQd1pBRUR1T0dJbEwwZGxUZU9sQzFBV0No?=
 =?utf-8?B?WFhQV2x6VSsvdW0yWHlqSU81ZGE3SXgrRGJ4emdncTd5NlF4WmNJRkhEcnZL?=
 =?utf-8?B?U3Ewc2hVK0kwOVNuWklBRGJoUzh5TVNQZkZaRG44RGxJRVk3SDliLytwZXNU?=
 =?utf-8?B?ZkpNcU1oOWV0VytwRUR5L0JubHc2YkFxb0xXYTFMK0FaT0YyVTJKWTd0RjE2?=
 =?utf-8?B?a1FScEZSTG9ST2Q3ZEtJN0pZUXlDWVBnNkYrRzdZTzF4bVJTNzZDMkRSeGFk?=
 =?utf-8?B?b29YdDlpRVQ1WUhadERIVkcrUHltd2dtMC8zOWw5bG90OVRLeHRVOUkxT0dT?=
 =?utf-8?B?MWJITFZ1SEdXUk54UGFqMHYyVzhRdC9MaHFNNG5EN2J0RkZ4N1FOS0ZRclEy?=
 =?utf-8?B?WXdDWG5obElGenc5QmVFTGxTaW1oeFJWZXVEOWgvenFSQWc0WnN5eTJtbnNE?=
 =?utf-8?B?R2tyd2ZjOEVxYnhHcFAvd0ZBaGtvd2gzRXFDTTVIVzZTUHdUdFFtSlNVcEdq?=
 =?utf-8?B?a1N1OWx4RUVHMWhVZGpBdFAwN0ZZWGlINmhCQ0o3L3hDcHhsdDljZWM1NFow?=
 =?utf-8?B?SUZxTU1rdjNYNkNOVVJnYnh1T3ZFcDB5WGNSTXBaK2pRa2FqVFFLMjdyRHlV?=
 =?utf-8?B?MTZYbWlnRTNzK0dxa0xab09NNHJzeVlndm0vNmtwcGN5Yms2YkI0ejVzNk1o?=
 =?utf-8?B?MFBzdU8zcEFxMm1SQ3BQMVhjdzgxcTFIMUlSWFN3ZUs3d1EvamNmTGlZd040?=
 =?utf-8?B?UGxOdGNBaVBsdmhGdzdXNUZ6UjhoQ1FvYklMTEpZaEZreWIwZXdYTTV0dXpM?=
 =?utf-8?B?R3JBSk1RZTF2cGtoZ2tBbXdnbnA3YS8xOU5saklxbmowTWJjaG05dGlJanNV?=
 =?utf-8?B?VFRiZGtZSlR5WXFPZW9GZGMweTM0M0NXZk9zM2R1Q1B5a3pEV2wwaG1RQ2JX?=
 =?utf-8?B?VWtaOXBuaTNEdExjaTBlK1lEcHFoZ0Jzb2lGOFVJU0xvM0doRnowT1BJNlNH?=
 =?utf-8?B?ZWdUb3ptN3JNbUJCNHdyWFNEVzM3cWk1UkJXdHBJNllLZXBUM0tlWUFmUG9N?=
 =?utf-8?B?eGVPODF2L3UwMjlYNnlKS1FsSHlWb3M5SEk1VHFVV3QxdFZaN3N3QUprQ1pL?=
 =?utf-8?B?UGgwVXErd0tPdGNZVWhZbjd3T2txM3RNc20yeWJtVnpDdXFjQkJHTVVEWU9N?=
 =?utf-8?B?ZU5uMUJlMVkxR0dFRG9hUUtaTUdhdk9VYjZSbElzYzA4bEdoWkxXbmsxemsy?=
 =?utf-8?B?YzgzYm1oNkpaWDRGaVdKSnRjNFVudXFUVlhBNEJab3hVSitCMFpDREpPUFU4?=
 =?utf-8?B?OVhhK09NSWhVNEVCTm1ZSzBqS0ZNL2lJNlNMc0l5MTBzcGZkdXlCTUVwVE1t?=
 =?utf-8?B?b29DUFo0MXEzaFpOcUFNN3lMYlZxR3d0YVBBbXRxY1NlSytvU0E3SXVvVFJC?=
 =?utf-8?B?RHRIVzFISkx5Q2dYUTM0Q0t4NWIyQ0lVUlV5MGgwa1pEMVRMRFk4eDQ0cE9a?=
 =?utf-8?B?aE5oWmJ1eHZNaDdxNXdMQnZoRDEyQldVZW9uQ0phRytKRjlSS2pzUzI0Ny9n?=
 =?utf-8?B?KzVXbStINlJYaFd4Y3l1SmxQSnpyNXlvTEU2VDlJN0RmVlYyTHM4OHo3R1dG?=
 =?utf-8?B?Z29oa0lVMU5IMHQ2b1Fjckk4dkZEdlhxSEFnc1dpb2xTVklXQmlZMTBwb0tT?=
 =?utf-8?Q?2S5gXWiKMxHux?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0JiSVBhZzZLQjg2K2puTjZ2Z1JjZG1yQmhaYSt2ZS94S3V1ckdiVVp6dmd5?=
 =?utf-8?B?MC9iUklBTm84dnVvS0RobzdOVkoraVhhMnFnT2ZPQmRYZFI4ZGlUbWJ4MHdu?=
 =?utf-8?B?L3djMzdOZFJHMmZITnkwZHdZNE83TE1iZ3BMcGlOU2g0UFM0dVhwTjNaT3pk?=
 =?utf-8?B?dWROckE0ODRQckZPaFBtVjl4cWdidStkZTBNQTByWldlSUFYb1FpZnpORkw0?=
 =?utf-8?B?elVyNHVDampYTkJ1SmU2Qnpoa0FZWVA2MUVhUStkcW5KbSsyQkErdWJ5NlIw?=
 =?utf-8?B?d2NMdFF0b2tjZ2pGT0pVTTBsenIvUWIxcHROQ09telNJTCtDaUlzR3Z0WFQ0?=
 =?utf-8?B?TWRzYU81anl5cVJBRzlYZ3J1WVNOcmhycXpOT0k1d3FNdFpleit1TFlvajhY?=
 =?utf-8?B?K3ZlMW5EMy9sMFo2K3l1UXVhWWtlWGF5TWtXRkNCZHc5OXFQalVYaG1PYnFt?=
 =?utf-8?B?b09TK2Fub0x2TlhjWmlzZzdTWC9TaFJEeTdVQ1V6VndwSUlhRUhIcE5Oem00?=
 =?utf-8?B?aDlSTHFXWnlsWUNlN1NDUkV6Tm5KRnBUWkp1ZTdTdytKa3haQUF0VVRRUzBM?=
 =?utf-8?B?WDYvamk0bDNJVmdGdllDYlNBNVo4ZFk3ejlnWXBWeUFRc2Fib1lLUkFaY2RB?=
 =?utf-8?B?NnRaVUp1WGVKWG10aVZ0dGcxakdBY1JmcmVVV1djL3crN2ZyNVRkREd1V0VM?=
 =?utf-8?B?SHQ1ZEY2N3U3Tzhxc0UzK1FUUTRpWVJ6dk8xSTVjWTR1UGpQM014STVwbzBo?=
 =?utf-8?B?ai8xZDJyNjVsRE5xcmZYN3pieWwzanhXc3VoYmpOU29LM0JVcExhM1JJNUdY?=
 =?utf-8?B?MG5uclJ0K1pNYXR0SUoyWWFOQU44NW5zNFNZa3o4VDU3K2RaTm1kU3B0ZHhG?=
 =?utf-8?B?OU94U3NUNWhhNkFwR3doZmZWR09RK2RVY3hlRnNWQ2tqRDRDbHNIaEQ0U2Nl?=
 =?utf-8?B?Tkt2emt3OG5wamZ6SzZxbDNJMkdHSDFYZVpqRTJqWFVPKzN5bnBkSHpYLy91?=
 =?utf-8?B?QXNDajBvRmNhaGlHSExmL0RWaDJUaEtjWFJPb2szVFZUbWtDQzNsSVphTmwx?=
 =?utf-8?B?Y2UxeW8ycTVBMmRHQ0Q5bndWMnZWR0lyZ2lPdE9GVTBwK2FtU2hHRWhvRkEr?=
 =?utf-8?B?N0RnV1EzZ1BwYW8yd28yaUVlWVcrdkEzK3RYQXhubUJnaHdCKzJxODRxL3Vv?=
 =?utf-8?B?ZmRaT3BWK3duaFBpZm53VlllRDN6QURZdDJRQkJtREJ1blFpZVZlN0JYb0w2?=
 =?utf-8?B?WlV5SExYWHNLbk9nbTRKS3NCYndtNXhNVkVwUTRLcGNpcm5CTUltbU84KzNB?=
 =?utf-8?B?VmMzbVFXRnpXQVNFUjU2QVc4aERkOHQxTnIzYUE0SGRGOHRDNnVSOHZkRnhJ?=
 =?utf-8?B?dUErRmpOS3c4RXEzbDFNN09VbE9EdTZKbGlTMUlsWm9ERjhpZDRIVmN1d1hu?=
 =?utf-8?B?MjVLeVdZNlJOZTlMSmdKNTFzcGRwS0VzcW5OK0YyVUlsajlnZmFXNDBITy80?=
 =?utf-8?B?MnE3N3o3QWY5eDRIUlVocEl0WjhrYjV2VzJIV29RbERlZ2NZbVJGdVRlam0y?=
 =?utf-8?B?dDcxc1d4cFlSeXBUQ0RraS9FVWZBQzVXMGMyZU9OUEFmM0xVd1ZzSW4yaUx5?=
 =?utf-8?B?cFMwalBNZ3o3YTFRSWc2SmRjTWlCa3Y5WEkreFZ3U2g1MmZVMk1JcG9ta1lU?=
 =?utf-8?B?SXVjb1VRQURlVkJDZHRGWlAyVmdSeXhNT2JEZi9GV2dOUSt3eGJPOXFYVzhl?=
 =?utf-8?B?bENTWjJFTm5nOEU5a3JIRURsNm5hTTdBZTdsMW5GSktHTlhFS2dsNVpPK0sx?=
 =?utf-8?B?QXJqY1g3bS8xY2xDbUhYT01XblUvSktOUUNRaStrZGREcWEvR2U0RGw4V3h4?=
 =?utf-8?B?WnlwVnFhYkI3alFEYUNVbk1ub0ZIS2M1clRPeWJ0MmFCVThMdzY2RVQwaEdj?=
 =?utf-8?B?YmlkQm1HQjZ2eU1hdW10eUZoamwybkliSDVTazBQMEhOOEk0aVJaTEVPNUVw?=
 =?utf-8?B?TVhwL082OE1rOC9hRnROQ3o5b1doWWVDZzJyaW9tbkx5NkcvbGljY1kxajNn?=
 =?utf-8?B?T1pRMlcrRXlwbnRkOFNsT2FiOUhLRVpma2g4ZWlwUGFOb1hoWmV0RWlZSk9T?=
 =?utf-8?B?UFVsVzdiektsN1pxbkNnRlZoSG9xbjliMzRLRkV0TXc3YXRvUG5zb0F6RXV0?=
 =?utf-8?B?Vk0zMTJXSmhISEFqMnRzUWNGWEZFanBKakZqRzFDUEF1UVFwcGo3S2xtMjRB?=
 =?utf-8?Q?2WuRHUaL9AmNP1+q7KYLq/P67z0RctQMw/swUpws8Y=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164bd279-02fd-45a8-7069-08dd61b523e5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:27:57.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTAXP3tMuAKY9xI326O7FZhjAwWpW0OpsVPt8v0I/dIEnVX9m5og9jawXx1fpR2wkgX1Sm05TRhJNggiHUVzgnReNJRHQWUAXzls86LUyLAs0OMDiT3kFJuX1KpU9IP3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6788


On 3/5/25 11:38, Sudeep Holla wrote:
> The Platform Communication Channel (PCC) mailbox driver currently uses
> ioremap() to map channel shared memory regions. However it is preferred
> to use acpi_os_ioremap(), which is mapping function specific to EFI/ACPI
> defined memory regions. It ensures that the correct memory attributes
> are applied when mapping ACPI-provided regions.
>
> While at it, also add checks for handling any errors with the mapping.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 5a9ae67f5c50a3e43d30aa368c31c80b81db01f7..b1b8223b5da7002fc522523dbc82f6124215439a 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -418,8 +418,12 @@ int pcc_mbox_ioremap(struct mbox_chan *chan)
>   		return -1;
>   	pchan_info = chan->con_priv;
>   	pcc_mbox_chan = &pchan_info->chan;
> -	pcc_mbox_chan->shmem = ioremap(pcc_mbox_chan->shmem_base_addr,
> -				       pcc_mbox_chan->shmem_size);
> +
> +	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
> +					       pcc_mbox_chan->shmem_size);
> +	if (!pcc_mbox_chan->shmem)
> +		return -ENXIO;
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
>

tested-by: admiyo@os.amperecomputing.com

