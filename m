Return-Path: <linux-acpi+bounces-10627-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D25BA10C68
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E09A3A8321
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9090D1C8776;
	Tue, 14 Jan 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B5FiXx4W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302281885BF;
	Tue, 14 Jan 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872607; cv=fail; b=kyvaDVZidT8EL5GQqirB5G6IXDyyM6RQyj+TUrvmSINuEEqyWSno63NyjZWMas7st6zis4/sVAqw21PYpNvf7LNXDDdCPJcWC7nHgdfiH+cFLPRSsgbZYzQAn1JR+KMFXNrRdVhqOXfiEOAu0HX2B+Br1HyX/WICdccLKqz3AiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872607; c=relaxed/simple;
	bh=QXovIuH6ySwE70ft9OC2rdKnQmUqDmcDwtfgBgxrOPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GBQFojcktmyyAZ6zYX1ujXRn/FlVhRQ78s32X0R+CTxmmDmin0L1YMWqw8MxQX0XExeKYmgmLjfHqbAJLXGEXsPlJCudEKjsYCC8D45tdRi48QWBz0XI8RUdoka1bg4CjcamTnavHhSYxNywVO0c4PbFbqqRleq6Wn9aH+i0lkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B5FiXx4W; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym5mx5R+SKLmOdKIkrLjhJb2IB9wziujubAOcqAS/stkaIOtybnLO32Jtjss1tteSLybK6CCaZfL68vpBbXoNAra94R8YpALxERKMGxDBbimDUeUtUvWen2gY7G0RF8Gr2bNflagUXynXKSICeaLddDyeMpMFtgsWTPT/nvFw0kzurYTDPqJXkbx+lAR2rVbuY1etQcVpB/a5iHwLEOjGCcoIFMNwHrJ9GRBFG2rtGvoNxHXC6Eh9z2MHauM9NIT6PqG827K4ipzgdmSIGoUcvSI3/Daf8SxqeLOUGohPmUYpjQp8aIv0rjusHR01flhjANLJulD7wqR1S/LhXj9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlopzxJOOwE7yJZKsnfHHA8ulSWnFE2kRigTzOnWzmU=;
 b=X2AgiV12T3qKffgr8gxL0oxNIZNwg23xny3utxBbhOvNXNLKomNIiDlvLR2AanCydMyEeqqh9gBQYRPnmVSlX/yF6VblBYrBTajFAiqahJGprNBAot6QaSbXd1GRG+UxywCND6fs8MaOd5Kt1Mg1ThnGVsv+WxMOLVPYpTGtu1nyrJYQWPiaJGWvyK6sxlpSpRc4wGCzmZE1JvYsXoXF5IKGcmwEj7TmOYVUNkmxdVZpWFjSphv7SE21qIQuT9K1DI5SQzEZHB/lnC/J/6osq8rQJ617Uyka1QT0cWgLIwnKTV2xpeaGsW7ydPlYUgAqHVcwoQKaOezuHweuCBDb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlopzxJOOwE7yJZKsnfHHA8ulSWnFE2kRigTzOnWzmU=;
 b=B5FiXx4WxmuNnamkrZMzJpdIDnmsCBhssDxT/OgfbA7vt42GBL+2fAWQ5Zm+aDKMSdqPvZx7oLnnCiPFQ+NVr2UhxF+dMXiwjFnwUv19yHP22lRTC5Pzmo4bve2WcaNYk9Ziz6bW5WnoDU565dRf3ZUNcWmcKEjqeYcvgtOxVHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:36:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 16:36:40 +0000
Message-ID: <a2e97e14-14c4-4108-8f1f-a81b240495b6@amd.com>
Date: Tue, 14 Jan 2025 10:36:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] ACPI: platform_profile: Add `probe` to
 platform_profile_ops
