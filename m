Return-Path: <linux-acpi+bounces-10484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2FA07DDD
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBF3A19DE
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0750C22256C;
	Thu,  9 Jan 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ERanM3mb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2F221DA3;
	Thu,  9 Jan 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440921; cv=fail; b=eqF49mcN4IKs7R1jPiUB/g6oPCu+RxQUZpdWQM2TF1gQaseDGm16gkKLdpKVAkqhytDDwP+ftQIE+CG1+GhjWfK+KPCEFo6QYpivUNUlpl91HNgmHeXSIrd81f6/zLR1d/OJGYjL47+TjiqL0EKg0YXneTXBrSB95WTl4ibREDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440921; c=relaxed/simple;
	bh=at1OaAfY04Sh1fCdStUkETTCRbEvxgq/kOV4TCPPMAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GMEaGEvmeKUPhdFUqZKk0/FmaKz7cGFQVyzZpKqcDLRwz1njljocOTCz79WGo3O/uJ4YZ7ROVj+9ADBLo2eydiAKuNROuf/e+by+RfSmAM15dOTGiakx0Rap8buD8bNyru1YLaG4arTW3GQLBDTVOktj2kuywcEiULd11/L0/0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ERanM3mb; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NH9Ozz7KRemaWG8ecVQLzhnxDsetY0sTqZFUm70EoIl+gF6M/wfnJ7qbRe0L/IBo941CZMSRxOhvBVwrQYdQ4bnTrgGG2b4cFJpdMMsx1u5My+0+iqkpoPh1sP0/qdqUPhnR6NA18jvokAc6d3Rr1oDI+Gpv85C6zvYcN7Jc8RH+/cdDxmYDSLB9qRKxHGdj/J9qXSdyBymcwQe0b8+ctDYlLW2ZIe5S0lyhCmDaqayKPEyR7nKWP/MzVaQgYiU5TxeqZoXU4f3SLOJLWZTyWrKviaootNE8iZJLnK/vVWQzFy7R5ovrBAkbLNw7Ypb+2rQflPD2uWrzB4/CTGhQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpsCNr2bjRPV/U9Vs6ARaFbLmmQT2N0M/w39elAdjk0=;
 b=vU7x2balIuVekrymR4wxSqBSiGG1T9kqIF0EpfrzgmBdrL+wNWjltTowM3j+ztgbRw2DcKdo9hmuTJjMSajvDJST4MteDR+bkay5oHL1jxaxAmjjT00+xmg8r4iQqSD2jnHvTxVKFq3qEjbolvjWSJX8tskXP6UH2nt+C5F6oUG/lSWy2BnLJttNTm2oLRFLIGphnSdjralsJYnnzbxTSdNE+8GLmaQ2/Tcv0eQQNL9R0vuiQa2H1rdNfaWgnfBQUagzHLufE9qob+h2DuFryk0EoeGSZqK3k5o89LFmweqGXoT6ei3defDDJDf1AhJAGE9EsooNAM02bMIBxNVGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpsCNr2bjRPV/U9Vs6ARaFbLmmQT2N0M/w39elAdjk0=;
 b=ERanM3mbe0aJ7F5f3zr2sttkkU34cS9lnMFx9w6DeyiLTn7J5aUiHXrin/nuetMPO7Rwe4JB7WC59d7y0p22fHs5y3bMGyGayTaaB4VvYKivR7wD+ILhvq91lGhfYJ683+KdurocxfDBt9E3U0awg6bPuNOnQSGvQBcFyTXhmTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:41:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:41:57 +0000
