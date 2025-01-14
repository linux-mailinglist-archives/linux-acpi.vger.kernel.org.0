Return-Path: <linux-acpi+bounces-10624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 958FAA10C2B
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BCD16570B
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69F1D47AD;
	Tue, 14 Jan 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ThSYaJBR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2F1CAA9A;
	Tue, 14 Jan 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871747; cv=fail; b=Hi2H3QxrgoanYD84EvtpcvgjMnKKVltPbxmBagh9ytSXUO7kEl9VaGWMZhZyREjNWoCbmsvOBMJ1wK/45QNkyL8FzXXDkSSTtDozma3p38GKDhcbdaHkyZEshK+ldepttBdIhHRlK5+FpHBtfk5QpWaJR4fHigYXYSDU2YdwR2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871747; c=relaxed/simple;
	bh=OPIVhpqeKT/xExWMupzMEsgon5PHFID8hlY/pZVBOZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TUvOvoILVw2TSTcfFqbv/ckeizjjunjov4O69UtP2wQm4OeMcZ64H0GkgY8dJmiNGdQ5USDsqro3Qd4TKo77Qmxcde536v8aHqHSSlzX+FV4dbamsH4oWtcJ//3/zFeMLZa4JuUevS7p6StOWyxI2UyHXTOTXtavtIHj4L7aK9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ThSYaJBR; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FECJnVUwtvBXs3ctEtDu55LFsitWZDFMdq2msKQdio2Xhh8MJlfFhB/Urpr8RTiyY8M43NRT/+QzfNXvhVmTootyyPKS4uLeyOTAqL4hnh1YFtwAPescD/JbA9JILHwzg62jhz0+zXmB+2Z39W/TXhq3zCdXet0l1QCsRm0/+WgscDHydpP7jUZMxygTFqVtRHWhPg+VkayoCn9kj15bnCT8kaaAudE+bo/YkPVW+5vq+6wA8QvEkNXio//UYhHmd/8Gdu19lhtBF0fyMmg8C7IGvUVMVQlpMNPoeti9APFWlxuO93ebIridUmx3w2OR9cDDy9IrDil8hpNsRrRLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrs3ce4xGndV+REAN1y0CPpN15NOT5fU1LjPIJI1hnc=;
 b=j3XIu9WP6lJ+cifHNQicWm0ko4Xy+yXp/55gmQZLKpkDFU9lUzHqm67Y8uHRQlFOBmtybpeGFpRRcAiWQQFsM3zzVz3ARs7Q8xa83asZpACDuxiDW37U0VMiC/62ETfc8eu/jh2sVcuDUMhg1gTy9WBkMBjKLjogluXzufgjipIP+eO6m2+GhEEJddsakIppOGQHVS9WEQSMlkJPLkCkbPjSp0s1xUk/soYlWkpVakVFwQ6Ntay2wfbmR2Dms1nstqaVSrNRqQNa4B9DS9e25REDiazw8hoX61JCTFUKwfzzl+AVRYYGvimUDxc24Sai41nt/scwzVxtkpVIrmxQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrs3ce4xGndV+REAN1y0CPpN15NOT5fU1LjPIJI1hnc=;
 b=ThSYaJBRnN3FSF5qCUf7uZVhiNR5s+/AEFHaWuKb1AgnyOqRC2leCKRGuo6RtIknje81RchzW2Yg2hGUpyOTpCcqMSzzTuRXxtFH/bfv6lRfks+1mU3Sj5xaKhkI/5PR3DdLPbAD72nAA6Xp8yZT0Ix3T9l8Ynd880fZJmZljfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:22:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 16:22:21 +0000
