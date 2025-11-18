Return-Path: <linux-acpi+bounces-19037-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B327DC6B2B2
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 19:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 600EA28E6E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 18:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0914A3587AB;
	Tue, 18 Nov 2025 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Uk0CPijJ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="JI4BRnRu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C12DA77F;
	Tue, 18 Nov 2025 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489814; cv=fail; b=hvsAFbsEbyDqQIsqDZssIVew/ZKgnxVOTzmLNVG37HuWeQvE/PXwFHZ12k2wPUlBtRy666z6nfxaA1LQHXD4q+lChRh9xe+bHYdoC5E2mINGctjCuBGX9NJUxcc09VGJIamSH+4BVnK1p/czloxdh0BHI2orelw+0iXwjw5zrYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489814; c=relaxed/simple;
	bh=FBJjSfirfgvXYjZZMVPqpmXrdd6rh4Jy1myUyq+u0Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKF2rUnStHfqnWL92POfMht6nKdzrQ1EchP08kakBwh2uDcRxWpKPm27iWJr0Squ+DM9AurdHNB1aHyLcEqwTZKtgymkD1gan8SPM1miVbAmqzEAwnRHN87KR1UBd6NX/L/bJeGRHOTeYhnIyrU3LHYOWiHCE217TY9NP6s2Exg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Uk0CPijJ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=JI4BRnRu; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI4n0QK4141806;
	Tue, 18 Nov 2025 12:16:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=QcXzAZIoEkOktALO/6cIqgax0Z8c504+Si4SoI22ZmI=; b=
	Uk0CPijJZ5ShCIXC73Om3LSbMO76oWebWoaZxnuY6XyQa4FAqKKo2aQCZ9XKC/uq
	cdieBPMVbLvqEg6F2SuB5e0ZH1+r5KgfprY/Nop+QELFWQjNPr/FZdfxQPJR1W72
	HwemrrrW0ZyYFVv0OaZzpIkCplnlWQbwN20I7jgpInPvN4u8rs9ZmAYfZ+Nm97yv
	VmYEfOv/G1mG6Nq2l04uGaa5gllxpBMV4M6p2FQssJrroaZWwCo/dvWqwgchNzJj
	XbRXymMakBUmIzCvRt2KdNWlXyvEsKlI3UeLXM0Q2+6M5ofy73/tqm/ojvxDdzVL
	cYBqflIEiLVpUGY1fAV9+g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023120.outbound.protection.outlook.com [40.93.196.120])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1buuc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 12:16:01 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGT3yRsXhLpcLfdIN9f2gk/VbnbXcZdH01PVAOSyYxkwpRnxcvn+Kq3+dCI5ERURiDrxz0EAz4K5w4kvQ2Nx9aQoisXaGNKd0j3ztuQ36lN7vs9zDMyvqAC7eH6xoS9g1k2HqHLex17/RS7zVoNUdYChHfkqOK9KCiZf57iSZhFOuzho4fgV51IxmE/M+xiGO2fd9Hq0M9FhlQ8C3Z3G0hiGweQaERCYTCJMHmOvPJOhirKPORJTPbaUe5XP71SymWjxyDd7bEo6HnjnQnCL92yDb9jewx76nEJ7u/BXLl2OPuCBuGN9Sy517FkCEAr1ILQRJftsSHb3SPUaH5CoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcXzAZIoEkOktALO/6cIqgax0Z8c504+Si4SoI22ZmI=;
 b=WxD8LnYNfCyyKWyjogegRnn8UZbZTs38ohCSS1NdMNUJAUB4Rrclk5CtR0Q8WPnSRp4URbW7UK0buAO09nZjStYoCp3caFPQH9WpJivkP4tCqj4Bmt1qG0Q2ikJqASlWwqDWQqJvF3xaPjZv9MPbnfkFfbWVeYM6BVlj8UNxwhIHGYJOR7f+SjManFs0fMG3rc/AOVTAikm+z+0EYNttVpSj/gOlUscKtwOWe6pZD8KYKUrHCaqYPqUmcs5Dd08DzOcuu5DpvZGn1Yw3h3eDeK7AueDYSSdsPQv7RoDar7BVPN2cFZj5S3XrGWHIZO2WJHMwTsg18TqRSGMnQBtniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcXzAZIoEkOktALO/6cIqgax0Z8c504+Si4SoI22ZmI=;
 b=JI4BRnRukKxe+uSLG9gahax4rTqwoC34fwYjvHllzB13sOvrIAoBsRbmS8Ya4Bjo7TKgiasz29tH8m8oBFqiK9wZrehLRCKb2UvXdE+tpBDaaDltL+VWckzMJq8mzd/obFIXk//DAge8Z+GpUhhbHmyHf4beFAffxmUuXcsKPas=
