Return-Path: <linux-acpi+bounces-15194-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6761DB07643
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 14:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4942E16BB9F
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AD026E6EC;
	Wed, 16 Jul 2025 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="iLPZ/vR1";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kULaywd6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA320110B;
	Wed, 16 Jul 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670416; cv=fail; b=DwZH4BwFq26ekxACyC26vs9dK9baEL6FKXQGWHN8sP5QayT3oFxoKP6o8CJF0ERzgYvVzfgpuPln+DpiJtof7n3k5aqeh4KTAJVbLEbVEhTWbJN/vDzLYXk9DUoMt2+r/WRLOGbkQkfhFrFEWINTYR5yEmd0eA8t69++J6s+Hho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670416; c=relaxed/simple;
	bh=8fgjm4p4tuEc99FGxKr55u8Mt3OGqMXzzT358DPXnEk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GU76CX3k8q3WwSytGTnrJZHQGSw85w8ztke6Y++Wui/9grZFKU78TnEdRNgJw3HTMGxvIg9j0FxoBUyRTqnchTe6LjxbhEuuil+Dhbjd70fx24WKIacXRfPEvDr6/JggkKh8VFM/1IN+9ehWkIs9fLmBZx80OvP7qP4F/e0dDko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=iLPZ/vR1; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kULaywd6; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G6gcmW021953;
	Wed, 16 Jul 2025 07:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=8fgjm4p4tuEc99FGxKr55u8Mt3OGqMXzzT358DPXnEk=; b=
	iLPZ/vR1Ye0LUUB4VgbILvlumE/y1MKbXw9yqMyrmb0jnm3aRMfNp08idUt0l6OK
	fVUC1PNuVeQVzKehN4bsEpJfQgLH+K0sHoR0Kcob58b1mCagiPjXddaOy6I2j4G6
	GWFIIQ5uksiA9M/kEv5EIV5ycdc85//ju5PMAJq8gXwSTt9qSQmAsFFDULolKLRu
	jz6ubIwf/KEV2W9T3cJoDkLkDcuqx5cYplcjWcYPmpgfXrm6ee62XW03g+HpymGt
	VhUWBwmY7VSfvedtbVdjZLdfpt72JlIG0MEEb3lC4FNtUwTjtAPAZOk6VQRkkkmy
	O0l87NSb23Rt4aOw6FMWXA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2126.outbound.protection.outlook.com [40.107.223.126])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 47un42dnen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 07:53:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xW8DvuPtPQj0NmbQPFWjmzGWmRkgJe93KPQN1kAt7Dc8xDRZvUip2JfdKzY0JQZVNyG/jcP9TC2O8lmLlz6PYI1xNqoxabAoUwemiKBPVzDYhSnRviNa5w/WaPFhhMJKSWisT9fkmUeQ+16cFSNpwiOnnmZCV4Ay8+4N68jDvpWjQ+O2vOzxDG/y+hInUjd8AT5C9SABPX0D8Dc9JrPEDbajt1LNZpzjNgQDrIUQrT0QgMOTIrBwMhKefwJElbv/ZhOKD78K3DXYsEUjx/jHJDGdqfDyEcswDhU70vWp11f3s8PbbIInBmspCWwtOFnBeq0sViNPlqVkA9syveB2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fgjm4p4tuEc99FGxKr55u8Mt3OGqMXzzT358DPXnEk=;
 b=wYTplmFLNdWP8tP/o2Fud5IJKc7APPm/eiRa6gtkWSpUYV2M39uEx4YcFLC/hJhc9BZzGuPO1d7dhEmyeBOD7w5rSgyYRUlCSm2fDeWGvNCLjOkvi/73wS8t9m2C6x08vuRdnfIiZqLDICqnGpmF5U6vwZyUgF8XW16YGDjgKFnyoBbE1KAg5jszSlcQ6thfrULqbBWm+CBo9ZAt5pj3uMELOpLmR4m5nX9SBIZwRm66+6aUkk6M/rtN3/RkAsEgGax6AM5KbgmnKJU/OBgOYr1WLZf9u86j4AXX6yF1tX17Md0kRI/sx0MbrLnYLQH1kE6uQxmzktMzkWSCCdyA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fgjm4p4tuEc99FGxKr55u8Mt3OGqMXzzT358DPXnEk=;
 b=kULaywd6ErvXFmDhC5W0OE2FuQqGaTBx09BgQotdw4AMWf1Htsv9hbyL1VN7U998/Sad1OcWqn/3mUpgEfQpnJ2VkKeOWRjFxoloGK5kwdHwRi/M7n9WlJzFPiq2vI7/Lhz8AUHuPKQksuRdWAZp0p4PWI6++N5fWHNLfYe+Z1w=
