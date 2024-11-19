Return-Path: <linux-acpi+bounces-9664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD319D2A97
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24E31F2338B
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D12C1D042D;
	Tue, 19 Nov 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4CWy2nWA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB21CF7AE;
	Tue, 19 Nov 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032963; cv=fail; b=unjYl9y4lmaWcYktWSOaUQOxuD4OhUrsToy/KwpZ7EH0/myd98HlnjZc0CxACYo4syzf0/wUbpzhNzq6XXpOlVEjPpMMv7pYvAUtH2SdiibvUaIYwG93Ggmjp+HdvA3JaA5poAMI/UhNFMQFOOEwureW/w9ruAC9E5jx6wb9wD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032963; c=relaxed/simple;
	bh=NY72NvtnN+dscR9Scw4EA606HFv3Kzi0M3SdoYIf02A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qRC5Cn2DHX3Ex8rVKhLsQS4+md5TM8kcHBnM1NrIEaj65Uhx96uo/mZASWGfEvL5Q+XBacMSMRQEhBVKte++cWkGXnKfCMmabeAbdWGbruG4qUPOGd3vI3ry4Onh9r2HA+R9Pnyy/MgbMhQGs/WECXp6O940O+//CaKl9WQ1Usc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4CWy2nWA; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mylScRmupSJ//xI06T9tyOhzyLSUGgu0xLQqEU0+ptg5CkAafDj3nBa97jqfEi0AlCCQdtesskxsuSKqzyZ29egSDeaebO0hWjiAIufgABYDkcml+Vp5LeWRwiOZw/WXJkokZazOkpImOXL3aEgBmUwbXBiotclRwrQYL95a9DnH2rbivtQswbrEeKLmJHVI7NYx770N1Hefczt6+uEdhXC6bbBoDSMUS7pIdSzmMNuWZftqEYvNX4f/DVqzpTcjvCLt9UpLHKxryCC87oHCWgqpffbV4uV8/8kqD3S2sBkI8rXoD5g7zYaJE2YTdQ0kdKVWb45/0mIHoB8ENC97Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvTByK6Xg4vs5lxGq8c83IFxNQ+H2ccgBf3iYN1RmcU=;
 b=DXsTeaBeuQ8DIH/ZccQubajv0XfplAoaDjVqFloj65h1zInUgn/8VSRETmMEFjZWhILM84P8ads3zGR0bvMSX5IYmw3QfpHBspW8A3Ho6+3nRcnTw3ygPRV2wmkyt4VMtBZHOnBgVmR4O5Mm42mcu3kjWtEP/sVOxL6692yeLSDQIKd7cmplj+AYItC7O6fgnTxqgDe7OE0sjOXukNS6gIjZOrOpq5qKuWN0DWXA7g7b85odaK6226tMrD0O6PAQPDwUXpACvk8CTitvMLTLWrBrBUkPTl3x4MuSKChlDjUSxQHbF9CP/UjGz5+E3rVN8UOLkhGZMxsX9qI0sPomzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvTByK6Xg4vs5lxGq8c83IFxNQ+H2ccgBf3iYN1RmcU=;
 b=4CWy2nWATA+QMrby+zT0UMkiC+kySvptfuLOgMsgU385iDAXB/xU/7WwpsHkDZZBhALt87jXM7Sm/Xf6xLMGAXWTMwjy8zvWqAuhT8I2kVcstd+JcJThcsvF9M5hHkvslFt+DZS1mEEz473BQcucsPnigdJKo4V5JA0MlOkNa38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 16:15:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 16:15:54 +0000
