Return-Path: <linux-acpi+bounces-10485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC009A07DE0
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEB7167CA8
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F294C222575;
	Thu,  9 Jan 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RdY1AMkk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CF221D82;
	Thu,  9 Jan 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440964; cv=fail; b=fnOeibw68otp3vyAZZ2+Gw9kZv7T16E68ywJ03Fl/LiC9FEfJ1HbCiPyukHFHxhisfZOrLSe15N0b5AAkFhfEaV23k0lyVkhPv5hGnsl7HLnNCkXuO6rQW4oy7PJnKGtdKa7cZ4XvcQltvkqVwW1MYohG9CZHiDx4Zzs7eXrrJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440964; c=relaxed/simple;
	bh=4KQ+ADpIjlbbFeMEzR0HRBZKOqiwqBfbCW8kuQIFhBA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qg0OG+xNoTA5AYIW2nGaccfvyavXHWbzCqKJoiAQUDvEn+4vwtGZO082F0GjsIEg+sndHRx7H6LZ5rFKv5y6DICaPbxwsajbsoL+nojJQZauDgfst9TjnQUY1aY3Ls6vJrAe0n2tQAVBsyZqUatBguNFuVZeRy/byBEbjXlk5y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RdY1AMkk; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrY3cimBddYQuF0ahDrySI2czyronT82lFkMEpq0vRCojuEoG2YHf9sYgXqrb3AMkTG+3aDaLo8OvXAlQpHC/bi9KWe+YeAT7ZSn0Qh4mVnSAliUhdD2F4g6W+X2k1gQTIkPjG6Zj6Db777SW+Mu+zX9A6IBmfr7ZWcAE64KbKn5GwpCT5Ybj6i2VqngUUJbEhlKEJjs2QvljxompHWpSFECcB/R+u+qhZiqydvU4GcLCYQxX01nRDoBTvctYrgVJ0i0c0hJNagdNhx1FPo2Qp7lgx8y0rCEGmwJJnCpOZYo8zRpwBNl+5KiCaRvNvpKi32nRiJBygfWWKpvbI9DIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGvxzdcvM9F53bQt0Ru+3lx+SudTYuQ2wR4ptwxjx/I=;
 b=erukv7MoTw/Zt83wKnlxe22sncnrGZWKbcEdYW25Ly9ALCE7sAUMgx6phd4RwTOT5N3QPNrrEUEHG3uUQ+TFQ1vDJU0HRsavYec7vHudkbLP4uIjBlc+mqJ63MIRnBxgfQv1rm4JsNz0ndVXtkmmmoHVcIDlVYplUNSs859S5qobDRcxs0Ti1WnxvyfnKDgyjjj+VxJKl2NaBXGmzohW1SsqVfcmyurTd45EJdjkMRlNoeP58qGiAV0Pjo/9kv76LZ53gja93iWXOF562H5hcu6ii8qkf4eB9sadNvR/BJUPEsr3ctcppk9oMjbSkVjASjFgFEfzM6gAfiT0HyybFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGvxzdcvM9F53bQt0Ru+3lx+SudTYuQ2wR4ptwxjx/I=;
 b=RdY1AMkkIguUGObciMvhRjNs5fbQIbaM8/T26V1SWfv9sF9BeXgNQhCdp3QxGVxEF+oahbSvKyCidRrp0prZt46BfCvCXFpW9izw5OT7F01tDo6nHXrcKh+lB4bYI7mBEXWDC5qSPax+KazCUgkJGMklOl8ZT+RBecQ1vro5ATI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:42:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:42:38 +0000
