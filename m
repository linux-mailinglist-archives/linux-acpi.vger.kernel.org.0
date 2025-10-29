Return-Path: <linux-acpi+bounces-18306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3A7C187FB
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 07:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE491C82398
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2123081CD;
	Wed, 29 Oct 2025 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aDgJWGIf";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="avNz6rCO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DD2857EF;
	Wed, 29 Oct 2025 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719933; cv=fail; b=p3YwxleOCpLtGdsXft8qJpjD691zaBZEqHF7ybdr0yVz2uc2v+vshtOGICOitSAeM69G77GwXmz9hZDDOrD9AUJaXAZxRO+K00SnR805+Fgid0dHliyrvg48E/5i6VrSnkyELmi5o15CxnCYMf1M4GtjMEJgsNLqPPLc0YUAkBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719933; c=relaxed/simple;
	bh=28wuD96Swf/MV4rk7nhrAy0ztt3VM4aC/x32KeEkPxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QoKmkHGTqw4iZsKwVNKUTR5ZORwmicrP+8f0eRdLxcmIwSRYBRXpiY0xiX9rfEI29R9N6d9Lumqgrj8dTP6SB8HxgAwd9KzGebEQ0eTC/RouwQ2l5Ezcqh5dByLOUWjZk3VctnHPE/jIjL1NdT2spp6PvVblMZWPIYGpuri6Qo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aDgJWGIf; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=avNz6rCO; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1761719931; x=1793255931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=28wuD96Swf/MV4rk7nhrAy0ztt3VM4aC/x32KeEkPxo=;
  b=aDgJWGIfgkbMO6cxZmhO6V6hwbLpDDRCMXRfDmtrcPdGEOqO4aMuy6eZ
   yuuGxD9U+9FnN1fLiiG6P2pYmBWbI2kXSnUOTXEPxjCnU7OsvDlr4369X
   MvEP83Kwml+wVq3IUnyxSdcMu7PBNTasyvMjObeLKkO/WOgqIpMD9fBBW
   Ba2cRzNmd6bmqQUORyEIM3Z9+1H0uFtDjd/Eu0v4pfMb6D1JFJ3TRxCTf
   91vWbUqhv4AKHx0lJ0x6eUWREvE4/edLLzyfLU2Zzxo6NhYEYNJwJwP2Q
   k9xOql3ctmS5PQsJN+pJ7EV3BqtsLW38JBdjM5r96unuIKbp117IlDsgI
   A==;
X-CSE-ConnectionGUID: PoyctTlpSvC7g/9YD+WZZA==
X-CSE-MsgGUID: bJDjjKwuQEiF2BoXGmO9Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="172272625"
X-IronPort-AV: E=Sophos;i="6.19,263,1754924400"; 
   d="scan'208";a="172272625"
