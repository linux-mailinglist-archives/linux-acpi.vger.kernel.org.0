Return-Path: <linux-acpi+bounces-16007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9076B338AD
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD10717FB08
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666D29A323;
	Mon, 25 Aug 2025 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ic59h0NN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F1220F49;
	Mon, 25 Aug 2025 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110275; cv=fail; b=uLeTs4qp2cSryzuRF6D7dQ/9/S9+NXsziDFc4XPLLkIxcWWcuSqLMisMvli2WMH3ClQbkOVF3JBH/3Vos9RlICGHJhvuZ11Ce4hC9OxwGDW5t5YJu8NkA5MuKKykCXaHdM3+PRKViAUSC0gQRclCerhU/A/fcjiQjbMGWajoS1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110275; c=relaxed/simple;
	bh=9kgzJokI6npNzXE5CJN5iey9qv2Qmu2wXRPfxEcZC3I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DMiygubVrkEgigDi1XqtGWHe23WTWhdipWoSGH4fXKqaXJYJECPj/o64FAzaUspPiJhRYZ4t9blo32cNH0IvTMM6qf2x8dw3/2YPNNvLD3cOXjacPrhrFu8F9gxin3d4NukkiP0Ny0YRL6pzmT/W8wLVTSbljEGbFN/55sGGhvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ic59h0NN; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756110272; x=1787646272;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9kgzJokI6npNzXE5CJN5iey9qv2Qmu2wXRPfxEcZC3I=;
  b=ic59h0NNvecYqe7LpaIVDqKJF1a+wnAvf8lIaBiwuETeCL9rQxGki2Zc
   b5mdaixYYiu0jP8NNwTleCHpY3Igb6Grcr2tMztaFiuZIKdP4yXb1Wzq3
   R8MpjQSRT2RjsJPuFd4w3G/HmmwTqJdPoD/jStLA0w5kxpMF90zvZgyBp
   +h+eHIfNO8uYSQEqeGbMpLtJD5V/A5mUfjfRzIlN+4Gedkt3WxeybS6zX
   d8+tuKqmn2jM2STuzDIAeFFKuqfzhpZCz8JV4DchaN3OnhTtjifkmBBbY
   1BpOcarkE5RqegQDHnBjHQXKWsYIa9YAZUy22PMzH/Lge2NXIgWVcSwk9
   g==;
X-CSE-ConnectionGUID: oJyFgnavQ8G2eGw5rNY0Bg==
X-CSE-MsgGUID: vyRyXNipQtGbbUjG9htGRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="165596215"
X-IronPort-AV: E=Sophos;i="6.17,312,1747666800"; 
   d="scan'208";a="165596215"
Received: from mail-japaneastazon11010070.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.70])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 17:22:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qymnd3LFM0xHWOkY1wrf02yJLsXUErCPMMBjwdXWIIaICfWToTF2XF92gMJb9u645k9nBByzmHm+jIiUg53ZF8xcxZzpgyAQSJQldu53Hj2d+1h8Au9D2YuyaibRLNu2rHy43xgDeh6ZiJ6IJKT0AVH8Eg77mXHZ6UxCWa9+MXHCJAYJbe6bgahVrJHhxNubHL7xgerlw3W/bYZwaB1BghlhVkyPih6AbNe/EpgsgU/5F4zDHrHfQKhXx54pVdELyth5Qr2iglCFg40zyCv0XQvUsTw022RYkDrmEbjH5FR8i232lOBptS9AlqrBvQqfzOm6byC/g8M0hocJZ7qAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kgzJokI6npNzXE5CJN5iey9qv2Qmu2wXRPfxEcZC3I=;
 b=EqYnu/X2rziuQQqd0yplVcxfCpE3xyKAhG5wjuJDJ0OXVtlJ+FiF0aBiQ7DPyeC9z3vluYxWRlhXTqiQAAk3F8xOHRsvobetqigNbGVqPqYqcP/p13WDq928T1huB7kBXsmhN40JHeoS5AQ1cosOhVnHxKipWqAV4x4efdbVOxVe6gq1gqtlauLQHr5pO5Zew5Ic64++hscPcUHPRuHwlR7FYwgoEN/qux2/6rWMhYdupnbkP9dBmyei7Ba3tVB+Fd7ZtCKZEkZM2ql0Lc9EjGYqPeGAg7RDTXCByHZJkP1idzut+uA6MMvzyFvw2qXCvw1O12owwzxYdovKRDFbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 by TYCPR01MB8551.jpnprd01.prod.outlook.com (2603:1096:400:150::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 08:22:47 +0000
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1]) by TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1%6]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 08:22:47 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Hanjun Guo' <guohanjun@huawei.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcEA0DtJrppafZxEO8iry1iSQK/rRqEFqAgAj9y4A=
Date: Mon, 25 Aug 2025 08:22:47 +0000
Message-ID:
 <TY3PR01MB9983ACD7CF3A638D96083536D53EA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
References: <20250818065437.85905-1-fj1078ii@aa.jp.fujitsu.com>
 <57c0e289-8d03-785b-15a7-18df3763be8a@huawei.com>
