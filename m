Return-Path: <linux-acpi+bounces-18241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F8DC0C816
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 10:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA7C1889950
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B4F30DD3A;
	Mon, 27 Oct 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="T+DUh1T7";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BreOxv9p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666D2F6173;
	Mon, 27 Oct 2025 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554895; cv=fail; b=crrIiFdbEoJOpyXaG2tpfj8A3o9kpPG04zvpv2PTwsBnvnuBZNyAUXYsjMJAiGKoyrwYsWr0MBavx/KXbjRYkIk35bQjf5oZTFTlBOcffL0fF1OZs/b7MgO1pxCPvPEae1EgKwxulceX+F2r+XZNmAVtaSxB9PicDzYoHxFDNE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554895; c=relaxed/simple;
	bh=/laQqOjdghiXHI1HRQyNzWnjbx9hM6yctZDOV8BGggI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GftM9kNMhO8f+DZTAFxjNgwWKhrescIG/8DhXo59eaI2HTS+XsM4RXRX9eV6dSKPlL0UuBD88RoraNOSENkv9QQLA0qRaLOnyQZWQokJbIyNyVOew+Y4mulF0zFe2Dh8eWc1sWoVDjKxc3eci4puz8WFzcwVxR+9Lz3IjJNrEGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=T+DUh1T7; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BreOxv9p; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1761554890; x=1793090890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/laQqOjdghiXHI1HRQyNzWnjbx9hM6yctZDOV8BGggI=;
  b=T+DUh1T7WkGkgMTPPs+4i1hQhwf620YxerO1W/7tQhbPTEREKH3SeQk1
   xvQr++8oKEJMxuJiNRXlmu7xQn2k50HtgnRf9C7lkEAH7x+ZyPukhU9X+
   OFNaKhzg6U6teiVG7rdajUJn8x7Svof/WDLkUyP44PZqpfMT6fkO3mJQL
   2kr8/1+IbYBd5PiHqBII2n6DOu1vHc/+OofTI4DMZWDnZbaf15Dr3DTh/
   oIJa0EFHqCnOL9JvT7HNNSPJHu52j0ML5nwf35/vhCmIrs+ZMSB+wXeH3
   uUGb3HBz3bSf29kuUAouOiS7xmIZfIi0pQdtTQGD4TD20qMlurUh8W029
   Q==;
X-CSE-ConnectionGUID: vgTxuyBUTSG6NMMaCEG75g==
X-CSE-MsgGUID: gyYk8cQQQP6HDMl+tvPXfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="172035044"
X-IronPort-AV: E=Sophos;i="6.19,258,1754924400"; 
   d="scan'208";a="172035044"
Received: from mail-japaneastazon11010041.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.41])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 17:47:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wS8xg7ODuolndocy6VrYv3wzlsx0+766VeQ4oEzfFhxs1NFj/mJJtSDo9hvx9b9E8MJ499E971LUBeJUYDhms6w3FNvOME/JbX/+Wp+Ph0wCkthfXcBm/ah+p7OC2GLR9vS6O/CxEFQ+zXUoHxMnizYCjlJaiB7/cCH+meIyH8AS8H/H09OtQ5hzj34kokXhm3G6goDjTloGVvDNnGT4EDQuGdW1DS+INSSdu7hbSPnXemqz16Dt11nVk96xO/Q23etlY0O1ro1gPYoQ1rhgW5LW5MYjhc/Nku7h2dENG0aXPYLRxi8GMU5gCx9L+FIwoA093FCbylsLOtzvl2wjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVWBFP4V+fvPG21h0ewYfGHYKt4bmVOJvGpbD97ZBCk=;
 b=gJdIIySDkfS9fXVyqCYzlAVayq1i2xQk4rGW5o8LeuOYxsLKaPKgGJ9ignytZGTfeqsXBMHOjihlD/gohEEg1oZr/6R2D77SytxAcx0H3vK3mOzfv/C2HhGI7ydn/3vlL4zrmIa7hmvS76cKhX9jPF6qGMUI5Bnlylh7ZphAA/aWATI7xyoOdSS9MQbVcDxJRfVWi6/nptor+X+5SK/aaobE0IwfsH8gImGxIg0B5qAnLfgFQcwUxlNsYc3WK1/sLnD4vUe7aneWMfpsMtGlH7ZMvaI/8UTERJnoiX904zpMGVvCudrbOeiKrl40GC35PEOoR1+YQ35/U/40sVgHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVWBFP4V+fvPG21h0ewYfGHYKt4bmVOJvGpbD97ZBCk=;
 b=BreOxv9pvlEJEk/B7PAZ+sTO/75xXDNjKtcmGprUxz1dz90wATftCYyF5lUN3c1ehn3F8BCgnkAA0EaX7r7I++xUswjuCp52hFqdgZZtZFmEZgBN4YXQpb//TS2xXRDyDYVj/0QkyGOMLFcpuPyonmPkY1BKy4fLGdsGO+ccTddcR+brcJkgXxC60syOH9m1kNrYlwbpMW14mcHK1RaGW3664R5yVI3M1d7N74ZPgjVEpyVzaDXUGDuyhdabLcBjTcBv499u1/LysNwbI4B1Z7yMrb7bbXNjBP7SVXDlkvOjICoZChsDhD/9vz7LFqoRNZ1jMTxHnbO48SDN92izMQ==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OS9PR01MB17072.jpnprd01.prod.outlook.com (2603:1096:604:410::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Mon, 27 Oct
 2025 08:47:45 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9275.011; Mon, 27 Oct 2025
 08:47:45 +0000
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
 Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>, Dave Martin
	<Dave.Martin@arm.com>, Ben Horgan <ben.horgan@arm.com>