Message-ID: <eb746e5b-74a2-4d9a-9e7d-a914e96051fe@amd.com>
Date: Thu, 9 Jan 2025 10:42:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] ACPI: platform_profile: Remove
 platform_profile_handler from callbacks
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-16-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-16-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0077.namprd12.prod.outlook.com
 (2603:10b6:802:20::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 297e2970-1ea8-483b-1b02-08dd30cc87f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFVRc2RVTGVLOWoyUkxGWTVPRC9YbkMxRWFET011bVprblFvWUVCeHZHRW51?=
 =?utf-8?B?ZTRqcjNEMUNYc2EyVlFYVzhMZXhuTnQxQUNuNkx5SjM2a21VTnRQd3h6S0pV?=
 =?utf-8?B?aGlpNHF5UnFyYWJLTWdieGhnczc3KzdUUFcybmY2ZXc0NjNhdy9uMjVDTkw5?=
 =?utf-8?B?RmVDL2VGNmcrQU9LVnhBRWJKL21FUUNtSlRBMG1lNzBLVStNRGtmeGRXcmhh?=
 =?utf-8?B?UXBWTzUwT242bWVGTVFXSTZWMGdWaW05eldtZEJkVFM5RWhpczBQTlFQNVgw?=
 =?utf-8?B?YmFpaHFmOHlIQ2hnTlpYUTV2UHF6WTFYVk9sL3A0RjRaR0JTUzBlQXJ1TXRT?=
 =?utf-8?B?TmhDOW91UVovOEF6cDZYaVF0Q3NTVkF3TitsL2txUnNmcjc2cFpnVjJqUFJV?=
 =?utf-8?B?M0tOV2JrWmM1MzQ3alpEYWwwVW1PcGVsQ0Q3c2xudjhISzF3MWpIUUlMdEF1?=
 =?utf-8?B?ZGtYcXlzNkFmTHJPWGJqc0dNeW5rbWtGRlBsbnU5Lzh3eFIwMFgyNDc3blhz?=
 =?utf-8?B?TXg3U2pLclFxM2hqclVzU00zYTBubjd6czZzSzV1ZFh4b2ZsZTJvcEQ0S1o4?=
 =?utf-8?B?Vk4yU1ZWeTJlQm5BYjlTeTI3REtYeFpELzYzSW9SN3VyUW12WjhvaUVZc0lz?=
 =?utf-8?B?eEZHeXpYLzUvOXBiNFMzMjNlSDlPNTRQRjE5b0tENkVTQzFQeUtKeTVCcFJW?=
 =?utf-8?B?Sll4MXZPQWhtTlg0VnBneW94SjhOcXg1ZGVvcXUyclViaFd4R1F4ckM5RmVr?=
 =?utf-8?B?TDJITVIxQmVMTWd1cjN6ZXdweU5VOHowMTNhbFRxL21MS3U4aHVqSjJobktJ?=
 =?utf-8?B?WFhIczZnOUFHSWVjVjBhcVVUWkhBY1ZsYnh5U0xIQW90bGgrS1l0c2FwTXBC?=
 =?utf-8?B?QzZMY2FOV1Z5RUsxMUkyUC9makJzS0FDNXpqcDg2eVJjVmZ4Umw4YU5sRDZD?=
 =?utf-8?B?TFJUaXl3QjgwN0QxNXB4SWozVURjWFNxRWxsVGlmZ3hkYzJYcnZpN1hnTDNY?=
 =?utf-8?B?SVVYQmlSNFJuWWIzblBHTUVxdmJFWjk4UW15SklLUUptenM5N2lXYTJMZ1U3?=
 =?utf-8?B?Nm9RaldQd2l5SW1tQWwxSzdMb2FhUFY4N1pRejRWbjVIYW9FcGJyc01tUkpN?=
 =?utf-8?B?UngrRzFlbHJ3ODh6UUNhUStRVFZpaGEvM1lYbFJld0E4SHVIQTZlaE1BOXhO?=
 =?utf-8?B?emJLVUx5bkZoSHM4TW83UmNIZHppaFZ6ZWpDTkVmNldrTGk2MVA4Q2ltWXdH?=
 =?utf-8?B?ZytOZUd4RmRUWEpPSmpWbmIwdzNVbTZHc3dnRHhKOFQzRElIOGh5WXlhNlZz?=
 =?utf-8?B?MGExbWp3dFYrdlNldDdhNGNVRWt4bDhiL243TUR5KzM1c3dXVlpiUW1YSkIz?=
 =?utf-8?B?RVJHbVJ5enlXdFpPdy8rU0xzZGtBYVJCc0pKWTZKdzJWcFVOQW1kUC9LSzYx?=
 =?utf-8?B?NmMrSWZQbllpY1ZPODlOeWZVUWd1ZmQwVWxBZFNrVGlLMEpCOVRTYmpZakN0?=
 =?utf-8?B?U0lxUk5KSFRJOWc2bDI2V3NOMitiV3J6Y2dmTHlRUUdxOUFVWE93REZ3emVp?=
 =?utf-8?B?ODUrbTFTUnQ0akY5bnZuSXA5c3poRjRJMzNMbi8yV05yd1d5N3EzWlM3Y3FJ?=
 =?utf-8?B?cVhONzhyM3gwcnFOR2lZTFVsSHAyRlM3dFJaUUNPUytaTUVIak5IOUoydCtU?=
 =?utf-8?B?blBLVUV6aUJYNTZEdi9IWkMyaG9rbUt0UnA0eTFaVHkxNk9MYkZrY1Rsci8r?=
 =?utf-8?B?a0p3eXlIZDIyMlF2SVREZ0hTNUc4VUIzenhYeDBqK2U4WWFpUHBNTkhORTBa?=
 =?utf-8?B?ZFRTTFFFLy9DSnpTVjBCTjBrMkNPR1BsOWI5ZmVXYXpHMHBYRktBT2tWb3hP?=
 =?utf-8?Q?laMVrxBpncma9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW1pTXpraS8xUm1TRlpZUmM1anJmcDZMblJzRkZqMVl6ZDhra2pYZ3dVZVZJ?=
 =?utf-8?B?UExiZlZvMXNRa2lyQVdBV1lWcHZPTkUxc1Zic1R0UW53d2FzaEhxbDRvU0JS?=
 =?utf-8?B?bFR1aWVYZHlOdHJ3NVlRNDV1YzlsbGI2RS80am5sZWpmT0U0SGUwK3Axb2tG?=
 =?utf-8?B?MUp6WldNcjZKQkgrMmJtZWYwZnhITmNhZDJlSkVYc09QeXhMaEJuWVJSa2pj?=
 =?utf-8?B?R2dKd2t5MCtBQVRzSzFFY0dmYXhQTkUxQ3lZT3pEUldRUlo3WWVDamJkb2xm?=
 =?utf-8?B?WXdSRDQ3bFhIelFqNTZKWTY2YWN3UGx6V2JsaEdiODZFRjN3THFSSTF5cjlu?=
 =?utf-8?B?V3F6YTVkVW1xeXhEYUNmT2IrYTlrVitDUTN6WnRoeWowaExtWHJ3cnlGcmRJ?=
 =?utf-8?B?Q2dCd3pOT1ExOTdpcWpmU1BmdmVocTk2Wk43NFQ1MzRmME1kZjVLQnFUYlll?=
 =?utf-8?B?dXJuQjZrWWJHN3N6N01MMy9uMDlXOTY3VEc5VjdvenJtN3pTOVFtdjBIL0Ro?=
 =?utf-8?B?VjFDbzBGR2VmcDFURTF6cDZkTFVFcnp0WXpObmJZdEFvdDluTDZ4eHdHQm9T?=
 =?utf-8?B?ZkR2NDZWd21RRFdsSnZGQjZwTWZ5WTU4SDFLa3hocU8yNG9ENEZ5Tm5GRnB2?=
 =?utf-8?B?bGgvbnBxVG00NEpiejJTSk5VY2t2Q0tUNEV5ZzJTamI2Kzd3SHZ5OW9LYVVV?=
 =?utf-8?B?TDVYQUFxc296ZlNscGRjMXdaRVhIa1ZOMy8yVHlsbnc0bmRKYTYyMjU2Uk16?=
 =?utf-8?B?STc4SWFQam0wb3R2RHlLbWxyRCtYRkMweDdGL2RjNzRXVEtmSElaM0ZISkxB?=
 =?utf-8?B?MUlzZE1zRFAyaTlBZVQ3Y1BqbkNkaUYyQ0x3bW9TTUY2alQyVVNaWFJySS8y?=
 =?utf-8?B?WlZqUi8rSGwxWnhOdzNBNlhYOTQxZXhLdy8xVE13OFptMlk2bjFYUnBNbTZE?=
 =?utf-8?B?bTJaRk03ZVFTZkd2UTRHRWo2azZKNlBoNEw4SHFMMGNIZjNNdUZXbnI0dW8r?=
 =?utf-8?B?S0xrSVFGbytjNVFpd1hQM3QxTGhSd0FldjRwTW1CYW5aemJQbkw0OXFxT1lz?=
 =?utf-8?B?RTZtanl3aUxQNlhKbFFtUVUvTFBMTFNmeWJ5MzdXSWRDbk5FOUlXVUc0WXNu?=
 =?utf-8?B?MlF1Y0s0Rk9hQjdwQ0hGdHFhbWxnZURkeCtYanZDYjNDVFhBdi92MThreUxY?=
 =?utf-8?B?WDNGcUtDTXZzQkFJQVVWVCtNaGNXdnJyMHhvSi81TXNZTnhTYllSUitZWVZB?=
 =?utf-8?B?Y0w4ZHNBUjZRV2RGV0p2U1ZhZFBzNDNmRlljUmpoSmpzRG5teDh1bnVuMUJu?=
 =?utf-8?B?U2d2MTlLaW5ZMnRLSDROSmxWZjFMYlVPZGpKWk5HODgxSmN2TkdHRUt1Uisx?=
 =?utf-8?B?aXI1ekl5dnorMzVsR0wycTlUQmVNWUdsYTY2QU1xd1NyRHQ3MEYxOXFtcXZ5?=
 =?utf-8?B?QktpcFRxa3J0aktxblBMRlY1Y3NUU0NmbjJtYVdLWkZwVDBHT2lmMlZSd3U3?=
 =?utf-8?B?NG9WTnJNNHFTTy9kNDExbVRnSE1GcndwT2hkeGY0UTd4bjg3K0hpV0ZzRlZL?=
 =?utf-8?B?dkkvRkdmNzlSUUMvMThsM1ZOajdGNE9INnR2MkxnRXZuWTlMUkpsTzM1Y3hq?=
 =?utf-8?B?TUM0aHpJWEM3NzVBVFFTb2hVZkRMRmE2L3RmWGUvQzdxU29NakVsT3NrOXBR?=
 =?utf-8?B?TmpnQytDTUprTWtjRFg2K1U2bFBXL1hYNkxIc25WNXVIbzVCLzF0UGkwQXZR?=
 =?utf-8?B?TEpUUWs0bHJZNG9hZTVKdEtBN253NUFQYnhyajJlTVJDRmtSUFdmRGR1MHU5?=
 =?utf-8?B?K3kvL2xTSnhmWVJaUzRNMXc2VnJCcnVhODVuR0VLcmxvbW9BWi9UYzBwQUFz?=
 =?utf-8?B?b0poRS8zeEs2MmYvbFRzaXV4SWFZdmtLVERYWWs4dUN4Yml5S2FqMVRQbStl?=
 =?utf-8?B?NEtuTFFyWU1TTnNpNlozclVVaGZPTFAxeVV6L3VFY3FkUWlibjlkYUxnVHkv?=
 =?utf-8?B?NFJ2c1EweTlUaVI5d2JPVVRQKzVsOVpDOEg5RC9hZHlDVUlnSG1qdWVhSFN5?=
 =?utf-8?B?b3kzcTIvMzRMdTMzU0swcXZPTjduczkrOGhBUDB0ZGJ0UW45Uy8wOXF5VENm?=
 =?utf-8?Q?Q87PHPkMqk9+y9nMUuQyK8klF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297e2970-1ea8-483b-1b02-08dd30cc87f7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:41:57.0421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61VpbX19XSQX+z0Tm07FJ1npJokKSQB0lWErcLatvoIwEmBO4N6KSHMtid8rtVMgxXx5IMw9IugBm2P+cimmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

On 1/9/2025 09:06, Kurt Borja wrote:
> Devices can now set drvdata to the class device, thus passing the
> platform_profile_handler to callbacks is unnecessary. Instead pass the
> class device.
> 
If not too hard; could you bring this earlier in the series?

If so it would avoid some ping-ponging on some of the files from when 
you introduced the choices callback.

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/acpi/platform_profile.c               |  6 ++--
>   .../surface/surface_platform_profile.c        | 18 ++++++------
>   drivers/platform/x86/acer-wmi.c               | 16 +++++------
>   drivers/platform/x86/amd/pmf/sps.c            | 16 +++++------
>   drivers/platform/x86/asus-wmi.c               | 16 +++++------
>   drivers/platform/x86/dell/alienware-wmi.c     | 12 ++++----
>   drivers/platform/x86/dell/dell-pc.c           | 14 +++++-----
>   drivers/platform/x86/hp/hp-wmi.c              | 28 +++++++++----------
>   drivers/platform/x86/ideapad-laptop.c         | 16 +++++------
>   .../platform/x86/inspur_platform_profile.c    | 16 +++++------
>   drivers/platform/x86/thinkpad_acpi.c          | 12 ++++----
>   include/linux/platform_profile.h              |  8 ++----
>   12 files changed, 88 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index fdf79b81b62e..8d034d928e32 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -67,7 +67,7 @@ static int _store_class_profile(struct device *dev, void *data)
>   	if (!test_bit(*bit, handler->choices))
>   		return -EOPNOTSUPP;
>   
> -	return handler->ops->profile_set(handler, *bit);
> +	return handler->ops->profile_set(dev, *bit);
>   }
>   
>   /**
> @@ -104,7 +104,7 @@ static int get_class_profile(struct device *dev,
>   
>   	lockdep_assert_held(&profile_lock);
>   	handler = to_pprof_handler(dev);
> -	err = handler->ops->profile_get(handler, &val);
> +	err = handler->ops->profile_get(dev, &val);
>   	if (err) {
>   		pr_err("Failed to get profile for handler %s\n", handler->name);
>   		return err;
> @@ -490,7 +490,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>   	if (!pprof)
>   		return ERR_PTR(-ENOMEM);
>   
> -	err = ops->choices(pprof);
> +	err = ops->choices(drvdata, pprof->choices);
>   	if (err < 0)
>   		return ERR_PTR(err);
>   
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 965940223892..0d059986cc5c 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -154,14 +154,14 @@ static int convert_profile_to_ssam_fan(struct ssam_device *sdev, enum platform_p
>   	}
>   }
>   
> -static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
> +static int ssam_platform_profile_get(struct device *dev,
>   				     enum platform_profile_option *profile)
>   {
>   	struct ssam_platform_profile_device *tpd;
>   	enum ssam_tmp_profile tp;
>   	int status;
>   
> -	tpd = dev_get_drvdata(&pprof->class_dev);
> +	tpd = dev_get_drvdata(dev);
>   
>   	status = ssam_tmp_profile_get(tpd->sdev, &tp);
>   	if (status)
> @@ -175,13 +175,13 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
> +static int ssam_platform_profile_set(struct device *dev,
>   				     enum platform_profile_option profile)
>   {
>   	struct ssam_platform_profile_device *tpd;
>   	int tp;
>   
> -	tpd = dev_get_drvdata(&pprof->class_dev);
> +	tpd = dev_get_drvdata(dev);
>   
>   	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
>   	if (tp < 0)
> @@ -201,12 +201,12 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
>   	return tp;
>   }
>   
> -static int ssam_platform_profile_choices(struct platform_profile_handler *pprof)
> +static int ssam_platform_profile_choices(void *drvdata, unsigned long *choices)
>   {
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 2059b29dd36b..2900ba060cc4 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1827,7 +1827,7 @@ static int acer_toggle_turbo(void)
>   }
>   
>   static int
> -acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
> +acer_predator_v4_platform_profile_get(struct device *dev,
>   				      enum platform_profile_option *profile)
>   {
>   	u8 tp;
> @@ -1862,7 +1862,7 @@ acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
>   }
>   
>   static int
> -acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
> +acer_predator_v4_platform_profile_set(struct device *dev,
>   				      enum platform_profile_option profile)
>   {
>   	int tp;
> @@ -1901,13 +1901,13 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
>   }
>   
>   static int
> -acer_predator_v4_platform_profile_choices(struct platform_profile_handler *pprof)
> +acer_predator_v4_platform_profile_choices(void *drvdata, unsigned long *choices)
>   {
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>   
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index e8d2de9bb646..700a6ef39201 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -282,10 +282,10 @@ bool is_pprof_balanced(struct amd_pmf_dev *pmf)
>   	return (pmf->current_profile == PLATFORM_PROFILE_BALANCED) ? true : false;
>   }
>   
> -static int amd_pmf_profile_get(struct platform_profile_handler *pprof,
> +static int amd_pmf_profile_get(struct device *dev,
>   			       enum platform_profile_option *profile)
>   {
> -	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
>   
>   	*profile = pmf->current_profile;
>   	return 0;
> @@ -363,10 +363,10 @@ int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
>   	return 0;
>   }
>   
> -static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
> +static int amd_pmf_profile_set(struct device *dev,
>   			       enum platform_profile_option profile)
>   {
> -	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
>   	int ret = 0;
>   
>   	pmf->current_profile = profile;
> @@ -387,11 +387,11 @@ static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int amd_pmf_profile_choices(struct platform_profile_handler *pprof)
> +static int amd_pmf_profile_choices(void *drvdata, unsigned long *choices)
>   {
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 809ab0353b68..11e5fcecf3a4 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3800,13 +3800,13 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>   static DEVICE_ATTR_RW(throttle_thermal_policy);
>   
>   /* Platform profile ***********************************************************/
> -static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> +static int asus_wmi_platform_profile_get(struct device *dev,
>   					enum platform_profile_option *profile)
>   {
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = dev_get_drvdata(&pprof->class_dev);
> +	asus = dev_get_drvdata(dev);
>   	tp = asus->throttle_thermal_policy_mode;
>   
>   	switch (tp) {
> @@ -3826,13 +3826,13 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> +static int asus_wmi_platform_profile_set(struct device *dev,
>   					enum platform_profile_option profile)
>   {
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = dev_get_drvdata(&pprof->class_dev);
> +	asus = dev_get_drvdata(dev);
>   
>   	switch (profile) {
>   	case PLATFORM_PROFILE_PERFORMANCE:
> @@ -3852,11 +3852,11 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>   	return throttle_thermal_policy_write(asus);
>   }
>   
> -static int asus_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
> +static int asus_wmi_platform_profile_choices(void *drvdata, unsigned long *choices)
>   {
> -	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 1eaa746eb4f1..19b7cd95018c 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1055,7 +1055,7 @@ static int wmax_game_shift_status(u8 operation, u32 *out_data)
>   	return 0;
>   }
>   
> -static int thermal_profile_get(struct platform_profile_handler *pprof,
> +static int thermal_profile_get(struct device *dev,
>   			       enum platform_profile_option *profile)
>   {
>   	u32 out_data;
> @@ -1081,7 +1081,7 @@ static int thermal_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int thermal_profile_set(struct platform_profile_handler *pprof,
> +static int thermal_profile_set(struct device *dev,
>   			       enum platform_profile_option profile)
>   {
>   	if (quirks->gmode) {
> @@ -1107,7 +1107,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
>   	return wmax_thermal_control(supported_thermal_profiles[profile]);
>   }
>   
> -static int thermal_profile_choices(struct platform_profile_handler *pprof)
> +static int thermal_profile_choices(void *drvdata, unsigned long *choices)
>   {
>   	u32 out_data;
>   	u8 sys_desc[4];
> @@ -1140,17 +1140,17 @@ static int thermal_profile_choices(struct platform_profile_handler *pprof)
>   		profile = wmax_mode_to_platform_profile[mode];
>   		supported_thermal_profiles[profile] = out_data;
>   
> -		set_bit(profile, pprof->choices);
> +		set_bit(profile, choices);
>   	}
>   
> -	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST))
> +	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
>   		return -ENODEV;
>   
>   	if (quirks->gmode) {
>   		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
>   			WMAX_THERMAL_MODE_GMODE;
>   
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   	}
>   
>   	return 0;
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 4ff80ed4f157..1ba2e58451e1 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -184,7 +184,7 @@ static int thermal_set_mode(enum thermal_mode_bits state)
>   	return dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
>   }
>   
> -static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> +static int thermal_platform_profile_set(struct device *dev,
>   					enum platform_profile_option profile)
>   {
>   	switch (profile) {
> @@ -201,7 +201,7 @@ static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
>   	}
>   }
>   
> -static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +static int thermal_platform_profile_get(struct device *dev,
>   					enum platform_profile_option *profile)
>   {
>   	int ret;
> @@ -230,16 +230,16 @@ static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int thermal_platform_profile_choices(struct platform_profile_handler *pprof)
> +static int thermal_platform_profile_choices(void *drvdata, unsigned long *choices)
>   {
>   	if (supported_modes & DELL_QUIET)
> -		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
>   	if (supported_modes & DELL_COOL_BOTTOM)
> -		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
>   	if (supported_modes & DELL_BALANCED)
> -		set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +		set_bit(PLATFORM_PROFILE_BALANCED, choices);
>   	if (supported_modes & DELL_PERFORMANCE)
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 1b9e176f8d6f..3849cf761a46 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1221,7 +1221,7 @@ static int platform_profile_omen_get_ec(enum platform_profile_option *profile)
>   	return 0;
>   }
>   
> -static int platform_profile_omen_get(struct platform_profile_handler *pprof,
> +static int platform_profile_omen_get(struct device *dev,
>   				     enum platform_profile_option *profile)
>   {
>   	/*
> @@ -1318,7 +1318,7 @@ static int platform_profile_omen_set_ec(enum platform_profile_option profile)
>   	return 0;
>   }
>   
> -static int platform_profile_omen_set(struct platform_profile_handler *pprof,
> +static int platform_profile_omen_set(struct device *dev,
>   				     enum platform_profile_option profile)
>   {
>   	int err;
> @@ -1345,7 +1345,7 @@ static int thermal_profile_set(int thermal_profile)
>   							   sizeof(thermal_profile), 0);
>   }
>   
> -static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> +static int hp_wmi_platform_profile_get(struct device *dev,
>   					enum platform_profile_option *profile)
>   {
>   	int tp;
> @@ -1374,7 +1374,7 @@ static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> +static int hp_wmi_platform_profile_set(struct device *dev,
>   					enum platform_profile_option profile)
>   {
>   	int err, tp;
> @@ -1440,11 +1440,11 @@ static int platform_profile_victus_get_ec(enum platform_profile_option *profile)
>   	return 0;
>   }
>   
> -static int platform_profile_victus_get(struct platform_profile_handler *pprof,
> +static int platform_profile_victus_get(struct device *dev,
>   				       enum platform_profile_option *profile)
>   {
>   	/* Same behaviour as platform_profile_omen_get */
> -	return platform_profile_omen_get(pprof, profile);
> +	return platform_profile_omen_get(dev, profile);
>   }
>   
>   static int platform_profile_victus_set_ec(enum platform_profile_option profile)
> @@ -1472,7 +1472,7 @@ static int platform_profile_victus_set_ec(enum platform_profile_option profile)
>   	return 0;
>   }
>   
> -static int platform_profile_victus_set(struct platform_profile_handler *pprof,
> +static int platform_profile_victus_set(struct device *dev,
>   				       enum platform_profile_option profile)
>   {
>   	int err;
> @@ -1488,19 +1488,19 @@ static int platform_profile_victus_set(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int hp_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
> +static int hp_wmi_platform_profile_choices(void *drvdata, unsigned long *choices)
>   {
>   	if (is_omen_thermal_profile()) {
> -		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
>   	} else if (is_victus_thermal_profile()) {
> -		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
>   	} else {
> -		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> -		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
>   	}
>   
> -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 55aac0190624..1937a2f00bec 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -933,10 +933,10 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>    * dytc_profile_get: Function to register with platform_profile
>    * handler. Returns current platform profile.
>    */
> -static int dytc_profile_get(struct platform_profile_handler *pprof,
> +static int dytc_profile_get(struct device *dev,
>   			    enum platform_profile_option *profile)
>   {
> -	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
>   
>   	*profile = dytc->current_profile;
>   	return 0;
> @@ -986,10 +986,10 @@ static int dytc_cql_command(struct ideapad_private *priv, unsigned long cmd,
>    * dytc_profile_set: Function to register with platform_profile
>    * handler. Sets current platform profile.
>    */
> -static int dytc_profile_set(struct platform_profile_handler *pprof,
> +static int dytc_profile_set(struct device *dev,
>   			    enum platform_profile_option profile)
>   {
> -	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
>   	struct ideapad_private *priv = dytc->priv;
>   	unsigned long output;
>   	int err;
> @@ -1023,11 +1023,11 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>   	return -EINTR;
>   }
>   
> -static int dytc_profile_choices(struct platform_profile_handler *pprof)
> +static int dytc_profile_choices(void *drvdata, unsigned long *choices)
>   {
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 9e2f24de0207..3d45df807b8b 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -84,10 +84,10 @@ static int inspur_wmi_perform_query(struct wmi_device *wdev,
>    *         0x0: No Error
>    *         0x1: Error
>    */
> -static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
> +static int inspur_platform_profile_set(struct device *dev,
>   				       enum platform_profile_option profile)
>   {
> -	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> @@ -131,10 +131,10 @@ static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
>    *         0x1: Performance Mode
>    *         0x2: Power Saver Mode
>    */
> -static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
> +static int inspur_platform_profile_get(struct device *dev,
>   				       enum platform_profile_option *profile)
>   {
> -	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> @@ -164,11 +164,11 @@ static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int inspur_platform_profile_choices(struct platform_profile_handler *pprof)
> +static int inspur_platform_profile_choices(void *drvdata, unsigned long *choices)
>   {
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 964f842ef756..2e9740b7e328 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10415,7 +10415,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>    * dytc_profile_get: Function to register with platform_profile
>    * handler. Returns current platform profile.
>    */
> -static int dytc_profile_get(struct platform_profile_handler *pprof,
> +static int dytc_profile_get(struct device *dev,
>   			    enum platform_profile_option *profile)
>   {
>   	*profile = dytc_current_profile;
> @@ -10490,7 +10490,7 @@ static int dytc_cql_command(int command, int *output)
>    * dytc_profile_set: Function to register with platform_profile
>    * handler. Sets current platform profile.
>    */
> -static int dytc_profile_set(struct platform_profile_handler *pprof,
> +static int dytc_profile_set(struct device *dev,
>   			    enum platform_profile_option profile)
>   {
>   	int perfmode;
> @@ -10539,11 +10539,11 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>   	return err;
>   }
>   
> -static int dytc_profile_choices(struct platform_profile_handler *pprof)
> +static int dytc_profile_choices(void *drvdata, unsigned long *choices)
>   {
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   
>   	return 0;
>   }
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 97ce9bd476ab..0824a12b9998 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -31,11 +31,9 @@ enum platform_profile_option {
>   struct platform_profile_handler;
>   
>   struct platform_profile_ops {
> -	int (*profile_get)(struct platform_profile_handler *pprof,
> -				enum platform_profile_option *profile);
> -	int (*profile_set)(struct platform_profile_handler *pprof,
> -				enum platform_profile_option profile);
> -	int (*choices)(struct platform_profile_handler *pprof);
> +	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> +	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
> +	int (*choices)(void *drvdata, unsigned long *choices);
>   };
>   
>   struct platform_profile_handler {