Message-ID: <973ec8c8-3c87-4f4b-bf40-cf04f8429882@amd.com>
Date: Thu, 9 Jan 2025 10:42:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] ACPI: platform_profile: Clean
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
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-18-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-18-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:802:20::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: ed37e2be-30a1-4b78-419e-08dd30cca0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFpvSDdDTGtwbnQrcGVRbFdYL3Roem1NcGtkUnhvQWVVNVNlVGt6Sm56Z3FU?=
 =?utf-8?B?N29PUnJlenFQVlFSUjNxVTZRVDR5cE0vaThaT1Y2TTFRSFJOR3QvQUhXeFNi?=
 =?utf-8?B?dWo1dkd3RGxKbmZrQ1ppYU5iaU8wUHNFRzFIOUg2Qk5NeGRxMXFiZkdzc0RE?=
 =?utf-8?B?WjB1aG5uRnJjcmQwVFNnc21DYlN3YXU3RnFOWDFQLzRjZ0laQjM5WWtaMEV6?=
 =?utf-8?B?bTkzc1NFdTZ2ZGtGbkFEWDFQUVMrazVjSml0WWNTV3c5M25hNWNpUWlEeWFQ?=
 =?utf-8?B?MEtiMVVLNE9xUGYzb0V2KzNSR29UOFAxUTlnNyt3UjlIKzdTOWtWM2hUcE5i?=
 =?utf-8?B?U3hWc1Y1Wkgyd0dDWWVHM2pSa3NoU3ZQTDFvUUR1clVUV3pqSmVmN2orQnpK?=
 =?utf-8?B?OE1BcDZ5OG5pU2NQYVNRRE56ZWlVVlJjS3VjZ3ZjS0ZVSG1MenNuYWJ0aWZW?=
 =?utf-8?B?M3hiTzhGUGdQNmpBR1JabGRrOXFyNnoyUTA3TUNLdFBSbTQyZldxUzFIdFJy?=
 =?utf-8?B?MXhOTTBjUXpzZ1lLeWFuMEFhSHFObU13dGxhSFI5TlB6L2dZTFlNc3E3bW5U?=
 =?utf-8?B?aWxnUDJKY0J5bWhsbWFVUytWSS94UDJVcDlwelZxRmI3T0x4N0trQURVdVdv?=
 =?utf-8?B?eVQ5M3JZN0R2dGxLaHZQUE01TzRQWmtXU2pJbTVhOFg1a21rRlhBUVozNnB5?=
 =?utf-8?B?S2xxS29QcTY1RkRpV1gvdlJzUWE2enJRbTZHWHM0dGFZdzRHTlZ4WVRraW9p?=
 =?utf-8?B?WmJFMy8vMklZb1VsZ3B2U01xbU5TYUxSUmxBb2xrVjdhenhIWTgxdEJmNXNK?=
 =?utf-8?B?Wk5xS0FYSHZURzh3aVZMQkZwWmNwaEZueVFVTnljQ01VS1FDZE5OeDJGanMr?=
 =?utf-8?B?cmNESVRSaWRLYml1TG9vcHVYejVSaVRMd09PanBzNnZ3alA0Sm1PeVlpbkxB?=
 =?utf-8?B?eS9RUFJUQURCRGJ4bE1zRjh1a283V2R0K3VFVHdYUUJXSVBZWHh0NFVIL1l4?=
 =?utf-8?B?eEd2anRzdC91dE4rSFo1NzRWQVpNWlR1UXhxVmV0ZGlKUVRxT2toNTNLYjdu?=
 =?utf-8?B?OUdWNzY4S3d4Q201VGpEUkJFd3FtTnBsckRpSXBHWWk0em5wYlpORGhhZUVI?=
 =?utf-8?B?ZUxnKzUrUTExZFBGZlNWYm9QWjNpQU5xZnVzY2RyeEtKaWczT2cyRG5GZXQ5?=
 =?utf-8?B?eWo3eW81YWpFcU55SlVrQ2ZHVFQ1RisrL0pTeXhkZjdaVEhIQTBuWWpQNUhj?=
 =?utf-8?B?MzZrZ0NobEhsWWpwYlM3WDZ1SnQyL0xWaWFHVEI0YmI5eU40TWFkUzhJRC9R?=
 =?utf-8?B?M08wSml1d3FoM0RMZFBYd0Zrc1hjN3poUXZ2akhDdGphM2YzNGcxdExGeUFm?=
 =?utf-8?B?b24rbmtNWEIzcmc4RFVvdE8xMGMwQjFDZlllbEFjZENYU29sM1BxbldNL1NK?=
 =?utf-8?B?VTIzVlZnWE9HM3lFOTEyNmNyL3l3bHlkRFowTWs0TWtqSG96b1c5Y29xS2lz?=
 =?utf-8?B?T1BEZjNCZ3p1MFdoa21jYmpYNDY4MlBWUTBDTXJHaCtDNzU4QnpzRVFybGl1?=
 =?utf-8?B?ZnhZQWxmVTZiU1Via2Nib1BPaGRKZ0tTbTN0cFozVkM5QlBzNkY2aVNubjM0?=
 =?utf-8?B?QkgxUzFsQnAzWFp0cVNabE00KzZvSUVZaENhTmFIM3N3RFZNNXQ3Vm5tQXdi?=
 =?utf-8?B?ZEVGMi94dkJvVjZteUZtVXpDdlhPSUNpWmExUkpnMjJxWWlESDFTTE5QYUph?=
 =?utf-8?B?NTdMMXA4Z1ZXb0ZmU2g5cVpVTFdMY1lJT1FMalVLejNMVHVjVDdmajZGVklZ?=
 =?utf-8?B?eUdZU0ZHaVhXSCtQd0wxcWIvMTJ2MFk4QkN3cTVsUWkwNDdkQUprekxtd21K?=
 =?utf-8?Q?1qkNavlpXNwDV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFF5MFh5Zll0WWFDd0dPbWl6Y2hIYUthb3FhOXZvZzB6MWtTdzRsc1VoNkJ5?=
 =?utf-8?B?cXhyU2hUTmdWSnIxUmpwV0FoTXFrOUFkVEdZbjJZQTliWlFZYlMxYXY5MnY2?=
 =?utf-8?B?bUNvdnRVS2piVlFKYUFyV2krRnk3bFdKV0RBY20rellWRDc0MW1DT0p5ZTVv?=
 =?utf-8?B?bGpSajJPdGpPZnFlRkJNcGtMdy93YXdZTnZHaUFLMlpBV1N3L0VlT2grdHBB?=
 =?utf-8?B?VWxsbTlpckcxcDBNZ2dIa2Y1WHJEVWlCaUdXZ2oyNEhTMHZKVXlSeUZlWUVH?=
 =?utf-8?B?R0VjYTNJVkY3T1JFZCt1blZxTEVKT1pRRmFiZm9SYkZuQTVQNVcvUlEzaHdM?=
 =?utf-8?B?OFdNVlpQVWl6SnBmQjlDWFRtVWNkeXJyV1dVeDhJcmJpV05TM0R2eThLTm1p?=
 =?utf-8?B?dnAyaitsRWo4SW1wYVhSbUpjME0vKy9jRDMzdHM4QTNuTSs0clZsUUdseWZX?=
 =?utf-8?B?S1BodmMzeXRXaFBnSXFobmh2dURTcjdyRlptZzNxR3QwcVJIdC9FZklJbUda?=
 =?utf-8?B?b2gwRTdUQjZyczJmaVFlSnlOK0ZIRGg5UDVsYnpZNThaT1FzeWp4dUVnTEdk?=
 =?utf-8?B?K0U0bzdpd2lJbmlVNkFiUjRPOWU1M3o4eGdTUUR1TmtIQjJwc3RIeGpJT1pn?=
 =?utf-8?B?MXdDZmZjZDBiWmFyS2tRL0hiR1lWT1BiVFhBMnlNNC9EdHYydkVBb2x0QXlr?=
 =?utf-8?B?WTFUZkk3OXpDbXRIQVg1bHZZbG40YzRYRWttdjJqc3dFbXlaZzNuV3lMYnJx?=
 =?utf-8?B?VDgxa2paMFBLbXlXMFEzYkJHaHZnSHhlS1VIenlTbXQ4VjdSdmxDR3ZMNnJL?=
 =?utf-8?B?dFpCUDQvR0ozTU5xdlJYb0pBcDJhL3hYdU1hVU90cHdPWlpnSUE5cHdiMHNF?=
 =?utf-8?B?QXJIejI1WDBzS2tlUEpjdjEwK1hGdUFsR0Uva3hHblBwOWhLcnQ2SGtjZGFP?=
 =?utf-8?B?dHlKTlU0dzJBWDhUeXZYVmpZaW9LTXhVemdqMk8ySzhmNEtGQUM0NWpWeUVw?=
 =?utf-8?B?b1lyUGhNYXJydmJid2lTbzRmZVZORVozWEZaRUFKUGZBOWQwamJkT3NnUmtD?=
 =?utf-8?B?UWlSSll4MDJQVzVwZ2FBTnpFenpkTVFFLzJtczZXeDlFYUpjc09taHozY0ly?=
 =?utf-8?B?ODB4RDFqQ1BaZEplMnF6ait6MkZORXpTclVWd0g0TVRUVmM1OTdJU1NqQ21l?=
 =?utf-8?B?ZjJIUUlZVkZFelVoTW91K0M5R1VhNVlVZmxCdUF5bEFFWlNtdTVEcEZXckpD?=
 =?utf-8?B?WlhmaTlwZ1I1bC9lNnRNSTVSbTVUVWJCQ3FHUW93eHJGVjZ3cERpd2ZyTito?=
 =?utf-8?B?MW1NTXlyN2dBd1J4bjBvSC93a1FUS2E3RDBjRndSRjNMazRLdksvVlNLMG5V?=
 =?utf-8?B?NUF1OHhPQko4VE1KekN4NGl3ZWRJb09oOG9IMEhKd09MdmVHYzNUT1dZVVJQ?=
 =?utf-8?B?ODhvRkhRZzlRL2NjdEtQcmM3ZUdxUC9PRlVPcG93MEprc1hFRStwdUZzTWlx?=
 =?utf-8?B?L1Awa0VPVi9VOElSV2crK3ZkNzF6aGxmY1B0M29yQ2FPZTZjcnhubmwvbWpu?=
 =?utf-8?B?WUFyZ0lhTzRrL3BNNDFCc2NHWk5IZklLaG1Cc1dEVVNRWGUrR1liOUdVYVpY?=
 =?utf-8?B?Qmo3YmI4bkhwamV1cFpyN0poV2l0bUNPemxKck1WQUdQbmc4WWp0UXFDMVVu?=
 =?utf-8?B?SWVqbHZsUTVITHFkQzZrTnBMSnFNTGl4N2V3cXc5NnhNdEltV2ExMnV1N2lO?=
 =?utf-8?B?RDRtVGluQitxTVg1RWNEYk9ZaUV3WGpXaW5QNThkbkNBM3VlRkgxNUhhcWlJ?=
 =?utf-8?B?YlBXajhSYWtNQUcyRkR5QzIzMzgxaHFHVjJud1hqMXgzOTVnYmphMnhIM1V2?=
 =?utf-8?B?bFF1RVVPWTF0Q0RDY1h0b0VrMlpJRHNIdTFvalk3L2JDK052YmpicTMxSXQw?=
 =?utf-8?B?ZTVvSmM4SFppcCtQUkVxYU1ab3hDNXYvdXJOT1dMY1dQM3FjUW81ZXZiei9E?=
 =?utf-8?B?bnMxWUwyQ1JhOWJCWXdJZVJSUERvb1lCTE1SYjV0ZmZEL1ZjeWp0S1NyUnRJ?=
 =?utf-8?B?Q0U1MjZ3SCtSU1FKNjV6SkhkYktwQnlVWUtOM0prZVM3VS9RaWdkZmU5T3ht?=
 =?utf-8?Q?HEYQ35wTuYmU8sbWbqwLnhgjj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed37e2be-30a1-4b78-419e-08dd30cca0c7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:42:38.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSRIYuyYkg5vPdwrv2lg+lK0lmiswQmhKSFbiGnPxHWnh3OYV0GDVjAS+rlysofobrDAzd9+hUaW4+oSO3J6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

