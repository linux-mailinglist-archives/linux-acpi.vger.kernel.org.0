Return-Path: <linux-acpi+bounces-17098-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267BFB82A8D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 04:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BAE1C00769
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 02:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A67207A09;
	Thu, 18 Sep 2025 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pSdC+LY2";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aM0IjZF/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD611F582A;
	Thu, 18 Sep 2025 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163013; cv=fail; b=XZc0Ye7fBi/Qa8T29kHrWZShbfNtsAIWdQQmkzegzXRNXaR4EOPYhpPbCU7GMAKWSQAEVQVHqZbiN0hwQnmFnliwKvY7Uud/z71x/CAxGwYMFN1Gt07KK8Gf4InPSkZq9wLuQUyiIX9aQOZNwQZyT0m4IJXIbEMAyHWlwKA7DFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163013; c=relaxed/simple;
	bh=NFKXWR3JD6OORxss+DRw3mo1EXJfej22DWxtTnL7XZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQWK1ZH1vWoA3qC5TVNQdaIqPP8KISbrRm7pilrYBvogcEF/63hQl/Xlj6W9tE5yx4J7+e0LAJyo+o/Xs0uFQtlZwDa77Iu3//tmySZ7iEwXD0cIYGYupiKffB/Z5siRa/BL1WXp/CHnxactG0a4AoBTJT7uGS9zcpQbi53RBjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pSdC+LY2; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aM0IjZF/; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1758163011; x=1789699011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NFKXWR3JD6OORxss+DRw3mo1EXJfej22DWxtTnL7XZ0=;
  b=pSdC+LY2BCHa3BhNynZ62Y/68zuJYlOCCQigFvA9LHGd/Sq3jybAPbYu
   CZax1/HfRJZSKP6Qwfxs+NACwF1RF23CRZQJYV9KztED9tzDWD3DbB7Jb
   WymT/juz/iw2+yqw6TcFbaYE//oINPHwe27nxM1x+uG5qwWcwUsA5IzaR
   5UIQYeDP7xj8+2vUTMHOXQQRQpwIJccAAoqPY9KJvOt570CYbjta2uiSf
   vXcqCaLDh9HayUcTVoKacbrES1HXADueUQ/4K16rTUJgJsb+qLho1GsZC
   ifh8PkU7ZEg6q2LIeVGDMkxBT73PDI+3jEXpawNjX0r2XQ7xk5vR3YWyD
   w==;
X-CSE-ConnectionGUID: 7DYJUTIaRhKHMntbwDVv/Q==
X-CSE-MsgGUID: xIpbApOiRxaLlYtLRXEBpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="79059497"
X-IronPort-AV: E=Sophos;i="6.18,273,1751209200"; 
   d="scan'208";a="79059497"
