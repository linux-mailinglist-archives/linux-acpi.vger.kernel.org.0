Return-Path: <linux-acpi+bounces-17393-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20393BA8A86
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7113A6098
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DE52C2358;
	Mon, 29 Sep 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SLaUzfbX";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="K8FFUfNg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD62C21E7;
	Mon, 29 Sep 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138384; cv=fail; b=n/tj1PHDUxJlxSbPE1pjqw0Wvb8FRcWFt8HIVLySTKPQ9BP9RpPVPpE0NTmpefLS/kdNGW2uN+mYDq9ye40BugqLOwLOeMY3FW4hynhuW31bVl7B+6ZZAZp91xu/K2wv2+qRmpTP3mw7F3jgp8xT0JhHeE4OZz95md/pw2CMGsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138384; c=relaxed/simple;
	bh=BBj9OJysCrlc7bnkPiWeT93Wzy7Ax5eqSYVbHiJ75Bs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YOWDA7apqNnvAkvnrboYg90bDDS1pHxpqeODEODS25n3tAeyGxYOyqi7J2pWlnNTCkGGGaGJRINCtebk14qioFBNIvzqJj9A0jfNFavVyB6V1Wlb0whcOBMzVPXff42zxPiXNiP8Y72eFVr9JlxVSPiEpvMA057wYHMt19AkwMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SLaUzfbX; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=K8FFUfNg; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1759138382; x=1790674382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BBj9OJysCrlc7bnkPiWeT93Wzy7Ax5eqSYVbHiJ75Bs=;
  b=SLaUzfbXu8BUExwk73GbIwwfrSsJGbtPpq6YdrIlgLHeS1ML7lJxcEAP
   WfubXcWq+6/Psvbp8ErCrwqr/oBI2iWoZjFCQ3dg6S4JZ+l3vGcpuFdyK
   eICkqW5cJ9oR8S1ia/CL5Ut50fjV7HZOpnvkZf0Lzkiuobb2DCLKUhANl
   ogz2I0w1jLQ128MTDMHsQFjkcMlq6W1+nh/H5t7YIi0lGV1vUw8LJaBfX
   AnfkL160m8AUB38RvfIsH1BAfJTkNN71dYmIiKfwstrTa82EiHDgCGoZm
   Un4tsH9vHPe9KUyzLch0rXkeGVNoyjODqAf21fATSo6z9Hcx3a6FLfaRV
   w==;
X-CSE-ConnectionGUID: Isccqu51S4uGNWvV6X5d0A==
X-CSE-MsgGUID: Qra64bniTr+uiMbOLwoWng==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="169346118"
X-IronPort-AV: E=Sophos;i="6.18,301,1751209200"; 
   d="scan'208";a="169346118"
