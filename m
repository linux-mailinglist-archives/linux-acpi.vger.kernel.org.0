Return-Path: <linux-acpi+bounces-18311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29EC18AD8
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 08:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51681354666
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 07:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562A8218821;
	Wed, 29 Oct 2025 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="X8waRzy9";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TCJlTfKX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2E1C861D;
	Wed, 29 Oct 2025 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722748; cv=fail; b=KsSfpINs6N0/6QFFHSRHaE/5UYOqYbosgjGilMKop2i/PaXJkaW9rKQCDh6z3LnxYMsQiwT6APqQBNWj5Sgwyr4E24n8xk+tykRjcbFUPdt9gQ7qvcjtdCQNaORFLmnhmB2zGg9Ob3BE2zAJCi8R9vQcCi1Lru6IRk/jINzexCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722748; c=relaxed/simple;
	bh=p9coGN6pOnR+VLLxOi20k7hlVVaJHihD6BeKmvoJzvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GafOBVcblcfYJBqwXDqF7wUCB3O3wLXa4TzXKGdSBH6pUUByyvFqL/qjXYpqcrVr3OSfrZp2EqOSEAQn48IlTb3cOiCEgKzJijXXv4hjcIIYBsH5elQyc160EsSV/U5LiUuVXUfW2ZP81qZqeAIM4Sr6gUIA+nfOEihHSUgVWyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=X8waRzy9; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TCJlTfKX; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1761722746; x=1793258746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p9coGN6pOnR+VLLxOi20k7hlVVaJHihD6BeKmvoJzvM=;
  b=X8waRzy9r8WTwMhv5Q4Uvdpd5qvl1uE/BzP42h3uhG/AXKFYch7Z7RJ/
   ggRhiGoeRjl6zeVE4eovIqFjYdkOHEmko4KkmgYm4Ubs29yjt/FlE2yf1
   P5oBjJrRd8S+8VjpXNAe9QSzgOVx0s8niaAH7aFFaVkhgiN/51YkJeY0N
   xLY89tepRx1ECIt8VBs7o9sJA9kwL3mTuBv+JdobT0ivPD8CXQjMSl1tx
   p+45iW3+C/L9F6ePCX15BSYKfHNyGBBJnJim99BUI4U0VJ4Z5GSapvukE
   5PNj8PFXLPJyYEVdnnPL1hY+TB3zTAmr3JLiM23mIegA+7Y+GvMrinXek
   g==;
X-CSE-ConnectionGUID: uFkatHXLSpyT9Cd9W6udBQ==
X-CSE-MsgGUID: dT8uuIx/TC+fpDNUEfS1KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="171924083"
X-IronPort-AV: E=Sophos;i="6.19,263,1754924400"; 
   d="scan'208";a="171924083"
