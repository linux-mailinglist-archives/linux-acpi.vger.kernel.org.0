Return-Path: <linux-acpi+bounces-16304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032FB41277
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 04:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA1D1B61A78
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 02:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2219E7F8;
	Wed,  3 Sep 2025 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BeW6FBx/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6039288D6;
	Wed,  3 Sep 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756867446; cv=fail; b=uPph3xWz6dpSyj16oi3ajqE5mZxsWMD6X1x7LDt90qY5xqQEnpeuMkLc/OcxcOhtjyF9XuVG3M6Y3twNXhcgLHRIIRLEEJGoElgiU1DQipHCpIcTulGxLaf/8CEYdm4qY6RuzC+SGNL7o50bwItWpgqmtVk4nj/bl5YEKFM5J9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756867446; c=relaxed/simple;
	bh=Q9XYHFbPKIFgRLQRZ6M1iUmQ+3LuMLdSogVkQfNBn0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LfMeRrAKpc0LGieby3ZxSNlpuxUGnLCxneEJJ98aMb3PoI057dQ6Pm3lJ8OB72IaIJmbIMwH6kIXV/DOGk5wmmB2FxvVo3MBhpOqk57899/9g/a3DQFSaT16I6HRT3sG9H2YwWjrvmx7pMbWsyMFX3Mt/p9UpNOSzf92jIaGvqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BeW6FBx/; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756867444; x=1788403444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q9XYHFbPKIFgRLQRZ6M1iUmQ+3LuMLdSogVkQfNBn0I=;
  b=BeW6FBx/619nic5DSwDnu0DQuzFEIIeqnjaItIX2oGJpR9wdW1QoOKfA
   lhwLYSLofu67/i9q/acaz0HWDWQXHyvaHml3Px5et5RQD8Sdq06Ch1Vqx
   /6j+qrd8zB8Nq1sQYlMDvWG+OlE6BQWywUkLrdSNpRooBJiNwJiLlUjjP
   gL7ZyDsIPcVdcycQof8xjNX85GC9U0LqJhBg9UvcUTP8MugBAppkd++BH
   fFa7N0RV8JfdFfAuZj1jgCDDv3FSMEOh2TaQLVTcMgYoU7EompbNz++3t
   FGqAFy1gcFSo/vDg45HmBcH2XKlqL7UOEVT0g9T4PaP1zC4XAZGOwrKeV
   Q==;
X-CSE-ConnectionGUID: wrFj897vRjm+C13r3kQdKg==
X-CSE-MsgGUID: vXSdVjcDT9yKUXxz7fOBdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="77494181"
X-IronPort-AV: E=Sophos;i="6.18,233,1751209200"; 
   d="scan'208";a="77494181"
Received: from mail-japanwestazon11011020.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.20])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 11:42:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAfzUdgt5n9M6KpZ5peOCqgAKg/36e+y6489GMlJ5sVtfyf9A37iIcnZgjxy834H41UiDjEHD180oMsb578e0m1/6vtQkJitxcIPHByg9liw9pXr1XP9k8JYbT9cwtT64XYg32u28nzXBUBdPRRwI1KHgqL4Da2tc4/3bXTxRDHZqf7VH5jZyxQ2T/9dNq3FG/xRTAFptQbh4JmphgZVly5zsFcUsVoDcRTRpmpi6JY8NYKUJG12u89smwyzIYlxYekhdGvZXFhnkUkHkvCBOqiWm9lfEfcmMdczUp6nuLuxM/JbV7MQY5w6pUDJALvWgDYC7xokwRfopPVY2uwTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G8/NekkUm3hkTNC6RFVfA7uod/CxxSljJbE2QT0eds=;
 b=pk5bUGS3RcWwMCSy98lfjQn2TLuFO//a/W872a3ymBPCwIhNEe8VHJ8l/TNHk7meImgIfXge/U1hHB4QoJ5MH98b7mS3U2fuoTCeTDHyd1H4TcW55KlyN0rYqXZIyap79gQn4k+sn/BFqjp7FYBmfNPATbALP+pW3u6FrZlI6ZC+gezBfPauUTocRIIQzGIl/vEUipG1V5sZDPZCdiNF4x+o8a9hpBM4xSS2mJ9zqw/i9u4P9icxdzBCmEOiZ6IDQIzH1GBkwI+Q99GlNN+TYIEOjOn0lvkwXBdcBcafAnDVzUeipjVsEvGq5i9E3xtJeJC0yR6Lv+UiUQqnPJZnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 by TYYPR01MB14261.jpnprd01.prod.outlook.com (2603:1096:405:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:42:47 +0000
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1]) by TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:42:47 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Ilkka Koskinen' <ilkka@os.amperecomputing.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v2] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcGM13mooX4tGAD0uUb6BBHdYKLrSAUQ6AgABuikA=
Date: Wed, 3 Sep 2025 02:42:46 +0000
Message-ID:
 <TY3PR01MB99834EEA2514239975DBA3BDD501A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
