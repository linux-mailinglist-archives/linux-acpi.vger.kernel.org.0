Return-Path: <linux-acpi+bounces-16010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B52B33B4D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 11:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C600B177B89
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FAD2D0611;
	Mon, 25 Aug 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SC7bCRpG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="hWMraJX3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8922C3756;
	Mon, 25 Aug 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114827; cv=fail; b=DyOhsr9mRRRtNk5cZglxdhWO3B6Ew0pCaqj4oF7M89AMHY6MF6Z8usJwV0OPgflYmYef4930RIqODZ8tVH1tXN7CY0z+UXs5H6HUxE3xc7Ys4nEMH6RSiAfZHO7gkbJqDOCdCxfW4zT4xH32MQhqM9a6tzyagMPP1ETM/BDns9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114827; c=relaxed/simple;
	bh=bBZjP1ZteDJZXJFe4Q5GKKm8vkDfS9DvqKWNMBoOdCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUbxOXDynMw778ET7gz9ARvEjou5w1FyL4jj1MkMCAOi+HC8Fvn2HhjpU/9+HNMAdjCxwgRjUALYuWfLjdY2g8uO9FAzuukQ+u/15MkuDzN4gajXOcTbL+X+1CiS2w+BwxpKRWxmq0JkCXEXzTrbnvpO6T/gXv8AEO8suKqPsJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SC7bCRpG; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=hWMraJX3 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57P48FNC102372;
	Mon, 25 Aug 2025 04:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=yh0lSvSZRjOFRRePI8Jmy8HHdoPKox4MBryQK2tfXKQ=; b=
	SC7bCRpG6wMMxeGXD/n0i6yWxVyGlSb4wHZ4ARgNK15rMDHUHiuOQ4esHmQsgxjm
	Y3qTQ58EnExLNQlW/cw4wmLDBUj9qmWZuLJln8DmTcvIlpXEgo645YVxQfynBRBW
	8lv1/nTQzhO0nSq1YjcYauDjVQKvU8VLh3SEEViMUtgPpPOA449ZUH5nhjqOPrt5
	7YZhhm4OnGi0UwhNh08iiLDAyOT03U9ZCRLBRa6hok8oWkJjTuxZVsKG1sIOgDQQ
	Diz61dwsJP7YtQw1gtOKSr9ooNQrWMwo8kv5fSniprf+faQnH/vBfRh4oXgpSgcD
	WihQ7LVk5bIoGsPRgJMfVQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2090.outbound.protection.outlook.com [40.107.102.90])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48qb209y3j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 04:40:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzBHZkKhNKPpAVanNtEK3q42GgCOAjHpLgpOlJAAxX/YqPCYsQv6/uZoCfu6c6xBCtw+VGgU/51LCmF16QUGwQnhArUFrgc5NjVKG/GLUOpYwiZ5rcceFei3RlTWjm6qlO4BlaHPWVXqwkofXc1NrG/Vxa0WbPJeAlWChyuTHlhBifiVl+oix4yg53LZOdd4Sfo8FUh3yDzWdhEQQBJwZsvsgMCBQ/UFWrsTkyYt8SL7oesnHv6PjyT0mRELY/7wQ8N9XJz9IKCRmsp9PDLpTznJbKGEZ13pSXeFHSE772sogg/qoEjgX0UXIZThL4nStT5xQo0xT+FRjr4+KDCi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2i6xD8B1akasXK+kf5JNEQWSIjJ05NgS5X962ladtM=;
 b=O99ui+FkToXE2WKNHuhIspNKiqbSzJyuq+CWkBbh/L7CJmuUEkIGmdyxGUe3aLfq0c4mPr2Ksd8TFzTXUrIIXmsLrFDsrgorISzV6sRlIWwLYogLYBPu0Tn24luCk/LFjRuTpsr/g7Glog4BuJ5AHXmz0jLIqlzf14QF/Lo/Wxj+HtyYouanHsv9IMeWC8eM6DlZqO5B9xlLlKbII30BvTxxrcNmfiQXLD2HIzEwir/l4UWFu/IKPSCX41dCxC/yGz4XHgXmLxKnEG3WxbaEUgz+it/OwZw7D242Vc6nVVj8P3MOarSgTIQFP0ssgqpOV8/5H4lRuuCI6RfQ2fNoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2i6xD8B1akasXK+kf5JNEQWSIjJ05NgS5X962ladtM=;
 b=hWMraJX3J9beGizto0dtgFzax7Xj8zYyDE6MyHhi1vInTPlMI7qpfyWK0TmvFGykK5k0XgcvDptQe5ozUhJB1HN+YRSW8DnZfXO9p+JQOS5OlO/CvseUC02QAoAdu5Ve25EsjW5kymNgUdyCQ8NOY/AXrxaPVlWhiN9+c9P/pHY=
