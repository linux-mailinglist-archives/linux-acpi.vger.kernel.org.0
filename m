Return-Path: <linux-acpi+bounces-9212-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2090A9B85C8
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 22:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4764280CA3
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F81CC15C;
	Thu, 31 Oct 2024 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rkbyELai"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FE1C8FD2;
	Thu, 31 Oct 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411707; cv=fail; b=Eop/8MOBU7E94c/13iWzmIMm14qUKX/WnGJRD1nKgE8BzHRelwq6WyFuMUd7fMWymmUubNdc8NI6PlB7yEp9t3zQ9cnOcU8DRE5VMqh+VzNWkHcG3ULFtYq/SwXqncz571t/JxaQdF/9L2PugVFj0ZepiRH1ITxU373MC7yf4n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411707; c=relaxed/simple;
	bh=uqUhs5jqTHhzNOVrEfdfFCWLExT/qQcmNjaUWOyV4KQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kfzJRkipJ+LAt30qJmcFmBot/i7XUHxppCBWmeMuiVR3NS6saYW6XDmp5xJgvo2Na/2kf+9cf4mtllaNO33V61MC+oFVvJO897b9EyFE9C4+IfQXNed8ReL+sQqt1o1ubzw53YKMojtqz7yK4QCA+2rGGXK03glu2nyKMOUwbX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rkbyELai; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3VM/dYElsHu7XpRSTW+vOaL35DuACbcU2ZnJ5xN0IfEWI+c6UBwjrrWFXA4eC+iZhNa7wlfDoYkmgNwHkqZM5iAvtKWkIGYPwJjyZsJ1H28gSITU47nVzY1Qh1Z/8+qAukoXajUi6kCKHSKmOhErLgLh/C6Pf4IGnNBAeehooQ/jNRHiv7+GdPG2PDI8bfJfGYvAAuy25rU3soAxhGe/VO3H3FoyKFbuXGI+vQ63LKEn8OhBz0w7E3YKbMd5n3H3sHK/6fXUBxAnIzoYR21QxdstXxwRMQVftnhCf0Ao4A4hWbUf3DWxaH3SZOqTCAICqf8TaEXrSp1uUmH0t7JyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7/zT/17oeb2o/GX5pDiFJM2AfF7wKAwa58ZM1G7BDA=;
 b=Hvax2OM0HCei8wPJiDoD36aJUcKWz5KzCYrwQ8QXhKEGVegwlZxdLWQDpj0+Hef/137Fj1qqypfFRJ1GcfsM7qO7pQ8w55bsHIiMYFaCDdf1TWYbwdSuU7FMiNAM/bdxIxnpWskJLMt4e2L26nhjD2X5WZFqxH76YUL6n0QroFO6pe+yTrxUwSMJ/soKFscJnGMKZ9UYCR53oMpPd1Q1TzrmIrvmTnlONxeRIvieNAJFaBNbWbTvHN4R/v468YzYy3XGPDSM1BBUMMicnyIwRMyTws/90axA0P9pPCb50jgfTSsQRxNnKTTU7hU2QIxK+4pRpP6yqTFRZSUdFeqJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7/zT/17oeb2o/GX5pDiFJM2AfF7wKAwa58ZM1G7BDA=;
 b=rkbyELaii71dw9jGJHqddyOeKzDiXugSYFiPi9mcVX2fZAFRdvayPoWY7FEJ5GSeYrhD/IkLEivRfEJq9ilByg0W7w+RHCg6bZykY7QJXSQberSNDCz9sqwrw7cZF/KlilDLg+jQV79oSgXqpV1I1lMmgHWq1yk1s6+Of04chdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 21:54:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 21:54:55 +0000