Received: from mail-japaneastazon11011021.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.21])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:37:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1ytG/FnLsfGk58jm1lbqwjUU3jH7CZTvhJk6h2bPk5vqIrPFoCfbdapH8hzxukCO9JUfsuocvGZ1bS0CiF82kE2KeiLSTzipWLv4wYFD1cEfBlKjkRi0TZ9Ungkbh17Wd960NyMXXnke4I2NNbcpNPtkuqQC2IeJ5YWs6zX0V5TW04ntJxtEIo4wryIAGcVKqvWnnF1dc32eXToUXSdVrbvtRs5dmwTjET//hf//EiWLlxsMvwhE+5/92FxLk7VErmu6yjjI8RihgV/moksqsGL4+sqJs47qaMF5Ulg3B/TGN2Z7QIfD695Lep5tq1EbHRr/7cYXIyhQhxasG7XVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28wuD96Swf/MV4rk7nhrAy0ztt3VM4aC/x32KeEkPxo=;
 b=BYdw1ZG9TuI5XYXUDXlmlY8KWTxll0E7AJF1wRZooPZo817nJZbDd+TwlWzGrZFmM6FGy2ZmDNKdUr7+NoO1kmZCctgodDafhthUD7c4Zhe8f/1m8I7ch7H4fwFo+ZZn4ohTbd0MMrUca6G4zgaifqqo++JyemY4ZnXPWW+Z47CodRytJ/ALbeDB3zkseIFfQi0plCHtX63paiAXOpe1AcuJh4ikB/R7kcPLCfCngiTV6RFu5jwvPk5pQ8ETpOx5W9b2g9W1+KNosGnAiQCN1VMxXh48JRT9ro3fsS2ELm0OfhSOnyDJ6jlWdwo9fxrcFHJTRYpJkZeoPxYxpA/UlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28wuD96Swf/MV4rk7nhrAy0ztt3VM4aC/x32KeEkPxo=;
 b=avNz6rCOyv4Zc8FCOHobA95kz/U/1khonWrObyVwdvwD6Pp9mX4wJk1eIxf5oYk6WCSfG/4IeHNVegh8bMyRTuXNPItwqEibmqEtjHzj2A+LjU5AZ6oRzC7a9HuFvKNes9ho4laujzTaAF1LhRFPisQnNAVl4tzTRkAvbsE7b2hUZj2ErTTgQU0Kcwszquq0ljdt7x3QGllYwPXzHKAVqEuQf2uI0C9jvG1+LV63ctZx35qFEEj0nqQAtIPIETSaqPwyaWIoYsC0S/sruN6I1GUgk7aNPhd9B9QMMQ6I9Gmmn5fw8FZUhIm+fgC5Vn7iTgdtATyu5naSr4t0CLn9Ww==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYRPR01MB15811.jpnprd01.prod.outlook.com (2603:1096:405:2c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 06:37:27 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 06:37:26 +0000
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
 Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>, Ben Horgan
	<ben.horgan@arm.com>
Subject: RE: [PATCH v3 09/29] arm_mpam: Add MPAM MSC register layout
 definitions
Thread-Topic: [PATCH v3 09/29] arm_mpam: Add MPAM MSC register layout
 definitions
Thread-Index: AQHcP5f2KprRKtAGMU2BCmMb3lXnDLTYvYbg
Date: Wed, 29 Oct 2025 06:37:26 +0000
Message-ID:
 <OSZPR01MB879898BD78D9958439E8535B8BFAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-10-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-10-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=0cbe2321-afac-4095-8a5c-9e8016be78fb;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-10-29T06:36:28Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYRPR01MB15811:EE_
x-ms-office365-filtering-correlation-id: 92bb300e-674a-4e65-7977-08de16b5a060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?VFBseVhyQ0Z1b2UrQnp2RVl4Y1RCTzJPZW9DNkpOTS9tbWR4c0lCbHN1?=
 =?iso-2022-jp?B?OFAxaGZJYkxMK1k2bjVGVWVOTnduK1hsTlIzL0srZU5IdDZEc3FGS1gz?=
 =?iso-2022-jp?B?SG4yYThXajRZdy9LK1hUbnJYbGszRHNjaHBRTzg3S1ZySVkyLzd2NHZn?=
 =?iso-2022-jp?B?TVh2U2J5SHBUcFBjdWdidW94aGJhVFNKYVY3cmhONlBoaTlQQ0pMMnlM?=
 =?iso-2022-jp?B?VTZSQmdwVVlITFNmRGxqQ3Q3VXh4a0VSSWVFeWw4RTUxOFc2aXl5WmJ3?=
 =?iso-2022-jp?B?MVVQU014U0k0aFpEOUNLbURBMkxZR05mR1lxdkw3Z0tFVUlRamZ5TVhw?=
 =?iso-2022-jp?B?WVNPR0pDMi9LY09jcVNUUVZlNFNLWVhjTHlUNTBsU09TU20wamtTbTJQ?=
 =?iso-2022-jp?B?MTcvSXlvaXRMZ2ZGTEpkczFyR0RUOCtPZnpEVGsyMzlxa2xzV0Vna0Ev?=
 =?iso-2022-jp?B?TkI1MGtZejlIUXBLQlIrV3N1QUh6QVBPZFYzeVhXQjNwdmVGY00zNzdW?=
 =?iso-2022-jp?B?YU1RSUtCM3lQSGdzdW9nR3p1bEdUekVTc0I5M3dkb0NiaEk4R0Fsbmdk?=
 =?iso-2022-jp?B?OGIyby9HVXpsUXBDS3dIeFIxRk4ySm5ZMi93TU1yUVlBWUJldTZFdmY0?=
 =?iso-2022-jp?B?bDY2T2o3WmZUWWR5bGlKbHlqRVArRWJMU2VKWWtrVFlROVUxc2dzcW05?=
 =?iso-2022-jp?B?cHRWYlkxWXhyU29jUkg2NXFXcXdGV25KSm1uNG9hZGV1NUZFWTNvY0lS?=
 =?iso-2022-jp?B?bGlvS2w3UGxBZ3V0ZzAzNXVzV0hyUStWK0FpTGpDNURkMXR2TU5EL3ds?=
 =?iso-2022-jp?B?OTE3R3ovT21MN3lkTm1McFpmcmU0L1lqYmZxY0FzaC9ja094WHlMckF4?=
 =?iso-2022-jp?B?YkU2RkQydGtFanl3ZjRDZFNmVVFlck55WExtUnhTVGNGcWlWdVlmRytB?=
 =?iso-2022-jp?B?TlBCWWZiRTFEdTBXb2FsNW1vMVlVSEZwejJNRDVYQ3E1Lzh1NFlxc0hO?=
 =?iso-2022-jp?B?U2hVZkxpeHJwNkpBekswOURmQU5teXVJN1poSUpZaFMrdG54c0pFaCt6?=
 =?iso-2022-jp?B?SFpjc25HMllDblJhdXZiRUVod0toYVdmUXNLeFRUWFJ3Uk5XQ0gzaGVn?=
 =?iso-2022-jp?B?clpPM25RSVRtMjBsdm5NSFJtWTRmajJhdjhzUnJhVjdKTGNxd1NDOFNr?=
 =?iso-2022-jp?B?SXhySUlHTVNNRFNod0tQcnRueHVxZk0xZUs1eTB4M09sTjhBNWRlMHRE?=
 =?iso-2022-jp?B?OHlZOVhUckhJVzdGUUtWdWFUTU5tb3AwSWdMMFdtVWJuRGJTSzZ6bC9p?=
 =?iso-2022-jp?B?a2VSUmVlSmFNRFA1SE5qQmJKMlJqdXE2cjk5U3ZMY29ma0o5aVc4UDdN?=
 =?iso-2022-jp?B?RmhHT3hDWjdFQXo0cG5MSElVZXNNdk5WK0FubnMreElsR0dTWWxJeVdj?=
 =?iso-2022-jp?B?K1lqa2h3cjY4TllFYnAvWTltVWV4VnBWOUIvMVAvRTV5TzZyVUlla3Fr?=
 =?iso-2022-jp?B?VVVVR0EzL2p0ckRWY2xuK0laeTdXYzZLUkRzYW9YWElPS2c1b3NtclJw?=
 =?iso-2022-jp?B?Mmh5YkMxWktpSzk3MEJyTExLbThIVlBsQUtQWDJNQTJBbGxWV1ZHSS9l?=
 =?iso-2022-jp?B?eUs3RGhBZzZieE5CQ3RWcCtHUzF0MDNOeTJsZXRSMnV4V0xwN2pqejFX?=
 =?iso-2022-jp?B?a2NadmYxNUFUSlNZcWtIaUJPNmI1RjRyNG9oYVJnR3RKOE1TUGF1WkR3?=
 =?iso-2022-jp?B?QS9Xb3ZNR1J5aS81NFZXNTc0aGtJc2hsRDNKczN6YTM0dS91MGl2bHNH?=
 =?iso-2022-jp?B?dnpDV1NkSXZPbVNtS09ra0lpRHd5VjAyeEY2U29EUStFVkUzSUNDcjJh?=
 =?iso-2022-jp?B?L1NzNGZVSUNZTm1KSEhmMmhlS2hBelNOSURRZ2FkbFhUdWMzOFJFaUNZ?=
 =?iso-2022-jp?B?UEM2NkFNd2FQUWZKTnVEdDVqSUN3RTVoZXJSNlFTMVNTTEtYemsyb3dK?=
 =?iso-2022-jp?B?QkNOM3JOdVZIRVhidFhob1Z4clI1Z0xQN1RnRlZ5U0dUczYzOWpqbENl?=
 =?iso-2022-jp?B?TUtQR3NrVjh0RlAxeG1CRGtkM2xjOWsrUUZ5NzZ0elRPdkozWmRzUE52?=
 =?iso-2022-jp?B?ckJ3QjNhWnlaT0Q0TjNsOVVERnc5S1hDRlFXeXhWMG9UOFlpSnd3Ykdh?=
 =?iso-2022-jp?B?L3crbXBwVnhTOTZ1UTBHVUZZUzlxYWVpT20ydVMzSllPM3RXcVhkL1Ny?=
 =?iso-2022-jp?B?R3k5UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aUV3KzZlb29hK1h1MmhVWmZ0Um5tcEQ2d2JnanFxdGM3MFZoendNQ1J1?=
 =?iso-2022-jp?B?MlREd2ZjNW1xWmtkR3EyOUtnVjBObHRQNTJSOUN4dWdrdER0UkFaSmRI?=
 =?iso-2022-jp?B?a280QzZxVi9WSytxWkNtY1hHU2x4b3FnTVI3eXdjOEVjQVAxWWlnYkpp?=
 =?iso-2022-jp?B?VXlHMkEycXM1cHpwc3g0TlMvSzMwUVYyUTZ1S3dDT25RU2lFdlVYcUh4?=
 =?iso-2022-jp?B?b0FtZUxqWkkzOWxoOVNRZ2FTNS91WEEvVTRhOFlDbGNtSGZlNks2T1Rp?=
 =?iso-2022-jp?B?b0IxL3hETkdXN0EzRTI1SG8xeWtoZGF2RE5GR3FjdXVBbTI1V1lMRSt1?=
 =?iso-2022-jp?B?UEUyTElvcmd1djN0aEplQkxMOFhuWVppSTV4cGIrZ2d1SXhyRXJMYjZT?=
 =?iso-2022-jp?B?ekxxTnpmTUpMU1Jxd3QvWSsxMTVFaU92V25vdytoRjB0a3pxV09GaWhQ?=
 =?iso-2022-jp?B?dDJRSEZTc3hUa2kxanJTaFVVSjVYQ1gzQkhwcFEvWW9YN1drSk5wZS9H?=
 =?iso-2022-jp?B?Q2JkczRud3BiUVpvS252ODRlamFRbUEyT1NNU0tkV0RhbXJycURhV2Np?=
 =?iso-2022-jp?B?VW56S1l5SjhESWNOc2RmQlR5TTFySUdwaU9sV1FIRDBocGVEOFNmQnow?=
 =?iso-2022-jp?B?ZHUwOFNWbXRsWnlJbHhmeEtFRHJpdEpuRWxXQ3ArdkRYckFCeVEvaHBE?=
 =?iso-2022-jp?B?NEtLVFAwa1RLK3lXUng5TFAzc21iR1VQMlFmWUV2azROclBJTkF6WHYx?=
 =?iso-2022-jp?B?RGJQSy9EWEszcndUUzhMYVRhNzN3RGtUVXNUNFN0aDErdEhhM0k3UHJU?=
 =?iso-2022-jp?B?ZGZ1ZGJJaWNCbFJLaytRbkxwb1lnaU1abU1WaTFXdGpNc2ttM1MrekM3?=
 =?iso-2022-jp?B?SmNxRjdHTmNBaXJUUDRaN05qTkhrVW5wZmFBTG96RFRpL05NalZqRERI?=
 =?iso-2022-jp?B?T3lDMjFwN2RiTDhNMFhtKy93RkUvbGJCMVBIQ0UwdXQ0M1RBWFpaRyta?=
 =?iso-2022-jp?B?QVN2VXVnK0dxNXFYQ1g0cXVWUU9zYTJZUVpFYmswODlGUFhRMWJidWgz?=
 =?iso-2022-jp?B?VkRMeFBHaUhRcUd5cTZaZmxYZlVGR011b3I5ejBBRit1dzhadXo1Tzd3?=
 =?iso-2022-jp?B?dVJkOEJyK2ZvUXJ5YVdmcklhcHdnb0FSZWt2Zktnb1llR3l2UkRlYzJj?=
 =?iso-2022-jp?B?dXJZOHFoRWFoWnRZU2xLeUwxWEpPZlFzUk5PbjdMWUwwNlNQYnVZNnVa?=
 =?iso-2022-jp?B?U2NKZVRZckNHa0k4cURiZ2NmWnlZT0Ixa1NNaWZoYXZ4aUgwUW15c3RP?=
 =?iso-2022-jp?B?dmpIZHR3NGg2Mm9IaUpHeWdLdGt1WDhmakJzVnpEUHJ5Q2ViL292M3dI?=
 =?iso-2022-jp?B?a050Ykp0cVVwbmJYMCtHcERET0JRaSthaGhmSnlya2dxRitQczhzVkY5?=
 =?iso-2022-jp?B?UlJDdjVZaTlOWU8zbmc2VlB6V21haTB5TEc3V3c2YUJtN1k4SEx2SFJH?=
 =?iso-2022-jp?B?ajNPekV3S09VTXQ4S05QY2hLNnVzSjdjSXZoWjJCRXVLK0FRUGZUV1ZK?=
 =?iso-2022-jp?B?RGFOSHgyak5oRXMyK1BVVXNVQmdBM2llQXJucUkxckhtT0xGZjdXMTIx?=
 =?iso-2022-jp?B?cEZ1S3hqMjBvZTFLbVVOOUlJTzJMV28wKzY4T0dsVGhXQmRsaGk4L3V4?=
 =?iso-2022-jp?B?S3hQa0QrNmRLbXB2SmRHeUJEcFlxYm9vRCtNUVhOR0R6dzBISkNPYXFG?=
 =?iso-2022-jp?B?STZyeWNYT3d1YUVQc3pSckczb0pObmdJSGdJckVGd1p6eFpEakM5emJ6?=
 =?iso-2022-jp?B?eVRRaGFERGhzdGdQdy80QzAvL0RncE81RUlJLzFGRzBCaEo5bEpWNXVx?=
 =?iso-2022-jp?B?b0lWaUhHb3NQMmNqNytBOG9Jd2lmYUMyM083bHJMbFJ1SG9ERnBkM2M5?=
 =?iso-2022-jp?B?ZlVYU1dhQWF1NmFiblhBRDdOS3laejV1VmpmRGFwWG1GSkovZ0svRG54?=
 =?iso-2022-jp?B?djBXNHI3eGs2L2VzYUd6MENEeVpyandCMWlwQkVYR21TTVFMdXF2MXBn?=
 =?iso-2022-jp?B?ejc1a1RkYVdObWlXYTBjeGw3M2tWLzdZOXh0dFVLL0FIdXZHYlpsd0pC?=
 =?iso-2022-jp?B?YVYyVWdZVGhZcDg0QU5QZTZ6NEtUQmE1RUIxQ1Z6ZDh2QkRpOHF0VXBI?=
 =?iso-2022-jp?B?OWhOd3JqMVhLWmhsRm40M2o0Rk9SdXlTRkw0R3F2TkNLOXJuY3lSNW9T?=
 =?iso-2022-jp?B?T25tRzhPUEh6L2RCRHhxcDdPUlA0SzNBZXlhMkRwRnV5M2RWdy9WdkNQ?=
 =?iso-2022-jp?B?R0UrMXAzdEJ4aVc2QWJkdTZ4RGN3a0pzMEE9PQ==?=
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
	R1K+rfla+Yz0zH9FjNtT5RczHaVWnyYLOlUzpOx/Iw98Pp8EecTcbcP7P2jI6MOtvV0yfU4HOF75Z8gKk4JFbORt8i3Ey8MMLWDXSv9OhZ6aXJ8fFvx5EhHZuL+E+SmH3HdggrYO2+WynEk/iVaeUdZxIfLYtqcq5YlgrAvpv8KZw6JY+qty5A0XO0WP9sCNHv++LiTzATZzSMMOM0dcte8nhY8W71K4QG+PFxRYkgxAG9yAZvPuq69uh6imAwdgdAX8yXJ7AXlUbjK+9xQt3xCcm2YKKmBM5kRJeFTAI+NKcmZSK7zMtyldopbudCMjRmv9tKGDK1/VnUogW7OniZvyQfgbXaCtC1W0mG6E0n5dWX/NTZMpWe5e+UoBDkRK735IObIQJWfuWEzQNtjCKoG3IKYpMZXrC6Lk1yTw6v/tIWKCrEa/lrxSmngEEvEQPHp79lwcm0XAsMEyc1+ggmQjfVgp0Aa4OsXrc7Tg3ue8T33q61aY6+sqgVRAhfh41OmsV8Aivx9+H9J34NDWa01/3a0qlZgQ7I/XhrOdYDG3t3nqRIsBnM+Qs8qyiOn5OWlUENXT2Z3Reo40JKr95dyTD0AKbDHjqP8gaAPmF30P6VpWNFkaK6YTiOSeQomQ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bb300e-674a-4e65-7977-08de16b5a060
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 06:37:26.8034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Su3eBFcgCk7N/H66te7xG66rk9Qu2Wzy9nZ8Q60CMvwx6gHXyySh6UrK85BOjjvtN8VcS8DRhmCU1PspboEgHpwVJmTZdlh0iUSxHW7DJ6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15811


> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
>=20
> Add the definitions for these registers as offset within the page(s).
>=20
> Link: https://developer.arm.com/documentation/ihi0099/latest/
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

