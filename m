Return-Path: <linux-acpi+bounces-17129-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB0B87E2B
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 07:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4A27C323E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 05:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060DD26D4F9;
	Fri, 19 Sep 2025 05:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kqp/JMG7";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="T78Yy7Gs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7D34BA58;
	Fri, 19 Sep 2025 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758258386; cv=fail; b=EML32QrWs1lsPaAAUm6Clz9okN/V81dcQyd+xmqAISFxp9MQxwwEcAnO+NA+7ehZ3fJHDMbxf2G0RZKUQWPVnDNu5j/sYO8sp8o3jZQuSx5AEQiWlvbiiIEwrK4lT2+m+ZyPZRs/4UitlZnn5STn0/OgDZiRbJuy0+7neE0FsVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758258386; c=relaxed/simple;
	bh=neELSq99Vj+CiThLsI23M/rGj2KXpuzBrs+SvQRTFwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=luuHp0g9mVUJG5MSbq8Jm+5tStgF4b+5AlBlEYvvnlmKdv9Iz0wuPe94949dWhfDbLAgQbzFKqQTq+tk2QoWZ7OXQF1jwDpdBVUkivDjSyOFQhocj2u3EVW84lCpfjkw+sD3skS3HCpeiY4tgLhrONZgyYfUy9IakAsj2B+OBmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kqp/JMG7; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=T78Yy7Gs; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1758258385; x=1789794385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=neELSq99Vj+CiThLsI23M/rGj2KXpuzBrs+SvQRTFwM=;
  b=kqp/JMG7lbdq2vncMuR9wBjqvbnuJp5qs4GLUNJsTwbCuu36iiPXR5QW
   iEA2qyuQ7xYH+bODUzE92AZQYtg0j3QZe+s1LZdCsvTuNcue9ZiuFi1rN
   LwAp7QmwcW/pUBcjh26oOu9RozJmn/MkpS3H9iuaQbVU2LpQwt4Gsub6m
   vepg3LhlG9yQAZhwnpjWBpQ1gES72DXVCqH4WZ9o6sNYIJQhOceCJgHr+
   r2TDnC5JZcfvA9IGN2fIHWp76DkJ3AwmVilALfExq8zUEmJvHuMqN8GDx
   SnPL/ehQdI7xbs9bfZsD6firOnS4FFWKPSoO7OooZSMHm3DphORvPhlDH
   w==;
X-CSE-ConnectionGUID: sc/a6vGYRAKJ0CAnqhMH2Q==
X-CSE-MsgGUID: oG39z9o6Q1eoufcnM7cOIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="168283896"
X-IronPort-AV: E=Sophos;i="6.18,277,1751209200"; 
   d="scan'208";a="168283896"
