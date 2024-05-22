Return-Path: <linux-acpi+bounces-5940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F38CC24C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0631C22979
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEBF140388;
	Wed, 22 May 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SL1lmUfd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74787140361;
	Wed, 22 May 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385221; cv=fail; b=PRbJly6ctpDRTfD9dysjTmW7jKXAHHUMZ3Cx5uS5DufgzHqsnq4JN67CGG1wTOilXpmy5dB3HowqUtl4G5TEYRe1qf6ACITRjR/a8Kntu+tmAHI/we+ph87n8VUiz63ZWcEKGa5YqSai6l9kzCRt6HyGp86TuXvGS2vq5SF/0sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385221; c=relaxed/simple;
	bh=9Y+oc+IApwQP5lmeJd+gZbcsQDw2gieAMnrUq+zRMz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LyZd+KHfzFvA1B+Bx0XL+g7X4wQzewdme7VlHUtTXDRft+m55A5Z+1yfBEfQbjfdsA2LdXIK5AClazoYm+a0PTJ6pEjbTwKrVcmLq/CnDftF/r6GApWT2fpws+zJPxGGY/+UkJH56f6IMlsDS0PqEDN4wGBfJw9PeLuAq0DOqdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SL1lmUfd; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxBeMP69Nlu3ezJlAFwjkrEZhO3Ms51QUdYLBHexS9AqZjbvlXsgYnB2dLxWnhyv9sGNoJrlCoDucBCavtALpXkBHpeBUwuxPUM40C2DeM69IiKqQkxSArlX0yRiHfmbwzbKm6K286DskX8zQX4IJYVUagmE4ue50kkfc/XqGEKSaw5q6OdNVE37ptqTOrrlnZUe9x3zhYFoz9xhYw+IZeqt9L/9lVIFWiV59xD9P3fHEQ2xZYZcEPBbwK0OvLHVpqfVOfy5Nt7frYRt0avjk+uxXqQvFA+yMv/2GSntyPFmLHtZQY25UooHb1FN+ybZ3IocvIjfrh4eyZJhYw8aQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGSNFbdYBdzcILWum/nOuyxHt+8Y1P1czP8zu3BsBvk=;
 b=UlTRgZyb4GZfEtwd9ZP8kM7QdmMoNMQDSu3JaOxqN5vA0JuAM5LqaHQiNx1UeQMmCrOM1Ltfi4eYn8+gb9lmLV24tKKho2Fr8sO4GFKrs0AjmmSyCdMuz6fNcY80vTlhEaAAF2aPTmlpAXECD7ShbgLhvWXk8QYD9+ny8HGeIAiokSEaLYxiU83hwxuSBNYcpWnxkHTxL7KSWgWczArjyIrs6Cw9s+JAjO2g07InWSJzb9VjbzbWykrjIa+qDmLoJpggncAzr0OiqIRBCHYhwgO9UHrNFxW9cuQpiS1PibxhHSiiubSbam6Car7BCs6/LWHXv+tnNWyBgZT7xeLwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGSNFbdYBdzcILWum/nOuyxHt+8Y1P1czP8zu3BsBvk=;
 b=SL1lmUfd7X1K4X4aQR40SLbrrvMujusutGy2A+7sUXwi2JvNkAXTTWKmCvWUFDSIO27ed3JiRThMqZ8GNn0jxuikKvvzulPzzDKMp/zG9rO3/f9tZiog/ewMNjqFc4pF0G0pjU2biMzuSj9I6NSMQhoMmtZTknCCEJTDNl8ZEKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 13:40:16 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619%5]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 13:40:16 +0000
