Return-Path: <linux-acpi+bounces-10964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B38A2F748
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7C73A84DA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4D2566EE;
	Mon, 10 Feb 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kJ/AX1NM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020127.outbound.protection.outlook.com [52.101.51.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D5255E5D;
	Mon, 10 Feb 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212647; cv=fail; b=Knw7cws1xVQzhgXziIiPWYRFVuyXQhHVTDCrvm0j0C2YOcrnYiALR6SqDHz1iV9ADA1AyrEFu+qwzg4bhWbfunbcwcPP1z/M+N06IKL9DbPsKW5oLVqc6CGOopyRtth2vLMJsl+GyLxTLqgvoln3YkH5+JRQttg5PvRngEVJJWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212647; c=relaxed/simple;
	bh=h/75/6tbGgbTfJAgQleixF7WlE85+LTnt1R8panQoKg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p/LWRY0kwFz4b2wE+hmtxNybgZmeIyM/naVamn6tLpiABW0IWThkZnlH2mnK1bboC/WKc1lwLnO06VXyxYfytN3x1sjgYdVAZGZrToE7ImG5gDMdprp0/6vu9a8qFAYAetzDICmpv+liul+QVvM0zo8GLEPTfzecPRCfxw0RCPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kJ/AX1NM; arc=fail smtp.client-ip=52.101.51.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWYFrpSw11siH+77WMsW/dndW4Vpa26aVqXn2PeI8HfcOZBjPxiJdHplZwqZIfeGpW+5Ile4EDsw4uMO7lnd3ZMZps6W0n+gr4W/v+mS/5KFGFOXjSPnAiAJ8DMNGfvp4bJAg9tQFshrbYKf+SFPKtzLomcD2JkJpug+adEBamT9THZogQi/1dUBmjmfPHY9oNOA6RELV4qxHcgN5xHQfhlLIS0bEpR6yPLhV6lc2Kj0/qQ7m8OHqr0eTFaD6ijWzpnqcLWmH+dwpYI90Jw9QQY6P0p//LW7Hhdw8EP9u1ZWW/wpSOj0jhT9USabwY4OA+YWxB2VOhbRkP1DZIly2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Iw96XrCZsImEjBbBaMr99I59rm+pRnxQsSWrzp0qIg=;
 b=LM9zxd3tRbMH0031l70BroZRBrsVUYVVdFcbKrLp4akKkov9abWEzrGk42bpvG060ftgfqn/IwdMb0mX4WJk23F4vcLqq0UUKTH9tur47T0UyX84QkG3qKc49NDeWfSKyA9P46prkH5/2UzTMPCuLXWSSCz47pJaAo3JWrmC5ahrjZguRNF62pJ/vJbR0lFSC+dgQLeeCwmHKRIN4rT9YNRbfxUvB69ENPuAKuH9q0Q9pdNMjCCI/UffFlFRrJRSMY32dmmVqK832TOx4YegJDXKybYUVkqIYA0VfjfodTl4wSK+eHSRuj6MIugr2qmMYzApg47kCJzaTxAwJ58Fbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Iw96XrCZsImEjBbBaMr99I59rm+pRnxQsSWrzp0qIg=;
 b=kJ/AX1NM4v/yyi8yvp5S8UF3vW7VhrKLMQETUPyimoHWw08lyxWf6DgXdE5EyIAcAqFI1busaBorYKO6qdmZSOHCKjGcBPvlzs39jtXjPBgTJhn46FgNTb/t6336gWrS6BVegkynqFsC2YBBim/1JLVth3f/xESTKoGCnb9w97w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 LV8PR01MB8678.prod.exchangelabs.com (2603:10b6:408:1ed::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Mon, 10 Feb 2025 18:37:21 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:21 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	dan.j.williams@intel.com,
	zaidal@os.amperecomputing.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com,
	viro@zeniv.linux.org.uk,
	arnd@arndb.de,
	ira.weiny@intel.com,
	dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 1/9] ACPICA: Update values to hex to follow ACPI specs
Date: Mon, 10 Feb 2025 10:36:57 -0800
Message-Id: <20250210183705.1114624-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|LV8PR01MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: eca54ae0-3d25-43e5-37e5-08dd4a01f4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iC+TvL+Eha9VVTKz0xcu5VV9nOh4V4se/Y0ZSKyiji0dBJBqlr+DltiSiZnU?=
 =?us-ascii?Q?dzx/Lq0zenqRjWHG9shaHdV9Bx9PYG4GWBKY88lA90WkgCnvASwfx3AhRzOL?=
 =?us-ascii?Q?Jc43tKvwiY7/pgiQMGNrbpCQNCIBEX67uoREabEHv8sLdYNcieoJQg9tR+Qi?=
 =?us-ascii?Q?QhlWcorEEeDmtDu2oNPbbj6jqH5FKi2/SaPNAbPadzaH/R61Aj2HIXZZg4Uf?=
 =?us-ascii?Q?HjKH47ETlbSHzUYrJWdGLAiQIGtaJGyqUG56i93qVjOy90uexpqezgwjv173?=
 =?us-ascii?Q?M3dWjDprw9GF5ZNqYXAEIB2v0OGXqKz+K8cDqWAGKSGZntwp4AISdvFlxTVd?=
 =?us-ascii?Q?mTazbURSwqx7I12nNc4iiyFkP+655QxDuOzhjf1BzsWDVeI4gOumITUIMESd?=
 =?us-ascii?Q?Gku2mbtcIqISwKH5pMqrYnAnhintbUOTIOsx2IALlyX6fRJ+ggDgVRo6QbZ7?=
 =?us-ascii?Q?VsJcBoT02x/d35OZcrvhHYeV1EvrxUo0vLSpmnDc+S3DuPQV6HUguKFQdp2+?=
 =?us-ascii?Q?jxgkkoTI9Oltfs5ymcE1/R8qjF9ovZAA6YbCvl6aK2Ixy/zRJ+LFAIZOKWDn?=
 =?us-ascii?Q?+2w4rTAPjAjPOTxhVuXyWnCCWMzB/fm26VauwU3tPBbH2oooOnIc4SqNc1nY?=
 =?us-ascii?Q?bZg6oDwQYjVQtO3MuPzUjPZmLUghNN6G5NFKDBF7+zwYpxvxCBc9rGBLvvev?=
 =?us-ascii?Q?+S78tDFP1AvGdvuIwLxUP5fWy18NHT9u2z+jXK/Ni6Ab2HFyPVFAAM1GPTLG?=
 =?us-ascii?Q?D1ilU/pcAmpbgSxEVKQbYlu0OvVruXB6TVk4Wp8mddf+M7rEJ9sXPGgvXpyF?=
 =?us-ascii?Q?onHvG8hw/3wgfCTCWflC/DsVkhsmbaF2DQUD9QsjLxtTEhNU9nURjZXF3hP2?=
 =?us-ascii?Q?E3jvl+8JJduT7QR0CywxqPRXpVX1EWylUXW7lfmmXOQehvD5PgZ20hfHrqAh?=
 =?us-ascii?Q?i7y99iRPJjVZ+51muPXXaibAjJBeKgHrzeGSu8DYWKCGlRgnmhQ8nnvbtP2M?=
 =?us-ascii?Q?8P/uPSpCCZYDk012wk5ZdL0hO9CbtzrghTvcROoTsonSkhKsSFhq11bZBnud?=
 =?us-ascii?Q?8HJp5MxcT3K4Y0sKCJDtU0x7nTmdUgbG0BYhaQBOaiRtnZuFkOqSFSY5dckq?=
 =?us-ascii?Q?ln1COpMgdsxXUyx3/Co0pKeRWNF39vqLjk4sbeBoTCOysJeAfxxl9sHTWP71?=
 =?us-ascii?Q?O0mWJ+Y+eL0Ch2MFhfZOVgHZqgj3Z04Xy55+6J+qUUKrQtfgba+0IyoPJyt2?=
 =?us-ascii?Q?1CRfmXjIS8UZw/259GdAYWZKUxxW6oaSGk2wMEz51Q7PvfITMlLjvMx25hSI?=
 =?us-ascii?Q?zAndhjV5jGHtMzvHbqCnYFoNQPrAJYA7lrrhwY4gJrj2THODQzDWivYHzXi2?=
 =?us-ascii?Q?K63XGHxoDKHF6h+Wpwm9e4NQWU436kf4UivGNk87kBT02rTB6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ckcM87TOlfz/x+aZFrB8VQr3T3sl6zmrW1xdvHZeO7vmRRISpI2VTQm+gF+?=
 =?us-ascii?Q?so/xngFvZ/Wg9yY3YAAMBL8Sg+0mj+0XPpI2Kz9TdFzTc6pSXSSHR2R/PMtA?=
 =?us-ascii?Q?OZ//B6FKDKPzLF9gMoxX+pC76K0P/ry56HY9M/C1bhdBizNtLqiCmNK6wGDP?=
 =?us-ascii?Q?Xq+tY6HFFb9EqS/DLyRsLOJL4Ip1EB5GWsivnEnjdwxq8wS0Wo6TuKAhTRF4?=
 =?us-ascii?Q?kNxY22HNUxMUoGkHciGU+YzVh/OqA2LgXAbvIgNRa5eXueus+Nlo10hwWFJy?=
 =?us-ascii?Q?zflqggx9ed6nF7aN6XdNBK2rnrqdHDX9NQaQl/PlrE+RsqJmXbpvIjifZRew?=
 =?us-ascii?Q?sQ+ifQuY6//x4Fqrkf9PlOvfwT5KPGg0vjCJ6m0CX1nBfn9Woc8v95aHU7iI?=
 =?us-ascii?Q?ZL2tFiqV1gm+VlJetpKuQH01xqTUOSMV/pYrzibXi71Lkk/9gkXhcmwT4IDO?=
 =?us-ascii?Q?yWvcBPw45wf4LdcZUs8bC7MjUbi/VgqCRNamabTG/1822j9zJ3p+VoaxcM69?=
 =?us-ascii?Q?028tfv/JkD0WD/hoskK1xOV9GnwP401/IGz0zqcMiF1o/ba6Fpl35LOrBU57?=
 =?us-ascii?Q?GWfCOBY9zzykoSsBfcn5ehCy6MImH+Ib0VlEbqjAnFufkmK5wgiojrnn7Hzi?=
 =?us-ascii?Q?9/S8d2vgiydT0Zn74dEEdj056mNuFpedH0/MkBEjNxXjiItrzSSrimxeK8rz?=
 =?us-ascii?Q?JGZiXncFUZbbr1NRXoYxApJHV+OHMySJnkKTCxzQEKuP1X1zM0Wsw7ZjR962?=
 =?us-ascii?Q?O32jsSkqKdc0ut2f9deZm4KDQcJ2xU4S8/oSDQkVQKwi/Qdug/9jm7B5BgRK?=
 =?us-ascii?Q?S5Qm8F3qFWMbQ8yvUPnlDgFZ7DAL6iOD9IsBvmZhKLNY5itaDyw1zJOkopJP?=
 =?us-ascii?Q?rTiCJKRdI40P0UU1/ewY2eoKEbgyiyoetcCgLoxRbQZ3Xg1Oqxc8Qf1C3Fm8?=
 =?us-ascii?Q?5e3ncU+2i4LBumnaGqF9UC1OfyQLLnD0AEjRj8k6HoaI5OLtQAufvRRT33o5?=
 =?us-ascii?Q?rY4Rg4aJi/69+Z/aalclRjJ0Zf87+gRt1YN4IMoOVjdtylra9g9z7dukKeVP?=
 =?us-ascii?Q?DIZQl+Atr/Bzw/hO4nnfTvqj5Aygsd0GMYueFtuFqZxL7+jwKvj4WLo/WH6b?=
 =?us-ascii?Q?2fjD0D25xvJv2d/Skss/3fGLrYdNm1faamEAQSOQ8NmNjL+VNLUIGwnCLLIm?=
 =?us-ascii?Q?IFSZ8g7sm7VGwRnonBCu2ZgSDJ1q2ywnd+ddAZePwLRg8T8pfXDDwyYJnhOc?=
 =?us-ascii?Q?cMjut1X5gchYvNWF0Y+4pr8mBFzK5fioClaxv9MEfNMQIRKRajKXBOplxZzR?=
 =?us-ascii?Q?bRGvw41IzvcO74AUTkb6lSoEcHpmmAbCp3QTqz6PSheKYVZL17cpFCWUQC+B?=
 =?us-ascii?Q?UftdA3urszXGYlmhIKPL4xj3+hoeURvMfMsV7WoChJiNJbTprEG34sJEkwAr?=
 =?us-ascii?Q?ArB/G84wj3mC2yd9CSjFxnQilcfbEV+ZRy8ewDc1hiwMFFHTD1YFPZK51QoR?=
 =?us-ascii?Q?OXuiRHG8/lRgA/6OBv7dNqtVvVsJZygFFFVom06kcWrwN/4fsO9FG4WnFtmi?=
 =?us-ascii?Q?/Vc6wzHXb0CK7eZFFF3Rp/k+CXmMgg1+aPT8EY9fy8eJBg6koIcmpQngU1kJ?=
 =?us-ascii?Q?70skWe3DFd8y7FktHW6iNhs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca54ae0-3d25-43e5-37e5-08dd4a01f4a1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:21.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCegO+wrVsNGVjYO0qT5YmVTEjBru49Ce3GlGUqJFlFJojCkxT56jX5OPP8vQ336ylm63S/fSjZ51UQle3uLFwPYYRs+eOjUv6YTzWt5ZSsXTqnyHWv4mwvfI5h9kPDG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8678

ACPI specs(1) define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs. This commit and the following one are
not to be merged and will come form ACPICA project see pull request(2).

(1) https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html
(2) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 387fc821703a..c701c434976c 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1024,18 +1024,18 @@ struct acpi_einj_entry {
 /* Values for Action field above */
 
 enum acpi_einj_actions {
-	ACPI_EINJ_BEGIN_OPERATION = 0,
-	ACPI_EINJ_GET_TRIGGER_TABLE = 1,
-	ACPI_EINJ_SET_ERROR_TYPE = 2,
-	ACPI_EINJ_GET_ERROR_TYPE = 3,
-	ACPI_EINJ_END_OPERATION = 4,
-	ACPI_EINJ_EXECUTE_OPERATION = 5,
-	ACPI_EINJ_CHECK_BUSY_STATUS = 6,
-	ACPI_EINJ_GET_COMMAND_STATUS = 7,
-	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
-	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
-	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
-	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
+	ACPI_EINJ_BEGIN_OPERATION =		0x0,
+	ACPI_EINJ_GET_TRIGGER_TABLE =		0x1,
+	ACPI_EINJ_SET_ERROR_TYPE =		0x2,
+	ACPI_EINJ_GET_ERROR_TYPE =		0x3,
+	ACPI_EINJ_END_OPERATION =		0x4,
+	ACPI_EINJ_EXECUTE_OPERATION =		0x5,
+	ACPI_EINJ_CHECK_BUSY_STATUS =		0x6,
+	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
+	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
+	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
+	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
 /* Values for Instruction field above */
-- 
2.34.1