Received: from mail-japaneastazon11010027.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 14:05:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDdoUastB/Z458dNXY7RqSwE7M9diVB0rO5j23COClOqCL2lOi1prhN5qobCciKf2bXmlcFYaAC6e0z3/QItqG3O22YW5RuNIQKGSrQGFvrspCQKFooDP4fnQ4iIkHmg7UeVDAfGGj56q9CV8Az+MftFPCeFDGWiTnjBmdzvyoNbykuuv7kCQSdIvv89E0A/flmJIk+9UqaK+dzpQiJFSABQoACyRdwv1YND/pYDW8lRsPEejr46mjJAJp4gMEMUXkhpYRHLxe/YcarjGxNz4txR+WBLZouDX8Krjocq71OWttwwG4Ek8654omOoXE7lpVYj3HpTtYMGulwnuke0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaVuSHEQlFhtNOWfktL6lecSsOsVWfLwiw7XB/a9Kww=;
 b=B/QF+uBC5r7vKU5NtHdDlrbkCSPkpBBwUgFchPfRaTy3PpwBoVu+r2jOi7RETHwpSG6rmtgCb7XXOLnWb7NuYffdxK5Z/MRLiL3Io2B21OXfDuoo2ZC2RD/1VbMThRYQj3L/3W2BfgnhXIUZSEJgEeAg/unxjOzFCCdzdXGPIsVCeDlh81krZ8L/aH8CQ85J8fnBR43DdmxF1rvuZvsjBz1XV7N3p3hE2l9T3bONlzES7y6rcdFoyqSat4emyJQuVD1AtRavOZDJ9JOTlryUAoJh2ZcT+71sgZZPABhTomkovUZ0HHzE5BsnlF7YZsn7b/mEpG/R3FS3JmrVzbCctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaVuSHEQlFhtNOWfktL6lecSsOsVWfLwiw7XB/a9Kww=;
 b=T78Yy7Gsfrl2ZmEHy6+1XB6AMD/yYjK/OpoWZ0a2i2Em5GfXx2LiquiJXC0ub8XOKFUpTBdgZlOhueKCMU5kKDm2mqg3oCu7P58K9U9i9pKfSozrI+PqLMy+QllTJspw8oyan27g8knDY1BrsF0NGH09Dxx6p9DVU+RWUzEkQENTBal2WBxIGpTjOhJ8DgtJf0dSPflMOIKelVPkw2t01FSHMo7A9zFPv+VBKWTSQpFHT1+7G6GgHpSCLwZ6OfqitMxmHHfFXVFljegjxdudcU4/GSbtRNIBIA/bQYuxt8ugZ3GI235216n/PHmBgSLCjqb8cWTePzHg8oeOsBfcOQ==
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 by TYRPR01MB14127.jpnprd01.prod.outlook.com (2603:1096:405:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 05:05:04 +0000
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1]) by TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 05:05:04 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Ilkka Koskinen' <ilkka@os.amperecomputing.com>, 'Hanjun Guo'
	<guohanjun@huawei.com>, 'Sudeep Holla' <sudeep.holla@arm.com>
CC: 'Lorenzo Pieralisi' <lpieralisi@kernel.org>, "'Rafael J. Wysocki'"
	<rafael@kernel.org>, 'Len Brown' <lenb@kernel.org>,
	"'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcHh171tqf09K4SkK1ciG0VLTs/LSJqfEAgAPpfaCADGlN8A==
Date: Fri, 19 Sep 2025 05:05:04 +0000
Message-ID:
 <TY3PR01MB9983025D434CAA2CDF83656BD511A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
References: <20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com>
 <bd45c06a-77cc-2ab3-122e-41dee1aee0ac@os.amperecomputing.com>
 <TY3PR01MB99836C3D57503E70C8B8C9E9D509A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB99836C3D57503E70C8B8C9E9D509A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_|TYRPR01MB14127:EE_
