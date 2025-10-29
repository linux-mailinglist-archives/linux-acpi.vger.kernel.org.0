Return-Path: <linux-acpi+bounces-18310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90181C18A17
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 08:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 262E94E5F38
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 07:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F783112B6;
	Wed, 29 Oct 2025 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="vk1qG1bT";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WPZTd8Fv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769C30FF23;
	Wed, 29 Oct 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722152; cv=fail; b=SJpi2MP6x/LzTbMG9ASNrcs65eHYp2kZrzpgz7ZIjIfYxnvjUVT5fvFEyO7/VCS+r6H7ECsVWteD4FUN8/rNEsfvlK94giHz3T+ChSHKmMsZbSMi3jQxRpzbVafXixqeVrIHV5v+HJYm8rshIEBuZ6aVup9KmOoY01TSJeoTsGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722152; c=relaxed/simple;
	bh=Niilj11AgSaH/anbz4Ekr1Udp5mbV4aLNHKwVq7Xjuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RaTh3yfPQJjdYjPFwlMY8BjD35YJqWJSC6hq0yssH+9Y7Gnl/n+TsR9ux8hixnqB+6Yz730mMMZK5nP1iEMQVPm2hk21PeyyCCA5t4xLfSJgcYUGv/P6qqShH/DV8187Usdw7/TgGR+9aBi1XPtcRtziGmKY0ERYMIOV4Lm7dbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=vk1qG1bT; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WPZTd8Fv; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1761722150; x=1793258150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Niilj11AgSaH/anbz4Ekr1Udp5mbV4aLNHKwVq7Xjuk=;
  b=vk1qG1bTMbQUcm41AoNR59uTJQxBTnIbel0FuA6eb7rSE1PfnE4Ct36Y
   XHET551H3kfS03IOe0L27t/0+9NmnSz7EDUVAHBfRFBpZ0NLYiI3tN3Di
   gR1PUiAvQWJwKTH40s50OJcCn7Toanf4xmBNhxD2pL9l5WEC8pvpTM/2o
   qOkRO3Q3BJkIal/RE395Owk4ENQj8Fb8B7kqGilpT5zBPpexfMYmJML5s
   uBU6d41N0lyqPTYFUJEJ2Tq0/7bK1gEN2i05bQkKx5fkUJ5BxV7KQaV4B
   CkRVylvDUem4Rrbtzc+qN2x9B5AtbbEVo2Cm4VA2tXGRLuJR99r+7WtnK
   w==;
X-CSE-ConnectionGUID: ItLX4NPlTHuVqL4PvGZ8nA==
X-CSE-MsgGUID: IbphtP5fR2qCmNSbndxN1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="172424963"
X-IronPort-AV: E=Sophos;i="6.19,263,1754924400"; 
   d="scan'208";a="172424963"