Received: from mail-japanwestazon11011014.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.14])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 18:31:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuFcY3irc/lJKuglU19W86sBmHXmrATJws5ClkemJ+c83VsdymhTqKMllR/ilyUqKUxQQ9tPSGIbKxcB7LtF0SWTs8lIOKDFvHlcZwghIEeyngoEybSGuCH+81U6Zuet+Ln/hiZDYbF8gBq1DjfzciKZnkSAYvj+eG50HPhMc0HZx34TkZJe8nA27WWwHTqzeJpIXyCcOnsK0UoY8pDXVTv68L/nFxIuM7IQN0UDr6kWxEpYNidL933KeyaQjcOzPxVfbpj1N+NodM9zoHi3GrlXblFT/B5KIyX5WH6flyrDAhK2ewzWdq4em/klCMpWqQBlKbt34Kv0yHvUlZpwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBj9OJysCrlc7bnkPiWeT93Wzy7Ax5eqSYVbHiJ75Bs=;
 b=bmaSETUFeFBa5Kp9XnwnEAEs+wABOYpm8eFCrebW4tMSEQzTmQwZWLAekfC43gZamcMh49FbBIChQLlOoyVt0fJsisXBXRHkp+p1k6zEuWToo0u7pRrIFL+ySJ0xzWuRK4ENAUNf1Uc/lNHtzCpL5HkdpTfsq11HS5WywCcQjDKx0iIliNRLe/0E6dwrGhzWQLD8y+iHt4KBAOcZ0/cTGzRj8EkiRaJ90Yb3bGdtUT+r7hMy+pibNfFntsVLnFVuAJ9QQpJDy7mPtzgQISSv7r59z3YCyhRcvGNNKxO5VuZsM+W4ziR2Qr6NBA59xJNw2TJ1yYdUc135ftdI9nssEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBj9OJysCrlc7bnkPiWeT93Wzy7Ax5eqSYVbHiJ75Bs=;
 b=K8FFUfNgvRZfcpk0d1UORwsYbwxI6vZIjVzjdAygRpqNtvDUb/0QXFMCAQrkY4a1ompQFbfQLz1CEnvUL/0ui/M+TLx1FGdYb9Of3WoSkJfrbq4VXkpxplhN+kA38kZLdz9LJr/+RtW6msQUqo5cpG0/X5zt+R9G7pYUdPBPWnB0CUcq58+vPW3vmrVEH/drC/t/R9JUweAH25i/gpAUSvNDSDvqh36BDsYDeG8p5YZgim3+tmLrLcQrL8o/g1v0TeYlasTRc30K/kwAoSqP2UXWm+vgK2krLjbk/yLeqK55y3eV0+wZ2ygvDPMJT9pUJGnRo02N0BdY481PRGDy/Q==
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 by OS7PR01MB11615.jpnprd01.prod.outlook.com (2603:1096:604:244::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 09:31:43 +0000
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1]) by TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1%6]) with mapi id 15.20.9160.011; Mon, 29 Sep 2025
 09:31:43 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Hanjun Guo' <guohanjun@huawei.com>, 'Ilkka Koskinen'
	<ilkka@os.amperecomputing.com>, 'Sudeep Holla' <sudeep.holla@arm.com>
CC: 'Lorenzo Pieralisi' <lpieralisi@kernel.org>, "'Rafael J. Wysocki'"
	<rafael@kernel.org>, 'Len Brown' <lenb@kernel.org>,
	"'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index:
 AQHcHh171tqf09K4SkK1ciG0VLTs/LSJqfEAgAPpfaCADGlN8IAMe3yAgANvbvCAABwZgIAAAqbQ
Date: Mon, 29 Sep 2025 09:31:43 +0000
Message-ID:
 <TY3PR01MB9983121D6F4EC2324C4367CAD51BA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
References: <20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com>
 <bd45c06a-77cc-2ab3-122e-41dee1aee0ac@os.amperecomputing.com>
 <TY3PR01MB99836C3D57503E70C8B8C9E9D509A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
 <TY3PR01MB9983025D434CAA2CDF83656BD511A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
 <3bbdc50e-a55c-96ed-a8db-6bbce1760ee4@huawei.com>
 <TY3PR01MB9983E784E31A612B9BA23255D51BA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
 <b8ab020f-8298-cadd-70ee-9325c32b968f@huawei.com>
In-Reply-To: <b8ab020f-8298-cadd-70ee-9325c32b968f@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZjdkZDUzNDMtYjhmYS00YzJhLWEyMzAtZTgzMDJmODQ2?=
 =?utf-8?B?MGFlO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTA5LTI5VDA5OjEzOjM0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_|OS7PR01MB11615:EE_