Message-ID: <0da7f58a-309f-4e25-b2f8-3bd80902341c@amd.com>
Date: Wed, 22 May 2024 08:40:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: EINJ: Fix einj_dev release leak
To: Dan Williams <dan.j.williams@intel.com>, rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
References: <171633159194.398195.10059732788629089925.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <171633159194.398195.10059732788629089925.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:408:94::28) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 907e42af-80a0-44e0-ce0b-08dc7a64b6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG5pNy90ZjFyTG1tOElVNmI2bVY4dWtHeXMxdDN6MjRKakc0NWp2T3NtN25W?=
 =?utf-8?B?aG5aU3NpQmh5YkJ1ODR3Qm1ibFdmdktaOGRIbGp4clQ2UytqMSsxNUlKQ3pZ?=
 =?utf-8?B?VVVDQlcyWEN5OVN4Q2RrQ2dqczRtQzl0NCttbDdXdmNEN2swT1NSV2t0NUpU?=
 =?utf-8?B?blI5RVk2ZDZHNmdiLzhIUTJZNGxJNDJJTW9zL3diT2doaFVuK1N3VFhtcHF5?=
 =?utf-8?B?YVRKdGh6Q0EvdWdXeTAyM1Z4RzlTM21vMVhpVUVOSjZSL0N0Y3RPMGpnT1Iw?=
 =?utf-8?B?VFIxTU5VbVBvZVRiaFphVVpyMVRXZFNwdW9YRzRzS3hXTUFSdWtDQUZ1TU1M?=
 =?utf-8?B?dXRvYkxmVDZwMStqWEM3K2RveXRqOGlTVkllVCtXS1BWVGRCZzJTcGdkT0xE?=
 =?utf-8?B?YTVoVnlSS0tJL1MxTUlMTUUySllpdUJ3VjlIMlczOGJVaHlBT0Y4OFI4YUxL?=
 =?utf-8?B?Y1lSWWZ0ejZTZGcyZ1F6ZUxnTEVKOU1kZ0pxR3RubS9HbDEyY09Xa0RSNndt?=
 =?utf-8?B?Qk5JMTJZQko2bXNra3Z3VUdWU3FuVi9PR1BZbG1LOG4vbW1SVTN0c1daMTlx?=
 =?utf-8?B?OGkrVFh3WWxDcUcrV29ieExuNjMrLzJ1Mm8xTEhzUzZVdUkwdVlLdjllbDJQ?=
 =?utf-8?B?b09sdWl1RGRkdlJQRjVLckRpeDBwYTZnSDc1cm5aUUtHUFAydkhVYmp0a2lJ?=
 =?utf-8?B?c0tGQUs2QkJORG9WVFF3Sm1Wc3psQk9HdEIwbXhwL0hITnZyOTFJZDRuZm55?=
 =?utf-8?B?eVBFMFRlK0Y1Wmw5SWN4NGI0NVlqWjBqUWNuLzJWZ2J5Q2hQUmZOVGdGYVRL?=
 =?utf-8?B?b3VMbmJ3Q1VtWkFxZlFPS2lGTExhMjRXNUFuMHlHQmM1L2gzOGpQa3Qzb3Vn?=
 =?utf-8?B?RkI3RktIV1hsWFFVajVaUzVNRm83OFQ2bVdWbjJVQTh6Q2ZuN3NKaTJVazNw?=
 =?utf-8?B?T040KzJpUWgxNGZTbEJldUo4L3ExYVVDcktneTVRS3ZWTWxJdkgwdkYxOXdF?=
 =?utf-8?B?TkFPZEpROXJUY0lIUUkyd20vbGRpMU81RFRtOEQ4YnI0d0ZXaUVxYklBOWJ3?=
 =?utf-8?B?MlVXanJDdXFNZUFxOEV2UzhqNC8xL1pBZndJU0NXUURKQ1ZldlJIRHRTQjRy?=
 =?utf-8?B?RnlOd2Q3OUhTK1ZvTGowTGlpZ2FCOFJQL3VyOFUxb29vaVdsU0RMQldNbjdw?=
 =?utf-8?B?bk91RlA2eXlZYWFzS2J5Y1B1QzY0ZGhhTzdwODdnUmVRcHQ5OHdnd2ovYTN4?=
 =?utf-8?B?L3FiNkJId2NxYWRGNmI1TkNlTmppS3ZDRDRBRk9YMElVVnBWaTRGdHVuVFJ1?=
 =?utf-8?B?T1FrOGVydWV6ZmFGd1NBOGNydmNJL0pPSHo3QWNUQ29obWNFY3RFeVZZRk9N?=
 =?utf-8?B?dEdTeitRWHExRlMzcVJkQ05Rek8zUk4xUWJ5SFhKQldaa2x5ekpUaVBRS1Rx?=
 =?utf-8?B?V0NmMWZ4djJhU0xzOGFiWC8vZjA3RWdWTGtyUUppemVYL2hNc0hzTUlHN1NP?=
 =?utf-8?B?SWljSm9CdkdrR2RLaXBKRFliTVowTmJ3RFQvaHRBc2ZjVnROamxlaytjMy9E?=
 =?utf-8?B?aUVVcEdMdEM0K1ZkYytublVJYUdjL0hYK2hHMEQxUFJraU9oK21OeG5HQmVP?=
 =?utf-8?B?WGRWZHNtN1hRdVZkQVRnM3hwV3Y5VEMvSit6aUtNRzlxTUxzSTMzdHF4SU8r?=
 =?utf-8?B?ZjFoOGo0blhMZ2Zlb0QwUUFNam9GVE9UandNQkk0OXY3SnpGSDdjYlR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG9MZHFudk9iMFdSd2xhQTRoTmUwOHFJNXR3disrUWxDTFA1dlZzUjZPa284?=
 =?utf-8?B?T0xIRDJEbzZqS1BYUWtUb28xOTNITS8zdGQxcUZkckpkQXJiRFJxdDRGSWNF?=
 =?utf-8?B?cU1OU0ludTVPK1p4aU1zNkNidDFRNGxzbnhJTnRBc2tid3g2UUxTRXQ4V2xS?=
 =?utf-8?B?Sk5WeTMwOEp4TXBkYk9TRlNJSEhxTTZyWWozckNFYnU0M2p3ZURtQktrOUNR?=
 =?utf-8?B?ZFJvMDNFUHV0MFczK29NbFZKL1NLRFZaRURJVlMwcGpTa1dDWml4QWU5SGMx?=
 =?utf-8?B?dmJOOW9rSGc1bFowYmNLZ09NYWgwYmx6OCtMdC9iNktZM1NlUFNrY0lENGpT?=
 =?utf-8?B?OGlodjlCT2pIbVhBNXRpRStqWk85NTNYL2RSVkpOTzVkUFZhL3dLSzNsVEZy?=
 =?utf-8?B?QjN4bEJGSzdCWnZoeUI2bzZUaVlEYXRFQldmNEZTVHVMbWQrZmp6RGJKWUJN?=
 =?utf-8?B?MDJSUjVuUVpXR1g1WWYwSk04cmtjYXlwQWthelVrYUV4U1JZVzZ0WnVZbVJ1?=
 =?utf-8?B?d1R2QVJvSVJJQUZIRW8wTGIyWWE5SmQzREVoWHRDcEJuVGRBTFJRUkE0c1Fr?=
 =?utf-8?B?ODZ0WkwzOG9wTlRiRjMwME04U2JnNnJZczVPVHd1TVg5dDdXd3BHWEpKTnBE?=
 =?utf-8?B?Yk14LzF5RGZpdjJ6eDc2SU41eTZIVlBsNGhMU2ZuaHU4TWI0b3RUeFM4ckdM?=
 =?utf-8?B?dElMY041VGZuY3l6aFVIcVNmenVmZmVRcmlqRWZFRUk4ZkpJV2J2VHR3ZnZm?=
 =?utf-8?B?ZFJwQUo5T0VEaGptV1RLVFd0UFVBS0dqdWd1aytDMXJ3VVQxWWc1Vmt4elFD?=
 =?utf-8?B?cmk2ZXNCYzJrTVFsS0IxTlhwelZvVXRtaTJwTEdiZGc2aG92M1NhTE4xb25w?=
 =?utf-8?B?ZldZcG5VbWpaWEF5TzEzRTRNKytwZnVJemJEZUJ6SkdzRHZCTzhYTG05ZGNJ?=
 =?utf-8?B?NktVck51ekZEd3JmUDFUVEhza0U5RFdNdTNONFlpMTZzNHB4a0hPU0JMN1pF?=
 =?utf-8?B?SWlhSWZiSFozWTk5SmJiOERtQldGU3dpTzBVc2ZrODR6cVVPZmRSZE1OMVN2?=
 =?utf-8?B?OHR2TnFHK0ZHVk52c1grdmpFd0YzeVRwNVZucFA1bGZHa1dMSW0yOWZWRUVI?=
 =?utf-8?B?aUpOOE5QSTNXODRMQzB1L1BoQ0YxeVkwdGEwbzhpOWlCa0g4a0NKeGVLczFl?=
 =?utf-8?B?RGtwdVd6aG1VcWNWUzJNNmtDSWZJRzdOeGkrWGtob0g3c09YZGFzOUt0R05L?=
 =?utf-8?B?MjJJUDNyYmNoM3J0U1U1MHM4Wmh0SEs4ZTB6YjE2YXFUckpNS0FmN1RRTEZv?=
 =?utf-8?B?VnZEZVgwQkovTzh4UjBWZ2o3Zi9TdWI5SUMwRFVvSlh1aFZnMS8rOGl3SjBK?=
 =?utf-8?B?SUNXbkxaSEozYzlBZDFqQ0pILzdNMm9hVnZRTDlOdmxnK28rYWw4am1CZUlt?=
 =?utf-8?B?WHo0UllCbTAxR1VYS09ZZ0V1V1FmU2UrclFBNXBjR0ZWdFFWQTJEekN2WGIx?=
 =?utf-8?B?dEg4Sjd4MmRwWmk4cHMwUE9QY21reVhsUDh6aVBCK2xSbXo5L3p3bkJycU1r?=
 =?utf-8?B?UVJmcXJoY09xZlFEWmQxVFc0NWtGMlBpUUNsZjdPNEJhWDFlNmoyNWtGb3Uv?=
 =?utf-8?B?RlNWaTB4cCt2ZE1WbmROZWRnQWVDUG9WeWI0a2Jib3luQ3NKSTEvUnc0aU9R?=
 =?utf-8?B?bEhVaFF1a2Y3RE14QjZDWkovR0owazJNbnhXRGFUQ2FDaXpIWDMzM3lpOEMr?=
 =?utf-8?B?Z1BRbWRCQU1PVmp2NWhUaEhxdVgwb0xUSEdlekloQ0daYjlsQ2ZJUEpHdmgr?=
 =?utf-8?B?M0dJeEZGM1dFdGpuUE9KcmExbGQ1RDdSWTNuNk5QNzh2OVdHL2dVUFR4bm5a?=
 =?utf-8?B?Y0dRaVh5UCt3dEVic2t6bFhBU2xNTXBLV2t2bjJHdkFzL0NFcm1xa2E3MzEv?=
 =?utf-8?B?eUNVVVVXbG9lY3BkcHpSS2g4Q1FabzZBSUpYQUdQazNVNGdIbU03aU5yUWdr?=
 =?utf-8?B?bDJQeWFaaHhBK1RQVVhUR0dRdnNVbFB5NjBsY2xaOEowc3R5M1Q1QUhsdU5j?=
 =?utf-8?B?Z3JVcURnQzBzTzd0Zk80SDhpaXlDLzlvTXRvZTBtRThwZTRTV3ErUG9UMFlq?=
 =?utf-8?Q?6SV5g3b/LPR0zF5cYIIJxCwwe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907e42af-80a0-44e0-ce0b-08dc7a64b6fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 13:40:16.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6F1uauFsKaPkm2G6v5OlRIxWhJ8WiiRJVQn4Aj3PmKsgrRe9mejOwmJ548YqUayuOGu1EBUTwVZgfemTGLtFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241

On 5/21/24 5:46 PM, Dan Williams wrote:
> The platform driver conversion of EINJ mistakenly used
> platform_device_del() to unwind platform_device_register_full() at
> module exit. This leads to a small leak of one 'struct platform_device'
> instance per module load/unload cycle. Switch to
> platform_device_unregister() which performs both device_del() and final
> put_device().
> 

Reviewed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Thanks,
Ben

> Fixes: 5621fafaac00 ("EINJ: Migrate to a platform driver")
> Cc: <stable@vger.kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/apei/einj-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 01faca3a238a..bb9f8475ce59 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -903,7 +903,7 @@ static void __exit einj_exit(void)
>  	if (einj_initialized)
>  		platform_driver_unregister(&einj_driver);
>  
> -	platform_device_del(einj_dev);
> +	platform_device_unregister(einj_dev);
>  }
>  
>  module_init(einj_init);
> 

