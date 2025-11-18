Return-Path: <linux-acpi+bounces-18996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C3C67CB1
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 07:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B5F8E2A092
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B342F360E;
	Tue, 18 Nov 2025 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IfpxIlqb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011038.outbound.protection.outlook.com [52.101.125.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4C299A8A;
	Tue, 18 Nov 2025 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448891; cv=fail; b=MT2UpM/XiIo6OMEy6E1F2aLUVe7M2jHjLF5M2I3CW+KDvapr2+iD8A34Z39JEJ4uZx1Zssz1wGL7uwAPoHlZXXpkOnvR8gVqA7bAAn49uUS61e+yqzoIvG8PXjOCVJaaSBRtjqw3aiwTM0PotVufYJdhGeCP6AD8RwyHffwUhBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448891; c=relaxed/simple;
	bh=PfbyS/hN97SaH8SUDZRhA1eXks6i5Y6lOvy0AuYjNYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqsZbYFvkQUgseNWfGYHagfPmPE1Nb5X65rMPwwpzEM1G+F1RJNfQkkfW96Hj6O9mE070nJ8FOMNnR2EDsS8bnx31H2CU+QLGg7IkOK1BQJ3mS4ZSUhXpOUjprOJVrTgydS+SIILNte9OSNOgdQ8LXWTsHwUgk4MzPbakW8Sgrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IfpxIlqb; arc=fail smtp.client-ip=52.101.125.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/oTYhWt9ACNG0i8IdKzUakvXU36bI0oj6zOy/tTL1H5qesBs+rsUZ/RyuD7RYF6o2PX1Ssdjzc+wx8YBqbgv5xqfXUYoGkwiOrrdBp4vxAHWqJ2zhMHeBkNC8+AuMGsLzJ98SRB3p34FzsdGumh9+l1J5lf53JS6p5BJSqC2NKjH7sPuPSCvwL6VtTNbrQmXh0Ho+3AK/O0/yaa3jWUsWntYLlEBP6iwMOQ+U/7jDmLwXdBzvG+UjVSjwihkjKlz0npDcPIV3fvRC0WgU/jU2mFYecVra+Cd9OBIwkqLsE8yXA3Y5BN9KfmWzn+RIPM7rXyV/27Sy/NscBpzG+1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfbyS/hN97SaH8SUDZRhA1eXks6i5Y6lOvy0AuYjNYc=;
 b=k/GS2kj/82GOizMENSqwjuYBPx/7xqL8V3g/qx4Yyt2zOk68kiIwOrxzSXBVwCNaPU+EWES7oc4yfQuJQL1IFLzX9UtRxO6DAB8IYH+x6KTW1IU/0bZu21Ox/lVDb082oPVJTf+fekKDAau/HlN3wXcdKElsRh8BAHD81S5yVd3ukO311HVkagHqNKpyDYduTOUKMU3RfLKHxIlFYQy8zTtu5o79/hbdMsS9uve8zfQwOvjkQyf7icN/2Vf6wPeIBPDJzLFHRPTyaN6xxKwWx2kRz1nmgk78gf/adyPD+HdZfb8rf1uwskLbJt80bOGrUId6yoT7u1KETtI1pubIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfbyS/hN97SaH8SUDZRhA1eXks6i5Y6lOvy0AuYjNYc=;
 b=IfpxIlqb/F+erTe/8ifvnpUb0qq89PYcijEGtm56JMs9EhKJD7bJaq6LZfywvG1uSgc+A++5WOXSMl+3XiRfVCdzkm7EyGWYgH7NTibHQVx692vBkSYIaS3an/lIs+N8z+2FXARcG0bI2WDS2b9aMbWnke7r5OFZQEDbo5S/zwSLEXq+YDCmBRbCAv6peTS8IxNeyYHoz433TO2RzvQ/xhwstrv7X8UI9UNtct48pntLmehKkq+1kw5CHQQudq3VhxSY5rWYsCMqYHA5lzUXPFF1gWF1ElofkRViiWuEgn/JAv3XNBgJGOH2aEl9IcycCfxdaCaj7Q2Ck5LCFv82Dw==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSCPR01MB14855.jpnprd01.prod.outlook.com (2603:1096:604:3ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 06:54:47 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 06:54:46 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Ben Horgan' <ben.horgan@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>
CC: "amitsinght@marvell.com" <amitsinght@marvell.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dakr@kernel.org"
	<dakr@kernel.org>, "dave.martin@arm.com" <dave.martin@arm.com>,
	"david@redhat.com" <david@redhat.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gshan@redhat.com"
	<gshan@redhat.com>, "guohanjun@huawei.com" <guohanjun@huawei.com>,
	"jeremy.linton@arm.com" <jeremy.linton@arm.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"kobak@nvidia.com" <kobak@nvidia.com>, "lcherian@marvell.com"
	<lcherian@marvell.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "peternewman@google.com" <peternewman@google.com>,
	"quic_jiles@quicinc.com" <quic_jiles@quicinc.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rohit.mathew@arm.com" <rohit.mathew@arm.com>, "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>, "sdonthineni@nvidia.com"
	<sdonthineni@nvidia.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"will@kernel.org" <will@kernel.org>, "xhao@linux.alibaba.com"
	<xhao@linux.alibaba.com>
Subject: RE: [PATCH v5 00/34] arm_mpam: Add basic mpam driver
Thread-Topic: [PATCH v5 00/34] arm_mpam: Add basic mpam driver
Thread-Index: AQHcV+Ow5QaSE8RtcUqdjxDlyPb0ZbT37YDg
Date: Tue, 18 Nov 2025 06:54:46 +0000
Message-ID:
 <OSZPR01MB8798F711D0471B6C56D345A68BD6A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
In-Reply-To: <20251117170014.4113754-1-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=ad676f4d-4fb2-4666-a493-573be579bdf0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-18T05:46:09Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSCPR01MB14855:EE_
x-ms-office365-filtering-correlation-id: ffbf70ee-3294-47a2-84d6-08de266f5c73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?alNBZmJLZ3ptVVVYempOL2QwajRGUnFrM0hNZS9HZUVXTHZYbTdROXY2?=
 =?iso-2022-jp?B?MTRlYW4xd2xsSVMvckdPODBVWUt6Z0NraTNxQTRYclZyOWtRMEFUSVhW?=
 =?iso-2022-jp?B?RDVQOW0vY2paYjFjbWdSQnRtN1Q4cFYxeWxZM2dCdk5sNHIwV3ZONGpZ?=
 =?iso-2022-jp?B?Sm9SNVlnSHN6eW13eE9NODRkSDg5WmFweXVKelVrWkFsS3YwalE3Rk5r?=
 =?iso-2022-jp?B?N2tZN1B5N0hwRzRVcTZXbUowTDFwdDlLYllBN28vbERNZk9sbHEwTDFa?=
 =?iso-2022-jp?B?UnFGOVdkVFlxeGRMZlF5RVFoWlVxd25RTHZmbnRhZHdiWDU5N1J5eVA1?=
 =?iso-2022-jp?B?dWxocE41R1BCWDJ4YkpWeEFMaXJiRCt3NU8yMkdINGZiMGJhcldudzFD?=
 =?iso-2022-jp?B?UHZWcTFEZ0s5dUU3ZTZZdkJQK3J1bUJGaFpmcHcxMmt1dDg5TzVTbE5L?=
 =?iso-2022-jp?B?dzZpRHRxclBjM21QTVphZS9Zd2NmeEpJaklBS0s0aUZqWS9oVVJQTEFw?=
 =?iso-2022-jp?B?emRpUFFtRXk1WFBEM2RVMnhrZWE5VGNqTDRHUE1MTWJtWjdRWVptZFBJ?=
 =?iso-2022-jp?B?TU1TZCt0cUQ2VzIxZmVKNFhJU2xyYWI4MnA5TmVaMjNLOHFHeGo5aUlF?=
 =?iso-2022-jp?B?ZlU0bjZSbWFXUmVMaEZKSFdJRGxBU3lzRS9Ga3owQWlmczJ5VmkxQndw?=
 =?iso-2022-jp?B?ejEwcFNVS3hUYkRhM3JwRG9tRW54a00rTDRpenhCa0VKSjh0eStqS3Fz?=
 =?iso-2022-jp?B?b0gwZGQwSFE5TWhkYVZkUS9hWExVa2RPYkxDRkxHMk56K2wvZUZnTWIw?=
 =?iso-2022-jp?B?dGhXL0ZMYmhzZU9LRDNEcldNekxzY2lrMWdOcVFFUGlXRnhpVmUrV2Fu?=
 =?iso-2022-jp?B?aWJYdGdsZEVrOEpQYW83WmNBUGhOM1FDOXk0WGhDeVhoWkVqUzlJL2NK?=
 =?iso-2022-jp?B?amxjUCtvZm9ZdGhXNVp5REpySjlWeHR0bnJLQ3FSaXZLbk81OVJVSHlR?=
 =?iso-2022-jp?B?RE1HMEU0cERuL2hBWm42M2RHUk9WQ0JIY1lSeDI5d0lJaGVlY2haODNn?=
 =?iso-2022-jp?B?cHdkMC9jS3VhRjVUVWVvSmtxUjZrOWJENHdXNGwwTEJoWEVUM2I0QlVz?=
 =?iso-2022-jp?B?UHYvUE90aEJvSWthY0c1L3QxZTgreDVLakpYYmE3bUh0ZUxyc1FRU3Rz?=
 =?iso-2022-jp?B?cFJoQjRxR0VWK1prdHdMTlpiYnJwZkNsSU0wL3RualRPTjQwY3ZpVFpr?=
 =?iso-2022-jp?B?c0hING1pcnEvaWxvRjJJVWVrVG1OaFhHdElJRjZGSU93VGNMUXJwYnZ5?=
 =?iso-2022-jp?B?NHJkSGZ4TTVpbE9iQ3lrSFBoTmMyWjhjaGs0K1NZQ0lhZjZCbXMvOW1F?=
 =?iso-2022-jp?B?SDZ6djBDM1BBQ2tmaHlnaG14aDQvcE02WStkbHRIaUNGTFZIR2ZaOHVM?=
 =?iso-2022-jp?B?YklJUGRZWEtSL0RJQldVVURtV2dDek4yZGphKzBtTEl5eUc4eXJvTnl2?=
 =?iso-2022-jp?B?TDd6S3hvSjNkcDFwdXZISzliVDhtQVpwL1JxV1NidThZWFBsQndpK2ZY?=
 =?iso-2022-jp?B?WklCTnhMQ1FsTmdWaUplTUd1VmtHVys5bnNpU0REdWJJUTNRdC9DRUNE?=
 =?iso-2022-jp?B?bzN0c3IwaVZpRzZlbXNWVTZodEhQT2h5YW5yRldEcVZ4UlFlUnlpbFRS?=
 =?iso-2022-jp?B?NHhRRS9pekd0OFdocmhaRUx4OVRjQk8rVjh0YkpnbmFnM2Iwbk9GdlhO?=
 =?iso-2022-jp?B?R1RPalZFVVM1QXRUcTdIeUNJdjgrZW1UQXhSNVZkM2xkN2o4RXQ3Tjls?=
 =?iso-2022-jp?B?R3ZNeVBNdDdYUm4vUDhLQnkvV2FkVlRZT2hOcTBWT3RuMzRxNjNZTmp1?=
 =?iso-2022-jp?B?Zk9yUVNqUERiS0w3UXVIM2RnQWZSdjc3a3l0SGJCRTZaN3NpclZhdncz?=
 =?iso-2022-jp?B?QytrWmhhYUxuWXB4b0I4Z2NrL05vYjVMdlhxc0pPK2RyV3c2L0JETTAx?=
 =?iso-2022-jp?B?Rk9HYXJBUE9wMWNIaUIvbzdxWVFmN2FEZkltWGd5S3NYOEZBT1BseFJo?=
 =?iso-2022-jp?B?WFo5ZUYyeTY1WWltQ3JlYU5GM1hSbGpIaVVYMU51VzZ5WkpGaTF1Zks4?=
 =?iso-2022-jp?B?MkZVVFhmYUcycDQ2alVUWjlnUDNrTS96ZENmT2VjOFVGdGFpK3FJUVps?=
 =?iso-2022-jp?B?QngyRVpIT0ZockNyejBQVU9maGRRSVZoQlFjSW9yZ1B6cTEzMVY2N2kz?=
 =?iso-2022-jp?B?Kzh3UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Z2oyU2JVZnRtV0gvY3MxV0UwcW41cVFsclYrcXErWXFxaGlPVEFoMlNJ?=
 =?iso-2022-jp?B?MlFzK0diRk1BNDUxMncyK2hncFBBSlRCc3E3bUxuWTNrUkdYci95Z3Bi?=
 =?iso-2022-jp?B?VDh3eFpTVHJNV3pwc3QyTGZyOEU2c1hIWTVWMEZWWVQ4em5FN3ViWjlW?=
 =?iso-2022-jp?B?ckRhTllGMDdocVZMbVNSMnFLN3dWZFh3SHhMcHBaU1k1bGgyVGJlZkhG?=
 =?iso-2022-jp?B?bFVBWTJlS3Jmc0QzUmVnK1hHNWZXUFNQK09WWE1KbWg5M1FUaDhiVXMw?=
 =?iso-2022-jp?B?SCswblVtSS95VFJRdkZ6SFh2SGZOb1k0dmE5b1R2eXl4R2RaU0N3S3Bw?=
 =?iso-2022-jp?B?NHpMNmhYajRuY1M1Q1l6Yy9hNDQvd0VBc0U1bENUanNPeE96SWU0TEtI?=
 =?iso-2022-jp?B?QlA4dFhNSnNSb0oxOWRteHI5U0dIeE5PU2QrcDVuRlovb0JocUpkRmFx?=
 =?iso-2022-jp?B?Y1kzZTBYZlljYVNBRjFnai9ORzhuUThBYjN2OUVSRW9pbGFxY21FVGYr?=
 =?iso-2022-jp?B?Y2VFcDdSVzNxUjFzQ3lDU1FPN2xDdDc0UklPNk1tL05pL2g2dHpWeDVF?=
 =?iso-2022-jp?B?VjFDODREcEowcE1tMytYMTZrcHFCbWFSa1VGUjFTbUFFYmRiREIvUnVn?=
 =?iso-2022-jp?B?aG9CTXAwUDhWRDlybWFTUjBpL3NSbzJSSzRlakhvS2VWcmZkWFBZSkJK?=
 =?iso-2022-jp?B?QWRJdDRWL2NTUm5hckNra0RaYUg1ZWtxMGhhZkNYNlFHOHo0VkYwdEJ3?=
 =?iso-2022-jp?B?Y3ZOU0FydWdQMlMrVWlmR2kxZVRaRFRqUGVGS0xoN2ppN2FHNjJhbGtX?=
 =?iso-2022-jp?B?M2RPcmdYTzBkQlBsQ2hpNDJRNlV4R0taeTIvaGNuaU1pMXlDMzlHTi9C?=
 =?iso-2022-jp?B?eGRyQVJDdDIwc2U4VHJSUDJJTEpscXFoTUs1amFoVnVpZm4vemVSNU8z?=
 =?iso-2022-jp?B?eEpha1g3RlFmUExNMzZBSUF5UFkzaWtldGk2TFNUeU9tZ1dHVUJLL2F6?=
 =?iso-2022-jp?B?Y0IwcmRaZTRyUmZjRXpKeVNRV1UvdHNCaWVHd0Z3YlltM2VVMHRXTmQ0?=
 =?iso-2022-jp?B?VGw4emFoTlliRFZvRVV6TFEwa1NCVTNzQWg1ek1JcjFhUldWN3JPRGhT?=
 =?iso-2022-jp?B?VUQ4Z01meWs0VGdIaVhFbVgvOCtaRjQ5MzN5aCtNdkgzUUdBNkpTL3Bh?=
 =?iso-2022-jp?B?eHhVVGpHN0l4TWQvVWgyY2hzMlhQMHBvZmJaYWRFcHRZWVE2MFFtcmp0?=
 =?iso-2022-jp?B?R1A2aFNJWXNBOVNYY0hBek40ZHZsSGJrWDYvN0pPeWJYNys4NklMUkhO?=
 =?iso-2022-jp?B?S3J0MHcvbnlkTis4aG5DK3p4OXIwSlEySmkyazI3WHVrU2UyVkdFcUVK?=
 =?iso-2022-jp?B?OURnelY4bDkvemFiY1Y5bi9yck1kUHJsZFZ2MUFVOGZ4eFJ1bE4reTgx?=
 =?iso-2022-jp?B?cHZmL0ZJUDN2dFllendRMlhiL3pGdVU4RVRUd0E5UDJkeW1QdXZ1Lysy?=
 =?iso-2022-jp?B?NC8zbGxuUlRMVWppZDlXbjBjeWhyM1RIbGM4Rk11bStiQjludnVrN1k3?=
 =?iso-2022-jp?B?cFRhNzg4UnR1eGlJUzgveXo2SjFNdTVhKzZzYkZnYkZHVk04TDhzaWpP?=
 =?iso-2022-jp?B?emoxQjhBblM3Qm01Mkx1SEtyUkE1OFFoSFF5emFXSGJiSVNjNFFwK1RM?=
 =?iso-2022-jp?B?dzhYQ3JNM2RqM1AyVVZ0dElNdnM5VTYyaGlzdWQ0bDNPd0RzRjcrbWpi?=
 =?iso-2022-jp?B?ZzN3bVNvVHBZVzBTODBtVWdJZ2ZGMi9kQjg4Rjh1dFFJUWFKVk5iSkdX?=
 =?iso-2022-jp?B?KzZVODJKKzgzLzZqdU5XMTBsUFcyMHJDM2w1RFJGY3BuNms3eElLL0RS?=
 =?iso-2022-jp?B?ZFVYL21lMUt0ZFYvbi83NlRNTUtLWGp1WG9yZnJZamFQdHB1VjVYRzVo?=
 =?iso-2022-jp?B?cTVuMW9XaUN1U3ljZFFwc09BcXJhRENWdTRseVhWYmYyZVpqRWNNTkhQ?=
 =?iso-2022-jp?B?dUZlREtPQWZhTFBaamRhd0s2MktURXNpTVQvUGw5U2RtNXhsZ3BrTXpx?=
 =?iso-2022-jp?B?U2VXK1hseE84SDNoNzJjR3pkckQ3UEtydmJ3NEdUdm1PWW1uNmh2WFBP?=
 =?iso-2022-jp?B?STVTdXd3QitRdGxNRW0yY3Vlc0ZNb1ZjYnI0QnllcFJIYWREdm9UczUy?=
 =?iso-2022-jp?B?ZnZvV0hjUFIxSU1QWHAyNkNQaG1lc3ExM2NZNEpVOXptR1FpYkJKTWNR?=
 =?iso-2022-jp?B?clB0M0ZzWWIybU9PQjJrV3Jtc3k3aTdtc0lxM2x2YjhDTzZMZ2o1QzhL?=
 =?iso-2022-jp?B?ai9WZEtVY2FlZzZNL1FhazZIK2gxNDJRMFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbf70ee-3294-47a2-84d6-08de266f5c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 06:54:46.7402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Qc5WPBI17txIQfRNfH5F+yMKhKG2QOlCWHNaTIo3NVmPUKKkiwq6b9yxZ3FP8LGCcuNDj1BTub/LtJj4Koz8V7mx1BK3/7lb/CcaIn4eQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14855

Hello Ben,

I tested driver v5 and mpam driver again. There is no problem.
This series looks fine to me.

Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>


