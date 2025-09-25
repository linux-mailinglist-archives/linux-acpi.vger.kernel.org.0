Return-Path: <linux-acpi+bounces-17300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFBFB9DD58
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 09:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B6D1B255CD
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099549659;
	Thu, 25 Sep 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dQT+JnAi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013050.outbound.protection.outlook.com [40.107.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1E2BB13;
	Thu, 25 Sep 2025 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784740; cv=fail; b=cS9JnQ08AeC5DuybSx7mgvp38MY1tZltarpZvLX3yU2O/hE/o6KYhTXXQTp58+HS+/CZ3ZDwE82tK6sJR51jEhU/9qu1f4BG3j1AXLbiOp364Ehuz0M0rQGqpVzySWFwnt7d1lpOR0TzFya+grbFzNcQafBuaPRggETfKuffY2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784740; c=relaxed/simple;
	bh=fgdysf1BdKmIy45pQuM9JA/JmmRAFqsogBAWTWrU83E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hMVHYKZv2lnJEJFi5YUNHLDHj0jcS70TqNoFtAa6N5WPWMAl7WJgftyejciaH4GtdUImrEsOvlavvN/tm7Odk7fk/G64oKy5bj5gJExFOKTlx11/x3J/dkhtiX/lV5uCnigPCTf2fOEvQSCTvvtA0EHi9tOJzrj6rugGnpHD5EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dQT+JnAi; arc=fail smtp.client-ip=40.107.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odunmIRbdiAZjNWsSf21lWlojUXH3U6IDfBVlEEGaJ93DaesWv+tlhH14gv0trCoM5g/cFITJxzrvCC5S9DwHBAbEOEv1lEiWyYDcTAQyYn2eRukvPYlG2mB9VUp+nX8Kr92dMrIPzYEjtVx7XjBXpnSCgPZnBr0ONPlA/46mZc7Uu1wk59MZfwEfF8Ro3eSrwFJbT0JhPwXoGsUziipqjQcT7jE9cQrMo76QP4DRSHSol7SCKUb30V3vaSGlDexMo+S5Y5nsKuJoMal319nEb8MNg/2kyHZtGAg3gjH70EOUkZ7qQX4SitjwS1t+91f1FyfX1zdJ+oOOxnwwbLoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiKLU+b2aYJHj86qNPJQ0vgGrVsqUeDOxSCPLQLLQiw=;
 b=ZDMGpZ/9mapwSbcJdOn2k8EELIdk/YFtiV5Z30x8ZmrHKtwqh5VVxrKIKoJZ1CraTWrKOvdsOtC6SAxEBH4XiQXdisYV59CIIsOJUfACAEuLuGfzUM1Tp6ekzY0877vZpCR2K0HDKYyZdUCrBPRPyIT8ezeVj5jcbwrnrQ01iMthkYDM8V6DU14tADhb0oILkqKbsq0wIgjgd4dqV6uCxcGQe1es1VaCiRZBBvYCa7UHyG1cH4L3s6Q6+HlaXPMYKj5QfWKwffEnQzj+YeSG9psZqQPbYztIiAp5tgFEehqMcFEqzBC6iCuJnYQsUvhPT2/wnrR3zYm14WTXc2CWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiKLU+b2aYJHj86qNPJQ0vgGrVsqUeDOxSCPLQLLQiw=;
 b=dQT+JnAiCE6C9tECBbriwS5eT4G8T+eQySgtcCKXl/om2Few/II6yv8WCPpQvmNLSyU2irBIGIHX0ISdvePL6sP5pYwq1AHukg/3guG8UmQWYJXbmZ4uyoYOMmzCWhh+185bRN5UEmP+zP1M7aUq6EEPZHxugAnE63fac3n3LSeeOKBbSDq4EUgu7iNQJSkINo/KiC2UrklYrHDgJaYNcLIhwMusVlEH9Sed1D3SORgmTw3j4lIXvqVfRizFDs+69XwHQu5eGhfsjy/QYUOA7VtkudNKUyoAw7Y3+WrUft6Qj2gukUGccsejKxbiftw0CBeXrhWiFqbIfWFcWbCekg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.23; Thu, 25 Sep
 2025 07:18:56 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Thu, 25 Sep 2025
 07:18:55 +0000
Message-ID: <8b6e5d1e-9ccf-4f96-be31-0c51c9ed1aed@nvidia.com>
Date: Thu, 25 Sep 2025 00:18:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/29] arm_mpam: Add basic mpam driver
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
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-1-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::47) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: e7232a2f-bfe4-412f-82d5-08ddfc03c98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzRJa3BIZFVhZmUzeTFLYTNGOTdSNkViOVBaeFNVZjY1c1JuL1dMS3N0RW5j?=
 =?utf-8?B?YlZaaWU2ZFRTeTVSVlpkaDhhTVU3cERoZU5qNFhEVGNaaFpiYkhuS2RaYkpS?=
 =?utf-8?B?MUVhaUR4WkdHaDdya2QwMy92N2dMTzZxaEd3V3UrWWcrOXoyRzJtZEhGcWxS?=
 =?utf-8?B?WllYSk50eUJCOEZzZ3NIOTBIYVl1Z01ZVWtNYXc5T0I2N3ludS9CKzJJOGxr?=
 =?utf-8?B?UnczblhtRVlvaUZIOU5Fem5wRzdzaEozS3dEcEhWeHRxTWZaSlBGSTgxbDY2?=
 =?utf-8?B?MHN4UWk2VTVpSUhIWFc1aDl5UlQreldJL3BiSERybzFhT01UMm9IU1Y4TjJo?=
 =?utf-8?B?T2FaQ1lZRjNId210UGhNTEN5Ky9SRllLWGZvRGxZWHlINnpxdWQwa25XOWZ2?=
 =?utf-8?B?S1NVTXpydW1UbHQ2VDREdWRDYkhka3BFbGw3M1JVa0RxbTY0RnZSZlFPYXVx?=
 =?utf-8?B?MksvTzhOVFJsaW5yWFFkLzdqZGFTdVNIK3U2ZDNWK2x6SzJtS216NXQ2eTky?=
 =?utf-8?B?U1JSUzZ2K2xqeFd5RmRPU0dkOVpxaUtSRlFMTzlSbjZYMTJaRjFDejV5cDdi?=
 =?utf-8?B?MG9hMDcyaVpSVjJleDVxZjhaT1RUQ0lMWmRpa1BpNCtYVFV4bThkeThMbzAw?=
 =?utf-8?B?WWUyRnR3VEVTcUFYMGNCemM0YjVrVDBkczZFZ2JyRUFjU2FYZkI2Q0JsdmpU?=
 =?utf-8?B?VFlWZWhNNnIzWFUwR0Jydjk4ZGNTcE5uMWlJc291aXluM3Z4THhCT29weDND?=
 =?utf-8?B?ZDg1bjF4SzZDVW9OOVVIUzNXUFZaejBiYXQ3Q2FsQTA1R1FwSkhPb0FyYVNB?=
 =?utf-8?B?clRacWxqRVlJbjJuZHZQM1RkckRRNVk3WmY4ZW5qMlFiUkFKdGhvTnBUSjV1?=
 =?utf-8?B?b3cwbEhxSkJNVzRkd0xqcXdqclgwY25yRjVTVUdZUEU0NUhtWmpmNmlHY0FY?=
 =?utf-8?B?UlRHMWp1UGZ6bHhvUStwWUtVdDNnbGlPRTY5cXpDS3ZYK3JoWEl6ZVpRdUNI?=
 =?utf-8?B?Tzd0TzFVbzA1L1Jobi9hTlYxcU4xWlk0NGtOekxFbHZvUEFJbnQ4YkN3R2VI?=
 =?utf-8?B?a2lQenNBUjlHanZWVGVIRnhoOG8vTzJrS3hHZVU0RmhrWTV2QWUwOTVlcGVX?=
 =?utf-8?B?WTlUY2F0NjI0bVhib3RoaTZON0FNV2d4a3dTUHlvNnNkVTFpeDJKamNQSTJS?=
 =?utf-8?B?dzc4WXNrYThTTHVjRE4vNmlITzlmVDd0bG41YnN1a2RoZ0VCTS9OQWRKOTNx?=
 =?utf-8?B?ZVIvZDJIZDdpekU3Rkljek1nLzhVSXljNElxUk9FNDVPb0M2S29PTDFkZXhG?=
 =?utf-8?B?R3dHaTdkcVdmYlNLV1FxYTdhSFhCWWN3UXBmL0o4TjhMQTVrMS9jZDdzNDJn?=
 =?utf-8?B?cDJhc1gvOVVCMzlvdlZKRElnRDNWeTdFNTErMzJqYy9mWFN4N0x0aGl4TitP?=
 =?utf-8?B?NWdsa1FMZ09LOTZZWW0yZ2VXdjczbFpjUE9lSFVUakdOR29QWml6cVNNRFZr?=
 =?utf-8?B?TlpkZlNTQURxR3dYK2J5ZUYxNEltc0xoN05LbDd0ajZZMGxRVUxBenQydmtD?=
 =?utf-8?B?bmV3SS9FMGpTTW1aS2UvUDFvZ0J6ZmdzaVBpd1BKV2ZNZXZ0d3Q1RGt5SEtn?=
 =?utf-8?B?a3V3aUdPa0Vkbi9IWnVQVFZRZzY2cCtuVGxsdGlveURrT285M1IxcndlT3k3?=
 =?utf-8?B?MHIwRXVIVDVwNURhN2ZvbzlxNWxuNUdnRjNoNXBvcVN4Y0RRdHhqQzhRWUVy?=
 =?utf-8?B?R3owbE8rZVJtYlhVNHRsVFpYVnJkaVVCRWgvMmdPeVZRYytmNGRqMVRPRndZ?=
 =?utf-8?B?cnBqdGIxa1ExSms5RmdlMWdTUHpRZ05IY0VKV2JsREFRK3pPNDIvT29HZW43?=
 =?utf-8?B?blJhWjMzVE9obUN1TWM2MG96TUoyQ2pSZmFpUGxmb0Z6ZW4yMnBCWSsrUTFa?=
 =?utf-8?Q?r/gMaHJ0X/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3pPNExtYWtMUDNVUnB6TFhpMHJwcXhteGdoTlZySERiZ0pwa25nVkxNaHVN?=
 =?utf-8?B?UXhsUE83aUNrRTNNSU0zSys3TkxlQmdsamtwbGdmSldVV3ZDUCs1cmhjY2k4?=
 =?utf-8?B?RE5rd3dCWXZuVE1kNGcvNEVlbVBMV2hiTjBBWUw1Q2htSTlyclk5bWNaNXRC?=
 =?utf-8?B?ekNhK2FrQ0xrL1UyekZlZUNvNzZQbVpKUTZPeTVaQTNRWXdLT1Myd1FOREhq?=
 =?utf-8?B?cUIxbjFySWhKa0EvSTBsNEN4cis3WTVraGdFUEtlaUFtOE4zek8yeUN3RnpH?=
 =?utf-8?B?SnNYdlBucjdmYnJyaTJmWFB4d3gya05qaGRkU1QzWkdCYzcrR3E0UTR0dnNS?=
 =?utf-8?B?cFhnbm5DZGNMcUc3aS9jdFNCeE1udjBtcjdFNWdKS0hHbUZXeTFXcjRsa280?=
 =?utf-8?B?L3pKVTRHclRvbUlvellNRjBLcTMyNGRRUUhUaDUxYVRuZHdvdjRITGNkeEVR?=
 =?utf-8?B?aXZnSjRyMUJyTlZ6dXcyUWo2Y2dncTdlZlRBSHUxaS93UlJaNHdOMVVHd1Jt?=
 =?utf-8?B?QzBXZU1jR2hkU01obXFRR3lpeHlVeUlDNVYweHpXWTl0Z0NvTnRFOTRWbmw5?=
 =?utf-8?B?ZURCSGZQZFlXR2tOdFlqNkVwQ2RuUnFCOWF6WUc2OW5JT21jRWk0WjdFcGlZ?=
 =?utf-8?B?NnAvQWl4c0ZiWDErUUJ1TmoyWU9sS3gvLzhHSjFCNXpVMzBMNmFpekpueVBZ?=
 =?utf-8?B?L1E5UzJCR1d5NTQyZzRDdDBMVE9BMVlGc3RIUVZxNEZEV1hZbHZTK3Vvck95?=
 =?utf-8?B?TnlmMGNHSEtDYTljVXJ0azNFU0ordWRMTlIvNVhrYTB6ZHZOcGFjclQwN0Y0?=
 =?utf-8?B?YzIxdHRwOXN2dUsvOVBSS014OSs1REdTOG50aTJxeEN1S1h5SmlpN3Z4RVEy?=
 =?utf-8?B?QVc5QXN4Z0dXQkYxeWVsWkZpeXB0NlpSR0NuVTRVdDdkaG1WK01XVHNQY3l1?=
 =?utf-8?B?NE1IRzlhY0pwUTlxcVRLT2lQL3NTb29LbHR5Z2xONW5mY3lJSGpBNWpCeDBz?=
 =?utf-8?B?UjJxdmVaRWc0WUFQeURZK3FUdWlTa2RYdmlaU3VyTCtwUE0veEVIcllyWFRZ?=
 =?utf-8?B?SzhoQkxVWTlmTUVoa0RjL2tacVcwM2g4T014QTRMZmRxaHVuc2k0VTYraGc0?=
 =?utf-8?B?L2t3VEVPTTE1cE1rYzRGbklFYm1GZUNLYmtaRTIyYkN0eTkvOE1vZlkxQzlq?=
 =?utf-8?B?MHZ2OTBoZjZSTStNNi9TQnRLRGFHTmlCc0tuM2RtSGlldnRtVHYrekszUCtN?=
 =?utf-8?B?QmhSV25hVStrUEtUWHM1a1lWWWx2TDU4b2Z1QmdwbGdnSm1mYTh2ZjQ3M2Nq?=
 =?utf-8?B?QTBNV01VdkFiU2krZW5nRE02djJPc3VjbXVJNDdpQkZmUDFmd2gxYWZsajB0?=
 =?utf-8?B?UzNuVEFoTHMvenIvOVM4d3J0V1A1am4xWFM4SXNibTNYcUF5RXprVUZMYkZl?=
 =?utf-8?B?Y3VVM09pWDlKdVk4L21oSFFHWU5HYWNYMmRhMDRuUGpVZ2IwRm9QaFFsOG5C?=
 =?utf-8?B?M3c2bUMvMFRTbXZ1eFpaZ21WSC93cjZxaC9Hem04d2xicDdwWXhoUnZBSjBo?=
 =?utf-8?B?TXlKV01BUTBWWE5UaTZ0eWEvaE1LcW1HZXBPTTdqUDBpcjV5Q0ZKU1p6UUVk?=
 =?utf-8?B?elBlSFBLWlFKMGRwdTg1TU1OY0ovZzdkUXgrY1gxaUZqMFlCWG5DL0RRTDFO?=
 =?utf-8?B?dmdKbzFtMVRrMkRKaWZKdUVuc1VrOW9ybGdMVlJYemYxOFUxN0N3eEVaL3Yx?=
 =?utf-8?B?SVBtTHJLeFYzdGkyMGEwOXExeUI2WTJzWWFEdUdGWFFWWmZsR0VySE1jZi8z?=
 =?utf-8?B?SkJTclNMOGUxSm41d1ZaUWlMUFhaOGhiWElodEMvaVZpamRtRkFyR2pmVDdZ?=
 =?utf-8?B?RktYbU0xN1JFaS8rMkVaWWRhOE1SaGZwWG5VdVJtMWNCRzZmbjNZTTdBL05n?=
 =?utf-8?B?ZzByb2VZaWVFS3c5Zm16YmY5eEdvd1N1UU51UmxCVnJOUll3c1hrakQvdXNR?=
 =?utf-8?B?dU1LYkFjK2ZTMkdNcyswUE1acVRLR3A4cU8waFYvQVlqdXk1R3FpS1p1WXBQ?=
 =?utf-8?B?L3BtZ3hTV3hzT1JrQXQvY2hXQ3pQVUhaVEM4a1UyVUJvMmZQQ1paZUZwUU1G?=
 =?utf-8?Q?Bk96odwJxi9VENXOoBULE3KIb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7232a2f-bfe4-412f-82d5-08ddfc03c98e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 07:18:55.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hy+xmQgO9Dkapu6iUXneYUG/0GOT+Tq/DJYzEfbN/1UAuo5GMi15gNTYICM9RESUOFRIVABiYLrW11COYTUmog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186


