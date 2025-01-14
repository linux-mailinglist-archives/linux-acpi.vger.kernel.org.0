Return-Path: <linux-acpi+bounces-10623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF39A10C17
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0037A06A8
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A84155742;
	Tue, 14 Jan 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SGCcgVrR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC812FB1B;
	Tue, 14 Jan 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871626; cv=fail; b=uCyfGkFHuDc1A9v/QzX2rGAip0MkD68sdOpIT3GxwtpREyujwvbn9h3sozPTLeBRbMW7+yvQWIVBGfLRKGEI/lHEqKNr3ExbdRsD6EbLRflfQYbyGsSvc57P5yZYbf13bKe3SN3K3iEuznlO2AmMsWQEGA72HX5cf3bQYlCMlYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871626; c=relaxed/simple;
	bh=2o6iAG2Ed6uw+LzA42Im03rtyM6j5/PrBa3WSWsJCs4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qvbMG/N61iqncErPbWK7h5KHoFwG1AVQkYypPG2yldlp860A0O5CQozzK+2FgwGmJl1yuaVOFXlcXemVBvPdBfrBXN5HKPBoM+FYHRtwh8+ONwLBhfgchs7VVr8b/mX1rJ9n8AgPxsiwmJ+pA+55Jf+pwTeDHosfRtKoGRtJHjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SGCcgVrR; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAArBDrmGRXj1mYqQK1hrXGVthmlQMYvSXtEK/IWl9pbtfXzjTumIsGRtmRLH/vaJza2ej/gM8hF8k9oIQWV+ZqXXu1jgfpHEOmoQxillAnTTAb5kZ+6g/3cTBSo6HoXy36mvIAoh81JoQlYOj7DXseRe2qZL7riiHUGU7/QMUCcFrfJ1zpt8rQXZ3zrjHuOoFwiLID86EbocDoIEjjue8pcwVi49eOVonZ9a2Ty/lCsuF7fYePTkOqO1skZTlQNcMH9QDxqFhj9LJqUBm/86ToldfMhjPz4qrKj5J8IW7P4Ag9A4JZClcuPlI54CZVm7n530x1ZfQ+pTF5Z9GunwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ran7gxwkp9gzUP8zXsCFJnAseG2gM+XXRGXe37Rsw8=;
 b=xji6/ILb1dOPk31TcZg9JIB5CkiRikpfdPvc13eqNfh2ibrUpotnuKj34UYxFVxoOYX+KYBicQyN6tfAsFoVwZSkBPHJb4g4XTLg86Lvk+TeuNdPs0zTsSTzSaReZnzgA4LB7jV9H+0NaPImEoQChkjrBiF2G2ZTUxhsTI6cbN5itT1V+IXlXi0iNEuHK4hNyhUgKTcj/56rHmI+iI1OcaMByqavsO1dwUoEytnKjmbgsWlvWxO7eMgr1/DVTsHUIq/+j2w5rN9akdGV67V4tH+awTIH9UayxxflKQFGQbCShMolK0mxsFvI3MBRKr10zjOFh/g5VI6uzFdi+ZwV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ran7gxwkp9gzUP8zXsCFJnAseG2gM+XXRGXe37Rsw8=;
 b=SGCcgVrRVwINKKS40f53PyjOBn7slQPBSNOq02tvH0YRyxlNxe/AprC2cZDQwe7Z3DkwJf+1XfIjq6HlsSMOhaNcfjMr9vQKxDGelC4re2ujg0CwqPGxM1RK5H99EiVY08Jp1olZdN0shv2Iig5XxVNRIDSdkZstDR+miWa4rGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:20:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 16:20:18 +0000