On 1/9/2025 09:06, Kurt Borja wrote:
> Remove parent device *dev from platform_profile_handler, as it's no
> longer accessed directly. Rename class_dev -> dev.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index c7a867bd01df..8c79ecab8a6d 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -11,14 +11,13 @@
>   #include <linux/platform_profile.h>
>   #include <linux/sysfs.h>
>   
> -#define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, class_dev))
> +#define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, dev))
>   
>   static DEFINE_MUTEX(profile_lock);
>   
>   struct platform_profile_handler {
>   	const char *name;
> -	struct device *dev;
> -	struct device class_dev;
> +	struct device dev;
>   	int minor;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>   	const struct platform_profile_ops *ops;
> @@ -91,8 +90,8 @@ static int _notify_class_profile(struct device *dev, void *data)
>   	struct platform_profile_handler *handler = to_pprof_handler(dev);
>   
>   	lockdep_assert_held(&profile_lock);
> -	sysfs_notify(&handler->class_dev.kobj, NULL, "profile");
> -	kobject_uevent(&handler->class_dev.kobj, KOBJ_CHANGE);
> +	sysfs_notify(&handler->dev.kobj, NULL, "profile");
> +	kobject_uevent(&handler->dev.kobj, KOBJ_CHANGE);
>   
>   	return 0;
>   }
> @@ -518,18 +517,18 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>   	pprof->name = name;
>   	pprof->ops = ops;
>   	pprof->minor = minor;
> -	pprof->class_dev.class = &platform_profile_class;
> -	pprof->class_dev.parent = dev;
> -	dev_set_drvdata(&pprof->class_dev, drvdata);
> -	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
> -	err = device_register(&pprof->class_dev);
> +	pprof->dev.class = &platform_profile_class;
> +	pprof->dev.parent = dev;
> +	dev_set_drvdata(&pprof->dev, drvdata);
> +	dev_set_name(&pprof->dev, "platform-profile-%d", pprof->minor);
> +	err = device_register(&pprof->dev);
>   	if (err) {
> -		put_device(&no_free_ptr(pprof)->class_dev);
> +		put_device(&no_free_ptr(pprof)->dev);
>   		goto cleanup_ida;
>   	}
>   
>   	/* After this point, device_unregister will free pprof on error */
> -	ppdev = &no_free_ptr(pprof)->class_dev;
> +	ppdev = &no_free_ptr(pprof)->dev;
>   
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   
> @@ -556,7 +555,7 @@ int platform_profile_remove(struct device *dev)
>   	guard(mutex)(&profile_lock);
>   
>   	id = pprof->minor;
> -	device_unregister(&pprof->class_dev);
> +	device_unregister(&pprof->dev);
>   	ida_free(&platform_profile_ida, id);
>   
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");