In-Reply-To: <57c0e289-8d03-785b-15a7-18df3763be8a@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YjZkZjY1YjktMGNmZC00OTU5LTg4ODgtYjk5MWE0ZjMz?=
 =?utf-8?B?MGE1O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTA4LTI1VDA4OjA2OjQ0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_|TYCPR01MB8551:EE_
x-ms-office365-filtering-correlation-id: 678e12fb-4e83-40df-f342-08dde3b092d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ny9Kb250VHg1Szd5aDU4WUJsQTJ1L1pESStCdkVNYlc3VHBCUW80dDZhQjZx?=
 =?utf-8?B?UDlzZ0xLaXZ2QUZpejI2TDFzZjZxV09hRHlQeWJRTW9ieU9hb2lRdisySE1T?=
 =?utf-8?B?VHlSN0RnZTFHYWlwNG9YemJpamx5R1g5bkZUY0xWTzZROXhDeS9SWkRtdmxr?=
 =?utf-8?B?NHdOZTRMRm1mQnRURUFmam5ocXZJUDAySEluVml0UGxkb0IvMnNZUXVWNzh3?=
 =?utf-8?B?MDYvZ0xIQTRNRFQ3b09ucFBzWndueUNFQWhnMUN5RWtLWGM1d1FEakFtL1pa?=
 =?utf-8?B?Q2IwQXZYTEVFVzhIL1VjMWQyUWFPQWxBYUFsMS8ydjlVU1RjcmJxQ3l6czRB?=
 =?utf-8?B?U08vbnJYaVlQZXFpNTdpNDlienEwRHRLbW9OSUZJWWxManZtU0w3TWVsek15?=
 =?utf-8?B?VG5yWHQwMEk3blBiSGtkMVdDUnkyWXk1K2NnQldrSk9ETjhKRUk3NzFkRU1L?=
 =?utf-8?B?VGZVdUdId2luZU1ZZGJKbzJnUDNsZFRMY25abmxISXhhWlNiemE0dE91ZGxT?=
 =?utf-8?B?aVNBeGVaSFlTM1hLWkE0RENjeVBDMDRaNVovQWRlVWpZZ3UyQ2pKRlIzK212?=
 =?utf-8?B?dG5hOU43MnI1Q3k2d2Uydm0yK2hhR0FEQ0JEOUF0bmNNTGNENmE5dDRDM24r?=
 =?utf-8?B?STVKK1VseldjeitHdlZYK2ZZS3RRMVl5bTFWS2lDbFZjc0ZhdUtnYWx3ZU1B?=
 =?utf-8?B?VFlSQWpMWGEwQVJuMmM0a2FrUlJaVy9ROW9sUm54THBwZi9Vblk4d3ZjZERM?=
 =?utf-8?B?M2pnTTRsOVoxTUdkbFY5cG9uanowYUtUaStUMTlIdDk3dUZyUFVvKytjMEw0?=
 =?utf-8?B?amlUR2wwOXdlMDZabjZnZ0paZWY1L252MmxVRGc3bFFkZDgrcDJ5YTQ4N2Vm?=
 =?utf-8?B?VkVXVzExOWRPQjZwRElYQWZBWGUvNVRDTTRvV3B6UGFCN2p5eGEzbEJCWm9J?=
 =?utf-8?B?RjJoanZHL0lJU2Z3MXlMMFg3d1ZSTit2b0c4YnhBcWhVc1VoL0o3UG5PQTRs?=
 =?utf-8?B?UFRiSElLRENiUnBNdTBYbEpLN3lpSGlNMHY0dEVvMjZNQnNRbHFreVhkZnQw?=
 =?utf-8?B?VDJFMXJmZWpacStvbm1iMm8rYWhJOW5OcTk1b2piYUFyU3BCNWV4ekZhb0dt?=
 =?utf-8?B?YnlkL2g0U2I3d01pa1R3NTJyZ1poMTBITmxMNHFGUTZONDgrS3ZucjBQQ1l4?=
 =?utf-8?B?RSs3cnVta0VNcG0xeEtGZ2NBcld1ZVVOS0VXNmJOZ2s2Y01uR2xZRlhoelQy?=
 =?utf-8?B?NGl1VTFPNVgxZXE0c1pCUHE4S05temJvNUpLa2srcGFDSnpVNUVPSnQzOSty?=
 =?utf-8?B?UFY4ZUpOTWttcmFCWmFqdWtaRWY4QmQyOWN6QVFYNUdhNDU1emNWTk1KQWhB?=
 =?utf-8?B?Q3BRc2wzYU5weHVhM296azA0VVVJK3JrTzRYdzdpK1pjZUhENXhCWHNDNEZh?=
 =?utf-8?B?bzc5RVprWDlSTzI1cmVNWmFwYnhoU1l5YmpBdmFvY0JpeER1Mmozb1JuS0pY?=
 =?utf-8?B?Q1hOQlVCMkJrUmxJTzFRY2FrRWJlbE1rNnpvZ21RVWJrem0vZXM0MWtYMUlM?=
 =?utf-8?B?NFlxandNNmllOUh1NkJxVmp3WFRzWGtGTDFMMDkzYWJPaXB1TCtreHZDdjVM?=
 =?utf-8?B?bGJDUGxJWDROdjVWaStkdW94bE0vMlJ6eXpxaElRTzQ3bE9FZm0raEtUK0Qy?=
 =?utf-8?B?Z1Uvem5NVUpNTnVYbnRaZ2lxWFFpdTl2bWNPZ3VpMDEyZUl5YUhVS3JLNnpn?=
 =?utf-8?B?OWNNL2FtVit3SmdaeFl3cnBwMmEwV2JlS3ZycXJHS0tsN0V1SFNSRWpBMjZn?=
 =?utf-8?B?dFdLNnlxRmREZ1A5WWlQWURodDZNWU5ObWdWRnJ2MW40MkhrUm0xQ1o3ZTR3?=
 =?utf-8?B?ZC95b2d6N2o4b05Rc0ZBeFp5Vmw0MmJlQXFGbnJreTFnOUNzUDAvQ3RWOWNo?=
 =?utf-8?B?dC9yT0hTOEJVYS8vd3lMK3Jsc1lOaEtWV3h5UU5CV1NFb3JoQlRZS2U3ZE83?=
 =?utf-8?B?b2JxbTI0UmlOQXh2TUpuVDBKL3lnRko5ai9vclQ3WVpxY1M3VS9FNjd1U2hN?=
 =?utf-8?Q?sKktyP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTE1VDA1QzJJV2JoanhBQXNJSVdWSFhlSHN0UkFjZ0k2VWtzc1RjS3c0d2pC?=
 =?utf-8?B?K2d6T0ZFVlV2UDVrSVFaMU9Yd2sxVXRvWDBMSXh3U1hsaVN3ZlhISGhaVlhL?=
 =?utf-8?B?d2o3dHNPcER2L3N4SWV5ek1ETFZkVlAwWmJoTENPNXE0Q1NxRzEzWSsrTkdB?=
 =?utf-8?B?dk56TEFwSGh2UHNCN280K0hGZXZKcUNtTWNlSlcyR0pQOEhkZlJOYTMwRGU3?=
 =?utf-8?B?Q1VDdkNGYUpPNk5IOGZjNlZ4Q1RjcEU5YVdsUldrWjhTUldkelZpNFQyMDBo?=
 =?utf-8?B?UmthTWdBbEg0S3hRT1ZNTWVOMmFjbDV6N3IyUlNqTGU2Mi93bytCbTQ5MjNl?=
 =?utf-8?B?SklEdmVxcEErN0NmN1VlK2FrVUl5dmhybHJyOGhndTRTUHNYN1NoWUZWWUpU?=
 =?utf-8?B?T0lWdmVKSC9aa1hqbUd4SlBmMSsvbWNRdVptQ0R0VUprdVNNVkFMZUJuNTRZ?=
 =?utf-8?B?SjlmRXEzdWZjQnFFSlBKTUFoeWZWVFdESFQzYnNDOTlZcGhFRUVXN3hWRDVS?=
 =?utf-8?B?N1NaVEZNYkV1dzlkR0ttbkh6bXloNnIzTmVmejZsQkF4aXVZeEs2cXA3K2hV?=
 =?utf-8?B?OE9Vc3J2WjlrRlpISisvNVl2QmJDYVI1YnJEOWFYeW1BYVVtNWVFMGdaWVh1?=
 =?utf-8?B?MGozT0V2QXZVejkzTE5PNjNxSnNEVkJRWGxmNk9OTWNKMEVFeHFqY3BoR0RU?=
 =?utf-8?B?U0Y1TFhENnkrWjdmRU1vMW9Yc0xFUXR0enhoRjNQVGhXMkhuZW1hVWlFNVlZ?=
 =?utf-8?B?ZXRSZk9vbW9mM3M5V2x3emYrWVJZYlltclZDZm5tWDhRb3A4Z0EvL0hqZHNX?=
 =?utf-8?B?QW1zekQwRTgzU0VIMHVXdUovSVhnSGpEVkQ3V0VZdGNhWFpEQU1uLy9OanA1?=
 =?utf-8?B?ZWc1bnpNNzFMaStNMkFaMFFPdk50Wk5aYTRhU3k5bkEyMGJvRGVrUGpKMTU2?=
 =?utf-8?B?Q0sraVJXb3VmOE00YUczTXd0c3BEUVlzc2l4aU1CcGxnUWhOckhLKzhtZlRW?=
 =?utf-8?B?U3o0M1NkMlp6WXJMbldEaHJjTTl1eGxmS0ZhenBNZExIbEczaWhIL1VsUjhU?=
 =?utf-8?B?OGY2UDlGclZobjdRM09lMEw3RE80U3FRUnpsY2ZidStxSFJnQXM4dWtFOTBo?=
 =?utf-8?B?ZGpyTFpyNXBka2xvN1V5dXZMbFhHbGdhV1oxVndOeEhWTVBERGJEelY1U1Zz?=
 =?utf-8?B?cjAyZG1zNFYyVkNLMU9xbVpOZFZjb0dxeFNFSEpVeTl0UHRzNndGOWVFZjAz?=
 =?utf-8?B?aFJsYlQ3eDdVTS90aTVNMnhYSFNNL0pla3c2dzVlUXNEc3pRTDhqVzlxdWk0?=
 =?utf-8?B?eUVJcmJkUmpDc1VOTnB5S3lIVVFQOEQvVVo5M2pRcEtxbFc2L2FZS05Icmk4?=
 =?utf-8?B?U3ZDdmErTGl0YldNRnJ5WmZudit3VnptWDBvUlk4czBWL1hncmhKQ1I0aDFN?=
 =?utf-8?B?SE1OL3E0QzhiZWlIakNoTXhqWWtIeG5ZL05LcWY1c1N1RDFrcTQxemtwSmRH?=
 =?utf-8?B?cTYzMVdTUDB1OURtRVlsTm52ZGNZVHMwaUNqK1RmdEZ1UzBUZWhpSVBqczVU?=
 =?utf-8?B?WlJhZkZ0c04wU2hoRkJYcEZtcU1pYng4d09LMExkVExzTWNUcU5YMGhmc2tl?=
 =?utf-8?B?bVZwK3l1TWt0UTQwSVhkRVZ1M09OOGVKR3FvR1dBYzEwdk44TTgwRTE0LzB4?=
 =?utf-8?B?aXErOHA4ZzBTWnFST0U1dm96ZVh0cjhQdlg0MG1WNWhjZlloT2lvV205dXZL?=
 =?utf-8?B?TFJZQ3MxazhjaDM0Y1hOWHk3UmJadVI1ZGxWcisrWVBrTytjK3lySkdsUTg2?=
 =?utf-8?B?Vks4YjF1cVI2OVhVSG5MZXZKc3ByVCtIVklDSjZZTWtUNHRXaFdPU3M5dXZ3?=
 =?utf-8?B?SUxMUCtFMzBjL0FQU3FrKzVwa0JvWEZFMVNKbk40cmRGLzlmM3hKaVJaZ21F?=
 =?utf-8?B?YWFJbklXbmxYUnRGLytpS3pWSjg3Y3dxOFZNTzdPZmVKb29Yczl5a3kyeFBh?=
 =?utf-8?B?N0JsUDNHM29zdUpDc21ZeVBwbVl3cmswTFRheW9hZ0d1Lzk3VVBrU2xCZmtm?=
 =?utf-8?B?RGFtd0tTUHlKRWVncVJBRFE1QTRrWFVtV0dSYVBRUzVZTWxhNzU1YnpkTk5X?=
 =?utf-8?B?NWk0VmtENTB4VkFicGZUTXlrc2EwNnIveklNNnNOTDRNWC9JcFkwNWt1aWtX?=
 =?utf-8?B?QVE9PQ==?=
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
	HODbw+PKGd54V1yvwITZ18Iq06D+zXH4QrFNsFRTMoZ8Py3N4W3IK5rohqUK5R/j4FSn4hB6K5WOUH4yy0klYGefpUyxgFGgZ2wm2EMCaYVSyQEBFWNYVV3sFuEEMs88f06eF3fMlHp4h4vTlGs8udouaexhPtpemxWo136FqCMmHhz2y50aje9eNJ+XIZ7nppHpVpb2W0cZjXGCsQrxAPNjTotb0d/7IpMjKAE1blUggw5l1GK68CgQLO1+e4U2qUq6EhwkMtKIc3rPKRmxQ5DY7RNxhbmZ/dxMjr9wjvU70Fv99g0H+aTGOHLhC/vtsmgg5ZVqgItk3fV3lkOwK4+SnVErRIhdv8kTxtLcTuVIjnWRddtZ82gzJBtMeaq3ilfvg2IkpffSoxG6/CNhaBdu6aLGFSw4Az8mYzs/Q4LW1mhXJmMi4naSzjqaskuisXYtjLq5Z0aNfjQxLQz6idbxnNukag0Aln2aS5qKHGAnhAqv4hzxSZzCVwhIkI5/++KT75Xnm5pzoP8eBT3i8ltmG85saNKjtg6beqrA0RXXaKkMsX6RCR3dy6xQxXArYvCl60XfJUJUeTJLntkGp8Ny7eZzSOSoRsilRZt4qAtwf6DJAUDtqAosQdQzvVj6
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678e12fb-4e83-40df-f342-08dde3b092d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:22:47.3026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zSU1eiNurbuanUbsN+Xr9iR9LGloLGk8BNUauaqlpN8UNle0j5gdr/0J7nniD1n6kTtybqaqnp5kSxDCSq09QiQR0R6Mu5ZDAnuDFIGHoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8551