Message-ID: <7423272c-9efb-403b-8473-b4a46ccf5ff0@amd.com>
Date: Tue, 19 Nov 2024 10:15:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/22] ACPI: platform_profile: Add name attribute to
 class interface
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-12-mario.limonciello@amd.com>
 <29899120-efec-4264-b6a8-0bca4fc1f332@gmx.de>
 <6b7d2f80-0dde-4f07-b889-fa2cb99f5c88@gmx.de>
 <0ba333c7-6e13-41b1-82ea-588da0161e5e@amd.com>
 <77c76379-672b-4367-8491-6ba9bbc1da1a@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <77c76379-672b-4367-8491-6ba9bbc1da1a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:806:20::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 9922233f-218b-49a6-5881-08dd08b571b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmc5aEFRWk83SVR1QkRjclVjRG41Yk96NkJWdUxUU0VYdzJxaWc3TmNGRkxE?=
 =?utf-8?B?RERwRVpUelBTL0hybU10aUg2MFFKSlZRbU9mN3JaZkw2NHNVa1k5M2dSckow?=
 =?utf-8?B?b2tONXM2UlVGUmZUY3RrcjZBOG5JaUNYSUpBc0tkSzhXTU9WcUl6OE5uWDFu?=
 =?utf-8?B?SFFtNUx4ejIreW5uckdVN1JiUEwwb0FwNFBlZ3UxS3V3S09mOFp6dDdkSjhT?=
 =?utf-8?B?cVpFTjVYYWRSNmNITTV3aXpPNUYxeW4vRHg0STM1R0pnMVRzQ0d2VFM1UU1a?=
 =?utf-8?B?bTZwRVBJaXJMUU9Jc1Z1Yi9oV2NmRXh4QlNzK0JrWEdyT0Y1dGJNakFJL3VG?=
 =?utf-8?B?d3pyd1NxcGdHY2tSTmt4cEVIY0NrNDRTbi80Q1VHTWNTZ2Q1VE01UFgzeDI0?=
 =?utf-8?B?TWpsSEJmOHpHdk9GRGxZQUVMMlBYanJJMGR6RGpDUGpINVVNRFh6U3MwdjJU?=
 =?utf-8?B?Tm1IUHQ3YWNMQkNPVUtsMTQ5Q3ZkT0ZlZEdRMVIxQlNzVnBHaTdGYlc0QVda?=
 =?utf-8?B?OGdqRW42bUE1VU1NMWgvM2NoVXB5VnZURjgzcmh0cU9nMklPZDFFdjVRQk9Z?=
 =?utf-8?B?YnBuOEhXcktOVlFCU09TNUlLU3ZieXc1U1ppSWJxZnlKNnNGL1BBQ3pGcnJW?=
 =?utf-8?B?aCsxMm04NUV3dk5SbmI4ZUlTV1VuSjVYL0J1Uk8wMnY5MmNuM0pWcFpZU2Ix?=
 =?utf-8?B?OWs5d0s3NndzaW11QzZFYWZKMGcxN2dqTjl2c3FoOUNlVldtNGFBdXpib093?=
 =?utf-8?B?UUcrVGxYcDA4RTZNTWpPVW5zdmg2b2R3TkRqQ2ppVlpKRFl5T0pBd1orWHVv?=
 =?utf-8?B?TFNieGFqYVhSVnZZcm9oZ21jMTIvVG5ObWZYV0pyaVdsRThvZzBkZUd2eEhF?=
 =?utf-8?B?dXNjYm1JaW5VSTZ6RHJOaVpuZFl5MkowbVdyRG9ydzZVK2NFbmZrMG9HeVR3?=
 =?utf-8?B?c01aT21JMytidWlaUXBHVDB0Zys2Q0ZmYjVnbC85a1FLRGRNdkNISlR5Rkpq?=
 =?utf-8?B?TWpRMkM3Ym1ITC9sNU50SE9NMFhUTkcyUFEvS2RUWHdIR0Rkai9IZ3l2N2F3?=
 =?utf-8?B?cnEwVGduWk95VWxVQkhyMGNpSnMyS05kUW0rYXByb1lsWFBxODVsL3hwNlRG?=
 =?utf-8?B?a0h1VVg4ck9LL0N6ZkROM3ZITFBHbFF4YVVLVjB3QkZBeG44RFIxZTIzbTNQ?=
 =?utf-8?B?ZU9adWxaSk1qanRWNlF0WmRsclFuNVltaVRFR2NTTWgzT20xaTBDTjlDcGVY?=
 =?utf-8?B?SE5hWEtOY1o0aTcxd1VZU0FOMEQ3SWxKYXNSRlgyYVE0ck5leGVlSWdIdHNX?=
 =?utf-8?B?Q010N04xZDF3dkRBZHZORE5mNHhnM1B0V05ETXEyVG5qUW5XMnZOb0ZVMnlO?=
 =?utf-8?B?NVBCN2pwMThXSTg3Q1B4b2FuTmxwQmkrMys1QWtTeVBjc2Rnb2s2enhUa2VT?=
 =?utf-8?B?M0JmODc5WG1zMmdTWHlmaUJiM0FMTmZ0czVValgrZm1hS3F4MDlSMmRSTlNF?=
 =?utf-8?B?Slg5Rlk1eHFac0NSc3pscGUyRUhseFgxNHdzZ2pWRlpJQ3lTRjc2MkV4OW5Q?=
 =?utf-8?B?WWFWd3lIV1doanErOWlMbisvVkJsbllOeXpEbUJrRzZCL1BsQ1RSd1VndmtM?=
 =?utf-8?B?LzRnRkFSbzl0a0E5TC9RSXBsSm9Eekp5aExXRUh1Z2VZY2ozdGIvVW41aFFO?=
 =?utf-8?B?WVY2SENhbzJnSnMzMHhLTDZjOFlGZjFoL3g2cFB0QVVMVUljQnRySllBb1p3?=
 =?utf-8?Q?o7mUs6t+uOhQBZXspQNvPUfBnnSPI/UhVYHLK6p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVVNeVlnQXplejNMYjAzSUt5Wjhlb1M5ci9zVWxieVlFRlR5UzZhbFhLTkcy?=
 =?utf-8?B?VXJhWis1c1dndnNkUWxGOGpkcVJRcE9ucnVPakxQTFdkSXdFREViSUJ3Tk85?=
 =?utf-8?B?NE04alJmUW9RQkhEbEplcUxUNmtsNm9neXh0N0dBYW9TTnVCNDhjMjdoYlBG?=
 =?utf-8?B?Tk44SFBtNDAwTkhuM1llcUNiUGNFSy8rK2IxMWVrUVBMb2dNdEVrQU5GUW91?=
 =?utf-8?B?N3premJTdW1HRzNCYjdGMW1adnNOaU45Zjl6MGVtbG52WVBOaytJRjZPNHk2?=
 =?utf-8?B?ZG5Ea0ZDb1hwRUlYMUV5R0tvRjQvbUF4amFVM216czdpMVpXbTY4a3NpMFhx?=
 =?utf-8?B?aGhXTFVwS1hlZUZweURQOVNFaCtTVTNja0lIRU5WZDF1RjNWRmQyZ0gzYStD?=
 =?utf-8?B?NmpuUTJKdGlGRHUzTkpsUDl1SzdTejIrdTUrRXFtRmdwM1NQUGJ0OThvQWs5?=
 =?utf-8?B?OUtzcVJWK2d1NXlRUW15OXV2ZFZ4dEJBenhPZkxMcHBXTzYxZDE1SXFpaktS?=
 =?utf-8?B?M1V0ZGUvblZVNXNzS080Z2NaRnFGaVBqbGpXN1JzYlVqb21VZG12MkJNaW9h?=
 =?utf-8?B?MC9sbVE4SHh1cHhlL24yeEZQU0FCWHJXK0ZTSDl2UHlDRTE5UkV3YWd0b0Yx?=
 =?utf-8?B?d21mMUtVMjJtQVVodjBaNEpNV3Azeis3VTN4WkVUUHlKdXJjMHNMU3FVMG5Q?=
 =?utf-8?B?YVhVUWU4ZnNjUFZ2MVZEaHVnVmJEbUFOTVZQK0pQMytNV0hHK3hENmZOVlRY?=
 =?utf-8?B?ZGJlN24yK2hoOGJHcmpqNjkxWnFjSVVtU082Z2l4S2dUMUlyZDFpWjRESzBK?=
 =?utf-8?B?OE1BZmJNdFZXcEMxbGc2R0hmQUh6Kys1ZEJBajJuVDgwU3lkMTRpNTRycTUx?=
 =?utf-8?B?bHNoR0pNU2UxUDNibU5QZmo3cHBlR3hBdGdyZ3JpRTNhcUJNZ0FPUHhsOW9M?=
 =?utf-8?B?ZlUraEErWVJ0QWs5ai8xeXp2YWdDeTVhbFdhdWlhR2ZZMHRTZnNzUWFoRTBs?=
 =?utf-8?B?bG9KS2NxajRpZGs1dmNwTEQ0L21DbzNrVGlLcndRLytxM0hvZThtRXZRdzdq?=
 =?utf-8?B?S0o3WW5HVmQzSnM2bGJMaU94Q1R5SDQwSlUvM0s4RXBBRERBc3FQK1Z5M0p0?=
 =?utf-8?B?M2ZQNkd3cUc5WmYvWnQ5enZuUUtwUS8rVnRneVV2dHRuaGY3N0hhTGNUbVRO?=
 =?utf-8?B?Yk5GMndiNDUxcFkxRXFhSmlsOEJnTXl1bTN3Ykd3WWFTdFlXdEZqZXFxb21C?=
 =?utf-8?B?eXcxV3c3czhVM0pHam1pZmk1WmhRUWVRWGs5b1RibzY1VE1sRENIUFBFVzVJ?=
 =?utf-8?B?VllnQ0prS0ViRkduZWE1TFJEa1VqM1VxelZLLzRjVmpmcFg5aUtneXVycDYw?=
 =?utf-8?B?VzdsNFpBeWF1am55TWhqV1gxVW5oVGRuZHJzdkdvV0RZcGhBQlpIbGJtcUh4?=
 =?utf-8?B?TE9qMjgzejlSUmVwSDA0UmtYSXFCMlNDUWpDNEtDR1FYY1pyMG1BaVR1ZkF1?=
 =?utf-8?B?VDBmVHBhWnpYNFdPUFVTRzg3NTJmSmJlMjBkUVVIc3d2ay9iVSs3ZlpZcXow?=
 =?utf-8?B?WUhzeEY3QStuMUY1Snh4aFNPSzlwandrcWxqVzVmcWlUaUtvQ0w2NVl0R25Y?=
 =?utf-8?B?MnZ2aDdnMmJYM2JyRlRLZ1ZMZ2hDNDVjc0NtQjU1bWhpQjNVWHJhMFBrNGJU?=
 =?utf-8?B?WlJjZXFzY3pQSmRPd2piL2krUFlPcG9FbzlVZUsyMjdBSXpQbEhDaU5RVWpx?=
 =?utf-8?B?dWVVZ1NHRVd2RXNSTlp0V1I1SW45OFZwU0Z3VUxsVmZSenQyWXZFWjExR1Vm?=
 =?utf-8?B?YlZ5WmFlZ3IwOFlMVXpndFZnMkNXeFlEVmFkbVJGSm5MNlk2MUtGZFVXREhj?=
 =?utf-8?B?QTBXN3UyZFZaVmFiQmtTa0g3NDc5OCt1bVl0RVh3MlVROFpWK2ZVQXpVVU9Y?=
 =?utf-8?B?U3BZeHVVM2V3TjhKSzJndkMzVVNodStyR3RpSnROYjZjV1FTT3RkTWZBTzBk?=
 =?utf-8?B?Z2NVZ3hVaWkxb3RaaGdxRFdXbC9pT3p0YmZuL3NaTWdqcE5yYVZFMmkzelB6?=
 =?utf-8?B?d3owT2lZOXZWNmRXNXpzQlliYzJKVFpaUlpnUVYrdWsxQTk3YnYyWVEvemF5?=
 =?utf-8?Q?kbOEWYL8HA2eBDr28d/XT4YM1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9922233f-218b-49a6-5881-08dd08b571b4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:15:54.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /85TX34RL34pvAid5cIXvFaxotesTSSRSlcY0ArB3N1XbS402A5QA5iyMYip1vGewanZC5b72R7+awhgYA6fzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398

