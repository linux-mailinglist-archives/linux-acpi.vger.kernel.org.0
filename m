Return-Path: <linux-acpi+bounces-17884-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE13ABEAF60
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658131AE370E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEB32F12DA;
	Fri, 17 Oct 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Lc/8WwT3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022131.outbound.protection.outlook.com [40.93.195.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334A2F7449;
	Fri, 17 Oct 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720594; cv=fail; b=Xl0WfDn5wcAc7sX3RyQCqfEPxHr715N4AkxBsFIOCZsCL4Jc9M/XzRbgXrN4IQXPz9/Y6rWWMMssYsCSs6Cl81AM3vwJ6/UQVEjy4Mdn8dq5CQy/3V1qfdeEHYZHpkEdxtX0kZBagiE+VOXO6SCPVnQl9HEg9zHlVHd00shL4mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720594; c=relaxed/simple;
	bh=0wRtlzIvv0yhJOQmGSW1H0uxgD9g7gEFcfy8nZQkTmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S0KTwjAYtHBFjAsmT/q+hzrKfJNJvJclf7Ap2615axCg07M+9Yer8vNEv3RuvDDgicvAIL36Go7xEhIZ+AWLYsDTBUSPzwBCF1b+tVf888JNzveBoCuqrwhvo1e47i5jOJ195npJVhySmm2vQiu1unfTL2xww90aGUWBEXOPW/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Lc/8WwT3 reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.195.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpnXj7+qd22lTF2acCmfuOKS9hxKMUlUgGC99ZbBLpUmEYsSAzTedSNvXOg7IOYZslE1Sti2JnkbrbosnEJCfJS8VBP3Y1ReR0jFnVHuL19fopZ0GNxrsu0523vLecqbh4M5d9HbXQqA0CZ0gf/XzCzdPyt0M56Fn/TYU5pHT4vl3ss9WOQtkEYNZtfOVeBYFPA83PYi+DYGhVtW2SswFFjME0I7/EuwQasNhpaEQ0kYmJz5m7uakJlAlL9onRS5HDHWALyklUQYmlSBr/YrxkmohQPn6IT1vlwjmvvr/5FMQtDgqJ5UOQGS7OtGePYcdHZyHRMh5sZs4saxMadiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJogpqkeU6kGYJoC9RTEh0eTxou24UyuqXjDvwtws4Y=;
 b=hES/T8dlChHIxK5yQA7pET0zWUv6T7Bd4h9Rb64Ue1jhGPpRHvAeEDTcJ9f0g5YDWpwfULCeJbOUCBcz0M1mSQmNkMyb3AdDc2cNMok99/DUbjoRkXw+FMFS3OWP4ClXN+/Z3etmZTgnHoTq+8ZFEaTRnQnKbCnZuTgAZ50IJeQXUsSwC6oChFD+HTPTXiHCpHU6k0Ha06ytR0GfLG/QUvGfkMOiDo53X+9fTB+HCTjlGNRWlJS/eOKUGl4RfowHLAzdUugpOFNPPUKh6LRRuMADWJZY5PcFZMn/EpS0jrlWJlLOtnCxxczax8jaSWEkq5rDAyRLAVhrdynWGvhByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJogpqkeU6kGYJoC9RTEh0eTxou24UyuqXjDvwtws4Y=;
 b=Lc/8WwT3Kx8l+3Vg4Xknc4Mm3ZP8MfXrhG9b0MR8mMMce+m3KSchCWE/sYEwfN8ySuttaUqQUPquUSrIPAQ5d7fwL0uNoUxRZ2S24hl8Lp//80aut0IpRlFfZJ0hiqk3Uo7kdckVbvpNbdQxbwq2sUWN8RjTIaB6nC8S6ZaMpSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB6326.prod.exchangelabs.com (2603:10b6:510:a::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 17:03:09 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 17:03:09 +0000
Message-ID: <d46a659d-6571-40e4-9c79-9a69ec919bad@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 13:03:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mailbox: pcc: Clear any pending responder interrupts
 before enabling it
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-6-0fba69616f69@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-6-0fba69616f69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:930:48::23) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 545834a1-64e9-41e7-bc19-08de0d9f0c2c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmtEVzFHcW5SbUNBRVhpa1hkdmxLZnpOTll0NjEwcit2YmN5eTdBcVBRamdR?=
 =?utf-8?B?YnpXbmsyWFFVb0lUSWVXd3pjNWh1MlBrY0I0dGFMV0ZseFQ1YTFkZzZJdmdM?=
 =?utf-8?B?dG9XZDdQVHRhTDBMbzdPYUxtcGhVbVJTUzFhWjBMS0daNUNJbVE0Q2lHUTJm?=
 =?utf-8?B?bEtOWDY3RGhmbjYzYmttck00aWRHb0pJZ3pFR21jQm96VDdQYUhFdWdXWkVp?=
 =?utf-8?B?QXVTUXdiZWQ4LzdQRko2YmVMYWY2Nitkd3lsSVdEcGhpWEd6aGJ2eDlocnJC?=
 =?utf-8?B?UXVXYXFRcUg1bEUvN0R1TlUzeElpaFVhdzJMY3dIYjFsdFZLcWlEZ3pVMElq?=
 =?utf-8?B?TkJBVEpNUDIwMC9qOXhYVUxta05MSUQzanZSdWs2Uk96eEorZXNWSFVaZ0Jw?=
 =?utf-8?B?em10L3hpNjZXblBQWllURy9scnFMdHNDdlU0cHlZcWdnNkNYdWhPL1NNeXNq?=
 =?utf-8?B?NmpiY1p2WlFRQ0xUR1czdVRrZFIxYjVmd2ZKK3ZnUXFVRFdwUlBVaG81TUhW?=
 =?utf-8?B?MklFWEl1b21PTVptU1pEakc0NUswbHREODBRNUI5MDZXRTNFMUpyV3dHSWs2?=
 =?utf-8?B?OTBSTEZpWmhMTzlJdnZtRVRxUll1NlJPTnlNdFcrakhHaU5saVhmZk5SRW5D?=
 =?utf-8?B?WFRLSkd4TTIva0x4azZ3cjQ1MUwyaUNDWVAzUE82UzJOYWIySkQ1M1VnTHlo?=
 =?utf-8?B?OHVGdXg0ZlNBbDgyZ0dKak1zdTQxc2dsSzhiNXRXMVRiUkNySHQvbHJSRnc0?=
 =?utf-8?B?TG9XRnNjUWFzQWh1dXpuTGZwcHh5N1E3NVdZT25NV0ZUSm9IcTVSUk1mb1Na?=
 =?utf-8?B?YU9rNEVkM2t4VUI0a2tURVoyMldEbkp0ZzhVTUhuK055YmJQcktXOWdwVDVK?=
 =?utf-8?B?aVFuSjByeDU3SW1sRXpGcEYyanVrNU1SYnA3bU1YVDNhWmkwdHp2VllsK1Fw?=
 =?utf-8?B?NUhiK2hsZk9zb1JrOTdpakNEMlRwam9UdGt1MTBiTlpDcnVUNTc3QnFJTmd6?=
 =?utf-8?B?eVlXV0ZpUUFVTG5RRzZmMWtiYkhzQTBQRWJnS2VTV1RoUWU3dGVmb0lMU0Vi?=
 =?utf-8?B?VEZXcmZsQ2htbFNMOVBrQlVqNjlLbGFubTFCcGI2REtBbWxCdDdyNzJPZldi?=
 =?utf-8?B?aElaQzdvUWw5M1VqZWZhTEhrSkZBaklJWXZTV3R3WUZLeTd5UlprZ3pQU25L?=
 =?utf-8?B?U0pnNG9qeFFZZHIvVGZ0bjRic1l6eFFUM3ptNjgydnBQS0lwd3N2VjJBK1E2?=
 =?utf-8?B?ZzFIbDhBaU9EYUpqbzdZNVhGRHFmT1R0eFA2d21ZaHN3YXZOTi9ORFhBMHNI?=
 =?utf-8?B?U1E3R1lvWFdCSzFtcjRxdkxCc0hWb0srajRkNFkxZGo1ZzdKcGVXR1Z5ZWND?=
 =?utf-8?B?RFQ0NnM3Z3BvMEp1Q21ZbVc3cUxwN1c4Q0p0WHZMdUo4bzZ2SFhDSDdaRmxG?=
 =?utf-8?B?bEt4cTF5MXI2OExkUCtQKzNkbTNpWHl1eVRaTjM1d3pzSUExYmo1My85cEkx?=
 =?utf-8?B?SXNHUzNlVUxiZ21SWHprcDc1Y2hIUzdXQWIxTGFXWDFBRWFOTWdJZ2htMEVl?=
 =?utf-8?B?Ynd4SndMQ05jdHhXa0lyWTg2SUZtcmwvMGw4eWxjRkJWNGMwYWFBOUswWFA5?=
 =?utf-8?B?U3pPL29FWHQ5V05kZEQ0bXcxbDUzQStHTmZzckV0SHdFbmpSd2xGVjF6WllG?=
 =?utf-8?B?UlFLVTNuMFVxRU1NVFJZUWtOc0liWFRIWS9tSWx0ZzB1dnFJazU2T1BMcUdE?=
 =?utf-8?B?SmNBRHhaTENEWUY0YU92RGgyZDFTTEU3OTVQR29SbGE1MytITWllM3I4YUdx?=
 =?utf-8?B?RU1Ya3NjTDJ0KzZieVo2YjJROHVQamtieXprSStlWDg4aGFZYlA2TlNTaVhF?=
 =?utf-8?B?SmprVVo3UGQ1NTJlQUxzdzBKWHZjOWtDRUtibGIxYzlhckpRU0pJVTgydEdE?=
 =?utf-8?Q?dJK7QlKdfIJscZL2nOoy6naj2HU1TKaX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2NwMjJLUEx5Sy83eXhjZFZ4bDV3UTFHT09taWhiY21McFpZUlZLbU9oUEVR?=
 =?utf-8?B?eXEwbDM4MlU2WHczTnBuZjlBZFV6OU03M2tha0k5UFJZMElNOEhMZnhUZFlN?=
 =?utf-8?B?Ty9aS2NxTThDN05lL1BJSVA5Wk1JTnA3aXIzaVkyYmR0bmp6bTNtN3cvdHdz?=
 =?utf-8?B?bnV4MndlVXlVMG51R1pSdzVUQ1pYc3lWckhwbnY2OGU0OElvVXBhRGMwU29U?=
 =?utf-8?B?Qjk0ajZFWGpVWjNBTTlXU0QzUmxCR2RCYzRWTGJKYlNrVVVnNGtTMjZ0RFBF?=
 =?utf-8?B?VEtFSjVxaThhQ2I2VE1CYkdKRHZtaUZjOUhJQ1pxS2Jxajh3UFIrZFg3Yk52?=
 =?utf-8?B?dTVvQmFvU25raHZPcnJFRm9UMExHQ1M0YVFIbTg1cUgwT25XbGdOb1FxdkFF?=
 =?utf-8?B?SjBxelN2dDkxcXN3UW1peEduL2IwVTlFZVE5cGZISlkrU1NMc0hOSlZCTVV3?=
 =?utf-8?B?Uk1EM2JTd0RBSkdkNHh3UElzQXE0a01xR0VTRjhvaEpNdHhTMDFWUHAwVXky?=
 =?utf-8?B?Sm1wZUJUT2xLNVowRUlTNVlvWXVQNWM2S2lUeFl1QysvbFNyaER6T1RXR2VZ?=
 =?utf-8?B?RCtEcS92WDJmcFlaOUo0WnA4VnhlcjA3S3BSQjc2WHFhNlZyNDEwcmJyY3Rl?=
 =?utf-8?B?VC82L3RSUVE3Yk1LZDJmWlBrUlFsZG1kOUhMNnR2d0o4d1FKSmJwb3ZlQ2F3?=
 =?utf-8?B?dm1yVWcvdnRCVDVVSm1EbWE2QW5POGNMVDd5ZmlSS2ZpVDJFQkplQWtjeXhs?=
 =?utf-8?B?Sk5YTm1qVFhYWkMzYnlSODVEWXZpVkdYSlpnOWhIS2dKNy9Nb2ZJUnFuYU9u?=
 =?utf-8?B?cFpDejZyY1pWZFgrY1RlaFJxd2dhTW9ZbVgxOC9BcThCQS9DTHN2SVFJaUk0?=
 =?utf-8?B?N0xTN3BKK2lwc25hcXc4RVFhMjY1ZU03SGlHRGhpNS83ZGZZWG9hWkdXa3VB?=
 =?utf-8?B?ckkzWHpIVVVjMkFGaHBOUXdtakVqUnBXajhOdGVkUXh0SUgvRk5IdG42NVRv?=
 =?utf-8?B?NGljVm9nMHhKWUJlMUFEZEwyMzBzQzBXOW1NTEVoVVFvUFY4T1ZNVElKajA2?=
 =?utf-8?B?N3FZdnpIYUhuVVpGYjBSaEcxZ0ZDWFVTRUZweXhjbUVaNXRmd1hOYzk4Ky9N?=
 =?utf-8?B?VHZjU1RHNis2MzdLMmhNdkJFSWVmQnNMUWFFRzNVU21HMzFSWVpwb2JyTE5R?=
 =?utf-8?B?KzFWZHlITGFGUHM2STZqdldZYW5MOHNBcTR0UThDYmdXei8weG11aG5DSm5U?=
 =?utf-8?B?dlFZQ0FSTEkxbnAzUEk3eUJPNUI2TWJxQmluT0thVm9oMHljT1ArMmJuc2Zi?=
 =?utf-8?B?SDFudWc2elo0cHAzTnFFdkJDYTYwYVRGUENCOWYvbUlwcDNoWThCQm12dzVt?=
 =?utf-8?B?NWFVSEtyQXZHcHVuRmFxcHZ6Qmt4Ti9mbVhaV2lrQ1AwcXlscWFrcjJxN2Vo?=
 =?utf-8?B?VzNrajJoWTRLblZtY3pxUmlMbUNYYlVGdHFFbUxtQUlLNlFDM3VsaWpYdEZV?=
 =?utf-8?B?bDRjOHRBKzZkcG1KQmFlMmQ0bFN0VnFuakxtMkZuN2sxbUNLajRJMGtRbGVN?=
 =?utf-8?B?NTJqTUhuQ285RTZSdE51SFhCZ2NZWEZaQTEvaklmZXZjV1JkNU9tcTlablZw?=
 =?utf-8?B?aDhkTGw3REFuZml6c3Z0VXkwTmJMamE4dGFjNnpVdUh2WVk1bm1TcndMU0Ux?=
 =?utf-8?B?VlgzZHltMHBLcEszYlB6QXdUbVUxbi9hdXRoQXJqMTBYaU83eEsxOFZCVzNh?=
 =?utf-8?B?ZFFwY0xDcGhVV3drT0NZUmNONlc5WDdYaW8zZC8zNFMrVkVmZmpMdnhFSlBq?=
 =?utf-8?B?RHVWQklzNjIxa3NGQ3NncW9UUEdZcU9rSTlibC85blJOb2tnVGNEVHpXQVpY?=
 =?utf-8?B?aWZEZzhVQ00wZmY1cW5jUjdNSDFQZlpqaldFb1Q5LytLYjRTbS8yUU5ydzZO?=
 =?utf-8?B?VWpBOU9RMVJmVXZrRmZqK1B5VVhiTFovNkJrS2Rsem9qWXZXOGphSE9kWEdK?=
 =?utf-8?B?REd1bWNWYll3VTR3WHl5cXdYZlhiMExzbWV3b0RtOXAwRmVjSU1GaS9EOTI1?=
 =?utf-8?B?a3I2Q1pKR1ZBN1JjMDg5UjhjcDVQZWtKc0s0blhNNHN6RkJjOW54TGowby85?=
 =?utf-8?B?M0x2TzZJOHo1K0dEOHFsNkkxY2hMUjdhS3FhYVJXR1Y2K25CSEVEOEhLREZq?=
 =?utf-8?B?UTVCSDAxeXZUSSs3TTUzMkZ2ZysyWTZSdng2d211YnYySXZIWEh2dE9GcEtl?=
 =?utf-8?Q?BG9ZdYOrXzlEXv2disGUfz3o8E0lPaOMH81FCp/0RU=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545834a1-64e9-41e7-bc19-08de0d9f0c2c
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 17:03:08.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHPj/pCrNIretPOJMKxcvccW0nHy+mkLl7SOteldPhiv4iCcP4+GrepOokyn8Ly0SgoDrVuwfH1y93MNR+GxDBR+n1Zmv8E9RBG6eVCql36zlxh/NHYSfQdfbALzrnhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6326

Tested-by: Adam Young <admiyo@os.amperecomputing.com>

On 10/16/25 15:08, Sudeep Holla wrote:
> Some platforms may leave a responder interrupt pending from earlier
> transactions. If a PCC responder channel has a pending interrupt when
> the controller starts up, enabling the IRQ line without first clearing
> the condition can lead to a spurious interrupt which could disrupt other
> transmissions if the IRQ is shared.
>
> Explicitly clear any pending responder interrupt before enabling the IRQ
> to ensure a clean start. Acknowledge the responder channel via
> pcc_chan_acknowledge() in startup before requesting/enablement of the
> IRQ. This ensures a clean baseline for the first transfer/receiption
> of the notification/response.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 2829ec51b47f..418007020439 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -468,6 +468,12 @@ static int pcc_startup(struct mbox_chan *chan)
>   	unsigned long irqflags;
>   	int rc;
>   
> +	/*
> +	 * Clear and acknowledge any pending interrupts on responder channel
> +	 * before enabling the interrupt
> +	 */
> +	pcc_chan_acknowledge(pchan);
> +
>   	if (pchan->plat_irq > 0) {
>   		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
>   						IRQF_SHARED | IRQF_ONESHOT : 0;
>

