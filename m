Return-Path: <linux-acpi+bounces-10488-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1884A07DFE
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCC53A96FC
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F0713D24D;
	Thu,  9 Jan 2025 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kDFlvsQ9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5154C7D;
	Thu,  9 Jan 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441182; cv=fail; b=EmEI0/FMG+3xu74axCmPY85DZRUqbs+VtcnKP3EI80UjgDAnP9BYdt9CpDHtcMD2ZrWVEV6iXEthL4sKWvlpaepnpr3ys++S6FTiV0KLQaVSr5hphxYUFbX3JTjOeOteVOp0QmZPP5wGzV8+DMCtrh8MVER9omua/8O1xfwOzds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441182; c=relaxed/simple;
	bh=suS6vkGaWoP4OrQeGQE82XG5H5AqNcxF+db+XuRQlxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=maO5AGTLqHs/fSNKmI6AiKyhI+AOhjd6PsbItM9XKMUS+HLYmlhSZBf4ll/QnHaHESVcg7CkjlrfdnTUkdKGAbt4ocTwklNiRG30NbGIRkLZBjRlCEiiVyQt2x6eTOLz4/0kOim7XpOTCHLZmdA5ZYLlLuvfvByQWlj1/wBFSS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kDFlvsQ9; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gByuWVp7/2T21KT3sputTNOJhLb8bHOTqPCu1ry/SxbuvRbxK7txrVvRrQ90NH87R/X8FE6iyIBI+KeU7vdrI/Ise21DFbzgbFThxBLHY96dAiCxUfMXnyMbF3fjLf0sP6VR+ut8rT/swlQ45+SI4Ip8cyVrLnp15ZPAQGo0Br50QyqElxKUY+eg1SiC+FMbSUyzUaz7YbAE/N2JuQQivPSptZjk+FrQiz/LIlZ/gcVwxMAvhSNw1E4nwyYH1FmJv0YSqK5bLMZr3XK+oCoJ+9i9pXjxTPsMxRSJVfZ4w8vOknoS3cpEnF3WXMbW+MxvEBdRk93HPNn9cO2GVHg92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqbhngI7xwrrHavoiXkv+vaJ2A2LEMK30vxqpNJi488=;
 b=fp0388Dtw1uvyV6HEJuzsrOeBILsLbJD7M1fWn2Zf9Dgzs5D35KCvHqmuuW5Seolf1x/UZPADx+n/Za2f4+sHCyFaZ/kfgNhcd5gyIXBAmC2QFt1xb0JUXwZvTv8/LjrUImhDAH+OJicPJfcuPyPtwG2sSivr4XKPuPQK2xxpz4pn5GkRMHjbtrHrFxHLYKOSfTsr7ODCTowM1XmWEPxh4gwGR5qYlhlN5dwGrDQhTTCeFvgxiXsdSuXibhpDBZ8XxZpzvJD27Dz4I2N/ov3fEjJdjkq0k2Ww7gX6IHSII3D7ID+F+XAdrPAgLSFpJvKDpeqDJ/tHq3eFjNxBBtnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqbhngI7xwrrHavoiXkv+vaJ2A2LEMK30vxqpNJi488=;
 b=kDFlvsQ9zrxY5ijQ5oFAz3jWH1VwDLGKNj12kMngs1F4AUxpLSs1m1Zh+bUiYfoiij1l+l9nbsLl5dVda1q1f4DBQxMOnqZV/yfoelSOn2tssie/KAduCZG8n9HQQ8v9xAJrqhvnyKMmUBNUzibfcsHw3/xAOJ1R8Xqc4vkiGqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 9 Jan
 2025 16:46:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:46:15 +0000