Received: from mail-japaneastazon11010068.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.68])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:14:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZg1CDKGeFJpR+cs/UCKabz1HqU47f7M8q3X1ir/Z6HZZRym3b0RvNXIHKwCg2AcNaRduY6AV30CbPKzToI01wvwql0yO93vnY8wcGLv5XHw4pvViwVrtD5yiDIzD+zTHZRg0ClAJFZ4DflnoGt5C6I0hrrWJPKVreKYAiDJmynyNe21qBrr8eqISkPypeVx1Ie7fIOJ2PJhdqmVs584Wt8+bJ/rdDta4MYMrcYaNcJE4Qj8ezPqSL3/t3/COT0p/J3jrxYhbDpzwQLLzc7TvS9gZEilCmTigPaQMmlxuPDxeR6d6lJqiGH32YqMqmvWSE/YK4X1+EicTGzAoKKrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Niilj11AgSaH/anbz4Ekr1Udp5mbV4aLNHKwVq7Xjuk=;
 b=UgsOFOZAXO0Ux67kXZ2Wa8uS04UiL+VaihM+pmD7DZJiHgVH8P27UBBMCFHy7dIKL1q8U+SdqeZ3HL+2CpwlGyE4UyVk1DVK4mkWU6BMo/Ja0MYL0xB8dtA0UIPpKaQ2C5MdCcVpa3NaZv9pLijtc3p8telZBh4g9tTsHCAs0AJ/SP9V/PXBCQNzyng4R+zUnZVLReuMvu4Wn6HZVSK7JTMzTDC4YAkeI6LuC6EnFO76TJcrFumo6Jm9IPCU39rhuiY/uqOeNXo6wU9ohIPFn+KVKddBCTYN9u2VH+lq9nq1dlh/Wj84bHckHpeFcGWDIPF82tslkecZ67hv8eXqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Niilj11AgSaH/anbz4Ekr1Udp5mbV4aLNHKwVq7Xjuk=;
 b=WPZTd8FvbOPxjgC/jdcGHpvQJNkHwN5f50b/XPhygttmw/ynV5y21DjOT4R5F+NbMNSd0QpEdgbvJ3hxXb9knk0uuUcAnfQKr4ihdgOSGnEP6z9TAbeuHD5WbSpCYKtCQgvDjXa3726jzxFVxCbvdXEMUlgKnqIR84mvPCn4SUTQUDfNnsV2obVZm7eISnzIjCSq0Wo72IuaCuwDHkjZobsfOMMgcyTN2/rNUx4JVq027PDpkeKFXS5515uJa4aqFN+VCpl3SEgKLApVsbq+VI4uMak10+FdzR8rtEg1BKjcW9QvJP+M74KyKz2v+nQFpfKIdB6ED95VFuHgnWF5yQ==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSZPR01MB7771.jpnprd01.prod.outlook.com (2603:1096:604:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:14:25 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:14:25 +0000
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
 Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>, Fenghua Yu
	<fenghuay@nvdia.com>
Subject: RE: [PATCH v3 27/29] arm_mpam: Add helper to reset saved mbwu state
Thread-Topic: [PATCH v3 27/29] arm_mpam: Add helper to reset saved mbwu state
Thread-Index: AQHcP5gv8/ngEQ+7AEiD2geJNmENQ7TYx/tQ
Date: Wed, 29 Oct 2025 07:14:25 +0000
Message-ID:
 <OSZPR01MB87980291BB01FFD5479B91258BFAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-28-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-28-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=ca28984a-40d6-4981-b81b-6f0760468676;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-10-29T07:13:54Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSZPR01MB7771:EE_
x-ms-office365-filtering-correlation-id: 9075c7b4-7acc-43ba-f81d-08de16bacaf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?b1VCN0JvQ0VIRlo1Tkx5enl6ejNoQisxWFBTRW4rdkl1a3RNaHlMK1Vu?=
 =?iso-2022-jp?B?Qk16VmI0Tk5QaC9RQzJxbXdsanNUcnRMQzRkZW1mU3ErZGwxUWZISlFs?=
 =?iso-2022-jp?B?YTJmbHhNZUNuaGxTeWgyRGNhN2NGY2FKNVFiNGhjYmpVY3ZqMTVteGlS?=
 =?iso-2022-jp?B?V2FKRjRIQUExZW11K1VTZ1RpeU56dFBqeGg5WG5OK2hPQi9LUVRDckI3?=
 =?iso-2022-jp?B?c1J4ZTBFTys2Y0piajBvVmZ1czJRYXRoK3llSXJ2d1JLa0NHaWZjd3p1?=
 =?iso-2022-jp?B?ODdaRDVNODFFTlUzVHRjc2pNYnBFRmNrNkUrWmJuSHVQTGk3RWFjRDlq?=
 =?iso-2022-jp?B?N2JLU1N6N2NKT2J4alJHaHZKaW81bThERmtjemNZQXJXMit4NURjY0Jk?=
 =?iso-2022-jp?B?V2xoUy9sV013ck9PUGhNb3l1Wm9PaVpXamFpTWNGejlMb0FjR29lQUc0?=
 =?iso-2022-jp?B?eDR6QVdYbFFBb0tXM2YvMUZKTlEvcXBhdGlSM0d3TmR5Q0tINi9CQmVZ?=
 =?iso-2022-jp?B?QVVWbE5hanYya01Ca0JFa2dtODBzOUpoMVBvbXErRFczOWZnalVGYnF4?=
 =?iso-2022-jp?B?OUpGVE02alNlSUg0RXI1TVJ1ZEQ3QU42Zmx6NnNVaGlOclJ2amc1d0JM?=
 =?iso-2022-jp?B?MERsU3FwUXFWOW9QUjZRQXhzdHorQ2wzTVp3QzFwVTl3SVM1V0F2b1Nn?=
 =?iso-2022-jp?B?emZFREJicXlEbkhvWWpkL3JoWEpBdGo3S29RYy9qeHFwb2dwUUdxS2NU?=
 =?iso-2022-jp?B?djFUOFlBRzNLcElsT0U2cGFJRGYvTkNKTzFlazNueGkrZW81bVg4VFNB?=
 =?iso-2022-jp?B?UFl0TzFReGt2clRRdHpGcGZQVGhmL29ldWM0aGtJYUNzMDVLeXZ5V1J6?=
 =?iso-2022-jp?B?MzZOTjU2ZlpEMkp2amRxcTR4dDJ6dXo5TnBpVzRLR2Vla0lwS1dIaW1G?=
 =?iso-2022-jp?B?YnIwZzBYbEZ2Wjl1Vkg0eiswbjB0NUpWNWJjSDV0UHlQL0p4QzN4N1BY?=
 =?iso-2022-jp?B?NUxzSS9Jak85aUhnZHVpaWVnRkFCclBJYzM2NS9IS055RVd5U1M2NlVv?=
 =?iso-2022-jp?B?dDBFUHg4ODBzd3Byd2dMeU93Tk9XcFhXVUpTSnRrck9DTEVORlNkK0c5?=
 =?iso-2022-jp?B?NjhFbFJHR3Q1N2R2UHNoSGVUSnlJZndUOUVEOWdJUW1zSmM0ZzRubzdB?=
 =?iso-2022-jp?B?eFczUEVZdlduKzBvaHh5d1hSaDhxcUlPNDZYaU80YlYxVEYzaXJCcE95?=
 =?iso-2022-jp?B?OExwY1BSZkQzb05kUkhlTjRFenBNM3FuVFQ0c2dnMTJZQUc4a25IMVZ2?=
 =?iso-2022-jp?B?bC82WVNodmY3NS9QNHlmbGd2Vk52VGxNb2xKUUlwaWpHaXNyS1I5MEhq?=
 =?iso-2022-jp?B?Q1RmcmNVV0crZDFFMWZPa21zYTJ3djRxdm8xSE5mcVNUMERQMmZqa3RL?=
 =?iso-2022-jp?B?czlHVC9PdFlORXVPbmdSeUVseUtBdksxSEFDTU5xL0wrdXpCa3BtbDF1?=
 =?iso-2022-jp?B?czJSQ0xJMHk4TXNWQml3a3NQb1VTT05Kb0RTSktMUzNWelRoZmVWSlB1?=
 =?iso-2022-jp?B?NU1pbStsalh3TDRCNGxvNFZveG5IcDNQMFFvV00zcCtpZVE2K2VTNXdz?=
 =?iso-2022-jp?B?TVlXdDNkcVZkcEtuZ2hncTFJMzB6ZzNLTStkRnRQUlZZallCMC9scGpz?=
 =?iso-2022-jp?B?MGIvbUZuOWNsWXFqaHMvN2VLeUxtazhHcThkMFdMVmVWZ3dWNkpHWjJS?=
 =?iso-2022-jp?B?azFIdWZnTy9xSVpwR2o5MGF1UCsyN0FRRVhNTVZvcHh6VnJrMnhoQjIv?=
 =?iso-2022-jp?B?TldSbitWRFZNaEFUL1RkM3Uxa0RsQ3ZGN0xRWjVrOGhoY2wrbW0wTmhL?=
 =?iso-2022-jp?B?V1diU2dzQWRaOTcyRHRYSm54R01UV1F2aE1wS0lPUDJLaENkK2dYT1d3?=
 =?iso-2022-jp?B?TDRCYm1KTFJjUVczaHJvSURCVHkzK0JVMEhSWmduR1QrTnNmQlNBRXpj?=
 =?iso-2022-jp?B?d2NwU1NVNHRMd2VUN2pzbmNlKzZNTWtzUkNubHZMQ0E3OHozQU1Bd2M0?=
 =?iso-2022-jp?B?UDRtRlNDWVZXdXlIQlRycVhsYUNHSG1hdWo5QWNKOTEyVm5GVldhK0ox?=
 =?iso-2022-jp?B?VnVBSGhlRFBVaUxma1llcS9WR2JuTVlpbkh0bTJ0S0V5UnlkQUJaOUpv?=
 =?iso-2022-jp?B?aFltOEJ1QWNSMnMrNlpBTHhvSFlzUG1kMmlseFN2cWhOeS9rN3dCNm4z?=
 =?iso-2022-jp?B?bFZwUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?V3pNbStQdW9sT0tvblVHMTFhVmE0cWV5YUZ4KzZGVDZ0TkdUQ2lnWUo5?=
 =?iso-2022-jp?B?L0JBQXArY2FJQTJHTTUwRGU5VTlOQWlSQlhCVUZNYm16ZWI1cEp3ZUxL?=
 =?iso-2022-jp?B?U2NzQVVYay9Gc3BzbTI1NzNtZmRiZHhIUklsb1NyRTN6dTdYVXY2MEVT?=
 =?iso-2022-jp?B?OFhMQXhJUnZ0QTdMMEFmaUE2Q3AzaVU5S0hPRjdxZzM0MERMSEEwOFJ2?=
 =?iso-2022-jp?B?bnZ0aFFQQU02VjNwZUFhbk1udExoNlRCWWpqTUtwVEF3bGdaUmFuR1R1?=
 =?iso-2022-jp?B?ekNVMEMxUkxBaERuV3pEOFNZV0NSM0NtMUxGOENUcUR6WWhGQzkwR1cv?=
 =?iso-2022-jp?B?Z0RZczdBcnZ6ekpDblEvbEFmVkIwS1VLTGx5TGJibERhUnVPRTNwaVZi?=
 =?iso-2022-jp?B?eXljOG9yK0h2K0VCVUZiWDM0Z3NSRmNLUGVoVVdoVlFHQXNJQ3hxS1I2?=
 =?iso-2022-jp?B?N2xGU0NsRks3eVNZTXpKdjArQjZiVXR3TGFBZE4wUnQrMEk0NG9pcHZI?=
 =?iso-2022-jp?B?cUVKa0ZTelczOTZUblY5WWE5VWt0a2FEQzR2QUFrMk56UElzVHYvZGx1?=
 =?iso-2022-jp?B?ZFBuK0YzVGVUTTF5N3I2MHhQbzJ0ZjBWVGVSRXdTSjhWUnBCdjc1U2Zk?=
 =?iso-2022-jp?B?QlowZnh2cFhRTHk5eUlTcFk2QWI0OXBRTEhMK0Z1REpPZFB6ZE84anh3?=
 =?iso-2022-jp?B?S05NbEN1b3dwemF2VkNFYng2OVlIc0xzQzhtTWk3bUhkelZJUnBQdGtD?=
 =?iso-2022-jp?B?Ums4dkppK0FqZjFOTmFCMWNFeGFPYmFxRGZ2T0pWTUFIVVQzUFY0MEVE?=
 =?iso-2022-jp?B?R1FrL1RTcGRZam9uR3lpMEYwb1AyYmRtcGlrU2p3ckR5a0ZtUVFUWTVY?=
 =?iso-2022-jp?B?ZEM1NW42bXVzd3ZFZFRoRFRjYi85Ny80WGc0d0hKVFVMWnRhSDQ2SGNY?=
 =?iso-2022-jp?B?bVZvT3EzZ2xjL0dMK0pYOGh1c3hXcVV4cHU3aUVwWi9iajgydGtiZzB2?=
 =?iso-2022-jp?B?QmNOL3ArTWlhdk5aUkZKTzkvMTU0a25LNC9taldLM0R1OEx3b0hGblJL?=
 =?iso-2022-jp?B?cmNFbkRSUXhzRk5vM3ZpK0lRVkQwOXZFWkRlc2pyOFZmZVlmZ2tDTmZT?=
 =?iso-2022-jp?B?WGl1dXVsZVkzc2tYMjZjQm82dnJ3b2dWOG9QaW9PUk1kM3Qrb2Q4QUMy?=
 =?iso-2022-jp?B?U0ppSzJaVlNkUzZTVWxwdFdSTlZjcWFBS3k3dFB1NktpeVJubDlYaWNI?=
 =?iso-2022-jp?B?dzY5MFVCRmQybDhPTFlOMEJjWWxsamNnMlB5UGMycXA3OGtVU3dTODVK?=
 =?iso-2022-jp?B?NzZreGtZc3ZZeUlZL2s3MUllcFlkdEIyM0ZMc1BYRFR4Z1BNUnhSTm1p?=
 =?iso-2022-jp?B?Y2tqNDRpUTFlczJ4L1kybW1lb2FJeFRUa216OGxEeFVDMDV3dnZWQ2dp?=
 =?iso-2022-jp?B?SWdrdE1VT2RCY0pEYXNvVkxidHVSci92QzBNV1g1WU9Dc2gyWHRVNmEv?=
 =?iso-2022-jp?B?RDNpajhWaWJDWFNMRVZub1ZNSHRvclJqVWtKM2V0RkNPQW1yRUQ1NmlX?=
 =?iso-2022-jp?B?RGVrQUhJbTZaR3JwT1crUjRtNDdVcVRlME9uMEp5VFZPZFpzb0ZyNjYz?=
 =?iso-2022-jp?B?L2NKQ3ozYVVZMzVOUFlXS1RodDZrMmpyZVFyTHdSOTZuckt6dHZkTElj?=
 =?iso-2022-jp?B?dUxZdHlhVTJtVVBPTVhaUllrR2QrZnB3TWVEM1B0WEtUQzE3TlAwZE5y?=
 =?iso-2022-jp?B?UEpKODRaaUFtZDljV2dzQlEyZU5hR0pFcHJBZGc0RjZWMjIyS2hVRnFJ?=
 =?iso-2022-jp?B?NUFzbDgra1VObkhyTnJTL0NDcWtocTY5NTBNcytZKzk2OFhjQmFSai82?=
 =?iso-2022-jp?B?OWFJQjF1SU5MeFdyY0ZDMlNjYzNhNHd2cktmdXluOTFNVjN6TWF5VWFZ?=
 =?iso-2022-jp?B?dWRvR3RlT2t1WFNjUERSM0dpdTBTeDkrd3YwVCt5L0czYmlDd1pmZ1c3?=
 =?iso-2022-jp?B?RHllZVYyVmhmTWx5RG1RZ3JsZ25BbTBYbWpqT1NrV2RlYld0YXArYTRI?=
 =?iso-2022-jp?B?L3VGL3lnaGlBL0U1UlFlUEl5cTFCZVhKOTVkTCs4Mm14YlpBa0ExNlhW?=
 =?iso-2022-jp?B?YnFLbW1qOXN2Sm5yaEVDRkk0WnJHczY4ZlJaUXpTVHhudFBQMzBSYVF6?=
 =?iso-2022-jp?B?cEcza205TFoxSG5EV3ByekN4ZjdBT0d0MThYV3YyNVRFY2N4VzU4cld6?=
 =?iso-2022-jp?B?Ris0ZTc1Tzd1bmovMmZ1WTRabHR2a2NhZVRYVmFwTHVWYzZrU2V3dkox?=
 =?iso-2022-jp?B?QXUyVlV4MkNrOXBWdWhPTEJ1am53cHdxQWc9PQ==?=
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
	7+Z6BWgmwl94s3x5lJb4ULJ8jpAJtJTXiAx+DWTUuvnDs3zJqfewq69ZpAKBjW8CM1iBaCZpSrrhl1X6g6uB2ScD84TIWNrx0uBUIII62qCNQpPmVYD4pMWh948oMJxpoEbbzYcCYXGVqgICssMz/RUVcfx3Kn/w+l1Psf1hK72rhBHcUHzlHHq5B1H9h0atjlyusIktgifTvLJOvE2wyBaqbYPLHlmuFs9Hni4xk450SiCZdHsUntqM+P2tbtGXkIOORr3+uivE+7x4Kl1zCGpWJC7CJz8HA9J1YStOojdGgi2CeTMZLBO44q21ekkV7QiEUteC8IufWyccRjp2YZERxiGGDjfpF+ED74gLBjFE/adlRSWtMGgxq3rMOMFMiUx/OmpxVQcXrMd8N002ierFgzQPY5CkXTAVNNpREo7XAptzjYPr9MwKScpI8sp/jetcyNQsqRDTmA3LSQTVP/ER9c+n4DhtojpiqMQmhgqv8pbuiuFxifEgOeoI2J/OdD4vHzggL/Oh1sUMBJcKCokPCChueZDd5tul8oeldlEMmQufJSp+e+KEs3AVmrSR6+OYTXMlt/0h+5tWboQfNoEZ8v+incOTINEDimr7UUr+47JjJrOMr/QLhpiviGFC
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9075c7b4-7acc-43ba-f81d-08de16bacaf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 07:14:25.7350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0q0JJHqlR6/iEdOhTZTNTGSDtFDd5q6n88kP4x/LlOxEzjubtq75XT0ShIbu1DtU+Ns15u99GpqKZuhN5FBlI1M8CdDKFuUv0taaB/Nm7M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7771

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
> Reviewed-by: Fenghua Yu <fenghuay@nvdia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