Message-ID: <d9a19f6f-59bc-4ed0-8f9f-8a4fca195d80@amd.com>
Date: Thu, 31 Oct 2024 16:54:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/22] ACPI: platform_profile: Register class device
 for platform profile handlers
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
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-21-mario.limonciello@amd.com>
 <9fdcfdb4-bbdd-4f6a-9a69-73dceac7b14b@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9fdcfdb4-bbdd-4f6a-9a69-73dceac7b14b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0186.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 63dca7e2-04ff-42ed-3307-08dcf9f6a799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW0xcWlCVzdkbThYZmFtVm5NRkd0NHRTNzdrMTA5alVBWU5BNTNlZTJHQjkw?=
 =?utf-8?B?MXRITUxCVUVKWi9xZUJITlFvd1hkeGNGRmNiM29kb2NLUVZYNE9MZlVnNzVD?=
 =?utf-8?B?aUtVM0lhOVJLU0x6THdkNEVFdmlQaTJCRVpCNWNmaUVkMzVpaVUrcTI4blBz?=
 =?utf-8?B?enE5UkRiRlRnYThIOURvUDdQSWF3MzlKNW5SSHdvcHlZVzhoSFZiWlllMnpq?=
 =?utf-8?B?OHVEWGduU0k5dXd4Q09qNDRzbG1FSVRRVks3ZXlPMmJwMjVYSmw5SCtjQ3ht?=
 =?utf-8?B?b0dMd0VxcEFuRk0rVHhXM0liOGxZNStPSmxxclhBWjNEYzZ5bGtBU01kRCsx?=
 =?utf-8?B?STR1ci9MT1ZJbTZjTWRXOUhRbEhsTnJMWlRRSm54VS9aYmtzQTBRV1ZGbHJr?=
 =?utf-8?B?WURSOUhPV1lNSDl1dFhRN1ZoeWxrcGpsUzRpM0xiRzZlWm9vMW1XMDNTZGg2?=
 =?utf-8?B?NkVEMk03M0g2T2R4RWVTM2lJL2VNeFNSdHQ0dEJKNzhXQ1k2YjN5Y1l6bzhQ?=
 =?utf-8?B?MEhJbDVhNE82YjkvdXZPbFNDdktsVHM1empaaHNWcmQ5SDd5WDZmS1lSLy91?=
 =?utf-8?B?OTRpbkdYcnVOVE54WUJxRnYxV3FuSnI3L3FjcUFNYVhLNVc0TmI2bXh5bll1?=
 =?utf-8?B?MXRrQ0NITGdKeTEzVktOb0ovV0F1NDJDdlVyZGdIS0E5N3FNS3N0NWFGNExN?=
 =?utf-8?B?cGFSbUo5KzZEMTl1NThsSnZyaTFQa2NycnBibFQrZGVPTHVlRW53a1dwdmZH?=
 =?utf-8?B?RWNPSzJaQnZKL0srcmVNTDh3T0g0bno1MmxEanZDeUpLbkJkbnJYY3NWNlVM?=
 =?utf-8?B?dWZYM2UxWStubDB5WlhoR0s2bkZ2Z0dnV29TdnpZWHhMYU1pbFNTbksyOExK?=
 =?utf-8?B?NEJ6eXV1TmF0NXkzOFE0WjZkZWpzYW5jbWtxeVFibU5Xd2NHTjN1OW0zdE5r?=
 =?utf-8?B?bTNRSDJSLzFnOTBwdFBDRkFMUlhzZG4wZEk0N0dBSmZ1eGtmRjFiNjhWMjFJ?=
 =?utf-8?B?eXprZWdENG9QemZZQ0VDRlFJWjlwUCtFR2I3WGYwYjY1TlNqL1FkbmJTNkgr?=
 =?utf-8?B?Slo2bUQrNFJabWxSV1RGd0JSR2t1R0pqTHpxTEVYY285SnZ4dUFnSFdSeHYv?=
 =?utf-8?B?NEFhT2Z5MWx5U3NadTEzN1Y4czRDR0h5SmJjREZMUnI1SEpScFJRTHFNYWZF?=
 =?utf-8?B?bmJDUnFsUFZjN1FWWHluZE5xNFFxaWhYd0w0cGQwYTd1a3l1VndVYk9ZNlBX?=
 =?utf-8?B?dE5wbjlCUzJ6MUtZVXUrNE03bytmUHFXNVVsaHNueVhDdElUS25ibmR3dmU0?=
 =?utf-8?B?WENXdTB6RnhoOEozdXhFcnNnQWQ0TVR3QmVQLzBwSUV0blhqb2huaWN4UExZ?=
 =?utf-8?B?dncrMkpJQmoyRWFNNGdXYzNVRXFDeGJ2VnpaMzE2b2FEclZpMVF3YlJyWDcv?=
 =?utf-8?B?Rk1sVG9WQVB0MitHeXBPc25PaGJ5MmdvamtzamxudTBjUmZDT0ZWWTd4Vlg5?=
 =?utf-8?B?Tmg1VGpISit0TnEwQWo5UkgxZ1BTS0Q4elBybWtzOC9UcjNKYlptY1RHcnBE?=
 =?utf-8?B?U2hVSGNvM3FuUnFXcW1nMDd5eWNneHZhUGIwM1Q4QnRzbDZlSjNTaU9hU0Qr?=
 =?utf-8?B?eXhWd1lrUG45aFE2YytNZi9BRGUxckVlbUpQS05NTXU4NklNNGlPcUJCZFpM?=
 =?utf-8?B?RU1uNTJ4YnpjeHk0S3pzQjF0bkVIaXRSTTNIeTZqN3pjcGN5UmU3VSs0OTJk?=
 =?utf-8?Q?nV/GOPlvJ/LXp/VuN/vIrmHwMojzQKKR+2xeAq0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTFDTmpyUVFvcmpVSkJPdDNaR0hrVXNNSFBkK09Tek9DUFdyc3JMeGtUZ3dJ?=
 =?utf-8?B?RWk2cFBsM2pMbmtaTFlDRTlOb1ExeXNCYlNMUG85K2tYczZUSS92NUIrQm8v?=
 =?utf-8?B?cWVSYmtwQi92cmhxZzVBZGp3YzZEZkkyTkh3cXpyRDFmM0QzZXNFZEFRanJN?=
 =?utf-8?B?VDE4V1BIYVhHNHkyUDhrUEY4SkY3eDhmeG55dVJFRmd5YktIZlB2elRtUzlX?=
 =?utf-8?B?MjhNMGVkT2N0NTFjQUQwQ3lZQzF6c2Y2aUtkSlk3WVdwaXJFVHVtcUNIdzRN?=
 =?utf-8?B?eWx4U0hHMlVHSGdQMk9pOVBNNXN0bmd2S0Q4T1NMNDZFeUZmOHQ5b2c0dSt5?=
 =?utf-8?B?OStBVDE1OHFXblhzM2hTanJ1UlhtZU5GYjdqMGhFVThHNVNHSGdQTk9XelhN?=
 =?utf-8?B?VDFOS2doWjF2WjRaQnRPc3NBMXVrZ095T0pla2NPQi9PeVNLR0IwYXM2NjIy?=
 =?utf-8?B?OFZ0Tk9aZ3FWWFRhZlR0OU5La0VJR1NyeUVtT0hSbS9FenNtQTdscnlDeG1B?=
 =?utf-8?B?WHlJN0ZySXR3N2ZpTFMwemgvRzRRTDNTeitaOERWeG9qcTN6YmxQSmd4czFQ?=
 =?utf-8?B?Z3VPNUpldDljVkVFaVdZQXVYdFZ4TEpkS1dYYS9lUnd4dHArWi9UczdpcmVX?=
 =?utf-8?B?WlZYSFRSc2lGSUZmbmFadTExUEROS1JNcG9aUno4ck43Qys5UEIveHNFbmJ6?=
 =?utf-8?B?THV4SzcyVmNxZDJmazNiN0RPUFBHTlJYRHhNSHNaMUhKMFJGZnA0NmxpME9t?=
 =?utf-8?B?WEc4N1lKcW5QZlluVHFPYkE0MUw4MTdGY2t0eGdESGdvMi9LdUxmMXB2MnB3?=
 =?utf-8?B?MFJpQXdFaUZwVEdDZktwV0pmbFJ5R294L29vT2REQW9FOEcwUmZuNUZzREhS?=
 =?utf-8?B?QTVRV2YzWm5DYjFjRlJtcE5UZ2FjYUtDWmF0R1phOUJtWHN2WExQVHZBZHVn?=
 =?utf-8?B?bWlFZC9wSnB2Y2VGcXFWUEY5WERFcG05UjBZczh5VHdoUkQ0K2ZoalJ4cVl6?=
 =?utf-8?B?WFptRHRrcFRwZ3BCQ1czRzJ6MXNFTkQvd3BiU3Q4UnFIWGJNTXB0djNjUEJv?=
 =?utf-8?B?U0lPRmpudi9vaG1GRnBhSXk1U3FiR09EbVVmZk9HK0RWckJ1c2xySXQwaUlQ?=
 =?utf-8?B?TE1JU3k4MmxhQ0tHdmJ4Njc4M3U3cFM4WDJIZCsvcHN5S3RBaUtabTdvdTFl?=
 =?utf-8?B?TGdmZy9tS2V5UTZNcVFNSEpxd3BXWlB3Zld6NCtBTDgySGxzNCt4Tk5FbFNj?=
 =?utf-8?B?TnFzNFd1YkZIVWhuWVNYTDREU2FreitSemY0d20zdVlFWmI2TEhQdURWcU9y?=
 =?utf-8?B?Q0MvNEMwd2lubU9tWndnWGhiek81S2oySXJlS1I5WTZzSzFFcTVBUS9kK09K?=
 =?utf-8?B?NTRwMXBIRlRidmFUYW1JTmdlQlAvSkNMV2NvTWVkNlVnT0hrU0dMaWg4Skhw?=
 =?utf-8?B?VzBLemk3alpkSm81bytNNndxRllLTDY2YmY4aDFHdUlCbnpWNkFCbFBWK3g1?=
 =?utf-8?B?TndlQUJYdTJpdzBHR2FTWEJJWDlWL2hXNk5yYWIyQmxZcmg1V3NpS2lsME54?=
 =?utf-8?B?aTh3MHBnMzFzNVJ5NlNXUHpjV3lEdnY0NTVMM0dYN0cwOGtRSjFqZ1J5bkEw?=
 =?utf-8?B?R2U4RndGWS9pRW9DNyt1OHNDTE0yeWNqdXFoNXBQaFgwaUwyZmdpTi9sVFpD?=
 =?utf-8?B?NWtFdVpQQVBPUWJwam5zSS9xUVIySEk3MDM5S3BLN1VkSjcrUGRNQ1ZKUEVD?=
 =?utf-8?B?ZFRpNzFMNEhOdUl4c2ZXckcyV0NyNnRlcEVYamV3WUEyams4c2pBa0pWTW5U?=
 =?utf-8?B?d09zQ0VFRjlGdTBNd0IyeG03R0xzYkFTdHBqSkJtS09EenVyVjRWOHd0YU1n?=
 =?utf-8?B?UmlWUk9GU3NqL0p3bkwrS0FxUEZwZlRJWGZac0w3ZEFWazlsRWk0aVl1TEdz?=
 =?utf-8?B?Qzh6Q0JoRHE0WU94YjVubjlYbjc4M3c4YVQrL0h1ZFNrTXF4dko0azMrZ1pO?=
 =?utf-8?B?ZHU2VE9aS1lubkkzTUU3Z0RleWxFWkF1N2ZXbmhnaGNaSitFdEI2aFBiQWhI?=
 =?utf-8?B?Y2pzZmRxSloydVdmcmJLV2t5Vk1VYllQU0dJK0NWYzRNMHVRZS9SWlFUNGRZ?=
 =?utf-8?Q?q3twQ7PIb2Xd/mGvHJSQXnJOJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dca7e2-04ff-42ed-3307-08dcf9f6a799
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 21:54:55.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpttX1YxnC1WFvcav60WPscskrUmjZrjO5vxizRaE/Z+Mu2d7xk2d7IOSgSnjQfFrjc0a/UE9RimSYOzBSKBBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605

