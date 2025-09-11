Return-Path: <linux-acpi+bounces-16652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C57B5295E
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 08:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FCA1C21CF3
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 06:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2CD23E355;
	Thu, 11 Sep 2025 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="zRXe1w4G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6D26B2D7;
	Thu, 11 Sep 2025 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573891; cv=fail; b=MMx5upK4m1VhwJVKgBCH5ueF4PXgV2LWut30lXNTuE99Ui5rhe1rf4Z9zwhjyOJ2rAjqe5Y1S6Kmle3Zci/urWC3SkPfOLRetj1jAMCUfZjXWJTWgTZSdycWN4V1aqWP0wse0O+U8NTKfy1qccSUqHosPnGZflLUE8FKqtmpQ2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573891; c=relaxed/simple;
	bh=LMZH0ODIE3N4jwA824Z8/DtZmy/URkDJ4PYfY72Se20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/Q56cH4HsOtVPC/676NjA5lSohf5H9/bVLM2CFVsyLMG7xpkCriELxO5dPpqQs6vjnUIfbQ59+1FA8LymtVZzv4/Bd4dftf4ZuJJf129bc/l6AkIp74aM/FPLucrtn3Hm+P8DwtXPXLyg+FXtSjvip6SNr8/HQVyCE6vuSxjhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=zRXe1w4G; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1757573888; x=1789109888;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LMZH0ODIE3N4jwA824Z8/DtZmy/URkDJ4PYfY72Se20=;
  b=zRXe1w4GDAENrbiP+GmZgf9KODms3yeOPO32zPRBpAMLf3sfIsp8f2p4
   +TocXYeepEs4XtOTMQkJJefenk4hTTEuh5/Prnh3twvvJKkwqw4v5g5KK
   wlijZD4k0KvqC91wm4B+GInf0SpQyH0FRm1Ornt6PihJnbyCM8+50+aqA
   HfUgwfRtrDN2k/CHPMANc8j2T7vknXRMZzTQyrUI0ZHkQssqk4mGKeYFf
   exqsy6H6t1qBOwzd3vaeoyRed1V6HojFwA8xVj8w1Vr8wzLwxRBK6M5Cd
   PRU/ABL4jKrU4BugQAicSjb6NPi89U1sGgw2FbjW1ZBN4kRH9yvbWB4m6
   w==;
X-CSE-ConnectionGUID: Y2aLvVQRRYiwDWQnaB6elw==
X-CSE-MsgGUID: LmpwaUnBTcyX5WnWkE5dyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="78789624"
X-IronPort-AV: E=Sophos;i="6.18,256,1751209200"; 
   d="scan'208";a="78789624"
Received: from mail-os0jpn01on2078.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([40.107.113.78])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 15:57:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNhzmlZ/nUFjgA6vER57rxLVh/IIquIimSp2zypL/PrrhukazCAvyjAXh0FEY+gjJ7WC314WO8x0lZgZtbYEbwSmCyoDV0XJ7cBXY1nkSQiZDggANk9//EbB4A1YWJAopYQj1yp+ud8vfFUz86Y0DWniA4E6Q4Q2umXO2d8jc1iUEbWsjQG2nwYAnRqB0EtzCTamyVHT3D21XGSWVTyI21cfexLa0S4vUWkZVsHwbsT0IqV/qgtJv6KISFObYyFLH/GW54V7zvesapMGgYmvH7XunSCOQVd38YzICwKYlG6Q3I5jfDox4BFemuXNNdB0x5k8rlwQPlqPgwqlqLPn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4h/mS/Vzg3h2gMn4RZ0rpdPYxHemAGmU+0S0BdsOdc=;
 b=ddnbbS9fvyADi/54hsButaIt9Deauu4wPDWEyDYNzDSXpz/7lsf6/4Ym1erYn7VTd4DqMSHh2stGwaYxK1gT5bMG8cbtNwjcMKJLWc1d+Syk+7JO02JX+/Qm0FrBZ2vzfqJ1ZK4Ww+amabDXjaGepZOPih8nXepgqCsm7DVCJQdATdfX4rWoIaM3V8AmZ3Ks8YNLGQCTKXfIhvk7zG9IvFu6AT2Brw3AG5u7SVvxLglac07e78MukQ6sn8znlhGMDx7Sr3PdMDBvebo39dODsM0Nfw+yWMuxts71ghfy7/GLtG5w1YrpqKi6PMtWl/seuqNCsQqUUH9HW0zMZyy87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 by TYWPR01MB9804.jpnprd01.prod.outlook.com (2603:1096:400:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:57:51 +0000
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1]) by TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 06:57:51 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Ilkka Koskinen' <ilkka@os.amperecomputing.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcHh171tqf09K4SkK1ciG0VLTs/LSJqfEAgAPpfaA=
Date: Thu, 11 Sep 2025 06:57:51 +0000
Message-ID:
 <TY3PR01MB99836C3D57503E70C8B8C9E9D509A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
