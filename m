Return-Path: <linux-acpi+bounces-18614-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C7C3E7AE
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 06:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCDD188A760
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 05:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E34220687;
	Fri,  7 Nov 2025 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="oMtB17tD";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ejS7gZQl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD31DA60D;
	Fri,  7 Nov 2025 05:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762491806; cv=fail; b=fi8gKWqit57wZzgwSExm5Zzp4oBE6ng284qIU8t8w8rdI9XLKcejfA0WfM0ABz+I4uUnA2bU0QytAMXiou7Iy2gtBDa9ONhFc5vAgmN5RKI6bw/sTy2z4a40LRoR4BuaJUM3vKDInBsbMLCbA9Ku/sPdIAvdRXhCdZZslTNFIlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762491806; c=relaxed/simple;
	bh=wSRCYCtqnbgZK8kA8QDJt4ZLRN2nouOi4KGewgZVI98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4RJxcqrOrIXhENKcSenDYi3OrWgYFANxLHFwHV3oDLlMVaOlXFpvxrEaQCeBcH8IoQX9vrt4MnmanTn35WgMeDkg9uDiGtcw7ljhVRCC5VIZiLFLF39zLxn/mjIVFlohXZyYdtpKN02dOnthNLV1k5P7CJiPC1en4YzuZg7xFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=oMtB17tD; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ejS7gZQl; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1762491804; x=1794027804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wSRCYCtqnbgZK8kA8QDJt4ZLRN2nouOi4KGewgZVI98=;
  b=oMtB17tDRgAJXL95ZZNal6mXlaGsvFH32klIKaMj3WEc31TJYV5uNbGK
   2Hj+AL2JbtmDXOwwnDqrDUuiwxh4T9WcqSbgM+qygLSdJHUFrPwF3hFUg
   gWm++kC2KuDQibyO9Td7zoQBewhd74acyt7ugPlghkRE8lraGw5jrdeYI
   BcOKd6fUE1KxPWCDks1ghlsKybmCel8wTrmrzq43s2BPFq/qiHJPPVsot
   HrLm128YUd+UjLVxVNDFwxjiuA+qz73S9qJFQIRtpR+LximU1v7azzQ1S
   jFxuODj8mIiSRE8AxHoME6h+9SCGr4lhNXmen4gaKZaDSI/SLJ/lzPrD+
   g==;
X-CSE-ConnectionGUID: eg8z1tPZQuG6cq037yKLOw==
X-CSE-MsgGUID: XFbMF+tYT4Clr1f5OXg4KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="173212059"
X-IronPort-AV: E=Sophos;i="6.19,285,1754924400"; 
   d="scan'208";a="173212059"
