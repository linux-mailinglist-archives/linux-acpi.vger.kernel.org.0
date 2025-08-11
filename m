Return-Path: <linux-acpi+bounces-15588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607DB20A9B
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50A63A8B27
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D614658D;
	Mon, 11 Aug 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Y6JvJ8b9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cHI5GDVE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB04C7F;
	Mon, 11 Aug 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919942; cv=fail; b=bZR2f181De1n4Wh10ADnVs9KwuWA1Ar4XBOoEkTos2IqDZgxxDkBsU8KA5LTZFxJmU27zCmMV3veU9Fcar3tNMw0mkajayPRaxZIYeAoGpaM8ISE7YLpPut7sWK5zGysD+Nk4rEncdv/OoKm2a50CFj00CZowq30ziXLXUzWE5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919942; c=relaxed/simple;
	bh=FMKYPJ7U1vJJZjf1NRN/+S6KfBhErNmKlP8M3i+tli8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VEjyHdoZ6GfOgNVgoOLQGfVuwdLP+JDXMP5tgWyV2IwS+bXsrLFl6/Y+And0sGgSP4TerJyRVGPKzv659fbrQWDMSFxJ4PNhBdy/3ZuwpvhNrFkIf9Yv7wdosIe6PFO7FfA8hu1MCrwPtXn497RZyLsxPbW5mAZ+tBU/Dci1/6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Y6JvJ8b9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cHI5GDVE; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B4j5g1012483;
	Mon, 11 Aug 2025 08:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=NBY9gMho60YvLsA9
	cCeV0pKq0Po2S39ET2akKH/gWJ0=; b=Y6JvJ8b9+kqrPqb95nfd83YbBUYm+qo/
	DNahtYeThbxmPS3cHhHcmKAV9DxYegwZXOP80TPwNakXcsfKtm/FkDPC1UNOY+FH
	XpNn8j+HzyX00eiNIclnHFBq8tBo437sxNx3C8bT5kjV0Ll9WsYGWGJs2z6edz8x
	019+ZLw7FBkJCj5x16xhxSn6rqY7Jsf5uDgcNHpug7vOFsTtRYmnM3ekYoz46MLG
	LCgeDGqFLsg5P9oQjAjUwmbBqvmW0cLgsQ/FHk05msn1DfSYwf+DUMVoeaJI7kxY
	ZkyxDecdg0+/gUgblQJCZ0AxeTnjDno0l6A5Q99deN9LSv5nwpl+Nw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2136.outbound.protection.outlook.com [40.107.93.136])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48e3qx25q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 08:45:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp7it+I8S5FFix7iWomeH+zMlMSgJKIQDrGExYvMJzpWYACjWrIuGgEZMwBGEIkNErtElvsvIhfeL3FysomVaNRFRWEf6eCtcWzjb5AqhdHXFoLwm0FxNBodJMzcxCtRujFVYK5RNKc8F2MCgTM//iY1t/3yhGuQbr2wdvcyB19ymRxpJ0Znak3Aspp/jzr2rmVM+cFYgY6UoGRRMNLOBCwgPyyPBccQZLmCdaj4YyMGIv70dk/c9LqSwiT1GYteFMh4FBDLxwxHdPS2M99lHkWQNQ808+Fc7SjM08TLCxW4k7dabXHzFNr42HWk8urXJa2JOqzOHJx0WofwPVPIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBY9gMho60YvLsA9cCeV0pKq0Po2S39ET2akKH/gWJ0=;
 b=IzikEc1Cgoh6YKQD50AdHw86kegOCR3AAtqm1VKHvr2nQUxyY/H7nVKroET1KDPDs02ZwcJglzBFvjVvTEs4wAwocnX/vYSJvTy/aTuRnUErpBJjMMNs9DMb1r3jRdd4Px4FFN9Twlu92O5RAhoEmUiUwm47KsGNW2wXa3HTrJV5b5wRehEuEokmD4aqtMyKvOXALX8xUCneiph7d7IoCDTB324/fVTRPEpRHyzCcxBdnpttm8r64CK+mLGfXGClUQJwiizOvhtfdBJgk1+VAxH+V7wMYAsnPJqWzSE4MVttLvoHdstez26Y07d85FMMozl69E64bKrxEMay+1mjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBY9gMho60YvLsA9cCeV0pKq0Po2S39ET2akKH/gWJ0=;
 b=cHI5GDVEZb3nJ3Tczv+Kci7VUTD7lCSXn47BI9H/4u9Xq4+KnNcFNieEmVim0Tj71jAQQ8W2cnsJYbPVtdQBj1A5FPKaZH7kJVcp6esbbnSuiCI11ODSNLfJ155GwoQfTDDqwlWVTHeZQEc0GLcWfSGr5kiyu8yZ7FbhLEkNAP4=
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by PH7PR19MB6508.namprd19.prod.outlook.com (2603:10b6:510:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 13:45:16 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::2b) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 13:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Mon, 11 Aug 2025 13:45:15 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B7A75406565;
	Mon, 11 Aug 2025 13:45:13 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id AA01F820249;
	Mon, 11 Aug 2025 13:45:13 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linux.dev, patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH v3] ACPICA: Add SoundWire File Table (SWFT) signature