Subject: RE: [PATCH v3 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
Thread-Topic: [PATCH v3 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
Thread-Index: AQHcP5gc9dQ0/jFTe065wirKGjIQ9LTVuouA
Date: Mon, 27 Oct 2025 08:47:45 +0000
Message-ID:
 <OSZPR01MB8798162B444DA35707A4E3798BFCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-21-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-21-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=84193180-0c3a-4636-9ac3-a559e5fbad3d;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-10-27T08:37:02Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OS9PR01MB17072:EE_
x-ms-office365-filtering-correlation-id: 3ebc76f4-bedd-4935-196c-08de15357fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?TzlpaDd3Wi9Bcmt3M016Q29CMWF5Rm9Cd2RyY1cvZ25NQTV0ampBK1pp?=
 =?iso-2022-jp?B?dGloY2tOM3dxbHZUME5rY1BZQmE4NlFkOXhXdC9nRDlCM3FWcmpxalF4?=
 =?iso-2022-jp?B?dkt2V1R0SGdQdWZGWEdPQVo2cmorV21pRzNVbFFsMndtc3pBd1BXWnJ4?=
 =?iso-2022-jp?B?ZkpjcDlCelhROEliYTV2UlZIZCtzUzkwKzFQZWVUS3JaNU5sUnFMWksv?=
 =?iso-2022-jp?B?bWVpdHAzaUkwbVJQYWJjT0dIdFIxVit1N0U5YkN2V0VJS1hPTjlMdmhQ?=
 =?iso-2022-jp?B?eUtsZnV1a3U1cXpmZmlYUnkrZFhkVkJDU1dqZ3FaUzVqSkVKZFhxZzBC?=
 =?iso-2022-jp?B?Zm96YVgzL1Zud1NacTI4NFJmM2pTbWd6elV5K2J0NTFDTSt6R2FYQXZU?=
 =?iso-2022-jp?B?TTJhVzhURjNTdzRsQXNIMjF4WXpwa204ZzdybUtsUnNja2tWN0drY25E?=
 =?iso-2022-jp?B?OHNEdU9sUTdTMC9hZ0xpSE9NMVQ3d1pFcjBVT3VMTkloNk40SnltdkVa?=
 =?iso-2022-jp?B?eDA2REZuODdQUmVaM1BOdXoyQUlWdVlXMzltVnJ4YmxGbFdGSlFuRVVV?=
 =?iso-2022-jp?B?Wkcrdmh4ckJUb1B4TWs0RFlqWWVsdlhkOGdQMll5ZmtIMjZwb3czY0Vu?=
 =?iso-2022-jp?B?U1NNbzFaVUpWVFY2dkVXMTFCeFFzZzhtZkVVMWxvZ1JQZWt2Y3FsYVV0?=
 =?iso-2022-jp?B?VmgzbHpHNlRxU2cyclhjOFF5VEVzVWdueVkyTTRHZGIyc05xTFZZWHBQ?=
 =?iso-2022-jp?B?UlB3cGNremg4dVFpRUdSTEcxeVpueGlhVWpwYlYvd01STnU0dHlZMW9k?=
 =?iso-2022-jp?B?ckNkUlFqeHdscG8rb0RQNXZSV1lReE9maEpYTm93ZnZiUm5Pam8zTDNk?=
 =?iso-2022-jp?B?N3lHQWJJeStlQ0RpTzRqc0U2Z0Q1NVg0SDdXeWVFMHlwUHVhcCtseXBy?=
 =?iso-2022-jp?B?OVp1b0V4Rm1TS0tPOWNFVzhlOFJQUW9nWnJYN2tMNU5QRk94ZVh6Ulhs?=
 =?iso-2022-jp?B?dDB5ZXlJV0lrUHowUkRRK3dXMHhtRUhVU3lENXl4QXpjVmdZMVFsNEhU?=
 =?iso-2022-jp?B?YWJqcDNseHVHMFhDY0xpckh4RTFLVjMwWktnODROL2k0eGFDQ0w2cUxl?=
 =?iso-2022-jp?B?MHpnSk5Wd3lpNDlpTHJ5TUhVODhZaDBSbi9NL0Y3M0t6cU5hcU82Q3d5?=
 =?iso-2022-jp?B?SmY5bmVSeWh3YzdRZXg4THJsMGxPT2FxS3FmQnJSUW9oeHVraTlqWCtC?=
 =?iso-2022-jp?B?QzhmYVB5N3E3Z05vTDVIWWtzV2U3bWZTczVsYTZEL3hZQzh0NVhreGE0?=
 =?iso-2022-jp?B?UUdvSHNMNXRmbmxpLzloMWxxY08vT1ZvUDcrUTNrcW5OWHZ4QmlQV2E3?=
 =?iso-2022-jp?B?ODBEcUh1SVVra1dyLzNiRE9JR2szR0FDVmozcVRUWHhscm5qMUtGa1p3?=
 =?iso-2022-jp?B?elVORlp6WFZxdWdEQ2RHa1piZEhKSFBVOWpxTG9QZGVDbjhXZGpoZHUz?=
 =?iso-2022-jp?B?OFZvQ0ZJWjUyTkRBa281bGZhNHYxOUV4aHlNZ1o2OGxvdnptbkJEYVgy?=
 =?iso-2022-jp?B?NFUxSzhlNGpQM3A3WDg4R2IzbjA3dlVrc0Q0THE0bDI2ckxhWVkxODNz?=
 =?iso-2022-jp?B?Y3hVYlBtVk9XZUl3bWVHWVYzSm5BWkxGd1lHUHl6T3BnemhpUVZLVVBh?=
 =?iso-2022-jp?B?cTQreVFPSGdHeVV2TTRwMVk5VWNydHlNR1p5OHpQZSszdXJ3UUJQWFUv?=
 =?iso-2022-jp?B?bmpzVzZnTk5zeU1UTDBldGtWdm9MajNSWkF2Vm52cWM1OWpuZzV2UkJ5?=
 =?iso-2022-jp?B?aUdWeHkwNUcza2c4bTNZMFcyQW14ZUllZWlTS2owV1FyU1hnOEVsekpo?=
 =?iso-2022-jp?B?Tk1HQVRxM0JYeVBXclc3ODJQWjZRKzFEV0pUcXpZZXJ5TEtSN2I1MVlM?=
 =?iso-2022-jp?B?S2RlcWNxUElsTGN5TlRFV1R2UkErbzdJbngwNGpDWEt3ZExXeDlRMzBY?=
 =?iso-2022-jp?B?VUpxV0FiTERZdFJVM0ZITENsNDNSVzQ0cDRBWUY2K0NOOVoxcUNUWFAy?=
 =?iso-2022-jp?B?Y1huS1NPNjlTNElwWXhTRzd2THNNdG5ZckdMalhmdGY2ZUE2dUo1Y2h3?=
 =?iso-2022-jp?B?WmM3RlVES081bFQyRkdUVFFzdDhEVWtRVy94R3gyemw1M2QzcTZjeEdJ?=
 =?iso-2022-jp?B?STVGSGxRSWJWcUFRL0h2REl0N2tLbFpwRlJOZElGTlpVeURnc0R6bGIw?=
 =?iso-2022-jp?B?RTRMdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WWVrOGRsNUFSRlJqS3R1V2h5Vyt2dzluM0Q1Znl6N1B6elA0cGdlTU5k?=
 =?iso-2022-jp?B?MXpvbE5HMHNBS3U3Rnp6dHBFY3Y1aXlJelBDTjk5cmFxcVYwMlEzRGVJ?=
 =?iso-2022-jp?B?MFo0cktUVmpBSURhQVA4Nk81Wk1VblN1bEVKekoxQnduaDNacjlQTE9C?=
 =?iso-2022-jp?B?YzROZTNlVS9DQWtUUVpscnFjN01uZ0tFdWlRSlltT1djZU8reFg4a2ZS?=
 =?iso-2022-jp?B?YWd5WGtnc0o1UlpuUG1Fb1RwRmVqNDVuMkc0UWdMdzNMb1UwUU8wNTVv?=
 =?iso-2022-jp?B?VGVlK1hjM1htMEwyY0srdFFyZ1ZSMUp6akJUWUd4Nmt4N1BUK3dIMVZL?=
 =?iso-2022-jp?B?V2ZUZEMybjVPelVLRURqZFRPSFRlZzNOTHBwWUtRTWxxRVBxVW1YV1kz?=
 =?iso-2022-jp?B?UVNaYklBclZaWlh4NVZCbjBKd3JuL3ZxMFJCeFVKNnEzRCtmRlJ3czlv?=
 =?iso-2022-jp?B?aDZMWVF6cEVUVVNpZ0JqWXZYQ3JPVmhhM2g0ZEd1NkI4U0RJQTBiNnAy?=
 =?iso-2022-jp?B?TW5iRG9HRnpTU2NYN2E3MWY1eGhjcTVwVE1SdnNGd3l5NmdjUGNMQlRu?=
 =?iso-2022-jp?B?SWxwSWdvUzR6MkxvWlRBdmplbkRVcHZmUFJLVVlnSmxsMTg3MkJoRU1a?=
 =?iso-2022-jp?B?elR2S2JXRjh6RlBFSFdOcHRxWnYraVM0bnBIcUV1b3RwV3MxN29yVzc1?=
 =?iso-2022-jp?B?TDRoZWxieGNlSUhXak1tamV6MXY4OHlLZ2t4eGFnc3ZiYWRCQkVYdWEy?=
 =?iso-2022-jp?B?SnZkRGFpUFlENk5KT0FxUnN4Wks2cElzNWFqVXBUaW53cW1NbDJ2Tm9a?=
 =?iso-2022-jp?B?bWpMZms2enplR1drZ09Lc05oK3E5eDB3TW1OU3QrTGJGZDlwRER3QkRp?=
 =?iso-2022-jp?B?R0VMYlNXcXdHOXZTRXdmWnB5aDgrUXhMWTBWZndtM2ZVUTlET3o1ZGsw?=
 =?iso-2022-jp?B?Z1dwRFZ1ZUtpRW1kN1B2T1FaTXJ2NjlBMStpM293YTdOQ1ZmVlBCWEl4?=
 =?iso-2022-jp?B?NGNqTWVzU2xyTzNnNncrb21iOEg0d3BuNnViT1ZISDBmamZib3NOZFJD?=
 =?iso-2022-jp?B?YXlrLzdtbUFESTZ5SlM2bmczV3QraXJlcGd6L2NxQW0yOXVWNkkyVEMx?=
 =?iso-2022-jp?B?d0VsZ0xxOFFSUExQKzc5SGRrUENRT2NwUkdTY2plMEN6ZjlIMTA2WWph?=
 =?iso-2022-jp?B?c1NIMnpDa29iSm42Q1FpUUFSZC9KZUFoYm85bzI2Qm01TU1OczZVZ21O?=
 =?iso-2022-jp?B?b0lJZ1B1OXVNakI3d0ZsNlNhVUR4ck5rUXNiaVNCME43c0RGMHl0ZFkv?=
 =?iso-2022-jp?B?dXE2bnZGRGVsaDlEcGhxTC93Z29FaE9zL0tnOFA1UVZkL1RpSnE4bUVS?=
 =?iso-2022-jp?B?dFBJV0VmRnNEd05UVGltSldsWCtxZzZPUHZEcFVvN2paY2pZRnV6cEVx?=
 =?iso-2022-jp?B?azFUTy83ZXNkbGxLb012TzlXT2VQb0QvOE1HQjV1aDA4bStwYi84SVdr?=
 =?iso-2022-jp?B?ZHlEV0JXc3FtTCtlVzJjUFVBK2JPVGZNdUd5ODM4QTZvSkxGNXZ3RHE5?=
 =?iso-2022-jp?B?OVFIbmVOZ3Vlb3NPNGQ3Vk1sWUdkSWNTT1ZlL2hMUTZObnJ2RlpyWkZQ?=
 =?iso-2022-jp?B?S3hTTm1FaEhoR2VCQ0xiVlJ6VWgrQ01qc3A5b2JNYXpUeTNiRlBCaUEz?=
 =?iso-2022-jp?B?bnM4WlM4cmFoV0ZDdkpBd0Ewd1d6ODhUTW9sTS9QQlh0L2E5M1M5QWJh?=
 =?iso-2022-jp?B?aGlVcHVhdmRvQzRZN0hxTWZDWnViMEdiamRYWlFrK1hqRytaSk9HeHk1?=
 =?iso-2022-jp?B?bFNrS2VrYklBbWczcFdKZmtFalZvcjdKRGZnMGJ5cERQQmFRWitPNlNs?=
 =?iso-2022-jp?B?K3pSaG50cGJVWjdGNkVDVkZjN0h2c2VJVVM5Q0FYdzFpMktrZHNnak9X?=
 =?iso-2022-jp?B?S2NIbXAzWUJEeW1TQy81RWw1V3FGcUpXaDNVSGxlSzJobU9aQnZ5RW9U?=
 =?iso-2022-jp?B?aTI0MmFHOE5kNHlLdlV3S3plSFJROGQ3WURvVlZlMmNYMFRjeGJRSUNF?=
 =?iso-2022-jp?B?VDhiaWdKSFdyYlJCL3M2SDkwSVNXZEMvdlp1LzNjMGRhbGtRS21CZ29Q?=
 =?iso-2022-jp?B?cFp4WU9aSDZIU3dub2EyaDRaNWM3enZxc0lJK2xkTWNBUTc3YlZJS3RG?=
 =?iso-2022-jp?B?Yjl1VGtCMnlrZ2J3VDF4VjhTKzJ1ekFsUUJlRUFMRXJnTUlSVzZOYnpH?=
 =?iso-2022-jp?B?cWROdWVoaHA3UlZIT0NhK1QwL053ZCt5MHBmQ2FBTVV6UjZzVGZmeWg4?=
 =?iso-2022-jp?B?ajhBMVhqMldaZzlKazZrQjVCdDh0Z3NMUkE9PQ==?=
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
	+/A5Zs4wT/F78ZYXWVwzK08ma3oiovI8DEsAhPNJUsCmQVko7d4iyHqpb9TxIFfT/BcvZ4a9ejawsJRFaF1gZNmRro/E4qHJNiqRWhguGvItSgKjz3xNGXP8E1tWKmk1rmTAtXiFH/RJx7VF58kelt2tiTe/gzN8EZaxauHnGsyrSQvUAtFdf3bAuFSHgkuQ8uF8rouqf+tOkruRwuMnDaOAXAtWRH2zKJOLAAIq0ll5oLue/ydpDCc/0WGwFRCCy0Wg0JBkBLCI6Op3bkGuehKql2zUNugwe1kUoXylY6wGQuPQHn5pQ1cmt2ouEyuWop34XBHHcghqv3/f5w7sQW9+pQYnI2lPmCrIM42mf+2CCrYukAFb4AXGfvo+XBRCF+ISmBuJDTxJb/sRyLKlhKKuUq/OrBON26Ko4w4LGe7Z9XVSyzBh6RoskQ2fyzR0Wuyof8AvAI4sm7fdDDmHlQW2YNTMOyJZPbKnKsdslnGSEQ61cNZECOzQgYAdISDu4MPml8xuUlX7ktYh03AWKOnU20EaR8H9ZrvMFJs4/fK0J+qE3svhy/X76lM/JaNmRl292W+bE9FiXJ0QGnz2iBf0WwZgttY+kXLvya05x0H+JuE5RKk/kHpvEV7uX7YL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebc76f4-bedd-4935-196c-08de15357fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 08:47:45.6551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyTdyIxDZn7kUQd7fj9hT/+GaXTW2Ysu/2SDzn/pQuPcWsZp7JzEHBSYNdGcDI3qHTQdS6CgX7ET7H7QqJLJcfRKt3DA1oHrT4qNHUiI9w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17072

Hello James,

> When CPUs come online the MSC's original configuration should be restored=
.
>=20
> Add struct mpam_config to hold the configuration. This has a bitmap of
> features that were modified. Once the maximum partid is known, allocate a
> configuration array for each component, and reprogram each RIS configurat=
ion
> from this.
>=20
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes since v2:
>  * Call mpam_init_reset_cfg() on alloated config as 0 is not longer corre=
ct.
>  * init_garbage() on each config - the array has to be freed in one go, b=
ut
>    otherwise this looks weird.
>  * Use struct initialiser in mpam_init_reset_cfg(),
>  * Moved int err definition.
>  * Removed srcu lock taking based on squinting at the only caller.
>  * Moved config reset to mpam_reset_component_cfg() for re-use in
>    mpam_reset_component_locked(), previous memset() was not enough
> since zero
>    no longer means reset.
>=20
> Changes since v1:
>  * Switched entry_rcu to srcu versions.
>=20
> Changes since RFC:
>  * Added a comment about the ordering around max_partid.
>  * Allocate configurations after interrupts are registered to reduce chur=
n.
>  * Added mpam_assert_partid_sizes_fixed();
>  * Make reset use an all-ones instead of zero config.
> ---
>  drivers/resctrl/mpam_devices.c  | 284
> +++++++++++++++++++++++++++++---
> drivers/resctrl/mpam_internal.h |  23 +++
>  2 files changed, 287 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> index ab37ed1fb5de..e990ef67df5b 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -118,6 +118,17 @@ static inline void init_garbage(struct mpam_garbage
> *garbage)  {
>  	init_llist_node(&garbage->llist);
>  }
> +
> +/*
> + * Once mpam is enabled, new requestors cannot further reduce the
> +available
> + * partid. Assert that the size is fixed, and new requestors will be
> +turned
> + * away.
> + */
> +static void mpam_assert_partid_sizes_fixed(void)
> +{
> +	WARN_ON_ONCE(!partid_max_published);
> +}
> +
>  static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)  {
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> &msc->accessibility)); @@ -366,12 +377,16 @@ static void
> mpam_class_destroy(struct mpam_class *class)
>  	add_to_garbage(class);
>  }
>=20
> +static void __destroy_component_cfg(struct mpam_component *comp);
> +
>  static void mpam_comp_destroy(struct mpam_component *comp)  {
>  	struct mpam_class *class =3D comp->class;
>=20
>  	lockdep_assert_held(&mpam_list_lock);
>=20
> +	__destroy_component_cfg(comp);
> +
>  	list_del_rcu(&comp->class_list);
>  	add_to_garbage(comp);
>=20
> @@ -812,48 +827,102 @@ static void mpam_reset_msc_bitmap(struct
> mpam_msc *msc, u16 reg, u16 wd)
>  	__mpam_write_reg(msc, reg, bm);
>  }
>=20
> -static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
> +/* Called via IPI. Call while holding an SRCU reference */ static void
> +mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
> +				      struct mpam_config *cfg)
>  {
>  	struct mpam_msc *msc =3D ris->vmsc->msc;
>  	struct mpam_props *rprops =3D &ris->props;
>=20
> -	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> -
>  	mutex_lock(&msc->part_sel_lock);
>  	__mpam_part_sel(ris->ris_idx, partid, msc);
>=20
> -	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> rprops->cpbm_wd);
> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops) &&
> +	    mpam_has_feature(mpam_feat_cpor_part, cfg)) {
> +		if (cfg->reset_cpbm)
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> +					      rprops->cpbm_wd);
> +		else
> +			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
> +	}
>=20
> -	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
> rprops->mbw_pbm_bits);
> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_part, cfg)) {
> +		if (cfg->reset_mbw_pbm)
> +			mpam_reset_msc_bitmap(msc,
> MPAMCFG_MBW_PBM,
> +					      rprops->mbw_pbm_bits);
> +		else
> +			mpam_write_partsel_reg(msc, MBW_PBM,
> cfg->mbw_pbm);
> +	}
>=20
> -	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
> +	if (mpam_has_feature(mpam_feat_mbw_min, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_min, cfg))
>  		mpam_write_partsel_reg(msc, MBW_MIN, 0);
>=20
> -	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
> -		mpam_write_partsel_reg(msc, MBW_MAX,
> MPAMCFG_MBW_MAX_MAX);
> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_max, cfg))
> +		mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
>=20
>  	mutex_unlock(&msc->part_sel_lock);
>  }
>=20
> +struct reprogram_ris {
> +	struct mpam_msc_ris *ris;
> +	struct mpam_config *cfg;
> +};
> +
> +/* Call with MSC lock held */
> +static int mpam_reprogram_ris(void *_arg) {
> +	u16 partid, partid_max;
> +	struct reprogram_ris *arg =3D _arg;
> +	struct mpam_msc_ris *ris =3D arg->ris;
> +	struct mpam_config *cfg =3D arg->cfg;
> +
> +	if (ris->in_reset_state)
> +		return 0;
> +
> +	spin_lock(&partid_max_lock);
> +	partid_max =3D mpam_partid_max;
> +	spin_unlock(&partid_max_lock);
> +	for (partid =3D 0; partid <=3D partid_max + 1; partid++)
> +		mpam_reprogram_ris_partid(ris, partid, cfg);
> +
> +	return 0;
> +}
> +
> +static void mpam_init_reset_cfg(struct mpam_config *reset_cfg) {
> +	*reset_cfg =3D (struct mpam_config) {
> +		.cpbm =3D ~0,
> +		.mbw_pbm =3D ~0,
> +		.mbw_max =3D MPAMCFG_MBW_MAX_MAX,

When rdtgroup_schemata_show() is called, the "cpbm" value is output to the =
schema file.
Since bitmap lengths are chip-dependent, I think we just need to reset the =
bitmap length portion.
Otherwise, 0xffffffff(u32) will be output from the schemata file.

Best regards,
Shaopeng TAN


> +		.reset_cpbm =3D true,
> +		.reset_mbw_pbm =3D true,
> +	};
> +	bitmap_fill(reset_cfg->features, MPAM_FEATURE_LAST); }
> +
>  /*
>   * Called via smp_call_on_cpu() to prevent migration, while still being
>   * pre-emptible. Caller must hold mpam_srcu.
>   */
>  static int mpam_reset_ris(void *arg)
>  {
> -	u16 partid, partid_max;
> +	struct mpam_config reset_cfg;
>  	struct mpam_msc_ris *ris =3D arg;
> +	struct reprogram_ris reprogram_arg;
>=20
>  	if (ris->in_reset_state)
>  		return 0;
>=20
> -	spin_lock(&partid_max_lock);
> -	partid_max =3D mpam_partid_max;
> -	spin_unlock(&partid_max_lock);
> -	for (partid =3D 0; partid < partid_max + 1; partid++)
> -		mpam_reset_ris_partid(ris, partid);
> +	mpam_init_reset_cfg(&reset_cfg);
> +
> +	reprogram_arg.ris =3D ris;
> +	reprogram_arg.cfg =3D &reset_cfg;
> +
> +	mpam_reprogram_ris(&reprogram_arg);
>=20
>  	return 0;
>  }
> @@ -897,6 +966,39 @@ static void mpam_reset_msc(struct mpam_msc *msc,
> bool online)
>  	}
>  }
>=20
> +static void mpam_reprogram_msc(struct mpam_msc *msc) {
> +	u16 partid;
> +	bool reset;
> +	struct mpam_config *cfg;
> +	struct mpam_msc_ris *ris;
> +
> +	/*
> +	 * No lock for mpam_partid_max as partid_max_published has been
> +	 * set by mpam_enabled(), so the values can no longer change.
> +	 */
> +	mpam_assert_partid_sizes_fixed();
> +
> +	list_for_each_entry_srcu(ris, &msc->ris, msc_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		if (!mpam_is_enabled() && !ris->in_reset_state) {
> +			mpam_touch_msc(msc, &mpam_reset_ris, ris);
> +			ris->in_reset_state =3D true;
> +			continue;
> +		}
> +
> +		reset =3D true;
> +		for (partid =3D 0; partid <=3D mpam_partid_max; partid++) {
> +			cfg =3D &ris->vmsc->comp->cfg[partid];
> +			if (!bitmap_empty(cfg->features,
> MPAM_FEATURE_LAST))
> +				reset =3D false;
> +
> +			mpam_reprogram_ris_partid(ris, partid, cfg);
> +		}
> +		ris->in_reset_state =3D reset;
> +	}
> +}
> +
>  static void _enable_percpu_irq(void *_irq)  {
>  	int *irq =3D _irq;
> @@ -918,7 +1020,7 @@ static int mpam_cpu_online(unsigned int cpu)
>  			_enable_percpu_irq(&msc->reenable_error_ppi);
>=20
>  		if (atomic_fetch_inc(&msc->online_refs) =3D=3D 0)
> -			mpam_reset_msc(msc, true);
> +			mpam_reprogram_msc(msc);
>  	}
>=20
>  	return 0;
> @@ -1569,6 +1671,64 @@ static void mpam_unregister_irqs(void)
>  	}
>  }
>=20
> +static void __destroy_component_cfg(struct mpam_component *comp) {
> +	add_to_garbage(comp->cfg);
> +}
> +
> +static void mpam_reset_component_cfg(struct mpam_component *comp) {
> +	int i;
> +
> +	mpam_assert_partid_sizes_fixed();
> +
> +	if (!comp->cfg)
> +		return;
> +
> +	for (i =3D 0; i < mpam_partid_max + 1; i++)
> +		mpam_init_reset_cfg(&comp->cfg[i]);
> +}
> +
> +static int __allocate_component_cfg(struct mpam_component *comp) {
> +	mpam_assert_partid_sizes_fixed();
> +
> +	if (comp->cfg)
> +		return 0;
> +
> +	comp->cfg =3D kcalloc(mpam_partid_max + 1, sizeof(*comp->cfg),
> GFP_KERNEL);
> +	if (!comp->cfg)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The array is free()d in one go, so only cfg[0]'s struture needs
> +	 * to be initialised.
> +	 */
> +	init_garbage(&comp->cfg[0].garbage);
> +
> +	mpam_reset_component_cfg(comp);
> +
> +	return 0;
> +}
> +
> +static int mpam_allocate_config(void)
> +{
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, &mpam_classes, classes_list) {
> +		list_for_each_entry(comp, &class->components, class_list) {
> +			int err =3D __allocate_component_cfg(comp);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void mpam_enable_once(void)
>  {
>  	int err;
> @@ -1588,15 +1748,25 @@ static void mpam_enable_once(void)
>  	 */
>  	cpus_read_lock();
>  	mutex_lock(&mpam_list_lock);
> -	mpam_enable_merge_features(&mpam_classes);
> +	do {
> +		mpam_enable_merge_features(&mpam_classes);
>=20
> -	err =3D mpam_register_irqs();
> +		err =3D mpam_register_irqs();
> +		if (err) {
> +			pr_warn("Failed to register irqs: %d\n", err);
> +			break;
> +		}
>=20
> +		err =3D mpam_allocate_config();
> +		if (err) {
> +			pr_err("Failed to allocate configuration arrays.\n");
> +			break;
> +		}
> +	} while (0);
>  	mutex_unlock(&mpam_list_lock);
>  	cpus_read_unlock();
>=20
>  	if (err) {
> -		pr_warn("Failed to register irqs: %d\n", err);
>  		mpam_disable_reason =3D "Failed to enable.";
>  		schedule_work(&mpam_broken_work);
>  		return;
> @@ -1617,6 +1787,9 @@ static void mpam_reset_component_locked(struct
> mpam_component *comp)
>  	struct mpam_vmsc *vmsc;
>=20
>  	lockdep_assert_cpus_held();
> +	mpam_assert_partid_sizes_fixed();
> +
> +	mpam_reset_component_cfg(comp);
>=20
>  	guard(srcu)(&mpam_srcu);
>  	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list, @@
> -1717,6 +1890,77 @@ void mpam_enable(struct work_struct *work)
>  		mpam_enable_once();
>  }
>=20
> +struct mpam_write_config_arg {
> +	struct mpam_msc_ris *ris;
> +	struct mpam_component *comp;
> +	u16 partid;
> +};
> +
> +static int __write_config(void *arg)
> +{
> +	struct mpam_write_config_arg *c =3D arg;
> +
> +	mpam_reprogram_ris_partid(c->ris, c->partid,
> +&c->comp->cfg[c->partid]);
> +
> +	return 0;
> +}
> +
> +#define maybe_update_config(cfg, feature, newcfg, member, changes) do { =
\
> +	if (mpam_has_feature(feature, newcfg) &&			\
> +	    (newcfg)->member !=3D (cfg)->member) {			\
> +		(cfg)->member =3D (newcfg)->member;			\
> +		mpam_set_feature(feature, cfg);				\
> +									\
> +		(changes) =3D true;					\
> +	}								\
> +} while (0)
> +
> +static bool mpam_update_config(struct mpam_config *cfg,
> +			       const struct mpam_config *newcfg) {
> +	bool has_changes =3D false;
> +
> +	maybe_update_config(cfg, mpam_feat_cpor_part, newcfg, cpbm,
> has_changes);
> +	maybe_update_config(cfg, mpam_feat_mbw_part, newcfg,
> mbw_pbm, has_changes);
> +	maybe_update_config(cfg, mpam_feat_mbw_max, newcfg,
> mbw_max,
> +has_changes);
> +
> +	return has_changes;
> +}
> +
> +int mpam_apply_config(struct mpam_component *comp, u16 partid,
> +		      struct mpam_config *cfg)
> +{
> +	struct mpam_write_config_arg arg;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc *msc;
> +
> +	lockdep_assert_cpus_held();
> +
> +	/* Don't pass in the current config! */
> +	WARN_ON_ONCE(&comp->cfg[partid] =3D=3D cfg);
> +
> +	if (!mpam_update_config(&comp->cfg[partid], cfg))
> +		return 0;
> +
> +	arg.comp =3D comp;
> +	arg.partid =3D partid;
> +
> +	guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		msc =3D vmsc->msc;
> +
> +		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
> +
> srcu_read_lock_held(&mpam_srcu)) {
> +			arg.ris =3D ris;
> +			mpam_touch_msc(msc, __write_config, &arg);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int __init mpam_msc_driver_init(void)  {
>  	if (!system_supports_mpam())
> diff --git a/drivers/resctrl/mpam_internal.h
> b/drivers/resctrl/mpam_internal.h index d492df9a1735..2f2a7369107b 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -182,6 +182,20 @@ struct mpam_class {
>  	struct mpam_garbage	garbage;
>  };
>=20
> +struct mpam_config {
> +	/* Which configuration values are valid. */
> +	DECLARE_BITMAP(features, MPAM_FEATURE_LAST);
> +
> +	u32	cpbm;
> +	u32	mbw_pbm;
> +	u16	mbw_max;
> +
> +	bool	reset_cpbm;
> +	bool	reset_mbw_pbm;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
>  struct mpam_component {
>  	u32			comp_id;
>=20
> @@ -190,6 +204,12 @@ struct mpam_component {
>=20
>  	cpumask_t		affinity;
>=20
> +	/*
> +	 * Array of configuration values, indexed by partid.
> +	 * Read from cpuhp callbacks, hold the cpuhp lock when writing.
> +	 */
> +	struct mpam_config	*cfg;
> +
>  	/* member of mpam_class:components */
>  	struct list_head	class_list;
>=20
> @@ -249,6 +269,9 @@ extern u8 mpam_pmg_max;  void mpam_enable(struct
> work_struct *work);  void mpam_disable(struct work_struct *work);
>=20
> +int mpam_apply_config(struct mpam_component *comp, u16 partid,
> +		      struct mpam_config *cfg);
> +
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
> cache_level,
>  				   cpumask_t *affinity);
>=20
> --
> 2.39.5