Received: from PH7PR17CA0011.namprd17.prod.outlook.com (2603:10b6:510:324::20)
 by CH4PR19MB8536.namprd19.prod.outlook.com (2603:10b6:610:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 18:15:53 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:510:324:cafe::a2) by PH7PR17CA0011.outlook.office365.com
 (2603:10b6:510:324::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 18:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.1
 via Frontend Transport; Tue, 18 Nov 2025 18:15:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id ED25E406547;
	Tue, 18 Nov 2025 18:15:50 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D4E70820257;
	Tue, 18 Nov 2025 18:15:50 +0000 (UTC)
Date: Tue, 18 Nov 2025 18:15:49 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as
 the key for GPIO lookup
Message-ID: <aRy31U8EQA1DO/R6@opensource.cirrus.com>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
 <aRyf7qDdHKABppP8@opensource.cirrus.com>
 <CAMRc=MfD7ZbwU4akkCJNgmRPwgSOqSVi2-L2dJDOBHrfdD-yZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfD7ZbwU4akkCJNgmRPwgSOqSVi2-L2dJDOBHrfdD-yZw@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|CH4PR19MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: b3655e16-21ec-41a7-72df-08de26ce826a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|61400799027|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUduOUR3RS9QTzR4cHFtejI1alFqRXliMGo4YjdqOXJ1L1NLSmkwcHBvVmhs?=
 =?utf-8?B?ZzFZZzYvcE90SUR1b2RTazdVSmM3WHRaNjVuUy83OFhkSFRwMEx0K2l5UUpj?=
 =?utf-8?B?Tmg3WE02aHRCYmxRZ0FCckE0S0xmcFhqQXNPVTlaTFZLaWovR2YybDZzeHd0?=
 =?utf-8?B?UnptblFEY00rME54amFZd2VUK3Zub1NQcXM5T25RL2wxbTZKQUo1MEhaTytF?=
 =?utf-8?B?RmpiZjM2QlJNYmRDSU9ESFJ6NUdmWkoyL1VpbDcrTXBsNXJsVmlLRkhydkNh?=
 =?utf-8?B?SXdmMU1PQnNFbEdDeWpoa044N1NPZUh2eGh2U0pzUm1HbTcycHM1K1NtdW9U?=
 =?utf-8?B?VzlmdlA3Mlo0cXRJZ1RoR0lHTDNhTEZsTDBmRjBmR055M29CL2x5YmlSWnc1?=
 =?utf-8?B?U2M4cnptbjJTOTdQbVJtOG84bnJ6MlBOSkJZQjBnUUZkZHJvK2JxTTZMamhY?=
 =?utf-8?B?Q3lZV0xlUnhEN0g1MDFITDdCbDhUNW9vdGdaa2F0NnQ1ZzQyempwcjlsaUJF?=
 =?utf-8?B?U1dLOWd5U2JPdmk5QjBGY2NyVDRtUERIZkN0S3AycGZGbVlQanJvb1lBaE5t?=
 =?utf-8?B?Z1pHbkl6ajI0MXY5OEx6c1J0bkIyOHhlcC90c1cvYXdyVis1RkpwWTNVZG1w?=
 =?utf-8?B?VzlvRExSS3pYa3VPK2lJZG10Mm9jOWpKTlM3N1BmMWNaN0IyQnBHMUhSelNR?=
 =?utf-8?B?NFZmUDVqcFZGNHZDbC9QMzQySXU4OVJTNW9qZ3RkSWEwVVpwdzhXK1RjQjA1?=
 =?utf-8?B?NUtDNTZZMjFHVmZsajJoYVdpUjRNRURCUnR5a0hhT2VwWnArWVRXYmZsRHNI?=
 =?utf-8?B?TlloSWdqaWZoS2lXTHQ3VHFvUGh3R1lxUDJEdWtVdjlrOHFmUDMyLzhpMnRG?=
 =?utf-8?B?cGticXR1QlJDcGJZVmtoQlNCUTgxa1krNDI2b2MvbzBpbGp5alU3NjhBZmRX?=
 =?utf-8?B?WFBaRDF0b3FlQ2N5UUhGT0lYNWFvNkk2ZkIyOXVKSVg1S1NZZEFPRXdVNG51?=
 =?utf-8?B?QnZHQy9QaFlOSmo4ODlDS2dDZkN4NWpMQ29GR2tRNXU1WnJEdmd4bjFJb05s?=
 =?utf-8?B?eUVJcVpJN1pvakpRUS83NVhKUktTYkdneHpwVG5TNGFDaHJPMytBMVdFQ1JJ?=
 =?utf-8?B?aHllU0lOK2FXZ2d4MXNQTXlWM2JCcUw2RmlsNWNCTnkvZXYxQlZyMUtMbW1R?=
 =?utf-8?B?UGlIT2RyOHVhVXJNU0hwWkRJNlRpY21pNnRXelZtMm9lbmsxM1lPRjUyc3ZW?=
 =?utf-8?B?OHpVb0pXY2ZFYmVvUE9RTTdLVi9VNmNnQkp2MGgwNU85NWNZZHZZd0o5b0w1?=
 =?utf-8?B?RCt6S1BBU1ZwNjB0eXlpSWF3enNDaGkwRUsxZkdacnhrWEg1aXhrTVRVdHBl?=
 =?utf-8?B?am0zdGZmVTZQMTRSNTRHbmQ5NmVPL242Ui8zOFJwTExjQnJDNGhoSnFmQVEx?=
 =?utf-8?B?dGR3WTR4OXJaZnNSOGJSY1dWUVk0a0V0Z05rQ2Z0Ri8vMkp0R0h0bnpPY0Q0?=
 =?utf-8?B?MlR0bW1SSSsrU2pjQWw3VGNlVWhWdENkOTl3Z0N4bnFBalIzSmUrVnhSY1l2?=
 =?utf-8?B?SXJJK2tpMlk3QmJwSEV3RllOQjdQZ2J4MXRzbVlrV2RJQkREVktPNGJQNmQ1?=
 =?utf-8?B?enRHOERrVXFheUFIdG8xLzBmNUNvakU2WDFMY0dXbXlPaktxemNpcHFTZHRE?=
 =?utf-8?B?TVB5RGlNdUpyYjVTOEVxR3puRCtkZ29BRUpINzFRVWFwV0ljRUZMNG01cXhS?=
 =?utf-8?B?Ukc0MVZ5cDlUbXRFK3lDTGRJVUsrVFdEY3hFaWd5QnpPZE5QNFNaN2UrdDdt?=
 =?utf-8?B?cWFIcGFyaFdwNkFRNXYxeHM5QjhueWJLdEtJd2NtRStnRmxQZnJ3YXBMNjRk?=
 =?utf-8?B?aDlGVHZzVHRWRWl2WmI1R1R0VDBGUy9DZnpKaDBLakhZZEJxVFlHbW5GdlFk?=
 =?utf-8?B?TjNSczZBNkMxNFNTMnh4UFA0dkpwYXhBdUNQdU5vZU1SaWRHa0x2VUEwN2sz?=
 =?utf-8?B?b1ByN2g5RzZqMnBmSzlqSEFKNXNQc3BiRS9JT3lrckpRMzdnNFNlenN3S0Nr?=
 =?utf-8?B?Ykd6SVRXL1JnN0JQRnk1R1JvR0FoajlNVnVvYkNZYkdzbDIvSU9hRzhzNzI4?=
 =?utf-8?Q?aafg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(61400799027)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:15:52.3088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3655e16-21ec-41a7-72df-08de26ce826a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR19MB8536
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691cb7e1 cx=c_pps
 a=obCHicajeL4Z6yanQ/wdqw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=KKAkSRfTAAAA:8
 a=c4C0Qp2SZ0XFrEDZea4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: mnsIWglV1EVJNFS_TgIdxLBAoJWbo9w9
X-Proofpoint-ORIG-GUID: mnsIWglV1EVJNFS_TgIdxLBAoJWbo9w9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDE0NiBTYWx0ZWRfX20PLrYdAUwrL
 z9BqROtwRhd6lVibN1stsS84g8Rs+Tm+SAYRWQUlPbbc1630RXvHdinihXudNQ7MUnZiR2tj4EC
 UKpxJ5i5N0iXHcM5Fk8qCJ0hp6zHJyAX5UxevEijWxRflFBlcCVIVnVPHrEV73AWbKoJnPr1xf8
 WjZqDJaUyPMxNSjXi0W8eOi6hfbxh39QFmRf5JVxb8eRrbckn4ezWoThurYrbDaL3sAzW5f9OF3
 NCOelccofIRMURS32qlgm3wGrZahbWbeSx42QTVBVxssQ3Km2SKhFRQKYP4rjUFwt34nu7G8ria
 AUYjUNW2r7ZB1Xh31V+tMbwtJE4Avye3yaANaTJjsAHCb87jGb5z9IhYmC7cPr7pXC9mxJy06Fs
 VmszRMsON1NVgP+ECmXrypcem5YEUg==
X-Proofpoint-Spam-Reason: safe

On Tue, Nov 18, 2025 at 07:01:24PM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 18, 2025 at 5:34 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > On Mon, Nov 03, 2025 at 10:35:24AM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Looking up a GPIO controller by label that is the name of the software
> > > node is wonky at best - the GPIO controller driver is free to set
> > > a different label than the name of its firmware node. We're already being
> > > passed a firmware node handle attached to the GPIO device to
> > > swnode_get_gpio_device() so use it instead for a more precise lookup.
> > >
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  drivers/gpio/gpiolib-swnode.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
> > > index f21dbc28cf2c8c2d06d034b7c89d302cc52bb9b5..e3806db1c0e077d76fcc71a50ca40bbf6872ca40 100644
> > > --- a/drivers/gpio/gpiolib-swnode.c
> > > +++ b/drivers/gpio/gpiolib-swnode.c
> > > @@ -41,7 +41,7 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
> > >           !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
> > >               return ERR_PTR(-ENOENT);
> > >
> > > -     gdev = gpio_device_find_by_label(gdev_node->name);
> > > +     gdev = gpio_device_find_by_fwnode(fwnode);
> > >       return gdev ?: ERR_PTR(-EPROBE_DEFER);
> > >  }
> >
> > One small problem is this does break drivers/spi/spi-cs42l43.c.
> 
> I'd say it's a big problem. :)
> 
> > That driver has to register some swnodes to specify some GPIO
> > chip selects due to some squiffy ACPI from Windows land. Currently
> > it relies on the sw node being called cs42l43-pinctrl to match
> > the driver.
> >
> 
> What is the problem exactly? The "cs42l43-pinctrl" swnode is
> associated with a GPIO device I suppose? Does it not find it? I'd need
> some more information in order to figure out a way to fix it.