References: <20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com>
 <bd45c06a-77cc-2ab3-122e-41dee1aee0ac@os.amperecomputing.com>
In-Reply-To: <bd45c06a-77cc-2ab3-122e-41dee1aee0ac@os.amperecomputing.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=67e4a6db-a8d9-45e9-a9df-263040abeb91;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-09-11T06:56:54Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_|TYWPR01MB9804:EE_
x-ms-office365-filtering-correlation-id: 1eb2f72f-d803-4cff-cee0-08ddf1008663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NjNZb3pyc0lpbURVcThiZEwySVhMRm5sVEpkdURZOXdjOVY2ajNJdWxh?=
 =?iso-2022-jp?B?d2NXcDk0dlhXT3lqYndrUmJQUXhHWHRlTTNDRit5Z1R0b21ZSzF4WitQ?=
 =?iso-2022-jp?B?cWNlYTBrUXJTeE9Dbm1GZVpIYXlzRzNHUVBaY3h5clRReFljUWllQkxT?=
 =?iso-2022-jp?B?QmdvdXc2UHJucFpBdndCVU5jaHRBc2FZWUtKZnByTUl1eEw1SDFVdVFR?=
 =?iso-2022-jp?B?MXZZZHcwSkRRU0VSUVdwUlRHRGhkOWNGSnBFNVdydUsvc1lyVjhOdklv?=
 =?iso-2022-jp?B?cFNsL1ROMnlVd01ERk1CUVM4cmhBNkVXL2ZhaEtJMGhZSzBScTRYcVox?=
 =?iso-2022-jp?B?MEVwVkdsNEpaK3IxUWdxZ2p0NWMrc2xHRmxIZjZqTUJhS3RoQkM0UHJU?=
 =?iso-2022-jp?B?WGxSeVVIRnp1V1JzVFRjMXdlN0J4dHYxSHJ1cjNEWktZWjJrL3h4Vk9E?=
 =?iso-2022-jp?B?VDZmME4rT2VmU2JnZ1JySVV5NlJHeVlXOFZ3RzFZWkQvVGxZalNkby83?=
 =?iso-2022-jp?B?cDlMNE96WTVNdkdkUmlRcDF3cmRyYW9tTjcxRXJiMWpsMkxYZWhqUjhF?=
 =?iso-2022-jp?B?S2xKTHFCRlV0c2hNUW8rcEVPTmNndTJWN2h3bVVUWGFZK045dnN2YlhR?=
 =?iso-2022-jp?B?ZytNVFJsYTB4bGcrL1czSU91bUtWanRVWW14YmpyRmExdzAzTFVxQTA3?=
 =?iso-2022-jp?B?QXpvN3ZoRWtJa2tSNHBYWFZKZzVobncxRC9VdG9FdkszaENDQlgyUmdj?=
 =?iso-2022-jp?B?U05yU2hsOEhPWFZwdXdyN2FTcHY3WE1MMUZCS0lsakk3dmFERUZBaTcw?=
 =?iso-2022-jp?B?QjlLWFlpbDRrdjVEeUQ1aTkxeHFicE9nWEpCeDJTdEpaL2lWb0ZncHhM?=
 =?iso-2022-jp?B?bzVsaWxoaDhoYVcycytESFFsOGtjRlBxellxMkNSbVIzbDZ3NkN4ZXRy?=
 =?iso-2022-jp?B?eGRtVWVzZzlXU0gvUUtoUW9MZ3g4dFhOYkFvTVNaZDJKNWNqMmJQb09E?=
 =?iso-2022-jp?B?TXA3ZGhHeXl1SnNLUjdXeDhWbHluSlBSWjVjbVM5SGpBU2F3Z3ZqbE5I?=
 =?iso-2022-jp?B?MW16Ym1tK2RtUi9ZQXRpQktXbnNPN2UxdmNrQkh3aEFkR2Y1b2pudVdl?=
 =?iso-2022-jp?B?am8xVm1wQkpGdldsU2c1VDMrSy9GVVBpQTBBZXZKcUQrZ3o4YWFxUnVw?=
 =?iso-2022-jp?B?WW1BY3M5NDlNQzIxNk5LU0FVY2ZzNmx4REp2MmtRL0o0K1ErQXJjYVJJ?=
 =?iso-2022-jp?B?SlVTRUErWUFhaFFReVBpbWIvUTF5dEd6ZFI5RTZPS1VYemMzSXV5UzMr?=
 =?iso-2022-jp?B?VWh2MHBIRWVQdE41NFlKLzROYXpBTzltQUFtbGRMT3V3d1V4Z0diT2lw?=
 =?iso-2022-jp?B?cEcyaUlzY0pnTWttMW5COThVa3l6YW4rbnFZTEtGTE5XeE9meWpSUXlP?=
 =?iso-2022-jp?B?ci9vRnA2Q2FIYUZjNmxaaHVlcU5IdmlZcE02KzhEb1o3ZVJPQldNM1FM?=
 =?iso-2022-jp?B?OENmMFlodlVSL21iYm0xLzlLYjJmS3cyQURUTWhaRCtZY2JSNXJGVUZC?=
 =?iso-2022-jp?B?aWFwd2ZRSjdvYVIySCtrRVNGQmgvOFROR2V6Q1hoWmo4MVZBa05QQmJP?=
 =?iso-2022-jp?B?ZURWblZGd2xzUU93d2N6dElwb0puaXZrTkxLWVNpUjJzeWRYa3cxQUYz?=
 =?iso-2022-jp?B?UWgwSVB2Y1JidUM2djN2UVZPU21nWVRiSXlaWmMxZkRTcmlWako3Vmwx?=
 =?iso-2022-jp?B?dTlqbUMyYW53WUhGRkN4Y0xPcVU3OUdCWnBBSitrd0pLeVNOWVJZVUJ1?=
 =?iso-2022-jp?B?bjNOeFZMNUVGdkdFSHZYTU0vcWlOeWFGaERhWmJDa2NtMHpvVmNRZTVY?=
 =?iso-2022-jp?B?cUpkZS9nckowcGIyRldleW9GZjVkeDhJMkJHeXNPOGdQZlE3SlZvb2U2?=
 =?iso-2022-jp?B?eDBuYjVyK2JGNFlVWHlad0JxQ2RGMk1rM1hyN0JGMG1rSDFYVGYxazNV?=
 =?iso-2022-jp?B?eklaVGRXRlN5TzZwU25SUkFYeFBrRmhLT0lPa0g4WXdQYnNkNGZhNEhk?=
 =?iso-2022-jp?B?YU9obGR5c0o2Y1FSUkRYcE9UUVhBOFZBOURIY2lyc2JjbnpHa1p2OVk4?=
 =?iso-2022-jp?B?TU5ZL2hrOVh3ZTFvR0lSZm5HN0w3c3FsbUdZc0I2ckllN1RzSU5NZEts?=
 =?iso-2022-jp?B?NVZWTmFjZ1N2VENIcWFwWk9mSjd0U0Fq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SmtacURjdWF6dURubzVOMTQ0TWVVRU9YQWoxdnZmZ25xdVd4Tit1a3R4?=
 =?iso-2022-jp?B?VDdHV0ZXRnZZejlCa002ZlNpY1BxRmQ3VHFLaHdoaWp5YVZiblduNXdv?=
 =?iso-2022-jp?B?bHpiMUpFUS9IQUlLNytpYmRnKzM2bjFKQ05sQnN4U2IzRlBCcUZhc0xO?=
 =?iso-2022-jp?B?bVhQeTUzSTdEaWU5OVRtcnJFdDQ2M1ZqZHF3T0d1VWZyeFJXL0ZrYUpY?=
 =?iso-2022-jp?B?UFB4VmZ2TG9oMWpCMVg2K1VidThCOE1XeXNBcFl4dm5GbnVFWm1CT01u?=
 =?iso-2022-jp?B?clQ3Yi9FZXpSOWNUMWxPV0xVQi9SMytnK0lRVlhsUXY2bDE1cmJYbDVK?=
 =?iso-2022-jp?B?OHZpTkFHaEJ6Q0pBWXViL1lKSDhzT0hKU3hXN0t2Y3c4OWUxTldoWTF3?=
 =?iso-2022-jp?B?WnFIM0xCMG9Tbjk4MVNHcnc4eHdGMFROMkVDUEdmTUl1WkxaSEl1YmtH?=
 =?iso-2022-jp?B?UDRERnpuWG53QnNCR0hqTElLK0d2c3lCMDkyc0hwbzZTaEFNNjdXNmdk?=
 =?iso-2022-jp?B?a0VlYnB0UjlEbWtxc1d0MWdmWlc5UzZOT3pkSml6UDZZR2N6Y3RNdXVy?=
 =?iso-2022-jp?B?ZEZjTVBnU1lkU0lnN0FQaThubTNDeC9rM2tMRHhZYzdIblQvUldvUksx?=
 =?iso-2022-jp?B?aTh5UW1PbkhHRGZEcFVremV0WTl0QkFEakFnRlJaZlFlQ3NvdGEzVmVs?=
 =?iso-2022-jp?B?eWFZUDNwRzVsdWdHOVVtTGpGL3dGdWkvVDc5RGlkOXdZU2VQMnlrQ3kr?=
 =?iso-2022-jp?B?dDBzbWR1alREMlZrQlJWSE0xZFNDeHNnM25ESmZKS2ZONmhla25PVkRn?=
 =?iso-2022-jp?B?TFlrUzJWcUlyNUlFN1Azd1VWRi9NSjZuV3NsMlBkK09aYnpCWFZtdUpl?=
 =?iso-2022-jp?B?WUdmRVNKVFhXeWtXWS82QkQwV1BIWXU2c3d3a3ZIbVc2d3UrQ2pPdDQ3?=
 =?iso-2022-jp?B?N1ViQTJFbFBkM0RySHpxQVFDSS9NNldLTG9MREc1ZWU1UkNIdS9SUVRx?=
 =?iso-2022-jp?B?ZDBOZFlzQU80MHpXdU9UUjM1YkRWdEZabmhyelZ0RXQ1RmpocmloNVZo?=
 =?iso-2022-jp?B?dzViZk9ZUFB4UUx2ZURSUHVQYzdMa2RlQkgzVlNsYWduYmtueUkzYmRO?=
 =?iso-2022-jp?B?cE9FVDk2dlFsMW0zZVVKZjk4UHplVlBPQy9qV25vbUlmTGNTT1F1Y3Q5?=
 =?iso-2022-jp?B?ZHc5M1dQOUNpWVU1bTBENVgrR1dRZnJlZU1vSEJITEU4aDhMUmtGRWtq?=
 =?iso-2022-jp?B?VndDOW5WRE84VmpOdiszQmpOVVdUSjdGUXZrRWRMMmFiK2JRVERocDd4?=
 =?iso-2022-jp?B?SHZNVWcrK2VTclRnaEtoV3N0RUE0VUNnTmVrRUtoQVpWSEloazRyMG92?=
 =?iso-2022-jp?B?RG84aDAyMHZ1cXdjUVYzNGs5V0NNcml2dCtlcDR2NzRWQkRpd1NwaHJU?=
 =?iso-2022-jp?B?TVFCektHbVRXcW5LUzVUZWpZUzY3aWVXcjJYSXBWN1dmZXJ3VnQvTmYy?=
 =?iso-2022-jp?B?NUpwVi9uYXdJbDlxd0lhT1lvT1ZrTEkxWmFGTFQ2a1N1cmtpOXNRZlNX?=
 =?iso-2022-jp?B?RmxXRWVOU1lnQjRzeFBBTlZ2YXREbzh4anA1aFdrUHk3VkJIMUROMlJt?=
 =?iso-2022-jp?B?d3ZxRmZnd1o3ZEo1U3pVUm9sL1I5ZzkvRURiL2NmSnBSREk2TUd0M3VW?=
 =?iso-2022-jp?B?RXJVUUtWd2lndVpQTjlNbkp2TWYzNjdsa2lnd1c5Qk5Zb2NlWGpkWHVR?=
 =?iso-2022-jp?B?TytWTVdRd1luZEh0STI1eDVZTTM4MllGOXFLVHZQMmlxalM5NCtBRXhU?=
 =?iso-2022-jp?B?OVVTa2g2eExRT0RaUEw4dEtiU3lBT2FOeG54UHVYSVFjK0lMNWxDRUFT?=
 =?iso-2022-jp?B?UUlUb1NsSUZ0SThvcjdzN1lRaHVMU0k1M3VicjRlTVlpaDFWUi9UL3lG?=
 =?iso-2022-jp?B?N3NKRnlzZEJFcVlRZkQzcmJQeGdJTzhBN1dnVmNtOFppNHU3TXcvZEtk?=
 =?iso-2022-jp?B?bVp3UmVsMGVwaWhKcVNHMjNFVStyd3k4c0paT0NGc2lxcTRwL0ZaVVFj?=
 =?iso-2022-jp?B?eFBhQ2ZOQ0lveDFwKzBjWlhvMW9CY0ZwNWFEU0hsUysvWGh6QzY0ajhm?=
 =?iso-2022-jp?B?S3ovdWxCOE1QdUo2TlU1eHlkQVE0V1VVYjVTTDVlMWRYNnhhRVJzeGlD?=
 =?iso-2022-jp?B?Rm43SDhvd1E5bTdOdnZDNkNzZ2xzQ0ZEN1VwMjlCVUltdWxJcnlSQ05M?=
 =?iso-2022-jp?B?U29Rd2xyUVlmSmRIZjlQVnVkZ0cwNDVMUHV0SWV4OGNnbjc0NzJNbDhV?=
 =?iso-2022-jp?B?ankxY09JMUhNTElvNFZERnh5ZTE1MS9UN1E9PQ==?=
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
	uKtFbX0ZHog5vSC6fBjHs7JLD2W6OfjHAHTzljG5rBNpJGIIGpmCzdbCdLKHTVC3jhcl6wSuXP/VbeEbtkoh4nzpfj+28O7v/UEhccfsdW2KXJn4RyPu93mMMR3zyT8FkyuzOJ3vuHnUsCLwqFt1DRoSAjjbF5RZkbLAddFwfd7Gsvw8jJqb4p6Ul0Yw0b6VgvZSbjKXGwTDrCDs1UNL6AohcKMRFVPJixFoNYqxrv/shM4/k8fSfA79reVG5fNObT6uisbryklzuqmpiPt5moSrSHQLC5smFlxF0lNUdP1P90LDvzb/+k5iF1so0v6y+gJW4DO4Y0UA0tfSNlS4J8SHy0PEe1qDz+qw7sppETE9PZzg+YVIQi7GMUW3SZELtR1Xv7yI3uP302jEs3MO6QcZVzvcsAvYhR94dSSaob4DbdzI1y8alwKx3zAccRMv3CDaIy74yz231YXMtcFhH8TKR5Bz5ztEaVxQBNZeUJdCgeP2q4WjXNAKadX1CsCfLkmXS03vaHxW71tYqzqbUw6xf87zRSvaMvzZWiQiLg233TCG/KGh4iJ8eeCfm5IPVxe3Ec/8PPGQ4rRtVv7V19mOLrrHLs6wAIe8Lntr+zmWNVU3vrzLA20/RxMQbvMk
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb2f72f-d803-4cff-cee0-08ddf1008663
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 06:57:51.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: plDAcVHNpCr+iKscJLfzDTvhqjZwsXL/x4jhNInas9L3FjeQyWn2EzvSyBrkvYQRCnJSoR/5i0+vANl4Iv6sfeiQqTy+JL6TkSz9/KVw5J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9804