Received: from mail-japanwestazon11011045.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.45])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:24:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqfU6JVWK87YFtZP8k/WdfasfG8weI8STT04rTvmdU0/Im+D4CrijD399ao+Yo76Mjd2jtncxHOXlu9hW6REOLDxyUd4rNLktgEqiZgfWsExRv/VOIfoIsfWFKxLv0xbM1RebPhrOZrYOCkYevWUA6QPdyvsIk8vbtyu/u2/EG+2YdoA1pjUP4fkFG+xl6QsYYlxyqgOO5CQOs8OlVDGC5ZnbumzCM0qb4Zd4bt4iAhQ9KTQV5zv1AjV5etpfgzQ8AEEO3FTtMaWrLhM9gRiPpzUEcUonVaUmbFEjqKwVJ9/OlospoOqOPAF2QSKozWmZ4o2WjxtgVXIi5yvZTum6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMNjL1LLbp3shUgElMFttHTPhCLXpivJX797As2fbeY=;
 b=LGFemNTIOyoW7pH8Ed6UwDjUxbzMElM9mqN0qiuCS6lWcCQ4pjOuHdqJJ2dzFVn2lxsSVMY0pXe2vLeL/cs3zN/cE9DuM2LBs66zvO/pUR+gfvClpxQiGnp2iTrJHcOfk5vhGIr33JL9uTnWt+CStdsJkmts0aSSzxy07rkgFBAi5u/yaL4Wr29WWyZvnw75ugfPIBlU0WpZSL3fO6Z9G8RQOaLoTVWSfJcKEyT2Bm/heN4U/2fSOMYGgtUubaEtSr46uqFJbN+JKCyh30uybHvfpLPT4bUyDWa/ftuZemN0hh91k1fODCF8tFXmVEjdNykJzm2VNws5BG3tWtrzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMNjL1LLbp3shUgElMFttHTPhCLXpivJX797As2fbeY=;
 b=TCJlTfKXCdJra3kIC/eIUvfAaZsRj5P5Y06TOfK9nQubQtFhQVyjtk7iNFsoUPu7UakqL7xkHdM341pthENbr6qEpiKM7h4t51gGcidkLfan8Cxkh1ZaNyWsouDShDm2oM79WnTcpqUMO3ELS9ftFcolENSd5XzktdptW3nq8bf4NwqAAKimX89DIq+tJKLSsWziXbePI4j2wemHB38BANgJHlAc1Mvsavbr4zTQoza0j4/+rrMHbAQg85XvKhGSbi+N19nE8vyRO8A6RYMNX8dwMvMeqDy/hlxZjEPZFHFka7GzOrIZWnys9vQ70rDsUm0aQIsUWos7t6yoUmdl/w==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OS9PR01MB14270.jpnprd01.prod.outlook.com (2603:1096:604:360::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:24:20 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:24:20 +0000
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
 Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>, Lecopzer Chen
	<lecopzerc@nvidia.com>, Ben Horgan <ben.horgan@arm.com>
Subject: RE: [PATCH v3 10/29] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
Thread-Topic: [PATCH v3 10/29] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
Thread-Index: AQHcP5f45PPQxKcOh0GOW5Sghg6mmbTYyqRg
Date: Wed, 29 Oct 2025 07:24:20 +0000
Message-ID:
 <OSZPR01MB87982433DCC67E55C90297F28BFAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-11-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-11-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=33f60ece-9bf0-4dc2-ba9e-d0967a870547;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-10-29T07:23:25Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OS9PR01MB14270:EE_
x-ms-office365-filtering-correlation-id: b8a0e5f7-8a39-47a1-d017-08de16bc2d44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?MUVlbTlNb1BPQ0F0aVdub3lXZWU1cWJ4SUxMRWk0b010QnJySDF2VU9Z?=
 =?iso-2022-jp?B?YkxaREdmNzJRTG9EQ2JYOXlkYlBWSDhUaFdIbTNPTkxUSGk1YWNhUUp6?=
 =?iso-2022-jp?B?N0drTTdNVVRvOGdSVkQyUTIxdEpLK21iamRVSGtLL3NleGs0YlY1ekEv?=
 =?iso-2022-jp?B?MTZsUk85aHJuVWFGVFlMQ21LaVVQTGQzZ1RkQzBGejUvZmE3cTFPTE5k?=
 =?iso-2022-jp?B?dlNQdjhsbUx3WXd4ZFU0TmpvNndqdytlL1I0WmN0LzNZaVJCb2xPLzhl?=
 =?iso-2022-jp?B?UG1IS3NDR2VjUnNHWVJzSjNDT203ZWRZMU1Ia2NsYk50aTFBQ1pScVFL?=
 =?iso-2022-jp?B?eXBLekZuOXEvOU9TZC9vSjgxRHpCcTZaRzNIYXV6d0ltbmlsQUhaQVEz?=
 =?iso-2022-jp?B?NXF4b1Q2aUkycWRPZDFzdG00SVMzWGN4dUtzSk42aGs5bkYvTU9VdGNN?=
 =?iso-2022-jp?B?TVJGT0I1dEpQZVFPaDBDV3BTazZLU09VM2Q4YktReUFYRkNCVjBoMlY0?=
 =?iso-2022-jp?B?QmRDS3hIbXdDRTlZVXJLVG50dDN6UmpyK0J3TFFleXM0VFZlOGpyUmdX?=
 =?iso-2022-jp?B?KzVMK3RTZkFCcUt4UFR4YnN6a0ZXS3FFT0ZqVzM2bWVRM3Vycmk3a2xx?=
 =?iso-2022-jp?B?ZzZablRpbGllNWF5MFRhKzkwK2FYR2pRdUdneXdiMzZWNWJ5KzdxelUz?=
 =?iso-2022-jp?B?aG1oZE8yWHo2eXZzbVdBQk0zdmViTXlycnZxeWt0Z2FVbFhMRU5Pbjlr?=
 =?iso-2022-jp?B?MVphMURiYkswQ29VZUFMM2YzeEN2eHljZkR6cW4vZ2tLdGxaUEhXUGta?=
 =?iso-2022-jp?B?OTlnWjBPYUsyVmdab0hCUys0NFBBbWpoZTFCUnM4TFFjTWo4enNGeG5s?=
 =?iso-2022-jp?B?ZG9BQk90dFhVdTBSS1lXdEJUN2RFNGFjK0syaEd5RGI5cDYwRUNEblY3?=
 =?iso-2022-jp?B?a1NrMzVmUHBhZlNIY1I0NVltYjJXYm9tOTdNSUorc2RFbVVpRVFwMTJj?=
 =?iso-2022-jp?B?OE1hZUJycWdCQlNVU0ZTQTJVVnFPWnA0QkNFaUplOFlyd21tMzkrcWRF?=
 =?iso-2022-jp?B?UEVTZm9QclpNSmlpMm45cDgzcXFBc1BCQTNwU1JIU09YZWFFOEZwMTJT?=
 =?iso-2022-jp?B?RXBLeEZ4amg5b3BBczN0N3JaTG15UHhVV0VMVEZHdDJQM3BDTTExWk9D?=
 =?iso-2022-jp?B?eDZzMTBvTlRGbURtd3lvK01DYlh4Ly9sMlVCLzZ4cTd4cmtFK1lQVWow?=
 =?iso-2022-jp?B?RVFZTDcwTmI3VnRKdUY2YnNLUGh6RWNOemZOUWxPUjFWUGlrenhWWUV3?=
 =?iso-2022-jp?B?UmN6SGttSzc3SWR2TDNyeGdMQnBLSW1FS1JXWU9jd21ZSDEyTEU3U0hG?=
 =?iso-2022-jp?B?TGx6RDQ4bkJRd3VFcmdPRnRxaUZBWi9WTG83eFdWSTdIRm9pYlhZQ2hi?=
 =?iso-2022-jp?B?WDUybEJKRFY2UzVMb0hFbm5sMHlMUmU1SWZFOHBRajRUSG9McEU0Wms0?=
 =?iso-2022-jp?B?R2d0RFI2TDFYOHExRm5tZjlJT21uaFoxa0JFeGNUeVZkTlNQUjJEUXc2?=
 =?iso-2022-jp?B?d29tMCsvZnh0ZFR4UmhKaHR6d1JuZ3V1eUlqWk5PaURzTHdNT1hzcVlV?=
 =?iso-2022-jp?B?WEpoNFZDRW5LQ2lDMm54VUxCM2FnR2NXK3E0Q3NWMkdvQkVwRzBJU2w2?=
 =?iso-2022-jp?B?eFp0TU9GS1BkbnNXbWNOSElJTTI5V2UyVzh2R09FbXRVdi9vUXVlUVhk?=
 =?iso-2022-jp?B?OW9qOEdRcW10N0lyS1BVL3RYdk41dHRlcFkyb1E5ZmNPLzZHTGlJSUg2?=
 =?iso-2022-jp?B?ZFhEaU9oTndnZDI1UjhGWUdrcUl6SHErRzU1NTZZZ0FVZmE2aVZaNGxU?=
 =?iso-2022-jp?B?Nmg5ZVhMUURHUDVodWpWL2UvMWtBeGF3TUMzZTdBd1hXMVhmOFM3MUxj?=
 =?iso-2022-jp?B?UDlHaktTZlE0WHd6UjY2U0R5L2VKdmF5MzNvNW90VUs3UUZ0M3M5ZTgw?=
 =?iso-2022-jp?B?NWxSckk5Y2ZKNEFIYUNxZTBwOVRIZFhwYWFneXZreWRpZjlyZnVzaTMz?=
 =?iso-2022-jp?B?WHE4S2RiNVdCL2FSTVdqUkRBM044eGtOdFFQRXBFRE5jcTRmZGZxckRu?=
 =?iso-2022-jp?B?aGFvaEpxcmxrQytyWmUzcUp6K0c1SHQzcllEWHJTVmVuZzFHd0VaMS9S?=
 =?iso-2022-jp?B?U0htMzZrTDdST1V5NWVndjNteWZzamZ4RzZ5K3QrWmJCd09mc2tjcWpB?=
 =?iso-2022-jp?B?a0NhQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?bkdDWUU4ZWhWcmoxbmdHQjJubExMZitZL2JZaFFHQ0V6akFFUHUzelJz?=
 =?iso-2022-jp?B?OFBuOGc4SFB1UXVLbjRRLzNtOTlYc1NmRlAyZFBYTGRmVUpjOHFqb2Jt?=
 =?iso-2022-jp?B?ZG9Oa0hPWVZhenN4bG8zcllKYWdPaTNqTmdxU3BxYlNRVGhMU1JodVpy?=
 =?iso-2022-jp?B?R29ZSDlSODlaWGlTNmZodnFXSUdFY2RSdUZuUWNSYWRLcjNwM0dCWElo?=
 =?iso-2022-jp?B?M1NnaU50TXlCV1JMMjhjcWhyb1ZFSUpEcU5GQWRUSityMHl1bi9hMUlM?=
 =?iso-2022-jp?B?MHZFOFpUVjhNL1VManVhbHRsTm9seStRYzVwVDNjMFNjeE1rczlIZHdC?=
 =?iso-2022-jp?B?WFF1UUtwMVFTNW4vTmtQS0ZoZVdMZG8xNStxNzBPMitYYTlaQW52WjRR?=
 =?iso-2022-jp?B?ZGI0WDRQdmhGTHRrTzRFTDBDSGkyekFRQnRxZWh6ZGh4NTBITXlHS3lZ?=
 =?iso-2022-jp?B?YzVRMlA2WWJmRlhUUE9sYW5JRjc1TVBMOTIwWjl4VlpMSWNUZHBxWUNI?=
 =?iso-2022-jp?B?SFN2V2ErTHpFM3ltU0NWQ3g2TGRKMjc1M2lkLzllZGp1am0zS21DNWdV?=
 =?iso-2022-jp?B?NFdaMnRkRTdicXhkRUpMcGgvZURFKzRxUitkbDl1ZGEraE9lajdrTk40?=
 =?iso-2022-jp?B?RWdNU1l2RXRiVVNzRWVsbnlwU043Uzd3TUFndUp3cGtoZFJ1b2phVEVT?=
 =?iso-2022-jp?B?RENDWDU3LzN0d0FmVmNjU0lNbWhSZCtqL1R3ZStQNHQ0ZTd3WjRVaWtq?=
 =?iso-2022-jp?B?NmxhZW9qUDFQeEVYQXd2cHc0TlU4QW5WRFhjM1ZTV1JPUnozNWIwdnB0?=
 =?iso-2022-jp?B?NUpFYlpKTmVQck9HRm0vL2ZLMFFmNTJob1BzR2NpMktkV3VNRW0rQStV?=
 =?iso-2022-jp?B?eUtPcHpJaXZEN3BMUnplNXBwV0REZ2hIeFNwb214dFFkQlJiaDRkMUZL?=
 =?iso-2022-jp?B?K2xaZVN3VDRQb0RiNkhIbXliekkyaGdFTFZKRWJiVDZFTUYwY2tKMUU1?=
 =?iso-2022-jp?B?K3ZXY3B2aVRYYmJlVU11V1lORWJzKzhVd3NOd1ZCY1VVRFRhTnlNb0tn?=
 =?iso-2022-jp?B?Mnh6cFlpdXNBcGhTSTJ4TXBoMDNqaFJOKzRlL29IR2dGT0RabHltMGN3?=
 =?iso-2022-jp?B?NUZ4ZXljaS9SdTZBaExaSGxkUSs4Z3ZWYlJPQVd3cWd0UWIvNkdOZEor?=
 =?iso-2022-jp?B?emkvVG1oSTlKaDhyMmxMekNXeUxaREVkK3paUW0rTWxnMXpwMGwyRzlp?=
 =?iso-2022-jp?B?ZEgzL0Nxa1JIb1dkYjBnVk52U29kWUY3TmFKcjNrVHJPTmd0aXg5Vnp5?=
 =?iso-2022-jp?B?SVVPNnc1cU1oT0dFT254YzJrUWtVMFRvbEJ0R2xQZ2syZWVvcnh1L1hu?=
 =?iso-2022-jp?B?WTBrQlptOU13SlowaVM5RWQxRzNVaU9HcDcwa3NCZHBhSmRxZ0tzZmk5?=
 =?iso-2022-jp?B?bTdjL3YxcWI3NU1aTTNQNXBIbUY4dVU3VStJeCtzZG5PK2JHR05IRUZz?=
 =?iso-2022-jp?B?RzFEc2hndWZCaUlPcHVqSzgyejZDM1o0dVV2b2FieGhRaGgzZUpmT09h?=
 =?iso-2022-jp?B?eGtVS1JCM3FwQkFva2V4WGd5Rk1pMFNIVmNmaWNoQ1pscTdTN1cyNDAz?=
 =?iso-2022-jp?B?SDlONGVlSmU5TzIzakY2Nmt2aUV1UlZ1TjR4M09LUzU4bUpwYWdDQTh4?=
 =?iso-2022-jp?B?eHFyWjBjSVd6VFN0MngwWDduSWJCazZwVzF2eUtXNlpYV2RaN3ZlUHdC?=
 =?iso-2022-jp?B?RzE0VDJQZUZvbkNRaTJzUHdNdElpTjRNblkxZW9ROUVxN284Y3BvTWcv?=
 =?iso-2022-jp?B?Y1hIZU40aDZZR1A5MlVVdnpsRUxWTkVXSTlYTWxOTXFHRFB5YjZDb2hI?=
 =?iso-2022-jp?B?bkJmbjZDa2RRd09PeHpKQ1V0SHlZZWFmeFJHQW1mZ1dESEJBWkNQMjd0?=
 =?iso-2022-jp?B?aVVNazEzSUloZUhmdTBmdVZ3elJmKzlzbmRNQmFOSDkxWXZBWG02dHVa?=
 =?iso-2022-jp?B?cHZvNVFaZitpdDFKdm0xSVk5dGNkVkN5aG8xMEsxSEpGYXpqNEJ5UEdj?=
 =?iso-2022-jp?B?UjFTMzZJRHgyc1NQZ2JNMHlHMGVYTmJrWks3TUhaTTc3a2RzQU43OGxa?=
 =?iso-2022-jp?B?dG8vTXFLcDRyYzJrL3pUQ2xqc1g5VkZjQkMxS0VzUURJVk81ZHhTQm1j?=
 =?iso-2022-jp?B?Ni92Zm5zajhlc0xDZVlDSVRYUEJkNldGQWN1cXdQZjdHVHg2dUVCUWFs?=
 =?iso-2022-jp?B?cnZXbnA0b2Y2anRBdGRLSUljWDNPV3g2d1FlMnJ6MFp2U1ZVeThYTEhB?=
 =?iso-2022-jp?B?L2NxYTZER0J1V2dJQ2pZdmdZMHJ0QzRMZ3c9PQ==?=
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
	xIFO9sMzASA6aTzU1IbB7CioZtRmJ2iRLXAiVewPVar8zVDWNNs1CYHNEFHV8eVz2DbOUkwoY52n4isZRZs4gLDXGjENwcEj/fhBIfXGDdHQvMqgWaWk8PWYVggNnh/fSNI9UuDJdHJ0xarK9LWvvS4/aheQZJ13HGRcJpDzkNsPjZER5AelPD/jv7XUX9deIypD6Ne/FkMlpW3dzx5hwh6/FJyosRzZAPUNhbKHrL0qxFJCITLlrHIrcPfWsf0MgNrjla+QNsbxe27Z5IcQ5b2GcEhWUNGDWHHkuNTgj0QEQSgRcYsZKiNB0uHkZaJWS5lrLmJMdDKv+UM3nnlQc2vSLB6H+CbDezWvFbGjlvmd5k+nLAEop9fJCThHKqn3pu0pEsm8bs9mU8TPBmBM96uckXnacIy/bvFCWxfML1YneGx/0YQ7Xu/n560R0gNd+KiYkf7oqwQnR2QmlnbJvNYHIX2u0ppcxYNUcY6CZ/NK9B3/stTLxv95pmOvYpCO+h2KO7EwB1UVyoqTlZxPe7wd/L2ZZBbtwMD00529yhEI1ovm/0uobe3Ws0Y9UNz1Va9VlbhTSy+MFPO2OnAw4WhK1/f3aYSXbMictP8+YmwRJoaBtnfebEHVssVfBiRx
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a0e5f7-8a39-47a1-d017-08de16bc2d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 07:24:20.1615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1nuZ7Loml60XlzFN0gPufHtRx6InCPQEztdwEDDx5YFEm+fI4M7or8/zXN0duby9kR1a94t6UIpEG6oq56QhVBNpTTqdu6dNM4OrA93vdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14270

> Because an MSC can only by accessed from the CPUs in its cpu-affinity set=
 we
> need to be running on one of those CPUs to probe the MSC hardware.
>=20
> Do this work in the cpuhp callback. Probing the hardware will only happen
> before MPAM is enabled, walk all the MSCs and probe those we can reach th=
at
> haven't already been probed as each CPU's online call is made.
>=20
> This adds the low-level MSC register accessors.
>=20
> Once all MSCs reported by the firmware have been probed from a CPU in the=
ir
> respective cpu-affinity set, the probe-time cpuhp callbacks are replaced.=
  The
> replacement callbacks will ultimately need to handle save/restore of the
> runtime MSC state across power transitions, but for now there is nothing =
to do
> in them: so do nothing.
>=20
> The architecture's context switch code will be enabled by a static-key, t=
his can
> be set by mpam_enable(), but must be done from process context, not a cpu=
hp
> callback because both take the cpuhp lock.
> Whenever a new MSC has been probed, the mpam_enable() work is scheduled
> to test if all the MSCs have been probed. If probing fails, mpam_disable(=
) is
> scheduled to unregister the cpuhp callbacks and free memory.
>=20
> CC: Lecopzer Chen <lecopzerc@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

