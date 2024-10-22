Return-Path: <linux-acpi+bounces-8914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2799AB8BB
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93011F243A1
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE381F8F12;
	Tue, 22 Oct 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kAQ4UYWM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB61CF5E6;
	Tue, 22 Oct 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632892; cv=fail; b=n3Wm6/kf/68MobeBHpSSmnmW7woRma9/IludKgd/cC6qjfFVgRztkoEi3EhhwF7/iUskmfAwS6XtsjRmnvOeGUCRugQlHmTisfVck794yYHbfrAmTTbao1zewM9gR1VElr9xhY0SfBbqq2L3njb+jcwKCkBkqGHUNYdy6pSW1Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632892; c=relaxed/simple;
	bh=6K9Vu4L6/O1/OTZfk2//JqeRBYIJN79++zQgmwajSa0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J07MW4T0yz2pdnSCFm//oZyJ4hLDQ88wzoZjsdviPRciSCnckgOaMiPONYPUyUzonBOEhF0wE6nJuWROckgt7Wvx/9NCs8J9VeAYZNcjpi35e8ckXUleTOubiyMNnzKfIL6ipv4fBkBSHYjrgmoRj6OdZGyblXhwWhIjYQSRGGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kAQ4UYWM; arc=fail smtp.client-ip=52.101.62.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVT89+MGguB1O94gSoydQvopfjq5kkOWt0dhSC7cJSkaAu5LLAH3/J1hkwHYTfmfDqLmT11Ay5I9sq8WOaDeGgAgm1VMdlkxrrsyoL8UmsDmisdAjSgl4xPBDqU3fkcxBw29WadOMcaEcIatR+xI4EiJ0tAatfpPHEUdl/3BX1UDedbwEs8EOA4qbjFzlxHtZdT6ozGkWfboZeChm7p4GC4FvoT+2FBmZ33Q/IPlSqD1rC6Dlq9u6r/hzduaX1xj94bpTPH+SZJibCASymQZ0SaHLk0CRj+Y1G5+oVpUNleWpp3Ci4O4VZ4nCGME/AigR7O4MZzHb2svD+TEXPfw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4uw7zLZyAVtMaitfutAbQhVjfCOnOi6ttCLIFIsHGU=;
 b=jpOHZnKG5uNanVWwLgA24YC9WOZMywKoF0RiyrF1PW9N+4bqn3oKcFVHr0yR3x+yr8lV86CDerOMhmLc8Eb606TzS7hFfShroXjcPjgD6YF7YBJWk/kCj134rDIFm4zUvQPFSfFDSKW7BTAyY42O3lYdxu1WWqCP5yHfn3QDa98IvOvcMn8EKLjHUZYx9+eAoL2BVY758EaO4yQyZHJ9fyds4qYPK42bf7S2y93dNEfbPIio1BU0E5F/RqswmRJhLoF7zAl7GWgkPK8vB7O0si3sVGR7fmVMNpeQpg7VtkoDrSb+3ku4A91RU1S5JIK9liuDZfL81SnCCtRGbRrfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4uw7zLZyAVtMaitfutAbQhVjfCOnOi6ttCLIFIsHGU=;
 b=kAQ4UYWMjEmLpRLXPm+mbLRItk4mJUeHw8zeVpOxU9jNqEwbWJ7EE31ZQ8f6XlulXokswBxTVrx2Qt895oSaxWFOqHXBMfCmCguJLwyeU/rPZgSbIgllywwAr8JKnObNbuF6x+2UR488wfBCimWRxz/Sftoc2ghh1EUjBAwa8k4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8991.prod.exchangelabs.com (2603:10b6:8:21b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 21:34:46 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 21:34:46 +0000
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
Subject: [PATCH 4/8] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Tue, 22 Oct 2024 14:34:25 -0700
Message-Id: <20241022213429.1561784-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS1PR01MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 40388e7c-3b81-4b77-4cf0-08dcf2e15958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k0iso+viZqxJenZCqq5kumsYfTMHM6mZqDqb7t4dvjrdPs0ZJ3C/pci3vSg/?=
 =?us-ascii?Q?tuwb3hlqtkXEbycs9Mj2+QHC3AfSXuxXKoaOlmGmlu00x2eG9BGF+UbZEOG6?=
 =?us-ascii?Q?CWOfud6GyBU5SNRApu7xTr+Xa5v7zzqTOw/bW21nDIfCEsh7iopmtORkpOZt?=
 =?us-ascii?Q?LTqm3WazmUfVPZdhURSnZg3/4nCgPUVGdtzA/1NdrCP7SUypKWGuva2Fd/QG?=
 =?us-ascii?Q?8s9sQrEyZQEJuPmAnKg3L1lsSsNNEOlXepfIzMrOxvF8JV0EJzlBnYz1IwLO?=
 =?us-ascii?Q?oKGrvsostatfepMVnDE2I/xCd93CS0ELq5FYj5svCzvk3xLGoi/sq0M9GvZj?=
 =?us-ascii?Q?kSRtNKbqNTJ/GJBFL19pu8HOSEqS+JqGAQUWAo+5bdA4ITHPBpdcudxxTIms?=
 =?us-ascii?Q?g4VuSLTk0ZLsJaryFOhRr5fPWtlSIkvGo0HoZ50t4RItTOhlqOH+TjtmPB3T?=
 =?us-ascii?Q?I5m/Sa27KHDh7YESDUDFKn1DRoEgJ8mgoNzd2CeOpcNHdd7qgSr3WpPklVx3?=
 =?us-ascii?Q?sySi2xs7C+Ll9pCX32SCUJ4WQgpdMeXRTJXOTs+IY01Ia/0Iip1z+AcPoUMU?=
 =?us-ascii?Q?eZ5JavZyFFwxkmKqmJBeau+uSo2EWkiL7qErfcoAVq84UsFTIonT9qBj/3Yx?=
 =?us-ascii?Q?4HtPl0QtHOTHNC/rxkoiUyIvDTdEjpRh/gJ0JsQj5rdeysIZWHpvdzFCO1uI?=
 =?us-ascii?Q?l+CBkMb/QolVkVfxP7z/35MTsELrqMEvlIuRKHdxnwAbCKI8YDGtXKNGnB3I?=
 =?us-ascii?Q?pqEY8Y/pR8oY/jClDTRDorr2zh9x9TtfgYrIGm+JZTf98INvnh2tOWNXxOfZ?=
 =?us-ascii?Q?VY3308aqAaYcmUbO5PInoeXxjAvnhlgm02G7wKLvD9Mb/eALr+0vMKMV15x5?=
 =?us-ascii?Q?JyxnYz4UagM3nXpMvTvqmZw7QO6CJU3K2u6SczmycZIiaIod/Q82Dnn4l5Vv?=
 =?us-ascii?Q?HOPsaxdLFOPudIWM+WlVKWn36TF/8hx3ud0CLlhlAXLlxQv6Q2gMcruRtIES?=
 =?us-ascii?Q?oBOvMQaIbXRg0LURjfS33OyBxQidoYKO7iPcjRnBVzTUhIbiP35WU4rQesvN?=
 =?us-ascii?Q?hpYKAsk3GnHiVejnu5NLuuxtao6c6of8PVIV0EeIe6fYqW0y6+w3TkD5RGbl?=
 =?us-ascii?Q?72oKKtGmbh0S4QENqFAAhpeSM/rD9BO3JPbLjONmOpGkWEi2iaIde2EDDtvx?=
 =?us-ascii?Q?ELjdkYIvWXlu6c0uPUsi7JK/q1759MemyChjfLdMXfdrGaoL4VH3h/gj1ZPx?=
 =?us-ascii?Q?+vW3Q/+KVGOxrzuQfR+K0On67zh/ivoRTvIb243bqOfEzsdM+kgFWeAnTTZT?=
 =?us-ascii?Q?yNpT2X9kbg88B5xIZcUMJR+hLn+YWKV4WpW7q9cXDdVNLX4BIkWxr3TuQKow?=
 =?us-ascii?Q?HQbVMkliEwSGZmQC0vqX6YoI84Sm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P7taSpamMOrNKrn3zi8zJ5LvvzELo5XSFHJlDunQEoMxlItBMIi29hlNB+4c?=
 =?us-ascii?Q?7Pd5l7dkcWn9G+0SEt1Fz8iFbGYAdFWmhPMB/tLQJRTKNwDfSxcPhgYHeA+w?=
 =?us-ascii?Q?hefwKhh7R9YtvoLtl6pThffuROzqxXh3dfhoKLyEfHtHYE1IEh6uW+XuNnNf?=
 =?us-ascii?Q?JCwDI6OFXzfXdhC6vtTtKZKGeQGwCIn0MKU+mdDsEvGD3CdV9iZNeWZvKNzK?=
 =?us-ascii?Q?reEhwg0xcskMtHG3NWZTWQ5RHsKJfRVECk1M2wcoQQaTqg3lWYQL/m6cf478?=
 =?us-ascii?Q?dr87HJdc+QHz+YhKvFlWgwDM2C/3NdTwVn9sT43fSaI/KMBCwR43yqTDPLF3?=
 =?us-ascii?Q?zQgzwZbiJFJ8Kk1S795BPZmk70kZtgb+d1qdp4mjQ0WzaCwtFCXWtePTmg+W?=
 =?us-ascii?Q?KfU77ofAdoMpRvHTItNgP2OvvMQGbV2A4mpXax3MQU/taVXAHcjqf+AbOSd8?=
 =?us-ascii?Q?yKmQpeEG7eECJ97Goe7B3BO5iZTQmZLIgU4Jcd53XFSzGW6mfYGqWqq7FxIU?=
 =?us-ascii?Q?dq3INNkTPoEUttCseqacTXS4DPzuv5a2vWtwa2qQ5imHVg7NZmK9iyvi4wFV?=
 =?us-ascii?Q?E67A9ul1ZNge18W/tCD34WqMAfmcVb7zuRG8EjjwnGNOWoqitnM9qhjqiPzZ?=
 =?us-ascii?Q?H9FS3O6KkMr679SCou48nI24+TvHer4sjw4IHcC/2m5SixxB5E65s94nDjGg?=
 =?us-ascii?Q?q33BzYNuKdrPAT480kKzE0pFHZUhw1EUbFhbOImTz4yr7BYPD2faY9jrchRe?=
 =?us-ascii?Q?Jg/Y7qDibF8e8B099r0YV5KXDIXF9X0Mnpm9nwIwgZ2bYUGePT8rSGf8rVTS?=
 =?us-ascii?Q?7Jwoako3NyW1rGsy4KhcxBoqwT2QEtI0C6a0MatjcZvblRi/kf/lTo+xPj4u?=
 =?us-ascii?Q?Seh1VhrxBT8fu/xMGzhNrhgUZ80XGuniKFWTfoYfE50YsoPcmX/5sP4yw5q+?=
 =?us-ascii?Q?mXQC85ohZSjPzdFKVkMFHJN8gbq4LEI8gVotzBblYXkFOXe+eNdgGSNCPDot?=
 =?us-ascii?Q?Wq3wQSitfoV8sFmVs77NaGEfmwULio5vVBsGMm2kVC/Yc7cGz5Pz6swj7A5L?=
 =?us-ascii?Q?fAVcu8LKCoQME+C1e6YGuBewUocqHXq7FjrK2mNakWQDeKkfOObZzHcO0WSW?=
 =?us-ascii?Q?Mtt6F/KbKd3G99YSfAVf7Bs/ISpPk84tIeWZWZfxzAn/RZDO8+lr9N213UC+?=
 =?us-ascii?Q?G/CQZn99gNefEyNTCUQWcMn+ebmYyc7rGVzolWlv93Jl0jgoa0rzETkX2pic?=
 =?us-ascii?Q?ZeoR2hjdDMA3TCbevs3HRjYnM8fVII7Ly9stlx3HBUP9onKsCWyohdiU0sok?=
 =?us-ascii?Q?9bsqGhNlMqFeF+N4vCXGfl7ggwkFDr5kVJjLzZBEblkvPByoRrX2hG5wbbso?=
 =?us-ascii?Q?ta6/G7C7SF2UXG3SI9Y/LECzkxUiBlOPCjii4MMFXcnoD/c8+eD2Fr1GsnEA?=
 =?us-ascii?Q?W2cmTxeMj2xxymFyVJQx3qWrcIQYa2CzAU33duuap2BM6BFnd8+IAP4q44Sf?=
 =?us-ascii?Q?p2oRTcKITh1uTcabpkaYtRbqaQguV87whYi0U9x293xM67w6ShnaOH28Ipi3?=
 =?us-ascii?Q?/v9zdswhBu9KdevLNBTEU0FseUUtvxswR3eRO43xKxktjrVOM8QeiC/EYw3L?=
 =?us-ascii?Q?VA7u3IyRxEOc9VaWhde+AjI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40388e7c-3b81-4b77-4cf0-08dcf2e15958
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:34:46.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ranh8ELR11OK6WQLTIe8OrFC84yQGLcnh2lztlYG6aJJICjxAOoJKMeFe6ZJfXgBlbLOJ19m7GnnIWRK2u727FgrhB7IRPladt3S7nbh1J1qilwozpx76x5z+V5lzXEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8991

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/apei-internal.h |  2 +-
 drivers/acpi/apei/einj-core.c     | 33 +++++++++++++++++++++++--------
 drivers/acpi/apei/einj-cxl.c      |  2 +-
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index cd2766c69d78..9a3dbaeed39a 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 
 int apei_osc_setup(void);
 
-int einj_get_available_error_type(u32 *type);
+int einj_get_available_error_type(u32 *type, int version);
 int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 		      u64 param4);
 int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 78c5a20115eb..3621f071a735 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