To: Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
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
 <a0a3fecf-6b03-48f8-a03d-a7076f31e2dc@amd.com>
 <k36dxs46y5riaiqwvse5ldxeiday6o6p2j74kmsusnmnkwsoyx@m5iyooae27dr>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <k36dxs46y5riaiqwvse5ldxeiday6o6p2j74kmsusnmnkwsoyx@m5iyooae27dr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0145.namprd11.prod.outlook.com
 (2603:10b6:806:131::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: f694f751-168d-4c28-b2b3-08dd34b99f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHhDSk9sNk8rRk5FdUZOd1g2SW9qRzV2dUtHSVo1YmliSkVtd3E3RG5GOEVa?=
 =?utf-8?B?NHV4NDU0VTBMbkM4RGF0ODdRcm92b2pNREdEa2RNS1BHeXV2cFZ6R2NBcHBY?=
 =?utf-8?B?TWowdFFwZVFYRExhY2FLQ1REYSsyditVZ1BTSDFHZEozUm1lZStFdkRBRjdT?=
 =?utf-8?B?QngvbTdPdWE1Rlp2ZFZPKzlRMUp3T3pOOHpsaC81VE1qNXEvR3Q1V013Y0Z4?=
 =?utf-8?B?ZFRvUmtTK3h4NU5QbVNoUU5TOVQ4NXRMZjJZR2FkV2dZNWlEaG41ek1Vc3JF?=
 =?utf-8?B?ZGpyb0N1eUhkZWtyWmJkNUJaUTNaQ084Tm5EM1F1RC9CMFFoUzNHMHViM0Uz?=
 =?utf-8?B?VkYrOTlKalVTdXlpRXhKdlM4Y2Z3SnhkSTh3TEQ0bFFxYys5N2NqTHQrbGNw?=
 =?utf-8?B?aXV2ZHYyZmczamdXR2IvQTVtdVZPWWNzZStYV2djR3BCVkNtQ01vKzVSSHZt?=
 =?utf-8?B?ZXNtWjlKUmJCcTdGMnRwWjF3SU9HSE5Db0NSWWFKbThEeUxkRjNZK1BubW9a?=
 =?utf-8?B?M1ZWUXBiZHdTNFBxY2E5VWtGNjZWa3Avc1JhY0dKSDAxN1lMOGY2WmVoaloy?=
 =?utf-8?B?UmpmQzBsVVRGTnBCVWU4ZzVEOW50M1lvbmlhTC9rRFVWKzROTEsyc3l0cUxT?=
 =?utf-8?B?S1BoNTRTREVLMXR1NGJuR3VIVno2dzhKU3kzTG1rbXNtWlNrVHltTVMwRUI1?=
 =?utf-8?B?eS81bWVNeTNteFp1VWZiUUVDaWxhKzFoV1BCVGV5dE5RRFl1MzFkQXY0OGU4?=
 =?utf-8?B?ZGFNNTNmQXhkeDFXU1YzVzd3eUhVbURQVGhaRHhQcTJXYUhZWGtiMlc3TEZO?=
 =?utf-8?B?dWtKVGc2Ly9xVUZKbkJRSmdPWVdkbzJUaTFIaTZzU2Yyb3N5aXBQWTFGSVJm?=
 =?utf-8?B?ZHlydWpqUkRXVkJLVEplWUZMVnQ4d0N1NWY3cGFlSHlZRWlGUkd4SjFqTlZq?=
 =?utf-8?B?L21NbzVXdUUrNnBVZlN6SzhYM2FkaER6NGEzdGNWcGVaemVYbzJIVldSUDNX?=
 =?utf-8?B?SnJNYWZjS0VXSDFPWk5NOUZTeXpPYmd6NGYzR1haU1Z5RUszdXZhTVdDRTdT?=
 =?utf-8?B?c1R0TUxmMVBDc2c5OSs1d1FtN1kvRWNuT1hqUWxSbjB4M0tuMTB4Ly9Rem9m?=
 =?utf-8?B?Ujk4YzRCTnk4YVBZR21wcXlzUXA5elpQTnJVNzNkbnJmRk5WVnAvaWt3aWYr?=
 =?utf-8?B?TUR6QkJ5UkVXcnZMaUtoR1JLWXFHVm51cG9NdVY3cDF4MnR4Nm1YNU9saDNG?=
 =?utf-8?B?eG41azg4Q01qS09tUW1LTG5CbzRWeTdEL0JpbUF0ZGNBTHF6aWdhZGZ6Qk11?=
 =?utf-8?B?UVdoR1o2UmhnUkw1cEp2RG9ZUG94WE00YUZDZ0d3TXFYYTZDNEE1TnhvOTVt?=
 =?utf-8?B?ZEFRclN5bURUcnpkSjFVZ01mWGd3WEY4UGNKRVI2VzJQVHJxWEFKYzJVdzdh?=
 =?utf-8?B?RFBvS0t4cmQ1RVhtQXRyNXdpbTFrSm4yRmlSZStqNmZrUXE5VzcyUEFUS0FH?=
 =?utf-8?B?K1lwY3JXWm13YzFjYTAyc1IwSDJMdzY1TkYrVEV5MDlUdGxZaDRybUgrRTV1?=
 =?utf-8?B?V3dnaUI0djV4U21JQk42Q1FYM2FwN05tK2RzQlR5bmxqUHdNeUNvOGkvYmNX?=
 =?utf-8?B?cXdvWmplckZKdXJMZUVmdEZ1RVZFekoxMkZucHAxcGFtSUJpbXdlWTZ1VEN2?=
 =?utf-8?B?cHIvWUFHeHZYckFkLzErdWwrdGJUZ2g5VDV5M2FuWmUyTlFWQzFaLzNONFhK?=
 =?utf-8?B?V25BUWRuOUdybG44MWFCdTdyTjhzUjh6T1ZoWWRFUEIwK01MMER0SjZMQXFo?=
 =?utf-8?B?cjJQMEgwbDRBT05qN2VKUnVnMUtZbmlmRk9PNWZYc0UrL1FQU3JuRlBmREVj?=
 =?utf-8?Q?orV6EBuOxKkTc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmhGTnVJNXpQdi80N1I5c0xIc0Y4VDk4SjBFUWJlbFRLNzZiSG1sS2dQVmF1?=
 =?utf-8?B?c1FUK2RSYVNMb0VKZjQ3elI5dmw4V0loV1FRNkIrVTRYMmpISDJKd1JtNGxp?=
 =?utf-8?B?N3NCY1p3MStVaFNUc0ZDa1hSTTdtRnN2S0NINEpaQWdGcU9CWDlONExaYTIv?=
 =?utf-8?B?YXdpL1RnWVBBZU9XYUEvZFFBdmltTXljZ1lUcUp6ZnVOSVNmOXYybDcxdDNo?=
 =?utf-8?B?SllKRW1kQytEWjRLdFB1bVdLaTk0Q2xZdnU3WVhRdno3Z1BZQzRwTnVqSnFh?=
 =?utf-8?B?Uk44NnFDWlZiRCtsMUpQelRHcGRlS2xwVThOUjZ2djRGK0haRW1DZDl5b25K?=
 =?utf-8?B?OGgwRnNkZXRUVS9SVmNVa3pzWE1FS0QzaEo0UFNOSk5Ec2s0UWlQQ0lDNUVQ?=
 =?utf-8?B?bFJlZ0dOVk4zdFJhRUxMNUovUGo0TldnSTZ1UHRudDJGUisvNWN4VjgxMzZz?=
 =?utf-8?B?K3dnck9MK3AvdHZKNXI5ckRiNGZlRWpTZUVzb2w0QUV1ZTB6bmk0c0xzUHZH?=
 =?utf-8?B?YlBTYWNDM0p4UTJaTmFVWEZ5VU4wSFlwTHg4bFNQd1lZYkN0RDFFQXNDOFM3?=
 =?utf-8?B?K3k3QnVRZ2pzWm4xN2ltTk1PMkJrMTJ5WFkwZXozZXJJSFVZNlN0dU9UbE9v?=
 =?utf-8?B?YXNpbEZONUNzR2htRDJFNjVHYnZCcHU0RStZOGJHc0tucnd2QlpPSTk5NjF3?=
 =?utf-8?B?MHN4NUhxUDE4MkZEOUpmbzEvUzhReGF6QkxkSkhRMndKQjNzTkJLU3lmUGpj?=
 =?utf-8?B?OXlmcFUySVgvZHZtUy80T2NCWWFYSzVlSVZ1VS8vVHo3bjNucVFKN0dGcmZs?=
 =?utf-8?B?MVNNVDhQTlRiZjg1aVIvaXVPeVFobnpiUXY0azRLeHJBN3pGQTB0T2w0Ti9a?=
 =?utf-8?B?Q1k2NFpYVEZxWW83U01ZbTZIMVo4QndNS0IrdkJwblFkK2VneDBXSWR6dUd3?=
 =?utf-8?B?QVd4cHUrcnZMTXlOQ1FNbnVFbXVXcjRnN2JFSUJKUTVUNjE0MmdRbGQ1QURP?=
 =?utf-8?B?Qy9BaVI1YTRDN1JUUGFGZGVkRWt5dW9rM1pja0c4SldkdldTRVBhdnNQc1NQ?=
 =?utf-8?B?cFBrY28wR1hZeUNjaEZxMjVwYmxtTzZpVlJNZitLb2UybUlYK3BhQUpuOTZy?=
 =?utf-8?B?MnN2c3VKclVHdFdWTTVraDFabVVickI1UkF2MXJCOThnMnljMEtuSFdxL2Js?=
 =?utf-8?B?OHVvTWVibVkrYjBRWXpQT1hUSkVIM2NORTN3TEkvNVg3bDU5MmdLd1lKSkxS?=
 =?utf-8?B?UGdKTkxkbXVkNWVjUUJsZC9IRjRvL3ZIaEs2ekdpZVF3dVBKejBqRkJlUnlK?=
 =?utf-8?B?Y0hQa0czc0ZBUURlbUpVemJsWkpYbCtraWxLNFdXQnF6cDdCeWtjcWJTRWVj?=
 =?utf-8?B?elFibG11bjhEbXRNODBPeWNXdUhDMFRGUWhlcUpsRVVYdDV2NXpVdnBDa1FM?=
 =?utf-8?B?WHpkWk1sYTdTN2hKMlNQSXVxOFRCTXNsVmFreFpBakJORWN3RkgyMXRkbzAw?=
 =?utf-8?B?aXNLQWhBR0ErMTJ2TWh2UDJLTU8vRzdTNHZvenFBeGNRWTV3dHhYZ0JzZzJV?=
 =?utf-8?B?SEhQTUxIQytRUmpXL2hoQ1ptNDI2cUhraWtRUmh6NG1uNEdEcnpFNW94aVZO?=
 =?utf-8?B?RGp3eHh6LzFCUXhqbG1XQ3NwNUI5RlFmRTFhUEZlSEFzMFFiZjd1cFgwQ2NJ?=
 =?utf-8?B?bDRRZTRqOE5mWm9rZ2NzczRWdm5aQVpONkFnOEZDeGZSZUs3V084cjJNVGsr?=
 =?utf-8?B?ZTBML3BHZXFBYWNHNlBnczY2MDZhcklMT1dqeGozaVZTcGNUWnBhNG1GSm91?=
 =?utf-8?B?cW5kZzMwdXA3bFhTUllEYkEva3RRdlpQUGJGc0VPK0dVR0VITFMzNTNnQkZK?=
 =?utf-8?B?MHM4REJrRzJibjVRUDhGYWxWMEJGUXJzWlNXT3Z1UTNqQWJRaGlBRnBwTURQ?=
 =?utf-8?B?T0QxRHMxeitlbXJDYWpaTkJoRCtTOXNhQVRib2VIQVJ4VW8wTUs1QVB2S3dU?=
 =?utf-8?B?cmdQM1NxaFRrWDMvWDBiYkV3SUwxZFYrVkdKY0tmdmpoU2ZQVkw2WVIyNFpk?=
 =?utf-8?B?WFhnVVlmK0d4azZMNHBqWlhNZHo0Rkd1UE5SRHVueTFBeVJ6NTgxK0VuK24r?=
 =?utf-8?Q?789c+8BzC5fBTZK44umG9D37J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f694f751-168d-4c28-b2b3-08dd34b99f0a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:36:40.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3UE2E2rszG8+ielJEy6aqxvZgEmk5nn4umvIUnUCljn/0IZqt9Op37OdkH8olOmz12URaTF10duqXW2QK+13A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

On 1/14/2025 10:31, Kurt Borja wrote:
> Hi Mario,
> 
> On Tue, Jan 14, 2025 at 10:20:15AM -0600, Mario Limonciello wrote:
>> On 1/14/2025 09:37, Kurt Borja wrote:
>>> Add a `probe` callback to platform_profile_ops, which lets drivers
>>> initialize the choices member manually.
>>>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>> ---
>>>    drivers/acpi/platform_profile.c               | 13 +++++++--
>>>    .../surface/surface_platform_profile.c        | 16 ++++++----
>>>    drivers/platform/x86/acer-wmi.c               | 24 ++++++++-------
>>>    drivers/platform/x86/amd/pmf/sps.c            | 15 ++++++----
>>>    drivers/platform/x86/asus-wmi.c               | 16 ++++++----
>>>    drivers/platform/x86/dell/alienware-wmi.c     | 24 +++++++++------
>>>    drivers/platform/x86/dell/dell-pc.c           | 26 ++++++++++-------
>>>    drivers/platform/x86/hp/hp-wmi.c              | 29 +++++++++++++------
>>>    drivers/platform/x86/ideapad-laptop.c         | 15 ++++++----
>>>    .../platform/x86/inspur_platform_profile.c    | 14 ++++++---
>>>    drivers/platform/x86/thinkpad_acpi.c          | 15 ++++++----
>>>    include/linux/platform_profile.h              |  1 +
>>>    12 files changed, 137 insertions(+), 71 deletions(-)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>>> index 440654e21620..34e22b006ccc 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -466,12 +466,21 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
>>>    	int err;
>>>    	/* Sanity check the profile handler */
>>> -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
>>> -	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
>>> +	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
>>> +	    !pprof->ops->probe) {
>>>    		pr_err("platform_profile: handler is invalid\n");
>>>    		return -EINVAL;
>>>    	}
>>> +	err = pprof->ops->probe(drvdata, pprof->choices);
>>> +	if (err < 0)
>>
>> Any particular reason to specifically look for less than zero?  Did you want
>> to have the probe() return something positive in some circumstances?
>>
>> If not I think this should be fine:
>>
>> if (err)
> 
> Ack.
> 
> I did it out of habit.
> 
>>
>>> +		return err;
>>> +
>>> +	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
>>> +		pr_err("platform_profile: no available profiles\n");
>>
>> Doesn't pr_fmt handle the prefix?
> 
> This file doesn't have pr_fmt :( I'll log it with dev_err and add a
> pr_fmt in a separate patch.
> 