Received: from mail-japaneastazon11011033.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.33])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 11:35:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2f7t2KdroydDfkf16oG4oFMIhW5FNu78JPdbFeCQiCyj5gRvDoImIFYNdHzk5SkGw2jX293sot4XsvHOHpmnPt6o36JOHyKBtYJrdRTj5HTf5kM9hkOqTKgMLHN1pDoMEQm+cSUxsgng1SAHbITfPINcJ/IFOC3HJfpK94gXthiUGg2S6uYGHgFTVG6gpcDet63P22axJy1qvzqCsXU2r+j4ghlLVg5/RBGsv11gNWf4umtb0P5/xPBLdxQsKviOVfhccXi6wJvnsGhpsiiL5lZQ3hWsjCYEqmQnPimW/x7jJdrhQ0/ERmceUQ08h6ZNWHqkFtdcxFOXa32tF5CYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFwH2qHyoxvHr6Uh7N2JRTzrFW2+CotUseF3ILMAPbA=;
 b=DcrvEUobzrpjSllQGdMrxiJweftGxKaCVr6A2Rdj2C/nAG5jK8U9tpR/EXsOC9KLlgigPUy8HDfAiXxZxxMkbkwQTFf71xj8LvU/SblZ3Uv5RYzyn1RaQPadevnfY64BEfDIaT47s+r8AEISYY+RcLrA1joiXeehRFyIs18slQ+SWQNJ2c6mci0+Mg+mG9CuvvbusNQAUKzgT8THvvc0aaE/w7+07ASElekSI650WnarezNH+a6PlFe4nh+RX6zGqb58me/RFE4FYiqEpNnbbtUlT/Gi9ft5IhWxE9SeQW2qPZPviPXE37R1OsrCkSPS6f27UldS2mrTumjH0xKBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFwH2qHyoxvHr6Uh7N2JRTzrFW2+CotUseF3ILMAPbA=;
 b=aM0IjZF/Rx4eLFQwoFrJguh3tN/nHw6vlPnGsnjZ9i3MCjyTYwG5KwpRZPuGkCX0CIsUfyhlOW/JXWogM2Gkj8oUi0O1tsQ5QnVIExDCcT3xuq+IdWjnmZgWrSYpVG5W8afm8Kch0ggX3/YG5tzKpa2oELrpGwNhT/FuIKonYKRngFtUC1pEjnt+BTPJSnnyYfmqHEDyUlr9LQqlRq5ATzLNb4F94nerJykpRjXBL2pl3JFefvANzyGoyTLEEv9eA6yciBt0Vh4H2qKWia3/kwfIZopPGDnvcs7Uh766IQ1ZSuFa7/yDT+i6OkX/igGcmmn46NLJpurWMnfL1HAJKA==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TY4PR01MB17272.jpnprd01.prod.outlook.com (2603:1096:405:334::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 02:35:30 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 02:35:30 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: D Scott Phillips OS <scott@os.amperecomputing.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"lcherian@marvell.com" <lcherian@marvell.com>, "bobo.shaobowang@huawei.com"
	<bobo.shaobowang@huawei.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, "peternewman@google.com" <peternewman@google.com>,
	"dfustini@baylibre.com" <dfustini@baylibre.com>, "amitsinght@marvell.com"
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Dave Martin
	<dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Rob Herring <robh@kernel.org>, Rohit Mathew
	<rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Subject: RE: [PATCH v2 27/29] arm_mpam: Add helper to reset saved mbwu state
Thread-Topic: [PATCH v2 27/29] arm_mpam: Add helper to reset saved mbwu state
Thread-Index: AQHcIpPm1yBhwJW+YEO2BQCfLO+73bSYQDEg
Date: Thu, 18 Sep 2025 02:35:30 +0000
Message-ID:
 <OSZPR01MB87982A954238E8122FF3ABD58B16A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-28-james.morse@arm.com>
In-Reply-To: <20250910204309.20751-28-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=2d28ae8a-ca6e-462c-a63d-24027b61723e;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-09-18T02:19:34Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TY4PR01MB17272:EE_
x-ms-office365-filtering-correlation-id: 4725690d-89b7-4a81-64c3-08ddf65c08cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?YzNTSW9JMDcxWEVrSzNWNTlJZGRqRDFtRm03VVN5aHBEZzVWTkdLMkxo?=
 =?iso-2022-jp?B?MjdsZDZUWitHQndqaWdTMlBwSzRlNUd0ZU91YUo2eStleVh3MVdJK0x5?=
 =?iso-2022-jp?B?VXNDTFVuY1Y1enV2Skh0RzB5NXR4R1hoZTZ1SEZ3ZndyY1MrOVlqeHgx?=
 =?iso-2022-jp?B?bTYyRmFHajZSWDMwUlJrbXZOa1NlR0w1OG5pWFJzOWdDYk1PWVlleThW?=
 =?iso-2022-jp?B?dnlBVzNPU0I5R1FVUFhqVkNjdXY1aDVnZ2Z3L2sxY0JmdGhzc002WjRE?=
 =?iso-2022-jp?B?UjVTK1JHWE50SVBmOEpnVUk2bHlyQ0loajh2UVFTQ1p4T0hYQmZ4aWcw?=
 =?iso-2022-jp?B?Sk9OZVZzTlRHcTMyU0hDbDFvMzA2b2laMU1aZHR5ejdIMllTN3I0Sk1i?=
 =?iso-2022-jp?B?MmgvbU9ObXNEZWJBdkU2WThpOVlPcUR4YzFZMFJDT3JwMVpmOU9UZGl2?=
 =?iso-2022-jp?B?RllpMU9VWmk0SmJsckowNTJiZHB1eUpzMG82MmJuSDNaVXdsWUNnYTA2?=
 =?iso-2022-jp?B?Z1l5RlNGN1N4Q29taHBHL282VFZyWUI0WVZ3N3QxcGdoRGpwVTVVZWxy?=
 =?iso-2022-jp?B?eEtzbFJubjlCQkVTYzlYMWZiMmwrcXcvNENaclNTUG1OUUgxNjFqRFRN?=
 =?iso-2022-jp?B?TzBKaVNyNWszZ1RTV1ZoZmlrK2hwL0RWU245TTlyREZXY3NCUlZFV1Bh?=
 =?iso-2022-jp?B?bS9hNW03VG9QVWNXMTJiV3JEcGRFWFAxL2dsMjhMMW8zZHZmUkR6NCtG?=
 =?iso-2022-jp?B?WERRbHF5b1Q4TmRPRFEwYTk3QW5aZzZQUGJuODBpZVNzVVovNnYzTWw1?=
 =?iso-2022-jp?B?c2tycndOK2hLMXhSOFkzaDArSjl2cVV3KzNrR3cwMjR1Rmp2c0ZWS29M?=
 =?iso-2022-jp?B?WHMwOXVyendFU21XWDNIUTl0eTUxaW1kSnVuUHZFVWVtUm9FQ0FmblFM?=
 =?iso-2022-jp?B?cTBzTnJiSVU3b05LOGRUZmp0VFlsRzEvMGhhRWR5eHFGZlZWYndRWCtN?=
 =?iso-2022-jp?B?STdUWm9PT3hBSWh3eGhZVXhoUE1MZnRTak5MZkhNb2s1RkgvdjBLSXNT?=
 =?iso-2022-jp?B?SU9hbTN6bHJUZTA5ZElPVzJVYVFaVTRFRWwwK0NsNjJqQ0ZPVU1wb1kx?=
 =?iso-2022-jp?B?aE4rQWdHWnJuendZNWdVUDlhTlAxZHJpb1k3S2VmQWo1T2Q5REo2ZHlF?=
 =?iso-2022-jp?B?MzJvYWRtY0JieE1jSlRJdFRBQmU3VnBlZlpVaENTQktaVnFOR2ptd2Yr?=
 =?iso-2022-jp?B?NXJOTWFhOVYvb0VES1BXN283eG40V1ZjdDlJTFhaYnFxazhmdS9oSXJU?=
 =?iso-2022-jp?B?TEFQb0RPTndnQ2p2ZDViK1E4dTBGaU4wZXgvZzlyeGxjQU5TWEFiWEhu?=
 =?iso-2022-jp?B?Y09vY2Rtbnl5V1VobzAwYUMvM0EwN0gxbnBYemVNeWtCcXJEUGQ4Z0Jt?=
 =?iso-2022-jp?B?WFdLVkVFVTQ2dkZDYkVmbWUvSVhyN2UrQ0lNY2YrYnA3Skk4akIwMTdq?=
 =?iso-2022-jp?B?bFdybTREWERsUWZSdDRtSVYxY21HbGlpWDh5cWZDb1NrcVZqbTlWdmRS?=
 =?iso-2022-jp?B?emhMYk9zMWVsYnBqTmJidGFUZWFiNjFodkpnZ2Q3NVJrMitNZm9ML0lU?=
 =?iso-2022-jp?B?cFhRMDV1NXZBZTBHd2xLL1h4NTRFeE10TXVGWDlVV1lsRE1td1c4czBZ?=
 =?iso-2022-jp?B?dkgrTVhlUEpQZGc2bHArYUxVd2ZlVzZ5VWpBZzBvZEZDSmNWYUR1aHVx?=
 =?iso-2022-jp?B?T0RNeFUweVI1TVVuWHgwOUUwYlZuVlowY1JTS01LdVJoMHJSemgrdWZK?=
 =?iso-2022-jp?B?U3QzVS9heWZoODRhcmVBTUhoZWNuc2tiNkdKZzRUZHk5MCtBWm9HRGk5?=
 =?iso-2022-jp?B?TXVoNE1OaEV0TXZNVEVOc1gweEU0UGRwQnBXdnhmdDE2bkdpdDVCaThP?=
 =?iso-2022-jp?B?ZXBwZUM3NnBqRnlHZi95aXhIdFM1UVRMVFlVQ01vVjkvMDRqeTUvWDVG?=
 =?iso-2022-jp?B?SjFwZmhmTFE5R25zMG9IcVhwVk11QTVxNnN1bCtlZkQ1VFRNUVBDQTgw?=
 =?iso-2022-jp?B?M0tickpJY1lyK0NDUlg3M1l5Zk9PYThuUFV2ZU42ZDU0MDVrSHl0SnIz?=
 =?iso-2022-jp?B?cTg3V05wV25IZ0NoOG5iRzVkeWs2MFJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NUQrcDR4ays4bjQyMERvRmp5VlNrZ0UyQmVaaUcva0U4WDh6UzdMTWhR?=
 =?iso-2022-jp?B?WXFXanFQOUlxcE1hb1JQNnBtaThtbjhHYmlvdS9jQXcrdEZWWndCUm1R?=
 =?iso-2022-jp?B?d0NCMHJSN0wySWVRSkdxVkxCRUFlLzhOUm1vUUdBVFZpS2F0SXJHcUNY?=
 =?iso-2022-jp?B?M0NLNWpwS2JSL2szY0xWNHZLdjV1aS9uY0kwaTlEOEUzNTVwRzFLUjFZ?=
 =?iso-2022-jp?B?UE96VlovekIrczh0am8xd0RyUnFZUUF4blFPRFpKeXp1c24yVi82Qzln?=
 =?iso-2022-jp?B?bFUxMDNoNXlveEhPN0hhMUkzMkQ4ajQvQnlITEE2R1hnc1JaMTVLTHZF?=
 =?iso-2022-jp?B?aktOaW1BT3NuMit6RmhxN2loaURwWHZDTVJicHVnRHRoM3Vldm9vc0J1?=
 =?iso-2022-jp?B?ei9hUUFHMkFYZDdkdkxlemlTL0hzRExCT1YvZDFaMEJaSHRnRTdhQkNp?=
 =?iso-2022-jp?B?VXloUE5zZ0FHQjdBU1NsUXVHMHBwMmZvSVpOZjRGeVhCcHpkWEFlR3JO?=
 =?iso-2022-jp?B?Yy9landtN29DaWZPSzR2WXRFMlo4QldlQ1hyVldXYjQ2SWxsclZxRGZn?=
 =?iso-2022-jp?B?S3o2MHJuZHhSZG5NRkRYdGRjYURIYkRUM2xkLzRjbnFCaUJ1NTJmWVBB?=
 =?iso-2022-jp?B?RWQ1WGlFVDBKR091a3J4UVZiVCtqci9DcVoraUIxRVRPMmFYbW10VFJx?=
 =?iso-2022-jp?B?VDEwdjcrUmk1VWlhbm1jMVJzOG9SNDVMSE1icnc1cVd1K2VEbmdWQTgw?=
 =?iso-2022-jp?B?VFh4a0RLZ2RjMEV3S21RTlFDaDI2MGpjZjhQU2tHUnhkTEJxRHhjVjFl?=
 =?iso-2022-jp?B?a2dMY3ozMTlKU2NBdkdUYjNKZnpIc2ViNEhxNk1Ud2N5TURyeDI0aUNy?=
 =?iso-2022-jp?B?L1pkOUoxc0E4VXpDNVpHcHhFMTBSUVRZV1ZnUEx4UDcvQjZYT0ZYU1Ru?=
 =?iso-2022-jp?B?blVPbytpVlhYUXgyaXYrN0gwYzNIeEh6Mzk5Z0ZTZGh1MWlaWGZDem5F?=
 =?iso-2022-jp?B?cCt4RVF6Zi9IcDFpL2F0UFg3OWdLa1RSVlhEd1E4blFuQjVOUUZ3WHR4?=
 =?iso-2022-jp?B?czlNZjJ2QjFRRXFicWFoRXAveWtENkxUNzkwNEdsOU1pWjhPRXBkc3By?=
 =?iso-2022-jp?B?czloNi9BWUxPaWU1cXAyQWhRcExac3ZxOXA3ZkVRVEU5WXE2YmcvNG4w?=
 =?iso-2022-jp?B?bWZ1L1ZpV0FoNWRqb0F5cTRvSzZhT0RqVU1pa0NyY1N0QXVEVGI5Nks2?=
 =?iso-2022-jp?B?Unk4N2NMakp6OGdSaW1veVdBUmNCMHF3MUZmTm9HUDBQN3JlandhRzE1?=
 =?iso-2022-jp?B?UXhIeWs0azF4bDM4cHd1RUFKMWFMZkoxNThFcTQzcXVLVmNKdEgzMkMr?=
 =?iso-2022-jp?B?bEptOWhnKzk2Z1hKVFpVRmx1YkNBdzVTZVprK0NmU0MwdGkrdnRNV1N1?=
 =?iso-2022-jp?B?Y1hqQjcwa2ZzUS9UWWVyZHZKejYvM0IrL0J1Y3NzWWpMTTVPS3dtcis4?=
 =?iso-2022-jp?B?UWJEblc4cG0zNXNhanpIRDJLY1psK2JxV3dkQnNERWZFKzFEeUpSUUU4?=
 =?iso-2022-jp?B?bWtOWDl5bXhKRkxoWVlMWk56QnJkL3BXQmtUSTI1eHFrRlMwSHE4bUln?=
 =?iso-2022-jp?B?TGtHeWxtcG9YUzZJSGp3bWhiN3IraEpuSmtlWFM0ZzZZdVhUM25hZmFz?=
 =?iso-2022-jp?B?d1JFV0daaERITEJ6VlBmUlJXZ0duNElwQU0vUFl6QWlBZVkxLzBacEYy?=
 =?iso-2022-jp?B?S0src1BwRXQxZFRVQVFnSzlxVzJOaUlYVzMvS2NQK2greW1ZdzBzL2RB?=
 =?iso-2022-jp?B?VjNmZzJoNG9CYmdTZHRFa3FpeGhEdUNDaU9ndzNzYnBEQkx0MjlhUXph?=
 =?iso-2022-jp?B?UnJBSnhuQ2ZCWEsvUnluM1RzaCtaN3B2VjhxZ252WG1BS0FjK2Y4MXRK?=
 =?iso-2022-jp?B?ZFVzMUltNTVpaTJRbEx6SjRPODJFdEJqeGdPelUyQVErQzN1SHRaTjZ4?=
 =?iso-2022-jp?B?WTBFQ09oSkVVektRMU5oTW4yZnoybWtZV1FUbHlJaHpWSU05RWphLzIr?=
 =?iso-2022-jp?B?TitXNWUwSlJqSy9ua2JzTVc2c2dyckVBcGRuZzQzZFRzQ2lxcCtpZnBy?=
 =?iso-2022-jp?B?UWFCMUVTbnFDT1FiemNyNlZobFIxcS9kWmNJMHUrVXkvRmEyRGxUZEt5?=
 =?iso-2022-jp?B?bDUzWTh1bXpsa29pWTQ5ZmlTNWZnKzE5eVFNUHBMNDMxT1R1dUFIU0Rk?=
 =?iso-2022-jp?B?em1sejU1RHJEa2FWNTJ4WkorRUp0VVpYODM0R1NGMHhhSVZrTkM0V0NQ?=
 =?iso-2022-jp?B?bkhhQ3pOYmpyb2NRWU9SVUJ0Y1FIaEdKRkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZGvPaiAQ7Gn3GD1i2nIgDCwTCk2o/j4DedIdcY1CuDF/FrjQh20LQ4kjQGkWIKIZYi8ZjfojI7pStzxrGWM8OGRT9Gu60r1hLrp68ztUHGj/XhAOlmCoF9LE1f3SrlyBYg1UeSHSN40BN9faEMsuzPRQouVlsVJvWYBb3ZVeGphMH0U1hrU/fP20OipSKsUgwaSqtDFE+qTngTQJsx0LNHTXZ8IiUSZdfPlt8C/3qXRT0EEfM/xBiRWi4IiNAG6AyJYwezMNUOPV4xfPOXKaJCgbGhpBT516XlxMOq6J91tkEE+wmKJCRXCgV7rSyWiSrA7+KWMcg5+eOY37d843YXSOffglGgxYu9Vyw9hi/DhLW21WlU5mt5BQ4KbpgrWQOThz1MwDjnDOm/vs19pV6tN6ehizrwKeb5/MVQjTaIpX0/0/IcwfaMuRMo6RVxZvLLfCw61kHHdK1s0Jruuj23oSlgXSYhpTEiL6OP/boOjBM/ICJKmuXUxQyt76Vh8f6QVVd3BMeWQ7on7i34OTt44x+CgzvpDDMcQRx3/OfTzmtDLry7G7nCKLOG1xADvvV9E5KWuTz50AB/acJDGAxyRLX1k48t3VZ0c7HKWqIkTrMgvyf+NTyaVkwSP05Y5Q
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4725690d-89b7-4a81-64c3-08ddf65c08cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 02:35:30.1208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHrU+K8/wBsydtz9+3YP3ynObxtmMkJULSydiCWauUoJSphn0bohPK0Su3C1DZn9igu40FLsDuksJkfINdAyYDVBOUigvrDZ0TrXhruA7OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17272

Hello James

> resctrl expects to reset the bandwidth counters when the filesystem is
> mounted.
>=20
> To allow this, add a helper that clears the saved mbwu state. Instead of =
cross
> calling to each CPU that can access the component MSC to write to the cou=
nter,
> set a flag that causes it to be zero'd on the the next read. This is easi=
ly done by
> forcing a configuration update.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c  | 47
> +++++++++++++++++++++++++++++++--
> drivers/resctrl/mpam_internal.h |  5 +++-
>  2 files changed, 49 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> index 3080a81f0845..8254d6190ca2 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1088,9 +1088,11 @@ static u64 mpam_msmon_overflow_val(struct
> mpam_msc_ris *ris)  static void __ris_msmon_read(void *arg)  {
>  	bool nrdy =3D false;
> +	bool config_mismatch;
>  	struct mon_read *m =3D arg;
>  	u64 now, overflow_val =3D 0;
>  	struct mon_cfg *ctx =3D m->ctx;
> +	bool reset_on_next_read =3D false;
>  	struct mpam_msc_ris *ris =3D m->ris;
>  	struct msmon_mbwu_state *mbwu_state;
>  	struct mpam_props *rprops =3D &ris->props; @@ -1105,6 +1107,14 @@
> static void __ris_msmon_read(void *arg)
>  		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>  	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>=20
> +	if (m->type =3D=3D mpam_feat_msmon_mbwu) {
> +		mbwu_state =3D &ris->mbwu_state[ctx->mon];
> +		if (mbwu_state) {
> +			reset_on_next_read =3D
> mbwu_state->reset_on_next_read;
> +			mbwu_state->reset_on_next_read =3D false;
> +		}
> +	}
> +
>  	/*
>  	 * Read the existing configuration to avoid re-writing the same values.
>  	 * This saves waiting for 'nrdy' on subsequent reads.
> @@ -1112,7 +1122,10 @@ static void __ris_msmon_read(void *arg)
>  	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>  	clean_msmon_ctl_val(&cur_ctl);
>  	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
> -	if (cur_flt !=3D flt_val || cur_ctl !=3D (ctl_val | MSMON_CFG_x_CTL_EN)=
)
> +	config_mismatch =3D cur_flt !=3D flt_val ||
> +			  cur_ctl !=3D (ctl_val | MSMON_CFG_x_CTL_EN);
> +
> +	if (config_mismatch || reset_on_next_read)
>  		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);

mbm_handle_overflow() calls __ris_msmon_read() every second.=20
If there are multiple monitor groups, the config_mismatch will "true" every=
 second.=20
Then "mbwu_state->prev_val =3D 0;" in function write_msmon_ctl_flt_vals() w=
ill be always run.
This means that for multiple monitoring groups, the MemoryBandwidth monitor=
ing value is cleared every second.
https://lore.kernel.org/lkml/20250910204309.20751-25-james.morse@arm.com/
+		mbwu_state =3D &m->ris->mbwu_state[m->ctx->mon];
+		if (mbwu_state)
+			mbwu_state->prev_val =3D 0;

Best regards,
Shaopeng TAN

>  	switch (m->type) {
> @@ -1145,7 +1158,6 @@ static void __ris_msmon_read(void *arg)
>  		if (nrdy)
>  			break;
>=20
> -		mbwu_state =3D &ris->mbwu_state[ctx->mon];
>  		if (!mbwu_state)
>  			break;
>=20
> @@ -1245,6 +1257,37 @@ int mpam_msmon_read(struct mpam_component
> *comp, struct mon_cfg *ctx,
>  	return err;
>  }
>=20
> +void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct
> mon_cfg
> +*ctx) {
> +	int idx;
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	if (!mpam_is_enabled())
> +		return;
> +
> +	idx =3D srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
> +		if (!mpam_has_feature(mpam_feat_msmon_mbwu,
> &vmsc->props))
> +			continue;
> +
> +		msc =3D vmsc->msc;
> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
> +			if (!mpam_has_feature(mpam_feat_msmon_mbwu,
> &ris->props))
> +				continue;
> +
> +			if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> +				continue;
> +
> +			ris->mbwu_state[ctx->mon].correction =3D 0;
> +			ris->mbwu_state[ctx->mon].reset_on_next_read =3D
> true;
> +			mpam_mon_sel_unlock(msc);
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
> +
>  static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16
> wd)  {
>  	u32 num_words, msb;
> diff --git a/drivers/resctrl/mpam_internal.h
> b/drivers/resctrl/mpam_internal.h index c190826dfbda..7cbcafe8294a 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -223,10 +223,12 @@ struct mon_cfg {
>=20
>  /*
>   * Changes to enabled and cfg are protected by the msc->lock.
> - * Changes to prev_val and correction are protected by the msc's
> mon_sel_lock.
> + * Changes to reset_on_next_read, prev_val and correction are protected
> + by the
> + * msc's mon_sel_lock.
>   */
>  struct msmon_mbwu_state {
>  	bool		enabled;
> +	bool		reset_on_next_read;
>  	struct mon_cfg	cfg;
>=20
>  	/* The value last read from the hardware. Used to detect overflow. */
> @@ -393,6 +395,7 @@ int mpam_apply_config(struct mpam_component
> *comp, u16 partid,
>=20
>  int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg
> *ctx,
>  		    enum mpam_device_features, u64 *val);
> +void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct
> mon_cfg
> +*ctx);
>=20
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
> cache_level,
>  				   cpumask_t *affinity);
> --
> 2.39.5