Message-ID: <a0a3fecf-6b03-48f8-a03d-a7076f31e2dc@amd.com>
Date: Tue, 14 Jan 2025 10:20:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] ACPI: platform_profile: Add `probe` to
 platform_profile_ops
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250114153726.11802-1-kuurtb@gmail.com>
 <20250114153726.11802-6-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250114153726.11802-6-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: d76c54ed-aaa1-4688-2332-08dd34b755ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXZ3V2ZDc3lDRUNtZU8rUk5RcXVHOVJidEhEZ2lFa0x3Wlc5MVNCeE15UmV2?=
 =?utf-8?B?VDhYdjFmSEhoVGlSV0FVZEdIOUZNUDdtcnpnV2RFYmsrUDdDL3NTaE5JNDk0?=
 =?utf-8?B?dU0yWmJRUDZKR2F5dlFsb2ZBc3ZlTGFDNGJZRk5Ic3BiL3VMa3FHK1Fnb0d0?=
 =?utf-8?B?UFJVaXlhMXRZSklwNXFFS01lUytUSm5UemNlbGlwRCszUE9CKzVvajl0c3A2?=
 =?utf-8?B?ZzRUR3ZLcmpkc2MwU1VxS0kyVVZ5T2p6Z0FYbllsZUpma2ZUdzJEckgrTDFp?=
 =?utf-8?B?WG1pVXlWN0ppOG9ZR0Z0MncwaGNDUG9Ha3dFcmticWVmWk83MVlvVWwweGYz?=
 =?utf-8?B?TiswU2Z3ZTMrU0RSdkJLVGd2V2k3QWdwR1V6MmZDdElEclhyV0RyWW1DQ0xO?=
 =?utf-8?B?QUJ1eTFRTVh0ODQyK3JmYlpqOFcvb3RCaERKN3pEQXhKM1VNQnZQei9FVUhK?=
 =?utf-8?B?aHBEZ3VMY0t4MmMrQ05abjlNWlRlcngvcEx6S240dnlTdk8rYUdHeXVKaDlz?=
 =?utf-8?B?WjdBeExmL25aS3BBdUlzMWRWUXFhUjRnYmErRDVKWnpaeVZlSzZ1WUpyZjBQ?=
 =?utf-8?B?eUFFeVNsUzJlMm9PT2pCNk1DbDlqRjFSN1o3TWRKY2k1aFVnM2RVOGZFRjNR?=
 =?utf-8?B?akJMdC9WcDBnMEFRa0tXVUwrMmttRkhsVXRCb1RDcVd0Q0Z2WjhOR2VybjNa?=
 =?utf-8?B?RzJRRytlaTNhQ2lJODNoOFd0c21VTXlvYnc3SHRvZmpOQXI4d3doUEFYc3d5?=
 =?utf-8?B?bXBNNUJKK0ZTb3kvTEVabERWSUg5S2Z0UjY3YVdNWm9rNHJvTGtnTjFXYVZW?=
 =?utf-8?B?eER6cDVVZlhTTjQvZmZIREU4TDB2dTBORUhNaDNUUEtDMnNCZGROK0V5aWE4?=
 =?utf-8?B?MGthaEdDU3lTQnBRcEIrZXJqNW0vWnN4QmpPRTY1RHVQeWV4N3FGQ1E3UURl?=
 =?utf-8?B?USs4TzZqQ241bTNiV2lpN2NhRzlrRmRTTEJNSkRscUMvUW5ILzVwZEZvUC9F?=
 =?utf-8?B?VnZRQ3BPenlqY1JWeTdGK0VLbk5ZRGdNSXUweG9oRHBSaWpXYkRkeUN5cFNU?=
 =?utf-8?B?RVR0enN4U25NSE5OYUkwSlVZNG5NTlA0bG1sbHlZNCtvMUVzTzVPeUV2VVFU?=
 =?utf-8?B?Nmcza1R6U24veXYyK0U4NzdHR1lNMkhUTEVLM2NQbElSU3NFcjd1MFVFajJ2?=
 =?utf-8?B?bjFmdTdmd2ZyTnVVMml0cVd2Z0V1SDdJYmdtcnlrYUE0OC93dlVSWGhFTzFS?=
 =?utf-8?B?S0xtTXZkaGJCek5xWDluNDcwbzN4YlRudDlJQ3lUdngxdlZyZkZvT1lBZ0lh?=
 =?utf-8?B?cktrQ3pUaW9jNEhsVWUxeG83SEsrSGFOeE9PeDUrd09nR2xmcHNQNnpFcnpW?=
 =?utf-8?B?S1RFeCs0cURLcUc0NEhBOGRmclN1blFZK2JMaVNMbDVWNHQyTnFhb0VCY3Rv?=
 =?utf-8?B?RkN2RWphWnljVmFYa1Rvd0hGazRiUm1WWTRaamx4TnlSUjRPd1hWc1Y3L250?=
 =?utf-8?B?Y1ZzdUFwZ05RQlFVWmd5SElUSjF2Zm5hQm96RVJMYVlHZ08zRkk5cWlZMFNW?=
 =?utf-8?B?N0p6Y2RWOUsybVhjNkFxNXBRNTdtc0p5RGR6L2lncUhoNEN0NzNydThnT2ZE?=
 =?utf-8?B?ZGgwTTJpdVhISWtVSkk4YXkrNGZlWkwwc093em9zb2RZaXNIM25PcmxPSUxW?=
 =?utf-8?B?OUlYbXFYZEtVVkRweFZRU1Zza2VKaUFOekYzQ3VjTVAxZzVYdWt0V0RLdElB?=
 =?utf-8?B?aWprQXltSU1yQ2pVaFBPOXduSThLdjd5d2grVEg3Q0ZZSFcvMTgxUlNWenlv?=
 =?utf-8?B?cWtxYU14d1JRNkRtQkpsQTA1WVk0QkZzV1F3Mk56K3RRcjdhRVIwOWZjc1dV?=
 =?utf-8?Q?DEvM6EdNPW1l+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjFRUlI4RjZ2aUQramhzVmcyNkp0ODNiZi9rNUpMaWU3NWkyM0lydFpqRGRO?=
 =?utf-8?B?eEw2bThEaytqbWtOZWlKZWk2eVNVOURCRlhYK2ZrM24zQzU5Q1VpQVpGUm5m?=
 =?utf-8?B?MWVQZlBPUjVjUE8vWU51Z0hjems4dXNzM2RBcDBDUzRFQlZhQWZxRld5WWdo?=
 =?utf-8?B?N2M5cHZXZUt0UFVNY2EzNkZDSkhFUGJXV3lRSVZzU3JjMHpmaXZ2N0V1ZlZQ?=
 =?utf-8?B?RUtlNVdpdmdIdytBdk1TWGdwRlRVQVJleU1JUG5NemZUeWNzRHVIUk1xdHVX?=
 =?utf-8?B?MHR6bVR6eHl4ODZUS01mdlkwYzQ4VDh6NVhWelNkZXA0cG44dittMllTemtr?=
 =?utf-8?B?SS9DdzNiSm5Qajh2dlMwSnQ1MnM0eGtQSEt4aVlQTmVkVEQ1djVhLzI2Y21V?=
 =?utf-8?B?Uml1bDgwN0d5RDZncDRFN3U2Sm41TmVUdVdJUkNBNmFhUUcvZ3RpYzdWWllN?=
 =?utf-8?B?RzdOMXJmZkdiUnViczgybkp6TmtMU3RkMkNPVDJuSmpSUlE4ZjdVWWxhQklk?=
 =?utf-8?B?TWlZQWFIV3dmU2paN2NFWVQwNVhtdlhsYzJnVDRSZ05tYzBwbTg5RUJIYVlz?=
 =?utf-8?B?U1RjZE9nUmt6ejZhTUhpUHVRdDBzZWNrOHloOVY5NGFlUUUxb2dXTjgrNkNY?=
 =?utf-8?B?SnNNS2EwTHQxV01EN29QRklRSGdPeUhCUUREdjgydVAzbzRQMW9LYXhwSWVx?=
 =?utf-8?B?cHJ5b0E4L1BHNjZNOHNLVmJPbzkrQnh6QTdTdmtCSVZ1TkJhSHNIc01xS1Z1?=
 =?utf-8?B?NmFtODY0QlYwUnp6ZDhiNTMrNnZwMlhXcG1LdUo0Y3kxbEhzVFRaSU9jL2or?=
 =?utf-8?B?SGRnRjNYdkcxSXc3K0dXS1FETnJ5eEV3MVJsUzRGWnFZT25WckdKVXdwMTMv?=
 =?utf-8?B?THhIdHZhZyt2RFNnV3M5SXQyOTNjRStKT0wrbUZ2endoaWQwUlBVdlJob2J0?=
 =?utf-8?B?eHJMK1p4eFh2ZzFMQUZlZTdERDBRQ3VSWHhzTVRjbmQxTnZUVFMvMmVTU1VG?=
 =?utf-8?B?NUswSGhVUHVFSDRrY3VjQUpsLytqZVMrTDR0dnE3K3NjZ0ZvTmhUYTRBN296?=
 =?utf-8?B?WGxjckZFa0oza21SWk1GaThBOVoyQ0I2djJkTHNmVXV5R3NlbkRmTVpBMmtU?=
 =?utf-8?B?NzhvQ0R1Z3gzZXltRHhZVytLQUM1M1daakwycTJUODkrNDJuUEVLUVZNSlhm?=
 =?utf-8?B?b3FhZFVIZE9ta1dpNmpBR0VyRFFISC9ERDNHUnhkbHRQWXZESWtCKzhrT1lz?=
 =?utf-8?B?cmZsaE05a0dydkFXNm8zNGMrZ0p3OWQ0QXlTZlZZNEtHaHRrRU9KWEFXWHh4?=
 =?utf-8?B?LzFxcVYxOS9zbHFlMVhOanRtRXBxelZQTERZMW1ScUtUQXZjZXgyTEVGZ0hU?=
 =?utf-8?B?ZFhaand6dGljaGhYdFErNGNsTGNqenBIbGRLaktSbjZkZDZPeXFFbXQ4SWpY?=
 =?utf-8?B?Mm5QeGdyZkVrV2RuWEVMRXJuY0dmYlFNcWpCS0xHc2k3ZFFMSjhqVFdqLzNF?=
 =?utf-8?B?bmtwTGJ1ZDl4YWV1dzFCWnVpWEJ5VEQrMmdrcDRRSitvdmdsOUNQbFJ3U0F5?=
 =?utf-8?B?TW9xMklrTExEaitEN2tYUVp6VTZFenJZbjZiOW81NkZMVm5GZEd0RmR6cHFZ?=
 =?utf-8?B?dGJ0LzRmN1JTWDlyVS9uVGtzd1FrV3h6d0psMXd3ZjJlek0wQllMVFVVaDJo?=
 =?utf-8?B?TVV1WnVzVHJDOGt2djR5M1pONHlaaDBLSllFV0VMS0ZxeUJ6aDhKZ0VqNkJJ?=
 =?utf-8?B?OFlBbGJhM0VqZ04yMmppQjYyVWM0c2FjaExuOUtzZkI4NktHL3pGY3NpS3VV?=
 =?utf-8?B?MHpYNjZtMDVuaDdhWkVjb3JKMHUwckxUL2NST3JiVHU3REFLSyt5aUpvYlUr?=
 =?utf-8?B?K3JNKytuZ2d5UHltRHluTTZGd0pYU1NISDZNMzNmMkhaVkNMbS9zU3JFWDcv?=
 =?utf-8?B?aDdwdzlXRU9zekF3MnNTTHJvRjZDVjFXZjd6bmJwem03dmVJeDRIMHV0TG05?=
 =?utf-8?B?eHdTT1ZtU3k0SDhSSjFjc2pFZVBWd1EvcTR1T2xhOFo5SEhucHFDV0dTWC9N?=
 =?utf-8?B?T1JqQlRjWGdUQjUxRkpBTldaTVI0Qkg1Z2NXMTkvdnQrVTl5dXA2UTgrdVBl?=
 =?utf-8?Q?jgFbD0zWhtLUVvz2tRtkQseG4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76c54ed-aaa1-4688-2332-08dd34b755ba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:20:17.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxRBP/0TAKTdDfba8bJUXXoRhy9lN9NCApZxia5SYyGiXxaydyAX/JCz4kt7XMT4SdQWJMoH2Af0A6PkKKtg2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