x-ms-office365-filtering-correlation-id: 24d13434-610b-4d96-1743-08ddff3b00a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nzl1ZzcybVFFTG9FdHFzTVV3cTk3VzJ4eVZNS25LVTR3L0RpcHBiUmczQ2Nj?=
 =?utf-8?B?UUsxdFdnN3BsZ0tCWTF1dWVSTnl4SmpVK1NpTTFPWlJ1QU1KdXJpbVNwUnlq?=
 =?utf-8?B?czZxQkhUM1BUOEhHTzhIY1k2THNIZnNCTEkvK1hSNmpHOTVVM0p1Rjh3NnRa?=
 =?utf-8?B?UkU3T28vSVMxOU5lRlJDKzBlUWpXZDRzZGVhS2dubWV4aENVcmJrQ3ExMVdF?=
 =?utf-8?B?bTI3NTM2eDg3N2JoSzA3RnZIUXRxdngyL3dNbmx6R1pvc1dHbEJOZzk4WnV5?=
 =?utf-8?B?SE9LbDFrV1lwZ0NQSStidy9HTGw0cFhsUllKaVRUNTF4VUM1SE5nUUpXTVpJ?=
 =?utf-8?B?SFVLa0JFdWFTUklYN3o3WExSNTQybktBQUt4VkxtcGUwOW9hQXF5Vy82UjZa?=
 =?utf-8?B?Tlp6SjRmR1ZDQjhFWVZ0Z0c4OFU5KzZHZWhmQlo3M3B3aENEQ1V6eTFyV2FN?=
 =?utf-8?B?b2QwUDdCZjlEM2RHNVdOZHZBWTBkQ1VTVXdxZm5zSWh1dEtydTZPNEkwOUNl?=
 =?utf-8?B?bjk0SnRGby9qbmJCZ29GeCtyTHBtd1dIbG1LQ0dIcnhNQ29NM1R4WUg4RTBM?=
 =?utf-8?B?OE5ORHo0VWtUS09BbFo0TVpLNnA2MUZLbXdNVGJiWXkwdUJndnFtd3JyWDRq?=
 =?utf-8?B?YUtSc2hRR1RGOFVzeGtiNmJvOE5zcklNZzVyRXBJY0FjbmFQaFZqWDg2RUw4?=
 =?utf-8?B?ZFdSSGZTNjgxYVJWekZhdGxPRGRqUkpZYUdpbEt5aGE5emZ6LzdoMEI0bEUz?=
 =?utf-8?B?ZWxNZytRL2lXOHVScHovMnF0Mk5hVGQ3WUg1ak4wQXlhSS9vcmplZ3RuOG53?=
 =?utf-8?B?Nit2WEF1Sjh1cndGdjJYTUNRV3BZVElydGg0WG55ckpvSDZkZDErU1Exd2JN?=
 =?utf-8?B?NTRJeGh2Nit0WXJJNFpUcVdDdTVCa1J0OEN3eUo3a1hLQlFnSE92bzJhSFIx?=
 =?utf-8?B?bzRXc3JkOURzTUlPajU5Ulh0QTNLdjY5Z3g0bnJ0dHhVRHl0dGYrdW5LclF5?=
 =?utf-8?B?UmZVOFlpajJJaWVKNkhpZ282cjJOa0Roc0dkSnZQdUw1ZU1BRnJzODQyRk9Q?=
 =?utf-8?B?aHRlNkVCdGpmNDM0cjJHeWlGU1Z4L2IzWHdscENRbExlU0tLdDBRSDc0OHJ6?=
 =?utf-8?B?aG1CMzhFcEdKSU9HTXNHR0t4Slhla3pXSDZjaVB4MWZsTW1nMEdaU1l3U0Nk?=
 =?utf-8?B?RllDMjVvR1ZjZnBBMjFGSWlFV25BcmRmMTA1eER5WnBTblNYR0tMK3phVVFz?=
 =?utf-8?B?NFcvYXVXdUdONGpyWWxueWpHVDBRdFNrZGdkdk0rSGJudjJqL0l6c1BOZnUw?=
 =?utf-8?B?SlhTNUJrMmxTOVZhV1lmTnFnYlprSnhWS1VBMGJEejE3SGtoYUdkSkJNN2Nr?=
 =?utf-8?B?UHM5WXBRWDMvU0R5QytaWWZsS3pVay9FK2RxS2RZTndpOFlVd1NwSS9XbVRz?=
 =?utf-8?B?ZGxoYXJFNDRIcGcwOC8yWXJVSUhaZE5rZ2hRN1poWURBSzJWNmEzeUovY1Y3?=
 =?utf-8?B?UERhY0Rud0txNGlqd1NqT0E0RG9aZ0puMFFVNDFTS0orRXQ1RUg2a3RCczhZ?=
 =?utf-8?B?VlBscVpOVkNLWU1xZytZSXBLSk9xN21DaWo0alJWTTBUWldwWTZaZ0RZMHFJ?=
 =?utf-8?B?T0d5bE5RcHUwaDE5ZlV3cklUMEpHRkorR2t4TjB6QWdVNGJUWVpwYzdiMjJr?=
 =?utf-8?B?bjN6OGZWbkNOMGxDNCtrUU0ycUk4TnB4cGE3dUZ5V3hWVXhodElOb1lQdDVx?=
 =?utf-8?B?U0orUDhHK1BOZGpoL1BJWjRHZ3UyN0Fic2hLR1V6dXpkWEpPdnVHbkZqcVhr?=
 =?utf-8?B?U2lPZk5YRDdzQzRscXk5TjR6ekdmY2taSGtMZ0g0SGVXMXlnTnEyaVNITnBn?=
 =?utf-8?B?c2J6VjJyMzltT2RIQXVJZlh0K0ltellDSEJZckw0ZkZrNTNjd0tOaXhMTU5Y?=
 =?utf-8?B?WWkyS2prN0RsRy9jV1UwbHJDYjV5eFR3NGV4TzN5Mkh6dUpwMHIrd1oxWU9W?=
 =?utf-8?B?Y1FRS21ta1l1ODJHLzJ2SktJb25PUEV0ZGxLZ2FLMEhUUVZ6dktSUEpFbVd1?=
 =?utf-8?B?SERLK0lJVlVldjBzemFscG9SdHJMQnJVYVRnd0xKVWRjWnRubDNkUjNqQzM1?=
 =?utf-8?Q?/LHw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amlqSHA0UDVhOHdtSnVKQmczL254NTgzR3JzbzZBL1ZjVXB6QUczTXFXVGNH?=
 =?utf-8?B?bkJiQ280c25sdGxlS2N3azB1a0tsU0NyV0FPZUhKNmxSdWRrRlFORDBmNE1a?=
 =?utf-8?B?ek9Gdk8vbjI0emM1c1ZKQ1Y0T0lHMmlSWEU2S1QwSm5RemMydEdIUXViMEd1?=
 =?utf-8?B?N3JBaldmcHM0QnFTcHg5czZtRDI1Z0gyTFZMd3VXSThjY2VZTHZkQytVdW5R?=
 =?utf-8?B?QUtKQ1ZiRFh3cEJwaVhsZ1Q0OWEyVHNQOGZyTVhodmozQ3BFQ3N6Rkt2Vjcz?=
 =?utf-8?B?dmxLTVdSUUVReWhKVmd5bGJlMVl1cnh6STFiTlhUSTRvdHF5MWUvZG90QmFB?=
 =?utf-8?B?V2NXdjcrdnhOZ1hyS0p6NVZlQlJTM3NEU1FtaGxGbzgvdlNaK2hRSVJYMjNY?=
 =?utf-8?B?TmVzV3hSbXZHZ3RJL2VuQ0srMFpDSUh3WDdDZDBjYmFrTUZNR3pJU3Q5NXkx?=
 =?utf-8?B?ZVc2elhkWWduN2x3MFRVdXVVYkxmQ3N4Zm50akJGayttWGw4OUZOOUxBOGwv?=
 =?utf-8?B?aGx6MFlmV1hNV0wwTHpHaGtVRm1UZW56MUZOdVFab2s1dE54ZWFwU3M0T3BG?=
 =?utf-8?B?aEtIUG5jUEZSd2MxQmJpVVN3eFJkVkZKaXM2dElmaFBLMUl3UjNxbmpiekla?=
 =?utf-8?B?MDdOcDF5ME85NGxjbFJMSCtiaThldy81amxHTWs3ZCt4eFIyYXIvS1BoMCtp?=
 =?utf-8?B?NE9kZDRkWFd0LzFSRThYR29LUEZnbzZvdDFlTmR0aDVpOHNLVldCRmhWSkdO?=
 =?utf-8?B?RTMxaDU5Um43aDNyVWRRUzMwZzZNYzdLVmlwMnhRYm9TVmNpekordGE0UFVW?=
 =?utf-8?B?K2ZKNjc3TVdoMk45WDloRDhtemx2TnNzRzl3emRmaWYyMEpTUUNpdmp3YXRl?=
 =?utf-8?B?QW9iOE1yYUZqL3ZjVnlLQUxYbWtFRHoxSnd4U08weW9lSk1Yb3RzU2w5WDN4?=
 =?utf-8?B?RGhhSDFMUUpmVFlpTHZMRVRUcGVYM21iMEZjaXhkYUJZSzRhWXJBeHhzQ1F5?=
 =?utf-8?B?TTdDa3cyWUk3WVdDT05lTmNDYVNFNkxGUEovbU1QK3hJcXg1N1NYdCtrWmZn?=
 =?utf-8?B?L3ZBV0Y5bXhGTFVJbyt2ekRJTy9BM2pYVEJkeVVEbTJuWVFMK0ZwcVVQRU13?=
 =?utf-8?B?ejF1Qlp5c2t4SUpDd2hYRFpBd2VVZ3hKWlN6M2s1bjkwQ0pwKzJqTksyWFda?=
 =?utf-8?B?dTdYck5uT3ZYSTRWc0ZQbzBPc1d0NnQwOVF3NFA5S3llNnh2SFIrL2l5Y09Y?=
 =?utf-8?B?TEhTcUxITW5SNUhHYnJqLzRtbWlaODBNL3RjbFEwZ2ZWOUxkRTNWM1VKKzZw?=
 =?utf-8?B?dG1INW9GbFFCdFNTeWJrUW9xV0FZMGhWZTBDNi9DNUR6S1pxSXlGSUFrRzI2?=
 =?utf-8?B?bjVOYmh3OXdtMUFrWE5PaTU4ekxoaUFGQUM1NFJDc040R3dGMkRjT1d4cE0r?=
 =?utf-8?B?aEU5M1FHWEpSbkNqNisrMkpqazZLYlkrU2ZiWVBYQzgveHFVTHI3QlkwUXp2?=
 =?utf-8?B?K2xrUHg1MlpSVXJDOSsvRlpLN0Fsc2FaMTRwSENPY1FrRzhkbEtXaDNXbTVx?=
 =?utf-8?B?dTJFLzBrOFgwcEFPQWw2OHFGOThEekF5SU1kL2Y3ZzZhY2F3alk1bzRycUcx?=
 =?utf-8?B?Q0FXcHRBQXFMQUtnNi8xdCtCR3N2alVGelpka0F6L3luOXk2SGZXWTdUV2ph?=
 =?utf-8?B?UDF4Y2J4RktNV09UUFFUM21BeGUwRzdCaDFhZmN3VWU5SDhHZTlGZHRHQmJR?=
 =?utf-8?B?UXBSVXBPNmpjZER1VkJ5RW13MVZYVUY2Q0haMzBuRmRVd0FSNkxRUmlkazZ5?=
 =?utf-8?B?N3VKdit3QXdLaU1yTDJwRlZHVHZUYkIyeEVlN2F2Q2NGNS9hUXZQamVwMlI0?=
 =?utf-8?B?VjRsYTE1TzVSbU54YXFJd0RsZi9lcjdQanNoanZRVVU3blNpMXlHRUZmOTdW?=
 =?utf-8?B?dXhBaDZGY0dXS0FMNUJTTVF5UU5UWlRYVmNnejZBMGlEYW1nTUIyZnNDZkw4?=
 =?utf-8?B?U2NvK3pMajk2bVlvMEorWDlKL1JMdVluSUgyZlRPTk14Vk9DNDR1a3VZZ1dS?=
 =?utf-8?B?cHBTQnRUZEk3VWEvMzlnNkF3ZmkwMDRrZGdrci9XNjdXaW8raDVuYzVRR05V?=
 =?utf-8?B?R0xlZE5WR3ZkYldUU0w3SnBpaiszaTF5a1h5VGQyRmt2OWJHSHhqNUpDcnBY?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uiuvtw+3SCQ48RsZhWYp4vrINug5tCNMz8ubzh6RFdpY5emSrh9Se3tviMBhVhfbU3dvi/S3Ja408zU6cei6hdXjbqchP8Uk98RLjgp43l0wZ6BfXTPiKJvjIZYECCiR1en/1d8Mgw4UIvuHyatM6wlwuIN9Yjb70/WFLZ9Y28rfw8VLJG2VaCB/GRzjM9u72Nrv68qneXSF08r2MxtcR1TXOvUXyRcuazyJMc4RE1P903ozHj97hVl8tyFaND5ixwcRZyCi/bCYHVTqIG7T1HttwQu/G4c4qAqxksT0cL4Kw2vzaQMkAiexwuUR8aCYJm4BUP3hDdwOwOilvaxs3P0YFYwc593fFlYi3BgsXLUy7sXqTPw8hJPoeRB5f1p9no5uRhVaR2QQHqQ7/SM+BgoZ5tjOAC0uw9PSAlknqtXl2BFjmb8yt92Byc6e0Z/bRDaqne8w0bfgOe5sGkf4bRd8gLaHtrzM2h+tGCICgFCN7PccSDjJh8LJGUV9lFJkmW2WjKyAWoDOqq23pFILnLyYf3fLAw7kr9Xk/wA9cP7KMcL6VrMBAwXW2yVgISyv7CLYiAq7HHkW4HEwijW94U8rfy2Rze/bOatjDjf3Jqzc1SLjx9Zi3L5hC265hqnG
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d13434-610b-4d96-1743-08ddff3b00a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 09:31:43.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNpWAWQAQiig3L4Q4V5QXg0pv8dLR+rPXk1nfltoM60zrn/cw7rDlEdqwj6+vmYRKlO9EHs7ywoIuNmEESi7VihVAw3xgPl5AmG7PJ5PpYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11615

