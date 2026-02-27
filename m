Return-Path: <linux-acpi+bounces-21235-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDfCBDrCoWkVwQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21235-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 17:11:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 247271BA97E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D1E3307736E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D9D44A739;
	Fri, 27 Feb 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TwFJQZiX";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="vxEQek9D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3144B66C;
	Fri, 27 Feb 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207909; cv=fail; b=nLUvRIR6fP7d1o0FBRaffLGB2AGrkYmMahuNmNP8BgReLJl/fGTd990ZIM+ZiYbf4A4W/los8TRZTcAHeBjZUI6hjxRnhGUWrQ868va7ZiwNwGihDcO6HjUprhmTxG1eE1r2YKhhAZSV470lH9FBqLSOQoDu7IEpSb4040qAV/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207909; c=relaxed/simple;
	bh=9zIaW5GrNYt1FwC1JeVTx+E+Uz24gYWP4WaCfjF8L18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4YilRMVhg/9A9l0b/pQnpMfa606o3RcDA/DgbvUdpF8Ma8nHJ4JEJNGtreuYjOgf2smUFyc0uAImuqmGeJrEHY/arfaEnyF/U7/HGCPCn3Yotpxdiv34VA5i+cuQeYxw841TQ0iwyUrMezYE2aGNpmVnbvu/imGVHpLR8H4cAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TwFJQZiX; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=vxEQek9D; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R4os9D2367068;
	Fri, 27 Feb 2026 09:58:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=h8cdWiTQowG9Wtj13i
	cgNjTqPC1+CjUUXuQxcNaliy4=; b=TwFJQZiXdXrSPjkpNm4tX3rKqMZ3mwdGCS
	gL2AnfVXSybAdkDcl4Ah9m+VcVzvv5C+9GeOgKF2Y97l+52ZCoU5IjMHcRHaOCyZ
	fEq5lmneai5V8egsjB9EVLrzDPdOSf+kloP/jplksvMiCjBPeB2ml6YEnGjJdbqd
	/0wgJcagKreB7Z5bG+eXdv6EZz6GfAAUzbRg9KcWVntb1NW+MlTBV3DyjZcKrF6Q
	bTw8UDUW/B/0aclzaaznzUDXNzyqHzE5RFvLMU1CggVXGtAC0iTKf1k2yE+6WG+M
	PxscbgdRaOt23oXsKHwWvMQX8Q4qGKmlNNf/vb3WsKXwWT/X3IsA==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020123.outbound.protection.outlook.com [52.101.61.123])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4cjmds1qep-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:58:23 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JftOqfTV+vdBtHpRt77hJV0shNu/oecctNNO8/qIBSD+fs0Yxz06wWrPQM1ovy8xn52tn/Fkhkk0bqadsg36ED5NQT9rfguKYJa6XqlmAx/j4S4IjAv7LxAnQJOoUD7sB2It3BaJhA7B5gx9l03PPNVf+ZjzQpQhNGSiBKW30qRUahoBKRuZK2kbt2w9wHRqpc47KbvacJ3SPiGl0Zjha4h+gRL0/V4PlHjIdxMLP9BXm1KEajH0ffL26w5E1eWWpBdlWySsE/6/Ivj6YcpxHYyhaFPLOchXxHUSkYqrP9mCDJUtIdZkKab9hTqYEFCHBfGGOGHYvFXLjQIYg6/8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8cdWiTQowG9Wtj13icgNjTqPC1+CjUUXuQxcNaliy4=;
 b=yeeA63PIE5DJKHVG1egwFxjPfqslB3qFvOs7jYtc0hd/iC9I2Z3Lp46ERDscuMXvHN/p0UczcOytYfse/zmZmtWoU7Tdr/+ybOfGxVQ05MKRBD30cit2PRFmT7CKTMrX5HdWggFv8bRwVAt4mnHNqFIbMFwOfVxrrzLE56tCzp/LOuvfZuexTsaT9WAYDf/OFfdSEd3YvUxnYoMDZCOH2IxWvSSsPetIhDnuvGGTQJ5D9cfO8t52w7NUgdbJd14KaSqfXy9MJtPKoQs5uqeWwqL3EOSiP7bL8xQoRotsj6a+p7wURd1MF0OY38GO720bjGQuUwYBKAu7UqIsY99/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=stgolabs.net
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8cdWiTQowG9Wtj13icgNjTqPC1+CjUUXuQxcNaliy4=;
 b=vxEQek9DGGx4P6FyYB4YJmYIHMTFJAm8eHDjpWpIYWdq821anGKyNniB5tsYUw1HN56jJWWPsRqy5dN67F4PaaK8JYiHM8QxndgOrnsOJdq0er2clBjbD3DBQUpOP5YTCzS7e6X52DNNW8VetMXk0QEikYjtpzVvHffBcY12GN0=
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by BLAPR19MB4466.namprd19.prod.outlook.com (2603:10b6:208:299::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 15:58:19 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::86) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Fri,
 27 Feb 2026 15:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Fri, 27 Feb 2026 15:58:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id AB1BC406541;
	Fri, 27 Feb 2026 15:58:16 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8E61682024B;
	Fri, 27 Feb 2026 15:58:16 +0000 (UTC)
Date: Fri, 27 Feb 2026 15:58:15 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kalle Niemi <kaleposti@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>,
        Saravana Kannan <saravanak@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Linus Walleij <linusw@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 09/28] pinctrl: cs42l43: Use fw_devlink_set_device()
