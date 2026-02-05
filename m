Return-Path: <linux-acpi+bounces-20873-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Z8MsJm8UhWkh8QMAu9opvQ
	(envelope-from <linux-acpi+bounces-20873-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 23:06:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F47F7EF1
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 23:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6F443004067
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411F32FA17;
	Thu,  5 Feb 2026 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qq2y+pzD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011030.outbound.protection.outlook.com [52.103.32.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41A31AA8E;
	Thu,  5 Feb 2026 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329193; cv=fail; b=Q/kszN6zOZ4yijXKpqYCKq/6mcFbHO34Fb1VKgUy3RfZsUWEYbdOKmoQ9d9o/2rwW9B4h+w+FHg5rlI2v0au8K5TrPELTbgZERCWGKeVi3EAxZuYnfBI62CWOu/ONSVJHUtOjq7dB4NgKIv3o0DDJkZ/3EpuJrc+40YYqJbDlws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329193; c=relaxed/simple;
	bh=d84A7ZfqDT+RVg1UZBksysJPoGn6HgmPuF2svyI1RhA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DgCfGoPhKV04iNWIa5SAWDl/Sqjh9Ayqi18M5SWaW9Kd2Rkak6LxqpnuyMhZjnsJogD2A4TGZZeNkYLY7ottUZmt9a2ZjyZm9TivX2ooAUlYuLZe/7+gQF9xYwVXE6TAorOUo23LveuxO03yV2CQIQ/6reTOh04Ff4wKshx1doA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qq2y+pzD; arc=fail smtp.client-ip=52.103.32.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gs1MtYmpt4NVh5/XE2SOpI41AY2ON2GYUASQpgjekB5Iiubnlf7HZi8Z2Uv7dpFFoRnG5MYVUnxhoBSZHZfxUXjQMyDaVs4IjBJSbf2cJCwjyBTCBaZuBJCGXzBK/1gl9cxlF8O0xHh7/8EbEljepbdegEftcfzJeY0NXch3Kl8HcuF+EO2sGi6yM02khKyCzpFBOdF/aey+AR574N2ezaqoq+DQmMYh1RdNntZp0F0xcZXH6KyQy9frzatKnfiQxV5sYI/IHB0n5LPhxYicvwIAxl16T26m3+ncFQ4nB3KQkTjNJHgrlev6HQmqE+TKFYP0teJph3MUGMn1jyMmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMN0zrR3o8Qs8e+WeXvV9TTqS5TlaMbUDmwj4mbMfdU=;
 b=yD/p343Xgxncjxtj1lQQA0HxiVvDlVDzgAUeXdMYGSX811jP2ynY8sFNKtZXu1MHmeoF0uOpAaRrixnm7pwJ0IzYzbRPj7D6meErSS04ekjL6aggQNkigZdU5A2ddZoFZpC5bKRYzBNUGIb+QcL8gHrag+V9rqzgV6wIOaFz2mIDAmzuU7FrJKdpnGggcCUdnXfuVqs8rnOumlu77aj+GMZ7yXKrHBahWU2lyp8CGBWu4nALuXFXwVusFhYSH1/t6x/PvFN8ecrsM1ZOoY6xLfN4xE8HqMHcTfdTjhbtrk9291IV7Va3bPriRzOLwF16AVrxampM/60a1vRH3806Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMN0zrR3o8Qs8e+WeXvV9TTqS5TlaMbUDmwj4mbMfdU=;
 b=Qq2y+pzDKwhwaPNcovZOo70txGKUEQMyfk2Y81cjjZSdxWMoipEbisyAn4EtqXs6jdTJ0WXZrDjS2te5CCHJn1yUkdB69oPYxz1DgMlmioalDxdb6l1dQmbSLwnG6qskypyIiimc1GWY74vvHoVfM3Amfcz+9BW/t7kOomjVc0SdagUfae4loRayN2o972/E3Yl9fBXaT7IERtbDmu03g9shLMSuEhzvnEBv5j4vr3bwg751Y6cDZhOwW+E5SkpKMhuEtdT1IPwjzXAbceQNiwEtXE3C9ToGjCAiupqKhMDpFIa32lYAOXA9ZPV9U0p6YfXxj6HNQoUN8+MhIk92KQ==
Received: from GV2PPF3CD5B63CC.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:158:401::b50) by PRAP251MB0420.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:279::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 22:06:30 +0000
Received: from GV2PPF3CD5B63CC.EURP251.PROD.OUTLOOK.COM
 ([fe80::4b7a:2c31:c2ad:b636]) by GV2PPF3CD5B63CC.EURP251.PROD.OUTLOOK.COM
 ([fe80::4b7a:2c31:c2ad:b636%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 22:06:26 +0000
From: Piotr Mazek <pmazek@outlook.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr <pmazek@outlook.com>
Subject: [PATCH] ACPI: save NVS memory for Lenovo G70-35
Date: Thu,  5 Feb 2026 23:05:02 +0100
Message-ID:
 <GV2PPF3CD5B63CC2442EE3F76F8443EAD90D499A@GV2PPF3CD5B63CC.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::23) To GV2PPF3CD5B63CC.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:158:401::b50)
X-Microsoft-Original-Message-ID: <20260205220502.65152-1-pmazek@outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF3CD5B63CC:EE_|PRAP251MB0420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c216eb5-929c-4f16-8f80-08de6502ce9a
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0gmpihVO5n1r98+fn/znu5pntpyIXN+oCzDpuZiZRT3zijNT5ImGeTJvk/oUgUB+KiK4sLhE4876Jw6gOJTAuQgm6SHYKqzbEWpBx5GrSoTDnUXqLb6DT/NDC1Ubg+ZAXB8x2aqyWHKpRIhhxsa/trOJEznoOM+aBDTfbwkPmMvv30MELUIA0leZxIC8YomqJ0JAzV2ejfX9c/HNIfpsRywc5wjQzoDMb2MXuoFQgUvlHnyBrKqhrY9zgkuNAMLA0QW9cA07hGF+50kAReiLC4mif9Jni3QUpeV4aI3zlOBTtg/r0bwzGl6tWUtDnwBENfpn5tdG+gGwI4cFTkW/ouH7QkQS8pxmwDyvuT8n76VqBKru1U5ExkG4RLAvWep0o4EY16tSEDtyKox8GBOktqXi9lip7y3qO9zXu67pxFd879IZsK+6toeFyWuew0ugah1pZtL/32LTciqyjc/RmFYmCpN5LLedceOJT1l+NDWU8Ro1IUdNgcr5ZKkFYUGJcUFGzwWP0ssFzTgtEGxAV8tw8mW2SGIUuM4VReatFpmpipCb+ZgVbokGApEfQ6AB/I7tp3XV3hgI5Uk2BRpr3lEC+Da/riAk23dv5yDlYigGaiQd3NOgzk2ZkCfyAG/pfVRxTSY21uJuSEjtF2UbupqEXaVok2jtq/QWcIhpRDKKEbVYYkkMGafgybaYUzZlbEypkD8sYfCdYDmoqTSslfuZ3G2MQdYzRSJ+FePVUvYA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799012|5072599009|5062599005|8060799015|23021999003|39105399006|19110799012|440099028|3412199025|40105399003|12091999003|30101999003|11031999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FyKXiWcl/cnlmbzJGpDCLHs4xv6gWw1hQ6/8WmQgppzFfIssYUohBwWGfRe3?=
 =?us-ascii?Q?Hsc3spi7wzqshRlbxpjpMvJCfmWKKVW52cIcfnWUz555uzZErk3JuoxQX9Rs?=
 =?us-ascii?Q?mPAiTbTkUYTEIgHxdhfzIyV3chTMnQweNPlecAjcVoGFBPZlQJyZ3a+8YJsN?=
 =?us-ascii?Q?Eo9ZG1iNqd0kJj9z+G9uZIDYibjkap8GxehZmyv0o+AuF9SxBZIL1YmOyO4n?=
 =?us-ascii?Q?esAOWR0MBDPEarmtGBR29ppD/1iLiTmYFxyOZfUE+7yrI7KEm8+MEtLZkVD5?=
 =?us-ascii?Q?UOoD1cdKClBeValycmWAw73xfhSCd8z23AgIOMcDcDrjAKTN75A8GiMHH6cm?=
 =?us-ascii?Q?t5ctW15L5Z/LaRhOQXSA5pM6SCrUCAer86d+lW3CJvICpg3JugW51Vw423a1?=
 =?us-ascii?Q?npSMXLqHPOHjbfGwG0xLPkABEthXqFEtKn1EqqIF+Kgyq6y54zInQudzjcMx?=
 =?us-ascii?Q?100vEl+ehah9CH5anW2nM8O44Bk5VDkq6XR1w84yVRx7KriEqDI9NS/VGlSs?=
 =?us-ascii?Q?yQ4LJuJHpergjzH3is8Ugd9lpsv0BE59HHi+tNlDR3zyt85mEmHw6urCldOu?=
 =?us-ascii?Q?TXg7wY2jqLK7PhDUyq8NyVhQGySVVRYd99VBMPW3YU1KkO9xXfnvSnKqkftO?=
 =?us-ascii?Q?MEp8S8cQ9fQDnPYbeANLfHw9WJoCbep4HCkScC6ujg/0Mz+FYogozPlh/1cY?=
 =?us-ascii?Q?3zy2ol7JtJyFDe6sDwfAeI6E8ZKyn+M02eE6mHBlJYdy3IjwsKEbfRq6OlLJ?=
 =?us-ascii?Q?FxKfss85sEleQ0lxmgBFHrd5siYQ6A5eUnIObzWf/qWinYwfnukx8F1hOuB7?=
 =?us-ascii?Q?JTwHPwipdwYbMON5gtHZRYiB+x9NR6JCThJB/QmTE8L8Ade2E9FmyRIxX+56?=
 =?us-ascii?Q?M7Neb3oLpOuo0NtN20bRPZZ2S8FderVybyoJBRBsDFiPjBr4f0wQ9f+Jsx8T?=
 =?us-ascii?Q?ppB5r+FflPuobajIzbACC4kC1FEXdcbyoEvZJiM2aIDhb25VsOlxm8pTXjEQ?=
 =?us-ascii?Q?66mUYP6o/9Zyw/Apd91B9kaFcFLsfBAJNtsw85I/+Bo0gv1DQiSEAn/l+npD?=
 =?us-ascii?Q?IgGz8rpNj8cWUe/kbIq7ooq1peVQfv7CEVDYM+YHG3E4mRyx/L4y/UWzubA0?=
 =?us-ascii?Q?33HtFQbH7Y+So/FGNn4ldZwHHnM0v+/DAtsbxC+jOHgfIYoKTJtWfdJtuycl?=
 =?us-ascii?Q?1ahMl4pLZkFW78Z1O7yZA37d/qfwSo8GynHqXiVuJLbd4JOQ4MjyO9Le9LCy?=
 =?us-ascii?Q?rrjvySQbOGJKi09fPrqQ7xfBEqqc4nK3s0I7WQSKuSAAl24uJock+uHp66ha?=
 =?us-ascii?Q?BODFbRU7EetbK4d3Am/cqstTZaj1W+zGaO7g70qPjzMF5A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8aXlxWi/BJSxCGgn9/A2YD8a2Exct2HIgsXd7U3vEUpXFddMbZLhOTr8uC26?=
 =?us-ascii?Q?pG2rfSuB3GgfTIDAJfLAE3puN/ASQtV2EG1L+7BtvOFPbYjwrpR9w7ZSOgUL?=
 =?us-ascii?Q?RumDS5HLfGXLf7h4SuzyyxXALQJZWlbYlfZOsvStb6jxfTdnJJFcO5MCWoOn?=
 =?us-ascii?Q?VafqvEVsx3jXdV1KRougJ3HQmslUsgeQYC5z87Bb2WsL95hyKE+f8DOKmX6S?=
 =?us-ascii?Q?s7KiNBhGhP1EPPCg3J/xLuxLXPWF+3lbBNwYCDErtWZnoZHzFNKaliXqnOex?=
 =?us-ascii?Q?VOaGkhJhXxB5oPWJOnt5VuZIGiQkTkn9lYKvXMZ800T8EQMyCpatIMXHNqh9?=
 =?us-ascii?Q?fmE2s7xhncIVLMDrnDCx2QFXMl6Bq9rU009fepeEgRoeDNOf3yyJekXQFFPS?=
 =?us-ascii?Q?l4RUokojEtx6Iqf8zQTmu7VvJeZLt3RpQJOvYcD9WVJe3eOJop7mHVfta25K?=
 =?us-ascii?Q?FcaIV+VAEdIDanPiq5aj5YRiEGCRyHQrkRYig+C7j9AZ2aTlE2stpIi3zRvj?=
 =?us-ascii?Q?kWAnOz6CCMNGHQwMa2Rip+9MUE3QygluZq1GzKxmt9YMfeky0M7KihMuzAU2?=
 =?us-ascii?Q?86z1s50zFslSdvBUbrrFWRD+bxJwPPJblXfeEC9yLeguZv/A9AWy1qJW0smW?=
 =?us-ascii?Q?UPv6KzAW5oiRHcebvMfpaP3WkXIjlZxFBELzLhV8HM85ozWnpBmC4nkSxDJp?=
 =?us-ascii?Q?bu6Q5Pf58bC39ngmHrV8iCl2bvcpysRgAuNGPVeslvSc6YeIt631cD58WViU?=
 =?us-ascii?Q?m9VjwO+3Hy+is6xrZXzxVAgKr3ddlEDCfLapzKO5Z7kiBceuErJq1kJBySgx?=
 =?us-ascii?Q?s4mA/KXX+9a1rnE809/53gb57KqVulBZ43DWLhcwveQU6TJhSLL6jUW7KvWX?=
 =?us-ascii?Q?bSoJdf/VkIrNK64pyOutNHqiNnNk9A1nFGSQYOFp/XrUi0pEUjrCLr/Tc3uz?=
 =?us-ascii?Q?wWTRCkeYOmABmW/WFjLE/2hhlzPQESd+11G1aqQl47FFdzkVAtdaSSkwvNRh?=
 =?us-ascii?Q?RgjCwPQ2WsT6kNxgpqkbB/OMhqJE8fxV6tHATlDHjY35sukxDtf/kSghvIm5?=
 =?us-ascii?Q?uAqOn2zFp9ZSx89hvldR2SR62eHV5PttHxQNRpYlS270HInJ9xMXSR+7N0nz?=
 =?us-ascii?Q?eIn2y2ADDdcIK3j87QpLThM3GS6Ed4xv1ie/El/o8D84DRvWD2haJwnUn2eH?=
 =?us-ascii?Q?DXeTVZ2y98hV9WwRqBx4Q3K3ZTk5KcbH2BdztNprhg9ng9i8K4ejf9qnO2At?=
 =?us-ascii?Q?gmb1GiU+PMzuPkgAY0neGLOuWGf17XuoHFvCyHkAvMbLpxyRKnPbrC81u++V?=
 =?us-ascii?Q?nIV4DdipimBcU8272up4ftie6ommEYCdso2HssjF8T37fbZ2ndVQTz9seySe?=
 =?us-ascii?Q?Y+aeoyCjqDVsVKBLQ2AYfT+8TKUu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c216eb5-929c-4f16-8f80-08de6502ce9a
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF3CD5B63CC.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:06:26.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP251MB0420
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-20873-lists,linux-acpi=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmazek@outlook.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99F47F7EF1
X-Rspamd-Action: no action

From: Piotr <pmazek@outlook.com>

[821d6f0359b0614792ab8e2fb93b503e25a65079] prevented machines
produced later than 2012 from saving NVS region to accelerate S3.

Despite being made after 2012, Lenovo G70-35 still needs
NVS memory saving during S3. A quirk is introduced for this platform.

Signed-off-by: Piotr Mazek <pmazek@outlook.com>
---
 drivers/acpi/sleep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 66ec81e306d4..132a9df98471 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -386,6 +386,14 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "80E1"),
 		},
 	},
+	{
+	.callback = init_nvs_save_s3,
+	.ident = "Lenovo G70-35",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "80Q5"),
+		},
+	},
 	/*
 	 * ThinkPad X1 Tablet(2016) cannot do suspend-to-idle using
 	 * the Low Power S0 Idle firmware interface (see
-- 
2.52.0