On 10/31/2024 15:55, Armin Wolf wrote:
> Am 31.10.24 um 05:09 schrieb Mario Limonciello:
> 
>> The "platform_profile" class device has the exact same semantics as the
>> platform profile files in /sys/firmware/acpi/ but it reflects values only
>> present for a single platform profile handler.
>>
>> The expectation is that legacy userspace can change the profile for all
>> handlers in /sys/firmware/acpi/platform_profile and can change it for
>> individual handlers by /sys/class/platform_profile/*.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c  | 93 ++++++++++++++++++++++++++++----
>>   include/linux/platform_profile.h |  2 +
>>   2 files changed, 85 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index 9b681884ae324..1cc8182930dde 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -24,13 +24,24 @@ static const char * const profile_names[] = {
>>   };
>>   static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>>
>> +static DEFINE_IDR(platform_profile_minor_idr);
>> +
>> +static const struct class platform_profile_class = {
>> +    .name = "platform-profile",
>> +};
>> +
>>   static bool platform_profile_is_registered(void)
>>   {
>>       lockdep_assert_held(&profile_lock);
>>       return !list_empty(&platform_profile_handler_list);
>>   }
>>
>> -static unsigned long platform_profile_get_choices(void)
>> +static bool platform_profile_is_class_device(struct device *dev)
>> +{
>> +    return dev && dev->class == &platform_profile_class;
>> +}
>> +
>> +static unsigned long platform_profile_get_choices(struct device *dev)
>>   {
>>       struct platform_profile_handler *handler;
>>       unsigned long aggregate = 0;
>> @@ -40,6 +51,9 @@ static unsigned long platform_profile_get_choices(void)
>>       list_for_each_entry(handler, &platform_profile_handler_list, 
>> list) {
>>           unsigned long individual = 0;
>>
>> +        /* if called from a class attribute then only match that one */
>> +        if (platform_profile_is_class_device(dev) && handler->dev != 
>> dev->parent)
>> +            continue;
> 
> I do not like how the sysfs attributes for the platform-profile class 
> are handled:
> 
> 1. We should use .dev_groups instead of manually registering the sysfs 
> attributes.
> 2. Can we name the sysfs attributes for the class a bit differently 
> ("profile_choices" and "profile")
>     and use separate store/show functions for those?