SGkgSGFuanVuLA0KDQo+ID4gSGkgSGFuanVuLA0KPiA+DQo+ID4+PiBIaSBIYW5qdW4gJiBTdWRl
ZXANCj4gPj4+DQo+ID4+Pj4gSGkgSWxra2ENCj4gPj4+Pg0KPiA+Pj4+PiBIaSBLYXp1aGlybywN
Cj4gPj4+Pj4NCj4gPj4+Pj4gT24gRnJpLCA1IFNlcCAyMDI1LCBLYXp1aGlybyBBYmUgd3JvdGU6
DQo+ID4+Pj4+PiBBR0RJIGhhcyB0d28gdHlwZXMgb2Ygc2lnbmFsaW5nIG1vZGVzOiBTREVJIGFu
ZCBpbnRlcnJ1cHQuDQo+ID4+Pj4+PiBDdXJyZW50bHksIHRoZSBBR0RJIGRyaXZlciBvbmx5IHN1
cHBvcnRzIFNERUkuDQo+ID4+Pj4+PiBUaGVyZWZvcmUsIGFkZCBzdXBwb3J0IGZvciBpbnRlcnJ1
cHQgc2lnbmFsaW5nIG1vZGUgVGhlIGludGVycnVwdA0KPiA+Pj4+Pj4gdmVjdG9yIGlzIHJldHJp
ZXZlZCBmcm9tIHRoZSBBR0RJIHRhYmxlLCBhbmQgY2FsbCBwYW5pYyBmdW5jdGlvbg0KPiA+Pj4+
Pj4gd2hlbiBhbiBpbnRlcnJ1cHQgb2NjdXJzLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEthenVoaXJvIEFiZTxmajEwNzhpaUBhYS5qcC5mdWppdHN1LmNvbT4NCj4gPj4+Pj4N
Cj4gPj4+Pj4gTG9va3MgZ29vZCB0byBtZS4NCj4gPj4+Pj4NCj4gPj4+Pj4gUmV2aWV3ZWQtYnk6
IElsa2thIEtvc2tpbmVuPGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+ID4+Pj4+DQo+
ID4+Pj4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gPj4+Pg0KPiA+Pj4+IEJlc3QgUmVnYXJk
cywNCj4gPj4+PiBLYXp1aGlybyBBYmUNCj4gPj4+Pg0KPiA+Pj4+PiBIYW5qdW4gJiBTdWRlZXAs
IHdoYXQncyB5b3VyIHRob3VnaHQgb24gZW5hYmxpbmcgdGhlIHVzZSBvZiByZWd1bGFyDQo+ID4+
Pj4+IGludGVycnVwdHMgaGVyZT8gSSBkbyBhZ3JlZSB0aGUgc3BlYyB0YWxrcyBhYm91dCBub24t
bWFza2FibGUgb25lcw0KPiA+Pj4+PiBhbmQgdG8gbXkgdW5kZXJzdGFuZGluZyB0aGF0J3Mgd2hh
dCB0aGUgaWRlYSB3YXMgaW5kZWVkLg0KPiA+Pj4gRG8geW91IGhhdmUgYW55IHRob3VnaHRzIG9u
IHRoaXMgbWF0dGVyPw0KPiA+PiBGb3IgdGhlIHJlYWwgdXNlIGNhc2UsIGlmIHRoZSBzeXN0ZW0g
aXMgaW4gZmFpbHVyZSBzdGF0ZSwgZm9yIGV4YW1wbGUsIHRoZSBzeXN0ZW0NCj4gaXMNCj4gPj4g
cGFuaWMsIHRoZSBDUFUgd2lsbCBub3QgaGFuZGxlIHJlZ3VsYXIgaW50ZXJydXB0cywgc28gd2hh
dCdzIHRoZSB1c2UgY2FzZSBkbw0KPiB5b3UNCj4gPj4gaGF2ZSB0byB1c2UgcmVndWxhciBpbnRl
cnJ1cHQ/DQo+ID4gVGhpcyBkcml2ZXIgaXMgZGVzaWduZWQgdG8gb3BlcmF0ZSB3aXRoIE5NSSBl
bmFibGVkLg0KPiA+DQo+ID4gSG93ZXZlciwgb24gY3VycmVudCBBUk02NCBwbGF0Zm9ybXMsIE5N
SSBmdW5jdGlvbmFsaXR5IG1heSBub3QgYmUgYWN0aXZlDQo+IHVubGVzcw0KPiA+ICJwc2V1ZG8g
Tk1JIiBpcyBleHBsaWNpdGx5IHNwZWNpZmllZCB2aWEgYSBrZXJuZWwgY29tbWFuZC1saW5lIHBh
cmFtZXRlci4NCj4gPiBJbiBzdWNoIHNjZW5hcmlvcywgd2UndmUgaW5jbHVkZWQgcmVndWxhciBp
bnRlcnJ1cHQgaGFuZGxpbmcgYXMgYSBsYXN0IHJlc29ydCwNCj4gPiBhbnRpY2lwYXRpbmcgcmFy
ZSBjYXNlcyB3aGVyZSBzb21lIGNvcmVzIG1pZ2h0IHN0aWxsIGJlIGFibGUgdG8gcmVjZWl2ZSBy
ZWd1bGFyDQo+ID4gaW50ZXJydXB0cyBldmVuIGlmIG90aGVyIGNvcmVzIGFyZSB1bnJlc3BvbnNp
dmUuDQo+ID4NCj4gPiBUbyByZWl0ZXJhdGUsIHRoZSB1bmRlcmx5aW5nIGFzc3VtcHRpb24gaXMg
dGhhdCBOTUkobm93IHBzZXVkbyBOTUkpIGlzDQo+IGVuYWJsZWQgZm9yIHVzZS4NCj4gDQo+IE9L
LiBQbGVhc2Ugc2VuZCBhIG5ldyB2ZXJzaW9uLCBJIHdpbGwgYWNrIGl0DQo+IGlmIHlvdSBhZGRy
ZXNzIG15IGNvbW1lbnRzLg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4NCkkgd2lsbCBzZW5k
IGEgbmV3IHZlcnNpb24gd2l0aCB5b3VyIGNvbW1lbnRzIGFkZHJlc3NlZCBhZnRlciA2LjE4LXJj
MSBpcyByZWxlYXNlZC4NCg0KQmVzdCBSZWdhcmRzLA0KS2F6dWhpcm8gQWJlDQoNCj4gDQo+IFRo
YW5rcw0KPiBIYW5qdW4NCg==