Message-ID: <aa5e4451-58a7-4685-9934-abab99f86092@amd.com>
Date: Tue, 14 Jan 2025 10:22:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] ACPI: platform_profile: Remove
 platform_profile_handler from exported symbols
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
 <20250114153726.11802-16-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250114153726.11802-16-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0208.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0463ec-e3bb-4358-503d-08dd34b79f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R09Odkdkc2NmdHRHWXRqTlo2QVBWczFvM1VPUWhHZUsyN296US84a284OEFl?=
 =?utf-8?B?SkRCdFhaWllXSnNTWjhsM2RIWXJSaHNlakozT2U1ZzVEekFTbXBUcFFiTzV1?=
 =?utf-8?B?ZmoxNXZnTVQyUUdJelN5WUhBQW8rTVpyN0taNEZ2bnNpb1g3RGN1T3NCaUtu?=
 =?utf-8?B?RnM4QnI5UUFRbmZyMCt5QnliSG1td1d1d2RFelg0Q0VTL1g4SWZsWWZTdUpK?=
 =?utf-8?B?U25UQnVhZGt5TmRhQS85VGR3Ly9hbjhycGE0WFBzTUQ2dDVZaVpNcDFqNVVS?=
 =?utf-8?B?Uk9ub3Jkd1A3VGxGYzNibVVJVlpvYURQa2JJRU9STGhkb3YrWFR1K25sN2JM?=
 =?utf-8?B?UllpaTc5TEtCTzVqSU5sWTNXM1FZbjQ0YmFuRGFJR1poWW1xM3dJOXY2cnRE?=
 =?utf-8?B?WE9jaHpnYUFrRkVhS1YyRE5mclM1Q201aTI5ejNuMjVJNzRZRS9uQWY0QmlV?=
 =?utf-8?B?ZUFlRi8zTTRUdm1PT3RicU1nTXVUTW9QTXdWK3pIQXNPQXpnRlJxdld0a2Jm?=
 =?utf-8?B?empONlJvdW5Pbk1sYndtUzNzaGorN0VnOHdJVlNPZzhZa3FveVhnQVFmMnVs?=
 =?utf-8?B?MkdvZC9GZll6Z2pPTDFRNGFXN1U1cE52bnVWeEUzbGJESTE0Ri9KNENBTUdm?=
 =?utf-8?B?dUFzZ3VSWGt6TVUrNFdvcUJUN1Q0TEwwcS9OZzlEOXoycFI1amdNak5aeUhI?=
 =?utf-8?B?SUFDaGtWV0p4TWk1dDVIdWlvT3dRNEQ5K0F0Q1hHVEdnRnExT1JIQ2dObDFY?=
 =?utf-8?B?ajFaYUxDd3h4NVRzem5HQWFQOGxpdmt2S212NHBhcGlBQTVGb0g3WEEwTVpp?=
 =?utf-8?B?cmtTQ0NSNWZ1akw1TU9MZTZNRnU5a2d2OUtKcDFnMmhIclZTSy8ra1pDczV6?=
 =?utf-8?B?ZWJPSGE3RTFEeGFDbzNkMHM0TWp5bTlKVFd3YTRNWXY3WG44VCtKekY0SDNp?=
 =?utf-8?B?bVgrNW9JTWd0S2x4c05rSkZjOVJxbi9QMDB5WFYzdXlLd0JUNnN3Uk03eGdt?=
 =?utf-8?B?czFxTmphcFhYWldGSWxHQW9PRG5CS3I2cDhvUVJYczJRQUJ0NkxIeGI5OG9u?=
 =?utf-8?B?WmhwVXFHZHpCaFNmandNbEQzQzBtSXB4TTJYYW51WlllTzJ5K1pKN2NFYVg2?=
 =?utf-8?B?bFg1QmRmdUc5Z1JKS2UzMExnRHNUQWdUV2I5OVlVWTNka3IxcnlLcjdDQXVx?=
 =?utf-8?B?VThaZjlyODAzZ3lqQ2lqMUFqRHFPUko3Mm43bjZyNk9zQW5TWUhpeHl6MzZ4?=
 =?utf-8?B?WVM2cUFpVTgxRDRVMk1BMzFuckEyUXpXUXRLMUpUQWtlTnpwMWEyTloxcUt5?=
 =?utf-8?B?Z0MrYTlSQnQ0dHQ4djdEVnA1eGhDME1BMHNzNmE5eWhtZDFwalNEOXB5NEVs?=
 =?utf-8?B?YzM3ZVgrQnBBdWdvTE1XKzltOXVSNXlqMGNhQVZmbDVHOTMxSUVzZEpCdVNy?=
 =?utf-8?B?VGtyZThHN3h5ZDdUaXR6Nk1lMUtGNm15d3RpK293a0s0QWNMVElSMFVZeTEv?=
 =?utf-8?B?dENLZ3ZGT0VpUC9BbjNqYlJ6c1l5SDRyTm9wY28zS3VQL1lvNE53NmpIL3lH?=
 =?utf-8?B?bkFPUTJyU1dUSEM2dlVWcGJmU1IwUUtRVkdSb3ZQVFZZYnVaRnlFemZpRXkz?=
 =?utf-8?B?OXVwb3hsWjBUYy92TDVOTXI1NHVKaTVCRmVHOTdBUWo5TXhVeXplcWFQbVFl?=
 =?utf-8?B?WGRsVnpiYVRwWUR4K2hLTmJFbUxEaGNTRkJqNWFqZjNLNnVqQWlKK2hNTTgw?=
 =?utf-8?B?dEY0b01UWXYwZTNKbU80WkJWSUtiY1EzZHcxcGlZOHBsS0xETHgvRWh6NEtE?=
 =?utf-8?B?TGVGdnFzTFR2OXlMVmNOcitnVWFTUmdKaUo4U3ZLOHdvbkRNRytWWWgybjRE?=
 =?utf-8?Q?ehEVmLdDQmYWe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzNjZE1melEycEdGaEVydWZXV2t4ZCtscW5aZkQ2UXZ0RFRMek5jcUlFNEg5?=
 =?utf-8?B?MGpSdzFmOW1wOXp3TWE0TkRBcVZnaHJmUXpxMzRKUlVYV3ZiWmZ6Tmw1NzR4?=
 =?utf-8?B?MVlyWnVlT3UrMjNCQzlwcExUTUljTnFXWnczRHU0MFUvb2FRQS9Sak01dWVD?=
 =?utf-8?B?bzJCWGl2U2pPdWszZmNsbDI0NkUwSTNMTlUxYlFvRWpHaE9ZQzlYV0ZnTzdY?=
 =?utf-8?B?ejR1WjExaEJCYmhNWDdQZVFNOVNIcFV0cXAzY3BoTTRyS0hUcGxpMEdyZjNF?=
 =?utf-8?B?akpib0xNejRtbDB0ZmxhRHU5UjRqdmxuR3VzZlduTWh5STk5QSswSkY0aFFu?=
 =?utf-8?B?MWRkRkJpd2YzeThuUTg4VXkxUnJnSU1VTTJLajhPTmVZakhCaWpnZ2s2bTRy?=
 =?utf-8?B?dU1PcVl6OSs5bENnSUtpamxJLzI5M2M1SFA1c0dOYzEzNVFaTWdIdlhqbm90?=
 =?utf-8?B?b2FwNTRmMVRkL3NjL2I0Tk1MeUg1VFMvWWs2UmkyZmRRbTV6ajJrR2Y0WFdp?=
 =?utf-8?B?WFVwdzI0eDAwbVdJVXc3UXFjMFVuZXN1NUFzSFRLZ0ZDT0NWZXlUbjV5NXBG?=
 =?utf-8?B?L0JJdWwvNWlvVm9wZnNsNzBvaTJ4OWtXZ2o5S25xQ2lCZ1MzRGRzYTVablE1?=
 =?utf-8?B?Z3pnTThCcURiUDF4L1lIRWRLUW0xaUV4ajYxTEFaKzRXSlZwb1d1eE5wWFZZ?=
 =?utf-8?B?WWkzeFI4RHMyKzNuRUxvbVFkemM5aGRIU1Mvd293a1UvWUovNjcvL3NpUkhU?=
 =?utf-8?B?YlZYdEtjaWdFTXVvVWlSci9XNXRZTzUxTUljQy9vQW5yeDVSS2xSOEFka1Uy?=
 =?utf-8?B?elBiQ0NWazlEVDB3V1lvUjFQRjRiOTgzRGxpbTdRaVE1R0Z0ZjF4c2lHenhT?=
 =?utf-8?B?K3NjL09DMklzeEowSmNsNzFVcytuU2FoTzdWb0pHT0RUUFljODFVd29mM056?=
 =?utf-8?B?Sk1LNmhsRHRkY0srd0NYV3dKVUc4ZVpWcHJtK204bFludWVIakFJMndUMlpw?=
 =?utf-8?B?MVRqaTZvL0JQR2xsRGU2QlRhdUYzOXYxZWJTOENNQjBvQzNtNWdzRVNSQU5Q?=
 =?utf-8?B?WkJZMUZzYWNZNjdaWmtUTEkxMjR4SWNzVmhDRGF2ODV5QXNQd1JpNVZuakdl?=
 =?utf-8?B?RW1YZFJGMW5IdVFwSWxuT1lRSmJtekxCYVhBMGw3SW5KQjQ0OTFsZml3MFNK?=
 =?utf-8?B?L3VMbXMzYjQwNWp3REJYN0RYRG1DQWZXSHdNb3dOVmc0cWlSUUhabU5va3FQ?=
 =?utf-8?B?Z2JqdDNzOFVENThyVVNmM2NYR3VXWDBqcTVuTXNqb0ttUDVQOTV4Qjg0V1pB?=
 =?utf-8?B?NE4yaFVzSU4wck9HRjJMOTdGaHR0dXJHT3RrUEVtbkJvWDdMUjZMdFpienly?=
 =?utf-8?B?N3NIRWgxc0hnRnFoVExRbElrSHpBcmtteG1mZXgzODEyQU5yOXB2TGhXa1Yx?=
 =?utf-8?B?TitySEpoMVNMM2NGYzc5blNaWkFaZFNtR0pVOVdmK0o1ODd3RHBJc3ZwN2cv?=
 =?utf-8?B?MmFxc0JRSzFKLytoZXVhWTdtdnJnTVNHSGlMclVLQTFhclFobVZRODVYREla?=
 =?utf-8?B?bWZvVitZSXluZHpVYXp5TlNSK25OTVRvallzNG9xSkhxbzJ6cHRTc2JMTU5s?=
 =?utf-8?B?UURHZkFiblhDWE5walo4N3ByTjBaVnZ6d0ZpQ001aDNOWkF1VU9MbXRJUFhD?=
 =?utf-8?B?L3JmQTI0R0hHWHFvdWJ4YUMvMXRlS2t4N0JlVjA0UWhpcC81NzJraGlLR2hy?=
 =?utf-8?B?bjN0UTh3RUJZTTlqeDMraDhWSVdRTm9ObkpPY1dxeC91dVpOM1hPWTRWK25u?=
 =?utf-8?B?U1lvcnMwTTFUenhaWGRxOFhHRlRwaUtVVDNqNGRuT1daWWpjdFlQMUpzUEdl?=
 =?utf-8?B?c1QrSWM5QUI5U0VIc2FCcWdMUEtyVDdpRzVPcTBGbzBvKzU4WTFPUE9SVC9r?=
 =?utf-8?B?S1B4Ymk0Njg0VDNjL3dIUGJkTFhxNG4zL3NvOXpTTnBWZDVDVWlLU3lGNEp4?=
 =?utf-8?B?ZERrWnNqYy9GdHNGU1c3M0VDaEs5RGpyRFFqOVM2VU1zMTQ3SXNkZDA0alY4?=
 =?utf-8?B?bnJWMTRmY1U0d2tPdTlqNk53ZGNZSW5qL0pEOUg2dTVnZnBrNjZaUWRGaWlo?=
 =?utf-8?Q?mPVznts6NBg41Elj6OTcBPau1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0463ec-e3bb-4358-503d-08dd34b79f5a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:22:21.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1d6ai4LDwPc2LpX57vKWL2gQ58ghKiWkWSdllrxfBYuGMggDjGN+6ViF4Utmr0az/8DXYcSqIR/+dquLadzWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

