Return-Path: <linux-acpi+bounces-18515-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C67D7C347D5
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54C5E4E51B7
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E81222575;
	Wed,  5 Nov 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="x0vm7l6O";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FmL88YNS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B581991CB;
	Wed,  5 Nov 2025 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331563; cv=fail; b=ecZ5e0Mv3TI2qxooI9qRXaX0/RWzCmXuHM/uVNHbUWLuwQW2r7lae09oCbtlVYgjp9zVEeRGERCetyoaS5w3pyDBZxXhBnQMlkB74zm5Va2Wn6QjilqeKGg8BWXu0EOxzjFxo/z5gck1kDN5Aet9WrOerk0hS8AdFSK2/hdYfaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331563; c=relaxed/simple;
	bh=e6SZ9S8LJZcI7h2O+RQP4d0IV62bgygFXQZz8IpwNP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0HzUCS9Awy85QPKarwgOnjyMk/7ITYf2crKx1R6czQBdKGaydBhl6EvO42ZRkhGhfsiCBUl2m+WCmzjXnmDFHZ4+7uifl6ZqfRFosKfa6vszhxofVm56F/g07jhuE9j/7cuhROuQQDTMEbmYXFao3wI1tKHN6tJNpOYYITpKRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=x0vm7l6O; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FmL88YNS; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1762331561; x=1793867561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e6SZ9S8LJZcI7h2O+RQP4d0IV62bgygFXQZz8IpwNP8=;
  b=x0vm7l6OlfSLwhjmsxiAqS+SKKR7NzjMLhJab04UNYEY1noTHjcCoVFj
   IdrMTKM/PlI6pA3WdX9+u692AVSgs6aPQ+ylK8WYBf+vcTRhjS7dVfqL9
   3vsHTlsLARutaSR/O6ol66GJomOd+k04oxE1CKyd9pS7w6PPg7lSf8/p1
   7LEn/llm0Pcha/OPI7w+ALLMjMCRYmdx6CQbgNZoQX3wxZSX1YdeBS/OI
   XpJFaAVDtxSlwHTQ9XwQd8J9hbdWWvDwaeU9fAn8XgDU1cdwmFiGr4rKK
   b13lnMVf4ikt8o3bW8fgnZg3QU3s7i0APo5poH4zkfiPx821NPhhtaROD
   w==;
X-CSE-ConnectionGUID: tcWFhOHvSY6YokHnXw3iCg==
X-CSE-MsgGUID: 9vK3edvGSDmWvxp3JHpXxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="172623419"
X-IronPort-AV: E=Sophos;i="6.19,281,1754924400"; 
   d="scan'208";a="172623419"
