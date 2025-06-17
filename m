Return-Path: <linux-acpi+bounces-14423-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D6ADDC54
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473C240275D
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D32EE97C;
	Tue, 17 Jun 2025 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="oGWYB8W9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023082.outbound.protection.outlook.com [40.107.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045125CC55;
	Tue, 17 Jun 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188653; cv=fail; b=TqVV1OMbbF0XzvLyo+sxaXecNQ0X/2KQfvay4M6hj6koYHVrvFPVI02NrW8rkYYyideG3+1TGcKlnaPRU1BZeu4p3L/R2BrcjzIerDB8eYZhaulkVP/PoYsdVrsNJF5ieQ4BnvELoIn2aJVpypIht2YVBIOGyVnR7Wwjfmo0+u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188653; c=relaxed/simple;
	bh=liNW9FtfMaIJ8X9DULxFbGM4uDQCA/mMcy7UWOM1x0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHZ7ObLDYyxNlQTBbxZ2nPLyQmWnpsALPI7FIwxneONmUMs9eKxWjifgmpGbmmO3eRGYAARZ05oA0AKhXznJ3gaNSNwZsQh8aso6Bok6vwq7pb02bPhdM0jyJaaqx11fAyoRxSsF5MzN1lID4EE8gN7dgduXEB7BdcpFPTNw+H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=oGWYB8W9; arc=fail smtp.client-ip=40.107.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQNCmK6j+t7DaG6yxidRY1EDT2VDNLv6zVcgICeuthA9IMIJTrry/KM45+kpSndwc+xtc4Bz+TJcsftKxdN8kwMZQ00Q0EQ+nytzzsROwfUSMp0+qj5d8w9NBsTp+uREUuYGjiKKfNmrgZSpaGn/wndXbw3d0hOW/PcKhstHgKIJpW0JQdOzXPGahRf4LIi1CTrTXenekdQxgwdFHQnrA2bp+jNFYuHBBxUP19gTRrmL1jKvDUfSWfMz2SfS8w5A0TGw52AFYkaIZak6zzMhmCatbmbyxuSQSgv8N22PVByMcntxqyg17vzxgv9r08eDRveKYvWA3VUaS9Ohil2PIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z4K9lm2nsFzcGjdy4PmXGDnvcsjEaLX2pepxG91Bew=;
 b=KDGkpvgetOsAGx3SKzGUn8vY5lxE5VE09n0vWYF6JFvI+EbGrcR78E/XJfqnNlrOWTCyj27J6DH12CtEZVGsSqiLt5YrJq1mV8NSw+7J/hF69sJuDlO2r43YunAtF1Dyigj9UTmRdsyrCrSf45gQDQjYaTLwJFA0HoXA6W52UOyfTgy+EWxLzTDiF8xSjSz4B12KkIEEbXfrkODKrIfZxCDuQ1G2Mo+wUNVEEBey6G9isQYik2PO6tkwK33gzvmVzRe1jL5gDzlejR3OVH3aOfXAYCUAk225JaOgLcsBP6rm0Yr43ktZxjxrkbokBSA8QRne5qdcUaPOQxW/BI4KZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z4K9lm2nsFzcGjdy4PmXGDnvcsjEaLX2pepxG91Bew=;
 b=oGWYB8W9Gh32yrrTAa11oMyC6apzprii6EyyUPhzOSPofcMAgR53L9+/+IHirURvJzu/cieSHAf8WyPM3G1uVtSJSS4HnXGHhqFVMEqc1daN8rEER1yxFo+VZ8BPwEC/sx3VqRA2Sx0yBmUUaztyAbvn+jhypr2C3kgqvmsWBGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS2PR01MB9414.prod.exchangelabs.com (2603:10b6:8:2b0::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Tue, 17 Jun 2025 19:30:49 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:30:49 +0000
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
Subject: [PATCH v10 4/7] ACPI: APEI: EINJ: Discover EINJv2 parameters
Date: Tue, 17 Jun 2025 12:30:23 -0700
Message-ID: <20250617193026.637510-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
References: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: db17d236-5433-4a7a-f50f-08ddadd576f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UP+U6kRMroEZhaU55hiZHUuHFrbPszOrEHbL40x9MhHPPAE4iV3hH0z+TgbX?=
 =?us-ascii?Q?XlnRLfp1gBBVAJqqOWvyLrODMKwN0nC4nOHyW/mE0o8ZHCc0ADXRqIg+sE3C?=
 =?us-ascii?Q?lXk8YpEpfw5FBVC0x7WDXevS3/ZBcCvJnaJkWdcwTEnKrRF4j6qsOqNvwLLj?=
 =?us-ascii?Q?hn3Xm3wHaA44kV9n7Rwxs8z7qKrJSDRypoGavZt/aBItXuBoZkBgyHO2+DbA?=
 =?us-ascii?Q?5avLuGnEaI+boGiAPiBk4QreJcoFqfQcSKYxEJPRWwnGkiKFk5l6iYMhw97q?=
 =?us-ascii?Q?t8XFh1AjsfB6sPhJzvE0DKhDBhiBKVUwqTQ8Zajn/UWvlHOzSa2WzPPAiw7Q?=
 =?us-ascii?Q?BqQK563a3Mq+LE+vZNb1PCzmdOn4k++EHYqSOqLYzmRONob+vU7lbopmRMMU?=
 =?us-ascii?Q?7CJxWrLK3kpSk4zF6k4hR/nvcBAz0hKN42x8SBTl/hnmd/VV8G0GLbYroKtx?=
 =?us-ascii?Q?ANC/HAnQ5xCsP5TBJZe/EbaTdIsXU8bKgebMwb0BMqfK/xSpbYnKP4VDRl+Q?=
 =?us-ascii?Q?2YW+a3aIhs6a715qRf/j/CeprAlhz1swP0eRO2SbN6OhJrJH8FVBWqwAlB7d?=
 =?us-ascii?Q?+AfWQcmQsLTSaX9PsxB1WgHwq+S8+kFwVlW+x/bSwemkI3wHzRa9CLT1IP5F?=
 =?us-ascii?Q?yj8ahlAIPQq2KrDUBkp5ECKFtxlJoqNLagsZL09VBDBZQWknxKCe6jGZ8F6h?=
 =?us-ascii?Q?tkC9rUqncuOj2DNg+qQ6Zaw8omHBt1zB8geuLm50cb/kb0RNB/Zre5LMagGW?=
 =?us-ascii?Q?LLuL1rkTCmIoJ3ddagBrYgOmwSTJ5u3zWZlVsFCtju+U5FuIA46uFrn0tz3B?=
 =?us-ascii?Q?dVa8PrNSc3PtzJIsw7MwQkAxQFVcANnE2hIC6b+bokux4Z5ILmvVtF9qMOjs?=
 =?us-ascii?Q?+CQ5/qiMoEDiJlC9jpjRpkp7qhd9iMEUqBzdJjlR1gFdt5gAeIuaUrupSJJK?=
 =?us-ascii?Q?UQWpDkFaMQccE2ZHWynEsUk3Zt6SSgOyxC4DQHcot61/FjzsjLe0tXTsotsS?=
 =?us-ascii?Q?KXFtP32O+AmK2Mrl2AD0SwIPEc19uTVQNrz1PdOYLMh8omqkafHK/GUHyTAa?=
 =?us-ascii?Q?BCeEFre0nWgJ6qZENci79ZBGG7h6zS5EW6i459F1w6kBekoOIWdPE61ovGcK?=
 =?us-ascii?Q?+YMJ1t0z3R6BqKS50olP9lZSl/MQmO089WzTF09hdLEHQD98IHVMhQGXsBXB?=
 =?us-ascii?Q?71KX6+11Aswx3hmJ2wIGIPzvbU+3Zy1pzGu0jx8ywnjFIvRrgWT14QkattDn?=
 =?us-ascii?Q?PUwJy/iyxiP60JBfs37LS3McjXreasFnxjL1qtYvoshGjZZgBH4bPPE3P1E0?=
 =?us-ascii?Q?6SkZJ1aL+uW2ZLimLkg5SHQ8N6fflwhyLbeuThsCP9yCxWhRavD7lu/MpAwg?=
 =?us-ascii?Q?BfVTN3JWNXdItdd/1RrjOYVULH5IuVGf/n7QR4ZN0aORQ2reIGIpnZ4XAjwd?=
 =?us-ascii?Q?6xpVBJx94IphoR1sM9IgG78mMy/JTc0upvTtI7xplEulD+9rioKjhkqQKUNK?=
 =?us-ascii?Q?2DFpZdeGIEnxIG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CKr7DDqsYAIDbm0wcdkFa6zkRxedWQ4epLVXhq+0v7CTlgWrvtQVNVQ4bvIT?=
 =?us-ascii?Q?sFH1Cs/qmqg2DPDuV5VbuXOgILDRrKkobDPy8w7BMoXjaDyyubL64Br1G19W?=
 =?us-ascii?Q?pzem1TKw34XbWAt20KxVQ1x84d7U8srveMd9xmxyR08tedp6zI/YxyKbqUSL?=
 =?us-ascii?Q?pgKFhq060wxSZC2X6b8fJ3touYs/3KTGaARaMPeGqbucwcrTluRs8g3/64OL?=
 =?us-ascii?Q?pSi6yOtyncG/qRp3HgdHCmq21Vg1rd25Q/CEuLw/wszQhZiYtFEWnp7YLKwt?=
 =?us-ascii?Q?SPH0MGM6Kv9NRFAvBPZPEzY79ejpc7QbIzlpKjhW1KYpvc4ikHlcIHfztMjR?=
 =?us-ascii?Q?wSN1ZmGCuzvFHPoro6OHQDNEe4dCLRvm14sKgOsrqqeihodMknY9stW+YzuJ?=
 =?us-ascii?Q?MTIo2AOD/ZEVcbsd8IvXIrwuKU7dyrdQ6liSoh3DcDeQxevfskymmpcrwDLK?=
 =?us-ascii?Q?Om1Xhu6EhFCt9ZryNYiWq+WxW9qvNxDxztZw3bpFTVp0mTnBa61GH5rDoJTW?=
 =?us-ascii?Q?FwyyIj6bwqC9qjdcYYbEB4sYDGFJiIP52Lpb+a83Q85JtucYSge1z2fuUCV1?=
 =?us-ascii?Q?t5662hOHjY7EbmsAs4qtMm+uNM0UjSsXFJrU+XZot0cZ+m64Vcp9ryfPncou?=
 =?us-ascii?Q?1KPJaxqUHdfdP8gxo6pHqtrRxTKKSdRLtRA+6JKAa+EGjRxnlXKviaR2wMV+?=
 =?us-ascii?Q?C6FuYhGN1kD9+65xMYZIQj9xTh4KD3vqpOmm7yLvIq83uxKj3KZ0G6vq23Ux?=
 =?us-ascii?Q?1ktCh2HuQbW7l7793FdYK2h3PQdXF3ksik7bOyKV7flCmOXZea5kKNXNqG5o?=
 =?us-ascii?Q?unZH8dJ10Fc3J2I2IyBhodgoAg9lXwXq1WC9kPHWJbSmlMLLl62HNNY1WxGd?=
 =?us-ascii?Q?Izds43V9BlpUmclTIVOrypo9PuD8SXX7BRB2T8A5gqF5ncuI3joUhaiY8uco?=
 =?us-ascii?Q?oWpoaRB9ggyDSWibNnqYCfCxUWo/SJ7ymYurdEseI6t7Gf8hkzlFh+XhYCE8?=
 =?us-ascii?Q?BaItonDdLri6L9bYAbQP2WGNsR+JfGLDD5R7lB3gnqyD1tDlYtkA+tXGtNw6?=
 =?us-ascii?Q?l+fg/3mEKD0ETtyt7hHa9lHtbuswDJtYrlDGdg3cAYUGDUDIQR6AH9TG9PA2?=
 =?us-ascii?Q?CiJIKtRNll+XBHxDbBDyxgsWIMZCn71wYaRAveB7ClsW77vCS9l4ZlYNlIm0?=
 =?us-ascii?Q?f7YK4F2oaiCjV1UFEWjVKR/ePIFyX2hlj9MHBgV5nT1M0wPFqpT683d6ngyV?=
 =?us-ascii?Q?mMgC68NRikEuVByawqBupLs/sj2Us6KaKTVNA/oxua325X1YF76F9FFwOi0z?=
 =?us-ascii?Q?lYEblmPvOopLtF25uvJ9nwNvtjZ/Ehpmh/52i8+Xhy/CQ3PYTak1jSvEy7Vr?=
 =?us-ascii?Q?2R1G1EV6cKltg0N3rWrKtctdrwl8NFqY732adV4OQ7lbIsbxvs46qf4TerAF?=
 =?us-ascii?Q?aD+dZVc0EasDeMrYVJK/QmOgEgVio3Bai7ZednNGb1k+3AOYspfiyot1WouE?=
 =?us-ascii?Q?EuoEcHV6CbJzBDO4ODvpfpb0600pIL7EwFDtmJV5io2ezPFrMqt+2XXGPPKs?=
 =?us-ascii?Q?iL/57uROKp4YiIHQI6tzgifzo3QhX4RmuusNwF1hsZBVAu4YIoClvk60vWEg?=
 =?us-ascii?Q?gAwziF13Yj9I/++TkcLj7NU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db17d236-5433-4a7a-f50f-08ddadd576f1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:30:49.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJNyhmP9N9zZHo47KYECptcDSvwP5AwBurFjXgBumXke351WRc5KP1rWJEXGP+SZfDC9Y6JOwsyp4NALRX4K0cgDHlfIWkqf8do0SvWLgSbMyT7eCdbfObItxXrV/3hg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9414

The EINJv2 set_error_type_with_address structure has a flex array
to hold the component IDs and syndrome values used when injecting
multiple errors at once.

Discover the size of this array by taking the address from the
ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS entry in the EINJ table
and reading the BIOS copy of the structure.

Derive the maximum number of components from the length field
in the einjv2_extension_struct at the end of the BIOS copy.

Map the whole of the structure into kernel memory (and unmap
on module unload).

[Tony: Code unchanged from Zaid's original. New commit message]

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 1ffe8270634c..ea6fd4343e63 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -108,6 +108,7 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static u32 max_nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -178,6 +179,7 @@ static DEFINE_MUTEX(einj_mutex);
 bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
+static u32 v5param_size;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -302,11 +304,31 @@ static void __iomem *einj_get_parameter_address(void)
 		struct set_error_type_with_address v5param;
 		struct set_error_type_with_address __iomem *p;
 
+		v5param_size = sizeof(v5param);
 		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
 		if (p) {
-			memcpy_fromio(&v5param, p, sizeof(v5param));
+			int offset, len;
+
+			memcpy_fromio(&v5param, p, v5param_size);
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, &v5param);
+			if (available_error_type & ACPI65_EINJV2_SUPP) {
+				len = v5param.einjv2_struct.length;
+				offset = offsetof(struct einjv2_extension_struct, component_arr);
+				max_nr_components = (len - offset) /
+						sizeof(v5param.einjv2_struct.component_arr[0]);
+				/*
+				 * The first call to acpi_os_map_iomem above does not include the
+				 * component array, instead it is used to read and calculate maximum
+				 * number of components supported by the system. Below, the mapping
+				 * is expanded to include the component array.
+				 */
+				acpi_os_unmap_iomem(p, v5param_size);
+				offset = offsetof(struct set_error_type_with_address, einjv2_struct);
+				v5param_size = offset + struct_size(&v5param.einjv2_struct,
+					component_arr, max_nr_components);
+				p = acpi_os_map_iomem(pa_v5, v5param_size);
+			}
 			return p;
 		}
 	}
@@ -933,7 +955,7 @@ static void __exit einj_remove(struct faux_device *fdev)
 
 	if (einj_param) {
 		acpi_size size = (acpi5) ?
-			sizeof(struct set_error_type_with_address) :
+			v5param_size :
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
-- 
2.43.0


