Return-Path: <linux-acpi+bounces-13099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99255A92CF9
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88C91714A1
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFFF1F8908;
	Thu, 17 Apr 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="uW/euJga"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023137.outbound.protection.outlook.com [52.101.44.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07615F41F;
	Thu, 17 Apr 2025 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927234; cv=fail; b=MnjK7jopZ2YHbMPEXpFYVC4/jPdqGPpg+sqED4b2kioWeRypMc2/fBgMB7CifVHQmqqIkCMiP52rBRdZIkZV3sTnpfbNZcNgKOwyZiqInoIYFXBzmnyGA7nHmuVGQ9M3ylTCtp0xjZDYnpaoEims8kR6BGoJ13XrlgswsM4f5Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927234; c=relaxed/simple;
	bh=V0bZTPazWnLKQvzaWtXS62zTYTbrdNQFPztls2HwHEM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uKYfVlNrISkO3WctOnd4TqN7T9OHxpHuzJGkgat/kCBYerNucofb0nhTOlQhktQJPvNWiU7+oH1BdPK4XEmHtAA+Gk/GxjjMY/5o3BAlowDXnVR1EktcUWgOiYxlUOy17xnsGGuQSHmxh2D7oX9/ObbR73jPZ/MZYOwTxuWiOsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=uW/euJga; arc=fail smtp.client-ip=52.101.44.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wacT2+eCogUmhKoIrRRufTY3+5etII06Lt1cFmkvoMh5YvJUS6kcinejpDVHyM7np1cX8fpKjcdi7OFvktLdQaTgGhceC1LbCVolcRYAqQZ+UAP2T5OpwYtavJ+I86GDkpt8TTKyujAl71/n8uQ0YzxqNaHhToYuh5xuuKLtw1dTBwwoSTFZpBU9Q48X3lIam/kokPaoY6rEqtO6rtLVZTIJKGzWr1bGfWlYc0vlI+PwLXAWyusRBjLBdug5kcCw9PDMr1iLHYjhA29Z9ZEo65XlGnSP6qqbypSzPALUgtcbuCdXunQqwZU4a8qynV68cxWsSFHjkAsV1wBrV3a9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhdetV4yJOXvYhSU2u0Qz3BH/3pfqJjG4jUb4j7U6Zg=;
 b=S2Iw47uIDWngzDzhumSb2UeeWAhZjGdzqpMU5wLNbO2W9MRmGaOf/vr0ad57SgJ97f826ZrMJzJd2vuTBDtrc+P/RFC75fjVMuAvJ6GTpdkp1hbp8jNyZtAc0nWn9yG6bpnTxkiAIyVEVaiONaYTpQqR+kwaGs57/GUYCwwn/iOgpAgtLxA3Wl4lwYnrHlbvglCYyUkoBobmRE9TQ9kJZz8dr5m/Q7VrqwM3X0JzYbQMQYIE1aT0lL0WI3Plrej+beOFIu8nmJoKtzzNJsnkIBKwzELLWNtsOdY6j7yLHdbrNNhZiJZUdSP+qG8B6rbSnfC3HldRdMApdEysEXTp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhdetV4yJOXvYhSU2u0Qz3BH/3pfqJjG4jUb4j7U6Zg=;
 b=uW/euJga0E/KyJZzgowUbD7ZUrpdjYLGEDbC6a1u9HSPGMpdDL0qGGl0uIRb4PAvSLlST1W20nmN6KwNnNwwACBqOtH5XwmFVIxiV/A6sxtBRLRDsr++7broyAWxQqDrQMEbpXBF9e+U3ZvNVw59gO62dVaFyzIGde4EjNEbzMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 LV2PR01MB7597.prod.exchangelabs.com (2603:10b6:408:17e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.36; Thu, 17 Apr 2025 22:00:30 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:30 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v6 0/9] Enable EINJv2 Support
Date: Thu, 17 Apr 2025 15:00:10 -0700
Message-ID: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|LV2PR01MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 107ed6a6-7961-4c93-2cd9-08dd7dfb448e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?orfRYqpEv2ftDS8WAsy6hl90XXWzuXnFt6TWRmSoioitcQI3rNu9F2TqzM4q?=
 =?us-ascii?Q?YyIWKD+86a6ptiH7KlGoxY7zcYrLY0JzCF91g8dvZyXL3P+q9CgckJvFvJ7V?=
 =?us-ascii?Q?fxOFEol/m/Qk9x4MI+GBJfkvNApguHSQA1U6BtS+vCWcLKVllL3oX8GZzFbF?=
 =?us-ascii?Q?QMjjNEI5hSb14/+XpNoTWujCMluRtT3p2Jqda7FO5cQUad1zl7rh8owg2qfV?=
 =?us-ascii?Q?6Z5U7uRwI/u5ihuxusGE9xu7GHZcZhcRH2Kui+AlIjfa0eJ2kwfSpM8aheb7?=
 =?us-ascii?Q?xGBg5H1/SUxdHnbTXI7eAf2YhHFZxdPf7ngHyijIgGn1CV7ZsvRAMmkgcSrq?=
 =?us-ascii?Q?142wmpoibQoEScWB86Tk+yPrbuhJ8JwmOUtdZgvM+JDmDJTN3k9NnZfnU7ou?=
 =?us-ascii?Q?uDcqRHOUg39La8GQ8gldSDaGbn7/4xOeLloCqWN526GDWxEilOTEEQOwdce2?=
 =?us-ascii?Q?OL4bGnM4QlPnMdtJwEQ56hWddLpqD7awf06OmPhDaqG04G8AVAew0Y3IHgAk?=
 =?us-ascii?Q?K81dfowcO4uToGVTPSYAaFilso5gRmWFRYk7B2ptnx8PHGZSCdCiL0o/93IY?=
 =?us-ascii?Q?8mmewHjOnOovDM0i2tN3qjQBGnMFBd6HMk+LMJqS/AoAB5A1xei8dbz947CF?=
 =?us-ascii?Q?m4r6OM27E4CXr8hn1bNi84MMZZkijCCVubHzQDJ1LJJ2+t0NZib4Auz/fmCN?=
 =?us-ascii?Q?uwTnFDh1snci7p96enXtJ+1EyLBOcliW0WdGnSEqiM+V5n28JoRhXzH6mqVs?=
 =?us-ascii?Q?NFWaUEvEVjpVcommBjuA+fEZ4bVkrJFV+r6XZhMeXo0QE4m2/hyfehFdpkDY?=
 =?us-ascii?Q?o9SQbtJfEaDqXEDFwXwHPmTvxetT98HUSTFyC9ZsMJHoiBjDwybe2zzmHXTG?=
 =?us-ascii?Q?U/R4n1qxNujyBJBGH0LoTA4a6iM0KvK6fKN5A0mhQoKnfgjYmFjWmtk0WDH8?=
 =?us-ascii?Q?TRO7vR5ppuVejve/lGp8Nx9AnuMcyZ7G5mKUtI716tzQnQbEkAPdBUeO0cgv?=
 =?us-ascii?Q?DXqtRh5pkX8nX5T17hPfNOhWkHWRh32SSVyeTcoGoyPW7tEr4+VRhC7uq/yx?=
 =?us-ascii?Q?g3lxBvuREcK7ROtueyK52X2+DBGujLpFf7G3QCpm8SeHp0nWape5f6WdkJh7?=
 =?us-ascii?Q?GlMhmtmb4JKLv9kujuBnTvyNm9ozRSnFYgQSMPxiYBvNZWuv3bhRbH4RZHsd?=
 =?us-ascii?Q?z020yDE4XNZ0ADnGfhciI+9UrswEdZ8F1zFuyanaeA3dCr1FxWaHLh1PF1J1?=
 =?us-ascii?Q?Tls/OZyjOPsvD1iofZdYPT5Id4sOCgvU70oM0tsavouKlFcWKnMhH3p1tkcV?=
 =?us-ascii?Q?9n1ISjc4ochu1h6i6kGUWxpNCNn+hsUi1WKo0r7fB6HNsUuF2F9qlVZ5Al/n?=
 =?us-ascii?Q?8o9M/wvgQos8xq39QGcty1nZJsvdpKh/xMSSwUDVmvsZlQbv0muOYGV6+p8h?=
 =?us-ascii?Q?n7pcvEcBmD/LZnwxhEiE9WluUYrMC56bw+gqyk1tVzNkxWYyv6TW34+f2Kpw?=
 =?us-ascii?Q?7oqPcWVI4cJutTINAFbE7WqJNY2sEMjzNvXs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?an8o9/hxxvG8TeteOKhqxP2lp8Fa7FS7SvXMxryxovwNFjeh7MGhu4xhdCeU?=
 =?us-ascii?Q?icyVWEgcEOHBCP6TlKe4zcq8J00OmhAGYColKvr52Z++Rwbbi5s0NUn12+L8?=
 =?us-ascii?Q?NqfqY0hvTqnd1FzmYmYZdWHydZHlKp9bn7Z8vBSgYnog5S17fmP8U+i3Ene9?=
 =?us-ascii?Q?+leD816jYRplbqUJ0lLm9ngoTPKyStnTZzJZAQMhPfgJDl9UMWCVfKo2M3FC?=
 =?us-ascii?Q?T3zN6zEYb8KEN9Qa0oY1gA4LRdGsWs+ORT4dhz8P95f3lJVX28dQqGbrD96R?=
 =?us-ascii?Q?h/MtRBfLQ2zCAssLSSgrph0YZ4UZIJXZuE/DAhg2HbJDI6/8W8cn8MRem4Qd?=
 =?us-ascii?Q?3ypF8hLKF2FV9LUDmZLDGXPQ1SfQcd94G7pkhs2NV+CsgjaBOLn59IeBB5ce?=
 =?us-ascii?Q?pud4dPqMAJK3szL1rFu7do8VLZu9s99fwtVheGxHJR8nNN5y935MNTXGp9AL?=
 =?us-ascii?Q?z/V1GDa4PpJx8eGTm5Shhfx4k2MlWvChpePBE7GBGhjcAs6DUHbXc7FWPnQ2?=
 =?us-ascii?Q?DyPl+Enfn3Qbcr9vl35dLzKT3FuO0zpECS4hsbgRrBsEi9pgtWhEpVcngQ3t?=
 =?us-ascii?Q?1zlmQbWXCJ0ASVJSQgSMHn7UFbnmHgCrj3TCM0Qw17HsQ2jT5cRdOSgTFsO/?=
 =?us-ascii?Q?DKfzI9yAfVba/W5k6QZD7heSlKPMS6QTpPa2LwAtXjWl+JubnkqDTxfP8eIJ?=
 =?us-ascii?Q?xBYT84qzISdsLJfV+c4XxFmVkrsspPHswl0zOscJnArH+RPQPrjDnQJvpKjR?=
 =?us-ascii?Q?Bt0xcBafpPM19/NIEOZTyM0bp+NqNo0c/2gSAQWLc4SmU2TF8Luo+FRQm63M?=
 =?us-ascii?Q?pik10BQGags35XYSu9Jlo7n5GtvHw554Q85XU5bbI11+xI5uXsEPF1NB1KEA?=
 =?us-ascii?Q?y2ZKIXHJSjzdZnRrJ8UEP/hSXKYFonpDFSn04X4aL5VqU3pl3GHGtNvmQjqa?=
 =?us-ascii?Q?TSm0kZXQlyb5adFZk0PQEbLNEzbA/cmaK1uHCCFkIf0i16iqIBGg1Wqn/Lfu?=
 =?us-ascii?Q?327GPARjKdx0WU+xXTyrSm51eFy9y7I5nE8rkdL3M/VUGSBuCZcLVWGY7Fpi?=
 =?us-ascii?Q?2AI3P2E46340qPtNaxKzBudfnHX1ErAjsyjRWhN8YqLmxx2wJzZCQqizTp6j?=
 =?us-ascii?Q?Bq0LliAUDecrSccQSbPL6bgCQZawFAB95hfxZa5I1jFBYBIktIenaPdgjgJG?=
 =?us-ascii?Q?SU5PfYweg/lMv7/96/MebBBOvGMeWMis0dDPIg7cpHQEI4k5N7Cfq3K9uoL4?=
 =?us-ascii?Q?1kVhv7rrAXka1Loa9w0hgmRwdrLY0dAhl+ELi2rPCOUiOTRYblLJk6aAPHz7?=
 =?us-ascii?Q?C5GlVuLQPfP/rW8hdHek3DF3VIa4mJwUPETAkY1E5hrUZYBhG8lrzSNXiBR7?=
 =?us-ascii?Q?vCVi1LlLWnA5t8hxOiGmAsxVPCFL6TkuUUL1L1MKT+LsuGOdjA/M1rty1kgA?=
 =?us-ascii?Q?PsyOWdezKsKrSeywUgCdr7Sj2IUBoB0Uf6On1NcL/phCu37oy82EnbOi0CMr?=
 =?us-ascii?Q?rI0Wimo04pptTrrXDBh89owo3juy9rqfIjhPDle/Ggza7W0gyiR4ICohUUtZ?=
 =?us-ascii?Q?ko166AxPhWN/9fmvKbiPwQpb+lDxhT55imJiYFrGGEM81pMcNRmaQW7jeWsl?=
 =?us-ascii?Q?CXGIhtUD44jGvnFdJ0S6pNk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107ed6a6-7961-4c93-2cd9-08dd7dfb448e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:29.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uta2DEn0540JAZqo+HZqCSh4b8IA6g2wRoFuM0xUf74spZLMerc4Ru9SYBe3HeKnJik6XqdbmL1ag7B87WRbSqwC4BMyat4dcLMsGEYTBxEfUU51qBsfgG4bDZgGa3id
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7597

The goal of this update is to allow the driver to simultaneously
support EINJ and EINJv2. The implementation follows the approved ACPI
specs[1][2] that enables the driver to discover system capabilities
through GET_ERROR_TYPE.

Note: The first two ACPICA patches are to be dropped once merged in
ACPICA project, see pull request[3].

Link: https://github.com/tianocore/edk2/issues/9449 [1]
Link: https://github.com/tianocore/edk2/issues/9017 [2]
Link: https://github.com/acpica/acpica/pull/977 [3]

V5:
	*Users no longer input component array size, instead it
	 is counted by parsing the component array itself.
V6:
	*Fix memory leak.
	*If EINJv2 initialization failed, EINJv1 will still work, and
	 probe function will continue with disabled EINJv2.

Zaid Alali (9):
  ACPICA: Update values to hex to follow ACPI specs
  ACPICA: Add EINJv2 get error type action
  ACPI: APEI: EINJ: Fix kernel test sparse warnings
  ACPI: APEI: EINJ: Remove redundant calls to
    einj_get_available_error_type
  ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
  ACPI: APEI: EINJ: Add einjv2 extension struct
  ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
  ACPI: APEI: EINJ: Enable EINJv2 error injections
  ACPI: APEI: EINJ: Update the documentation for EINJv2 support

 .../firmware-guide/acpi/apei/einj.rst         |  32 ++
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/acpi/apei/einj-core.c                 | 345 ++++++++++++++----
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 include/acpi/actbl1.h                         |  25 +-
 5 files changed, 314 insertions(+), 92 deletions(-)

-- 
2.43.0


