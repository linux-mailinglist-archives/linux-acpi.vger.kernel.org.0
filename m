Return-Path: <linux-acpi+bounces-18993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C546C6790C
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 06:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F9B73446E4
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 05:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B7E1D5ABF;
	Tue, 18 Nov 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J/Xu10OW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A0299A8A;
	Tue, 18 Nov 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443816; cv=fail; b=ld5LWI3tnZ/8Duk7PmP6laI5YHTtrLRAbnQxzDu8845zSiBTJqnjv1RiTSR/KxzRe252r0qPt9if17LgNolE2b7PYhcjTc+ywvDOVz8W4yQMwj2cwK2dfZW1U0M9rz5eYsNBZgYCLvsWr69F2tYOwrrFirGc56pQHgAbBJ2TObo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443816; c=relaxed/simple;
	bh=3rDHLZ97kZHuKavSlPcgs5G9Gw5pfzV8Y0xGnmygZYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YS5R/X61Yt+gbdYrJdDE6mcxx7gsbsCUgF6gbWnsxk2MWcrbN15HF4Cp8a0NzcMyokBXYvxk/JHwKDOPNALZkYp3wwKRARHWRMQ2hq/x86Sdxaic6OIuSIyJxownIaNrz+e+hjr/QW+XONGrwxXfmI5TdhYyJ3cRmICnT1f2bL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J/Xu10OW; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaO0aZsZJIUlClcddPQPysggP13ub5Wcn5fXeU0rzleDphLPBzOXqVtqdWpYRg1vYIPKVORVw6++8UeaUQYYx4xgO2Z8FMQlddckCqY71I2OrYekATPgEbBmKXla+qRCRshVxg3Ou5VRpL1BLGs3LWmvUB8stFe5ZlF27v6uw/C9PZeyLmqvAbyhSvJYGcRvwgNkI0jo5kxbW97d9CMkSx2YoV8KEuAUC03gd22p69RZOuQDtYs+FmRjEv4yhSF+EYJZrpNr1mZTphTt2EmCLXQd2R3Mjex5YFRRZ19YJfU7auxmUwkRC/K0f2DpO6YJSjuC+WKTn4x7sxmmnkjMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyFhl1hEzPvW46Y59mJkUDzXPFkTfwnJuoQO2RfRWAI=;
 b=IGVRbItSwJpMaiCAYmU+2diHNS67sPqVlVSeE7r0ZCcjCAAA6lJToJl0SCuBlgIvDOv44dXy7SfElQAghRBsGmw7B2UEKuUUlcM+7tTmqxMV7InPMG8KyK2FOT4hWZjqoYUCbomu1MrdEVzRwF54i63nmvmLOqSjKwY2SXfV/FhAf5d3Y9Pcqa3trWLjDbLgMmEcJxQtQ8s4C0E/rNkNRd9mMLYZQNz/DrzEO6gLaTAUmP1UjURnkyqqHGFBtFgopefEQqi9RQJ/iLXRkYRf/LzHzknlGLyjEgyhlNBEoEQFEbrVtlPVvV+2ns5nuNJ8c7l+Rr3G/Aijws4w0jQ61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyFhl1hEzPvW46Y59mJkUDzXPFkTfwnJuoQO2RfRWAI=;
 b=J/Xu10OWnKPoMxuW2X5+Gu9QUHrXRZp6dgyUPopU1RdxtfTEAeakWMXAcL102CCYlc27hi8i48Wdq+QPOycnsb8w+3mg8MBcFfwrfggYFiF+27z/j0Qo+ihBq6KEOOgwLaVKM6fC3i73cfMru45lCQwJZT7QjxZ629iX5shcQTn8FCrYCfcFVlTQcC6bhVGd3ls51bY0P8kfCP4Or7qajydfOtrzL+G3CWPqdDmdF/hn2zOQFaNSEgtS91c6NiWJLtDpQ1UItx9+a6gjLiNDFwsz0aFbTznaTYAazNWSGTrCodkqwDmaSnvWnBMpU/5mCJ82vcuTc+kRHWNRKFRifQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.19; Tue, 18 Nov 2025 05:30:11 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Tue, 18 Nov 2025
 05:30:11 +0000
