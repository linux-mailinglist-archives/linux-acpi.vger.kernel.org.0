Return-Path: <linux-acpi+bounces-18308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CFEC18946
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 08:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157413AB826
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 07:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0DE2ED846;
	Wed, 29 Oct 2025 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="smuVzyZd";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JclcnAHO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89F2EA754;
	Wed, 29 Oct 2025 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721381; cv=fail; b=qoUbQQZJYXrkV7m2pkoGaSQGh/2TFRJwuTOSY8XltKyQU+zCBb8/1XC1HX7Yqrzfz+Fp4SEBzI1r/SWm5QEkyVIef80SQuPwd99xenX64/NNsuRG/7pqdxtearvOIPKtl6dzx0uU/6VkRFQYnIqyjsuWqo1CuSMYP7VtWwl23uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721381; c=relaxed/simple;
	bh=SEhXgLNO02jfnJp0uUjGl42R7WAcuuNvqlHO19GkG/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gyJiC2c/4zwyHuch9MZbpyHwnsJvyEOS73OtkyYqFIMEp0dtV61xY7pHLxnSx7vzD5tt/6eE/wVeS+HQLhDv5KMIb5NLIzRpti7zqg1UcxrvcrgesdJTU2aWg0c5Ia4YWz3Gdm9so8zDac0gmoAn7XtU+hnC3MDjCI/HBsJmHug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=smuVzyZd; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JclcnAHO; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1761721379; x=1793257379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SEhXgLNO02jfnJp0uUjGl42R7WAcuuNvqlHO19GkG/Q=;
  b=smuVzyZd/Zh8onet2e5Uh/Oeg8pBns7PTGLEl1VOovus/XOz+2nx6M15
   p17Al4DHtwuwXiCiKZfuYrn/DzaEaJpJPI8Ms/ODf7TewpQKi8Rwvp1g2
   UWPCK/9Kh79mq7k2+P3GrQsQVjbA5jDuGbUcqdgXxBvFs+n+3v3NsiX6M
   2zVVXSBj8kPVilZDxmwS0W7FqzbiH0DCQJbuTemLrWGSzAiKIId4mMref
   V3N4PuQe/mZcmeJIuax3W+JeNbr9/1KBEkCnoCN+gJ5OwPCiiP+jwtB9d
   b7P+RPD2vvTsXuml32HbJtrBzzXlDbrNrYmThw++gey8XujWEthFFQumT
   Q==;
X-CSE-ConnectionGUID: XucQDIJlQBuWO5rVUMhOoA==
X-CSE-MsgGUID: doHmVftcQ3S8q916/UYUQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="171973013"
X-IronPort-AV: E=Sophos;i="6.19,263,1754924400"; 
   d="scan'208";a="171973013"