Message-ID: <7312b426-666e-4edb-86d7-7df4ab1f3001@amd.com>
Date: Thu, 9 Jan 2025 10:46:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] platform/x86: inspur_platform_profile: Use
 devm_platform_profile_register()
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
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-13-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-13-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:806:d1::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 60eec818-0c19-43db-6906-08dd30cd21f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dE81Q2phMTJweDlZN1NmamdNVmJoeVVybmtZdnUrZHU2elFqdHJUdlhneGpS?=
 =?utf-8?B?ZXhXdzlKcjh0OVdmZ3BkdUM2R09aS1AwVjZ5SWcxRnJxZmhVclRLcXFMTXU0?=
 =?utf-8?B?NlN4SHh2MXk3Y09BWkl1MTBxekMxT3BmTUtZN1hMQkJUVDdIdTJYRTV6WnhI?=
 =?utf-8?B?NWtBdWxtVExCU1FqeXJkY09SUFVoOWVXOTcwdDVXV004ZDg4M0x4Sk1jNlFa?=
 =?utf-8?B?dTV3QWxuUHlrbU8rektZc0FWaVl2OEZNYWF0d1B3UWVaL0NXR2JMVTNnRkQ0?=
 =?utf-8?B?UXZqWHdQMG9hSFRYZ0VHNmNYbzlXemZ4bzBqVFUyU2UzYjAxcU5pSVducHFX?=
 =?utf-8?B?Z2JRUVhPRVBPd1lyRUJQcWFwRzd4ZHBkOUpNZGtGdXg2NXk2RWdtQmtzVFQ1?=
 =?utf-8?B?Wkxmck9TeVo3MjFNNC9yRVhyYTBEUkhEcTlXQnpWNUlJYzloZnNBdWxmcjNm?=
 =?utf-8?B?dzRQU1dXajd4RnlEWDFzemtCOWg0OWZacjltMU4yN1k1dUE0OTNhemdPRVk2?=
 =?utf-8?B?d2F1YXpoOHVGS0RldkF0NEE5bTFSbVR6bmdoODIrVFhJV0RQZlZxZlJhY2Nk?=
 =?utf-8?B?RHNLNGVhcTByZGovUjltbHg4ZmUrc0YzbDBVV0RZb0VtOTQzakZ6UjhSZzN3?=
 =?utf-8?B?RzEwRVZreWhxdEdsT0VTZUlSQnU0K2IrNm1tOFh6OFRtZTFkUHFZbkEvampm?=
 =?utf-8?B?UlhqT0J4cDIzeVlkNzh5RHYzN3hXQmR2NlFjUXUzWVlZTkdVZnhrZS9yRFhx?=
 =?utf-8?B?UWg3dExOa2ZGekdPZFdabzhwcXU2eW8yRE9QUXF2UW9Wc2Ivc2xPWFowREpK?=
 =?utf-8?B?MEkzK0JhQk5NZksrbWhwUStmLzhZNmFXZ0J6cXIzeS9iV0QyRlg5SnU1S2Nz?=
 =?utf-8?B?SVBpZFVxZGJ6QlJEK3o0NUJ5MVh1YXh0aFU1VkRzNll3VHFhSXl4eE14TjhC?=
 =?utf-8?B?djYvcis5Szl2SW9lRXlCTmVsUUlnN0RYZk8xMEtPbjBickp1VUlyVTFUVC8z?=
 =?utf-8?B?bmdoYS9YVWVPdGRhVGdMSXpKS0EzaG5RUDlTdWtOaGhhR1ZEQTUvT0hxTzBr?=
 =?utf-8?B?dm80OXUvcUhTY3pOMXpHVWJub0J1SU1OSEFydVoxQXA3dW1kMUVucW1oenYz?=
 =?utf-8?B?UXRyOWxvSlB6eXhHTVF5dVV2U2RFOGJ1RFFPQis3Mk1KM2c2eXlJOXNnK0pq?=
 =?utf-8?B?djFTVFpjblIxQUFMUDZFcTAzNFNjQ3VpbUVob1BmZTBJUjJnTXRKOGY1enoz?=
 =?utf-8?B?MVJaMHU3Nm5remVRNW9HeS9kTU04dWg5Q21kbTNPS1pGRTFXUVhBYVRFbEt1?=
 =?utf-8?B?UHhnQ1gwc1VxMGN6MUhCaVlUNmhrd0s2TkVidDVkNWF0T1VlUXRWQ1QvM0hq?=
 =?utf-8?B?MjFKWUhJZjZXTDNIdzFDWjdUenJneWNnZUo5blA1NFMvWEVYS0F6QmFHbDU0?=
 =?utf-8?B?OWs5N0dUQ1g3cmxmNXZCWlgrMVV1cTBRdnVoTDhLcWptQnpXc0ZFYU5meDJK?=
 =?utf-8?B?aDNyaHJ5SUVXNE9NMVM0dC9sTkxGR2t0UW85K3lGdTFibmZjSmlFM0hWNzl5?=
 =?utf-8?B?SGRIK2VoYlFhV05PblpvNmcvZEJGREE4YlJRU05ud3N0RmRTbVNNVmxnUGFv?=
 =?utf-8?B?ZTJPcGtYcFNCdXhGbnM2eUpRNEtZaDk1OTNFZDI4SkZRTVI2SnpaNS95U1lp?=
 =?utf-8?B?V3BOa2xXcUlDVEFNZWVoelBPMEREVGVqYUZ5aTFtNkhMQ2RYeGNPWjR2U1k1?=
 =?utf-8?B?a2tHYklyTzdaL2EyNlQ2TUE3ZjBLZVF6NmdodXpTNDNFaC9LaDFvL1loY2d4?=
 =?utf-8?B?N3RBMmZPQWlVZDh6cTZ6bGp4UEp3SnV1WHZLYTNvUTFLYVAwYTFydG9CalNt?=
 =?utf-8?Q?K0ws3xYW1E0Yk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXB3MmpEY2NGOURKOTdraVdTK3RZa3RyVEZ3QklnWU16Y1U2ZXlLVjZVcjFL?=
 =?utf-8?B?UlVJaEQ2SWVVdEhtdEcvd2R6aCtheWJYblVvOFJPNWpHZW5zZ2FpNEJoUEN4?=
 =?utf-8?B?aE9Deis2NXVvNkFkVWxoS0I4S01yMzFSUDMzUHVUSXNzenh5c0ZJOGxFS1o1?=
 =?utf-8?B?SFEyYVhXd3pmTFF4STMvYVh3NGtvOWF1SzlYdEg2cWNIMWVwK0xIVStuN3Jk?=
 =?utf-8?B?MzdUSXV6ZWR1ajFrOS8zSDNMYktGSHFzOThPU3A2azBrZTJLbHBWQVYzSkZa?=
 =?utf-8?B?YTVFVzlhNkhINFRWN0Y2SFBNY0dJYXRiMjFacmFLSlNDRDFvSUhpU0Z1c0F3?=
 =?utf-8?B?S2pmaXFvNFFJajY2YWQ3N0t4Q3QvdGRPYjNtUUFLblFuaGhMM0FjNnZYM0c5?=
 =?utf-8?B?L29YWnZSSmhBc1gzMXN4QjVoQ1VIeUdobXBzZ1BkQUZaMzlGSHhpcVRkK2NY?=
 =?utf-8?B?SkhrQWFTYWtpdFVxck5wS3dCZHhlQkgvaVlOYUxvR2Nhek1LZUduZ3ZqdUhw?=
 =?utf-8?B?SWVXWFhjcTRQMTA2TWIwWEdZL0Q5SmVnV3VMNnprZUhxY1RqZmdJVXJmbDY0?=
 =?utf-8?B?TUZXQXUxTk9aaUVvV1crYzRlMEFLeUo1YnBDTFdXR3lZWkV4MDd3dTlqMkRv?=
 =?utf-8?B?SktnK2ZqN3dDaTFENlpUSnU1ZGgwcUY1NTZ4Y0JBVm1vdVdXVlZqVjhKT2t6?=
 =?utf-8?B?cEY4S0RIdjJHcGc0M1pUVHdmSW1tclJOQnRFQTBTdXd1Vm0xRmtyaHZNbWZz?=
 =?utf-8?B?ZXhIUkpFNkFWWXljZmlVajBxbzViQkJwQm1UcUFUaW4vbW1uZy9iOTQ4YTJx?=
 =?utf-8?B?bFgraDRYZFFEY1NmeGdFYUVWaGhTVGlOcTZycjNrcW9XSTJZQ0hDWlFIZ1Jr?=
 =?utf-8?B?QmpqYmZOMjhCNDM4SWRONzNjTzJlZCtYTTFHNzZobEtlUE8rWXZ6RHVlNVhL?=
 =?utf-8?B?SzBCTUZ2QmV4OHdpOHVSUXF3RytnMFNmSG9taU1qRExpMDI0RkEwL3FDaHRa?=
 =?utf-8?B?NW42WWN0U050a2tsSUx3K0Y5WlZrKytTK0Zvd1l5czFueVE4VWtWTTh3a0JK?=
 =?utf-8?B?QndnVGQyU0NuSmpmckxqYVJPUllZbVVxNnN6ejNYTlJJTTA4YkZGK1J5S1dS?=
 =?utf-8?B?MldMUHA0SlVQcUszM1RtR1huYmh6cHFiUm42Zk1iTGgvcHpiKy9PaHRlNmhP?=
 =?utf-8?B?VEZrL2RPQVhvRWQ3Q3BZb1VsRXZDa3FzUFZDYldLWTM3VU1BMm84RkZrSHRT?=
 =?utf-8?B?L0VrajBUMzFLcHpTQ1A1SzdJdDBHemc2UUxhckl6UmlRamFWQlVEWTBOR0Ey?=
 =?utf-8?B?Nmk1UzlJMllsbTZuamRFMVFPaXZnTHIrVGhBKzRPUHkxNzZYT0FXNjhRQVkx?=
 =?utf-8?B?VzJSSzMrT3hZanJabmpaMGIwMDNoM1NyZ25GNXM3UUs4Znd3MlZ0Nmo4VVdC?=
 =?utf-8?B?VEZPQzZsVEw4NFpYOEdtSG8xRkpEZS9TOWtaNFljV2xkMGlHY2ttL1ZqbDdB?=
 =?utf-8?B?SVMzMmZHeHZxMzE4K0hodW80MFRQWXRQUXZDYmFOV05NODViZUdvRnhUd3VS?=
 =?utf-8?B?QnRDYms0bUd1Y1FRcjc2bmVPZmVFLzJxRHRGNDFPcU53eWxLVFNsbXFwVkk1?=
 =?utf-8?B?V1FKbnp5S1pnSlZKTlIzd0trSWNaREszemlxVVNOT042Y0NZRTJzMWN3RWRR?=
 =?utf-8?B?b1hmWDlhVndjMUQ2VjJidXVWRGlGK0lsSCtkSGl3UDBxcWZzak5vVE9zL0hV?=
 =?utf-8?B?bllwNWNVUFVyRW0wQVNlZ1VUYWxPS2ZmNWMralVNN1RWMDZzQUx5RTYzQjR6?=
 =?utf-8?B?cUxIdXJLMW9QRjBGb0tjRTlyeXhkcWUvMDhYQjlBS1JBV0NBbkRaWDJXMVBw?=
 =?utf-8?B?b0RZajQ0djlJNlI3RlZOSWF5bTV6MHFHSTdFWmlML2cwdUszeHZzeithK1RO?=
 =?utf-8?B?TXJ6MDkvSjNTN1B0alFMZWpRdWtvTWpiL2MzZEw3NSsvZEw5WksrYjRMZU12?=
 =?utf-8?B?YjlnWktCS3BaZXNoK3RUbVJFcU1PaGx4dTBRdEphVmp2RXJ2MUFoaEVXNWxV?=
 =?utf-8?B?RWVkcXZqOURYcEV5bVlsTEpuWVo3SG5EVy9oL21CV1JkcmtpaFcvaDQ4MFVB?=
 =?utf-8?Q?CHBi20bj48sZiOflD4euZHoNZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eec818-0c19-43db-6906-08dd30cd21f0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:46:15.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOYrTKMkP249eYWTfcftl1KEjYOQqZhqq7YQnXtRnNuL+4lkTGx7oRlsoJlQZc0uQINQIgMvdbc3mNmu/9PigA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> While at it, pass inspur_wmi_priv to the class device as drvdata and