Message-ID: <9f1feadc-076b-49cd-9cbb-d2fec0950128@nvidia.com>
Date: Mon, 17 Nov 2025 21:30:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/34] arm_mpam: Register and enable IRQs
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
 <20251117170014.4113754-22-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-22-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c014e6-eefa-4f1d-8c78-08de26638afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eERvTkFvdWUvYVdyczVnQVFNK0ZUSG85YmNUQ1IvYWVRL3I4bWtVaWNGMEJn?=
 =?utf-8?B?NWdPQ0t2dGIxdjluUHdUbVVBL1c3aE1ha1NYdUtUV3dHT2dUTm9rY2J0eFl5?=
 =?utf-8?B?QlRVUnFKbkIrT3RQcnhlWCtiT0x6dHNtam53Zi91ODRnOEticjRocDZqdU04?=
 =?utf-8?B?Y0Z1cWVxTXRkVnF3c2d0bHhkQWxuYXJuVGI5Yjg3QmxwcXMxMzJwZ2didUlC?=
 =?utf-8?B?cEQyNENwTlFiM0hrdW9kS1dyeE13SWgwYTk2RkFzVFhkMXVtUW5pZHIrUkNE?=
 =?utf-8?B?UXdDZWxjSVpCN1hMN1RRTDJQVzB5NWkzcW1HNVdHWUZYQ3NCb3FXYmltaFNm?=
 =?utf-8?B?eGwrOEE5a0tQbkpOVU1zZGtpckE3VzFFRFphUW1Bd3R4WmhsN0YvWGlOdVNv?=
 =?utf-8?B?b3RVeDFwdEMxMjMzelhpWWNkTFoxU0dQYUd6bVlRL3VyYkY1aG1sZWZCeCtD?=
 =?utf-8?B?d1JpYnpwK1k0SWZtand4b3NVSGlVZzQzUWR1RS9iK3pJRHpPUmFXS2pUMGdZ?=
 =?utf-8?B?RmR0aytKeWpGTkYvME55R1RWUlB6ZnNQZjU5YUw1dWdjNEdxS2tzS3JFTFhu?=
 =?utf-8?B?dnNLTDJmdk1vTmxNZnpXZ3dHb2sxVURNTTJuYVRFK0grVmNJODJjWmhzZGwr?=
 =?utf-8?B?M3V1b1ZvQkxKTkxyeldEZHhPMGdDd1ltYStTWG9aRkFkQVpnOVZOSHk1SnBS?=
 =?utf-8?B?bmVadGhYeThhTWRPdDJKaG56bmd3c0QzWExJTjB6WUE3U09CdDdpOCtnbzdm?=
 =?utf-8?B?UHNFWUFOMEYvcmZVZDIzMzdXSXJrTUhOcEgrT2hxKzB0WlBycHVQT3JhYlJH?=
 =?utf-8?B?VGQrVFFNOElyZTVQNnIwWnB0QW5UZmpib3RJdUhiaHppYmEzRUNjdjUrcCt3?=
 =?utf-8?B?cDdtam1TcG0wZ1MvbFpMcDNCK25LTnRCcnd3RERUN2FzSW1pZHZzRis2WVht?=
 =?utf-8?B?b05pbWZtTkhMUEpHcmRNUnBYYUJkd09lTUZKV2lvb3Blcno3SGp4alM3dXpN?=
 =?utf-8?B?V1VxN0t1YzV2MVI4VnpLWi92bDJ3b2RsVmpEWGwxWVFPL01NQWllU2VNSWpx?=
 =?utf-8?B?QXVlWkdsTUlLbjV3Q29MT0lKZHlvcHp3WmhUay95QkhNU2JxYlN4QTJqam1V?=
 =?utf-8?B?czNuZ25UQUV4ZWdwMFNBSUJ3eEwxTTJQV0RYRDBkanJ3bVg2VkRRWExpZmt2?=
 =?utf-8?B?b05za0ludk5MQ2d4TlRLcEhrZHpTRGxiZHRTYllUdjZLTkNyc21yTkxpUWFT?=
 =?utf-8?B?UURzUUdrcXNzNjJ3TG85S0poWmxGa3hBUkJuNVpuSkxkK2dGR1RTTnBzTm0r?=
 =?utf-8?B?WDlWY1c0aDBjSkJ1VjNTWWdSM0xYNmpYYW9wOGl1cXg4eWF3UzlPUnZsZ3FC?=
 =?utf-8?B?b2dYOTFFYnJGK2hxRHlmbHhRNG5xaitGc1pvYzdZUFFBNE43d0JvZU1jOG9U?=
 =?utf-8?B?K2NhWFJPNm1mNk1Fd05hWHF0YXNYMEdjc2tORklQUDVaMnVJQ0hlZ0FpdlFk?=
 =?utf-8?B?TjVzNTNPMGUvMWNzN2F4UjMrL2k1Lzc0TXFxQ1lPRzVnSnlGcWpJTVc5bVpH?=
 =?utf-8?B?WkVlREdlZlRZT3hHcVZtL2N4b1FxZVdUMXNaSHZjVFB2S1N4VmdtbXp6QVpZ?=
 =?utf-8?B?S01oaWgxdnhEakRGSHFNRUcyLzAza2ZXWGNsRVlJalFETGkrNFdjWUF4MXo2?=
 =?utf-8?B?RUVjRFFrSzFtVCs0eU5aQXl5WlU4YUp5OHFwTXdpTGlzN0g5ZmttMDVEcm9U?=
 =?utf-8?B?Z1ZrZ2V1UUw3WU50TU1PeWxjbUd5ci83SW9VczB4NldJNVVTUW1peU1laWRz?=
 =?utf-8?B?dXVkSitWYzhBbGZ2YWdpSVNyT3ppQnJsbFlIMTZYN0ppcTZ5STFlVllUV01n?=
 =?utf-8?B?eHFQREN0WCtoTUphaEdwTitVT3UxWUlvaVdNMEZXRU5ZYlFDdHJwd3R0SCtU?=
 =?utf-8?Q?VfaW2lyQ0PNnflsnTmzR97WRQJflZHy9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3RraUdseDE5SXQwem1lMXVOcmZxL2lKaGZ3Mm02M2E4YTJ1dmxtOXRJc2x1?=
 =?utf-8?B?TG9FWTNYNUZtZ291MVdabHE4YWdzeHRZbVRGQlF3dFY4a0h2S0lwcnBaUWhR?=
 =?utf-8?B?V0JLS0ZDYlI2TnlwTEx5UlNrZ05MVWtuM3NVekcvb1c1NXdvb3J2NldzeDZD?=
 =?utf-8?B?OTB4NkpOdWNlV0g5UitZMi9GallxVjdZM2x0d3VSNlZ0eDZZVkV5SDdpb3hP?=
 =?utf-8?B?TXFkVVNnd3BkZS9zTGhiQzlKbmsrOWplMW1mRzRDNm15L3lsRXBZbjJWaEZN?=
 =?utf-8?B?L1hwK2NWRTVLTngyVjNoMVk1K3RFWndmbTBWUnJqVzVDN3pKeTAxMGdOUlEy?=
 =?utf-8?B?YWRTSHhZTGJYTnQ0bzhwUTBtbm9wSUhjSGNJYXpIQUZFMzNTM3F2WDFwdGdM?=
 =?utf-8?B?dXN1SmtSa1NWQTRIU2Jjb2V3Q0tFMnl3ZEpzZVBmUUZQWjhvUWN0a0FjZlAx?=
 =?utf-8?B?M21FYUxKRmcwNCtyck5UQ3JuLzRXcjlUMUU3SmoyN1UzbVZ0MkVwZUVuYlJY?=
 =?utf-8?B?Si9kMFpJN3FQSk5TaWhNZEhWY1J4S1U3TGt4V1RlZ2FpQ0E1VUpNckdDRkJF?=
 =?utf-8?B?a1dsMFhXSTJyVUlHNlA5dFg3UUxmUTNuWlJEdmc1QldId3hueXBKMGtEWnZ4?=
 =?utf-8?B?cVFpTlZDa1NEa3lad1N6QmlHR2QzdXRTMXZpQWluREpmOFdRZjMwSXZDOGVk?=
 =?utf-8?B?M3pDeDVVMGI4NnBUT0xUNGlTSUZESHZWbEhUeDhVc0IwMnJMTEdDKzNud0g2?=
 =?utf-8?B?TVRST3RMeVM4b3MrQXpwOWlBQ3l4Uk5GdWF4Y2llWDloTWluUFBzTHZmdlUv?=
 =?utf-8?B?aFF4djRCT3dId3gvWWc3aWo4UUd2aHpMazlKakE0TkxUYVpjYitTanZGS2RV?=
 =?utf-8?B?bXJSV05tYW83UDRYQUtJNnk5SE5IZHQ2UC9PY3paVGJHaGtqTWR0bzdpZjVo?=
 =?utf-8?B?d0R1bDNtZ3VtNHNmMWg0WmVBS09Ga1lGeTYybFF3TDJuSzl5a0FxNTUrS1hn?=
 =?utf-8?B?ZitybEpYREhtY0owcHFOTlZLVmlsTGZDakxVT0pkRFZZSFVXb1pMWTI4dm9v?=
 =?utf-8?B?QUdmMFF1VXNrdFVFS2RMNEwvT2srUjg2RThUYW9jdlovTXZzTFNST0pMemQx?=
 =?utf-8?B?R1AvcUdnS0xtTVU4OXFncEZZb1AyL0QvU1hZUnNya3VMaUFpbWVaUW82ci82?=
 =?utf-8?B?VnhIQnpyRzQxYjJyTG5uRXpyWXozb3VRRGZERHRZQzRyM1k3QjA1M0VEeW51?=
 =?utf-8?B?YkxkelJlOTI5c2g0S09KK3hubDZKVFN3cU1sbjhuVmJOWlF4ZVU3ZjdFcHlx?=
 =?utf-8?B?cjBqVHFNRXF2ZTA1bklYSGVoUlM1ZkpwZkVSMWNQQ1NmU0pIRkRnQW5nTk45?=
 =?utf-8?B?aUF4eG1RM2QybzNpbjIwekNJdUMrL2kwQXMrTEZlbDBnczhKVEVNb0dDZ0V3?=
 =?utf-8?B?MFRaR3NkaWtlczdOYkZkcE1TbFBaNHlUOVgxbmxBRUhZcjQ3SUNVNDNvYkJW?=
 =?utf-8?B?NENaYXpxRS9nQXBhV3ovVGpVWTd0YjArQVBRV2Y2UWZPbFBhMCtnZlh3R0NL?=
 =?utf-8?B?Z0FGS3FtZktHVTFDV0g0RDh1eUl3QzhneEdLbHcwazE5TkZ0TVNoWXd2ek9B?=
 =?utf-8?B?cm1kN3QzMmlvTVBNMW9uVnkwNnZsWFFINzBzTFN6MTk5S0gweER0N1plS01B?=
 =?utf-8?B?Sk5ZcUdIdmc4OXJ5MWJ4K3B6QldJakQ2TmQzT085RUZKRkNBaEdFRmVDZDlF?=
 =?utf-8?B?OU5CbDRlTVFOUG5LWTYwdS9MWGFIc3JsbGxlSFM4Y1M1aGp6cFhLMDg2SVBk?=
 =?utf-8?B?SHVpbklVNHR4NDdFL2VadUlsYnMvSFJFc2VXTzM0aVJwTGlGRDVrZ3JyYUg3?=
 =?utf-8?B?azE1cTRlV2k5OTZ3SzdxRkpLVzhwaVFRSVdDVEVqVGNuOTIrNjRQZG80ZnZH?=
 =?utf-8?B?MDA5RDAxZ3BQWlpkNENQNlhIbnFSR2I1NGcwVmltSWxuclk5ekJVYmlwVVBV?=
 =?utf-8?B?c0JZM3lRUElZbmNqakQ1cmlXM1p4bFJEVlJ5TmlWVGxUNFJ5aWhxUTVzNjFS?=
 =?utf-8?B?c0h6OENqdDRGTVM1NjZzV2hMZUdLMWNyYjB0d0RjbHRyQ0p6M1lEUHA3dGpN?=
 =?utf-8?Q?bDbHWHkt6HBASFfpl4xXNHGHL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c014e6-eefa-4f1d-8c78-08de26638afa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 05:30:11.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnKIBHhDKRBkkQaFchHAJHMsiM20D9CRGNm+mmZnSIAyKeMgUKZrVAMz3h5vdN3m7tZo5+nONfs1c41cUBHgQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005



On 11/17/25 09:00, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever
> signalled, attempt to disable MPAM.
> 
> Only the irq handler accesses the MPAMF_ESR register, so no locking is
> needed. The work to disable MPAM after an error needs to happen at process
> context as it takes mutex. It also unregisters the interrupts, meaning
> it can't be done from the threaded part of a threaded interrupt.
> Instead, mpam_disable() gets scheduled.
> 
> Enabling the IRQs in the MSC may involve cross calling to a CPU that
> can access the MSC.
> 
> Once the IRQ is requested, the mpam_disable() path can be called
> asynchronously, which will walk structures sized by max_partid. Ensure
> this size is fixed before the interrupt is requested.
> 
> CC: Rohit Mathew <rohit.mathew@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Rohit Mathew <rohit.mathew@arm.com>
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

