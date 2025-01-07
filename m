Return-Path: <linux-acpi+bounces-10409-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8292A046FF
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149663A032D
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F757081A;
	Tue,  7 Jan 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KiK5n1hf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A648BEE;
	Tue,  7 Jan 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268472; cv=fail; b=uSTBssPZWSnoUN86Bte5V1k1rxOTKzzDG6A8O2IkOuPcR8KI1M+10+szrAsrO3Da04Re9o8GBwpFtBFGJ2DT4ru8FHF7MxQxJJAKd0CJDxagHv//zKp876qylgeobmgq618KIHkJ97y8cE8Q8XnqqTWmC+WkJQLiEnmVZaREhQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268472; c=relaxed/simple;
	bh=CTuc7d3OoUQgufh4gGbuwPSKvQjREk8RMZ9HUjeaAJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sIpSnK9QyVFngykyb+LupugKbVZsScaD0kSppJcR4CVgNKNZzc/MyAvUvGVyh1thtiY4XrpxFG22SBuHPH/focVKMIki5CrJZPx+C5nIlGS5bcsfWaxjhYhn5PaIzLSllmqwXwMRk+2DoR/MYp79f++/vfLLgxA1pZEptTTuBzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KiK5n1hf; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHz3HzrbaRgI6EAHfMO53pgMLDBQhoH1KXm9F7/50ezLicXAdG42jkQh9Zh3u8WhMxg0IGO+oWGIlvMkLeZCcv6VGB7n9wRx+FjDY8S36/QqzArtFCn1u9jC5aXTTVb5oO4x6UmuJvTKKW9Qhk15xOWp0ikK9d1uJskDxGgKhyR9n+gg4K7FwiWIEAdKx/A6fSgyoisKKnQMaCioNmGeO/Eb8k5qmoEQEi/m/fXn0PiEMDXVORcszshXW5CjK/WBJNQ9bScBgh/8ER6gkVQn7/5Wa86NViDLOTkOGwHoJ+drTTJKleZ/aLlLTKV8WwzKrS5nehwB4srRob3h0EtnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk9SL3ZbHMQR09n1CoTfCcQptAtrK2cGNpr6q6bpVxw=;
 b=Ubv9RX8yuZefvSW0G8AuOTvyvKn1PNI9oyY5A8qjFR8pYSYvfG+PyPBwL+qhlBDVLDMTC/mjE7DjIdaG2AjJE8CPeIlN5/Xplaqnl5kz7zDS8uL8u2qlIXE84EFe0TK1KdC6thiqC1n4hEgDVXEKVPAjw839dAz3TIbnEujuk1yl7JZt5WLtapZEFbC4GDy9s5YSXzFS+IZFQKBagVS0kBdZsWlIksiq8Upri6B/PS6jiAWa8eT/03oXESuqfuTL6YBO1WaCMNgyqoJ8RX5kyZveP01yTPdMZ1KYyAnb1iBLLlgCaDvgrUXJp8HMjU++PtyngaKspuyra0QOrnmWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk9SL3ZbHMQR09n1CoTfCcQptAtrK2cGNpr6q6bpVxw=;
 b=KiK5n1hfOUITAbsvZk2qsOgEKQYM1yDAfLUVhkFi4ZeD/ruMzaqunk65ITXM4zN3XMmsu8QOtNjSbajtW5HaCci+RQzp22nZbH7T5hvOjgPgo0LOv0cF3e5JGumKaHsSPTPEt8zy6zMPDNj1svtICTtTo7KluBDi4BvH7A7SVVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 16:47:42 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Tue, 7 Jan 2025
 16:47:42 +0000
Message-ID: <205c47ef-6651-4a57-bbe4-adf1b8a25983@amd.com>
Date: Tue, 7 Jan 2025 10:47:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] ACPI: platform_profile: Let drivers dynamically
 refresh choices