Received: from mail-japanwestazon11010025.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.25])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 17:32:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I92rX/SnuGrdKRTPYt2fjgRoeqXuRRtum5QWZydoF/7d7EdgvqvYqOnPirqE55IV1pPs2YLeMgS+PBNt7k8c5oftlCK285RYxRkqeVmQDqrbBjS2PSFEPPc/mcJhBtineO2jnsuzzeEEhNfSznThpHQ8IuacyjoW97pbQCUHjyRPN+uRMAGBctOeMVz23fczj1n1Pvdn0ADjIK0Ak5PSW0/QXNho3ElP2y+Gy9dzldYiDZGhoVGIjRGWl1BpcWfv5uVPm7lOOrB358+Yu2+Z6wN3avyjKN4UUaK6cGIUUbJoV7D0xP0fef5gVDErRfvn5XSEK14FJFfXOrMgTbN6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYlp6GvbrHMp89MN1H7tBo0hdr2V36Lec8HKcmNpLPs=;
 b=i4vtkMaFAXruNZxLqC5Bdv/E8BBpoHk2a6P+x/tYw/uI2ixM2ROUkLjZORkfELz0hyZAQJObyYSH72hkssyILFlIcmKwxNW46hG8tEzQNIQLItNmBh+NwczOSYpvAdRSOU5gDvQ6H+4ixsDrl8S0bVFQXMcvURpQET0V4k7dfYfioeuKJ4yBxrm+ILFcOi0HsKckdYrbAMvi51AoCEZKFrpaFdCybKKi7N27i1JQkq7JK8q6MCWktFgB82D5c9sOM+W29pRaewhY0FTNT3jnSMn9ldRpCzQlCMGdmbQox2ByL3wrbW4S+TFy8bgpQzdzIw7zJbv6tZIuwqDFrK4y6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYlp6GvbrHMp89MN1H7tBo0hdr2V36Lec8HKcmNpLPs=;
 b=FmL88YNSLC+7uXQZ6ro5FHWS6R4nUYjdtJv01ORcIehAVFSJ3rZyPi6FNOAE8c2CSmTD8TD/8tnvcgeuKClRAhQuyHn7KnOykohqNZqCiTEH8MDjhNQAsNQGm2T7fvbxi7CC+CKokFitbDmoLjNJTvSjuFQE9pR45uVmVggzaTCMVG+MCgzNGZCvcGVecaoM+mZi5L7bGBDMPIL3jRe1dazmxt5Ib3VsMDrMCp8fMiIcWJwucy++uBWKgHHswJgIFXub2NesL95HXl8ffJ2xGrv3IO+tCgXtaActSdBVcPaEyjC7aI+GRB17NNp6jYJsB36et3jVc3SBEz5cCJNlTQ==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB10116.jpnprd01.prod.outlook.com (2603:1096:400:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 08:32:19 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 08:32:19 +0000
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
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Jeremy
 Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>
Subject: RE: [PATCH v3 23/29] arm_mpam: Add mpam_msmon_read() to read monitor
 value
Thread-Topic: [PATCH v3 23/29] arm_mpam: Add mpam_msmon_read() to read monitor
 value
Thread-Index: AQHcP5gi3HY59E83yESxgvOX1gpTFrTj2YYA
Date: Wed, 5 Nov 2025 08:32:19 +0000
Message-ID:
 <OSZPR01MB8798C425E5A820C2E0AAA7BC8BC5A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-24-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-24-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a2991e45-b8b1-42d1-88f5-c8ade33ba2ae;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-05T08:15:33Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB10116:EE_
x-ms-office365-filtering-correlation-id: 35466d70-c6d7-498e-64ed-08de1c45d596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?bE1jNlpEUDd1NUNlcmJUcERDakhRU2MyQlBrWjZsYysvMXc5eEpOQ1BG?=
 =?iso-2022-jp?B?UDkvaFhiNXVOb1NFRjBqM3UwUlZFRC9haEFkNEk4bnlUR243aWlJY2U4?=
 =?iso-2022-jp?B?VUU0VDRxdmcyMnBRNkp2bC85UUtBSmtEL2MyWVBNM3NFN213cFAvNzlM?=
 =?iso-2022-jp?B?VmpEczloTnhsa04rSU9JcnpPbU9SUDI5YWNHckhsbEw4QThqTGhwK1A3?=
 =?iso-2022-jp?B?a2lBUUdlQktwWW54YlRmRzJyUTFjVCtSVmpDeGtnUTY0NzlNak5XTTFh?=
 =?iso-2022-jp?B?dkJwRWo5UE04Y2IxeDB1TWxkL2FGeTBwTFJvc204a2ptSHNPNHQwZUNv?=
 =?iso-2022-jp?B?L3FsK014Q0FVa1Jjci9ETnUxdDJ2NGo4S3paeUIrc1FkZGlKL3o1dVdQ?=
 =?iso-2022-jp?B?LzVRaUM3UGdsN1NMWkZPTWhPMGFXRE43bDZ1K3p0Q3ljUllvMUZ2WEdH?=
 =?iso-2022-jp?B?VUZnSDZXaUNvd3lxc2N1cUdCS3B5WkFjREFPOEd3QWVBUnFWWEwra212?=
 =?iso-2022-jp?B?QWg3RW9sRjFDOEE4TTMzUGQraUd2VWJaZXpPRkowSUJ4a0pwS0N0dFBT?=
 =?iso-2022-jp?B?S0F6ZGMzOElZTU9CQ3N1L1lKNE1jRlB2VlRZaE9tSHVOQzlYVy9RNlRy?=
 =?iso-2022-jp?B?cnNVSGdlYU1SeFU0aUlXcllGN3laQzN0eHRlMkpobmw0a0orNjdqU0Z2?=
 =?iso-2022-jp?B?dTgyNDhYU2RZYkJKNFcxMFF3RHRaTE1UNFNZQnlVYmZnM1ZKRFNKS244?=
 =?iso-2022-jp?B?dnkyR09rTFdVUHdGaUppQXVoR0g0L3lMUjMxK3lvUnc3RndycDB0VXBy?=
 =?iso-2022-jp?B?VjUwaU1GdTJkRll2V1IrTU0yczRvb05kV1F6MkFRTnJmN2ltYitTU2kz?=
 =?iso-2022-jp?B?TVNMV3gzUE5DWE0xandOZU9melU2OVJZaFVQbll2QndKcTBZdU1qNTY0?=
 =?iso-2022-jp?B?QUxSSG9Pbm9vRXRHM0dkSG9rZFNpb29FWEFyMDd5bWVJbnRiaXhyNGJm?=
 =?iso-2022-jp?B?YU1aM1kvdXd3dlM0eUlML2pJbExvUGFCS1k2VHVsa1NsMG0rc2Y1NDJh?=
 =?iso-2022-jp?B?Y3J1dmFqc1lDNkVEYW1MZVpQZ0JodlBpMWhidkpnWEd1OWFncUdwZFFt?=
 =?iso-2022-jp?B?SlNZUEQ5MUp3b2xRN29nTDVDRy9OOHloY3pFSDUzNnp4Z295eFRUc0xX?=
 =?iso-2022-jp?B?RFR6UDQvSnFxUzZoeXNVd0w4MW5DUHlyRXFlQWVUODVtaFV3RmZ5emQ1?=
 =?iso-2022-jp?B?OFBlUlFJUmZUeEloRldaR1BIQjZxQm1QYTZWQVFtN25pSG5BS1RCc0Vk?=
 =?iso-2022-jp?B?bWY3U0Y1K3AyVndkYTEyMkhWNEhXOG5scmFJeUZ5dXZxaHdlbDAzQ2lQ?=
 =?iso-2022-jp?B?WW90MlQwdklndFgrcUZldThvYXlpbTY0emZlYkVOQ1NsQTVuTFdqRzdU?=
 =?iso-2022-jp?B?MGdvV2RHTXFDcndvWXVNQjR1VlJZOHJrZ3hzbHdzSnVSVDIyNmZxdlo4?=
 =?iso-2022-jp?B?L1MwUVlKbk8wTGV1QVhFRXgyNW9iU3cvVjUwMUpwaHhLTC85bnJVZG1r?=
 =?iso-2022-jp?B?Y1J1VHhsY1ZFTEs0SGlBRUZuMHhxQVVQd29NSTcvSVZsVWU1Mzk5TDFU?=
 =?iso-2022-jp?B?U1NRbkVmemJIdDZPWVc5SmlpVHhLNnJuSDRzN2MyNk5ySFN0empnbWEz?=
 =?iso-2022-jp?B?RG8xVjBsOSs1TEY3RC9nUDBBNVZyYlFhSnQwZlRkaWk4cVRlMjhYbkVu?=
 =?iso-2022-jp?B?TjNoRWxwYnNqdzZnSmU4eFZ3Qk43dG9PSlRlZXcwTnBqdk5reHc5YUgx?=
 =?iso-2022-jp?B?NW1VVStnZHYxV04wTU1NeUpiUHkrMkNBK3VWOE9VbDJqQUY5M0FZRzVC?=
 =?iso-2022-jp?B?ZmFNQnhhKzFRelJwTk1ESVRLdDlQeTJBS054T21CNVpYUFJyMFNpenR3?=
 =?iso-2022-jp?B?aHlJUEJIMHRSZnE3VjNWN0FlWis5Z3JaamlzNnJWNjdrM2c2MURmaHpV?=
 =?iso-2022-jp?B?ZDNXUUJPZk0zdm5DMStVR3BOd2JXU0U4azhIN0piZXlmTDRKZDhkMk1O?=
 =?iso-2022-jp?B?aWFaaUxERDI0Y2dOV0ZGUWY4S0U4T3JxMTRvenU1NFJQNzQ1NFkzVzdr?=
 =?iso-2022-jp?B?dU4yWklyTHJORmZvTHdHQ2dlcUZGU2x4alR4QTY5bmg0UzE5NkZ3SXlt?=
 =?iso-2022-jp?B?ckYyVERiaVl2d1dBV3hsK0xKM0lmMEZnNmYrRTB5TTdmUDdvYmdpS3Zo?=
 =?iso-2022-jp?B?TzF2bFI1ZGdGQ1pGL29wVEhzTDEvRC9Qcz0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WTM2RmJtUlF5SjNzQUQyT2ZwM084Q3ZMVEQyaENrRitXT244c3kvWlFl?=
 =?iso-2022-jp?B?T2JMU2NmZlpKTUxVUVhEb0hpMDFETXpENElOUUxzaDBlMWs1WmN0bWk2?=
 =?iso-2022-jp?B?SHUwMFdxcUVmaU1CakpBS0xXcysvUS9tWFFpTGg2MjcvQW5CZGhTOUsr?=
 =?iso-2022-jp?B?UFFNUFRLUlpNRFRZNkM2SVFoNlRNL3NoKzZlQXZlcm1lTGVCUmowdUtM?=
 =?iso-2022-jp?B?d0dlZmxQdnJjL2dQcVZBc0xnUXVlcEQvSmUyMGc2NXlIMTVURG9GTS9Z?=
 =?iso-2022-jp?B?RndESmpiZHlieHR1eGIycjQrbzhKdTVicXJmRnhycXBRbENWRG93Qm5I?=
 =?iso-2022-jp?B?ME1JSHZmT1kwblB2V1Y1Q0ZsbTRYTmkwN3hsNnExOWI1TGd1SnhISzd2?=
 =?iso-2022-jp?B?b1d5RG1FL2YzTHVvOXR1ZDcyVTZtNjVBOXNZeUNVbTNWaVJxRGZXZmZz?=
 =?iso-2022-jp?B?dm9vMGFWdzBjMW1nM0hVOWJjWnlxQlM3a2xuQ1crVS84Skd1QmIrOEg3?=
 =?iso-2022-jp?B?QTlpRzVoaFpKL1B0Q2pCSFpRZDFMVGgxVmQvSXcwQ2U3UGlYZkhnaDQy?=
 =?iso-2022-jp?B?a2tlZnFoR2phTlBna0Y5TTlnTXVGcVlIUkZ2QlF4MWhvUmRUZjg2TFVs?=
 =?iso-2022-jp?B?M21vWHZ3ZXF6aksrVTBPcnF1UjEyYTRSc2pmalpqN0dqOWhMVnlQZTNZ?=
 =?iso-2022-jp?B?NzhYcmtYdFFObXI5cHJKZFlXMUx5K0M2VFNqUkFCdUZnYko4c1dsdC9v?=
 =?iso-2022-jp?B?alZPNXVJRmpSdDJrRUcyUDIzTzZES21lenV0U0VaNkxpa0lRNm4zYWdK?=
 =?iso-2022-jp?B?UHFTNS91NllROW1jT0F3ZE8vWXV2TG9OQ3k1dlpUd01LcXBYS3FnaW90?=
 =?iso-2022-jp?B?WjIwMElCWCtMMWJTOFVRZ0VMREpud2YwUzNxT2NNYlhrdFlVZS82TmFH?=
 =?iso-2022-jp?B?Tm1KS2tVc2dXNVQ5WW5BUE43OVFIN2RhS2NxZDlCak1UY0J6ekprdVgy?=
 =?iso-2022-jp?B?UDdaaGlhaHJaQURyM0d2OUNoNnI0RHZnMHo5dWo1T2YrMVFhd2FiRkZx?=
 =?iso-2022-jp?B?Um1vSlh0cDBIa3hBOStDQjlOVnptS2kwUVJLVmtYenFuNlZxbUdWS3N4?=
 =?iso-2022-jp?B?elJsMmZDaXpBQzIvUEUwcEYrMFlWK0NGMFU0aVBjWjJRL3pZRDM4ZFls?=
 =?iso-2022-jp?B?elhhaGs5YnM3VzUvZ3BRbWxxeXIwUnQxYUgwMU9VWFBsZ29lK3pLa2Fj?=
 =?iso-2022-jp?B?Uk9wOTI5a1hySDNIUjZ3VkVsQ0lSazJjeit6RFUzOVZneWZnU2NmL2hx?=
 =?iso-2022-jp?B?L3JZMVhuZlB6Vm0vUnh0dS9UZ3l5RDNXTnYxU0dHOUhzZExXelR6WHd0?=
 =?iso-2022-jp?B?dFpMZHNIYmEzWjdIVS94TjFCdi9idUtrbkd5bUsxZGh6UFRPZ1g0ZThK?=
 =?iso-2022-jp?B?S0JDQlBxeWlrem5DY2NhM1VLd0kyejBCa0xzL0RIUHVwRXZsdW8zaDB0?=
 =?iso-2022-jp?B?WTFaWDVoTmhFeWVmS2w1OTNRazgvRzdqUDN5Y3NSQmtKNVBQMlpCb0xh?=
 =?iso-2022-jp?B?L3VsQWhVY1hZU2h0NHhVWithcmVaa0FSbWxoRFh4SWFJY2tWcmlhSlJU?=
 =?iso-2022-jp?B?dkMwaUMwclZSTmZlT0R2TkE1UXZPc3pKdEdYc0d3elh1dmFKR2s4aFRD?=
 =?iso-2022-jp?B?V0E4Z0M0c0dzUkcvRGJKSFNWVitFSlRuVjZvbFIrR1JqZzFTK25xWXhp?=
 =?iso-2022-jp?B?ZCt5NUN5VkNic1pwTUhNUzc4c1d4Q3NNV2xpWm5rbmZ2NERNOFZuakNC?=
 =?iso-2022-jp?B?Nm93KytIeUJVSjZ0T0JqZDJOa1JBdDZ1S2M4YUFvKzQwSkc4eWdkaVU1?=
 =?iso-2022-jp?B?V09JUjAxV0pzcUVLZExNL1BRbkZYZ1B1NFZDSURjdEJ2VDhKZWxsM05h?=
 =?iso-2022-jp?B?cktBWWxxVE92MHhjVkp2OFhybW5WOUFxR3JHU3F3clY3b0FweHRzTVJD?=
 =?iso-2022-jp?B?MnlCM1lxVEhHc0huWFRnRE9TS0hZUnlBV2VheW85aTlVR2YrSGU5Q2JQ?=
 =?iso-2022-jp?B?UXpqMmFOZk5xWnh1K2h2a2JraXRKOC9ITE1kb0dSWEtSMmVUNU1GKzZP?=
 =?iso-2022-jp?B?K3BiK3Bva0JYc1dRMEZpNENDclBzc04zUGJJTGVZR09hbzFoaEFMOHdY?=
 =?iso-2022-jp?B?U3pjQUovd3ZCeTdXd3RXY010SGluWlBMRWp3TEUzR1JzT0lsckVVNG4x?=
 =?iso-2022-jp?B?Q0Rod2ZnN1JJb2dmWnV4czBuV2hCS1IzeUJ0RkZUc2hpc2xXNFlaOHRF?=
 =?iso-2022-jp?B?Zmd0WG1oV3NRU0IydStOd1V1Y2JGNzNvV3c9PQ==?=
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
	j9dwNWL2J9YDJTaIqjPimCHO0KLojFRVbkFtPsSjLHi+nTKKGSmPY9BoPWkJQz9ysDlFl9hr/KMMRaP+j5EyJOzqElC+9Do3V7olOq6s83mpheMs38HDmHSKztAOAj22ZX6h37Ka4wjx0sqrAq8ReHhYOCy2/Oi0FetYYuKN0tHnTPOqUjTCu8ICS4Qbxlg7Pzp/WmzfE4acPGjKCkKlmT4+45Z7MdX2gE0FtKCogfAfnxftT7wYlPw1/2EHu/9GcIpoE+hPb4Mnoa8u81+UOdRySc+3875ZzWYFaFiloXY1bwdL4hZdcozCmhUOiQjc3UeYyIlRxKNQ765/jUj6qM6/qp84vHKTOJvR7I+htlz8iCt4j+MPscpNnmXgZi9NoGSNhnurAEZvK8+6u/yFAo8aW2nLPzVvmsy49tlSxOVBV15WXh0+wKo8GX81DV/yubQy6opDgx1cfXyALL0rX0YNk5FqFTXr5oFfs4Ox1Q7tl/9upnHM/CZezrvM1xrxU1LOnmg44cXHsydLzWM4em/lybArFlViLbd28tdG1AksxdO4cVJ3zkZ5Kw515D43lYQ8EmhwE6CQlEyLZlyjMZiPLXMSD0yBX63J3BxCZ27jD50GRzpJJyuHbHcA6PgY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35466d70-c6d7-498e-64ed-08de1c45d596
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 08:32:19.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qp8yPFQXWpwLscGIIWZ/+LbZ72aCZ68289uRcJK2HrRYIq9YwR62ofZo3h0BRqA3RnxxezHM+lSgX/fxGrDHqvTyQ8Pyp3xa4dVHR0teV5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10116

Hello James,

> Reading a monitor involves configuring what you want to monitor, and read=
ing
> the value. Components made up of multiple MSC may need values from each
> MSC. MSCs may take time to configure, returning 'not ready'.
> The maximum 'not ready' time should have been provided by firmware.
>=20
> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns not r=
eady,
> then wait the full timeout value before trying again.
>=20
> CC: Shanker Donthineni <sdonthineni@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Fixed ctl_val/flt_val assignment that led to always reading counter 0.
>  * switch to using guard() version of srcu_read_lock()
>  * Fixed use of rcu helpers when srcu is wanted.
>  * Use return instead of break.
>  * Moved variable declarations into the loop.
>  * Use struct assignment instead of memset().
>  * Whitespace.
>=20
> Changes since v1:
>  * Added XCL support.
>  * Merged FLT/CTL constants.
>  * a spelling mistake in a comment.
>  * moved structrues around.
> ---
>  drivers/resctrl/mpam_devices.c  | 233
> ++++++++++++++++++++++++++++++++
> drivers/resctrl/mpam_internal.h |  19 +++
>  2 files changed, 252 insertions(+)
>=20
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> index a29f97cd176a..fb5414c6b3eb 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -880,6 +880,239 @@ static int mpam_msc_hw_probe(struct mpam_msc
> *msc)
>  	return 0;
>  }
>=20
> +struct mon_read {
> +	struct mpam_msc_ris		*ris;
> +	struct mon_cfg			*ctx;
> +	enum mpam_device_features	type;
> +	u64				*val;
> +	int				err;
> +};
> +
> +static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> +				   u32 *flt_val)
> +{
> +	struct mon_cfg *ctx =3D m->ctx;
> +
> +	/*
> +	 * For CSU counters its implementation-defined what happens when
> not
> +	 * filtering by partid.
> +	 */
> +	*ctl_val =3D MSMON_CFG_x_CTL_MATCH_PARTID;
> +
> +	*flt_val =3D FIELD_PREP(MSMON_CFG_x_FLT_PARTID, ctx->partid);
> +
> +	if (m->ctx->match_pmg) {
> +		*ctl_val |=3D MSMON_CFG_x_CTL_MATCH_PMG;
> +		*flt_val |=3D FIELD_PREP(MSMON_CFG_x_FLT_PMG,
> ctx->pmg);
> +	}
> +
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		*ctl_val |=3D MSMON_CFG_CSU_CTL_TYPE_CSU;
> +
> +		if (mpam_has_feature(mpam_feat_msmon_csu_xcl,
> &m->ris->props))
> +			*flt_val |=3D
> FIELD_PREP(MSMON_CFG_CSU_FLT_XCL,
> +					       ctx->csu_exclude_clean);
> +
> +		break;
> +	case mpam_feat_msmon_mbwu:
> +		*ctl_val |=3D MSMON_CFG_MBWU_CTL_TYPE_MBWU;
> +
> +		if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw,
> &m->ris->props))
> +			*flt_val |=3D
> FIELD_PREP(MSMON_CFG_MBWU_FLT_RWBW, ctx->opts);
> +
> +		break;
> +	default:
> +		return;
> +	}
> +}
> +
> +static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> +				    u32 *flt_val)
> +{
> +	struct mpam_msc *msc =3D m->ris->vmsc->msc;
> +
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		*ctl_val =3D mpam_read_monsel_reg(msc, CFG_CSU_CTL);
> +		*flt_val =3D mpam_read_monsel_reg(msc, CFG_CSU_FLT);
> +		return;
> +	case mpam_feat_msmon_mbwu:
> +		*ctl_val =3D mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
> +		*flt_val =3D mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
> +		return;
> +	default:
> +		return;
> +	}
> +}
> +
> +/* Remove values set by the hardware to prevent apparent mismatches. */
> +static void clean_msmon_ctl_val(u32 *cur_ctl) {
> +	*cur_ctl &=3D ~MSMON_CFG_x_CTL_OFLOW_STATUS; }
> +
> +static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
> +				     u32 flt_val)
> +{
> +	struct mpam_msc *msc =3D m->ris->vmsc->msc;
> +
> +	/*
> +	 * Write the ctl_val with the enable bit cleared, reset the counter,
> +	 * then enable counter.
> +	 */
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
> +		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
> +		mpam_write_monsel_reg(msc, CSU, 0);
> +		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val |
> MSMON_CFG_x_CTL_EN);
> +		break;
> +	case mpam_feat_msmon_mbwu:
> +		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
> +		mpam_write_monsel_reg(msc, MBWU, 0);
> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val |
> MSMON_CFG_x_CTL_EN);
> +		break;
> +	default:
> +		return;
> +	}
> +}
> +
> +/* Call with MSC lock held */
> +static void __ris_msmon_read(void *arg) {
> +	u64 now;
> +	bool nrdy =3D false;
> +	struct mon_read *m =3D arg;
> +	struct mon_cfg *ctx =3D m->ctx;
> +	struct mpam_msc_ris *ris =3D m->ris;
> +	struct mpam_props *rprops =3D &ris->props;
> +	struct mpam_msc *msc =3D m->ris->vmsc->msc;
> +	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
> +
> +	if (!mpam_mon_sel_lock(msc)) {
> +		m->err =3D -EIO;
> +		return;
> +	}
> +	mon_sel =3D FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL,
> ctx->mon) |
> +		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> +	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> +
> +	/*
> +	 * Read the existing configuration to avoid re-writing the same values.
> +	 * This saves waiting for 'nrdy' on subsequent reads.
> +	 */
> +	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
> +	clean_msmon_ctl_val(&cur_ctl);
> +	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
> +	if (cur_flt !=3D flt_val || cur_ctl !=3D (ctl_val | MSMON_CFG_x_CTL_EN)=
)
> +		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);

