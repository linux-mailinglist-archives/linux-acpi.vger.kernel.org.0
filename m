Return-Path: <linux-acpi+bounces-17882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EE8BEAEF4
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9661AE2B33
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0DB2F12A4;
	Fri, 17 Oct 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="bYKfdIOz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020133.outbound.protection.outlook.com [52.101.85.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390F2F0699;
	Fri, 17 Oct 2025 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720360; cv=fail; b=JPE/PO6MLpsY+S5HJXhBdLg2eI5pfDMB9pyGkcdWe1ocBILg1jqMiJHdjIi5W63lYlDpY+lfdxARFn+CJgVSMvDCdM1ADz94QOwZ3vV761+ZO4bzO1fwNplKotaf+YKcwdBrumpnpxKX+oTWlJouhCyLU9eMDe+yIvNr89qFX7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720360; c=relaxed/simple;
	bh=dwB6BSGpwv1WD0pwFPdDa9mIoeYaIaq/GSD8bHhcoBg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=khkjbIM1hCVOqjbEnoFMakdVUxbApF7kKkGFilIobqbjv1QGGH1PpPBfps6+qjodH5ANK1MXCaNZunYFq8g5iq7xPEzS/GOF82qKbJKjhXjymBkdsBRupj+dcUFJ5SeaWaqtAxyVtuPBYoEs7r9lhfHC9MUo5KPlP5tW+J2ZPkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=bYKfdIOz reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.85.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXrMMEeYK2jzCUGwKNvbwa2wgbfWpA71nKD2FhluQrZVmhBc5TJMI1Ve/o+Fo0QbGclU7/hS2chUEoOEzzsjdENZR3BUsbk6mb5Vo4pTZQwC0c7yR6NFVadS64ngFnTEVZfGxQs/2Jaj1HvmNrpGjHXeUxOUMtZr1VYqvU/vIIRQ64C7OI0p5xqTYb3xwHnIiw8CLSJKyHl5csBuG9eITUvVXBt+Z0/xHFnCWn7XbV+yLcJfC0ovnV8wYJvmNhHh+rZfxNdDsDTydA+8xe2BfEzQFMcH2qJeo463M3y5V90GT+JmcGx7JaOsz/OHkzVCS6OQZ6DpMvarU1W7Laey3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVX44I5y8xmTvNM31qNqARUWB7OW0mbLQrcqsOnu35E=;
 b=jU9fyv6kuMhzfmGFTsA4MkQCOvkLDof+zAHqIhAAKPtgbu6H5ZdFDcuvOyEZDiQ8Jrh8cA3NnKPzDh94DDp4lAespodQ8NZ8sfnz/zZRcn6eLYwmqIepXY/W3bq0bvsuh5VNN/KI6PEQNPlB/QqMmWzycpqrhrcD2gwZLUoXf33hlvL9ZMZDpsbXMJNmJSlMkmRQb/iH1y/AylF3qlIWWXGs/U8z+QPIUEuTReIzEdlEvTPelj8J5/yBuLwIL/nbaeVaGdBC+WXAuGFqOKBDmPAF22/q+OY9j8QP9rx58ECzoIU0WlhdUUPMhZb/0fO+mGl6+el0IY7/RPVDtv1ABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVX44I5y8xmTvNM31qNqARUWB7OW0mbLQrcqsOnu35E=;
 b=bYKfdIOzkNsVxB+XXV3OAbfMCwtN4N6sazGcpR5bOojs4FgKrJHHfk+ySvpx4lVHkGGYEaqqMnNCxOT0DZb4T+x8j7f6t9hMbHxIHT1Lli011vbJcnD5AkqoSUQOh6bV8NKcgtL8F5UufdZR5TecBQRKeBC52H+STxm2cYexy3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH0PR01MB6809.prod.exchangelabs.com (2603:10b6:610:ec::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 16:59:15 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 16:59:15 +0000
Message-ID: <88b406d0-919e-4357-8740-e87fce26e346@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 12:59:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mailbox: pcc: Wire up ->last_tx_done() for PCC
 channels
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-2-0fba69616f69@arm.com>
 <81929a1d-6730-4ae3-9c91-c4cbfba44a7c@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <81929a1d-6730-4ae3-9c91-c4cbfba44a7c@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR19CA0098.namprd19.prod.outlook.com
 (2603:10b6:930:83::15) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH0PR01MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ff87b7-ec6e-4655-207a-08de0d9e810e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjBKeWc5bVJSNVd5bWNkU1pnQnhUQUNNUTcvVWRGdHRDZTVleEQ1RlI0SWto?=
 =?utf-8?B?UEFUQkN2YitQSXljeGkvK2xuT3FCUnJsMzNMd3kzQjY2Qm9JRVg2WHhldUpQ?=
 =?utf-8?B?RTJVR2JXcEluSjUxcGhRVmpNOHJQWGdzYmgxLzh2TDFTUTR3NTdYY1p6eUM1?=
 =?utf-8?B?bG1yQXNpeFQ1ZldnWVdDdUd6V1JqMG14T1BRbnR0WEhZT05mRFNzb3pvODBq?=
 =?utf-8?B?SksvRDVyeUNYaVR0cThOOG1sUWxtUUdNRXM1ZHhRcUJzZzRpSGNTS2JiRXJE?=
 =?utf-8?B?Q3VCNDk3ZkpIOVRlMnA0WDlUcmNnY3NDTnNkMUJFVTgvWXdRZTVIUDI1K3Np?=
 =?utf-8?B?WFdXUWhDNWl5cUNZRlRWeGZYM21CbDZKMHZHeTRwZkE1SzU5OXlqTkZyb3FF?=
 =?utf-8?B?Y1VlTnNPUFduK0dJM09qR29ia0dzSlk3b1p2eWExR21BYzk4a2Z5bmpKUk9k?=
 =?utf-8?B?WUxCTVJPYXgyb2hhWU16VWVSc1UydUNpeDBXVXBWZ2t1ZEFPdkhOYWZ0cjNl?=
 =?utf-8?B?RUYwL20rMWZPbkM1MWJneHdwQWRRc2t1cjVwcUlTWEJBRXV4dmxkeE1WY0Rj?=
 =?utf-8?B?bHRGako5TjhKVlprd0x5SHpNNDh3ckdMVmhFSDdML3lxaVJWVmlORHhNeU9Q?=
 =?utf-8?B?WFMzM3MwM2hpRjJSdjJGZy9qZFlueDl3Z1dXWUc1eExXZ213NlYwN3JMUHcw?=
 =?utf-8?B?TWNJcllDci9uU1N5YWtQNVVZS29ZYnI5bENrS1BCTVhDL0RiRUdDTVRmTUZZ?=
 =?utf-8?B?bGF0TzJtRWl0aFNoMHVjL3lleUF4czdSbWxwcE5PT1BGY1lKcGpjRlgvaGg5?=
 =?utf-8?B?VUR0YUdOSUQ3UUw2bVJiajkwQlVoSXpmTHZzeWlmM2xia2hwakpzTWJJZEN3?=
 =?utf-8?B?d2MxejRJMU1MNTJmWjZYSVVGSWhmckJPNks1UFRBd2kzQnFnaUFWa2gzR1dQ?=
 =?utf-8?B?M202TmxNOVJnak5mVzFlY01NTk5uS3dQNFdwOTRDY1I2L0hIWU91VWMxZHVQ?=
 =?utf-8?B?R1VpbGpkOFptTHFuc1kwMzBvaHdxVnFVcTVlWjhXOFhwaDZOdHR1T0FlUW5p?=
 =?utf-8?B?bXZuOHAxU0FzeVM0bno5OVNEYk9LUEdHYzZmQm9RVko3THRMRlpVQWFldFZ3?=
 =?utf-8?B?ZFBpcHJvUDBTMUEzWUVzcWEwU05vZTlHV2VqRTFmd3E5MllIMHlJbFJTcm5L?=
 =?utf-8?B?QklPRHh0dmMrYklISUNYUjhTMklidlNMQzhXZHFlVmlqY2RUQXNRZ08zQkc5?=
 =?utf-8?B?cXAybUI3QUJGMnVoeEpNbHZqdHdZNVhBYkE4K3k2eWdIUis5dXdVNEZSekRT?=
 =?utf-8?B?NXZZNWkzdUozdXp0OXVBeEdwcldKYzk3bUJxcHZLL0tFWVRhUE1KdnFOZ00w?=
 =?utf-8?B?UzVWMHJBRE5HOUtwN2Z5T0hueWh1NmFLTmhGQnN5THBzYUtJOGNYb0NyMUdj?=
 =?utf-8?B?NENuQWN0NEhCdWdUckZxVFpSUGdaYXBHcFAxTWNtT3BIV3lrNyt6cXgwaEsy?=
 =?utf-8?B?UmphV0g1RUpSZ3JrZzFZK1FjU3lRYmxNSVR6L3h5SVhqZjNiNlZnVWREa2NM?=
 =?utf-8?B?QzNyelYydlYzQk9reStNcU5LZUVuSkNOY3pHb1ZCRUhZMmNFK2FLdCtlMUNU?=
 =?utf-8?B?NXBqWE9GVEhrbVI2WVpJRS9pc0ZFeUpMcjRwdFlUcUpSZHFBcjQ0M1MzM0M1?=
 =?utf-8?B?VE5NeEFUSVRNT3pXdnFEZkVxUUVsV0duODhHZWZrZ3FKOHBPRU5wZEFuY3F1?=
 =?utf-8?B?eGV2ZE5YVEJqZWpqNFJqUld5aHVGZnhNaVRUaWRUQ2tSdFZSV0NMOXdRU3Q2?=
 =?utf-8?B?MnROVHFaV0JtUHNnb2VMWVovS1ArVGJpWExQdzdxSXNoT2hRY0UzZktlNmdt?=
 =?utf-8?B?UWZ0SHp0aXE2dXlHcWRrUWxqYXU2bUUrYXBqZURLQUJUa3JtRzl2M0hzZ3VZ?=
 =?utf-8?Q?ASYCXP+GeaQCPmqCQUbbdFFMmkiPGjWC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEEyZE9Sd25zaHhJWGFsK21ncmpxdm03VzVicjZOWWlKaFNzM3pESDROZ3pK?=
 =?utf-8?B?Tzhad2taeHNQK3E4Sk04K2J0VHBHaXFRbkltSUIwZTk0S0p1blA0Z3pjOWsv?=
 =?utf-8?B?azBvRjBxSHI2TW1XZjg1TzFWUGZvR3MwYXdHOHpSRXI3ckFkbS9UUkpwc0I2?=
 =?utf-8?B?L1ROd2MxM0M0UUZhNzgvY1ZuN2p1dzFZTWdFUFBpeEw4ZzcvOHQvRFd3Ulk5?=
 =?utf-8?B?bHlaUG1EYjIyUHNiL1ZWQWgrNm1Ga1RJU3dSSGVoZG5BQXZ2RG9yMkVpZTlr?=
 =?utf-8?B?SGs2bUxybXQ5Q2QvSkh6NW5COHFsenNYTFJxajZ3TW82NXdMeE1sNElZOUhy?=
 =?utf-8?B?ajJzN3dzQmRzN2lwNDdQekZCNm1mOXVacUxUenRPUzI5aUJsZXdjNmU2MW9i?=
 =?utf-8?B?QVhSOWFaaXphdWluSUFBeSt4MjZkeWl4OFhPbGVoVGVOanNTY3ZyMnRrTjFT?=
 =?utf-8?B?MUpxeHp0VTh6WU5vNnRtWU9OSEEwTFFQc2txK3M5cUI2a0hybnFqOUFEdnRp?=
 =?utf-8?B?T3JoRTVXRS9Ub2VneEUwN0YxNDIvSlA0c1V2ajU0ZjJSZ2VPNHJnSEtUUmQ5?=
 =?utf-8?B?bHlXRVFBSHFkRFFZNGF3VHVDc3g4b0xpZFUwOWZSdU5kdVRCNE92NVdZRVV5?=
 =?utf-8?B?bTVDRFlSY1lXc0V3QkZ0eVBidUJNeEJmNEVEenlSdCtYbklDTDVrQXZGcGpE?=
 =?utf-8?B?aFU4UFpjN0Y1WVA2a014RzBlZHB2OHlTRkNRZmQzdmpNZDh0Y2xDdlg3K0x3?=
 =?utf-8?B?UzRVcUg1ZGsyTGZaMzE3L284dkJhSnRiRjFGYTRkUlNWRE8rdnFWcWkxb2tl?=
 =?utf-8?B?cHhYNE9BNm93SXpFV3RDMHM4TkFvYklPQzkwRzJSRmtiSEowb0xPSkpkUzM4?=
 =?utf-8?B?NnBKUXBIUFh4Wm1VYVZxR3NhcEdRR2lSWWdzMWhIWHFyL2w1ZzU3VDlObVZi?=
 =?utf-8?B?UXRnbTNrMllROGxMRm5TNlhTaVpoSTFBRTE0Uk5MSmJ1UUpQREdQRmtYbkxq?=
 =?utf-8?B?MU1pMUtBOWgzYU9vUHBwRjJaT3ZCazA3V1NSVWx3dU9YWWwrVzQrT2lmU2Mv?=
 =?utf-8?B?TjNHVVlWUnFYMFVRMjFWcjZLTlkxVzVRVndidWY3YTZEWXhWRlpxYzJ5ODIx?=
 =?utf-8?B?OXF1T3IyZ0xlbDZlVEs0VHhib3gzS2xKek0rSG84YjdkejFNbGlpRjUwUXpr?=
 =?utf-8?B?bVlLUTBvSEQ4R1BjbDRmbFRURlA4aDEwZnpWWmF6eW5QT0lYbm5LMlZWOE5B?=
 =?utf-8?B?SlJJQXdBK29qTlRTck5KVVhMK1NhcUJrcGs5K3ZlMktkWkxqMDd2WGVPMytm?=
 =?utf-8?B?ZURqekhOZloyRlNnYnNodHJOQnZyL1RmSysyR3dwcUpPTG1PSzY1ckRNdDE5?=
 =?utf-8?B?N1ZYWFQveDVqV2R5UjNxckEvR3lCUnVheUg5Q3pwZ3F6R1o3YldKNll4TDB4?=
 =?utf-8?B?Tk1rdXJjVjlOZGpFSXFnMHREa1VJRXV1TG1MUlVoWnJsUFQxbmYxaERFemsx?=
 =?utf-8?B?cUVSQVJJSzhWbnlUME5RUkhOcUNyRndJUmlnb3BSS2l0c3NsSXBjVGNuMGhh?=
 =?utf-8?B?eDB5VlBHRGpsYmZHaGVRRFVwK0hVV1JSTTA2Y0srZExwV3c3em9kdGxuVWpR?=
 =?utf-8?B?SFlGeGdOdklCZzJhRUhUNlQwVmpweG85MTVIVFM5SlRET3lJNjFvRVUzZU9X?=
 =?utf-8?B?MzhRaHhEVWZOOTV1Vy9QNW9pK3hieHNjVnkvdDBQNUt3TzI2ajhFMG1WT2hU?=
 =?utf-8?B?MHBFV21YM1MyRkZlNkJ3Q2U0RmdxdVNZcGlweUxIVEpqMlpLL2NsV2QxMjM3?=
 =?utf-8?B?RXQrY1VwYlFQRnZsR09nTmJjTldvSTBqYTdMRmQ3Um1lMlBtaENmVHpqcWla?=
 =?utf-8?B?ZTl1VVRHemtoUXh0dGZRSHh3M3BlbmlpT0c2VlZBK2Rzd3dqYmZGVVE0ZWhF?=
 =?utf-8?B?VHUxa3Avc0VNNldra3FiN0RiL3FLR1IxVjk4S25namVMT1BFelZzRElXY1ZI?=
 =?utf-8?B?djVGL0NIYWNyYit5L3pqU2htcVJNY0NPQ3BmUFpqZnVYc0k4bGZCUTd4M1Vi?=
 =?utf-8?B?cjhoVEVVVUl5U3A4eXhqT053NEh5d2dIQXBkVE1vRTJLRThndHV6QkltVWpi?=
 =?utf-8?B?MElNdSt1ZGdHa1htR2FmR01XK3h0bVkxaHllVTRzVmVmU3NoOFYrVVpKZHFQ?=
 =?utf-8?B?NUFnLy9wWlRnNkIzQmwwaTZvYXY0RzhEMmQ4WHp3a1lieWZnVDBQdENKUnEv?=
 =?utf-8?Q?5CGXPl5Ijb7B+9gDlwk6DAh4yGlhrz+wVyiMHHZVnU=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ff87b7-ec6e-4655-207a-08de0d9e810e
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:59:15.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cl5H1E1eQ6cM95N6Z9HWZqhQtFYKmB9yFlnXFTALneSsk3LvI7pgFXy6reB+IAeKYm1GpB4mnE8WprRCN5fQyRwEPALisXskMGZHap6Ha9rTUDi8uG02diTKUjtjmu/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6809

Correction.  I need to slow down.

Tested-by: Adam Young <admiyo@os.amperecomputing.com>

On 10/17/25 12:48, Adam Young wrote:
> Tested-by: Adam Young <admiyo@os.amperecompuing.com>
>
> On 10/16/25 15:08, Sudeep Holla wrote:
>> Some PCC users poll for completion between transfers and benefit from
>> the knowledge of previous Tx completion check through the mailbox
>> framework's ->last_tx_done() op.
>>
>> Hook up the last_tx_done callback in the PCC mailbox driver so the 
>> mailbox
>> framework can correctly query the completion status of the last 
>> transmitted
>> message. This aligns PCC with other controllers that already 
>> implement such
>> last_tx_done status query.
>>
>> No functional change unless callers use ->last_tx_done(). Normal Tx and
>> IRQ paths are unchanged. This change just improves synchronization and
>> avoids unnecessary timeouts for non-interrupt driven channels by 
>> ensuring
>> correct completion detection for PCC channels that don’t rely on 
>> interrupts.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/mailbox/pcc.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index f6714c233f5a..2b690c268cf0 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -445,6 +445,13 @@ static int pcc_send_data(struct mbox_chan *chan, 
>> void *data)
>>       return ret;
>>   }
>>   +static bool pcc_last_tx_done(struct mbox_chan *chan)
>> +{
>> +    struct pcc_chan_info *pchan = chan->con_priv;
>> +
>> +    return pcc_mbox_cmd_complete_check(pchan);
>> +}
>> +
>>   /**
>>    * pcc_startup - Called from Mailbox Controller code. Used here
>>    *        to request the interrupt.
>> @@ -490,6 +497,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>>       .send_data = pcc_send_data,
>>       .startup = pcc_startup,
>>       .shutdown = pcc_shutdown,
>> +    .last_tx_done = pcc_last_tx_done,
>>   };
>>     /**
>>