Received: from MW4PR03CA0050.namprd03.prod.outlook.com (2603:10b6:303:8e::25)
 by LV3PR19MB8478.namprd19.prod.outlook.com (2603:10b6:408:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 09:40:06 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::82) by MW4PR03CA0050.outlook.office365.com
 (2603:10b6:303:8e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 09:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Mon, 25 Aug 2025 09:40:04 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C5A8E406547;
	Mon, 25 Aug 2025 09:40:02 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A1C6E82024A;
	Mon, 25 Aug 2025 09:40:02 +0000 (UTC)
Date: Mon, 25 Aug 2025 10:40:01 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3] ACPICA: Add SoundWire File Table (SWFT) signature
Message-ID: <aKwvcaCGuKGCXosa@opensource.cirrus.com>
References: <20250811134505.1162661-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811134505.1162661-1-mstrozek@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|LV3PR19MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: c131b913-1477-4007-9ba6-08dde3bb5ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?n8jK2mY5HJJemiB5hX6d8b3ZLFewtOcvpVGZiKvDOZ0qsXI8zSAqSVdhH0?=
 =?iso-8859-1?Q?vaNy9oDQv5uNbsdtC95B4q6ku+HvcgMgkgz5XfioayvUybWAep/Rtyj5Xy?=
 =?iso-8859-1?Q?erd27Mx3T5tKTsnGyTFadKs0mxN+zJhXsuhOJ5dKBQiCIt5agoSYXTkl0o?=
 =?iso-8859-1?Q?loQeKHwwm87iArjJpuIwmd0xv2ZrOdwyv6miGHQlBhDocw/dL9EtbROELu?=
 =?iso-8859-1?Q?8dDC+T6hq2HFBYBvxnOQN80LLcQY6IXSa3E1iYXHTKZJEhpjZfbwXR+rG0?=
 =?iso-8859-1?Q?qN718YIFgV1sGiWKskit4BcWoYQs9n/oJKJCebLLiW7n2YCmIayP2CQt03?=
 =?iso-8859-1?Q?Sq++cMjKjlklHlsRtn/4RklN8r354OaS7eVh8aoj7w0BoWK3SbjWpx+Bqj?=
 =?iso-8859-1?Q?xtN1yOKVuOSWpGIStpMW2rpr8VNFQNN86tlGHvX2yy6jHU1PGjPCoPyuDC?=
 =?iso-8859-1?Q?yl19Tfrg5SoNezxe6cQCgURbF5x5X/oN39EjC44+Aeku0CLEk3HNsyz9NJ?=
 =?iso-8859-1?Q?wnw+UvZ1HSAvpfjsiw4AwYcUHqlqGG6QlLEIwQXCSTZ+4qLT62mKOJl97u?=
 =?iso-8859-1?Q?BaA+6OnXQOAeJGzNVfd4sMzVvIFMiJvKydboo/nQkkob+0oJ/MxWvdIMh2?=
 =?iso-8859-1?Q?XX1eU8+c+D9fL8Jp6z5VONX9n1OBzVKudCH9HpGLtYo05hxjXxonjzvKWl?=
 =?iso-8859-1?Q?f/gv2WxUuTgY6cBuDAMNm9nOdIzcAL+DAoeZgFdFJp3Xq0AOilPc43YQB/?=
 =?iso-8859-1?Q?LrOAfa/Ay7iRt44WXwLIUcYM2+0lK9p0EJ7niK4nJ36PFOeZV6h9z2egUr?=
 =?iso-8859-1?Q?KyBMN2kplufj14orGm4XpXx7l2CvMm8Zsk/cZM+UApgBhTWudq78B2frCM?=
 =?iso-8859-1?Q?xhRmohg+U+TM/APc/H3RXxVJyhiY2Kl7idxuqBlHH1iUeCRfV+xn77dieA?=
 =?iso-8859-1?Q?GwxhrMIynG2FFhKZo6nF1upl3K1E8oJQ6d2IRu57s00HSyerGdDgRAPZBI?=
 =?iso-8859-1?Q?u8K5R6S7jJRk4jHCna0qu9g7YgqvLBBEmUNu4sJ+Kgek1i6P96kAyLVTSS?=
 =?iso-8859-1?Q?/FkFVq5yAA8AzNySXjdde0u+mCcmpv7K0NZq0zOQ3Rf+KFoh52gd5vv53e?=
 =?iso-8859-1?Q?DsoKsM1a6uw9x3vkdExV+HZx1QqW22WSHfo084R0W684hm044mKhNxJ2df?=
 =?iso-8859-1?Q?xfwqt1pqZV+Oz3zGJq4D91Y4ZUnVRuvY/SIjj8W8u2GlKdUFW+63tEgKVC?=
 =?iso-8859-1?Q?4O3zIyeeoLXjqMu9PI7EsxsJx+dB6XdOK+tcbcp/T6v2OOi4BxMZhLXDq4?=
 =?iso-8859-1?Q?7NzqzjICGMl17w1fnocm+/eWKg2ZWGQB7iQzOVpY/2+j10KYQyrgGdbzOT?=
 =?iso-8859-1?Q?8pCHK79QkY/8dWHj3jiF+TTciU0xmWsXQgjSzUaXeeYiuCr53sDmYHdGlM?=
 =?iso-8859-1?Q?rWow4isG2tQGCBazn3ET8dco/WwlxeZs1f418DSGF/p5CBNItuRBYUSDUt?=
 =?iso-8859-1?Q?xzKHmQrdm1f0Q1piq6XKTjmGnqHviNoAaWjJukCIOymA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 09:40:04.1536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c131b913-1477-4007-9ba6-08dde3bb5ec4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8478