Date: Mon, 11 Aug 2025 14:45:05 +0100
Message-Id: <20250811134505.1162661-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|PH7PR19MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6f86b4-bbd0-4136-a369-08ddd8dd4dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1ZxZVFjNTNKU1dlU3NkYmQyMDhnYndVWXFyd3ZqOUlzQWN4TFF2bU5ML0lM?=
 =?utf-8?B?b0xSeUZFc1I4U2N6NXJjUzR4REtvMmNVUWRQdzR5NWhkbzVRakJObFFQMk53?=
 =?utf-8?B?MzhQUmQ3Y3Z4ajNCMWxzYXZ2VUR3UG84NU9iZ05pYnAzR0hKNEdPa1p2Y29z?=
 =?utf-8?B?VENxMGdVQzRHNUdrY0g3OVk5WWFOZWFxdUNSdmQxSHBpVW40R1YxUXpiV3Rh?=
 =?utf-8?B?dzFYcjVPOW5LczNVazZ2TEh3b3UxekluaC9aNWdJQ2ZLbEYyNGNuQ2xOeDMy?=
 =?utf-8?B?aUN0eFFwbGRKTGFCTWRZVm1aN2dZTUxWcUE2eFc0YW5GQmJ3VWV4cThKRlJ4?=
 =?utf-8?B?MG14dm1rSHFrQnJDYWwvWnBjZFpGM2Z0ZGNkWUVCazlwMGdOZmpWSUN6Q3Qy?=
 =?utf-8?B?cHpjK01UenFtbXpqcXlabXREek5yU0R0U056M1RXU0tGZFdXQW82OVdDMTJm?=
 =?utf-8?B?WkRIRWxKUmdWWUFmU0dwRDFRVko3RUVTaElwNEI4ejBjSElRVk15Y01FUHhz?=
 =?utf-8?B?NFpUWW5OdUhJS3AzYXRIc3JXT1R5dmFHdWJnb1hNT0hMWVNpbTVkZmFSTXQy?=
 =?utf-8?B?Rm5wSXpON3FPVlNsMEJKWmdWQWZxQWt0NnpEYmVHaytXRFNhbEM2SG1naDdS?=
 =?utf-8?B?KzduU1VFbURkVjk5SCtOY1FlVndLaWMvMVRkKzlJNXhlazFUUWx3QjlLWHZ2?=
 =?utf-8?B?Vk1HQjV5WHJsZGE4OGFYb3l5bEpzOEtiYUNYVUdNM1ZnNHF1b244VW9SODBF?=
 =?utf-8?B?dmNSbEVsWkFIdzhERnlUMWY2ZFhCWXZQdTFZY0xBL1Uxc05oQ1BrVXprUHdT?=
 =?utf-8?B?ajF4a3dPYmJOK0V5SUNVdjh1YkU5VVcrOTQweGhTTWVDZUVWSmtzeVdyV2RU?=
 =?utf-8?B?L2ZBOEJoYkxLek9wdEkzVmdRdjJvOGVwVHc1MHpuVGJJdGY2N083RWdFRitE?=
 =?utf-8?B?eEFGOWR0Sk1tNnNyVjFjSVlkam41VmhjaTRkcm41QnNUMGlRcUZmcHhQUTRT?=
 =?utf-8?B?azFqeEtsYmorUk90c0NjWEVMZmFUQVFEYVlQelBmR3JtaDJQVm9sd0w3MnIz?=
 =?utf-8?B?QktvYTlBNTU3MTBuRXF6cDZocldJT1I4OHdDTUwrN2loQnZCVFhBN1UzODVE?=
 =?utf-8?B?WHNZMmdYTHl0RzZjY002bGcxS1lpU2pnNkVMUkVyOG5kdFB2Y0RkaVRYZGwz?=
 =?utf-8?B?elBLZ3ljRjYvU2tSMHR6VFhWd0k4QldRZUhramxZcFlRc0Z0VVBrYjk2YkNY?=
 =?utf-8?B?QVgzei82S0VNWUZFZkRzMkQrRy9nRGtqcHNkR0pzTGh4UUNpUkhSQWZQeWlp?=
 =?utf-8?B?aER5WExGSXNQK1VIdFpJTXUvNzBzMUVzNE1Hc0xlekZKVW51VjNncEhjUEhR?=
 =?utf-8?B?eXFzc2x5MWZqR2JOK1R6a2UrRTFSU2xMaklsUk9nSTM1OE1saWZlUVVORlA2?=
 =?utf-8?B?QXNUWG9Yd3VWS2l0S2ozSEdxRnh4dW1qb0Q4QmpHemlQY1pieVlnUUVxcmxV?=
 =?utf-8?B?NS9IVDZKSnBNTFF0aWJLY3BSbkJ5MWZkbVlhV2NnM0I1QmlvMUNoeDJDZ3dY?=
 =?utf-8?B?bXpZdlZjZDVkdDBEWGJYN3p0SlNSb0YrSGp1WWRQTmpvdFFjVVllbWJ3Nm9T?=
 =?utf-8?B?SmF2ZFh2NzZINVhiZWJXR1hmNDh0elcwOFJpcUZ4WkI1cFB6MERLcVpxYUVy?=
 =?utf-8?B?RkFjUlJ4cnBOVkRnK2NGcXJESGtxcGlWWVZrbGsxN2FwS3FjNEFNWmJHeUZq?=
 =?utf-8?B?Nk85VFNYSkNTVndkVUNJQXJsTGZSNSsraVZFSVBNL2dGN0cwOU40dzFSRWRt?=
 =?utf-8?B?RGxJVU1VZGpUclA5dXoyTHhNeGl5TFU0K254N0tFM0hnODNKdjllb3JxZ1Fx?=
 =?utf-8?B?Wk1hbWEzMWF6aXBZRWpkMHZLck1OTU12WExPbU9kTlc3dldZVFV5VjE2MkMy?=
 =?utf-8?B?dmc1czZ5dWplWjdBNG9YMlhjMDVYZzVuZFpVZHBXMHMyQ0JpbGJVaEZsc2pD?=
 =?utf-8?B?bkYvVDRqeDVvMjFSREVKczZQUkJmc1NxK1BjOUptR2NhUXJYZ1ZrY3A1ZGtH?=
 =?utf-8?Q?d+EiMJ?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:45:15.7891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6f86b4-bbd0-4136-a369-08ddd8dd4dce
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6508
X-Proofpoint-GUID: FFj85gp5prktoqqYtw6YdeeNUWeVFUTG
X-Authority-Analysis: v=2.4 cv=Bt6dwZX5 c=1 sm=1 tr=0 ts=6899f3f3 cx=c_pps a=m6C/VzIz8X0REkloh6CGuA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=NEAV23lmAAAA:8 a=w1d2syhTAAAA:8 a=L35MEKfBLXpLSl1DdtsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FFj85gp5prktoqqYtw6YdeeNUWeVFUTG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDA3NiBTYWx0ZWRfXyc9/EG3XfOpQ 4SoHyG/GrMEVVwZ6AEkrJz/Nkid8tiWOd194HTPllV6MugcvYOFKWUwUkoHYH2eyfPX9o7GKEZe Dv6/cT9KiKwsdNV9eJpI9aoXM7xYi2PIZcr5uI7z/IJnsbiIyaA8hswDj8T2uHBfgb6MFDa8dZN
 sgEma55mwkxmBwTFeqUpAMKaEIvrxgoAY3egpjJw3rKAvDjMMdctjQWpuj3n5mXWjdoMvCpdXFA RUt1sEMjQ2tEnEsM7EnUW8SLmjtBUnQyidDhkBVnls5CdPi0lj7SGsjapF6Zsz7PQD4aYyvITVv 0as5+3X54NxzwwjvWlfQN1SU0uqGvHcAM80BcRtsbn/QAkkgGeKrBVX/TYeRyJyRCx0LEk6hS9r TiWB4Vkr