> replace uses of container_of() with dev_get_drvdata().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/inspur_platform_profile.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 43cb2a927fdf..543e4bce1a57 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -87,8 +87,7 @@ static int inspur_wmi_perform_query(struct wmi_device *wdev,
>   static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
>   				       enum platform_profile_option profile)
>   {
> -	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
> -						    handler);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> @@ -135,8 +134,7 @@ static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
>   static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
>   				       enum platform_profile_option *profile)
>   {
> -	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
> -						    handler);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> @@ -196,15 +194,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	priv->handler.dev = &wdev->dev;
>   	priv->handler.ops = &inspur_platform_profile_ops;
>   
> -	return platform_profile_register(&priv->handler, NULL);
> -}
> -
> -static void inspur_wmi_remove(struct wmi_device *wdev)
> -{
> -	struct inspur_wmi_priv *priv;
> -
> -	priv = dev_get_drvdata(&wdev->dev);
> -	platform_profile_remove(&priv->handler);
> +	return devm_platform_profile_register(&priv->handler, priv);
>   }
>   
>   static const struct wmi_device_id inspur_wmi_id_table[] = {
> @@ -221,7 +211,6 @@ static struct wmi_driver inspur_wmi_driver = {
>   	},
>   	.id_table = inspur_wmi_id_table,
>   	.probe = inspur_wmi_probe,
> -	.remove = inspur_wmi_remove,
>   	.no_singleton = true,
>   };
>   