X-Authority-Analysis: v=2.4 cv=GbkXnRXL c=1 sm=1 tr=0 ts=68ac2f7a cx=c_pps
 a=OkheQ7YMNxSF7aQwypjV+w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10
 a=RWc_ulEos4gA:10 a=NEAV23lmAAAA:8 a=w1d2syhTAAAA:8 a=JQJDhRPD3OthYt_GnVkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA4NiBTYWx0ZWRfX/7HRzKq5/RF2
 DqTSdPTt1al6f1G0b3rMntH/9fJehrjY4KU0S0QT5e3sC9eVXBrA92+MmQ3Ry46d4zFAl9vFWzi
 TgZkdBvJLjCc+Qu5A/NEiYcYPNMcv7Adz77SClQFy3ppXvhFKpFEBWuoW73p/YIAGk1XXWBngD9
 lhKhlTjgugi42is02lkNuAHMklXg0NAcHE7UzGJX3Oq0vxJ+R6y4FjDCoX1E5RqNO3r9tyQl5mO
 ttZdnXQTgai0mfyQtrlEP+Y8n9Hyhkpmqxs2XCqUgfJjyK0X5Dypsa6RxVCARyhzmS2klI1qLM5
 ZRG/Zm36Ad9brpN2fYFk0ql+/8U/EkVsE9+gkedoIckQJOG5/mDD67PeX6vL58=
X-Proofpoint-ORIG-GUID: T2FXsJZzuDvvbrDaJ9lej9uSyeOhq22Z
X-Proofpoint-GUID: T2FXsJZzuDvvbrDaJ9lej9uSyeOhq22Z
X-Proofpoint-Spam-Reason: safe

On Mon, Aug 11, 2025 at 02:45:05PM +0100, Maciej Strozek wrote:
> The File Download (FDL) process of SoundWire Class Audio (SDCA) driver,
> which provides code/data which may be required by an SDCA device,
> utilizes SWFT to obtain that code/data. There is a single SWFT for the
> system, and SWFT can contain multiple files (information about the file
> as well as its binary contents). The SWFT has a standard ACPI Descriptor
> Table Header, followed by SoundWire File definitions as described in
> Discovery and Configuration (DisCo) Specification for SoundWire®
> 
> Link: https://github.com/acpica/acpica/commit/18c96022
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

