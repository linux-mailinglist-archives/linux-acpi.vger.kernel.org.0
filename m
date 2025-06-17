Return-Path: <linux-acpi+bounces-14419-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5D6ADDC4C
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDC37A8395
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2423B60B;
	Tue, 17 Jun 2025 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vPJZd0A5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023082.outbound.protection.outlook.com [40.107.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1723B61C;
	Tue, 17 Jun 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188645; cv=fail; b=BWjcx0yqa4yb+GXRk5hfwPjcUjxOFs/WWJPWx2mD22zDhZpEtI6lcWSOwwZ0TIsRpMST3cmwey+O6lepOZRRAZ1KMZaHcoqjcLL1OFMUcAEWeYIt/3F6bh8XRGPUzfZ+3B9C6jjdCkBx8EtNf8/2Zj6bX5iG5sS0tZArAzbbUCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188645; c=relaxed/simple;
	bh=yXPYw/eJl/9S1tbG293JFTtH3vdKYhbYDNAfrMyQby4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nIEijqLjr+rX5sCFlHHomxRZbQi43Fwlvem/vbTA8i7Br/Or/WMfKv7ToCMY1PGkH7xFW5UL9tLLoaz8GCd5iMEwJa4llP3JtY5GQ2aqGZfPQGZLusHdwq3XFN/sIpbmD8Krr07f4529R21LAMNqu1qAmD4YFHg62MOHmEwWhU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vPJZd0A5; arc=fail smtp.client-ip=40.107.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEhE2u4TGSKsQEnBsRATYBVToR9uM5Bc1Ww9Qe6ZSLxUUM5BBBvOs8afU66ppiIlxxm0YH+Dqe4FhEbhCtUY56x6nmIluBOUFY/hCxb+X1yfXLhIBRRuMuSHYDlsnX/cEzvFiRC3Z3Gmsh+hcgqw4FFxmYRuHEi09vRVXi6jf+u3CzNXdfP1n8hkY7GkpdWRkVA4p7DStk4R96ueOT9L0Qn7KJQMoCRxv91lY0xIUGSvC5Ud2Sgfo94bbGqQR7h4tD0rp9czDj69m8rbZ1ZzF+rCIly58fXNuhm2NKkClJC/UCPHSjaq8s3kjfuunEmraILeB231w56jO5ewWjYSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vdgPeJF/i7MJPwkYrrTlOf3Yb5482qrRnvExX+YRIY=;
 b=W794TKO7vc7enB4Gd8QwoQ8XSRLXH8QxVxZoaWvoSdtP/cZH2J1pLPknGr9e0o795bB/FYZPd7rp1DarNOfu9sucezECl8lx/xs2ZLvyjHE97aRU5CdMVEowgqDC3cnwW5ixbtdNvBU+op8SbJBmQGLTeg7HfklwjdOS9T5YWNTuSbEI+++oliZAOHvnI1tz8DIkjJfr3ZtKuBaAFCYqjqmLuTOZDXZbGOkd8DGacin0Wq9YuhhFPUBVl4bVdXs8YKgrXT/Za25pZRJnVv69Wevd+HcM3zsWqwk2h80b7OS32A7INkWrBsHH3locnzTpaL183gcRgycIRhBbQEkDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vdgPeJF/i7MJPwkYrrTlOf3Yb5482qrRnvExX+YRIY=;
 b=vPJZd0A5I4Vz0/LDsK9FTDt4bjU3rF0zxA8DwgghMJi6kRNtPd0lYm8hHXxSeLp8ctEWadPkXyEw+iFcIyvLGxncP1YLEf0MZGSM7QCTaMG4Pn+qaeNFRwKqjVq7n3feGMehipRpgspJ+QV5phUg/rBYA/3mAUMYI7hc5XmaJrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS2PR01MB9414.prod.exchangelabs.com (2603:10b6:8:2b0::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Tue, 17 Jun 2025 19:30:41 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:30:40 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	kees@kernel.org,
	gustavoars@kernel.org,
	zaidal@os.amperecomputing.com,
	ira.weiny@intel.com,
	Jonathan.Cameron@huawei.com,
	viro@zeniv.linux.org.uk,
	sudeep.holla@arm.com,
	dan.carpenter@linaro.org,
	jonathanh@nvidia.com,
	sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	benjamin.cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v10 0/7] Enable EINJv2 Support
Date: Tue, 17 Jun 2025 12:30:19 -0700
Message-ID: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS2PR01MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: f056c3bb-f140-41a7-3a67-08ddadd57197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b3+VDkfXvnHXRERc/dsao/jK1HN6u3HPF3s7490lNZBEchlRLvhggF58FRnZ?=
 =?us-ascii?Q?+nEMxvTT+2STkgF0dFvfSO1LSFJm/qY7xDCvG/QzKTV9JXJi87Bf3/K77soZ?=
 =?us-ascii?Q?kjkJHflO3aMwhqxB+qHxQDf5jf7/cTUA1mgY8V7tmFf8Jir7BNT3ANbnFoHe?=
 =?us-ascii?Q?7OxxGaTHqd/xkEylXnhDTLmaqso74s1qW59DwGfNmXf6mCdLbwz0AI3kpkeN?=
 =?us-ascii?Q?rqW6cwZhyMLnvrHLMB1t3QkZr7+KM4sUJ3MvM4BNvuBbEVaW+Oq8bsxCpVBA?=
 =?us-ascii?Q?tZhgx7VcOAm1qfvOLJr9febYv/jjZIooAckYZdr/BxVc4i0U6+T95XS7FcYd?=
 =?us-ascii?Q?ZHdFz+qxlvnHQfWafHhkli2so+MNg/aiAHlPZpuVD2Pk4yCv60XPuU0r3H/1?=
 =?us-ascii?Q?EP2LEutmGsD4wwoMXkCCd1NIsJjudVK3bwHNUYtQ8pA1ZZDoNMZkKoBcfoU9?=
 =?us-ascii?Q?GWXLgUr2uGMxb68zNpHAcXnaeH4DDWqmY9axydFx2ckHnn5Hn1LIoKIWw7lB?=
 =?us-ascii?Q?2Oqr4HqRWAtstaisyU1fz9iytPno32RbgzEui5XMjZXN12JoiEKUxYJ8vXWN?=
 =?us-ascii?Q?x7llInqOq8huhqHfoNIwBUWrO73Q1K7oHP+gGO8Jc5fBvOX4HCVm0iQPUjFk?=
 =?us-ascii?Q?qPmqPbOF2J0e5kpGyoSgIrfX3sCzDjTlozzfmIfCavS8gidv/cPEhdX/37Kl?=
 =?us-ascii?Q?mZ5W2OHG2C+I2oh+p60XoXEEh4PpT8PYjBAk1m7ZKUObVSiqGNfuNhuHUNHr?=
 =?us-ascii?Q?qT6Bbbhu4Pie5N/wm0/ypcbkY3lu9Jv6YvbANfRUl3fxbWzbZgrkVddB6TTt?=
 =?us-ascii?Q?J1n9gIvgffvLbWlnWNLjIlWoNCdZuaz9ZDSMK8kEgcZsYsMcnlstQ1frrEnN?=
 =?us-ascii?Q?USnixtlMg9z9gKcEFYJcYpeAZq+adeWsKCK3c7prtxNzhrXknupaMGaygoU7?=
 =?us-ascii?Q?5MIRfPKdWmiAI9BsQYma8UsKbiIn61wNMkeZtj212JtR23p9rApgj+a7SxD6?=
 =?us-ascii?Q?2gY/dVHFumiPPnCybjnI/oUrM3VLptrmRh74ngF2dphg0iKn4+s//jmYwV7D?=
 =?us-ascii?Q?l2f0cOXB06vFrnPJzM4RJw6V1KIxmxvdhV2TG4KLjFkITN2SnqyIcUWMX4g3?=
 =?us-ascii?Q?t6p57DbCpaPgsHQQysgiMnM+nKQZ39OaaCYu8A0aPUa426RPn23GK1sbvIzW?=
 =?us-ascii?Q?OdyEKsbkf+/iyMuh/kDxLym437ZWkn7ypMoQTNTipdilkTgzV4i/2VCyAS7d?=
 =?us-ascii?Q?9HmZMCWASp3ZV5+uysML/75i7k5ZVF9nbFWWDFqFPsQDUPnEe5O2CH9EhqOe?=
 =?us-ascii?Q?YJ6YrMZrelfjViLH7VfFDcd0E/fvCOyTnj62K3KStLDdK63Yk8MacX2PV67g?=
 =?us-ascii?Q?GoQBNvQgGL/HgQRHMDujCcB3csgg9ASSAa02DjKlywi5WfjGQGZJf2e54KDE?=
 =?us-ascii?Q?2nguRe9l3WiIxqsPDtZ3jpapqWOWNsLd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bl+yZMhe/gfV2EAErEqDwjhVRBStAO+1brY1DzmHiOjuf0kO/eRVn9VGU3bw?=
 =?us-ascii?Q?8dS4WEAeK5fg+oE8Ozj+hHet3wprOmeJJ+Abdcv2Eo1Q/cPh0rVAZVYnFYi9?=
 =?us-ascii?Q?s0s1l8bfkOf2B3B4Ygjw7RVjPPfKMc/PMoYWO8aE9pSe6Psk78C64convrar?=
 =?us-ascii?Q?NXk1ptI3JTQL2CQ1vRmG1wfQ8hyXmPwBq7GccS69ORofRuSeGryPNQ74h2on?=
 =?us-ascii?Q?oogaxZDLkcvlZGAf8vfeUYeqEbw0aVf0wrcmB+SJU5GeURht1V+UtJ5MjHjq?=
 =?us-ascii?Q?2BkIolVOa1XOK9qrJvARW6alNVFX/ES3nCO1RgNpd7Bd0BeONVFHEHaK7sSU?=
 =?us-ascii?Q?5beGsNlT++dCHJMLyPb2l6142qtEIkYgbdlM9U4PG7sCGljBVQ1QHkqOBNXZ?=
 =?us-ascii?Q?5I5unuh5mPs9xfjtALcqOTWQDtRCfc4+tPj8r/PS7yf0X+wzxhdrDgPDaa/T?=
 =?us-ascii?Q?5SvTyllJ44Do//YicbZOH3jv5EbPbqGLapG3dMffF4JeNbYhJMoGUpkri12q?=
 =?us-ascii?Q?5IXbaG7HxGZ2puVEY1Pna7KXeEggXEfpTqaEZLFWzTT5cc5AhFpBUJ/FMCym?=
 =?us-ascii?Q?POgGPlXhE1r3bUSA9Hj7TKcsRM/OLyKJDJsuut8DnqhISX4i59ibYwjtYHtQ?=
 =?us-ascii?Q?/j8f81eRRMiJlXE+kKqiAKVz6b49hJSkNtiEYJZj6AOF2GS+/+ilaZ8fDOlw?=
 =?us-ascii?Q?pRRqoUmx/kptEnNqQy/QGwb5M3i0qcW7jaF97W4ACPO4HJzja82FCPX+7n0S?=
 =?us-ascii?Q?LrvxOmtMJuZLnycRwrya2BtWryTZLAtXqNxXa2mDmPKny4hUqqbRNTtL7lym?=
 =?us-ascii?Q?QkODMFqe4qYcQ1reazfkYaTEyKb9hm1ZvRW0Fh5RItTmaYVMFIW/BdkuoATX?=
 =?us-ascii?Q?4+KKOWhOiV7ZyNHCH5rQ4FqFhCRYie+5bclRrWF4PDoiDeZqG6O3QBlohvhk?=
 =?us-ascii?Q?SREybA0BEzA4zSVFda1dOeKwNewF/mKOgq4XwZeycV+qJ/6nY43FLuIAJM5K?=
 =?us-ascii?Q?/y6QK0D/o+F/+dDhuOBw701gzSdGxNKsSfzx0w7tUnT+cRqZrjKa1ldR9ThV?=
 =?us-ascii?Q?pNIZYmxh4sEFAQanAGmdTVl9GF6P720SEiJKRwOrpnJuXqHff486EiP48NdH?=
 =?us-ascii?Q?IJsyZk6ltJ0y2xGsHicyETGApii77csVmppHV3uhuzBBck1GmEKSUSj4Jzvi?=
 =?us-ascii?Q?LYbFEuwP67iljMjW945lZXqXVJ05U/laz0vzxeNt1OjUJVlvtaNAfqPqzKWK?=
 =?us-ascii?Q?DYlTeJ6EJsOt70tK0alaTIrJ3AdEaN3s5Xe42STgvhrFaWaQAdY5O4B0V5se?=
 =?us-ascii?Q?YkI09EDZJn+zY8Kzjx69KKPlN+6RL5w3qLCbrzUL4N9+JRUuAtkc3zgG+IO6?=
 =?us-ascii?Q?j5muOQETjHG8OLof9wAb41R/GNZPRODCzRrtXtsqgaR9d9EYQul44drxtuGz?=
 =?us-ascii?Q?LHcE4N9r/XvPNA+NMXSZBwCm0Y1r+vgHpWqBPaEOcvgiwPKCLpDe37ZCjR5K?=
 =?us-ascii?Q?j7sb4FOVlGaO5O/95OaLCOYXeAw5xC0wUwsEfEwtf5q2+bMR5XHz6xXHY3v7?=
 =?us-ascii?Q?mfxg4jlreHSksdPCDbiTR30NOOJk5gH8pJEBiycr3cQReMDsmnZ516jyvd48?=
 =?us-ascii?Q?raUJpvDJK+/y2NbmCxBf+XM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f056c3bb-f140-41a7-3a67-08ddadd57197
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:30:40.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPawNFom5HwUWRvb3lcx5g68oUyGLXe7dXmVf+7LDOH58LtMevGmH9eQKNRRmde/phoXG3WsUKyeEwG5z4an7AzD2lVsAX3z/RpsDFlSm5CieVSHAelpKbkHh+F5qEvQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9414

The goal of this update is to allow the driver to simultaneously
support EINJ and EINJv2. The implementation follows ACPI 6.6
specs[1] that enables the driver to discover system capabilities
through GET_ERROR_TYPE.

Link: https://uefi.org/specs/ACPI/6.6/18_Platform_Error_Interfaces.html#error-injection [1]

V5:
        *Users no longer input component array size, instead it
         is counted by parsing the component array itself.
V6:
        *Fix memory leak.
        *If EINJv2 initialization failed, EINJv1 will still work, and
         probe function will continue with disabled EINJv2.
V7:
        *Update component array to take 128-bit values to match ACPI specs.
        *Enable Vendor EINJv2 injections
        *Moved component array parsing and validating to a separate
         function to improve readability.
V8:
        *Update UI to use single value files for component array.
        *Update links to point to recent ACPI 6.6 spec release.
        *Updated commit messages and documentation patch.
        *Dropped the first two patches as they were merged via
         ACPICA project.
V9:
	*Fix commit messages signed-off/reviewed-by order.
	*Fix sparse warning by defining syndrom_data as a
	 static struct.
V10:
	*Use defined value instead of hard coded for component
	 array size
	*Unset EINJv2 flag for EINJv1 injections 

Tony Luck (1):
  ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome

Zaid Alali (6):
  ACPI: APEI: EINJ: Fix kernel test sparse warnings
  ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
  ACPI: APEI: EINJ: Add einjv2 extension struct
  ACPI: APEI: EINJ: Discover EINJv2 parameters
  ACPI: APEI: EINJ: Enable EINJv2 error injections
  ACPI: APEI: EINJ: Update the documentation for EINJv2 support

 .../firmware-guide/acpi/apei/einj.rst         |  33 ++
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/acpi/apei/einj-core.c                 | 374 ++++++++++++++----
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 4 files changed, 342 insertions(+), 69 deletions(-)

-- 
2.43.0