To: Hridesh MG <hridesh699@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Kurt Borja <kuurtb@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 josh@joshuagrisham.com, "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Armin Wolf <W_Armin@gmx.de>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250106044605.12494-1-kuurtb@gmail.com>
 <33a5b6a2-e4df-4bfc-88a9-a9e8309c7f7a@app.fastmail.com>
 <CALiyAonc81o1FreDaWiik3XaqKYVf=wYHX+vaE2_1w66LhJTnA@mail.gmail.com>
 <2e71a4a9-6ec6-4ac7-8640-d80dcdfd7776@amd.com>
 <CALiyAonp1eow2ht_Cmux0B5+-Ukx7YxsE59c4VzwfSvL61iQ5g@mail.gmail.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CALiyAonp1eow2ht_Cmux0B5+-Ukx7YxsE59c4VzwfSvL61iQ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:d3::18) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 0748e0f9-9832-4186-2ce8-08dd2f3b0118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U28wU2tkVk5GdnZJdEdGNVBBbWpEb0xhLzEyUGI3OWd6aStQeWhZZFpLblUy?=
 =?utf-8?B?SnFQam5rK2JVUEVhRUFSamJDeUVNSStKOXo1dTAvTmNkUFhGUjFsVjV4aWM1?=
 =?utf-8?B?S2MzeEZ0anA3NE1lZ215VzRKV011Zmgxei9SelZKUHRFaVl5WCt2Qzk4QVNh?=
 =?utf-8?B?NlZJcW1WbFUrWjFtaUxubzh3a3JRS3ZBeklQMUdkMjNlSUljOHpNYlRXeExX?=
 =?utf-8?B?Y3dKUXhKTW11eWRIU0Y5aFBnL2NLVng2emFrT0tBdnVlNnI3TlcyaTdwaU9N?=
 =?utf-8?B?NVhSdERJZzU2MElhVDRHbE80V0U3TmxFQjZ5cTl5TXBIQ3Rqa0hOK0V5WXg0?=
 =?utf-8?B?QlZmV3MxSCs4YzlYcUxuSldNcW1vYTlRSWs3ckN5VjVqeTF2VzFmemw5dnNv?=
 =?utf-8?B?R1BUOHYycFpNbTBybHEyU2VTaDZ5YzZKekNRbnRzTENmOU83WXc1KzJpNEJO?=
 =?utf-8?B?TUlsTDlwQ0swM1BsOThaSGQzSVQyVk90bGNzUmZMYWd3S3Q5NUhrcFFPcjF6?=
 =?utf-8?B?KzBxV0hhaHpTd3daZk8ySm5qK0hsa1BPYTVYUE1kalZtUHBpOGc2YVBRNk8v?=
 =?utf-8?B?dzhmU24yWXc5WnpaOExVWjhyZ2tDSmE2aEFRSGxlbGFQMFVvLy9xSjFpa1Jo?=
 =?utf-8?B?cUkyOGMzdzdWTjB6Wjdya1JraVNpcWtKUFRNNFErMERXNXZiSjZtNEhTMHJE?=
 =?utf-8?B?Q0MzclpkKzIyTzV4c0IvYjNzZGUrNExudytaeXNFWmsreTNMVjJlQW5adENO?=
 =?utf-8?B?VHBNaEVsaUNzbElwUlZ3NytobWVOa2tWamNNNWVWNjJtOU1KNS9tN0ZXVEp2?=
 =?utf-8?B?SWlIcmNwOVlreis2NzRGcjMvV0hyTmNnWFQ4Y2JwK1FJaE9oNEZ5Q2pJcGds?=
 =?utf-8?B?VmZ3R2MrMStMQ1BBRGNzQlFlUlBoZGFHZG82TVppNVV5ZmIzakY2cXdPWHk2?=
 =?utf-8?B?S0RrUUtZblZjN3RjbFpQSS9QRnk5L01KUzJNU0FNOGtwaDh2Q1FCMVA3aG95?=
 =?utf-8?B?SittRHZjK3BWOFF6ay8vUnk5Z2xrb1BXaWo5Ym9hV044RVFEWW9oL1lIaWlP?=
 =?utf-8?B?cFU2STQxSndROWFteXJHOFhzZzhYbjgwcWZWTXVNbzcvNzZ5YXNDeExOQ0VU?=
 =?utf-8?B?bS9KSnRPVEdvd0kvTXFDSkVIblFlWlJoa2YxdlpTSTU4TDJPZm16eEhZY3BG?=
 =?utf-8?B?elA0NmtWTFBkSHJiNkhsUWNsdmJRRGtnMDdlNFJKZUYvRzM5ZFdQWUtnbXN5?=
 =?utf-8?B?a0JVemhsMENrTDEwaWM4UVBQbW1NWWJYY2hxbENRTjdEUUgyU2RpQTdyNHVx?=
 =?utf-8?B?SVlQL3kwUVUvdlJWWHNLTHZnazJoKzc3N3J5NjQ0NENneU1vUm51R2k2VlFl?=
 =?utf-8?B?V0xibklZaHpoNDJoT2hHL3hRbDhleHVDcnVGWFpqMWN4eXM3RTJpR2VmNWhO?=
 =?utf-8?B?QzViUkVLcHppTmJJejdsY2x6YnBVSjg5VldVb0dlcS9QeDZQbzhVZTcrNGl1?=
 =?utf-8?B?U3M1RWNhdHE0NmRUT2oxdnVmbWRlSjlMTEZzL0V2ZG9abHZia1J5UHZwWGZQ?=
 =?utf-8?B?L2RCQUtaMlJEaE4zZTFNclZZNFR1clJua3dLbXgyVFM2NFIwTzhlUDlMbldY?=
 =?utf-8?B?aS9Md05HMTJ5d0lvTGk3SVVVb0NheWRkTzJtQ0tRa2pzSm92R1lVRUVScGU5?=
 =?utf-8?B?czFicWV5QnRBbC9sMk54ejVEaTBjaTEzZU9Zc1lOaEFTR0pkTng5UGpRSnBt?=
 =?utf-8?B?UWxSWUpUTUgxUkZPWGhBNm5UVHhnaEpndFRxc3lSd3AwOUJMejAzaUZ2cTFQ?=
 =?utf-8?B?OVZHU3Z6a253OGNLV0hLazd5bGpCZ2ZxY2szbWRscEs5dXg2RVExWFpPNEdG?=
 =?utf-8?Q?JFv2XXmJIvoxd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R01QekwzdXZSQWdZUGlyRlhsaFNpK1VMbEdid01tYXd4VjJ3ODBKOENodjR5?=
 =?utf-8?B?eFV0WU9kNVVyQTJtK0Y4MnMzU2N3d2xRQjBjSnpWdkZiTC92akxQZ1N5TDVr?=
 =?utf-8?B?UjFzc0lQNStySjJhRW5UemxtL3ZBOG1kVGdBMDB6YjEwMW9ORkYrNk04TU44?=
 =?utf-8?B?Yk1aNjZFL1dIQmJ2R0tYajFKa0RnZmw3Wmp6cTBZaU1LeFJ5c1dvd0RQQ1JD?=
 =?utf-8?B?WTVXMHkyTlFKdWZwc0tRcnlXKzFiQlhOZ2VGbnZCdER6cVpuTnNtKzVFaWhR?=
 =?utf-8?B?WHhsM0ZMSE9nZTJqTlh6cTB1R2h3Yy9YRnJtS3JFekF3d1A1SlQyQVJRNjJz?=
 =?utf-8?B?ajFMdTBIelU4RmZtMVBic1E3YW94bFdsUDdBRUpJQlkyeDlLVXEzQWxQcUIw?=
 =?utf-8?B?SkpWazVaR2RXd0d2cDN2RGRyVU5rL3JPRnNPWDZTUVQyakc4b1B1UGhmM1B0?=
 =?utf-8?B?ck5maTJDTVlNR2JqQ3UzSGRpc2tFWkk3WkdJV0pMSlc2YWZGRFErUWNPV21y?=
 =?utf-8?B?THZRSFhkVzI5bklIWjZQbjRhdlNEQk1rcFNZUXQ0TmhkU1RKVGRtTS9JMHRG?=
 =?utf-8?B?UjZKSTJGU1ZXRDN2dG1GVGJOMm1uTUtGejJQckg4d1gyUk1aakhOMTU4bGdm?=
 =?utf-8?B?TzczYnpuSnZRZWZtODRMT1RCTHJwckFpUzhGQzI2QUN1KzlhWGRIZEZoWFhl?=
 =?utf-8?B?ZWdnUklUUzZQcEpJWjI3OERRNno2WG90dUhRTXVySkRCbm1yMlNYazJBbTRp?=
 =?utf-8?B?OGxKQUZPRmREeC9xZjZNQTE0VzF4L1NjZXRrekJOS0ZVVkpZZkNyUGF0ZHVO?=
 =?utf-8?B?UnozMFJadDJKMlhESXFydEJVWHRDaW1GbWF1MDVjOFJoaTdqSkxNa0JxNTl1?=
 =?utf-8?B?NUZ1TTRwMC95V1c5SDNtajJxYVpiTlk1aVRmRGZMZTNUYUQwZzlVRkxaVWtt?=
 =?utf-8?B?Q2FtRmVhVE5ja3JRT1pXZ1BGM1pWSGpPcmtEZUZ0QTM0V1VSYWtOUy8va3J4?=
 =?utf-8?B?UFNvU2NGdGgwem9RYVJzcXduNEJBeEVKak5tTnhqUzVLTTkyYy9TNzUrME9X?=
 =?utf-8?B?YUgxREF4dUNQQWxabTJKc0ZqOEVlK3ZPcXVJcmZHY1BQb0U4OGMvTmswTlVH?=
 =?utf-8?B?TVI1T2JNTm54YVoyZXJWdGlhUzlPZEJMVDdGSWFHUWlMSThVMkpnT21xaDVN?=
 =?utf-8?B?Ym9NTFZxM2d1MEtZSHBDRTlGL1JXeWM5a3YxaTYvZWFmWUZGRGFxRHh5d0I2?=
 =?utf-8?B?Nk5xUVg3MnE4TmREV0o5M1FNejcvTEhoRHBZTDRMOUZuU0FzMVBsa0swaEUz?=
 =?utf-8?B?WlQ0ZnN3UDhFNkNOaWlmYXQyaS9hUVFqVVNUZkl5d1N6VnAwajMwZHVXbFBM?=
 =?utf-8?B?TVkvRmRKcFdwVTlEN1FRTFJLV2hmZUFtQnJEYWp1VTFKekVWZXlQZFkxN3Ew?=
 =?utf-8?B?WTM5Uk9tTTU4b25Xb1gxUk5lV2RsTkNacTlHZjhGQU15TWZHenQyKytBZVpJ?=
 =?utf-8?B?NVEyTlA2dElZMkdWdlA1SmJXM0JRR0ZnR3FqbjM5VDFvMDNuWHVJSmp0S29S?=
 =?utf-8?B?ZmwxUXUrR0cvajM2YUc5MzRHSENEUkZoeno2YXVudjlKVERqOWNvVW1MOWdX?=
 =?utf-8?B?S2VORGFXcGtpaFYyOXY0MDF4d3hJZlRieU5WUlJsSXVBWEQ4M2xrYUNKWXRN?=
 =?utf-8?B?MExtNkdWYXBtOXVKaGp6dDh3Zk9XbVFqSEY2Z0U4SVdhN2xPUXFTNnE1Znhk?=
 =?utf-8?B?amdNZHQvd3lZUkVVbm4zOGlqcjhyWkNpWmFDbUh5NVVycXBRRHc1Y1pJczYx?=
 =?utf-8?B?LzNFZUhGd003OE03TGVkdlFzdndjeHcrZFJRdFl1VDJlSUt4L2t5cXVUSXRt?=
 =?utf-8?B?NHgxc2RGZmNtKzhXdW9oR25pTngydmE2OG5TY1dOYS9zeVl3RnBNYWVEZkJT?=
 =?utf-8?B?cXF0MG5xbjZoYXUxM0wzVkV0UzhseklRV25vMkhpY1NNRktRa1pTMUZRWkVC?=
 =?utf-8?B?SFJLeDdtdmZWdlZZZTVORDdZQjVlM0ZFTnp6VG9yeDhTa09zcE1CbGsvZzMw?=
 =?utf-8?B?dnppZi93NnAwZjVvKzhDUFZVY3pNK3NHOThlWGhDZ0krOVA5U3lnd0x4TTJn?=
 =?utf-8?Q?fZxkKpCyv+b64DskEHEuUNkBV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0748e0f9-9832-4186-2ce8-08dd2f3b0118
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:47:42.6259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGeC7pRvFt1j+268UaLYmyRQRLuHVjjBtEKk7Hr7ylw8cN57aEdRdvqSo5K8Pclq23eycid0w8RVcLtVV9tFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743