x-ms-office365-filtering-correlation-id: e382aebe-12db-4aa4-dce7-08ddf73a1871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?SS9qV0tiWU1TT3RoVFJyZU50bVYrTUZzaFVFUDFmRTR4YUVydGVZZG1E?=
 =?iso-2022-jp?B?SHplMnlVS1Z3UWV3dXZwSnJJWFRXSTFiMW5rWnhQTlc5d3p5ZSs4VDBW?=
 =?iso-2022-jp?B?dnlDNzROZ2VtMDl0Mkg4UjBoWXRtM3YvTWhJb0s0dFBveFJYTUJHSmdE?=
 =?iso-2022-jp?B?aHVrWlpDVUxYNGJ0cjJmakp4MGpmWUZVWHNzdXhVTTViRzJ2aDE2S3ZI?=
 =?iso-2022-jp?B?ZUNka3RJOTJpWTFkbUsrQWNnM05QendTM3FvZHN5SVhYbVN2YzM1UFZD?=
 =?iso-2022-jp?B?ZHVkZGxwMi9qYXIwVEd5UGlPUS9PazExeEkxUDNIck81Z2F5ZlJNMzhs?=
 =?iso-2022-jp?B?QXVudjJCSGRCa0RJM3UycHNjOTl4SklidXhlM0wxNkNRV0N2WXJKVmFX?=
 =?iso-2022-jp?B?TGUzL09mTjkxd0x2czljVTFIc1ZVOFYrbWRSZ3ZLTlRSRDYxOThtZ2RM?=
 =?iso-2022-jp?B?VWppdHVEdUNvaWpRM1oyaHVlRko1dEJTZmczYkxjcFNKbktRc0kwdnNy?=
 =?iso-2022-jp?B?ZGhFYndPVDd5S0QxUmlyRmRSQWJHYU9QbFJhOG9QNmhlRGZDT0xaMVd2?=
 =?iso-2022-jp?B?U01wTjdiTWh3dkJVU0U3T2oydktHa0w2bzBFMEs4OHFFaFF3MzVuK3Z3?=
 =?iso-2022-jp?B?V3RKdXovMnNwTlQ2ZEhpUFNGcHJ4VjY4cGhOMEpPSDU4TEUzbnZuN0pp?=
 =?iso-2022-jp?B?a040emtha3pQamJsbWI0SnFMc3d3TSs3dmVoZDJLRDF1TGRZSzI2SWhB?=
 =?iso-2022-jp?B?NlIrNThFV2M1QjRKbmsxTXhyVVViQmRZME5vYngwLzBrUE0wNG93Qkg4?=
 =?iso-2022-jp?B?TVZEdFo4a0JHMm82ZkxEZHc2UDJiRVFWOEtNbmlCajMrc0oyUGNpVWVK?=
 =?iso-2022-jp?B?SFRpUmJWM0p5SVkrUE1SaVEvOUhhR0ZWdklFekdoc0JwNnc0RWRHblVj?=
 =?iso-2022-jp?B?ZGxWZG9FQjNZY21NNHl4UCtSbmNqaVp5UXQxMUlmNWtEZGloSHNFM2ZJ?=
 =?iso-2022-jp?B?b0IwL1pzTVA2YUpxYUx1OTNKdndjemZjMmtlMFNxWkgzVVB5N1RtK2sz?=
 =?iso-2022-jp?B?cjRhNGM3aHdUMXlzTk9KZWVUV2Y0THNTV1NEbGVsSDhlYlZjUG5TUE5R?=
 =?iso-2022-jp?B?R2phVDNUMkFrWC9DUWlsc1hFeGtQTXJEZU5ncitpQmVSdllscVQxYytD?=
 =?iso-2022-jp?B?TEVSQVFJR280MTl3eGM1Rk85Y2htb2NtK2M4NGdmWjA4YnQ3WFE0YWts?=
 =?iso-2022-jp?B?UExBS0xSVWUvejBsUlVyZ1RrcnRKMU94bWlsN0w1L1FUaUxZTW9WVWdB?=
 =?iso-2022-jp?B?SFFiSVlXTmlpc3hxVk5sZElxcG9ZaGpydGp4SVkxV09xWmVxc3dBUjNI?=
 =?iso-2022-jp?B?cDRMK1J5eGRVQk9FL0NaQmJ0b1EzK0pCQjlIWXBDN1J5bHBKSUlGS2U4?=
 =?iso-2022-jp?B?ZC9MOUNUSjZaMzgzTUxjZitPMFgxYm9oT1YvWk9GRmIvZmhJeWV0RmZZ?=
 =?iso-2022-jp?B?SXlJWjJtRy9FT29hRlcvaHJSbDVjTll0R1pDNDhkTFlqZzdDbmdWT0Nr?=
 =?iso-2022-jp?B?TWFLQVZqc0N6RnZlZ0xZbyt6MUxZZHJ4dGtlQWxpR2E1MEQrWTQ4VVJ5?=
 =?iso-2022-jp?B?a2YzTFhFcHl2V0ZweW1IQmFsWlFsK2hGeDBLRkl1Z0ErclFsZHVGRmNi?=
 =?iso-2022-jp?B?WUdUbXB0L2U3L0gzc3Q2cHJ3VTVpZ1ZUbmRDcndDWDh0NnJNZE9lOU02?=
 =?iso-2022-jp?B?eE1sa2xac29lY0NlQURQY2h3VFVnQzhzMnVkTjBIR1lyVDRwbk9GWG8y?=
 =?iso-2022-jp?B?d0QwWFllT09wVzVRUGlmNnk4anJHVVkxM3Rvb1hLM1pCK1puTU52MGho?=
 =?iso-2022-jp?B?QThzQkpyMXRTaG94ZkJ6SytjT2pSSHhlL05RQ0cvRGtEQUUwR0k2MWxp?=
 =?iso-2022-jp?B?akxCMTFlZThyNHlBWDRFQXZLbmlVYUJyeWpWMWtPQzNCOVJFck1ZY01o?=
 =?iso-2022-jp?B?TC9VVDhUdlVsMEZCN1RhbmpsZ0VqeTdVckdhQysyVVVKb25iS1c0dCtr?=
 =?iso-2022-jp?B?UlRkbkwzYmJUemRBYU16U2V6ajlNcDVhZGE2YmNhekZIRnRFNnF4RjlM?=
 =?iso-2022-jp?B?Q2RoTnh5ZzZ6Q3NUN3F3QnNCYnYzZHRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?TEN3cEdZOXNubGp5OVJ6Q3dvRG5HcTV2djY0YUsrbVVqZmNhYWpCNmpi?=
 =?iso-2022-jp?B?SG9FeGxNbkt2N1NCRGJJd1VhWUlXNDIvSU80bERCeFhXMkVnamhCNU1V?=
 =?iso-2022-jp?B?L2lQYmY1RmNTRnpzNWtLL2krRlFKQmFFYnRQd1FWY2hsUUw5bWtTV2l3?=
 =?iso-2022-jp?B?aWxHUHV2cUIyWFQ1cDVZUjl6TUxsRDJGWTlXSDc3c0dlSllkTHpKcTZz?=
 =?iso-2022-jp?B?cTVYd3lnN3M5SWlCUVdGWWV4Tm5zYjZqMnI0WG81U3RrOGpjTmJUaXQr?=
 =?iso-2022-jp?B?WjBEWTJOdDFiamdIV1ZSQUNCQkdhdzJLM0REdG93M3d0cTFDYURlcWRC?=
 =?iso-2022-jp?B?WUhBMGRFZmdQNVJkZ1FUZHlON1BtQTNUcytSWEV0czBuOTFxMy9uTjFo?=
 =?iso-2022-jp?B?T0Zid2xYZGZFODJrcXdrOTVubGEyZTNIbzM1eWVPRjdOelNORnVTVEJk?=
 =?iso-2022-jp?B?VXpFSVpFZHBEZVlyREJHamJETU1FbXQ3QkU4Wm5kZmhVYWJ4SjlnYzYw?=
 =?iso-2022-jp?B?KzkrM1FnK0p2WEdNY0llWC96L3Rpc1hkdlJHL29pck1sVjl6KzdOMDN3?=
 =?iso-2022-jp?B?MDNwTGZpbi9va3h6VldkYjdyRVprZndlVEY1VERUWXNGZ21iZUg5ajBZ?=
 =?iso-2022-jp?B?aU83YXpKWE9adFlWKzdER0k0ZjYyZE1MbXUzd1R0RUl0eXh1anprdU05?=
 =?iso-2022-jp?B?L2pDcmp1NWVRNjJqcjRDTVVYbWtWbCtLM1ZYamRIZUM5VlJ2ZlZnOWkz?=
 =?iso-2022-jp?B?WG9MVjVpQmQrZS8rR3psZVVnSEdiWmtZZ2ZVMm40bGsrczMrTWx6Y0xm?=
 =?iso-2022-jp?B?d3FxREFtcml6dThST0wvc2x3NVA3ZTJ2dVFYbXBOcGVVWi9iRGZEU2Uy?=
 =?iso-2022-jp?B?UWFiSUw3S0FwUlhWQWptMktNenR2akhtemRkVHRnN0pMcTBsZDRVWTJU?=
 =?iso-2022-jp?B?aGlOMVJTWmp2bEhpTHU2bDZlZGkxTE02L0UwNGZqME81UVF2ZzZvVzdk?=
 =?iso-2022-jp?B?aXBoRUNDVnkyc1NTRTFEWjFVVCs1WHlxZW5zWkhwUXZJUDBTUXNORlpa?=
 =?iso-2022-jp?B?NGJzOVBHejZsQkQzUjd3TVloRndiRDN2VWF6VFBFN1k2VVRJZVBlVVZG?=
 =?iso-2022-jp?B?N2M5aDhzbEloaFlEU0ZUVmFLUnJ1Ym1TK3lnVW9lRjRxODZEa0FtK0ZJ?=
 =?iso-2022-jp?B?NXFmUDk5VzZpZlJ4Z3hNU2VFUjVhTnYxNjFMaXo4bkUvcS9LbTBjNjVw?=
 =?iso-2022-jp?B?d2hPMkEvODNVcFJvZzdzbHJ3dEZFMUhzUEtyWVQ3QUtvUEJNUmJ6R0t6?=
 =?iso-2022-jp?B?Q1k4aVR3YjRsT1VoYWNUbDAvQjUxUU04VEpSNGxoNzZFUW1iUWx0YTNN?=
 =?iso-2022-jp?B?YkRNaG9wandlRW1MaE1Vb0NxVUZ4cGRvcHQrb1BzZEJRZGZmZTFRcGR2?=
 =?iso-2022-jp?B?bU4zTFBYZW9hUEJxM2lUd2xrdjhWNC9UTzQzeEdJSmRSOGRZS0thaG5i?=
 =?iso-2022-jp?B?OE5tVXFSMnl1SVVyMnZ5THNqL0E3TGtzbGdXTU5OTm54d0hFU293cy9o?=
 =?iso-2022-jp?B?c0NhL29ySTN2RWlRekhIRUVJT0xBaTBvcG5pV2lVZ1FYc01NQmJ4REp0?=
 =?iso-2022-jp?B?TDEwMUJhaTNCd3dsTXhyanpmS1VJVVptekFyL1VWdDVqOHFwVTV6bXB0?=
 =?iso-2022-jp?B?clc5K0lweUxTQURzdlpKcGFQQU5idGtqOFQ5MTBqZmRGTlJSNldWT3d3?=
 =?iso-2022-jp?B?dFlDTm9ZSDVmOHdpR2Z3cmQxTjc0M0toK0x0S2RJZWd0NzVsdmFtb3BD?=
 =?iso-2022-jp?B?VUpxYVFOVHJsSWtzd0tuUXBjdXR2N2VHNDNZbkNwL0F2MkR6TW9RZnZv?=
 =?iso-2022-jp?B?d0VxZ2NIc3lURlhGSGhyOWRWR0Q4ajZUM3U2VWdJeWpmUEtMQU9VdU80?=
 =?iso-2022-jp?B?R0t4ZDV1UUtCUllRcWlJbkg1eWg0aWNXSEwrWHNhbzYrelVJRUJHVUlS?=
 =?iso-2022-jp?B?TzMyOGl0dFJBczMrYnVCakF6WlVZRUp4QnN1bkF2U0loSlorZEk3K00w?=
 =?iso-2022-jp?B?VnBGbGtRWHgvc0Z5VExrQ3g5T1p3NE1lN2IxTlBRTW1pS0JFRnpuOUI0?=
 =?iso-2022-jp?B?MlhlSmcrSWdQcFdUbndjWGEzUnhCZFdvTWVuUUJCRlBLc1g2OGN3bE45?=
 =?iso-2022-jp?B?RG1DS1lmUDZZTmh6ejh4dGRpQzlBNEduMElOUjZJcWlQR0k4bTRtREVD?=
 =?iso-2022-jp?B?b05qR2FvcWpGMGpxOUxERUp2NlZ6NzgvZ3oxY0RBYmhDcFZqbW1UZXg4?=
 =?iso-2022-jp?B?NytMbFpwd21xVTZrbjlxMW05MUI2d2QrU1E9PQ==?=
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
	ieKZnwoqDqgxRV8w2THQc6V5Rde7S3o8/Y5Nt6FETouyUpUBzsF1JJJYBJ9teN7XhVgyVUtLJ6an41jPeGwMSVwSigSvueVKLjBGfD5GxcDzkwiUy1lLJpzHTHIfteSGalx0Qu1i849/frZFsvPdcLOf4j+ec/ihiGqxfIP4hos3bFHbbySqeHUfCWQ6TuuYugbV+5O6uooLxj30cj6vHKebUUV1HV/+m34x1hmoU0XnuilHFxyatYMj4fduUY+NS0lKUpLlPwUqFdboYUp4IAA+nzUq0Z1VLEC619fW9mdmhorhmEGFKb2t0+hqNZ8ZH/Zs/5EEMoYJuHyrcYOANoo9zl2F1BCZhOmQbxjEHrOEfuoMb8yMt/MLhTdtavN5XNOFeVyRz9c8gK3wGgmJjhekW6J4E0Vjbj3ML/a99o0URekhj7o5GC02i2Ko4YBMaLjSUIuZeTeLjJVpu82WY8XvrhmZbtkzg/Yka46d9PIp4nOcu8Ul1QOMnU91ILZVY0XJxyLknIPyb4uQMFFcdCZZP6kM/b6uPnugwrDTnQmjaw7m9VsL836ENBiaNc6ors3ufsTmzX04ZgrNTovmJyebwaIa06qNSLVe8F5R0pcpuoIA4liBBFW2cQMTc2Tv
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e382aebe-12db-4aa4-dce7-08ddf73a1871
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 05:05:04.6146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9iVXD/Jh+Mo1pEIh1Ty7znRNF2jBVxEe2ER1Wm+7DrmNX2jIqJeY0MCzlYpR8aT74HZ7eR4XFeGBSu18hg2wY+MVUEAozm9Y+NeO3BzZR0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14127