Ooph!  There might be some other cases the prefix needs to be fixed then 
too.  I noticed it in use from some existing code too.

> Thank you again for reviewing this!

Sure!

> 
> If Ilpo doesn't have any comments I'll send a v3 right away.
> 
> ~ Kurt
> 
>>
>>> +		return -EINVAL;
>>> +	}
>>> +
>>>    	guard(mutex)(&profile_lock);
>>>    	/* create class interface for individual handler */
>>> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
>>> index 76967bfeeef8..48cfe9cb89c8 100644
>>> --- a/drivers/platform/surface/surface_platform_profile.c
>>> +++ b/drivers/platform/surface/surface_platform_profile.c
>>> @@ -201,7 +201,18 @@ static int ssam_platform_profile_set(struct device *dev,
>>>    	return tp;
>>>    }
>>> +static int ssam_platform_profile_probe(void *drvdata, unsigned long *choices)
>>> +{
>>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
>>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static const struct platform_profile_ops ssam_platform_profile_ops = {
>>> +	.probe = ssam_platform_profile_probe,
>>>    	.profile_get = ssam_platform_profile_get,
>>>    	.profile_set = ssam_platform_profile_set,
>>>    };
>>> @@ -223,11 +234,6 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>>>    	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>>> -	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
>>> -	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
>>> -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
>>> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
>>> -
>>>    	return platform_profile_register(&tpd->handler, tpd);
>>>    }
>>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>>> index 91ae48adf6cf..6953e36dbfde 100644
>>> --- a/drivers/platform/x86/acer-wmi.c
>>> +++ b/drivers/platform/x86/acer-wmi.c
>>> @@ -1916,7 +1916,20 @@ acer_predator_v4_platform_profile_set(struct device *dev,
>>>    	return 0;
>>>    }
>>> +static int
>>> +acer_predator_v4_platform_profile_probe(void *drvdata, unsigned long *choices)
>>> +{
>>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +	set_bit(PLATFORM_PROFILE_QUIET, choices);
>>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
>>> +	.probe = acer_predator_v4_platform_profile_probe,
>>>    	.profile_get = acer_predator_v4_platform_profile_get,
>>>    	.profile_set = acer_predator_v4_platform_profile_set,
>>>    };
>>> @@ -1931,17 +1944,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
>>>    		platform_profile_handler.ops =
>>>    			&acer_predator_v4_platform_profile_ops;
>>> -		set_bit(PLATFORM_PROFILE_PERFORMANCE,
>>> -			platform_profile_handler.choices);
>>> -		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>>> -			platform_profile_handler.choices);
>>> -		set_bit(PLATFORM_PROFILE_BALANCED,
>>> -			platform_profile_handler.choices);
>>> -		set_bit(PLATFORM_PROFILE_QUIET,
>>> -			platform_profile_handler.choices);
>>> -		set_bit(PLATFORM_PROFILE_LOW_POWER,
>>> -			platform_profile_handler.choices);
>>> -
>>>    		err = platform_profile_register(&platform_profile_handler, NULL);
>>>    		if (err)
>>>    			return err;
>>> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
>>> index 6ae82ae86d22..e710405b581f 100644
>>> --- a/drivers/platform/x86/amd/pmf/sps.c
>>> +++ b/drivers/platform/x86/amd/pmf/sps.c
>>> @@ -387,7 +387,17 @@ static int amd_pmf_profile_set(struct device *dev,
>>>    	return 0;
>>>    }
>>> +static int amd_pmf_profile_probe(void *drvdata, unsigned long *choices)
>>> +{
>>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static const struct platform_profile_ops amd_pmf_profile_ops = {
>>> +	.probe = amd_pmf_profile_probe,
>>>    	.profile_get = amd_pmf_profile_get,
>>>    	.profile_set = amd_pmf_profile_set,
>>>    };
>>> @@ -414,11 +424,6 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>>>    	dev->pprof.dev = dev->dev;
>>>    	dev->pprof.ops = &amd_pmf_profile_ops;
>>> -	/* Setup supported modes */
>>> -	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
>>> -	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
>>> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
>>> -
>>>    	/* Create platform_profile structure and register */
>>>    	err = platform_profile_register(&dev->pprof, dev);
>>>    	if (err)
>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>> index d88860dd028b..3d77f7454953 100644
>>> --- a/drivers/platform/x86/asus-wmi.c
>>> +++ b/drivers/platform/x86/asus-wmi.c
>>> @@ -3852,7 +3852,17 @@ static int asus_wmi_platform_profile_set(struct device *dev,
>>>    	return throttle_thermal_policy_write(asus);
>>>    }
>>> +static int asus_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
>>> +{
>>> +	set_bit(PLATFORM_PROFILE_QUIET, choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
>>> +	.probe = asus_wmi_platform_profile_probe,
>>>    	.profile_get = asus_wmi_platform_profile_get,
>>>    	.profile_set = asus_wmi_platform_profile_set,
>>>    };
>>> @@ -3885,12 +3895,6 @@ static int platform_profile_setup(struct asus_wmi *asus)
>>>    	asus->platform_profile_handler.dev = dev;
>>>    	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
>>> -	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
>>> -	set_bit(PLATFORM_PROFILE_BALANCED,
>>> -		asus->platform_profile_handler.choices);
>>> -	set_bit(PLATFORM_PROFILE_PERFORMANCE,
>>> -		asus->platform_profile_handler.choices);
>>> -
>>>    	err = platform_profile_register(&asus->platform_profile_handler, asus);
>>>    	if (err == -EEXIST) {
>>>    		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
>>> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
>>> index f7a854d40575..0146d2f93be6 100644
>>> --- a/drivers/platform/x86/dell/alienware-wmi.c
>>> +++ b/drivers/platform/x86/dell/alienware-wmi.c
>>> @@ -1078,12 +1078,7 @@ static int thermal_profile_set(struct device *dev,
>>>    	return wmax_thermal_control(supported_thermal_profiles[profile]);
>>>    }
>>> -static const struct platform_profile_ops awcc_platform_profile_ops = {
>>> -	.profile_get = thermal_profile_get,
>>> -	.profile_set = thermal_profile_set,
>>> -};
>>> -
>>> -static int create_thermal_profile(struct platform_device *platform_device)
>>> +static int thermal_profile_probe(void *drvdata, unsigned long *choices)
>>>    {
>>>    	enum platform_profile_option profile;
>>>    	enum wmax_thermal_mode mode;
>>> @@ -1116,19 +1111,30 @@ static int create_thermal_profile(struct platform_device *platform_device)
>>>    		profile = wmax_mode_to_platform_profile[mode];
>>>    		supported_thermal_profiles[profile] = out_data;
>>> -		set_bit(profile, pp_handler.choices);
>>> +		set_bit(profile, choices);
>>>    	}
>>> -	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
>>> +	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
>>>    		return -ENODEV;
>>>    	if (quirks->gmode) {
>>>    		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
>>>    			WMAX_THERMAL_MODE_GMODE;
>>> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
>>> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>>    	}
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct platform_profile_ops awcc_platform_profile_ops = {
>>> +	.probe = thermal_profile_probe,
>>> +	.profile_get = thermal_profile_get,
>>> +	.profile_set = thermal_profile_set,
>>> +};
>>> +
>>> +static int create_thermal_profile(struct platform_device *platform_device)
>>> +{
>>>    	pp_handler.name = "alienware-wmi";
>>>    	pp_handler.dev = &platform_device->dev;
>>>    	pp_handler.ops = &awcc_platform_profile_ops;
>>> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
>>> index 9010a231f209..32b3be0723f8 100644
>>> --- a/drivers/platform/x86/dell/dell-pc.c
>>> +++ b/drivers/platform/x86/dell/dell-pc.c
>>> @@ -24,6 +24,7 @@
>>>    #include "dell-smbios.h"
>>>    static struct platform_device *platform_device;
>>> +static int supported_modes;
>>>    static const struct dmi_system_id dell_device_table[] __initconst = {
>>>    	{
>>> @@ -231,7 +232,22 @@ static int thermal_platform_profile_get(struct device *dev,
>>>    	return 0;
>>>    }
>>> +static int thermal_platform_profile_probe(void *drvdata, unsigned long *choices)
>>> +{
>>> +	if (supported_modes & DELL_QUIET)
>>> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
>>> +	if (supported_modes & DELL_COOL_BOTTOM)
>>> +		set_bit(PLATFORM_PROFILE_COOL, choices);
>>> +	if (supported_modes & DELL_BALANCED)
>>> +		set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +	if (supported_modes & DELL_PERFORMANCE)
>>> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static const struct platform_profile_ops dell_pc_platform_profile_ops = {
>>> +	.probe = thermal_platform_profile_probe,
>>>    	.profile_get = thermal_platform_profile_get,
>>>    	.profile_set = thermal_platform_profile_set,
>>>    };
>>> @@ -239,7 +255,6 @@ static const struct platform_profile_ops dell_pc_platform_profile_ops = {
>>>    static int thermal_init(void)
>>>    {
>>>    	int ret;
>>> -	int supported_modes;
>>>    	/* If thermal commands are not supported, exit without error */
>>>    	if (!dell_smbios_class_is_supported(CLASS_INFO))
>>> @@ -265,15 +280,6 @@ static int thermal_init(void)
>>>    	thermal_handler->dev = &platform_device->dev;
>>>    	thermal_handler->ops = &dell_pc_platform_profile_ops;
>>> -	if (supported_modes & DELL_QUIET)
>>> -		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
>>> -	if (supported_modes & DELL_COOL_BOTTOM)
>>> -		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
>>> -	if (supported_modes & DELL_BALANCED)
>>> -		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
>>> -	if (supported_modes & DELL_PERFORMANCE)
>>> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
>>> -
>>>    	/* Clean up if failed */
>>>    	ret = platform_profile_register(thermal_handler, NULL);
>>>    	if (ret)
>>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>>> index 60328b35be74..75bcd8460e7c 100644
>>> --- a/drivers/platform/x86/hp/hp-wmi.c
>>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>>> @@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct device *dev,
>>>    	return 0;
>>>    }
>>> +static int hp_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
>>> +{
>>> +	if (is_omen_thermal_profile()) {
>>> +		set_bit(PLATFORM_PROFILE_COOL, choices);
>>> +	} else if (is_victus_thermal_profile()) {
>>> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
>>> +	} else {
>>> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
>>> +		set_bit(PLATFORM_PROFILE_COOL, choices);
>>> +	}
>>> +
>>> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static int omen_powersource_event(struct notifier_block *nb,
>>>    				  unsigned long value,
>>>    				  void *data)
>>> @@ -1566,16 +1583,19 @@ static inline void omen_unregister_powersource_event_handler(void)
>>>    }
>>>    static const struct platform_profile_ops platform_profile_omen_ops = {
>>> +	.probe = hp_wmi_platform_profile_probe,
>>>    	.profile_get = platform_profile_omen_get,
>>>    	.profile_set = platform_profile_omen_set,
>>>    };
>>>    static const struct platform_profile_ops platform_profile_victus_ops = {
>>> +	.probe = hp_wmi_platform_profile_probe,
>>>    	.profile_get = platform_profile_victus_get,
>>>    	.profile_set = platform_profile_victus_set,
>>>    };
>>>    static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
>>> +	.probe = hp_wmi_platform_profile_probe,
>>>    	.profile_get = hp_wmi_platform_profile_get,
>>>    	.profile_set = hp_wmi_platform_profile_set,
>>>    };
>>> @@ -1598,8 +1618,6 @@ static int thermal_profile_setup(struct platform_device *device)
>>>    			return err;
>>>    		platform_profile_handler.ops = &platform_profile_omen_ops;
>>> -
>>> -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>>>    	} else if (is_victus_thermal_profile()) {
>>>    		err = platform_profile_victus_get_ec(&active_platform_profile);
>>>    		if (err < 0)
>>> @@ -1614,8 +1632,6 @@ static int thermal_profile_setup(struct platform_device *device)
>>>    			return err;
>>>    		platform_profile_handler.ops = &platform_profile_victus_ops;
>>> -
>>> -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>>>    	} else {
>>>    		tp = thermal_profile_get();
>>> @@ -1631,15 +1647,10 @@ static int thermal_profile_setup(struct platform_device *device)
>>>    			return err;
>>>    		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
>>> -
>>> -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>>> -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>>>    	}
>>>    	platform_profile_handler.name = "hp-wmi";
>>>    	platform_profile_handler.dev = &device->dev;
>>> -	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
>>> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
>>>    	err = platform_profile_register(&platform_profile_handler, NULL);
>>>    	if (err)
>>> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
>>> index 96e99513b0b5..050919a28d2b 100644
>>> --- a/drivers/platform/x86/ideapad-laptop.c
>>> +++ b/drivers/platform/x86/ideapad-laptop.c
>>> @@ -1023,6 +1023,15 @@ static int dytc_profile_set(struct device *dev,
>>>    	return -EINTR;
>>>    }
>>> +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
>>> +{
>>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static void dytc_profile_refresh(struct ideapad_private *priv)
>>>    {
>>>    	enum platform_profile_option profile;
>>> @@ -1064,6 +1073,7 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
>>>    };
>>>    static const struct platform_profile_ops dytc_profile_ops = {
>>> +	.probe = dytc_profile_probe,
>>>    	.profile_get = dytc_profile_get,
>>>    	.profile_set = dytc_profile_set,
>>>    };
>>> @@ -1112,11 +1122,6 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>>>    	priv->dytc->priv = priv;
>>>    	priv->dytc->pprof.ops = &dytc_profile_ops;
>>> -	/* Setup supported modes */
>>> -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
>>> -	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
>>> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
>>> -
>>>    	/* Create platform_profile structure and register */
>>>    	err = platform_profile_register(&priv->dytc->pprof, &priv->dytc);
>>>    	if (err)
>>> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
>>> index d0a8e4eebffa..06df3aae9a56 100644
>>> --- a/drivers/platform/x86/inspur_platform_profile.c
>>> +++ b/drivers/platform/x86/inspur_platform_profile.c
>>> @@ -164,7 +164,17 @@ static int inspur_platform_profile_get(struct device *dev,
>>>    	return 0;
>>>    }
>>> +static int inspur_platform_profile_probe(void *drvdata, unsigned long *choices)
>>> +{
>>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static const struct platform_profile_ops inspur_platform_profile_ops = {
>>> +	.probe = inspur_platform_profile_probe,
>>>    	.profile_get = inspur_platform_profile_get,
>>>    	.profile_set = inspur_platform_profile_set,
>>>    };
>>> @@ -184,10 +194,6 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>>>    	priv->handler.dev = &wdev->dev;
>>>    	priv->handler.ops = &inspur_platform_profile_ops;
>>> -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
>>> -	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
>>> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
>>> -
>>>    	return platform_profile_register(&priv->handler, priv);
>>>    }
>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>>> index 9978fd36a3d1..5c250867678f 100644
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -10538,7 +10538,17 @@ static int dytc_profile_set(struct device *dev,
>>>    	return err;
>>>    }
>>> +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
>>> +{
>>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static const struct platform_profile_ops dytc_profile_ops = {
>>> +	.probe = dytc_profile_probe,
>>>    	.profile_get = dytc_profile_get,
>>>    	.profile_set = dytc_profile_set,
>>>    };
>>> @@ -10584,11 +10594,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>>>    {
>>>    	int err, output;
>>> -	/* Setup supported modes */
>>> -	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
>>> -	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
>>> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dytc_profile.choices);
>>> -
>>>    	err = dytc_command(DYTC_CMD_QUERY, &output);
>>>    	if (err)
>>>    		return err;
>>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>>> index 6013c05d7b86..5ad1ab7b75e4 100644
>>> --- a/include/linux/platform_profile.h
>>> +++ b/include/linux/platform_profile.h
>>> @@ -31,6 +31,7 @@ enum platform_profile_option {
>>>    struct platform_profile_handler;
>>>    struct platform_profile_ops {
>>> +	int (*probe)(void *drvdata, unsigned long *choices);
>>>    	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
>>>    	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
>>>    };
>>


