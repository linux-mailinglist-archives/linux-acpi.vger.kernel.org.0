Return-Path: <linux-acpi+bounces-10483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2EEA07DD6
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECD93A1BFE
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C91221DBD;
	Thu,  9 Jan 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xxy555cg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03F221DA3;
	Thu,  9 Jan 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440837; cv=fail; b=UzyJBogT/auRPq0enlxSeFTFu8mJmk9sqPADHtdN3H7Tgw0ByGjbDHI+zKcca+1haxetf+8J8Iju5VUpw9nauQZIY1kqYiaAhVkJFTCMo//L2hntQekh2VfecKzxb9dnAH+qEXmtq6iUXxoIRASevGNLhLh/xS2jA+jcdjgoTXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440837; c=relaxed/simple;
	bh=SFxj8sgrnZWmCXCurUTSkeE6OqKljc2F0H2G0daXd9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JRIRLWa3Q9AIyu3qIKn8gXbDmovhPGgo5Kk0GKqKNZCX/ibNwmuP6Gs7Upht/C6OdYQN3VXB+RrV4WJH5mYL000GBxT2tBlxGWluC0srE2MtnGwUKy6OLDmUyTkNBbhzJiG1lY2EoosUQ/LmFrF2ZpaP6pkqGx7ShU5PGweXlnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xxy555cg; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNpT86dTNjJySPBZc6pMpYpNJof08YOpD32VUmpHXVUBotmQgYQFxRVQwXXXt3ApsiKBz8FeDuso8zKlgo/fgZZBWwo+Wr1A1pIElsKxXKiVJjftLQiVpQd2lm1WpXVInaVUo2YFhX9+dq/yQL/wHaRXTC0LDso+doXEXMnb7++ubTwEX0TnnO0N7dvoDuCRCLWbA5NRZti/i8raqXO2ZCkPvVMqVrx9uaQG4TC6mNcZMtWuCcrgdDICX8FhfS043WWVfSBosaS97TjBWU8VK/o+vbU4BrKVnTAowDKVFvgywR4pggsvqVbwVVyFobHR7MVAtyeLNp2ilA+ueWfH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+YXiCpHnq7+hj8gKsFH+KQNxLPvzktKranJKkK0KaI=;
 b=q5/ALPWod7AOcJhl22uv+uxrCmngIodsRlvrzu1YtCUIvQ8ur43r/JuoH1lgfvnDeoWCOZglUzozZZBKuuU7oFj7pMXoCr0zsIpMVGJJJ4BgHfIGsPDCa9i7D1F73C+Ixm7XSkt4P62QRSr2AZZFnnXJLX0zhRDPiFkGEBy1p4eqGTywj6H5Ik9hxnKHgiNf2cXilg2E8/b/oUCh5ytOMM7w0W3ESLjJxWIYo/QX7vyFvc6DIbTwDlXbRxWNpx5unQYySD24XhMvOMbaJGPCbHJnLKP0zgT7ftqaqeGeoEQRy50lLt2FSabCPoYpNee8kUmylTOM4/TMRGUbmFsw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+YXiCpHnq7+hj8gKsFH+KQNxLPvzktKranJKkK0KaI=;
 b=Xxy555cgmhw81vGqwH4OoG56O57GuvP39bpZbFutE4Ti9fHi02Q3idP6nzEBdowisRlcz0waxoeD2i96ygo715DEhlVuIpdWPQxA+ds8wfpvllaZVC9VgTK2cpGiPM7p5Kpt6perEApOuRVlVkhNYQhEduSlxYpyXspqxsSMkCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:40:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:40:33 +0000