SGksIEhhbmp1bg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4NCg0KPiBIaSBLYXp1aGly
bywNCj4gDQo+IE9uIDIwMjUvOC8xOCAxNDo1NCwgS2F6dWhpcm8gQWJlIHdyb3RlOg0KPiA+IEFH
REkgaGFzIHR3byB0eXBlcyBvZiBzaWduYWxpbmcgbW9kZXM6IFNERUkgYW5kIGludGVycnVwdC4N
Cj4gPiBDdXJyZW50bHksIHRoZSBBR0RJIGRyaXZlciBvbmx5IHN1cHBvcnRzIFNERUkuDQo+ID4g
VGhlcmVmb3JlLCBhZGQgc3VwcG9ydCBmb3IgaW50ZXJydXB0IHNpbmdhbGluZyBtb2RlIFRoZSBp
bnRlcnJ1cHQNCj4gPiB2ZWN0b3IgaXMgcmV0cmlldmVkIGZyb20gdGhlIEFHREkgdGFibGUsIGFu
ZCBjYWxsIHBhbmljIGZ1bmN0aW9uIHdoZW4NCj4gPiBhbiBpbnRlcnJ1cHQgb2NjdXJzLg0KPiAN
Cj4gDQo+ID4gU0RFSSAmIEludGVycnVwdCBtb2RlIGlzIG5vdCBzdXBwb3J0ZWQuDQo+IA0KPiBJ
IHRoaW5rIHRoaXMgY2FuIGJlIHJlbW92ZWQsIGl0J3Mgbm90IGFsbG93ZWQgbmF0dXJlbHkuDQoN
CkkgbWVudGlvbmVkIHRoaXMgYmVjYXVzZSBpdCB3YXMgYWRkZWQgaW4gIkFDUEkgZm9yIEFybSBD
b21wb25lbnRzIDEuMiBQbGF0Zm9ybSBEZXNpZ24gRG9jdW1lbnQiDQpJIHRoaW5rIEknbGwgcmVt
b3ZlIGl0IGZyb20gdGhlIGNvdmVyIGxldHRlci4NCg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEthenVoaXJvIEFiZSA8ZmoxMDc4aWlAYWEuanAuZnVqaXRzdS5jb20+DQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL2FjcGkvYXJtNjQvYWdkaS5jIHwgMTE0DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tDQo+ID4gICBpbmNsdWRlL2FjcGkvYWN0YmwyLmggICAgIHwg
ICA0ICstDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDExMCBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hcm02NC9hZ2RpLmMg
Yi9kcml2ZXJzL2FjcGkvYXJtNjQvYWdkaS5jDQo+ID4gaW5kZXggZTBkZjNkYWE0YWJmMC4uYzUx
NGJiODc0YzVkMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvYXJtNjQvYWdkaS5jDQo+
ID4gKysrIGIvZHJpdmVycy9hY3BpL2FybTY0L2FnZGkuYw0KPiA+IEBAIC0xNiw3ICsxNiwxMSBA
QA0KPiA+ICAgI2luY2x1ZGUgImluaXQuaCINCj4gPg0KPiA+ICAgc3RydWN0IGFnZGlfZGF0YSB7
DQo+ID4gKwl1bnNpZ25lZCBjaGFyIGZsYWdzOw0KPiA+ICAgCWludCBzZGVpX2V2ZW50Ow0KPiA+
ICsJdW5zaWduZWQgaW50IGdzaXY7DQo+ID4gKwlib29sIHVzZV9ubWk7DQo+IA0KPiB3aWxsIHdl
IHVzZSBub3JtYWwgaW50ZXJydXB0IGFzIHRoZSBzaWduYWxpbmc/DQo+IA0KPiBJbiB0aGUgc3Bl
YywgaXQgc2F5czoNCj4gDQo+IFNvbWUgdXNlLWNhc2VzLCBzdWNoIGFzIHN5c3RlbSBtYW5hZ2Vt
ZW50LCByZXF1aXJlIHRoZSBhYmlsaXR5IHRvIGdlbmVyYXRlIGENCj4gbm9uLW1hc2thYmxlIGV2
ZW50IHRvIHRoZSBPUyB0byByZXF1ZXN0IHRoZSBPUyBrZXJuZWwgdG8gcGVyZm9ybSBhIGRpYWdu
b3N0aWMNCj4gZHVtcCBhbmQgcmVzZXQgdGhlIHN5c3RlbS4NCg0KSSBhbHNvIGluY2x1ZGVkIHJl
cXVlc3RfaXJxIGFzIGEgZmFsbGJhY2ssIGFzIE5NSSBtaWdodCBub3QgYmUgZW5hYmxlZC4NCkhv
d2V2ZXIsIGlmIHRoaXMgaXMgbm90IGFsbG93ZWQgYnkgdGhlIHNwZWNpZmljYXRpb25zLCBJJ2Qg
bGlrZSB0byByZW1vdmUgaXQuDQoNCj4gDQo+IFNlZW1zIG9ubHkgbm9uLW1hc2thYmxlIGV2ZW50
IGlzIGFsbG93ZWQsIFN1ZGVlcCwgYW55IGlkZWEgYWJvdXQgdGhpcz8NCj4gDQo+ID4gKwlpbnQg
aXJxOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RhdGljIGludCBhZ2RpX3NkZWlfaGFuZGxlcih1
MzIgc2RlaV9ldmVudCwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQo+ID4gdm9pZCAqYXJnKSBAQCAt
NDgsNiArNTIsNTUgQEAgc3RhdGljIGludCBhZ2RpX3NkZWlfcHJvYmUoc3RydWN0DQo+IHBsYXRm
b3JtX2RldmljZSAqcGRldiwNCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICtz
dGF0aWMgaXJxcmV0dXJuX3QgYWdkaV9pbnRlcnJ1cHRfaGFuZGxlcl9ubWkoaW50IGlycSwgdm9p
ZCAqZGV2X2lkKQ0KPiA+ICt7DQo+ID4gKwlubWlfcGFuaWMoTlVMTCwgIkFybSBHZW5lcmljIERp
YWdub3N0aWMgRHVtcCBhbmQgUmVzZXQgTk1JDQo+IEludGVycnVwdCBldmVudCBpc3N1ZWRcbiIp
Ow0KPiA+ICsJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aXJxcmV0dXJuX3QgYWdkaV9pbnRlcnJ1cHRfaGFuZGxlcl9pcnEoaW50IGlycSwgdm9pZCAqZGV2
X2lkKQ0KPiA+ICt7DQo+ID4gKwlwYW5pYygiQXJtIEdlbmVyaWMgRGlhZ25vc3RpYyBEdW1wIGFu
ZCBSZXNldCBJbnRlcnJ1cHQgZXZlbnQNCj4gaXNzdWVkXG4iKTsNCj4gPiArCXJldHVybiBJUlFf
SEFORExFRDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhZ2RpX2ludGVycnVwdF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICsJCQkJc3RydWN0IGFnZGlf
ZGF0YSAqYWRhdGEpDQo+ID4gK3sNCj4gPiArCXVuc2lnbmVkIGxvbmcgaXJxX2ZsYWdzOw0KPiA+
ICsJaW50IHJldDsNCj4gPiArCWludCBpcnE7DQo+ID4gKw0KPiA+ICsJaXJxID0gYWNwaV9yZWdp
c3Rlcl9nc2koTlVMTCwgYWRhdGEtPmdzaXYsIEFDUElfRURHRV9TRU5TSVRJVkUsDQo+IEFDUElf
QUNUSVZFX0hJR0gpOw0KPiA+ICsJaWYgKGlycSA8IDApIHsNCj4gPiArCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJjYW5ub3QgcmVnaXN0ZXIgR1NJIyVkICglZClcbiIsDQo+IGFkYXRhLT5nc2l2LCBp
cnEpOw0KPiA+ICsJCXJldHVybiBpcnE7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaXJxX2ZsYWdz
ID0gSVJRRl9QRVJDUFUgfCBJUlFGX05PQkFMQU5DSU5HIHwNCj4gSVJRRl9OT19BVVRPRU4gfA0K
PiA+ICsJCSAgICBJUlFGX05PX1RIUkVBRDsNCj4gPiArCS8qIHRyeSBOTUkgZmlyc3QgKi8NCj4g
PiArCXJldCA9IHJlcXVlc3Rfbm1pKGlycSwgJmFnZGlfaW50ZXJydXB0X2hhbmRsZXJfbm1pLCBp
cnFfZmxhZ3MsDQo+ID4gKwkJCSAgImFnZGlfaW50ZXJydXB0X25taSIsIE5VTEwpOw0KPiA+ICsJ
aWYgKHJldCkgew0KPiA+ICsJCXJldCA9IHJlcXVlc3RfaXJxKGlycSwgJmFnZGlfaW50ZXJydXB0
X2hhbmRsZXJfaXJxLA0KPiA+ICsJCQkJICBpcnFfZmxhZ3MsICJhZ2RpX2ludGVycnVwdF9pcnEi
LCBOVUxMKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJCWRldl9lcnIoJnBkZXYtPmRldiwg
ImNhbm5vdCByZWdpc3RlciBJUlEgJWRcbiIsDQo+IHJldCk7DQo+ID4gKwkJCWFjcGlfdW5yZWdp
c3Rlcl9nc2koYWRhdGEtPmdzaXYpOw0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCX0NCj4g
PiArCQllbmFibGVfaXJxKGlycSk7DQo+ID4gKwkJYWRhdGEtPmlycSA9IGlycTsNCj4gPiArCX0g
ZWxzZSB7DQo+ID4gKwkJZW5hYmxlX25taShpcnEpOw0KPiA+ICsJCWFkYXRhLT5pcnEgPSBpcnE7
DQo+ID4gKwkJYWRhdGEtPnVzZV9ubWkgPSB0cnVlOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJl
dHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGludCBhZ2RpX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGFnZGlfZGF0
YSAqYWRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKCZwZGV2LT5kZXYpOyBAQCAtNTUsMTINCj4gPiAr
MTA4LDIwIEBAIHN0YXRpYyBpbnQgYWdkaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICAgCWlmICghYWRhdGEpDQo+ID4gICAJCXJldHVybiAtRUlOVkFMOw0KPiA+DQo+
ID4gLQlyZXR1cm4gYWdkaV9zZGVpX3Byb2JlKHBkZXYsIGFkYXRhKTsNCj4gPiArCXN3aXRjaCAo
YWRhdGEtPmZsYWdzICYgQUNQSV9BR0RJX1NJR05BTElOR19NT0RFX01BU0spIHsNCj4gPiArCWNh
c2UgQUNQSV9BR0RJX1NJR05BTElOR19NT0RFX1NERUk6DQo+ID4gKwkJcmV0dXJuIGFnZGlfc2Rl
aV9wcm9iZShwZGV2LCBhZGF0YSk7DQo+ID4gKw0KPiA+ICsJY2FzZSBBQ1BJX0FHRElfU0lHTkFM
SU5HX01PREVfSU5URVJSVVBUOg0KPiA+ICsJCXJldHVybiBhZ2RpX2ludGVycnVwdF9wcm9iZShw
ZGV2LCBhZGF0YSk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gICB9DQo+
ID4NCj4gPiAtc3RhdGljIHZvaWQgYWdkaV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiArc3RhdGljIHZvaWQgYWdkaV9zZGVpX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2LA0KPiA+ICsJCQkgICAgIHN0cnVjdCBhZ2RpX2RhdGEgKmFkYXRhKQ0KPiA+
ICAgew0KPiA+IC0Jc3RydWN0IGFnZGlfZGF0YSAqYWRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKCZw
ZGV2LT5kZXYpOw0KPiA+ICAgCWludCBlcnIsIGk7DQo+ID4NCj4gPiAgIAllcnIgPSBzZGVpX2V2
ZW50X2Rpc2FibGUoYWRhdGEtPnNkZWlfZXZlbnQpOw0KPiA+IEBAIC04Myw2ICsxNDQsMzQgQEAg
c3RhdGljIHZvaWQgYWdkaV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikN
Cj4gPiAgIAkJCWFkYXRhLT5zZGVpX2V2ZW50LCBFUlJfUFRSKGVycikpOw0KPiA+ICAgfQ0KPiA+
DQo+ID4gK3N0YXRpYyB2b2lkIGFnZGlfaW50ZXJydXB0X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2LA0KPiA+ICsJCQkJICBzdHJ1Y3QgYWdkaV9kYXRhICphZGF0YSkNCj4gPiAr
ew0KPiA+ICsJaWYgKGFkYXRhLT5pcnEgIT0gLTEpIHsNCj4gPiArCQlpZiAoYWRhdGEtPnVzZV9u
bWkpDQo+ID4gKwkJCWZyZWVfbm1pKGFkYXRhLT5pcnEsIE5VTEwpOw0KPiA+ICsJCWVsc2UNCj4g
PiArCQkJZnJlZV9pcnEoYWRhdGEtPmlycSwgTlVMTCk7DQo+ID4gKw0KPiA+ICsJCWFjcGlfdW5y
ZWdpc3Rlcl9nc2koYWRhdGEtPmdzaXYpOw0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICtz
dGF0aWMgdm9pZCBhZ2RpX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+
ID4gKwlzdHJ1Y3QgYWdkaV9kYXRhICphZGF0YSA9IGRldl9nZXRfcGxhdGRhdGEoJnBkZXYtPmRl
dik7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChhZGF0YS0+ZmxhZ3MgJiBBQ1BJX0FHRElfU0lHTkFM
SU5HX01PREVfTUFTSykgew0KPiA+ICsJY2FzZSBBQ1BJX0FHRElfU0lHTkFMSU5HX01PREVfU0RF
SToNCj4gPiArCQlhZ2RpX3NkZWlfcmVtb3ZlKHBkZXYsIGFkYXRhKTsNCj4gPiArCQlicmVhazsN
Cj4gPiArDQo+ID4gKwljYXNlIEFDUElfQUdESV9TSUdOQUxJTkdfTU9ERV9JTlRFUlJVUFQ6DQo+
ID4gKwkJYWdkaV9pbnRlcnJ1cHRfcmVtb3ZlKHBkZXYsIGFkYXRhKTsNCj4gPiArCQlicmVhazsN
Cj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIGFnZGlfZHJpdmVyID0gew0KPiA+ICAgCS5kcml2ZXIgPSB7DQo+ID4gICAJCS5uYW1lID0g
ImFnZGkiLA0KPiA+IEBAIC05NCw3ICsxODMsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2Ry
aXZlciBhZ2RpX2RyaXZlciA9IHsNCj4gPiAgIHZvaWQgX19pbml0IGFjcGlfYWdkaV9pbml0KHZv
aWQpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGFjcGlfdGFibGVfYWdkaSAqYWdkaV90YWJsZTsN
Cj4gPiAtCXN0cnVjdCBhZ2RpX2RhdGEgcGRhdGE7DQo+ID4gKwlzdHJ1Y3QgYWdkaV9kYXRhIHBk
YXRhID0gezB9Ow0KPiA+ICAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7DQo+ID4gICAJ
YWNwaV9zdGF0dXMgc3RhdHVzOw0KPiA+DQo+ID4gQEAgLTEwMywxMiArMTkyLDIzIEBAIHZvaWQg
X19pbml0IGFjcGlfYWdkaV9pbml0KHZvaWQpDQo+ID4gICAJaWYgKEFDUElfRkFJTFVSRShzdGF0
dXMpKQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4NCj4gPiAtCWlmIChhZ2RpX3RhYmxlLT5mbGFncyAm
IEFDUElfQUdESV9TSUdOQUxJTkdfTU9ERSkgew0KPiA+IC0JCXByX3dhcm4oIkludGVycnVwdCBz
aWduYWxpbmcgaXMgbm90IHN1cHBvcnRlZCIpOw0KPiA+ICsJc3dpdGNoIChhZ2RpX3RhYmxlLT5m
bGFncyAmIEFDUElfQUdESV9TSUdOQUxJTkdfTU9ERV9NQVNLKQ0KPiB7DQo+ID4gKwljYXNlIEFD
UElfQUdESV9TSUdOQUxJTkdfTU9ERV9TREVJOg0KPiA+ICsJCXBkYXRhLnNkZWlfZXZlbnQgPSBh
Z2RpX3RhYmxlLT5zZGVpX2V2ZW50Ow0KPiA+ICsJCWJyZWFrOw0KPiA+ICsNCj4gPiArCWNhc2Ug
QUNQSV9BR0RJX1NJR05BTElOR19NT0RFX0lOVEVSUlVQVDoNCj4gPiArCQlwZGF0YS5nc2l2ID0g
YWdkaV90YWJsZS0+Z3NpdjsNCj4gPiArCQlicmVhazsNCj4gPiArDQo+ID4gKwlkZWZhdWx0Og0K
PiA+ICsJCXByX3dhcm4oIlNpZ25hbGluZyBtb2RlKCVkKSBpcyBub3Qgc3VwcG9ydGVkIiwNCj4g
PiArCQkJYWdkaV90YWJsZS0+ZmxhZ3MgJg0KPiBBQ1BJX0FHRElfU0lHTkFMSU5HX01PREVfTUFT
Syk7DQo+ID4gICAJCWdvdG8gZXJyX3B1dF90YWJsZTsNCj4gPiAgIAl9DQo+ID4NCj4gPiAtCXBk
YXRhLnNkZWlfZXZlbnQgPSBhZ2RpX3RhYmxlLT5zZGVpX2V2ZW50Ow0KPiA+ICsJcGRhdGEuaXJx
ID0gLTE7DQo+ID4gKwlwZGF0YS5mbGFncyA9IGFnZGlfdGFibGUtPmZsYWdzOw0KPiANCj4gTXkg
bWFqb3IgY29uY2VybiBpcyBhYm91dCB0aGUgbm9ybWFsIGludGVycnJ1cHQgYXMgdGhlIGV2ZW50
LCBub3Qgc3VyZSBpZiBpdCBpcyBvaywNCj4gbGV0J3MgZmlndXJlIGl0IG91dCBmaXJzdC4NCg0K
QXMgbWVudGlvbmVkIGFib3ZlLCBJJ2QgbGlrZSB0byByZW1vdmUgbm9ybWFsIGludGVycnVwdCBo
YW5kbGluZyBpZiB0aGlzIGlzIG5vdCBhbGxvd2VkIGJ5IHRoZSBzcGVjaWZpY2F0aW9ucy4NCg0K
PiANCj4gPg0KPiA+ICAgCXBkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfZGF0YShOVUxM
LCAiYWdkaSIsIDAsICZwZGF0YSwNCj4gc2l6ZW9mKHBkYXRhKSk7DQo+ID4gICAJaWYgKElTX0VS
UihwZGV2KSkNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hY3BpL2FjdGJsMi5oIGIvaW5jbHVk
ZS9hY3BpL2FjdGJsMi5oIGluZGV4DQo+ID4gMDQ4ZjVmNDdmOGI4OC4uOWRkYmRkNzcyZjEzOSAx
MDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2FjcGkvYWN0YmwyLmgNCj4gPiArKysgYi9pbmNsdWRl
L2FjcGkvYWN0YmwyLmgNCj4gPiBAQCAtMzM5LDcgKzMzOSw5IEBAIHN0cnVjdCBhY3BpX3RhYmxl
X2FnZGkgew0KPiA+DQo+ID4gICAvKiBNYXNrIGZvciBGbGFncyBmaWVsZCBhYm92ZSAqLw0KPiA+
DQo+ID4gLSNkZWZpbmUgQUNQSV9BR0RJX1NJR05BTElOR19NT0RFICgxKQ0KPiA+ICsjZGVmaW5l
IEFDUElfQUdESV9TSUdOQUxJTkdfTU9ERV9NQVNLICgzKSAjZGVmaW5lDQo+ID4gK0FDUElfQUdE
SV9TSUdOQUxJTkdfTU9ERV9TREVJICgwKSAjZGVmaW5lDQo+ID4gK0FDUElfQUdESV9TSUdOQUxJ
TkdfTU9ERV9JTlRFUlJVUFQgKDEpDQo+IA0KPiBZb3UgbmVlZCB0byBzZW5kIGEgcGF0Y2ggdG8g
QUNQSUNBIGZpcnN0IHRvIGFkZCBpbnRlcnJ1cHQgc3VwcG9ydCwgdGhpcyBmaWxlDQo+IGJlbG9u
Z3MgYWNwaWNhLg0KDQpVbmRlcnN0b29kLiBJIHdpbGwgc2VuZCBhIHBhdGNoIHRvIEFDUElDQSBm
aXJzdC4gT25jZSBpdCBpcyBtZXJnZWQsIEkgd2lsbCBzZW5kIHYyLg0KDQpCZXN0IFJlZ2FyZHMs
DQpLYXp1aGlybyBBYmUNCg0KPiANCj4gVGhhbmtzDQo+IEhhbmp1bg0K