Received: from mail-japaneastazon11010056.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:02:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppsG2BQi2ZWUDvJfKMAx/LnWQO8AY5VSK0eHYPvpP7zK/vGadf3Yep5zCuIPBYoTBcAzMwnL9Odv4fGeZJh7nWEYmlR5a+sJZ7r1W4MyfgFwCPOMBbt0rsVKOJBOBVkZrvvEoi4ZsfVl1ackOQACgW+tZbhKxPByfq4k7bghFw6sFj/UTxObXgoNkVUfbq+1M7sMWDbzvlsTn3DlyJ/qwfL4bKcuO5TdRyJYMEFz3aW2mIg4xBkKerT8Xjb3wI7X5BLg6Bkmz7rgNzPzH66L/UyB8cENpjd8FGQmogwrwRCjK6qmLIxu574GN8yU1lgDk1p6R/nKpRZDa6Y1cfJF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEhXgLNO02jfnJp0uUjGl42R7WAcuuNvqlHO19GkG/Q=;
 b=hdqiNEfwkUQIMBX3Z/V5jbTBx+AX7OS6EtGu5dTSJ+Dms1EdQry3lbRngX3GFr7tzde5Sw4+tu1A1VZ8ieKBiuTycDOTj1+d8wti1AeoFZbwq27qn2qr7PSmfyqNZVMdHHymBXh4qOfFrZEqKV18L9blK9CzbOpI/zAFjr3d8cMWveOnS/xhVtKZbiHFPQTjCm6Gr2pLh5T7+BCKH4aMI3WoRL+BQ64XkB2GLumehDj/vD9LizM709Mg3hht3orgVUPUzptbIJ24JWerTJEyhJl1UMsntOICMDXjUrr2+vakhJd3tie7+O6Ip5h7Ri0xEp7ajVjra7N5zpx97mpz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEhXgLNO02jfnJp0uUjGl42R7WAcuuNvqlHO19GkG/Q=;
 b=JclcnAHO9YQxQPgmppufyqLtgmurFE+LXAI7BFpfzALKFvrTqC2MUQICb6T62KavuAf3kHiUsijaWXBnjsspBhjli0GgAVFXWif1hSI1X1dFY86zVV6i51BwqK0wM9IYkFYxv9cKDwVA5XaPW85q9NQDRnmp/Ts+wWYML8fLX0uXt+ULug2PEFtUvEZ32AuqfLF+3lkQ54of7vMRJ45xI/tMZGoB1TVpGfvACYLw2k7o6ap9TIxcfxGwG6F1kKyWDnKqz+BB2g7P12VbzTb+O2v8S0IC6DSP3Sy+TL5vbJa58NV7GAGV4tDvTQM0cBH+aU1i/tQF0HXXKGQJEFByXQ==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB7361.jpnprd01.prod.outlook.com (2603:1096:400:e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:02:44 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:02:44 +0000
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
 Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>
Subject: RE: [PATCH v3 18/29] arm_mpam: Register and enable IRQs
Thread-Topic: [PATCH v3 18/29] arm_mpam: Register and enable IRQs
Thread-Index: AQHcP5gfzmdtn4IkEkuYOaKU7UTJqrTYxJNw
Date: Wed, 29 Oct 2025 07:02:44 +0000
Message-ID:
 <OSZPR01MB879875FB57F312EF7086033B8BFAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-19-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-19-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=c18e61d3-3d8d-4d5c-b45c-65c98bd8bc95;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-10-29T07:01:42Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB7361:EE_
x-ms-office365-filtering-correlation-id: 7d020ae0-12bf-4472-aadb-08de16b928d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ekgwWXhsNFlNNlMreEJzLy90dG1hb2pnNzFBVDZVbDRUN3QramNvam1w?=
 =?iso-2022-jp?B?bENQNXRackllSkQ4ckVra29lbnUzZ05tazdrRS9DVmNDeXhMbUo1T0dw?=
 =?iso-2022-jp?B?aGZEamltVFh0aGsrSkV5RkxNL25GeERXMjVXRGZid2pyck13K3RTNDU3?=
 =?iso-2022-jp?B?blVUWDgxcW5ROG1Dd2VMQXVSZGV6eWxRZmFKZy9nWnBUOVl1VlBBb01I?=
 =?iso-2022-jp?B?cC9XcXZHYnNPSHlqdmZWYkcrS2tzeVdQUk4xN1VOcmN0S2ZrUzhQYjky?=
 =?iso-2022-jp?B?bmtSeXkxTGdoU0ZoZzN0YzRLd201SzJzMytJWDlSVms4Q2hHVldWTnV1?=
 =?iso-2022-jp?B?YjJVU2NyK2dVNWNneWpCRzhHRnA4MEZVYzN3cjcweGsrQWZWd0hOeFFH?=
 =?iso-2022-jp?B?SnZHOWZOODhNbVZsNHNKTnNhaS80NCsrMGNlczhibnRXalFIOExqeFNl?=
 =?iso-2022-jp?B?L2lHOUs2aG0wNWRYdXRPVzhTbDdLVFUyVHp0dVdCT1JFZFVKeElOa2tT?=
 =?iso-2022-jp?B?cmVBWjJ2N3pnaElUajFaZ2QrS3hLeE5ZYWwrcnBOQzd5ZExkbyt0Zmx0?=
 =?iso-2022-jp?B?UHZDSzNSdjhJQmluZjNBMHlmSENOSzBsZlkzdEdQMUZ2UnN6SHpoUG1U?=
 =?iso-2022-jp?B?UUVzdjVNaDZaeDNGNzBpcjE3UFlzSjZFRjE2ekRGTFVROTVVb2xXY1Jk?=
 =?iso-2022-jp?B?VXZIb3B0QjFKUjdhVmVCZkdaK1orcitOdXBmQ1RiV1lMSGtIa3B5OTNO?=
 =?iso-2022-jp?B?ZTFtTy9DaU5ZdU5iRFlCU1FjbFZjc3EydlpvbUZyWFh3ajZtbzA2ZDJY?=
 =?iso-2022-jp?B?WEo0dWJCZS9EbUtDNjY2SGJvcGRVcllVRUExYzNmRVUzYTUrK25qaDBr?=
 =?iso-2022-jp?B?Y1NSK2ltMUwwZW1SQUNQaTFGZ1c2UENQZ2hjbng5Sk5abWN4UGJNRURl?=
 =?iso-2022-jp?B?elF6TkVTbVFKeDl0d2tsei9naFpzaFV3QWNTWmhHVWRyaDU5VGtLMlVQ?=
 =?iso-2022-jp?B?SkVKaG5WQ0hLVlFZdGZVamtaUHBDQW44UlRNQ3pmeTFQSFpaSGtsS29X?=
 =?iso-2022-jp?B?VE4wU0lYVS9mU3c3YzFNTFlYbGp4Rll4b2dBTDA2bEVYK3pyNTBmOFAv?=
 =?iso-2022-jp?B?Um82d1I5SjdPRVJjL3IwRUQ4MnVNa3gremxmazRBK1BIZ2hCcXc0cmZZ?=
 =?iso-2022-jp?B?VUVCTldpZXNCeDR3elBvUGZJcEVpQ0ZLQ2JCUlBTcHR6N3lwMEZOUkx3?=
 =?iso-2022-jp?B?UStQSXZncHdEYk9nVkZhRVlZaTVRaDhRN2VLUjVDaU5sSWxra0xvVUJL?=
 =?iso-2022-jp?B?UE9YVkgvTFk1NnNQRzFYNG9sZW5scmFNVFg3TWd5NkN6WEtleEZQMWZx?=
 =?iso-2022-jp?B?bW9qT2JHQWdFY1I1U2JJMlI1VGQ3UE9HYi9PT3c2NUhlQ0YzOVUvc2tV?=
 =?iso-2022-jp?B?bGI5ZHUvMlo0bVFGVmNNcjZJYjZIanpka0p4SWRKWWxCTGpzYXdLMXRL?=
 =?iso-2022-jp?B?bjAwRjViQStmOWxNYlIxRzJiUUh3ZUtYTG1RZDRHMnlrbjFXVDlvV2JJ?=
 =?iso-2022-jp?B?Snl1RDBGc2M5Z1VZUlpZaE9WWnZLL1hzRERYYXJodFhRL3dGWjgxajlY?=
 =?iso-2022-jp?B?QmZPZ0tRVFRKZnhNMEpwYk1oalBkdW52K2x2dXhlZEdsY3ZIVnBOVktF?=
 =?iso-2022-jp?B?dU1YY0ppTERjbXZ4Q21hQ2x3Ylh1MkErTGZhditncU0wUTh2WWpOLysr?=
 =?iso-2022-jp?B?eW11bEZ3OVQ2Q2dMK1VYMlpvcHB1NStXZDNXcEZXTEd4WWF4MmJhNGQz?=
 =?iso-2022-jp?B?RERXWFllR3V5OGFQU3dmNERDTG5USXpxV3ZXTzR2MjhuMngzSVN6bzlN?=
 =?iso-2022-jp?B?d2VMTGlZc0hrbG5UWEVJMWNNUkFxSlA0MzNJNTRKUURkYkxYQ2g1VW8v?=
 =?iso-2022-jp?B?c09NTjZpL2VqT0granMzRU91amFLaHhaYzFDaG1VcDEwZm1rcXQyQXdF?=
 =?iso-2022-jp?B?U1RpSTd2TWF1TU5BdUhIdG5HZzhZVlRNNEx0TVM3TTZneE5WaCtIeTFG?=
 =?iso-2022-jp?B?SUZMTS8rSzhVNmFtcmdsZWxhbTVabmN5ckwvUTVyb2lqdi80M3lQdE5G?=
 =?iso-2022-jp?B?OEJsQkY1UGloOEozTGN0UGM0ZmhVa0Q0V25IVjliOENtNmh0WU1pa0xY?=
 =?iso-2022-jp?B?NEs5TjJRa2p2RGdhSWJwdmpZdThuTkxqeTNHOE1IU0UwRkhjdnlxQklU?=
 =?iso-2022-jp?B?WUY0QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?U09XQXgrUDc2QitxaHlETWVxaFJjZU1CSW9xRG5qZUtnbS9hcTVTVTVS?=
 =?iso-2022-jp?B?SUl5Z21uVlRIaFJSb1VPbTJjNW9lUytrUVVVdjd2ak41b09nKzkwd3J3?=
 =?iso-2022-jp?B?Mnh5OXJrd284WHQ3cjRZdmo0c2lTQlp5c3R3RHRDbmIvVGwrcmxOYUxm?=
 =?iso-2022-jp?B?U1pGOEFsQkNlWFJFZ21uWlFRZVdPRm5KUTBYaFRQYXZMUTNXVnBMbVpm?=
 =?iso-2022-jp?B?eVVvV210bm9kckIxc000YUV0Wk1MQ0QxcThQUHpOd0lqMUpDMmc0Q0FY?=
 =?iso-2022-jp?B?K1lwYUZncWtrbWs1WFdJSSswWHJIaUxXVUdHQUw4RDNGNHJ2eUYwZTdM?=
 =?iso-2022-jp?B?eTRjMCt5cUkxN2pJRU1oOFJZbnh6SkVLNjhJTUUzYjRXY3JkS1MxbUdZ?=
 =?iso-2022-jp?B?TC9Xc21xMEV2cVdWY0dhOXhQcHNaZ3IyWFZmOEJBYTA0TnkyT21wMDVU?=
 =?iso-2022-jp?B?RS9idHFLemxUa3g1ZktQYXU0MEhKN3VKRGFjRFQ4MDRtbjEyaVRLUmRI?=
 =?iso-2022-jp?B?dVpKWEFpMzNXL0VKQWg2V2I0dzFVb2V5QWFEZnRpUU56QVRuK3Vheitk?=
 =?iso-2022-jp?B?dUlpaGFwRjVYT2VLblV4MS9LM3YrN2RUbWRLVUo2c0ZxZkZORk52NWZx?=
 =?iso-2022-jp?B?dzA2WUlyZnJzOWIwVi9SeVh0cThlQ01aL1BBNlc3dDJyOFJBUVV5L29Y?=
 =?iso-2022-jp?B?U0VQMjkvUDBBOWtnelhOeEEwZUlYbjR0R1M0VmtOUFE2UnpVaVhPTkhy?=
 =?iso-2022-jp?B?ZVhGMmxSbUtDUFZvRTBTMUVNR2VmNkZOSHRtdjVQblVnYUtkU1U1TGEy?=
 =?iso-2022-jp?B?V0g1QjJDMHEzSU55OXJTaDNxUTZUTE5EblhMcmkyTFQxOUZjS0M0d2hm?=
 =?iso-2022-jp?B?ZlZrdTM2MjEvY09PRFFBdFhwVk1LUlFUUzBjYlhlRlI1bVEwLzVKaVJ0?=
 =?iso-2022-jp?B?TUJaL1loZExLUnB4MnFrcnQwcGRNbXZiZEZxQzMydXppakR6ZG9IMmJy?=
 =?iso-2022-jp?B?TmN0cWVYQTJLeU5GbFc4NGNHUGNGNWpqeFV4enFmMCtGZS90RDFuR1FT?=
 =?iso-2022-jp?B?ZUp1ekF6U29ESHZvUk1zMkU1dTliVkcwMDFPbmNXL2RKZnhGamNod0E5?=
 =?iso-2022-jp?B?b0t5cXQrVFdsT09DelU1L1NxL1FYMGRiQ3NjcnF0ZnFhSHFoMlFjd2Z2?=
 =?iso-2022-jp?B?SGdzN1Q2NEFKVUxHMWZwbFZFckZhdHdkc0RSNUdrOVdXeE1HYXRlejVj?=
 =?iso-2022-jp?B?UnZXZHY4Ujdkdmc1enRNbmhlbG90eTNlN2M1dU9QNEhNYS9QeXowZnpN?=
 =?iso-2022-jp?B?d3lKVzFITU9FbXdpMzl5Q1ZySytqMUZoeXhXWkFaWFdDMGdKQWpMUjhV?=
 =?iso-2022-jp?B?UVZmSmVxNDczc202ZXM4dDYvYWlXenVYemFDRTIwTitJZDVYNElNdk52?=
 =?iso-2022-jp?B?WDZLdnRKZjN4T1FmU3JIc0xqcDBObitmMHBRRkFQOTRRWEYycUcxWjB2?=
 =?iso-2022-jp?B?Syt1TVRrdUFoU3RHMitEWGk1UFR4aXhsTEJUMU5lcDZyQyt6NVhZbmdy?=
 =?iso-2022-jp?B?N2VheTZ4TTJZVFBqZ25NbDl2azB6cDNJSzZNOFJldHc4aWJqSHJJT3Z3?=
 =?iso-2022-jp?B?dUJyQlB0WlVVTW1tUmZoOFpQQWlNMXBsWkJTMGNZZ1IxVlpaK2JQbHBu?=
 =?iso-2022-jp?B?dWhzbThzaU1NdjVwUjBMVnNPSHNqWitqNWNPamxNT2lNQTk4SHMvbVll?=
 =?iso-2022-jp?B?ZnF0T05SZ0gyT0VKTSttekxxVXhJT1hPcWtpMUI0d3crNFVWTGZJMXRk?=
 =?iso-2022-jp?B?b3gyTUY4TkRPV00raHI4bXBmaDRoQ0hnR2JodDRWdEFIQmw4VUpHVVE3?=
 =?iso-2022-jp?B?MUxQMmdGcTNnS2VtOHlCTTNBZkFaVDRiWElENHlJOVdRZEc4MlhTeG5o?=
 =?iso-2022-jp?B?cmZuTWpuMmtMbERValFubmVid1JraXVrM1BBTm1mUmZQQnd3aWtEcEV2?=
 =?iso-2022-jp?B?V3ZRODJxeXdaWmdJQ3kwS2kzWHBzc3ovRWc5SzIza0trTlR4UWl6d3dG?=
 =?iso-2022-jp?B?T3dVT0U5UUxDdXRlWnNoRzZmLytURThiaEZ4WjlDQnZIWEJtcnNlMjFy?=
 =?iso-2022-jp?B?aXJsdEFwY2xhYVpwZ1lrRjZrdTJmRHh6cnpXeEFOWjNWRE0rU1pSbDhN?=
 =?iso-2022-jp?B?U1h5MHl4SFV4UU1GV3dacG1jbVR3cUFGanNGd3FJS2h6cmFlRFdSaWJC?=
 =?iso-2022-jp?B?NVV0akhIZHVpTnl4NS9IdGFMSVM5eW9rb1p5WW9rc05Fem1CUlpDSWQ5?=
 =?iso-2022-jp?B?eGhvY21ha0o5UFZDM2RmZm5Db24zOS8vRkE9PQ==?=
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
	RC0+b3ldVs/+hEI8Ju98n+39CUv9Ckbytiri1wNi4etJqef7TS1GliyGqo6qKAOgjQC3oLD9eZoNJy664Vjipd3Fe3+/JTE0NMYRMzz+JN2riiZcY40GJiWHozQLBJynCcK4SaROlzi/b67IBhM+Hk0276gF5a/bhXdo03zQ4tY/sMTsUP/aDWMqFyLezu+sjNJEDz5K3N7ldgC4f4miTvt8dCvLKo1GZSlKREOehAi51SV6AsWyFgO7KiSI8re02hPcWZARCo58WhsZPatOXz7gOg7Ru1wrTRhzewfKpUe2thk6mi+tcuqEu8ECpOOli1CJOeV2B0DszcVD2NJMuHp6ir6n+eqJn53C7iKH3q+38LkRYlJaC40G5TOdRae+Z+JRO1ArlthANjh9sn2it4gFfDt7mcPxGtT/GKGN+/sKMW7k/4ptSCvdbhRmAsjVJLszyHlK5W8XfcYtDwkd4L0bAVMlsuYL3PvSc4UIAZfrLeyJniy1ThO6PL7qrQlZKWaEAVY0gEQsKdwIJ7qOBXlNVzTvpZ2D57mvgRRJSDFhPZMVXNwPRhZIrFT8ue+NagvaedLczA4gT1WNdPGdu+LnlpWOEDrdukFax4Af1XrwPyKKC0qL9OP5i1Qhm1HH
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d020ae0-12bf-4472-aadb-08de16b928d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 07:02:44.3150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFtg9f/o5fKBjpKEift8YJ5Dec9cX/5HMOkbp2WBXihbG4dFa75Fj9eghKOfC08OPUNzEYAP60I2CKGN7bRml5gHlnh9JOMm6VUtC5/M0go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7361

> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever si=
gnalled,
> attempt to disable MPAM.
>=20
> Only the irq handler accesses the MPAMF_ESR register, so no locking is
> needed. The work to disable MPAM after an error needs to happen at proces=
s
> context as it takes mutex. It also unregisters the interrupts, meaning it=
 can't be
> done from the threaded part of a threaded interrupt.
> Instead, mpam_disable() gets scheduled.
>=20
> Enabling the IRQs in the MSC may involve cross calling to a CPU that can
> access the MSC.
>=20
> Once the IRQ is requested, the mpam_disable() path can be called
> asynchronously, which will walk structures sized by max_partid. Ensure th=
is
> size is fixed before the interrupt is requested.
>=20
> CC: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