Received: from mail-japanwestazon11011040.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.40])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 14:01:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXa+h2ugatBhIcXMgXpS7hSLV7svMcAgF6qctCScx/qIWRqmZyBs5aHJ0yULJHRWH3U4l3uk2WTjYrewUdAr+FU5BhfEsGb2/95kwOlkTrMZ3nxsNKE0fv6ZhXnZygQ//fBDqtjlxJSJ2LSuNhWAWQAhpdzB2lx3+2OjfdCoc81R3fynWEXb4w4hKBvRY08MCFOTldNMGlpJMAg3c5yY0AqAs6NWBM2nCF1NTskVmKBea0at4R9cEVmdIinTZnV3SJ2a7tqdF2Hrzz5H4MPlG9U6JFn7bXcWTayTtoPKVfgXx2zL+nffFrmgU0xvLbPAlobZuPzEcM37GVGBeNLR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSRCYCtqnbgZK8kA8QDJt4ZLRN2nouOi4KGewgZVI98=;
 b=XlMg+WqHXYORPhAwRMYrO6PG+RVia711nN2nKRx24lex+lJp6TA08jxihQv5o4BoCV+O+L4A2WM+hlZAKQMRp8oO7kP1GzDjOhNvVnV9NxRDlahS3MIQsWUOGJkWcuQPmxMNHZp/rexP75wmKJIOW/wHr4apm/uyr8R7ukNIdynqsssaZN962XHsSuIQiJEe/xANNDf4xZc+hBL8dxVk5Q9IwIQ7id/k7q58q8VEj8QGh5jtyB7k4GSIUcv7GpMdDQrhKyDIM/htIw+5dkRZ57Cncmzw3QerXzPUjuwSOKGTnTP5g1NJ03KUZ9H+vTn37gjEo8Q8Go+Ht6qETLc2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSRCYCtqnbgZK8kA8QDJt4ZLRN2nouOi4KGewgZVI98=;
 b=ejS7gZQluWMqoW89HMOfTNGdvYXJ5OHmRh2dki2LnFye7/GUs2YkF+ZbZhGwkfVYuOzXTBKlRazIbP09Jb/0UuTs/NSXqY610Xywkh+Shary015KJLoglFNRRN0R0ICb89ADp/adXvxKh0k4ctrAxZWZR+hNqvlCUeRULem3bZetwESTaNIE/pGMyRLNxlWpMDAJMU8p/a8WU8mEBpmngwi30FpuqsyF2QR+UglaNjIQ8LNeWIjWgsBf+qZqfDTPWnTOs8uHYG63gIX7/mJBlxv1hpAhPw2qVYImGC47CiW6lSiFiHV8/dc3mywJkVPCDmAtks1Hv0EN1EJnpCFT5w==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB7292.jpnprd01.prod.outlook.com (2603:1096:400:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:01:56 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 05:01:56 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Ben Horgan' <ben.horgan@arm.com>, 'James Morse' <james.morse@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
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
Thread-Index: AQHcP5gi3HY59E83yESxgvOX1gpTFrTj2YYAgABB8oCAAqlbMA==
Date: Fri, 7 Nov 2025 05:01:56 +0000
Message-ID:
 <OSZPR01MB8798EEEF42B16AD8F35DE8EE8BC3A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-24-james.morse@arm.com>
 <OSZPR01MB8798C425E5A820C2E0AAA7BC8BC5A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
 <597d479f-4f1d-4cae-b15f-21ecc73a35bf@arm.com>
In-Reply-To: <597d479f-4f1d-4cae-b15f-21ecc73a35bf@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZTBkYjk5NTctZWNkOS00NzBjLTg3MTYtOTRjZmE2YTli?=
 =?utf-8?B?NzYwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMTEtMDdUMDQ6NTA6MTRaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7TVNJUF9MYWJlbF9hNzI5?=
 =?utf-8?B?NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfVGFnPTEwLCAzLCAw?=
 =?utf-8?Q?,_1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB7292:EE_
x-ms-office365-filtering-correlation-id: aa47a732-fc1a-4b5e-6cae-08de1dbac66c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVFBcndCdW5Cdzl1TFJIbEtOOUdSdVQyUmhUZ3RYYm0zR3RTMExuMGgyNEdS?=
 =?utf-8?B?OTFSNDhieDdzNlA0NHE4M09BWTlOMkRuN3Q3Sk5TT3Fya1FuSHlsOStNYzZY?=
 =?utf-8?B?OWw4Q2Y3V29ER3EyMnNSY2V1YTVDd29TeU5oNFdiNDlFS1FGbXBubnVVbkhm?=
 =?utf-8?B?RTFMRys1U0sxUDVTOGRJVGJNUXl6Y2t4Uit1YXB1djdjNGRFRDFOSXh4Njd6?=
 =?utf-8?B?WkkvcjV5YnYzaWluZTdEbExhNlNteXFuNjYrRml5TldGcnhPdEFPblhsM3NT?=
 =?utf-8?B?azdpNWF6TzZXK2diSHpRT3drb0owV20zamJKN2tiU29wenBrRzltQ1RYeFNI?=
 =?utf-8?B?b09POFZwem5vZkVPYUNVQ3NVSEdvZHRCcE1zYThkK0thZVI5N1V5dlpZTUIx?=
 =?utf-8?B?QndqOHp3Z3BSWTRHaEpRVHFyb3E1bmNNR0lBOWZ3cC91YlBMSTY0cnp1T2lS?=
 =?utf-8?B?b3VxeHVFSldES05yUytRTVJMQWFDVWlsMWxSMXcvQ0g0dXF2blhVekhUWDR6?=
 =?utf-8?B?WDZ0WTl1VDBQc21NU0N3Ni9tWUhMdi9lblNjOUdSazl3Wm5pUEhQQmY4aFg5?=
 =?utf-8?B?V1BGc3pVNEdPU3Vuc3FWY3lXNmlPcDBxRVVXUTE5M21PQ2liOVpVUXorYzRH?=
 =?utf-8?B?TjdhUHpGc0wrZXJQNXJBY3d3WjUrVjVaVXBGcFhVQ2xOeVhTeE00OFNIZlAz?=
 =?utf-8?B?bmVwR3djM3N1aVpETlFjbCtCYmFqUG1zOS85UHNTalBIa3FKOGNLZnFqekxv?=
 =?utf-8?B?ampEeGtPVG5XUWVPL080Vk91bXlNZytMcmJFRWl5Rms4QlRFWHozQ2sxQjh0?=
 =?utf-8?B?YTZKb2xCZ1E4U0g2RGx0dXpkMGdSd084ekdXTmNqWTI2MUtyWFp5MDZEZFBW?=
 =?utf-8?B?UHBmdmR0cElxcm54bnRCWGd2UDZXVDB6TFlUM2F0dVFnYitxUUdVNmtaVkJW?=
 =?utf-8?B?aTAweWxGMW81RlpmWVhCaXIxeWhhaTVQTnpGU1JIZU14NDBNTlZjVnNQMzQ2?=
 =?utf-8?B?ZXFCV011WWk1MVFEcG81UDlVY0lLeVJEYWdOU29wWC91djk3YjFBVmwzbkJQ?=
 =?utf-8?B?WlJFV1JJVWR4bFZCakNUZjBvS29ZUGV5R3VXRms0YUxEaDZrR1FYNmdIMTda?=
 =?utf-8?B?S3lqVGVRM1J1QnFCY211Q1pVVXZ3ZkJ5VWZud25acEs1UzZZcVc5eVNpZmpZ?=
 =?utf-8?B?NWkyL1NOZ09WV3c2b3FWZGMza0lVQzVCN3Ywa3N5cTJzaXZMdGkzcVk3VSsr?=
 =?utf-8?B?dWpYWHVRYWtLeEk3NzVKTjFXaU1jdVNKbzFLUDBKQXphT280WWo3OVNUdGMw?=
 =?utf-8?B?a1U1WDI0MXBwaWRzYkF4cEIxdDkvZVU2bm40d1RrZkVqM2FWT1E3d284Njcr?=
 =?utf-8?B?NFllZ0tRQmdSclJtb1liWCtHYWIvbTk1blhoSk95dEFkVjAvZkxBUklwTGw0?=
 =?utf-8?B?OWRSTW1KZEgvb2FOdkZXZzRCeHJlMUV1QktsQkxad2xvWkFyZXlzUnVlQ3Qx?=
 =?utf-8?B?VDIyUm12MzhKN25qUTUySjVCWDh1bnVYazV2NWFoRlBDMEFxU2NONXVSMXlE?=
 =?utf-8?B?Z3JwU1VzVmttc0hSWStWdGVQams2ZHdPUVZvb0gyTSt6cmM4MzNjdDEwU3VY?=
 =?utf-8?B?a2NBN1pHaW5nSzNhN3ZSbDI0ekc1UWRvQUhVejgzRlJ6WUJCYVFpZERROU4z?=
 =?utf-8?B?ZURpT2RKcFp1ZHFqU2dRVUhyVVludFpEcXU3QXBpK0w0TTZxVXNtVE1ueGpQ?=
 =?utf-8?B?T2NJL2dYeDFEdHdxeWpjNG90RkJxdm15S3lsNjVnRGt0dGhUWGxZNDFvSy9X?=
 =?utf-8?B?WWRQMHRFY3BYMzhFb3JiNnozVkJlN2s1dFJtRStDZXpGbGZiRGJRZ1l6TFIr?=
 =?utf-8?B?dkQyYXdsOVlOblBiU25tZ0Q4Rlp6MkJxRkRUTTNVTm4wYUNBUjVUd0JBcy9M?=
 =?utf-8?B?VDN1czU4ZW5LaEJIRG92U2swaWVWdzBSUHhzWkxIWHA3NVhLbmVIbVFOVVNJ?=
 =?utf-8?B?d0NUWjdBd1RCNW1ManExcExJbnIwSFl3MXRhRjFCTnJ1Mm5GQkZlSDFjMFpJ?=
 =?utf-8?B?RlMyaFRNRmNBYmZiOVJNMWtHcVk3QkJUNkV2dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym55bFJWbTJYZUVqQ1ZnV08ySXVrcnhyNmtZa2s1cy9lTllCQ1U0MGVmejBT?=
 =?utf-8?B?eU03UURGcFluTXNValB6eno5b1U4d3VJUFhDcm5aMjAva0VyQUlPaWRrZ3U0?=
 =?utf-8?B?bjBMNzRoazJGMkRiUnNXQ3QrcVBkMzYrbjBqOG5nbkg3c3NhU0U1OTM2eEtw?=
 =?utf-8?B?ei9mNkhJeHUrNGVkWmMveUpjOG5yQ1lXSVpQb21EemdBU0V6K1JKQWtFMFov?=
 =?utf-8?B?bFdNUmtBM2RIai80bWNQYldCQi9OcmlYZ3hvcE56UmpZM3BtcGhTUWQrd1Jw?=
 =?utf-8?B?QitLald6bkdyOWdGSVFlQmZQTTNsVDRoemt4THR2R3FtL0hLWVZYS21HZGV1?=
 =?utf-8?B?R256Y3h6ZE11Z2lyYmV4ZmduVmFZdVkza3hacVpicHJMYThBaUNPOGhJVmNL?=
 =?utf-8?B?QS92Ukh1elZER1FQRzFoT1BqZHUzR29HK2phZHN3eGxJaGtIK3FvMFhZQ2Vn?=
 =?utf-8?B?TFZDK0JjWmlBeTRSRExzNHYzVUQzdjlGWUVUenFrZVZGemYyR3N3WWRBSVUy?=
 =?utf-8?B?Z3Q4RjJMSkRFamV2ejlLWGtLN3djNWQ5UzRrVGoxVzRaSGhydjdUblFNMkdt?=
 =?utf-8?B?MFg1c04vY1Y5K3hXU2VlS0N2SjR6bzlzcFpUaGRDRXlMMWdvVThhY2hLZHJq?=
 =?utf-8?B?WTB1TnowOGJLTDNJQ2FpTndhQkIzQVdRSHFrVnZHSDFrYUJZZzJBamtwL2hm?=
 =?utf-8?B?OExzSHJYdWN6UDRsMDVCMlVWSjNMNEJkSGxiTWVtZHcrNkYxbGhqaDJFSEtB?=
 =?utf-8?B?RmlITFFaT1RnYjFhUzNYVnVYVUk4YTZOTDdRNEt5WDFaY0M3WlRDbkFiZTFh?=
 =?utf-8?B?TUd6U0p4S2l0a1YyVjJHOGFxaFlHMlZWUEZWa1dIRlBKakZTRTE1SVpSUTg2?=
 =?utf-8?B?UzVwV043V1paaktmWWhBdk16MzA0YlpadzhTeS9ndkZpZHJVVUNxaFgxOEtS?=
 =?utf-8?B?b091ZlVEMTB5QjByMjJCU1YwQUk3Q1F0ZURDeGY0c0pvMmdiekk1S2s0b1Fq?=
 =?utf-8?B?MXcrbElpK25ldWlrRDIzZDZOd1dSTlR0QXFEZWFSVTR3dEpDQ0Y2bXBGQ0FZ?=
 =?utf-8?B?a3V5U2pjOFpibVM0bm9Sd1IwM1ZsVjRXbCsrRW5ReUt6M3dEN1JHOGRjY1JO?=
 =?utf-8?B?RUJnRGtvS1gxNVRXSDkvWmZmaFNYUDRjVko0V1l5dWp2THAvbGtkRmhMZGh2?=
 =?utf-8?B?Wnc2ejBqMm9wTStEbnFVa1FuS1NxTXFxd2RkYnZtWEM5Yjd2RmZ3dFRyM2pS?=
 =?utf-8?B?MDdHelRkeDA2WE0yZGFHaTdHOHp2V2tWbFF5Y1FnS1ZFYTBKdUdaSmNXRWpP?=
 =?utf-8?B?QlVRUXM4WEdNdEVZdVRTemFMV0w4aEVhMmZmQVVGSlRUR0gyTEV4ZFNxRjBt?=
 =?utf-8?B?K3VETTdWbVJ2Q1RRZGpWWUowbjJZaXFtYXhLU3AzMUhVOXVibVFpSW5GOWh5?=
 =?utf-8?B?cGRiOFZKMnJrQTZJRklUKzROc3dFS015bXhjWFM3TUkxNHdVKzY1czVzUmpX?=
 =?utf-8?B?NTYrdHREUDJISnhXbVBTSGl3M1IxYWwzSVBWNGkwOVFxdXUxNGg0OEpXRGlj?=
 =?utf-8?B?OTlMUVBQOEtLTm5UbTBBSzBpeFg2YW5jQ0Q5QURQUmsybVUrRm1QYVRNaUd3?=
 =?utf-8?B?WlRNREs0amg4VEhKeUpUNXJVMzlBNm1lcVV6aTV2eDRYTGgvQVlvcGZVVnpw?=
 =?utf-8?B?OU9aVXdyazF2TnRRVS93MkFhdEVCZ2g2ZGQ0RnBReWtQakxDZjZDdVhiRVl2?=
 =?utf-8?B?bm94OE0wOEIxQ1NTYUJBWU04VTlLOUwyb2tTd05ZQUNOWlloUm05Z2tYMzlF?=
 =?utf-8?B?SUtSQ216ODRQM0piY1ZWVElnVFdEeVJXbGxBMjRzYzRXNm9TNzNCZDZKWk5x?=
 =?utf-8?B?VlZsSCtOd005ckgrMUE0YnVBUU41S2NEUU5QdVVSMUVrTEF4ZG5TRjlBcnd3?=
 =?utf-8?B?eGVCWVhLZFJ0TlNvVkd1WG9JUnloY0o4Rnd5YTBraDZPbHlXbHptL2pZRkI5?=
 =?utf-8?B?VjFVcWdDQ01NZHVJNzlIN3ZCVzlRUE9pS3I0elFNSzdHL0xTTHRlR2hEUGhR?=
 =?utf-8?B?c2pLeGVhOWhjZi91ODc3ZC9OL1NKM0lVTlZHdlJScHJTalh6UFpnbVpWUURN?=
 =?utf-8?B?L2lzdU8yYVY5RnR3VjdCallkQnZSOXNyMzIyelRCQjB4TGtIcURBdG5qUlpw?=
 =?utf-8?B?bFE9PQ==?=
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
	J8UeXZx2wn4qO0O9Ac8omggrFvjgLWGkHiVtNp6n7QishW8mKspR+y9yFnwLKkyD8qoo0gHp83DzYR0irwKNcGNhkBjbiGizxbTa43QnsEmQNHzbHO/pyBIeTXBIk2Dv/zxukktQhqhE3MNUizfCqf4rabQzKKWzkIl7zkf3z2FASjoiN2HtjwU2MGaOkQjDFeJzzqN0sDwkeUOacASv3h5MjIPach85O+B9ajb0Rc4zlBjAKNQ4ZQq3yE4GlgM4+pd7i1Y+T8Xdvu7MYkVqG+lClZT+mIM9aZm9QB/OZfwIoKEjrEEbcfvOST/QxzWvisCn3g+W1e8iNf3npdB4t93gA9rfQxBLxHSpG4iSCtKowzL9YEDcUBDK0t5br7LvXJThKxJN62T+tCm8w77/bCE8XWakQV9H9uXzKFT8svU2veQLxAlBM6Zq7UUs8pYwE9LP3Rq/uh5GdHAR6W4e0nmmbdhIXGZSneJ9A0WlmRvGKiMcemRAtoVD9rMgG2J4zbJsXaXWKNf1t5qGQy8R6qMte9psdeRTMAEEX9sxX5DFphweaPnt0WfxbnSS1YFlevlJtHB0TeeBGw0N3nYRs6WILBWG2htYxbwQZIQEEblkMk6tttN/p+6OFTx33wQA
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa47a732-fc1a-4b5e-6cae-08de1dbac66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 05:01:56.3277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N171n6ff7TJVHkTo7Z9eVZ+ICnO4F+jVzdDZuhSf5dylmxPIUl6NFvTIT6Omd+iI7y3kM1TfcF0Z4yXAlkuQlpAmhdu5amA04f/D6FD1dRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7292

SGkgQmVuLA0KDQo+IEhpIFNoYW9wZW5nLA0KPiANCj4gT24gMTEvNS8yNSAwODozMiwgU2hhb3Bl
bmcgVGFuIChGdWppdHN1KSB3cm90ZToNCj4gPiBIZWxsbyBKYW1lcywNCj4gPg0KPiA+PiBSZWFk
aW5nIGEgbW9uaXRvciBpbnZvbHZlcyBjb25maWd1cmluZyB3aGF0IHlvdSB3YW50IHRvIG1vbml0
b3IsIGFuZA0KPiA+PiByZWFkaW5nIHRoZSB2YWx1ZS4gQ29tcG9uZW50cyBtYWRlIHVwIG9mIG11
bHRpcGxlIE1TQyBtYXkgbmVlZCB2YWx1ZXMNCj4gPj4gZnJvbSBlYWNoIE1TQy4gTVNDcyBtYXkg
dGFrZSB0aW1lIHRvIGNvbmZpZ3VyZSwgcmV0dXJuaW5nICdub3QgcmVhZHknLg0KPiA+PiBUaGUg
bWF4aW11bSAnbm90IHJlYWR5JyB0aW1lIHNob3VsZCBoYXZlIGJlZW4gcHJvdmlkZWQgYnkgZmly
bXdhcmUuDQo+ID4+DQo+ID4+IEFkZCBtcGFtX21zbW9uX3JlYWQoKSB0byBoaWRlIGFsbCB0aGlz
LiBJZiAob25lIG9mKSB0aGUgTVNDIHJldHVybnMNCj4gPj4gbm90IHJlYWR5LCB0aGVuIHdhaXQg
dGhlIGZ1bGwgdGltZW91dCB2YWx1ZSBiZWZvcmUgdHJ5aW5nIGFnYWluLg0KPiA+Pg0KPiA+PiBD
QzogU2hhbmtlciBEb250aGluZW5pIDxzZG9udGhpbmVuaUBudmlkaWEuY29tPg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1lcyBNb3JzZSA8amFtZXMubW9yc2VAYXJtLmNvbT4NCj4gWy4uLl0NCj4g
Pj4gKy8qIENhbGwgd2l0aCBNU0MgbG9jayBoZWxkICovDQo+ID4+ICtzdGF0aWMgdm9pZCBfX3Jp
c19tc21vbl9yZWFkKHZvaWQgKmFyZykgew0KPiA+PiArCXU2NCBub3c7DQo+ID4+ICsJYm9vbCBu
cmR5ID0gZmFsc2U7DQo+ID4+ICsJc3RydWN0IG1vbl9yZWFkICptID0gYXJnOw0KPiA+PiArCXN0
cnVjdCBtb25fY2ZnICpjdHggPSBtLT5jdHg7DQo+ID4+ICsJc3RydWN0IG1wYW1fbXNjX3JpcyAq
cmlzID0gbS0+cmlzOw0KPiA+PiArCXN0cnVjdCBtcGFtX3Byb3BzICpycHJvcHMgPSAmcmlzLT5w
cm9wczsNCj4gPj4gKwlzdHJ1Y3QgbXBhbV9tc2MgKm1zYyA9IG0tPnJpcy0+dm1zYy0+bXNjOw0K
PiA+PiArCXUzMiBtb25fc2VsLCBjdGxfdmFsLCBmbHRfdmFsLCBjdXJfY3RsLCBjdXJfZmx0Ow0K
PiA+PiArDQo+ID4+ICsJaWYgKCFtcGFtX21vbl9zZWxfbG9jayhtc2MpKSB7DQo+ID4+ICsJCW0t
PmVyciA9IC1FSU87DQo+ID4+ICsJCXJldHVybjsNCj4gPj4gKwl9DQo+ID4+ICsJbW9uX3NlbCA9
IEZJRUxEX1BSRVAoTVNNT05fQ0ZHX01PTl9TRUxfTU9OX1NFTCwNCj4gPj4gY3R4LT5tb24pIHwN
Cj4gPj4gKwkJICBGSUVMRF9QUkVQKE1TTU9OX0NGR19NT05fU0VMX1JJUywgcmlzLT5yaXNfaWR4
KTsNCj4gPj4gKwltcGFtX3dyaXRlX21vbnNlbF9yZWcobXNjLCBDRkdfTU9OX1NFTCwgbW9uX3Nl
bCk7DQo+ID4+ICsNCj4gPj4gKwkvKg0KPiA+PiArCSAqIFJlYWQgdGhlIGV4aXN0aW5nIGNvbmZp
Z3VyYXRpb24gdG8gYXZvaWQgcmUtd3JpdGluZyB0aGUgc2FtZSB2YWx1ZXMuDQo+ID4+ICsJICog
VGhpcyBzYXZlcyB3YWl0aW5nIGZvciAnbnJkeScgb24gc3Vic2VxdWVudCByZWFkcy4NCj4gPj4g
KwkgKi8NCj4gPj4gKwlyZWFkX21zbW9uX2N0bF9mbHRfdmFscyhtLCAmY3VyX2N0bCwgJmN1cl9m
bHQpOw0KPiA+PiArCWNsZWFuX21zbW9uX2N0bF92YWwoJmN1cl9jdGwpOw0KPiA+PiArCWdlbl9t
c21vbl9jdGxfZmx0X3ZhbHMobSwgJmN0bF92YWwsICZmbHRfdmFsKTsNCj4gPj4gKwlpZiAoY3Vy
X2ZsdCAhPSBmbHRfdmFsIHx8IGN1cl9jdGwgIT0gKGN0bF92YWwgfCBNU01PTl9DRkdfeF9DVExf
RU4pKQ0KPiA+PiArCQl3cml0ZV9tc21vbl9jdGxfZmx0X3ZhbHMobSwgY3RsX3ZhbCwgZmx0X3Zh
bCk7DQo+ID4NCj4gPiBXaGVuIHJlYWRpbmcgdGhlIENTVSBjb3VudGVyIG9mIGEgZGlmZmVyZW50
IGNvbnRyb2wgZ3JvdXAsIHRoZSBjb3VudGVyIGlzDQo+IGNsZWFyZWQgdG8gMCBieSB0aGUgd3Jp
dGVfbXNtb25fY3RsX2ZsdF92YWxzKCkuDQo+ID4NCj4gPj4gKwlzd2l0Y2ggKG0tPnR5cGUpIHsN
Cj4gPj4gKwljYXNlIG1wYW1fZmVhdF9tc21vbl9jc3U6DQo+ID4+ICsJCW5vdyA9IG1wYW1fcmVh
ZF9tb25zZWxfcmVnKG1zYywgQ1NVKTsNCj4gPj4gKwkJaWYgKG1wYW1faGFzX2ZlYXR1cmUobXBh
bV9mZWF0X21zbW9uX2NzdV9od19ucmR5LA0KPiA+PiBycHJvcHMpKQ0KPiA+PiArCQkJbnJkeSA9
IG5vdyAmIE1TTU9OX19fTlJEWTsNCj4gPj4gKwkJYnJlYWs7DQo+ID4NCj4gPiBUaGUgZmlyc3Qg
dGltZSByZWFkIHRoZSBjb3VudGVyKE1TTU9OX0NTVSksIGFsbCBiaXRzIGV4Y2VwdCBucmR5IGFy
ZSAwLg0KPiANCj4gDQo+IEknbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCB5b3VyIHByb2JsZW0uIElz
bid0IHdoYXQgeW91IGFyZSBkZXNjcmliaW5nIHRoZQ0KPiBpbnRlbmRlZCBiZWhhdmlvdXIgb2Yg
dGhlIG5yZHkgYml0PyBJdCB0YWtlcyBzb21lIHRpbWUgdG8gZ2V0IGEgY291bnQgb2YgdGhlDQo+
IGNhY2hlIHV0aWxpemF0aW9uIHNvIGlmIGl0J3Mgbm90IHJlYWR5IHRoaXMgaXMgc2V0IGFuZCB0
aGUgZHJpdmVyIHJldHJpZXMuDQoNCkkgYXBvbG9naXplIGZvciBub3QgZXhwbGFpbiBpdCBjb3Jy
ZWN0bHkuDQpUaGUga2V5IHBvaW50IGlzIHRoYXQgZm9yIHNvbWUgU09DIGNoaXAsIGlmIGBtcGFt
X2ZlYXRfbXNtb25fY3N1X2h3X25yZHlgIGlzIGZhbHNlLA0KdGhlIE5SRFkgYml0IHZhbHVlIG9m
IGNvdW50ZXIoTVNNT05fQ1NVKSBjYW5ub3QgYmUgc2V0IHRvICducmR5Jy4NCiducmR5JyB3aWxs
IGtlZXAgaXRzIGluaXRpYWwgdmFsdWUoZmFsc2UpLg0KDQo+ID4gVGhpcyBtZWFucyB3aGVuIGNo
ZWNrIHRoZSBjYWNoZSBtb25pdG9yaW5nIHZhbHVlIHRoZSBmaXJzdCB0aW1lLCBjYXQNCj4gPiBt
b25fZGF0YS9tb25fTDNfMCovbGxjX29jY3VwYW5jeSB0aGUgcmVzdWx0IHdpbGwgYmUgMC4NCj4g
PiBGcm9tIHRoZSBzZWNvbmQgdGltZSwgdGhlIHJlc3VsdCB3aWxsIHJldHVybiB0byBub3JtYWwu
DQo+IA0KPiBUaGlzIGlzIG5vdCBleHBlY3RlZC4gT24gY3JlYXRpbmcgYSBuZXcgY3RybF9tb24g
Z3JvdXAsIGdlbmVyYXRpbmcgc29tZQ0KPiBtZW1vcnkgdHJhZmZpYyBhbmQgY2hlY2tpbmcgdGhl
IGxsY19vY2N1bXBhbmN5IEkgc2VlIGEgbm9uLXplcm8gdmFsdWUgb24gbXkNCj4gc2V0dXAuIE5v
dCBzdXJlIHdoeSB5b3Ugd291bGRuJ3QuDQoNCkJlc3QgcmVnYXJkcywNClNoYW9wZW5nIFRBTg0K
DQo=

