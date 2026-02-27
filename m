Return-Path: <linux-acpi+bounces-21234-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAHEGinAoWnPwAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21234-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 17:02:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E81BA798
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D81F3305BB93
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986184418C7;
	Fri, 27 Feb 2026 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FeIS72Yl";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="isxINe6B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC444105A;
	Fri, 27 Feb 2026 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207885; cv=fail; b=VepWaG26RN6d1EieVj8meeMyemOyXvt/F2QbAbUZt7Je5H7NtAH+pJWXuckMXH2t+/vQkDlL+77wwjllR22LCy7cAEtG8n6o8vIjL9Jy7Jfx8QUTkCUVeajk1LDzcdTVp3/qDaxdzRcL1yZqkoWgHxrm+Q5D7ivpG3IY63v4kks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207885; c=relaxed/simple;
	bh=KFF9usAye2tt33gnMIN51PKdPB69z1lkn8dajPOJldM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucb+3x8yuGcA/s9mbuznXr9DatTg9lrO+aB3je3cSE7K64YxG+UJH3j1rD6MKbagNPHVZkVYaMEB3tRzUSmQSrk922RNDIkYrfJNxfJaOH9Qy4BhH+iXQ7p+1Csf//FwuAnsqtFn61eDU5Srzrt1kLmUeUiT4Gfhii3C+Nx+bjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FeIS72Yl; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=isxINe6B; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R86SF62680887;
	Fri, 27 Feb 2026 09:58:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=4smoy7DR4EhCrJ8RsP
	vdP0yHDY3z6/MTEuAaAZg8DjM=; b=FeIS72Yl9GEDfiMjjOU+1M1G1M2//Ap7Ch
	xpMcu4Rhjqnu+l6D0B0VW/CICQIqF8pJN/qPTdxVsLnLjN6fr7sUtK43V0+HkK4J
	hhk1XjLEza2XlYSmwObhhsfB38v/1Jq4sDLAHb+Ru3tOH5iZxrvOaA8VdutLFbEi
	F5XRfzpTmz3hIz+VIHQCR5sJLAO6K2pXZHuVgdU9kWhZLEWNSorh9qo3A35D1jDr
	jIJX4vl/r2fMSNVy85rxTHOB0aij272lsmjmZCSNqMCLNySsqeogkgsBVOUzTZHd
	7cUoTqMbFZzknrTZwYQYcREW2FvayEsEwrRaDL3CwDa27rs93kDg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020117.outbound.protection.outlook.com [52.101.61.117])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4cjmds1qec-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:58:02 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcXqQxl5ytz0pS+KznMYvJmwiDg8vYjW5YyNkyaJkvwaQK0UIna5c0TeGEPBt2YfeKXfwdPRWH7t3KsY5ViKwIubiKP6zL10hTZ8gv9AjjzgcC6iCUj3DEZn708CFRsZAg1uzkmzKcg8s3UBHySEvzc8tJo7pLKb/VjqBKCzVYe+4bQXdhsd4lTYyJa+82iTEmOXi7dN1nkQuS/Qo+pknrjddF6C67augzVxDqWoMpjTJuMTyg/hTusquM+9WpL0EAy9hHuohE1zw1OSHUmYTi/anbQ+7g2s2DieIccIAOM9Ynd7vJRsO1BihN4IRmHyNlN0WoMN3TOlB82TTZi+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4smoy7DR4EhCrJ8RsPvdP0yHDY3z6/MTEuAaAZg8DjM=;
 b=jbChKUVbW0JLu3uPlpVcxF5W5k1kRg7mTAho57NuXig7JiiIPHgTVfcvYUzJWvWrmNNz68P6r+2I3MU13MnwDqJ8660LOA5+66+vfWefH4Lwz7u3YZBWp8A9zgTBitThNVK3yt31Td57lcChrxcU5woSUzMbTuWSuEckEja5UbI0RYf5d3XzyWmy4yjL3vdwTmY2u2fBtVl/5Qkqi6L+x5CTVW0JMopFB7vl7z705glHWc4USd7JZ//ByfA6uu1yo7HWusndif6zun3cD2Q9damrQ1np7O3U54fK9R51v2qypCuY2hbSocMqxAdL7zBn8b0WO8BjCGlwvAnrilqxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=stgolabs.net
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4smoy7DR4EhCrJ8RsPvdP0yHDY3z6/MTEuAaAZg8DjM=;
 b=isxINe6BAy/qyd/KjoMxLY50mmQ68OX5lpdunOe0f91XRY/SRKW6N1dkkbEs4ehI4dZ4EUJsLQb05CQEk86LxlQQ8LNQI8yBhQ8EHBdaWTjbcb+2Tp0MPByG+Wki+61WM7GvKIn1cK+f4baxSgPAoIVQEQonpuAKYOwg/cYRYws=