Hi Ilkka

> Hi Kazuhiro,
>=20
> On Fri, 5 Sep 2025, Kazuhiro Abe wrote:
> > AGDI has two types of signaling modes: SDEI and interrupt.
> > Currently, the AGDI driver only supports SDEI.
> > Therefore, add support for interrupt signaling mode The interrupt
> > vector is retrieved from the AGDI table, and call panic function when
> > an interrupt occurs.
> >
> > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
>=20
>=20
> Looks good to me.
>=20
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>=20

Thanks for your review.

Best Regards,
Kazuhiro Abe

>=20
> Hanjun & Sudeep, what's your thought on enabling the use of regular inter=
rupts
> here? I do agree the spec talks about non-maskable ones and to my underst=
anding
> that's what the idea was indeed.
>=20
> Cheers, Ilkka
>=20
>=20
> > ---
> > I keep normal IRQ code when NMI cannot be used.
> > If there is any concern, please let me know.
> >
> > v2->v3
> > - Fix bug in the return value of agdi_probe function.
> > - Remove unnecessary curly braces in the agdi_remove function.
> >
> > v2:
> > https://lore.kernel.org/all/20250829101154.2377800-1-fj1078ii@aa.jp.fu
> > jitsu.com/
> > v1->v2
> > - Remove acpica update since there is no need to update define value
> >   for this patch.
> > ---
> > drivers/acpi/arm64/agdi.c | 95
> ++++++++++++++++++++++++++++++++++++---
> > 1 file changed, 88 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> > index e0df3daa4abf..2313a46f01cd 100644
> > --- a/drivers/acpi/arm64/agdi.c
> > +++ b/drivers/acpi/arm64/agdi.c
> > @@ -16,7 +16,11 @@
> > #include "init.h"
> >
> > struct agdi_data {
> > +	unsigned char flags;
> > 	int sdei_event;
> > +	unsigned int gsiv;
> > +	bool use_nmi;
> > +	int irq;
> > };
> >
> > static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs,
> > void *arg) @@ -48,6 +52,55 @@ static int agdi_sdei_probe(struct
> platform_device *pdev,
> > 	return 0;
> > }
> >
> > +static irqreturn_t agdi_interrupt_handler_nmi(int irq, void *dev_id)
> > +{
> > +	nmi_panic(NULL, "Arm Generic Diagnostic Dump and Reset NMI
> Interrupt event issued\n");
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t agdi_interrupt_handler_irq(int irq, void *dev_id)
> > +{
> > +	panic("Arm Generic Diagnostic Dump and Reset Interrupt event
> issued\n");
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int agdi_interrupt_probe(struct platform_device *pdev,
> > +				struct agdi_data *adata)
> > +{
> > +	unsigned long irq_flags;
> > +	int ret;
> > +	int irq;
> > +
> > +	irq =3D acpi_register_gsi(NULL, adata->gsiv, ACPI_EDGE_SENSITIVE,
> ACPI_ACTIVE_HIGH);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "cannot register GSI#%d (%d)\n",
> adata->gsiv, irq);
> > +		return irq;
> > +	}
> > +
> > +	irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_AUTOEN |
> > +		    IRQF_NO_THREAD;
> > +	/* try NMI first */
> > +	ret =3D request_nmi(irq, &agdi_interrupt_handler_nmi, irq_flags,
> > +			  "agdi_interrupt_nmi", NULL);
> > +	if (ret) {
> > +		ret =3D request_irq(irq, &agdi_interrupt_handler_irq,
> > +				  irq_flags, "agdi_interrupt_irq", NULL);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "cannot register IRQ %d\n", ret);
> > +			acpi_unregister_gsi(adata->gsiv);
> > +			return ret;
> > +		}
> > +		enable_irq(irq);
> > +		adata->irq =3D irq;
> > +	} else {
> > +		enable_nmi(irq);
> > +		adata->irq =3D irq;
> > +		adata->use_nmi =3D true;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > static int agdi_probe(struct platform_device *pdev) {
> > 	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev); @@ -55,12
> > +108,15 @@ static int agdi_probe(struct platform_device *pdev)
> > 	if (!adata)
> > 		return -EINVAL;
> >
> > -	return agdi_sdei_probe(pdev, adata);
> > +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
> > +		return agdi_interrupt_probe(pdev, adata);
> > +	else
> > +		return agdi_sdei_probe(pdev, adata);
> > }
> >
> > -static void agdi_remove(struct platform_device *pdev)
> > +static void agdi_sdei_remove(struct platform_device *pdev,
> > +			     struct agdi_data *adata)
> > {
> > -	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev);
> > 	int err, i;
> >
> > 	err =3D sdei_event_disable(adata->sdei_event);
> > @@ -83,6 +139,29 @@ static void agdi_remove(struct platform_device *pde=
v)
> > 			adata->sdei_event, ERR_PTR(err));
> > }
> >
> > +static void agdi_interrupt_remove(struct platform_device *pdev,
> > +				  struct agdi_data *adata)
> > +{
> > +	if (adata->irq !=3D -1) {
> > +		if (adata->use_nmi)
> > +			free_nmi(adata->irq, NULL);
> > +		else
> > +			free_irq(adata->irq, NULL);
> > +
> > +		acpi_unregister_gsi(adata->gsiv);
> > +	}
> > +}
> > +
> > +static void agdi_remove(struct platform_device *pdev) {
> > +	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev);
> > +
> > +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
> > +		agdi_interrupt_remove(pdev, adata);
> > +	else
> > +		agdi_sdei_remove(pdev, adata);
> > +}
> > +
> > static struct platform_driver agdi_driver =3D {
> > 	.driver =3D {
> > 		.name =3D "agdi",
> > @@ -94,7 +173,7 @@ static struct platform_driver agdi_driver =3D { void
> > __init acpi_agdi_init(void) {
> > 	struct acpi_table_agdi *agdi_table;
> > -	struct agdi_data pdata;
> > +	struct agdi_data pdata =3D {0};
> > 	struct platform_device *pdev;
> > 	acpi_status status;
> >
> > @@ -104,11 +183,13 @@ void __init acpi_agdi_init(void)
> > 		return;
> >
> > 	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> > -		pr_warn("Interrupt signaling is not supported");
> > -		goto err_put_table;
> > +		pdata.gsiv =3D agdi_table->gsiv;
> > +	} else {
> > +		pdata.sdei_event =3D agdi_table->sdei_event;
> > 	}
> >
> > -	pdata.sdei_event =3D agdi_table->sdei_event;
> > +	pdata.irq =3D -1;
> > +	pdata.flags =3D agdi_table->flags;
> >
> > 	pdev =3D platform_device_register_data(NULL, "agdi", 0, &pdata,
> sizeof(pdata));
> > 	if (IS_ERR(pdev))
> > --
> > 2.43.0
> >
> >