On 1/7/2025 10:33 AM, Hridesh MG wrote:
> On Tue, Jan 7, 2025 at 9:21 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 1/7/2025 07:14, Hridesh MG wrote:
>>> On Tue, Jan 7, 2025 at 7:49 AM Mark Pearson <mpearson-lenovo@squebb.ca> wrote:
>>>>
>>>> Hi Kurt,
>>>>
>>>> On Sun, Jan 5, 2025, at 11:45 PM, Kurt Borja wrote:
>>>>> Hello,
>>>>>
>>>>> Some drivers may need to dynamically modify their selected `choices`.
>>>>> Such is the case of the acer-wmi driver, which implemented their own
>>>>> profile cycling method, because users expect different profiles to be
>>>>> available whether the laptop is on AC or not [1].
>>>>>
>>>>> These series would allow acer-wmi to simplify this custom cycling method
>>>>> to use platform_profile_cycle(), as it's already being proposed in these
>>>>> series [2]; without changing expected behaviors, by refreshing their
>>>>> selected choices on AC connect/disconnect events, which would also solve
>>>>> this discussion [3].
>>>>>
>>>>> Additionally, I think the platform_profile_ops approach would enable us
>>>>> to hide the platform_profile_handler in the future, and instead just pass
>>>>> the class device to get/set methods like the HWMON subsystem does.
>>>>>
>>>>> I think having this kind of flexibility is valuable. Let me know what you
>>>>> think!
>>>>>
>>>>
>>>> I personally would love to see how this would be used for the acer issue highlighted to see how it would work out. It feels like the series is short a patch :)
>>>
>>> I do think that having this flexibility would be good, as i was
>>> considering manually clearing the set bits and calling platform_notify
>>> for the acer series, but in my specific case (for devices using the
>>> predator v4 interface) it was found that the hardware was responsive
>>> to all profiles regardless of AC/battery mode so it made sense to
>>> leave this kind of artificial limiting of profiles to the
>>> userspace--similar to how the Windows driver handles it through the
>>> Nitro Sense app.
>>>
>>> I feel like users should have the power to utilize their hardware in
>>> the way they want it to, though if there is a compelling reason to
>>> limit the profiles then i'd be more than happy to add this to the
>>> series :)
>>>
>>>
>>> --
>>> Hridesh MG
>>
>> I agree with Mark, this series is missing the patch that shows exactly
>> how this would be used.  Furthermore; what exactly are the differences
>> in choices between AC or DC?
> On the predator series, the Windows OEM application only allows you to
> select the low-power and balanced platform profiles on DC. These
> profiles can however still be activated through WMI methods and the
> hardware will apply them.

So on Windows if you are on DC and pick "performance" then go to AC it 
will automatically switch you back to "balanced" and you can't pick 
"performance" again until you go to "DC"?

This sounds totally counterintuitive to me at least.  If you're going to 
gimp people on anything, gimp them on DC.

> 
>> To "userspace" I fail to understand how "balanced" is different from AC
>> to DC for example.
> It is not, the profiles or states themselves are not modified between
> AC and DC, just the switching between them is affected.
> 

IMO - just because Windows does this doesn't mean we need to in Linux. 
If there are only 3 sets of profiles, I'm of the opinion we should let 
users pick any of the 3 profiles in "AC" or "DC" state.