When reading the CSU counter of a different control group, the counter is c=
leared to 0 by the write_msmon_ctl_flt_vals().

> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		now =3D mpam_read_monsel_reg(msc, CSU);
> +		if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy,
> rprops))
> +			nrdy =3D now & MSMON___NRDY;
> +		break;

The first time read the counter(MSMON_CSU), all bits except nrdy are 0.

This means when check the cache monitoring value the first time,
cat mon_data/mon_L3_0*/llc_occupancy
the result will be 0.
From the second time, the result will return to normal.

Best regards,
Shaopeng TAN


> +	case mpam_feat_msmon_mbwu:
> +		now =3D mpam_read_monsel_reg(msc, MBWU);
> +		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy,
> rprops))
> +			nrdy =3D now & MSMON___NRDY;
> +		break;
> +	default:
> +		m->err =3D -EINVAL;
> +		break;
> +	}
> +	mpam_mon_sel_unlock(msc);
> +
> +	if (nrdy) {
> +		m->err =3D -EBUSY;
> +		return;
> +	}
> +
> +	now =3D FIELD_GET(MSMON___VALUE, now);
> +	*m->val +=3D now;
> +}
> +
> +static int _msmon_read(struct mpam_component *comp, struct mon_read
> +*arg) {
> +	int err,  any_err =3D 0;
> +	struct mpam_vmsc *vmsc;
> +
> +	guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		struct mpam_msc *msc =3D vmsc->msc;
> +		struct mpam_msc_ris *ris;
> +
> +		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
> +
> srcu_read_lock_held(&mpam_srcu)) {
> +			arg->ris =3D ris;
> +
> +			err =3D smp_call_function_any(&msc->accessibility,
> +						    __ris_msmon_read, arg,
> +						    true);
> +			if (!err && arg->err)
> +				err =3D arg->err;
> +
> +			/*
> +			 * Save one error to be returned to the caller, but
> +			 * keep reading counters so that get reprogrammed.
> On
> +			 * platforms with NRDY this lets us wait once.
> +			 */
> +			if (err)
> +				any_err =3D err;
> +		}
> +	}
> +
> +	return any_err;
> +}
> +
> +int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg
> *ctx,
> +		    enum mpam_device_features type, u64 *val) {
> +	int err;
> +	struct mon_read arg;
> +	u64 wait_jiffies =3D 0;
> +	struct mpam_props *cprops =3D &comp->class->props;
> +
> +	might_sleep();
> +
> +	if (!mpam_is_enabled())
> +		return -EIO;
> +
> +	if (!mpam_has_feature(type, cprops))
> +		return -EOPNOTSUPP;
> +
> +	arg =3D (struct mon_read) {
> +		.ctx =3D ctx,
> +		.type =3D type,
> +		.val =3D val,
> +	};
> +	*val =3D 0;
> +
> +	err =3D _msmon_read(comp, &arg);
> +	if (err =3D=3D -EBUSY && comp->class->nrdy_usec)
> +		wait_jiffies =3D usecs_to_jiffies(comp->class->nrdy_usec);
> +
> +	while (wait_jiffies)
> +		wait_jiffies =3D schedule_timeout_uninterruptible(wait_jiffies);
> +
> +	if (err =3D=3D -EBUSY) {
> +		arg =3D (struct mon_read) {
> +			.ctx =3D ctx,
> +			.type =3D type,
> +			.val =3D val,
> +		};
> +		*val =3D 0;
> +
> +		err =3D _msmon_read(comp, &arg);
> +	}
> +
> +	return err;
> +}
> +
>  static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16
> wd)  {
>  	u32 num_words, msb;
> diff --git a/drivers/resctrl/mpam_internal.h
> b/drivers/resctrl/mpam_internal.h index 96a02ea95583..0c84e945c891 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -183,6 +183,22 @@ struct mpam_props {
>  #define mpam_set_feature(_feat, x)	set_bit(_feat, (x)->features)
>  #define mpam_clear_feature(_feat, x)	clear_bit(_feat, (x)->features)
>=20
> +/* The values for MSMON_CFG_MBWU_FLT.RWBW */ enum
> mon_filter_options {
> +	COUNT_BOTH	=3D 0,
> +	COUNT_WRITE	=3D 1,
> +	COUNT_READ	=3D 2,
> +};
> +
> +struct mon_cfg {
> +	u16                     mon;
> +	u8                      pmg;
> +	bool                    match_pmg;
> +	bool			csu_exclude_clean;
> +	u32                     partid;
> +	enum mon_filter_options opts;
> +};
> +
>  struct mpam_class {
>  	/* mpam_components in this class */
>  	struct list_head	components;
> @@ -325,6 +341,9 @@ void mpam_disable(struct work_struct *work);  int
> mpam_apply_config(struct mpam_component *comp, u16 partid,
>  		      struct mpam_config *cfg);
>=20
> +int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg
> *ctx,
> +		    enum mpam_device_features, u64 *val);
> +
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
> cache_level,
>  				   cpumask_t *affinity);
>=20
> --
> 2.39.5