On 1/14/2025 09:37, Kurt Borja wrote:
> Add a `probe` callback to platform_profile_ops, which lets drivers
> initialize the choices member manually.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/acpi/platform_profile.c               | 13 +++++++--
>   .../surface/surface_platform_profile.c        | 16 ++++++----
>   drivers/platform/x86/acer-wmi.c               | 24 ++++++++-------
>   drivers/platform/x86/amd/pmf/sps.c            | 15 ++++++----
>   drivers/platform/x86/asus-wmi.c               | 16 ++++++----
>   drivers/platform/x86/dell/alienware-wmi.c     | 24 +++++++++------
>   drivers/platform/x86/dell/dell-pc.c           | 26 ++++++++++-------
>   drivers/platform/x86/hp/hp-wmi.c              | 29 +++++++++++++------
>   drivers/platform/x86/ideapad-laptop.c         | 15 ++++++----
>   .../platform/x86/inspur_platform_profile.c    | 14 ++++++---
>   drivers/platform/x86/thinkpad_acpi.c          | 15 ++++++----
>   include/linux/platform_profile.h              |  1 +
>   12 files changed, 137 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 440654e21620..34e22b006ccc 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -466,12 +466,21 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
>   	int err;
>   
>   	/* Sanity check the profile handler */
> -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
> +	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
> +	    !pprof->ops->probe) {
>   		pr_err("platform_profile: handler is invalid\n");
>   		return -EINVAL;
>   	}
>   
> +	err = pprof->ops->probe(drvdata, pprof->choices);
> +	if (err < 0)