References: <20250829101154.2377800-1-fj1078ii@aa.jp.fujitsu.com>
 <f61868d2-3344-b6a9-d587-98cc654885f4@os.amperecomputing.com>
In-Reply-To: <f61868d2-3344-b6a9-d587-98cc654885f4@os.amperecomputing.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=76bbd244-dd68-4e86-9a47-48cfeed6e2b9;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-09-03T02:35:13Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_|TYYPR01MB14261:EE_
x-ms-office365-filtering-correlation-id: 59a16018-02e8-46a7-7b1a-08ddea9390f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?eVpXN3JGc1F0N2g1UWMzbDRtZVgyKzJPejZTRlVWUGJpSnA0V3U1TXRM?=
 =?iso-2022-jp?B?V2NyU2ttTVRjVmM4QUtFNTBJcGhzZU02VnBGQWEzY2ZPVDhuWk15Mk9u?=
 =?iso-2022-jp?B?WndpSDl3UW9TUHFrRWdnNDRHZEhxYy9UNi9EUUMzYzhvcDhMczRPQnVR?=
 =?iso-2022-jp?B?R05ITTc3T21HdlVIVlJ2N0doSjZ3d0VmbnF6aGpCTGFOL1FmMVY3NkZ2?=
 =?iso-2022-jp?B?OXFpU0xMc0k4cmVlSGlMRGZzaE9VSEtoRjNjR29wNU1LZWdmK2dMT0Fz?=
 =?iso-2022-jp?B?d1FHQjM0RzBEbjZmMnRCVlJ4WmwzRWpjOVY3VVlwNmV0ZGpsNm5XOTEz?=
 =?iso-2022-jp?B?Ui80RWQzblk3UlJtdk92SDRSRG1pUEgrVFByemZ0OGpDZWFFemtzU05k?=
 =?iso-2022-jp?B?WUJxSENPSmkwMmx1NVJVRFNkcW5zZ0FFYjFQTEgzeWNpWWJMSjdvT2ZT?=
 =?iso-2022-jp?B?L21rZTZzM1d1cVNWRlhPMTRZMVptTmU0YUxBUUtpdEhEajYzbWRXMjFp?=
 =?iso-2022-jp?B?SXNZVklYZWZ1Vk1DQzdQK3NnS1g4eDFlcklIUk1yVFR2Z0p4RngwWFNG?=
 =?iso-2022-jp?B?OUxCY3V0RWFRT20yc1Q2ajQrOFIxbWRVUm9vbEhGYm9VL3FvU2lLdXZO?=
 =?iso-2022-jp?B?NkJwYXVoNkVXZE5wSEVmVXFxVllWMWNZcSt4ZDBQWlVaQnY2VlpIcU1F?=
 =?iso-2022-jp?B?bm4rUFN6SG1yNXRyR1EybDBoN01Ua3lZY1p5NzhrdWVGZkNaaDVCZndY?=
 =?iso-2022-jp?B?dWRBNXVxbjlVZEVON2xpb0RKNklUaWs0b2k2Z1hIRHhyM1lnaUthd1hx?=
 =?iso-2022-jp?B?WDdUT0psOVFUbmNJMHlDeUFNQ2hRWGo2NnR3MmZzakhjL0R0WjRRTVRS?=
 =?iso-2022-jp?B?dElLdVFNUXdpQjAyRGxOY1NsMDV4ZnE4ZXJpNGlKUTFraHorM3NPVXFl?=
 =?iso-2022-jp?B?b3Nxa0F0WUxkK0tiUUFRdVpIb2YxUFhNYjR1d3djQU90QmhMUCtUQmlx?=
 =?iso-2022-jp?B?c2ZuRWNnUkhnWnc1amFjSHkvakFyNWl4VEE3RXN4V2xBcUx3a2tPdkVT?=
 =?iso-2022-jp?B?MlJRQk14aFd0amdVdlNsVEZsUlU3QzZ3WEtENGdUU3lGVStpR0lJMkR1?=
 =?iso-2022-jp?B?WklucjNWaTViVkwxUjJZMmJPWUxHdWM5UE5Fa3lOc0xaekVGYXc3WHUr?=
 =?iso-2022-jp?B?Sm80eEdPbjMzRmVCcEQybVV5OUpRb2Q5bS9VYVE2dmhXRTZSVDNhdVpq?=
 =?iso-2022-jp?B?RklCank2bWVYaktmM2NucFFOK2RUbklIcmt3NmJnOE9oVlNJRlZOUFZT?=
 =?iso-2022-jp?B?cG0ybzZJSTVLWS8zbG5nYUxBOG9rc1VOZnI2d0gvWW8zc2ZXQXZYM2Qz?=
 =?iso-2022-jp?B?RTdhMnFSZ3R3V2J1WVJyZnFiYXhldm4rdDMrL2cvNGQxMmVUNVRjSGxW?=
 =?iso-2022-jp?B?OGYwRUtZNi9lMWlHSEJ2dDNmWHJlbVRCTk5mb1V4VEdiUXZWMXFsWWti?=
 =?iso-2022-jp?B?QytNa01CZ1BvaXRYaytnUVVHVzRCeEMvSWtSVUZXbDBiNmU5WVpZVXEy?=
 =?iso-2022-jp?B?NTFXaXpKdFhGY2x2Znd1eTNUM0dzK0VlRzFld0FwSHhPT0FzYkJxTUlG?=
 =?iso-2022-jp?B?d2lsMkV5b1o5Q2FzeWZBNldXZ3B3dUp6NjMyMCswK3BIbzEzN3V2NzJM?=
 =?iso-2022-jp?B?dWpocjFxT1ZLemp3Qm16V0dyVU9KTDBiTmNYLzFra2hTU2x3b09zQWNS?=
 =?iso-2022-jp?B?WWhJZTZaQnIvVFVNVDZmd0hRZTd2RlJrdUpGWS83d3ZDN3FiU3dmNDRn?=
 =?iso-2022-jp?B?cjd0eTdpTW5CME1IYTQ3cXBodXhlazNjSkJpU1B6MytibmpnWDVHcW8v?=
 =?iso-2022-jp?B?OWh5QkpmbWl5bVp3MVo5ei9YN0QwUVl2ODdQWFUwN3dHLzdOWllLZzBw?=
 =?iso-2022-jp?B?a042VmFWaktoUE9iN2pldGJCQXJkNllFUW1zZStLQWhHYU14VUY3Ty9Z?=
 =?iso-2022-jp?B?aXlGS0N2ai9tb1JKZ1ZJYlFqN1UyT2d0Vll4MDBGS0tBUmlJbStyQmdU?=
 =?iso-2022-jp?B?RXZnVlovcEpJNWEyK0xqSVlZaW5iUXpGcHQ3Tmd2MWZPZU1aOUZLWnFE?=
 =?iso-2022-jp?B?Yms3ei8ySk1pYldwZVRYWmh4QXJmalBOWDduaHpoVS81VHNrVHpIVjZI?=
 =?iso-2022-jp?B?b2RaU0ZyV3ZEakxoK1FtdHpSVkIrYUsx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cFYya0xGSGRURFhpejFDcnRtSy9pOUVIa29RY0hsc2ZkQ3k1aVo1VEpT?=
 =?iso-2022-jp?B?anFmb2lVdUhLZnRudk9MTFB0MUhML0xmMUo5YWZGTkt2RVEyUGxNaWRt?=
 =?iso-2022-jp?B?R0hJM2VXTjlHZVVnVlVTbm8vNXlIaDY3OFFoQklCTGM5TXZuT2dXZTlX?=
 =?iso-2022-jp?B?RUpoMmlmQVRReVVEUVM2MzIzdE9QWDFjZW1JQnQrMEE3dmlITXd5VUFs?=
 =?iso-2022-jp?B?bG9aeXo4TldLaWxYN0JKditwTXRzTWZ4MGlHd1oxcG0rb2JmelZkZGlC?=
 =?iso-2022-jp?B?c2xPbVJkZEhWSThYZzhjREs1Zm96R0paMVZ0RVNjYURQSmxZMmlhN3Zh?=
 =?iso-2022-jp?B?c1ZzWmNYWmphUitRWEVEZDlFMEJEN3JnT0xOVy91SFNCSzRjQWlrdVdn?=
 =?iso-2022-jp?B?eXVUY3dsYm42TVlzWDRKZFRKTWRYV2orTll0MzlJdG4waDNJYWxZdDRs?=
 =?iso-2022-jp?B?Rm1tenVkMnRaQS9iTmhQTmJWWTkrYnZzZnhiL3pNTjRob0FYZ3A1Rnc4?=
 =?iso-2022-jp?B?dkZiNlVic0ViYWZZbXZUSXpSclYwQ3NRQjh1K0dxUEx2ZzhZbzI1NWFu?=
 =?iso-2022-jp?B?UnpQN3R5VXdXeEJ3bUlJNFV5dThYejRMaUs2WmdZRkpPYVpWM3d5Y1J3?=
 =?iso-2022-jp?B?b3FCbGFPZ01VcHdXQzA0dGFRMGRFVnc0elRaM3Jsd0JKenFRRVEyNlVY?=
 =?iso-2022-jp?B?d2U3MlM3eGRkMWs0T2FnRTFydHlNMWlYSlhJY2wxaExaVFBXZUVnSVVX?=
 =?iso-2022-jp?B?NkJjNUV3UnQ2M1dHa0JVdVp3T1h1b3QvZXZiaW1UU0hHaGlqeENYZHY0?=
 =?iso-2022-jp?B?cDNaOXA2cm56aEg5YlRjcjNwc3lxWGczcE5LSHhOc24vU0E0YkJhdHh3?=
 =?iso-2022-jp?B?U1B1UVZwNFp5Q1VJT1l4a290cXYxdDhySDVHa1Z5NVdZczRUWFFGSkpT?=
 =?iso-2022-jp?B?SDRZNU01RmdUYzJsSVNxYWY5c3ZsRjdtWlJUU3htODBRaEpEeWFQRm5l?=
 =?iso-2022-jp?B?SEt5bTMvTnZjOWRtQVd3TFJ6MExOL3lFd2JPTlEwd0RRRmU3aWdPOUl6?=
 =?iso-2022-jp?B?bFNsMlhxdjAwOG5GUUNDK0VaV3BvdlNmbmt6cWcwUjIwRHBYTkYrSkhQ?=
 =?iso-2022-jp?B?eHZoMEhSM21yYXRwYXhJSitDM1A3N3FCL0dCdkZrbG9Ib3V4Wk9TcE1D?=
 =?iso-2022-jp?B?R0h5WFJFOVJNSzg5YkRNMjZjSk5yUGFrYVFiL252WVNqdlovNU1lK3Bx?=
 =?iso-2022-jp?B?U3daVmxNWUIyVUdnMWY2OFp1R0dxamhIdVM4V3VtWDRWS3VvL1JpbTU4?=
 =?iso-2022-jp?B?c3RHWFI0UGdQY25BeVRoYWVsc1RsM2FnQTgveVhmczR3dmt2SkZ1cnRM?=
 =?iso-2022-jp?B?cFFRaXBNTWpyMlZjTnFjWEdoVXgxaW93dmQ3MVE5MmFDWSt6Z2ZWTXBr?=
 =?iso-2022-jp?B?L21OOWRPWE1SekNyeEhpcW5ReU5nMzEzQmx3QmhDMEhZMXFKK0JpOTc5?=
 =?iso-2022-jp?B?dk0rZC9nZlg4bnB2MjJPVEJiem5vM0FiWE1lMmkvSHhvdjhEcmh3dGZk?=
 =?iso-2022-jp?B?aHROYzhTN3dBLytRdTdheFNQSUNqUWExYXRWMG5MUnpPcVlaSmhpZ3Z6?=
 =?iso-2022-jp?B?b29pZUQxdDZYSzdXWTFCcWF0ZUdEVnhoNnU3ajBYVVF6U0xQdmxXNEc4?=
 =?iso-2022-jp?B?cm9HdVJFak5Uc3pzRm5QMDhuNk5YVStpUGFyTTNya3pFMDduZ3g4OEpl?=
 =?iso-2022-jp?B?cDEwN1NBaVZ4Y0ZPV0hVdVBubjBvWU9iVHVKdEdWNHRYejlCTTRLUkFT?=
 =?iso-2022-jp?B?alc5eVArKy9tZFQwL2c0UjJjbW9wd1NTSGZ2ejdkUEIwdFBtNFdyQSs5?=
 =?iso-2022-jp?B?enpDQmYwbmpXOUErNVVNZ1ZMclg1RFZONmpqRXA1TW50THNNVER5RnI3?=
 =?iso-2022-jp?B?YW8wcnhQaDlUeWJ4azhxRGkvUnBBM3dWUXVNU2FzZEtSdmVkdG9YQTdV?=
 =?iso-2022-jp?B?am41aFZoMDRkOE84UDFlTVdVRkk0TEJQendueUQ0aVNXeFJUSmVKUnBJ?=
 =?iso-2022-jp?B?Z01DUmNocFoyanNYeVJwaFZkdzRTNWVVOEpQUDA1Yk5jVXJESTVRbm9w?=
 =?iso-2022-jp?B?ZGVNNDVXczBOUGRGWTJWWEpNTmJWdGNHSE1xUk80ZjVoUmlvdCtCOXhY?=
 =?iso-2022-jp?B?VXMxZ3NvTStiVTFEQm5uSm55UUFKam54bjIyWmxscFBueTdQendmQjNV?=
 =?iso-2022-jp?B?Vm1sOVB0QTF5WEJPQktlaEp2UVVPQ1h4TGFsb3grVC94RkxQVTVUdlVu?=
 =?iso-2022-jp?B?Sm5WNlNpRG5LdUk0Nm9lQXorMytaS3VEZXc9PQ==?=
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
	sx9nj4uKurPYUYWjIKQw+pfv1Fy4j6elyuaL2Y3T/TXfKYD6bgkzQ3lOluxKQN0kU1a2fXKR10EwzmrtmY5iqterhBovJLZBDumiY8ldzN1BS7EM5nZ+K2Y95uKYthIg+CCpqPjrEpOTx7FuXSeKT4JG548q/N8k2e/N9wzpY5KZgb+r7/ZwFpYGqbeKcwjFn5pYOXA8BgVaCLAfuRmbNroVLaq6naHtXHymrMxRh0tZzzzn4wcADSE2TISqAB254Mw6zh5peOXiGlJ8KUeun8UP7QKkzM5QuwIWzdoR2JYcxNvOt9UkJpYOhnnV8PXCwrq6A2dpnz1bHuTlIr+geuEYPDk5OUKefB1PFAMMhjvY/AR13qoB+Y2ddlx17WeNl4X1qV4EyhzRbxMU/Anpk9jPkxGk9GspPE4QZnj+YlX7vDQTwTIJ9C5Ve8/iDNHvLwRfZE12jgAUx7BmLzzbQRio1Zi4WnO9bVeL+iXHlragfHuOGr3iZNEOI40gwoVIcKgU0EtMHnaSaDxExGeOt5gWEUA0pmzix9MFnpPyvxqQBZt8Gh/MyPdkIFIWAjAFGqdzL7liTV2XRXuKWghqBL7aSF9Sm6EZunWDzvolQL+QauP8gNCzEAOD3TvVkjtb
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a16018-02e8-46a7-7b1a-08ddea9390f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 02:42:46.8892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCBA0RSFlPcT4mjfByl/V3mEUZvV8U7wf8k/0Ya9vltgv82ouCnafk9roba7X89KgF6n/3EOFLcwQKg9FF+SCaMz7gZC6NcRt7uVyFqhr1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14261