On 9/10/25 13:42, James Morse wrote:
> Hello,
>
> The major changes since v1 are:
>   * DT got ripped out - see below.
>   * The mon_sel locking was simplified - but that will come back.
>   
>   Otherwise the myriad of changes are noted on each patch.
>   
> ~
>
> This is just enough MPAM driver for ACPI. DT got ripped out. If you need DT
> support - please share your DTS so the DT folk know the binding is what is
> needed.
> This doesn't contain any of the resctrl code, meaning you can't actually drive it
> from user-space yet. Becuase of that, its hidden behind CONFIG_EXPERT.
> This will change once the user interface is connected up.
>
> This is the initial group of patches that allows the resctrl code to be built
> on top. Including that will increase the number of trees that may need to
> coordinate, so breaking it up make sense.
>
> The locking got simplified, but is still strange - this is because of the 'mpam-fb'
> firmware interface specification that is still alpha. That thing needs to wait for
> an interrupt after every system register write, which significantly impacts the
> driver. Some features just won't work, e.g. reading the monitor registers via
> perf.
>
> I've not found a platform that can test all the behaviours around the monitors,
> so this is where I'd expect the most bugs.
>
> The MPAM spec that describes all the system and MMIO registers can be found here:
> https://developer.arm.com/documentation/ddi0598/db/?lang=en
> (Ignored the 'RETIRED' warning - that is just arm moving the documentation around.
>   This document has the best overview)
>
> The expectation is this will go via the arm64 tree.
>
>
> This series is based on v6.17-rc4, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v2
>
> The rest of the driver can be found here:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.17-rc4

Tested-by: Fenghua Yu <fenghuay@nvidia.com>

[SNIP]

Thanks.

-Fenghua