Yeah doesn't find the GPIO device. Apologies the background is
fairly lenghty here but to give a high level summary. The cs42l43
is an audio CODEC but it has a SPI controller on it, in some
configurations there are a couple of speaker amps connected to
this SPI controller. For Window reasons this SPI controller isn't
properly represented in ACPI, so we have to depend on a couple
magic properties and then use software nodes to register the
speaker amps. However, as part of this we need to register a
cs-gpios property for the chip selects used by the amps.

This chip select gpios property is where the problem happens, we
need to refer to the gpio/pinctrl driver of the cs42l43, but
software nodes only seem to allow referring to other software
nodes. Previously this worked as we gave the node the same name
as the real driver, which meant it found the real driver.
However, after switching to look up by fwnode, it is looking for
a gpio controller attached to the software node.

static const struct software_node cs42l43_gpiochip_swnode = {
	/* Previously matched the driver name for the pinctrl driver */
	.name	=  "cs42l43-pinctrl",
};

static const struct software_node_ref_args cs42l43_cs_refs[] = {
	/* This needs to point to the genuine pinctrl driver? */
	SOFTWARE_NODE_REFERENCE(&cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
	/* This is a mark that indicates the native chip select is used*/
	SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
};

The bit that is unclear to me is how we get that software node
property to point to the real pinctrl driver rather than the
dummy software node. I think maybe we need to add a SW node as a
secondary node on the pinctrl driver itself and link to that?

Also happy from my side to spend some time working on this as I
am not convinced what the driver is doing now is totally legit.

Thanks,
Charles