@@ -84,6 +85,7 @@ static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
 static u32 available_error_type;
+static u32 available_error_type_v2;
 
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
@@ -159,13 +161,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 			   EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
 }
 
-static int __einj_get_available_error_type(u32 *type)
+static int __einj_get_available_error_type(u32 *type, int version)
 {
 	struct apei_exec_context ctx;
 	int rc;
 
 	einj_exec_ctx_init(&ctx);
-	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
+	rc = apei_exec_run(&ctx, version);
 	if (rc)
 		return rc;
 	*type = apei_exec_ctx_get_output(&ctx);
@@ -174,12 +176,12 @@ static int __einj_get_available_error_type(u32 *type)
 }
 
 /* Get error injection capabilities of the platform */
-int einj_get_available_error_type(u32 *type)
+int einj_get_available_error_type(u32 *type, int version)
 {
 	int rc;
 
 	mutex_lock(&einj_mutex);
-	rc = __einj_get_available_error_type(type);
+	rc = __einj_get_available_error_type(type, version);
 	mutex_unlock(&einj_mutex);
 
 	return rc;
@@ -647,6 +649,11 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(11), "Platform Uncorrectable fatal"},
 	{ BIT(31), "Vendor Defined Error Types" },
 };
+static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
+	{ BIT(0), "EINJV2 Processor Error" },
+	{ BIT(1), "EINJV2 Memory Error" },
+	{ BIT(2), "EINJV2 PCI Express Error" },
+};
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
@@ -654,8 +661,13 @@ static int available_error_type_show(struct seq_file *m, void *v)
 	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
-				   einj_error_type_string[pos].str);
-
+					   einj_error_type_string[pos].str);
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
+			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
+				seq_printf(m, "0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
+						   einjv2_error_type_string[pos].str);
+	}
 	return 0;
 }
 
@@ -692,7 +704,7 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type)))
 			return -EINVAL;
 
 	return 0;
@@ -769,9 +781,14 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		rc = einj_get_available_error_type(&available_error_type_v2, ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+	}
 
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index a4e709937236..5ffc4a162c70 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -30,7 +30,7 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 	int cxl_err, rc;
 	u32 available_error_type = 0;
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
 
-- 
2.34.1