Hi Ilkka
Thank you for your comment.

> Hi Kazuhiro,
>=20
> I have a couple of minor comments below
>=20
> On Fri, 29 Aug 2025, Kazuhiro Abe wrote:
> > AGDI has two types of signaling modes: SDEI and interrupt.
> > Currently, the AGDI driver only supports SDEI.
> > Therefore, add support for interrupt singaling mode The interrupt
> > vector is retrieved from the AGDI table, and call panic function when
> > an interrupt occurs.
> >
> > ---
> > I keep normal IRQ code when NMI cannot be used.
> > If there is any concern, please let me know.
> >
> > v1->v2
> > - Remove acpica update since there is no need to update define value
> >   for this patch.
> >
> > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > ---
> > drivers/acpi/arm64/agdi.c | 98
> ++++++++++++++++++++++++++++++++++++---
> > 1 file changed, 91 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> > index e0df3daa4abf..e887aab6b448 100644
> > --- a/drivers/acpi/arm64/agdi.c
> > +++ b/drivers/acpi/arm64/agdi.c
>=20
> ...
>=20
> > static int agdi_probe(struct platform_device *pdev) {
> > 	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev); @@ -55,12
> > +108,17 @@ static int agdi_probe(struct platform_device *pdev)
> > 	if (!adata)
> > 		return -EINVAL;
> >
> > -	return agdi_sdei_probe(pdev, adata);
> > +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
> > +		agdi_interrupt_probe(pdev, adata);
> > +	else
> > +		agdi_sdei_probe(pdev, adata);
> > +
> > +	return 0;
>=20
> Is there a reason why you always return zero instead of a possible error =
code from
> either of the probe functions?

There was no particular reason; it was a bug.
I will fix it.

>=20
> > }
> >
>=20
> ...
>=20
> > +static void agdi_remove(struct platform_device *pdev) {
> > +	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev);
> > +
> > +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE) {
> > +		agdi_interrupt_remove(pdev, adata);
> > +	} else {
> > +		agdi_sdei_remove(pdev, adata);
> > +	}
>=20
> You don't need curly braces in this if/else block.

Understood, I will do that.

Best Regards,
Kazuhiro Abe

>=20
> Cheers, Ilkka