On 11/19/2024 06:26, Armin Wolf wrote:
> Am 19.11.24 um 05:09 schrieb Mario Limonciello:
> 
>> On 11/18/2024 18:28, Armin Wolf wrote:
>>> Am 18.11.24 um 20:43 schrieb Armin Wolf:
>>>
>>>> Am 09.11.24 um 05:41 schrieb Mario Limonciello:
>>>>
>>>>> The name attribute shows the name of the associated platform profile
>>>>> handler.
>>>>>
>>>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>   drivers/acpi/platform_profile.c | 27 +++++++++++++++++++++++++++
>>>>>   1 file changed, 27 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/platform_profile.c
>>>>> b/drivers/acpi/platform_profile.c
>>>>> index ef6af2c655524..4e2eda18f7f5f 100644
>>>>> --- a/drivers/acpi/platform_profile.c
>>>>> +++ b/drivers/acpi/platform_profile.c
>>>>> @@ -25,8 +25,35 @@ static_assert(ARRAY_SIZE(profile_names) ==
>>>>> PLATFORM_PROFILE_LAST);
>>>>>
>>>>>   static DEFINE_IDA(platform_profile_ida);
>>>>>
>>>>> +/**
>>>>> + * name_show - Show the name of the profile handler
>>>>> + * @dev: The device
>>>>> + * @attr: The attribute
>>>>> + * @buf: The buffer to write to
>>>>> + * Return: The number of bytes written
>>>>> + */
>>>>> +static ssize_t name_show(struct device *dev,
>>>>> +             struct device_attribute *attr,
>>>>> +             char *buf)
>>>>> +{
>>>>> +    struct platform_profile_handler *handler = dev_get_drvdata(dev);
>>>>> +
>>>>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
>>>>> &profile_lock) {
>>>>> +        return sysfs_emit(buf, "%s\n", handler->name);
>>>>> +    }
>>>>> +    return -ERESTARTSYS;
>>>>
>>>> I still have a bad feeling about the locking inside the class
>>>> attributes...
>>>>
>>>> Can we assume that no sysfs accesses occur after unregistering the
>>>> class device?
>>>>
>>>> Even if this is not the case then the locking fails to protect the
>>>> platform_profile_handler here.
>>>> If the device is unregistered right after dev_get_drvdata() was
>>>> called, then we would sill operate
>>>> on possibly stale data once we take the profile_lock.
>>>>
>>>> Does someone have any clue how sysfs attributes act during removal?
>>>>
>>> I think i found the answer to my questions inside this patch series:
>>> https://lore.kernel.org/linux-kernel/1390951311-15325-1-git-send-email-
>>> tj@kernel.org
>>>
>>> It says that:
>>>
>>>      kernfs / sysfs implement the "sever" semantic for userland
>>> accesses.
>>>      When a node is removed, no further userland operations are
>>> allowed and
>>>      the in-flight ones are drained before removal is finished. This
>>> makes
>>>      policing post-mortem userland accesses trivial for its users.
>>>
>>> In this case taking the profile_lock when reading/writing class
>>> attributes seems to be unnecessary.
>>> Please remove the unnecessary locking inside the class attributes.
>>>
>>
>> Before I respin a v7, let's make sure we're agreed on which things
>> need locking and which don't.
>>
>> Functions that check if a lock is held:
>> _store_class_profile()
>> _notify_class_profile()
>> get_class_profile()
>> _aggregate_choices()
>>
>> Functions that take a lock:
>> name_show()
>> choices_show()
>> profile_show()
>> profile_store()
>> platform_profile_choices_show()
>> platform_profile_show()
>> platform_profile_store()
>> platform_profile_cycle()
>> platform_profile_register()
>> platform_profile_remove()
>>
>> Functions that don't take or check for a lock (these are intermediary
>> and things they call check for one):
>> _aggregate_profiles()
>> _store_and_notify()
>>
>> Are you suggesting that basically these 4 can drop taking the lock?
>> name_show()
>> choices_show()
>> profile_show()
>> profile_store()
>>
>> I think the show() ones I can get behind, but I'm worried about
>> profile_store(), particularly as it pertains to the other callers of
>> _store_class_profile() because it's incongruent how the other callers
>> would use it then.
>>
>> Can we perhaps just drop it for the 3 class attribute show() ones?
> 
> I think so, i also remembered that profile_store() needs to keep taking 
> the lock in case platform_profile_cycle() is currently
> running.

Actually considering this, we need to keep it on profile_show() too then 
for the exact same reason.

I will drop it for choices and name though.

> 
> Can you also remove the second call to dev_get_drvdata() in 
> _store_class_profile()?
> 

Sure.

> Thanks,
> Armin Wolf
> 
>>
>> LMK.
>>
>>
>>