Received: from DS7PR05CA0099.namprd05.prod.outlook.com (2603:10b6:8:56::20) by
 SJ4PPF403D7541D.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a1b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 16 Jul
 2025 12:53:27 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::89) by DS7PR05CA0099.outlook.office365.com
 (2603:10b6:8:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Wed,
 16 Jul 2025 12:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Wed, 16 Jul 2025 12:53:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0FB96406540;
	Wed, 16 Jul 2025 12:53:25 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id F2AEF820249;
	Wed, 16 Jul 2025 12:53:24 +0000 (UTC)
Message-ID: <6339d75ec6e4211eb96f0d313c923656a2360097.camel@opensource.cirrus.com>
Subject: Re: [PATCH v2] ACPICA: Add SoundWire File Table (SWFT) signature
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linux.dev, patches@opensource.cirrus.com
Date: Wed, 16 Jul 2025 12:53:24 +0000
In-Reply-To: <CAJZ5v0i24A5N5bwJE-zqw_afcPk2a3OvnPNDCTCCd2tRTy7zBA@mail.gmail.com>
References: <20250716100337.652657-1-mstrozek@opensource.cirrus.com>
	 <CAJZ5v0i24A5N5bwJE-zqw_afcPk2a3OvnPNDCTCCd2tRTy7zBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ4PPF403D7541D:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c45efcb-c4e7-452e-140a-08ddc467c1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFNHOGlaUUF4RHB3d2JKcmp4REpSSllKc2x5ODk0cHA4MFNva3ZOQjRWeUJF?=
 =?utf-8?B?SmNSQTdzdXpHTWZxMlZvWitVRFE3UGM5a3Z5bjFqa0NTcGFwaHhhWnBlTkJM?=
 =?utf-8?B?YXd0UkMzaDVQclNaL3BUVzIxYkNVYmo1U0wybzNqQXMxUW44c05GQ2dPUDI2?=
 =?utf-8?B?TlNhYm9GL3AvelZTTTZFYmNGOEtBbkQ1RmRLOTRzN3FPeE42UWNEYUFsL1NB?=
 =?utf-8?B?YWN4MERBSHdySzNkbWhuVFB3L0UzMG1IM2lpQlR0OFZReDNNbW9GUlppZ0Jl?=
 =?utf-8?B?dEFmbnMrcHhVT05UM0JlN3VUM0xCSkxOUXJKeHV5M0ZNemJxTVd0Wkg4aDZM?=
 =?utf-8?B?dGh1cGlsOFo0VTVLTFRVMFN0Tm9IYUlXRkZyN2FCK2g3cW1nYXl5VjdUamdP?=
 =?utf-8?B?cnRiNUtoYU9oL0MreWFyRllueGRHcDcwMWZtanpZUWhnUHY1UkllQVlvMlQ0?=
 =?utf-8?B?UjY1aEdLQWc4OWF0YlBOaTFRaGpPL1ZBL2FUYlAwTjJGbldCQ1k5cGd2VDVX?=
 =?utf-8?B?OHlKbXo0UU5wY2tJL1VMN1Bzc0ppNkEyOWNML3JySzNIdGUvcFkrRDBicmZs?=
 =?utf-8?B?MHNsd1VDT3hnSVEvZE9jYmlwcmt1c1NSekczUFhXUVVUOVU1cTc0Y2ZZRWFr?=
 =?utf-8?B?UFExL05HZExQelZFZ1RpZ3hjeW45aC9JYUkxbUxyT0w5dVNBREZ6ZVlIR1E5?=
 =?utf-8?B?YmZqL3RvQnczZm01azNjUWhKaDg4Y0Q5aGNHYVFrTEc4VUFtZEV3NXlmNG9C?=
 =?utf-8?B?ejF0NmlwUjRmaDVhVm14OTJCRFU4RlppdUlaRWhrRjlrcDJabGd4QWcwT25S?=
 =?utf-8?B?WitKeml2ZmtDWlpNS2FkZzAwQ3lNSTMyTWNlSVRMMHQ2UjZ2bXVha1ZKaFUx?=
 =?utf-8?B?WU5FWHQ5SGEvUit5V05BTlFzdS9ZUXlSTkNDOUZoUHhYcm9RdDFmaXhFbXZQ?=
 =?utf-8?B?UTZ5TGt5TmNxWU8vbmtuWTNtUEYvajBsNFBXb1ZYcHNCT2FTWXdUcEg2UUVi?=
 =?utf-8?B?VkU2ZG43TnVDblRMLzY1Y1NFVHhUT2QrSUhIbGd0Q1I3T2E4ZERCMVNIOFE1?=
 =?utf-8?B?cEF0SEhWNmEwTXdLZkRIZThDZ3ZzV0lpRnRZRUVWdUJidE1DUklMZ1VhZGJN?=
 =?utf-8?B?cjlrS3dIRVdNV0Z2Y2ZmTVVmSm0zWnI3Wk9FU3FWVW1hNXgvYURoUkFtcUF6?=
 =?utf-8?B?SWxBNThVQ0xUZlQyYlhZQzhkMWZPK042RVVzajkxMWczSExTdCtqbGVCVFhm?=
 =?utf-8?B?TDlMZTlDM1E3eWJjcnJxd2FWa2QxNjFIY3BzN2hWOGc0VndNakEyZUJqem9t?=
 =?utf-8?B?WURPY0NKcEFpWTk2N283SFh3ZG1iOWhrMCsxRlVkLzI2dXN5MjFGMy80VDln?=
 =?utf-8?B?WjdPTGVaM3RHMjVIY2lWdGd5TFBWY0tvVDl3eE1qVkl2VXp4MzRORGpUQkVV?=
 =?utf-8?B?QktNNHBUbmJ3UUp5L0t0OFF4OHJTZ2tuY0tFQnN2TWordXNnY3E1TjFYZlVx?=
 =?utf-8?B?NGFFd3crUnRsTS9qdEFtbHRiZ2NGeldOR1NhVk1HcHdBcHpBZ09iZmJVK1Br?=
 =?utf-8?B?Y2czQUlEY1JqSE0weld4azAxZ29wbDlxaUpNdzhnWVhaWmlMdlZFemVYYjk2?=
 =?utf-8?B?MnJCODRTZVZhTEJLVnlJdUxrS0F6SjY2QjkrVWJEVjJNSE5zcDBxMDBUWFRv?=
 =?utf-8?B?Y2JabEUxeE5oNGx3QXpBdDYxeTA2bWN1MEtCY2dqcmQvK1VFL01VZE5SOGlu?=
 =?utf-8?B?VGZmenhoUmlwQ0ZwWEVKZXlMcmFIQm1pRlFWNGlIVk16NkNYak5IQVIzMk52?=
 =?utf-8?B?QlFIZ2grQkZoMFdMZTI2M0hYeFgvUlVBcnhTNDJmVG9BNjZCT2NsQUlTdlFF?=
 =?utf-8?B?cFVsTTRkOEU1ZGFHOTRzUGtJKzVMRW1VTWEweTg2RzRLdG5lK2hBVGlvNmUz?=
 =?utf-8?B?NCs1d3ZsZ1FpbUpVbjNaRnY5MFozWkhZUHliRkFHNTlRUlRCTmt2enFUdGh3?=
 =?utf-8?B?WDV6UzB5NG40RENmL1NNaDFQRkRPNjNGdnN3S2FWTitJb0JaWGFUSnhUbkF1?=
 =?utf-8?Q?inyd2G?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 12:53:26.3440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c45efcb-c4e7-452e-140a-08ddc467c1a9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF403D7541D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIwMCBTYWx0ZWRfX5UumEx1mukJs 4YPTFGKIBhKCO3FT66Lt88x8/n0u0ouCGxYwbbvgWwuGE4gA0masDi44oSAfMgXVv08VEbTnzN3 3HzbOJfPFX4wntiCiQWX2EOUrhDNO2fkPZo8gbE9tQiCRZgk6v70SqTfVghv0CW8d3SMkfkleAT
 ge6oFHIOmHVRzuxct4P5xnBgKFarej9CjGfw/be8f2tDc31VE7C2Zh7FBQauiNvBZVTy4Up4Pch /VLFvWIBSoEVKBKGJLy3E7JNaOiNpHP2ErPOvfEPBMvV9IcMqZ4RUNbSaWzD77XEvIPNxRnuTK0 5QyClBZGuW75p0OrT65ZvLp1R5Gf7le4n5KRleBCpGo54BvFJaZk6HnYgVHKcNytFSAt0SVBj2W V5pgC0lA
X-Proofpoint-ORIG-GUID: WUaBfCzU2C71zZZFeHQT5he9SopfBwK-
X-Authority-Analysis: v=2.4 cv=F6tXdrhN c=1 sm=1 tr=0 ts=6877a0ca cx=c_pps a=Dk5bMbaT25Dkt+m1nh8p1w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=HtL0slFiYqgWA7QMNmAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WUaBfCzU2C71zZZFeHQT5he9SopfBwK-
X-Proofpoint-Spam-Reason: safe

W=C2=A0dniu =C5=9Bro, 16.07.2025 o=C2=A0godzinie 14=E2=88=B629=E2=80=89+020=
0, u=C5=BCytkownik Rafael J.
Wysocki napisa=C5=82:
> On Wed, Jul 16, 2025 at 12:04=E2=80=AFPM Maciej Strozek
> <mstrozek@opensource.cirrus.com> wrote:
> >=20
> > The File Download (FDL) process of SoundWire Class Audio (SDCA)
> > driver,
> > which provides code/data which may be required by an SDCA device,
> > utilizes SWFT to obtain that code/data. There is a single SWFT for
> > the
> > system, and SWFT can contain multiple files (information about the
> > file
> > as well as its binary contents). The SWFT has a standard ACPI
> > Descriptor
> > Table Header, followed by SoundWire File definitions as described
> > in
> > Discovery and Configuration (DisCo) Specification for SoundWire=C2=AE
> >=20
> > Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
>=20
> The canonical way to change ACPICA is to submit a PR to the upstream
> ACPICA project on GitHub, wait until it is merged and then
> (optionally) submit a Linux kernel patch based on it and pointing
> back
> to the original upstream ACPICA commit.
>=20
> Thanks!
I was unaware of this, going to submit the PR then, sorry for the
noise!
--=20
Regards,
Maciej