X-Proofpoint-Spam-Reason: safe

The File Download (FDL) process of SoundWire Class Audio (SDCA) driver,
which provides code/data which may be required by an SDCA device,
utilizes SWFT to obtain that code/data. There is a single SWFT for the
system, and SWFT can contain multiple files (information about the file
as well as its binary contents). The SWFT has a standard ACPI Descriptor
Table Header, followed by SoundWire File definitions as described in
Discovery and Configuration (DisCo) Specification for SoundWire®

Link: https://github.com/acpica/acpica/commit/18c96022
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
v3: Added link to ACPICA commit
v2: Removed Change-Id line
---
 drivers/acpi/tables.c |  2 +-
 include/acpi/actbl2.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index fa9bb8c8ce953..57fc8bc56166b 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -408,7 +408,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __nonstring_array __initconst
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
 	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
-	ACPI_SIG_NBFT };
+	ACPI_SIG_NBFT, ACPI_SIG_SWFT};

 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 048f5f47f8b88..f726bce3eb849 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -57,6 +57,7 @@
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
 #define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key Location Table */
+#define ACPI_SIG_SWFT           "SWFT"	/* SoundWire File Table */
 #define ACPI_SIG_TDEL           "TDEL"	/* TD Event Log Table */

 /*
@@ -3478,6 +3479,26 @@ enum acpi_svkl_format {
 	ACPI_SVKL_FORMAT_RESERVED = 1	/* 1 and greater are reserved */
 };

+/*******************************************************************************
+ * SWFT - SoundWire File Table
+ *
+ * Conforms to "Discovery and Configuration (DisCo) Specification for SoundWire"
+ * Version 2.1, 2 October 2023
+ *
+ ******************************************************************************/
+struct acpi_sw_file {
+	u16 vendor_id;
+	u32 file_id;
+	u16 file_version;
+	u32 file_length;
+	u8 data[];
+};
+
+struct acpi_table_swft {
+	struct acpi_table_header header;
+	struct acpi_sw_file files[];
+};
+
 /*******************************************************************************
  *
  * TDEL - TD-Event Log
--
2.39.5