Received: from CH2PR05CA0031.namprd05.prod.outlook.com (2603:10b6:610::44) by
 BY3PR19MB5011.namprd19.prod.outlook.com (2603:10b6:a03:36c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 27 Feb
 2026 15:57:58 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::8c) by CH2PR05CA0031.outlook.office365.com
 (2603:10b6:610::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Fri,
 27 Feb 2026 15:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Fri, 27 Feb 2026 15:57:56 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EACB8406542;
	Fri, 27 Feb 2026 15:57:55 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id BFBF282024B;
	Fri, 27 Feb 2026 15:57:55 +0000 (UTC)
Date: Fri, 27 Feb 2026 15:57:51 +0000
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
Subject: Re: [PATCH v5 07/28] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Message-ID: <aaG+/21w9S0alqTN@opensource.cirrus.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
 <20260227135428.783983-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227135428.783983-8-herve.codina@bootlin.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|BY3PR19MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 980339da-f25f-4529-2899-08de7618f992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|61400799027|54012099003;
X-Microsoft-Antispam-Message-Info:
	W/3ronU9vsFZ43jDeF6W3mORMWyB/l3riBdqYGIKczjGbRut4OaDV8ZCsmeXO6+durrZGoa5lQlNpimGULB9SAb9HQOi+yiNWFTeyUGl0DomyezQ3xQCXPadFxjZp/Mr4Jiellb2KMOiu0GnmE+7NXz2vmXmEitVwW0+SVj9R9+jmDQAyaP6OFUA5Djgn5syMUMu25f15mWzJYWcqgZ03cpTb8/RVAZsa5BWYdLbyEPzBfP3LsoHE6MfonjRVain9YGkRtqSr1UJp0Gw+EcQURZxvR6fqVrjnRH5qsifGBNR3RKwyvpD0X787kf55PNcduaMclqXakDqlAnq+xmRiH9nOBYwqe0eeakVe7U71gA/DEIGD4Dbru6JwRnyZIHspnKTnRe1UCl1vk3WPG1CU5ZwvhB+9/kgEiLAqTp4dXp7B0+aud6i6QgNoSKmVNEbIvG8OtkMk+jx4boDJ1m54k7f9YAXb6UZe13atRuk3mNGvbF+f3NG9I8qSwuh8Vo4puztRgtFq/LZPiwI78TEUDOtOMNLgZRNIZysKrpGhcgRO+9asgiizaYizNH0HrVCFDuwIwo+zw1CgNoGsP788KdR0gx/k2cmxNoESiD37S8xUTEx1He5ARlOtTHmmTnH5fYxGwOSq4D/fkTaUxKYcOkkPUamW7QWXw6ok9LGYmLGXzyBfUTLAH8ByAILg1z+XRHNwriJgW/PoXtzwCiCscT8dk44dNAWgNirS6a8ANAeHgGD79CH+MLS/seqDro0SYrY3vOd1xGWMZ6Xqu5ndGfT9/E8eSiwaWKRzSYmOc9rXiro49P1kzPWPrIep92tl22HjDTlEjKKr5Y5JPdXyw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(61400799027)(54012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L3d1I7xxQsZR3O+OuX/CC+hoDAcNG8CW7Bodkou1Cg7olTzMm3ILYPcbXOycmzJQDbgTUdowy8mQmzcaN0/rAiTGtZQTefjmL+5rGTamgp1KzftQ4frtAokmYxD6xL7WpeRtUpVpGX44d20+k7nv5/8JbGS5HXhc4uy5XfPo2KfSd5QRotINLsfpQsjb77hs/kxhRoATPGZHqKCMSRCyCkgczhjs621gMuWb59o0g20nJW8jAHwNRnwn5VsDfKR6cWKBxEqIdq640ocGRskz6Z52ghntwmfN9NkLCMJpLVf5FTqS8cvB0l2udc6uOMGUovj1hBdeiIZMIjQDDRGgjTZnrEXC+ESeY6li65DQ1SC5QKsNuF2dfzqnL5mF1f22wVkB1Rw29h4yJJuJomWHsAYf7D3yKQO1SIimOqsSb/5HEVwrslLpOXS/x+X9rUYh
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:57:56.9275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 980339da-f25f-4529-2899-08de7618f992
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5011
X-Authority-Analysis: v=2.4 cv=dO2rWeZb c=1 sm=1 tr=0 ts=69a1bf0a cx=c_pps
 a=zbd7yB0EajPYIcOkJMaukQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8
 a=rSjeN_rvdOytUjbESTAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uE6eyuXmduAqXwtHTT2aUQr7LQDeAj4u
X-Proofpoint-ORIG-GUID: uE6eyuXmduAqXwtHTT2aUQr7LQDeAj4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0MiBTYWx0ZWRfX0mskQKmLgsXQ
 2+TYSkJSueLauCd0VcS26TFUinl5zww9210Q8u7kwCVopkIzFlC+S6hGxFgkJUM/vNsgj/2y5tW
 0Niubs+PYtKS+/99OsWU32AvFMjP3TiIlYoM5c/inzlA3ntTEunfTX50HlrgdVBsxtq8ejogU9+
 2x4iTijpWDPG/zSrV73RpxRsUZWSA6vSJY3Bt2W0mFD0gDj0LIKYJycI4FOVeY5BPd2Mj5xIjm6
 JolXKC+yvhLUu7IYoQsYfvpq6aJDl30ANI9lyL5HByAF8bLSrb6PuKb3VfZGJlF7nu9K6Xslnux
 ea403p2Gv/1W6MPM3RGfHLFRdqUzthRfyxXg7XtoMs9j3mwWYDPtbbsyLqj9ANpnOTAKa1UeASK
 O/v6DUmzHlSIihaeHnGh7IhQXq8bexz7AuQFE2RkzcLYHR7oclM9kzxTcG0OQMj4nwuJkBsLjqv
 Efo5PEwokW2n3YPkRMg==
X-Proofpoint-Spam-Reason: safe
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,huawei.com,intel.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com,bootlin.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,opensource.cirrus.com:mid,bootlin.com:email,intel.com:email,cirrus.com:email,cirrus.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21234-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[intel.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[herve.codina.bootlin.com:query timed out,andriy.shevchenko.linux.intel.com:query timed out,ckeepax.opensource.cirrus.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 239E81BA798
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:54:04PM +0100, Herve Codina wrote:
> Setting fwnode->dev is specific to fw_devlink.
> 
> In order to avoid having a direct 'fwnode->dev = dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