Sure.

> 3. Why do we still need platform_profile_handler_list?

The main reason for the list is for iteration and checking if it's empty.
I guess class_for_each_device() could serve the same purpose, but this 
patch probably needs to be way earlier in the series then.

> 
> This would allow us to get rid of platform_profile_is_class_device().
> 
>>           for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
>>               individual |= BIT(i);
>>           if (!aggregate)
>> @@ -51,7 +65,7 @@ static unsigned long platform_profile_get_choices(void)
>>       return aggregate;
>>   }
>>
>> -static int platform_profile_get_active(enum platform_profile_option 
>> *profile)
>> +static int platform_profile_get_active(struct device *dev, enum 
>> platform_profile_option *profile)
>>   {
>>       struct platform_profile_handler *handler;
>>       enum platform_profile_option active = PLATFORM_PROFILE_LAST;
>> @@ -60,6 +74,8 @@ static int platform_profile_get_active(enum 
>> platform_profile_option *profile)
>>
>>       lockdep_assert_held(&profile_lock);
>>       list_for_each_entry(handler, &platform_profile_handler_list, 
>> list) {
>> +        if (platform_profile_is_class_device(dev) && handler->dev != 
>> dev->parent)
>> +            continue;
>>           err = handler->profile_get(handler, &val);
>>           if (err) {
>>               pr_err("Failed to get profile for handler %s\n", 
>> handler->name);
>> @@ -69,6 +85,10 @@ static int platform_profile_get_active(enum 
>> platform_profile_option *profile)
>>           if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
>>               return -EINVAL;
>>
>> +        /*
>> +         * If the profiles are different for class devices then this 
>> must
>> +         * show "custom" to legacy sysfs interface
>> +         */
>>           if (active != val && active != PLATFORM_PROFILE_LAST) {
>>               *profile = PLATFORM_PROFILE_CUSTOM;
>>               return 0;
>> @@ -90,7 +110,7 @@ static ssize_t platform_profile_choices_show(struct 
>> device *dev,
>>       int i;
>>
>>       scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
>> -        choices = platform_profile_get_choices();
>> +        choices = platform_profile_get_choices(dev);
>>
>>       for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
>>           if (len == 0)
>> @@ -113,7 +133,7 @@ static ssize_t platform_profile_show(struct device 
>> *dev,
>>       scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>           if (!platform_profile_is_registered())
>>               return -ENODEV;
>> -        err = platform_profile_get_active(&profile);
>> +        err = platform_profile_get_active(dev, &profile);
>>           if (err)
>>               return err;
>>       }
>> @@ -138,12 +158,22 @@ static ssize_t platform_profile_store(struct 
>> device *dev,
>>           if (!platform_profile_is_registered())
>>               return -ENODEV;
>>
>> -        /* Check that all handlers support this profile choice */
>> -        choices = platform_profile_get_choices();
>> +        /* don't allow setting custom to legacy sysfs interface */
>> +        if (!platform_profile_is_class_device(dev) &&
>> +             i == PLATFORM_PROFILE_CUSTOM) {
>> +            pr_warn("Custom profile not supported for legacy sysfs 
>> interface\n");
>> +            return -EINVAL;
>> +        }
>> +
>> +        /* Check that applicable handlers support this profile choice */
>> +        choices = platform_profile_get_choices(dev);
>>           if (!test_bit(i, &choices))
>>               return -EOPNOTSUPP;
>>
>>           list_for_each_entry(handler, &platform_profile_handler_list, 
>> list) {
>> +            if (platform_profile_is_class_device(dev) &&
>> +                handler->dev != dev->parent)
>> +                continue;
>>               err = handler->profile_set(handler, i);
>>               if (err) {
>>                   pr_err("Failed to set profile for handler %s\n", 
>> handler->name);
>> @@ -152,6 +182,9 @@ static ssize_t platform_profile_store(struct 
>> device *dev,
>>           }
>>           if (err) {
>>               list_for_each_entry_continue_reverse(handler, 
>> &platform_profile_handler_list, list) {
>> +                if (platform_profile_is_class_device(dev) &&
>> +                    handler->dev != dev->parent)
>> +                    continue;
>>                   if (handler->profile_set(handler, 
>> PLATFORM_PROFILE_BALANCED))
>>                       pr_err("Failed to revert profile for handler %s\n",
>>                              handler->name);
>> @@ -194,11 +227,11 @@ int platform_profile_cycle(void)
>>       int err;
>>
>>       scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> -        err = platform_profile_get_active(&profile);
>> +        err = platform_profile_get_active(NULL, &profile);
>>           if (err)
>>               return err;
>>
>> -        choices = platform_profile_get_choices();
>> +        choices = platform_profile_get_choices(NULL);
>>
>>           next = find_next_bit_wrap(&choices,
>>                         PLATFORM_PROFILE_LAST,
>> @@ -228,6 +261,7 @@ EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>
>>   int platform_profile_register(struct platform_profile_handler *pprof)
>>   {
>> +    bool registered;
>>       int err;
>>
>>       /* Sanity check the profile handler */
>> @@ -250,14 +284,49 @@ int platform_profile_register(struct 
>> platform_profile_handler *pprof)
>>       if (cur_profile)
>>           return -EEXIST;
>>
>> -    err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +    registered = platform_profile_is_registered();
>> +    if (!registered) {
>> +        /* class for individual handlers */
>> +        err = class_register(&platform_profile_class);
>> +        if (err)
>> +            return err;
> 
> Why do we need to unregister the class here? From my point of view, 
> having a empty class if no
> platform profiles are registered is totally fine.

Hmm, OK.

> 
>> +        /* legacy sysfs files */
>> +        err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +        if (err)
>> +            goto cleanup_class;
>> +
>> +    }
>> +
>> +    /* create class interface for individual handler */
>> +    pprof->minor = idr_alloc(&platform_profile_minor_idr, pprof, 0, 
>> 0, GFP_KERNEL);
>> +    pprof->class_dev = device_create(&platform_profile_class, pprof- 
>> >dev,
>> +                     MKDEV(0, pprof->minor), NULL, "platform-profile- 
>> %s",
>> +                     pprof->name);
> 
> I would suggest that the name of the class devices should not contain 
> the platform profile name,
> as this would mean that two platform profile handlers cannot have the 
> same name.
> 
> Maybe using "platform-profile-<minor>" would be a better solution here? 
> The name can instead be
> read using an additional sysfs property.

Sure makes sense.

> 
> Thanks,
> Armin Wolf
> 
>> +    if (IS_ERR(pprof->class_dev)) {
>> +        err = PTR_ERR(pprof->class_dev);
>> +        goto cleanup_legacy;
>> +    }
>> +    err = sysfs_create_group(&pprof->class_dev->kobj, 
>> &platform_profile_group);
>>       if (err)
>> -        return err;
>> +        goto cleanup_device;
>> +
>>       list_add_tail(&pprof->list, &platform_profile_handler_list);
>>       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>
>>       cur_profile = pprof;
>>       return 0;
>> +
>> +cleanup_device:
>> +    device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>> +
>> +cleanup_legacy:
>> +    if (!registered)
>> +        sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +cleanup_class:
>> +    if (!registered)
>> +        class_unregister(&platform_profile_class);
>> +
>> +    return err;
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_register);
>>
>> @@ -270,6 +339,10 @@ int platform_profile_remove(struct 
>> platform_profile_handler *pprof)
>>       cur_profile = NULL;
>>
>>       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +
>> +    sysfs_remove_group(&pprof->class_dev->kobj, 
>> &platform_profile_group);
>> +    device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>> +
>>       if (!platform_profile_is_registered())
>>           sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>
>> diff --git a/include/linux/platform_profile.h b/include/linux/ 
>> platform_profile.h
>> index da009c8a402c9..764c4812ef759 100644
>> --- a/include/linux/platform_profile.h
>> +++ b/include/linux/platform_profile.h
>> @@ -30,6 +30,8 @@ enum platform_profile_option {
>>   struct platform_profile_handler {
>>       const char *name;
>>       struct device *dev;
>> +    struct device *class_dev;
>> +    int minor;
>>       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>       struct list_head list;
>>       int (*profile_get)(struct platform_profile_handler *pprof,