Message-ID: <aaG/F3JKIpsefS5f@opensource.cirrus.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
 <20260227135428.783983-10-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227135428.783983-10-herve.codina@bootlin.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|BLAPR19MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 1048c8dd-3d67-45bc-46b8-08de76190680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|61400799027|36860700013|82310400026|54012099003;
X-Microsoft-Antispam-Message-Info:
	KqTRJQ7H2aPhnSK38lLqGtxxHhOUh406CiKOo63Ta4T9BC2Q8m6k2EkRFfiSW8o4OWFAv4OJNjsSXzp2ikTh5GNTrCxcyGTEB0h242oWBBDyaTXDrirExCGzfZ/5QGSJRYOOkHeb10hz9nDnYTBwyBtJ2BWqISV3eGO3CO0XdhWFvSGCjIrmB6glSrJyrTJ6v/R+pPOuwbdEJfx26y2eY98akJXPYIH2QJS8F6G+HjGidRxvnFlbwKzfDyO3QgVVD2+vJxq11XxrmpE04KluC/XOxIY5GIbuC/s/QGpQ2XnmY/0deFA3PWYFP9g4v65vHMUhHvzdvfLFDIK5bA6aHYqrFTuKOUR7Sb048hntRpwEZXO5v/A17ybdRr0m5RdgIE2eLaS1s/hI37U4yXLwxosX+l6SB67R6eaen7G+iB4WkAQQ+/EpiogxEC+9Qgn9yxfda5cqH//31RS+wBZ7FNjM3m2shc9bnyw7LUbjVNz5oWhCpGUD+ShMorjoytQ09fvhWdq/OZd8dN2YHGACVt3f225YMqkVoi+duDT6sm5pTxu1/r6nJ0K/258k96ppFNgjXbFR2JgKD6E0KI5N6APDDhgQbXiAjVOH68ax9iIbLkJwqdcJ3PJup3kbuVBj04D4CNTvo9Ce/nBeyu3OXoyf0tHhouL2VfBIZyhGtzS2YLAifdagk92gh38iuAzaicppy2avk5ouSDhEWispZkjLxeEkurqzdOcag0iK71CKQRkChq8vVMEvQXHRuaiAWzdP5pTEJ7CRHuaPhNreBr+YfArB9EPIm0tJIrB0ZUYteyBAdWbYJSfzps2IEfnOlqL6ESHCt1CjLApjQpefVQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(61400799027)(36860700013)(82310400026)(54012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qIv2880b4PziF90kXI4TPyyFDV3tPqhooEDvHel4ULVhZ2Je/a+FozWykUiGyzWKCSX3wxJXlwVQQHvCa96is18BZppgRNqt2kJVdhQAxM0SbrxSlDWl0p7dlMzLax41uV8577cWLmVlb3sE1S/58zhkvI8BU/lxVTozM/gjyjfIUT8Xh7BI92eLmL6Nue0nHzN7TCJ3F0Krxsd7BjD+kGwHcnzG2RKyNWZv51KVt2RYZouXhPfRxC77A/JuMUOXstm8nZNTQQN/LSOzhMBcRsTr8dYag4WzconsTMo6I6hYvYcVCV4OAs8usqj9FhFu4WFfBnwSFFzT6VWB5QUcPJyCQi1JUtarzu52aEBVG5rQiGYBJj1AsBmolb2E6nI3hrJzIWy1zF4xehJwKIOtpr1sDkfIQ6pT+cLUfoD64YrQntmIl0pM5GI9HD53ei6E
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:58:18.5261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1048c8dd-3d67-45bc-46b8-08de76190680
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4466
X-Authority-Analysis: v=2.4 cv=dO2rWeZb c=1 sm=1 tr=0 ts=69a1bf1f cx=c_pps
 a=FbtOodId46Ol6SGOFNJvpw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8 a=nQlXo20cr35tWbDzT6YA:9
 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: KuKW_utk8Rmwdqs4O54vos19QWturA2o
X-Proofpoint-ORIG-GUID: KuKW_utk8Rmwdqs4O54vos19QWturA2o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0MiBTYWx0ZWRfX+R/yExiaOXbu
 LKD5evsq6QDwSsCu8HGulcnFa5ThrGyziPhtsZ2KS8oOSdWilpGIQBfJnM6KbTdAqpQRrsTVGPt
 LY/M/j5iZW05a8chJ1WzfQEagpibgAT4uYO12bA06TgYMpfpZNL4TARaDogsAtFaptdIi/mBsF4
 TqIdZwjJOtUr72YafA7nPItWBeE7h0JrkGtCwfk4KNGKvlckqoYL2J6EJvmu2laWurmzYcwQk8q
 Pn5ecsbhAXK1aFTX+5oGCHY3TCfImx6G+lHcb/RF4nSsn/mDPAid87Jmpf+ve+OBRHKX+LEfNI+
 aumcRMl0dqnJMIw5LzlDZuwd0q0T6+JCdFVmIbZyz4kiPDCtthBaz/Ph7FnKYmQDLhxK+H8DnEJ
 BUN7Y02VcoNJO70XehIGNm+ZYl9V2VQZbXSxdbQWInTTxh1fPc1skeaCikDEhmNj6qF9ykFh/zJ
 rvZI96rAaKzf6erQ2Pg==
X-Proofpoint-Spam-Reason: safe
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,huawei.com,intel.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com,bootlin.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,intel.com:email,cirrus.com:email,cirrus.com:dkim,cirrus4.onmicrosoft.com:dkim,opensource.cirrus.com:mid];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21235-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 247271BA97E
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:54:06PM +0100, Herve Codina wrote:
> The code set directly fwnode->dev field.
> 
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