Hi Hanjun & Sudeep

> Hi Ilkka
>=20
> > Hi Kazuhiro,
> >
> > On Fri, 5 Sep 2025, Kazuhiro Abe wrote:
> > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > Currently, the AGDI driver only supports SDEI.
> > > Therefore, add support for interrupt signaling mode The interrupt
> > > vector is retrieved from the AGDI table, and call panic function
> > > when an interrupt occurs.
> > >
> > > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> >
> >
> > Looks good to me.
> >
> > Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> >
>=20
> Thanks for your review.
>=20
> Best Regards,
> Kazuhiro Abe
>=20
> >
> > Hanjun & Sudeep, what's your thought on enabling the use of regular
> > interrupts here? I do agree the spec talks about non-maskable ones and
> > to my understanding that's what the idea was indeed.

Do you have any thoughts on this matter?

Best Regards,
Kazuhiro Abe

> >
> > Cheers, Ilkka
> >
> >
> > > ---
> > > I keep normal IRQ code when NMI cannot be used.
> > > If there is any concern, please let me know.
> > >
> > > v2->v3
> > > - Fix bug in the return value of agdi_probe function.
> > > - Remove unnecessary curly braces in the agdi_remove function.
> > >
> > > v2:
> > > https://lore.kernel.org/all/20250829101154.2377800-1-fj1078ii@aa.jp.
> > > fu
> > > jitsu.com/
> > > v1->v2
> > > - Remove acpica update since there is no need to update define value
> > >   for this patch.
> > > ---
> > > drivers/acpi/arm64/agdi.c | 95
> > ++++++++++++++++++++++++++++++++++++---
> > > 1 file changed, 88 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> > > index e0df3daa4abf..2313a46f01cd 100644
> > > --- a/drivers/acpi/arm64/agdi.c
> > > +++ b/drivers/acpi/arm64/agdi.c
> > > @@ -16,7 +16,11 @@
> > > #include "init.h"
> > >
> > > struct agdi_data {
> > > +	unsigned char flags;
> > > 	int sdei_event;
> > > +	unsigned int gsiv;
> > > +	bool use_nmi;
> > > +	int irq;
> > > };
> > >
> > > static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs,
> > > void *arg) @@ -48,6 +52,55 @@ static int agdi_sdei_probe(struct
> > platform_device *pdev,
> > > 	return 0;
> > > }
> > >
> > > +static irqreturn_t agdi_interrupt_handler_nmi(int irq, void
> > > +*dev_id) {
> > > +	nmi_panic(NULL, "Arm Generic Diagnostic Dump and Reset NMI
> > Interrupt event issued\n");
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t agdi_interrupt_handler_irq(int irq, void
> > > +*dev_id) {
> > > +	panic("Arm Generic Diagnostic Dump and Reset Interrupt event
> > issued\n");
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int agdi_interrupt_probe(struct platform_device *pdev,
> > > +				struct agdi_data *adata)
> > > +{
> > > +	unsigned long irq_flags;
> > > +	int ret;
> > > +	int irq;
> > > +
> > > +	irq =3D acpi_register_gsi(NULL, adata->gsiv, ACPI_EDGE_SENSITIVE,
> > ACPI_ACTIVE_HIGH);
> > > +	if (irq < 0) {
> > > +		dev_err(&pdev->dev, "cannot register GSI#%d (%d)\n",
> > adata->gsiv, irq);
> > > +		return irq;
> > > +	}
> > > +
> > > +	irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING |
> IRQF_NO_AUTOEN |
> > > +		    IRQF_NO_THREAD;
> > > +	/* try NMI first */
> > > +	ret =3D request_nmi(irq, &agdi_interrupt_handler_nmi, irq_flags,
> > > +			  "agdi_interrupt_nmi", NULL);
> > > +	if (ret) {
> > > +		ret =3D request_irq(irq, &agdi_interrupt_handler_irq,
> > > +				  irq_flags, "agdi_interrupt_irq", NULL);
> > > +		if (ret) {
> > > +			dev_err(&pdev->dev, "cannot register IRQ %d\n",
> ret);
> > > +			acpi_unregister_gsi(adata->gsiv);
> > > +			return ret;
> > > +		}
> > > +		enable_irq(irq);
> > > +		adata->irq =3D irq;
> > > +	} else {
> > > +		enable_nmi(irq);
> > > +		adata->irq =3D irq;
> > > +		adata->use_nmi =3D true;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > static int agdi_probe(struct platform_device *pdev) {
> > > 	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev); @@ -55,12
> > > +108,15 @@ static int agdi_probe(struct platform_device *pdev)
> > > 	if (!adata)
> > > 		return -EINVAL;
> > >
> > > -	return agdi_sdei_probe(pdev, adata);
> > > +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
> > > +		return agdi_interrupt_probe(pdev, adata);
> > > +	else
> > > +		return agdi_sdei_probe(pdev, adata);
> > > }
> > >
> > > -static void agdi_remove(struct platform_device *pdev)
> > > +static void agdi_sdei_remove(struct platform_device *pdev,
> > > +			     struct agdi_data *adata)
> > > {
> > > -	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev);
> > > 	int err, i;
> > >
> > > 	err =3D sdei_event_disable(adata->sdei_event);
> > > @@ -83,6 +139,29 @@ static void agdi_remove(struct platform_device
> *pdev)
> > > 			adata->sdei_event, ERR_PTR(err)); }
> > >
> > > +static void agdi_interrupt_remove(struct platform_device *pdev,
> > > +				  struct agdi_data *adata)
> > > +{
> > > +	if (adata->irq !=3D -1) {
> > > +		if (adata->use_nmi)
> > > +			free_nmi(adata->irq, NULL);
> > > +		else
> > > +			free_irq(adata->irq, NULL);
> > > +
> > > +		acpi_unregister_gsi(adata->gsiv);
> > > +	}
> > > +}
> > > +
> > > +static void agdi_remove(struct platform_device *pdev) {
> > > +	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev);
> > > +
> > > +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
> > > +		agdi_interrupt_remove(pdev, adata);
> > > +	else
> > > +		agdi_sdei_remove(pdev, adata);
> > > +}
> > > +
> > > static struct platform_driver agdi_driver =3D {
> > > 	.driver =3D {
> > > 		.name =3D "agdi",
> > > @@ -94,7 +173,7 @@ static struct platform_driver agdi_driver =3D {
> > > void __init acpi_agdi_init(void) {
> > > 	struct acpi_table_agdi *agdi_table;
> > > -	struct agdi_data pdata;
> > > +	struct agdi_data pdata =3D {0};
> > > 	struct platform_device *pdev;
> > > 	acpi_status status;
> > >
> > > @@ -104,11 +183,13 @@ void __init acpi_agdi_init(void)
> > > 		return;
> > >
> > > 	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> > > -		pr_warn("Interrupt signaling is not supported");
> > > -		goto err_put_table;
> > > +		pdata.gsiv =3D agdi_table->gsiv;
> > > +	} else {
> > > +		pdata.sdei_event =3D agdi_table->sdei_event;
> > > 	}
> > >
> > > -	pdata.sdei_event =3D agdi_table->sdei_event;
> > > +	pdata.irq =3D -1;
> > > +	pdata.flags =3D agdi_table->flags;
> > >
> > > 	pdev =3D platform_device_register_data(NULL, "agdi", 0, &pdata,
> > sizeof(pdata));
> > > 	if (IS_ERR(pdev))
> > > --
> > > 2.43.0
> > >
> > >