Message-ID: <cf174e21-c9f1-4891-8c4b-b76a4e45e367@amd.com>
Date: Thu, 9 Jan 2025 10:40:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] ACPI: platform_profile: Move
 platform_profile_handler
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
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-17-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-17-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0024.prod.exchangelabs.com (2603:10b6:805:b6::37)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc35ab7-f5c7-4aaf-cc37-08dd30cc55f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTBkeDAxU1VYeXVDUUhaSWdGQ0tJTUtMRGlPN21ZVHc4SGNIa3YwU25uYTYr?=
 =?utf-8?B?cWp5bFNhMDRlaTAzWWxuemc2MzZNdmRucTNJMXFKWFoyODFFMlNGaVdGL0k1?=
 =?utf-8?B?VFJBN2ZpZEpwSHZWN2U3SE00NkcrbFZrcDloN3pQOGhiRzdPRzhBOHV3Vm9D?=
 =?utf-8?B?K3loK20rN3JRWHMreDlFY3Q0WVJ1ei9ISDZTeTc5TnI1dDdQc2FIRjhmOUhT?=
 =?utf-8?B?ZlVhR0drZmM4L1k4TG8yenpYNDBzalRmOXlNc050QXNBV0FURGRYMUUxemli?=
 =?utf-8?B?bDhqRStxcVlJTXB4Y2tmKzVEZUUyN0x2eUxxc2NNaXJ0a091SnlZeURZVVh6?=
 =?utf-8?B?Uk40NGVITDhqaUZVUFhQaFdjT0RRTDlTcDN2a3IzOGUyd041NVB3N2paTEZL?=
 =?utf-8?B?MlF2UUtIRTc2Nno4RU1MeGZtUGJPSlptZTlmWXVCSk9FT2F5M3FNSkM1akhV?=
 =?utf-8?B?anErMEtOQVZnZjJJZHVQRUdBaThXeG9iQmlpZ0pwaU9JbUttUFJ2cGdXTWsv?=
 =?utf-8?B?Vkl3bGlTTWpzYnZ1SDJvRjV4U0ZsY3lIaTNuSXhpZlVLb1BHRXk0aGx1WHo3?=
 =?utf-8?B?SXQ2c2dZam05M1VMcGhQV2Zkak1mUnoyR01TcHEyTktVakM4SVViUFRSTWVN?=
 =?utf-8?B?R1Q0ditjYkdJZExKZktBczFoamdsdUUzRjNYU1Z0YkJvSTlCRmM1RUE3Qnh1?=
 =?utf-8?B?NnNqK1R0dmltSVd4L3NpYkZTZlIzd0llSkhnaUFKcnc5S0dtWG1LL0pQUGJw?=
 =?utf-8?B?SkJBMTJielI4N2EweHNNTGFIVDdkUE5LTlZLZ0R5SjZ4MEhxa2h0bW53V2h0?=
 =?utf-8?B?cmF2RUQ4QVI2T3dTUUV0STVrejQvZkRRaFBlOGhrRW5MTS9OaTB5VHVobDFq?=
 =?utf-8?B?YURXTFVUcFhhbmsrNlp1bHNmY0gycko4amdWM3RMdjFnYWhLRWkzSzZBcVN5?=
 =?utf-8?B?Y3ZJMTBuZjZMVExaRnc2dTB1cVJmeEo0djRtRmlCaDcvMjcyeHB5dmFtdWlS?=
 =?utf-8?B?UmlKS3Y4bWVuQnJraEhaY0czc3VWcDk1VEFmaDBWWmc3VCtqS2x1eVZsMzVQ?=
 =?utf-8?B?VG1WUDRpeDdYelRBczFsbnNHZlB6VFBXNTZCbFJmR1JBTTVKUmJ6R3laT1cy?=
 =?utf-8?B?OWlzL1RoYllUaTNtM2lwZkhQV1hvamkzQ25FK0RDeXEzL2hoTDBFazJzcFNB?=
 =?utf-8?B?czN5QVlJaXJlNWdjS0dQdHZsNmxUbVFCRDE0aktpQkFySUNGcjcyODR3dDBi?=
 =?utf-8?B?TDVTTlRMaHZNcHFZK2NkTUhkYmlhdGhCMWhxMExHcXNLWWRLcHMwdWFFZjEw?=
 =?utf-8?B?QXFBRlVLQ1BKTmsvSm5JODB1RmUvNlZxcWVYUFZYQUJYRHlna3hnWUZrdi93?=
 =?utf-8?B?VWhZVUxlQWR0YkxRb1lMbkJFR0thQ21ISjZZOU9keStDT25JemR0UUJqeGIv?=
 =?utf-8?B?Q3pmTENXaGgwRDJDM1M5ZnREMHdxcFlHejE2TXZQZGhBN2p5eG55dGx5WVZn?=
 =?utf-8?B?UFc2cmk3UndjQVBnUGxmcU95c2doQkFuckRUUk50OHI4U2IxOFNSVUhIR1dV?=
 =?utf-8?B?MDlLcytndmFmU0lEMXQxdHVNRzRHQVB4NkVUY3BQT3Yra2NpT0VZQ21DeVIx?=
 =?utf-8?B?SEp2WW50amlhRUJmYWNSSDBwc1ZWQXVmdk90ejNoYk9nQ1J4T1JydFN1c28x?=
 =?utf-8?B?cmlyOWFSU3ZqRGJmWGJIdmtEekdtVEY5K3cwRU8yZUpPNWlMcGxYd2lmZFFM?=
 =?utf-8?B?QytwMWU4MXlSYjl2cXBOR1VmWVNwVW0wdDlEZ094T0dmajIreHdtNkZzbzY0?=
 =?utf-8?B?TG1yRHBreVhrcmpFK0lDN0lGYlFUbVpPWml3N0F6ZUdsQzJjRXNaUHhGNjdp?=
 =?utf-8?Q?Jhb3VX8znmexi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFlBVS9oN0FBSmc1c21GUGxkZ3IrQjg0VGxnR2kwSnV4SmFuRlRPOTVHME9s?=
 =?utf-8?B?VGFGK0FJYzhRQ0pHK0Q3TnpOKy9PMHdUOVNnVGF6MEhLU29kcm9NcHd5bnUz?=
 =?utf-8?B?VDZ0bnFkeWppSEFMRndVQUpHbjdXV1NUdkN2N2twWEFPKzNNRFR6cTFLSEhB?=
 =?utf-8?B?UFV1L3MzUXp1S0krNXBoS25vREUvZEZmWmpkTjZVZFdLOTQ5OHQxMzVIeUpO?=
 =?utf-8?B?YllIWXlCa1VCY2pId3hBR3BNTzZRN1BmdXlMalorY0NUV1JjendxbUxOZUc1?=
 =?utf-8?B?RGdsdmxOcW40V3BSMGExemVrZEZxYjdZU205dmV3Z2cxTEFzNk9SVFhMcUly?=
 =?utf-8?B?U01kbFZuMHBac09rUitMeDBVS1VEK1pKUUF4eWZOZmxnZ3NlZktpaEx1NnpC?=
 =?utf-8?B?Y082VEtUdHc1Nms1dEZIalFpSzZJVVVNOC8wY0tFbjhFNFYwTUdnRUFWNmk1?=
 =?utf-8?B?ZXVRL2hDdjBUVjRDOEtRZ1RZU0hsTXVveXBGUGlRbnFvNUxscis0WlRoUWdv?=
 =?utf-8?B?TUk5SHhwYUlCMFhWM1JXa2tPVW9LT1RZQXFoOXFmaUgwK1Y0RGhKWk1tRTcx?=
 =?utf-8?B?RHBkbFdCcFpvWW5SQ3hYNHNzOFJBTE04dTFXYVpYZmpjMDNGbTIyT28vN0VH?=
 =?utf-8?B?VE5GSWZqM1IwMUlkNlZVQkFmVjlxMDZKeER1dnpNSDRVYVJ3d25QS3ZNSG9j?=
 =?utf-8?B?bkY0QzVENWZtSXM5emM3MitDSnduWXFjV2NvTHh0ZTYySTlCQTJiWm52WnF5?=
 =?utf-8?B?dmRqUjZxZHFoQlJxbDQvampjU1BJMjZJbEtzRmpocTcrWnNvb1VxZXBBbi8x?=
 =?utf-8?B?QzRHeVRCUTU3NnI4OFVBd29YakRxOEluK2tiM2hoeVhtVWFJYStUb2ZuMGIv?=
 =?utf-8?B?dGhWYVVWR3RKS3ZkVSt6YUoxbWdJd3BjTmx3Ulg0RC80dFFqRkRxb1lCN2JW?=
 =?utf-8?B?RkZpVFErcVg1SXV4T2pYeFlQMWtrc2VlRlFsbEM3M2ZYT3hVOVE0b3pFbGh6?=
 =?utf-8?B?U0ZYSjloVlArUGNRc1AxYmJtRkdCMzI1RUpBK1lWeW8vZGZLQzRzQjRRb1Ex?=
 =?utf-8?B?UEdsZU5reEdEdFZyc044YkhBYnc0OElidVhndm1FNkIzRVJkaThWSVo0a09B?=
 =?utf-8?B?Q25JdjJ1VVAyUGszRm9CS09LRXg2c0ZaM0VqSXNKcTdZNElMK0dLREVBWUl2?=
 =?utf-8?B?MC8rQWJ1VjYwOXVnQ0hNU3JMY1FjREFZS3NnU1NKWGVyRlJPNmxsNkVIZ2hy?=
 =?utf-8?B?R05ZYTBCSFljaWZBQzk1WnVIbEc4UDR2VDkzYlVEUmVqMlNwTTFOM0ZPZjM4?=
 =?utf-8?B?cGZGN0NLNDFkR0ZRV3F5Zzg5L3J4V3p0eHhvK3lKYzk3NmhVZzNOSnJGTTU0?=
 =?utf-8?B?bGQ3aUxrekJPY0VqbXFpdWdSN3ZORDVpVzNYSnk5dHA5bnVPNUV5QWZzQTBy?=
 =?utf-8?B?ZUQremRwcDRPNEdNV0VobG1aSnhhZ05OYTZqUGJNUXQvcm5FeFM4R0xGbXlE?=
 =?utf-8?B?M21hVTBhV0xBSW9EeE8rOGNvN3FZK0RpekpVSnBMSGNBVysvNkM4YzNOWmR4?=
 =?utf-8?B?K040VWtCeE5jZEdBZm8wOUFxem5NWllxL1RKMnVJMEoyakdha1oyV1FoT2ly?=
 =?utf-8?B?cVhETTlscSsyUDkzcm03U1k0dkMwL3dqNHlXUTBicTNoNEpjRWU0cndqNFBU?=
 =?utf-8?B?S3NSbk9BdGhVS25DU1V1YzE2bll6bFRIclpvYmI1Z2xWaGdhR3IwVWlMbG5z?=
 =?utf-8?B?WEg0cUJWYzJORU1PYnFGUkovR1UwclRmZTh4V2g0d3Q5OUhSWnVYS1JpM2hN?=
 =?utf-8?B?UERRMUtSMkQ3cUZwYnFZRDNBU3RlaktEeHdIKysreU5KbExtS3lPWUhhSE54?=
 =?utf-8?B?eEhTUWZQcXAwWktmbVdwSmE4SmFBbFpPOXFzcDZkR1E5QTBVN05HeUl6Rktw?=
 =?utf-8?B?djJqRS9CMmwxdUsrOE9FNUpzNS9KdUI4V2wremRtU1VDUy9aaHlNMXJFNGwv?=
 =?utf-8?B?WGsyZHZFWEFBRDJOMXQyaStUMERlY3NWalZWbk9qYjZ4TldDUlV5aHFGRWNU?=
 =?utf-8?B?WGtOc1BNMC9Cd0ZjMytTMU9JYlFWQkREQm9mbXNPcDd5aUpFRmc1QmVUZWtw?=
 =?utf-8?Q?qfh2ikPu+rlZ+pjILTIN65GQA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc35ab7-f5c7-4aaf-cc37-08dd30cc55f4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:40:33.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGXTI16wslkx9Sq25cLNCs3WqSnu3TTgUNbi28sA0ZTJo10RKrrlxOLZE3O/brNhmjxB8QTVOsd05UmVa/SBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On 1/9/2025 09:06, Kurt Borja wrote:
> platform_profile_handler is now an internal structure. Move it to
> platform_profile.c.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonceillo <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c  |  9 +++++++++
>   include/linux/platform_profile.h | 11 -----------
>   2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 8d034d928e32..c7a867bd01df 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -15,6 +15,15 @@
>   
>   static DEFINE_MUTEX(profile_lock);
>   
> +struct platform_profile_handler {
> +	const char *name;
> +	struct device *dev;
> +	struct device class_dev;
> +	int minor;
> +	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	const struct platform_profile_ops *ops;
> +};
> +
>   static const char * const profile_names[] = {
>   	[PLATFORM_PROFILE_LOW_POWER] = "low-power",
>   	[PLATFORM_PROFILE_COOL] = "cool",
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 0824a12b9998..2c99aff7cd19 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -28,23 +28,12 @@ enum platform_profile_option {
>   	PLATFORM_PROFILE_LAST, /*must always be last */
>   };
>   
> -struct platform_profile_handler;
> -
>   struct platform_profile_ops {
>   	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
>   	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
>   	int (*choices)(void *drvdata, unsigned long *choices);
>   };
>   
> -struct platform_profile_handler {
> -	const char *name;
> -	struct device *dev;
> -	struct device class_dev;
> -	int minor;
> -	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> -	const struct platform_profile_ops *ops;
> -};
> -
>   struct device *platform_profile_register(struct device *dev, const char *name,
>   					 void *drvdata,
>   					 const struct platform_profile_ops *ops);