On 1/14/2025 09:37, Kurt Borja wrote:
> In order to protect the platform_profile_handler from API consumers,
> allocate it in platform_profile_register() and modify it's signature
> accordingly.
> 
> Remove the platform_profile_handler from all consumer drivers and
> replace them with a pointer to the class device, which is
> now returned from platform_profile_register().
> 
> Replace *pprof with a pointer to the class device in the rest of
> exported symbols.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/platform_profile.c               | 87 ++++++++++++-------
>   .../surface/surface_platform_profile.c        | 11 ++-
>   drivers/platform/x86/acer-wmi.c               | 18 ++--
>   drivers/platform/x86/amd/pmf/pmf.h            |  2 +-
>   drivers/platform/x86/amd/pmf/sps.c            | 17 ++--
>   drivers/platform/x86/asus-wmi.c               | 20 ++---
>   drivers/platform/x86/dell/alienware-wmi.c     |  9 +-
>   drivers/platform/x86/dell/dell-pc.c           | 22 ++---
>   drivers/platform/x86/hp/hp-wmi.c              | 19 ++--
>   drivers/platform/x86/ideapad-laptop.c         | 14 +--
>   .../platform/x86/inspur_platform_profile.c    |  9 +-
>   drivers/platform/x86/thinkpad_acpi.c          | 14 ++-
>   include/linux/platform_profile.h              | 12 ++-
>   13 files changed, 125 insertions(+), 129 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 34e22b006ccc..2fae5e2fc962 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -4,6 +4,7 @@
>   
>   #include <linux/acpi.h>
>   #include <linux/bits.h>
> +#include <linux/cleanup.h>
>   #include <linux/init.h>
>   #include <linux/kdev_t.h>
>   #include <linux/mutex.h>
> @@ -213,9 +214,17 @@ static struct attribute *profile_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(profile);
>   
> +static void pprof_device_release(struct device *dev)
> +{
> +	struct platform_profile_handler *pprof = to_pprof_handler(dev);
> +
> +	kfree(pprof);
> +}
> +
>   static const struct class platform_profile_class = {
>   	.name = "platform-profile",
>   	.dev_groups = profile_groups,
> +	.dev_release = pprof_device_release,
>   };
>   
>   /**
> @@ -409,10 +418,10 @@ static const struct attribute_group platform_profile_group = {
>   	.is_visible = profile_class_is_visible,
>   };
>   
> -void platform_profile_notify(struct platform_profile_handler *pprof)
> +void platform_profile_notify(struct device *dev)
>   {
>   	scoped_cond_guard(mutex_intr, return, &profile_lock) {
> -		_notify_class_profile(&pprof->class_dev, NULL);
> +		_notify_class_profile(dev, NULL);
>   	}
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   }
> @@ -461,40 +470,51 @@ int platform_profile_cycle(void)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>   
> -int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
> +struct device *platform_profile_register(struct device *dev, const char *name,
> +					 void *drvdata,
> +					 const struct platform_profile_ops *ops)
>   {
> +	int minor;
>   	int err;
>   
> -	/* Sanity check the profile handler */
> -	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
> -	    !pprof->ops->probe) {
> +	/* Sanity check */
> +	if (!dev || !name || !ops || !ops->profile_get ||
> +	    !ops->profile_set || !ops->probe) {
>   		pr_err("platform_profile: handler is invalid\n");
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   	}
>   
> -	err = pprof->ops->probe(drvdata, pprof->choices);
> +	struct platform_profile_handler *pprof __free(kfree) = kzalloc(
> +		sizeof(*pprof), GFP_KERNEL);
> +	if (!pprof)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = ops->probe(drvdata, pprof->choices);
>   	if (err < 0)
> -		return err;
> +		return ERR_PTR(err);
>   
>   	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
>   		pr_err("platform_profile: no available profiles\n");
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   	}
>   
>   	guard(mutex)(&profile_lock);
>   
>   	/* create class interface for individual handler */
> -	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> -	if (pprof->minor < 0)
> -		return pprof->minor;
> +	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> +	if (minor < 0)
> +		return ERR_PTR(minor);
>   
> +	pprof->name = name;
> +	pprof->ops = ops;
> +	pprof->minor = minor;
>   	pprof->class_dev.class = &platform_profile_class;
> -	pprof->class_dev.parent = pprof->dev;
> +	pprof->class_dev.parent = dev;
>   	dev_set_drvdata(&pprof->class_dev, drvdata);
>   	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
>   	err = device_register(&pprof->class_dev);
>   	if (err) {
> -		put_device(&pprof->class_dev);
> +		put_device(&no_free_ptr(pprof)->class_dev);
>   		goto cleanup_ida;
>   	}
>   
> @@ -504,20 +524,21 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
>   	if (err)
>   		goto cleanup_cur;
>   
> -	return 0;
> +	return &no_free_ptr(pprof)->class_dev;
>   
>   cleanup_cur:
> -	device_unregister(&pprof->class_dev);
> +	device_unregister(&no_free_ptr(pprof)->class_dev);
>   
>   cleanup_ida:
> -	ida_free(&platform_profile_ida, pprof->minor);
> +	ida_free(&platform_profile_ida, minor);
>   
> -	return err;
> +	return ERR_PTR(err);
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>   
> -int platform_profile_remove(struct platform_profile_handler *pprof)
> +int platform_profile_remove(struct device *dev)
>   {
> +	struct platform_profile_handler *pprof = to_pprof_handler(dev);
>   	int id;
>   	guard(mutex)(&profile_lock);
>   
> @@ -535,30 +556,32 @@ EXPORT_SYMBOL_GPL(platform_profile_remove);
>   
>   static void devm_platform_profile_release(struct device *dev, void *res)
>   {
> -	struct platform_profile_handler **pprof = res;
> +	struct device **ppdev = res;
>   
> -	platform_profile_remove(*pprof);
> +	platform_profile_remove(*ppdev);
>   }
>   
> -int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
> +struct device *devm_platform_profile_register(struct device *dev, const char *name,
> +					      void *drvdata,
> +					      const struct platform_profile_ops *ops)
>   {
> -	struct platform_profile_handler **dr;
> -	int ret;
> +	struct device *ppdev;
> +	struct device **dr;
>   
>   	dr = devres_alloc(devm_platform_profile_release, sizeof(*dr), GFP_KERNEL);
>   	if (!dr)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>   
> -	ret = platform_profile_register(pprof, drvdata);
> -	if (ret) {
> +	ppdev = platform_profile_register(dev, name, drvdata, ops);
> +	if (IS_ERR(dev)) {
>   		devres_free(dr);
> -		return ret;
> +		return ppdev;
>   	}
>   
> -	*dr = pprof;
> -	devres_add(pprof->dev, dr);
> +	*dr = ppdev;
> +	devres_add(dev, dr);
>   
> -	return 0;
> +	return ppdev;
>   }
>   EXPORT_SYMBOL_GPL(devm_platform_profile_register);
>   
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index bbdc873cb788..275269a6efc1 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -40,7 +40,7 @@ struct ssam_tmp_profile_info {
>   
>   struct ssam_platform_profile_device {
>   	struct ssam_device *sdev;
> -	struct platform_profile_handler handler;
> +	struct device *ppdev;
>   	bool has_fan;
>   };
>   
> @@ -228,13 +228,12 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   	tpd->sdev = sdev;
>   	ssam_device_set_drvdata(sdev, tpd);
>   
> -	tpd->handler.name = "Surface Platform Profile";
> -	tpd->handler.dev = &sdev->dev;
> -	tpd->handler.ops = &ssam_platform_profile_ops;
> -
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> -	return devm_platform_profile_register(&tpd->handler, tpd);
> +	tpd->ppdev =  devm_platform_profile_register(
> +		&sdev->dev, "Surface Platform Profile", tpd, &ssam_platform_profile_ops);
> +
> +	return PTR_ERR_OR_ZERO(tpd->ppdev);
>   }
>   
>   static const struct ssam_device_id ssam_platform_profile_match[] = {
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 39ec236b7cdb..3e39465b3783 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -758,7 +758,7 @@ static const struct dmi_system_id non_acer_quirks[] __initconst = {
>   	{}
>   };
>   
> -static struct platform_profile_handler platform_profile_handler;
> +static struct device *platform_profile_device;
>   static bool platform_profile_support;
>   
>   /*
> @@ -1937,16 +1937,10 @@ static const struct platform_profile_ops acer_predator_v4_platform_profile_ops =
>   static int acer_platform_profile_setup(struct platform_device *device)
>   {
>   	if (quirks->predator_v4) {
> -		int err;
> -
> -		platform_profile_handler.name = "acer-wmi";
> -		platform_profile_handler.dev = &device->dev;
> -		platform_profile_handler.ops =
> -			&acer_predator_v4_platform_profile_ops;
> -
> -		err = devm_platform_profile_register(&platform_profile_handler, NULL);
> -		if (err)
> -			return err;
> +		platform_profile_device = devm_platform_profile_register(
> +			&device->dev, "acer-wmi", NULL, &acer_predator_v4_platform_profile_ops);
> +		if (IS_ERR(platform_profile_device))
> +			return PTR_ERR(platform_profile_device);
>   
>   		platform_profile_support = true;
>   
> @@ -2033,7 +2027,7 @@ static int acer_thermal_profile_change(void)
>   		if (tp != ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO_WMI)
>   			last_non_turbo_profile = tp;
>   
> -		platform_profile_notify(&platform_profile_handler);
> +		platform_profile_notify(platform_profile_device);
>   	}
>   
>   	return 0;
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
> index d99b3556205b..41b2b91b8fdc 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -338,7 +338,7 @@ struct amd_pmf_dev {
>   	struct mutex lock; /* protects the PMF interface */
>   	u32 supported_func;
>   	enum platform_profile_option current_profile;
> -	struct platform_profile_handler pprof;
> +	struct device *ppdev; /* platform profile class device */
>   	struct dentry *dbgfs_dir;
>   	int hb_interval; /* SBIOS heartbeat interval */
>   	struct delayed_work heart_beat;
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 7c7ed2b9de01..a96fc6887cf0 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -404,8 +404,6 @@ static const struct platform_profile_ops amd_pmf_profile_ops = {
>   
>   int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   {
> -	int err;
> -
>   	dev->current_profile = PLATFORM_PROFILE_BALANCED;
>   
>   	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
> @@ -420,15 +418,12 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   		amd_pmf_set_sps_power_limits(dev);
>   	}
>   
> -	dev->pprof.name = "amd-pmf";
> -	dev->pprof.dev = dev->dev;
> -	dev->pprof.ops = &amd_pmf_profile_ops;
> -
>   	/* Create platform_profile structure and register */
> -	err = devm_platform_profile_register(&dev->pprof, dev);
> -	if (err)
> -		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
> -			err);
> +	dev->ppdev = devm_platform_profile_register(
> +		dev->dev, "amd-pmf", dev, &amd_pmf_profile_ops);
> +	if (IS_ERR(dev->ppdev))
> +		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %ld\n",
> +			PTR_ERR(dev->ppdev));
>   
> -	return err;
> +	return PTR_ERR_OR_ZERO(dev->ppdev);
>   }
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index f8437cff66df..4ad99cf9df1a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -313,7 +313,7 @@ struct asus_wmi {
>   	bool mid_fan_curve_available;
>   	struct fan_curve_data custom_fan_curves[3];
>   
> -	struct platform_profile_handler platform_profile_handler;
> +	struct device *platform_profile_device;
>   	bool platform_profile_support;
>   
>   	// The RSOC controls the maximum charging percentage.
> @@ -3789,7 +3789,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>   	 * Ensure that platform_profile updates userspace with the change to ensure
>   	 * that platform_profile and throttle_thermal_policy_mode are in sync.
>   	 */
> -	platform_profile_notify(&asus->platform_profile_handler);
> +	platform_profile_notify(asus->platform_profile_device);
>   
>   	return count;
>   }
> @@ -3891,17 +3891,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   
>   	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
>   
> -	asus->platform_profile_handler.name = "asus-wmi";
> -	asus->platform_profile_handler.dev = dev;
> -	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
> +	asus->platform_profile_device = devm_platform_profile_register(
> +		dev, "asus-wmi", asus, &asus_wmi_platform_profile_ops);
> +	if (IS_ERR(asus->platform_profile_device)) {
> +		pr_err("%s, failed at devm_platform_profile_register: %ld\n",
> +		       __func__, PTR_ERR(asus->platform_profile_device));
>   
> -	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
> -	if (err == -EEXIST) {
> -		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> -		return 0;
> -	} else if (err) {
> -		pr_err("%s, failed at devm_platform_profile_register: %d\n", __func__, err);
> -		return err;
> +		return PTR_ERR(asus->platform_profile_device);
>   	}
>   
>   	asus->platform_profile_support = true;
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 0146d2f93be6..99db93846a63 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1135,11 +1135,12 @@ static const struct platform_profile_ops awcc_platform_profile_ops = {
>   
>   static int create_thermal_profile(struct platform_device *platform_device)
>   {
> -	pp_handler.name = "alienware-wmi";
> -	pp_handler.dev = &platform_device->dev;
> -	pp_handler.ops = &awcc_platform_profile_ops;
> +	struct device *ppdev;
>   
> -	return devm_platform_profile_register(&pp_handler, NULL);
> +	ppdev = devm_platform_profile_register(
> +		&platform_device->dev, "alienware-wmi", NULL, &awcc_platform_profile_ops);
> +
> +	return PTR_ERR_OR_ZERO(ppdev);
>   }
>   
>   /*
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 2759bb608b1a..8d60e1b223de 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -109,8 +109,6 @@ MODULE_DEVICE_TABLE(dmi, dell_device_table);
>   #define DELL_ACC_SET_FIELD	GENMASK(11, 8)
>   #define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
>   
> -static struct platform_profile_handler *thermal_handler;
> -
>   enum thermal_mode_bits {
>   	DELL_BALANCED    = BIT(0),
>   	DELL_COOL_BOTTOM = BIT(1),
> @@ -254,6 +252,7 @@ static const struct platform_profile_ops dell_pc_platform_profile_ops = {
>   
>   static int thermal_init(void)
>   {
> +	struct device *ppdev;
>   	int ret;
>   
>   	/* If thermal commands are not supported, exit without error */
> @@ -271,26 +270,17 @@ static int thermal_init(void)
>   	if (IS_ERR(platform_device))
>   		return PTR_ERR(platform_device);
>   
> -	thermal_handler = devm_kzalloc(&platform_device->dev, sizeof(*thermal_handler), GFP_KERNEL);
> -	if (!thermal_handler) {
> -		ret = -ENOMEM;
> -		goto cleanup_platform_device;
> -	}
> -	thermal_handler->name = "dell-pc";
> -	thermal_handler->dev = &platform_device->dev;
> -	thermal_handler->ops = &dell_pc_platform_profile_ops;
> -
>   	/* Clean up if failed */
> -	ret = devm_platform_profile_register(thermal_handler, NULL);
> -	if (ret)
> +	ppdev = devm_platform_profile_register(
> +		&platform_device->dev, "dell-pc", NULL, &dell_pc_platform_profile_ops);
> +	if (IS_ERR(ppdev)) {
> +		ret = PTR_ERR(ppdev);
>   		goto cleanup_thermal_handler;
> +	}
>   
>   	return 0;
>   
>   cleanup_thermal_handler:
> -	thermal_handler = NULL;
> -
> -cleanup_platform_device:
>   	platform_device_unregister(platform_device);
>   
>   	return ret;
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 1304dfc65aab..d1f9bd287986 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -273,7 +273,7 @@ static DEFINE_MUTEX(active_platform_profile_lock);
>   static struct input_dev *hp_wmi_input_dev;
>   static struct input_dev *camera_shutter_input_dev;
>   static struct platform_device *hp_wmi_platform_dev;
> -static struct platform_profile_handler platform_profile_handler;
> +static struct device *platform_profile_device;
>   static struct notifier_block platform_power_source_nb;
>   static enum platform_profile_option active_platform_profile;
>   static bool platform_profile_support;
> @@ -1602,6 +1602,7 @@ static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
>   
>   static int thermal_profile_setup(struct platform_device *device)
>   {
> +	const struct platform_profile_ops *ops;
>   	int err, tp;
>   
>   	if (is_omen_thermal_profile()) {
> @@ -1617,7 +1618,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err < 0)
>   			return err;
>   
> -		platform_profile_handler.ops = &platform_profile_omen_ops;
> +		ops = &platform_profile_omen_ops;
>   	} else if (is_victus_thermal_profile()) {
>   		err = platform_profile_victus_get_ec(&active_platform_profile);
>   		if (err < 0)
> @@ -1631,7 +1632,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err < 0)
>   			return err;
>   
> -		platform_profile_handler.ops = &platform_profile_victus_ops;
> +		ops = &platform_profile_victus_ops;
>   	} else {
>   		tp = thermal_profile_get();
>   
> @@ -1646,15 +1647,13 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err)
>   			return err;
>   
> -		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
> +		ops = &hp_wmi_platform_profile_ops;
>   	}
>   
> -	platform_profile_handler.name = "hp-wmi";
> -	platform_profile_handler.dev = &device->dev;
> -
> -	err = devm_platform_profile_register(&platform_profile_handler, NULL);
> -	if (err)
> -		return err;
> +	platform_profile_device = devm_platform_profile_register(
> +		&device->dev, "hp-wmi", NULL, ops);
> +	if (IS_ERR(platform_profile_device))
> +		return PTR_ERR(platform_profile_device);
>   
>   	platform_profile_support = true;
>   
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 87c1e087770a..6065a7421a02 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -142,7 +142,7 @@ enum {
>   
>   struct ideapad_dytc_priv {
>   	enum platform_profile_option current_profile;
> -	struct platform_profile_handler pprof;
> +	struct device *ppdev; /* platform profile device */
>   	struct mutex mutex; /* protects the DYTC interface */
>   	struct ideapad_private *priv;
>   };
> @@ -1050,7 +1050,7 @@ static void dytc_profile_refresh(struct ideapad_private *priv)
>   
>   	if (profile != priv->dytc->current_profile) {
>   		priv->dytc->current_profile = profile;
> -		platform_profile_notify(&priv->dytc->pprof);
> +		platform_profile_notify(priv->dytc->ppdev);
>   	}
>   }
>   
> @@ -1117,15 +1117,15 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   
>   	mutex_init(&priv->dytc->mutex);
>   
> -	priv->dytc->pprof.name = "ideapad-laptop";
> -	priv->dytc->pprof.dev = &priv->platform_device->dev;
>   	priv->dytc->priv = priv;
> -	priv->dytc->pprof.ops = &dytc_profile_ops;
>   
>   	/* Create platform_profile structure and register */
> -	err = devm_platform_profile_register(&priv->dytc->pprof, &priv->dytc);
> -	if (err)
> +	priv->dytc->ppdev = devm_platform_profile_register(
> +		&priv->platform_device->dev, "ideapad-laptop", &priv->dytc, &dytc_profile_ops);
> +	if (IS_ERR(priv->dytc->ppdev)) {
> +		err = PTR_ERR(priv->dytc->ppdev);
>   		goto pp_reg_failed;
> +	}
>   
>   	/* Ensure initial values are correct */
>   	dytc_profile_refresh(priv);
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index e1631de6ad86..8b71c4242939 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -32,7 +32,7 @@ enum inspur_tmp_profile {
>   
>   struct inspur_wmi_priv {
>   	struct wmi_device *wdev;
> -	struct platform_profile_handler handler;
> +	struct device *ppdev;
>   };
>   
>   static int inspur_wmi_perform_query(struct wmi_device *wdev,
> @@ -190,11 +190,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	priv->wdev = wdev;
>   	dev_set_drvdata(&wdev->dev, priv);
>   
> -	priv->handler.name = "inspur-wmi";
> -	priv->handler.dev = &wdev->dev;
> -	priv->handler.ops = &inspur_platform_profile_ops;
> +	priv->ppdev = devm_platform_profile_register(
> +		&wdev->dev, "inspur-wmi", priv, &inspur_platform_profile_ops);
>   
> -	return devm_platform_profile_register(&priv->handler, priv);
> +	return PTR_ERR_OR_ZERO(priv->ppdev);
>   }
>   
>   static const struct wmi_device_id inspur_wmi_id_table[] = {
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 54ff3e6b8b1a..2a3dd0d149a1 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -962,6 +962,7 @@ static const struct proc_ops dispatch_proc_ops = {
>   static struct platform_device *tpacpi_pdev;
>   static struct platform_device *tpacpi_sensors_pdev;
>   static struct device *tpacpi_hwmon;
> +static struct device *tpacpi_pprof;
>   static struct input_dev *tpacpi_inputdev;
>   static struct mutex tpacpi_inputdev_send_mutex;
>   static LIST_HEAD(tpacpi_all_drivers);
> @@ -10553,11 +10554,6 @@ static const struct platform_profile_ops dytc_profile_ops = {
>   	.profile_set = dytc_profile_set,
>   };
>   
> -static struct platform_profile_handler dytc_profile = {
> -	.name = "thinkpad-acpi",
> -	.ops = &dytc_profile_ops,
> -};
> -
>   static void dytc_profile_refresh(void)
>   {
>   	enum platform_profile_option profile;
> @@ -10586,7 +10582,7 @@ static void dytc_profile_refresh(void)
>   	err = convert_dytc_to_profile(funcmode, perfmode, &profile);
>   	if (!err && profile != dytc_current_profile) {
>   		dytc_current_profile = profile;
> -		platform_profile_notify(&dytc_profile);
> +		platform_profile_notify(tpacpi_pprof);
>   	}
>   }
>   
> @@ -10647,14 +10643,14 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   	dbg_printk(TPACPI_DBG_INIT,
>   			"DYTC version %d: thermal mode available\n", dytc_version);
>   
> -	dytc_profile.dev = &tpacpi_pdev->dev;
>   	/* Create platform_profile structure and register */
> -	err = devm_platform_profile_register(&dytc_profile, NULL);
> +	tpacpi_pprof = devm_platform_profile_register(
> +		&tpacpi_pdev->dev, "thinkpad-acpi", NULL, &dytc_profile_ops);
>   	/*
>   	 * If for some reason platform_profiles aren't enabled
>   	 * don't quit terminally.
>   	 */
> -	if (err)
> +	if (IS_ERR(tpacpi_pprof))
>   		return -ENODEV;
>   
>   	/* Ensure initial values are correct */
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 5ad1ab7b75e4..778d4c661c3c 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -45,10 +45,14 @@ struct platform_profile_handler {
>   	const struct platform_profile_ops *ops;
>   };
>   
> -int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
> -int platform_profile_remove(struct platform_profile_handler *pprof);
> -int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
> +struct device *platform_profile_register(struct device *dev, const char *name,
> +					 void *drvdata,
> +					 const struct platform_profile_ops *ops);
> +int platform_profile_remove(struct device *dev);
> +struct device *devm_platform_profile_register(struct device *dev, const char *name,
> +					      void *drvdata,
> +					      const struct platform_profile_ops *ops);
>   int platform_profile_cycle(void);
> -void platform_profile_notify(struct platform_profile_handler *pprof);
> +void platform_profile_notify(struct device *dev);
>   
>   #endif  /*_PLATFORM_PROFILE_H_*/