Any particular reason to specifically look for less than zero?  Did you 
want to have the probe() return something positive in some circumstances?

If not I think this should be fine:

if (err)

> +		return err;
> +
> +	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
> +		pr_err("platform_profile: no available profiles\n");

Doesn't pr_fmt handle the prefix?

> +		return -EINVAL;
> +	}
> +
>   	guard(mutex)(&profile_lock);
>   
>   	/* create class interface for individual handler */
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 76967bfeeef8..48cfe9cb89c8 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -201,7 +201,18 @@ static int ssam_platform_profile_set(struct device *dev,
>   	return tp;
>   }
>   
> +static int ssam_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops ssam_platform_profile_ops = {
> +	.probe = ssam_platform_profile_probe,
>   	.profile_get = ssam_platform_profile_get,
>   	.profile_set = ssam_platform_profile_set,
>   };
> @@ -223,11 +234,6 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
> -
>   	return platform_profile_register(&tpd->handler, tpd);
>   }
>   
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 91ae48adf6cf..6953e36dbfde 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1916,7 +1916,20 @@ acer_predator_v4_platform_profile_set(struct device *dev,
>   	return 0;
>   }
>   
> +static int
> +acer_predator_v4_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
> +	.probe = acer_predator_v4_platform_profile_probe,
>   	.profile_get = acer_predator_v4_platform_profile_get,
>   	.profile_set = acer_predator_v4_platform_profile_set,
>   };
> @@ -1931,17 +1944,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
>   		platform_profile_handler.ops =
>   			&acer_predator_v4_platform_profile_ops;
>   
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE,
> -			platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> -			platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_BALANCED,
> -			platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_QUIET,
> -			platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_LOW_POWER,
> -			platform_profile_handler.choices);
> -
>   		err = platform_profile_register(&platform_profile_handler, NULL);
>   		if (err)
>   			return err;
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 6ae82ae86d22..e710405b581f 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -387,7 +387,17 @@ static int amd_pmf_profile_set(struct device *dev,
>   	return 0;
>   }
>   
> +static int amd_pmf_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops amd_pmf_profile_ops = {
> +	.probe = amd_pmf_profile_probe,
>   	.profile_get = amd_pmf_profile_get,
>   	.profile_set = amd_pmf_profile_set,
>   };
> @@ -414,11 +424,6 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   	dev->pprof.dev = dev->dev;
>   	dev->pprof.ops = &amd_pmf_profile_ops;
>   
> -	/* Setup supported modes */
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
> -
>   	/* Create platform_profile structure and register */
>   	err = platform_profile_register(&dev->pprof, dev);
>   	if (err)
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index d88860dd028b..3d77f7454953 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3852,7 +3852,17 @@ static int asus_wmi_platform_profile_set(struct device *dev,
>   	return throttle_thermal_policy_write(asus);
>   }
>   
> +static int asus_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
> +	.probe = asus_wmi_platform_profile_probe,
>   	.profile_get = asus_wmi_platform_profile_get,
>   	.profile_set = asus_wmi_platform_profile_set,
>   };
> @@ -3885,12 +3895,6 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   	asus->platform_profile_handler.dev = dev;
>   	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
>   
> -	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED,
> -		asus->platform_profile_handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE,
> -		asus->platform_profile_handler.choices);
> -
>   	err = platform_profile_register(&asus->platform_profile_handler, asus);
>   	if (err == -EEXIST) {
>   		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index f7a854d40575..0146d2f93be6 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1078,12 +1078,7 @@ static int thermal_profile_set(struct device *dev,
>   	return wmax_thermal_control(supported_thermal_profiles[profile]);
>   }
>   
> -static const struct platform_profile_ops awcc_platform_profile_ops = {
> -	.profile_get = thermal_profile_get,
> -	.profile_set = thermal_profile_set,
> -};
> -
> -static int create_thermal_profile(struct platform_device *platform_device)
> +static int thermal_profile_probe(void *drvdata, unsigned long *choices)
>   {
>   	enum platform_profile_option profile;
>   	enum wmax_thermal_mode mode;
> @@ -1116,19 +1111,30 @@ static int create_thermal_profile(struct platform_device *platform_device)
>   		profile = wmax_mode_to_platform_profile[mode];
>   		supported_thermal_profiles[profile] = out_data;
>   
> -		set_bit(profile, pp_handler.choices);
> +		set_bit(profile, choices);
>   	}
>   
> -	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> +	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
>   		return -ENODEV;
>   
>   	if (quirks->gmode) {
>   		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
>   			WMAX_THERMAL_MODE_GMODE;
>   
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   	}
>   
> +	return 0;
> +}
> +
> +static const struct platform_profile_ops awcc_platform_profile_ops = {
> +	.probe = thermal_profile_probe,
> +	.profile_get = thermal_profile_get,
> +	.profile_set = thermal_profile_set,
> +};
> +
> +static int create_thermal_profile(struct platform_device *platform_device)
> +{
>   	pp_handler.name = "alienware-wmi";
>   	pp_handler.dev = &platform_device->dev;
>   	pp_handler.ops = &awcc_platform_profile_ops;
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 9010a231f209..32b3be0723f8 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -24,6 +24,7 @@
>   #include "dell-smbios.h"
>   
>   static struct platform_device *platform_device;
> +static int supported_modes;
>   
>   static const struct dmi_system_id dell_device_table[] __initconst = {
>   	{
> @@ -231,7 +232,22 @@ static int thermal_platform_profile_get(struct device *dev,
>   	return 0;
>   }
>   
> +static int thermal_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops dell_pc_platform_profile_ops = {
> +	.probe = thermal_platform_profile_probe,
>   	.profile_get = thermal_platform_profile_get,
>   	.profile_set = thermal_platform_profile_set,
>   };
> @@ -239,7 +255,6 @@ static const struct platform_profile_ops dell_pc_platform_profile_ops = {
>   static int thermal_init(void)
>   {
>   	int ret;
> -	int supported_modes;
>   
>   	/* If thermal commands are not supported, exit without error */
>   	if (!dell_smbios_class_is_supported(CLASS_INFO))
> @@ -265,15 +280,6 @@ static int thermal_init(void)
>   	thermal_handler->dev = &platform_device->dev;
>   	thermal_handler->ops = &dell_pc_platform_profile_ops;
>   
> -	if (supported_modes & DELL_QUIET)
> -		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> -	if (supported_modes & DELL_COOL_BOTTOM)
> -		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> -	if (supported_modes & DELL_BALANCED)
> -		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> -	if (supported_modes & DELL_PERFORMANCE)
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> -
>   	/* Clean up if failed */
>   	ret = platform_profile_register(thermal_handler, NULL);
>   	if (ret)
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 60328b35be74..75bcd8460e7c 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct device *dev,
>   	return 0;
>   }
>   
> +static int hp_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	if (is_omen_thermal_profile()) {
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
> +	} else if (is_victus_thermal_profile()) {
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	} else {
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
> +	}
> +
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static int omen_powersource_event(struct notifier_block *nb,
>   				  unsigned long value,
>   				  void *data)
> @@ -1566,16 +1583,19 @@ static inline void omen_unregister_powersource_event_handler(void)
>   }
>   
>   static const struct platform_profile_ops platform_profile_omen_ops = {
> +	.probe = hp_wmi_platform_profile_probe,
>   	.profile_get = platform_profile_omen_get,
>   	.profile_set = platform_profile_omen_set,
>   };
>   
>   static const struct platform_profile_ops platform_profile_victus_ops = {
> +	.probe = hp_wmi_platform_profile_probe,
>   	.profile_get = platform_profile_victus_get,
>   	.profile_set = platform_profile_victus_set,
>   };
>   
>   static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
> +	.probe = hp_wmi_platform_profile_probe,
>   	.profile_get = hp_wmi_platform_profile_get,
>   	.profile_set = hp_wmi_platform_profile_set,
>   };
> @@ -1598,8 +1618,6 @@ static int thermal_profile_setup(struct platform_device *device)
>   			return err;
>   
>   		platform_profile_handler.ops = &platform_profile_omen_ops;
> -
> -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	} else if (is_victus_thermal_profile()) {
>   		err = platform_profile_victus_get_ec(&active_platform_profile);
>   		if (err < 0)
> @@ -1614,8 +1632,6 @@ static int thermal_profile_setup(struct platform_device *device)
>   			return err;
>   
>   		platform_profile_handler.ops = &platform_profile_victus_ops;
> -
> -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>   	} else {
>   		tp = thermal_profile_get();
>   
> @@ -1631,15 +1647,10 @@ static int thermal_profile_setup(struct platform_device *device)
>   			return err;
>   
>   		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
> -
> -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	}
>   
>   	platform_profile_handler.name = "hp-wmi";
>   	platform_profile_handler.dev = &device->dev;
> -	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
>   
>   	err = platform_profile_register(&platform_profile_handler, NULL);
>   	if (err)
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 96e99513b0b5..050919a28d2b 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1023,6 +1023,15 @@ static int dytc_profile_set(struct device *dev,
>   	return -EINTR;
>   }
>   
> +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static void dytc_profile_refresh(struct ideapad_private *priv)
>   {
>   	enum platform_profile_option profile;
> @@ -1064,6 +1073,7 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
>   };
>   
>   static const struct platform_profile_ops dytc_profile_ops = {
> +	.probe = dytc_profile_probe,
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
>   };
> @@ -1112,11 +1122,6 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   	priv->dytc->priv = priv;
>   	priv->dytc->pprof.ops = &dytc_profile_ops;
>   
> -	/* Setup supported modes */
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
> -
>   	/* Create platform_profile structure and register */
>   	err = platform_profile_register(&priv->dytc->pprof, &priv->dytc);
>   	if (err)
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index d0a8e4eebffa..06df3aae9a56 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -164,7 +164,17 @@ static int inspur_platform_profile_get(struct device *dev,
>   	return 0;
>   }
>   
> +static int inspur_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops inspur_platform_profile_ops = {
> +	.probe = inspur_platform_profile_probe,
>   	.profile_get = inspur_platform_profile_get,
>   	.profile_set = inspur_platform_profile_set,
>   };
> @@ -184,10 +194,6 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	priv->handler.dev = &wdev->dev;
>   	priv->handler.ops = &inspur_platform_profile_ops;
>   
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
> -
>   	return platform_profile_register(&priv->handler, priv);
>   }
>   
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 9978fd36a3d1..5c250867678f 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10538,7 +10538,17 @@ static int dytc_profile_set(struct device *dev,
>   	return err;
>   }
>   
> +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops dytc_profile_ops = {
> +	.probe = dytc_profile_probe,
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
>   };
> @@ -10584,11 +10594,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   {
>   	int err, output;
>   
> -	/* Setup supported modes */
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dytc_profile.choices);
> -
>   	err = dytc_command(DYTC_CMD_QUERY, &output);
>   	if (err)
>   		return err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 6013c05d7b86..5ad1ab7b75e4 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -31,6 +31,7 @@ enum platform_profile_option {
>   struct platform_profile_handler;
>   
>   struct platform_profile_ops {
> +	int (*probe)(void *drvdata, unsigned long *choices);
>   	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
>   	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
>   };


