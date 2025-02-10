Return-Path: <linux-acpi+bounces-10963-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB60A2F746
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06393A23FA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D5192B84;
	Mon, 10 Feb 2025 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YIA4QpM/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022122.outbound.protection.outlook.com [40.107.200.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5279179A7;
	Mon, 10 Feb 2025 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212644; cv=fail; b=P9Z7K5nhAFmHEk0RsEDASfD8ujrhO38zr3gQzxB6jX0e0VYr0pSPXvoE808nUBx8q0Jh1HKtrX98MsDTO5USuGSzzQSIQyEv3UWkO6zLOTwWQ7Qk3R6fnse8S6QKauWWPJXWCxRVQ8WpzY7vPqMEX32Ybmg/+YoBzcdMmcos4Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212644; c=relaxed/simple;
	bh=N34WjkqU0A2sQeWS77WtsOZp0VsxNsF4YH1EXi74cnE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZWkJ1YSKongPLLZucPmBElwhHWdFhOMn7ezlxrprqsnpOHwszf0rkBiOA4MrHLymA2bh3m8sP8Fpol7FRRFAe52rZsfC2d/ILLRMKf3EdHFgaRPn/ltOuhANhlqd5ios76Ra+Sx433AG8vR8FzKDrgA2DQCHd0yHxCO5HK8SHSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YIA4QpM/; arc=fail smtp.client-ip=40.107.200.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QecuEG8K418qNcsg7C3eMnVZvUW9O3dowWzFLOf4oB8838ohfLW8fEavZJhNZYnZpqB0IK2JOVd+6v9lOKP+vXV9DCJkaOQ4hAKWtPWT+YS38o9R9xegjDGGdhDuPeoNI3eO0FOsteYXxWjVXt1hhjiJfsNkY4rnHBk4V9Ul8PCfRzZeX7wEkZLlAUMscCOUHJO6m+NDTptn9NDMyvmrShQiX1GYT2yaVFJ+4jw8tB6u8enngZngH+6KdJov/qaN8Z1Ixdckw2y1ucEKApXnCeCQuKimUCXXzelwleef9mYI5WLQ4o2g/J/CixA/ONvuEjq7cBOfS9QfQEwR443h9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUz3BduvTKA6TBnvhmIYDrV+vAlEVuUlCgSRXUOo7cg=;
 b=FV7SgXUR+8EFzQMx+8op6fscfeOthRBPNShJfVfFbrav4QDh9eXLknjcWjxoJOO2GTZZg4ScCY+TQzAdBB4TfNulfV4ajpZTONHWx4KLCBSfaEXM2cAwgVQHFEn3F0XCakFcy3bhi3/Fzhdv0MnwLC5qrT0Xm1u0MEYHUuBCkzCnNT63/UuF0G7Qlzr6s1egEKbZVFYad1T+wS4HOO3E5VOM8uKc9X2qArQD2TKAZWrwpZsxIjM+n3gj7WGRrGRasVxN5YsQPxMv71a6ueOcCIXdjhmenLFJPTiBE+70n/6U5NS8xp25+ANV27NHEUNVAnoj4BnbuFoU3Xj7Tp1GHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUz3BduvTKA6TBnvhmIYDrV+vAlEVuUlCgSRXUOo7cg=;
 b=YIA4QpM/OBIhF5a+2+iO+zhiFq2ksiXIXVyVptOEnNEclzWz7Y5L4slsUdpk5lboBWH/iw6oabx0VyIl5UhWL6Lkyt8wlSbAAOEV9EW6WYRd9VYjvp1euvRX3gWnPb43D1Yysb6tD8qtvAj16LFLEjC2KV5V7eABFKcH9M/MeIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB7101.prod.exchangelabs.com (2603:10b6:408:150::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Mon, 10 Feb 2025 18:37:20 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:20 +0000
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
Subject: [PATCH v3 0/9] Enable EINJv2 Support
Date: Mon, 10 Feb 2025 10:36:56 -0800
Message-Id: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BN0PR01MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 532a004d-db86-4be4-35ae-08dd4a01f3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WcEPEmT0WPbl5kiOgGceqw2x7pwBcQNe5cBITKAn3EEM7r60ROXErvCGzU7g?=
 =?us-ascii?Q?jl34ZIQ3PRxv0u3iCqV1XoxWGRiU9cK7BjbQwX7pGC3mdFFWsS9XecK0sBRg?=
 =?us-ascii?Q?lmhdFo4uL/0QyT6A8UmeEDDIDhtaROd24YRt7smZ7e8NkOK31t3z0+Nk2DtT?=
 =?us-ascii?Q?KUS4NAXYGs+rRrQxeAYS5o7blFVWGnOQsaJnfEdWU4HuyvrO6bqlcmi/6oHg?=
 =?us-ascii?Q?wecxA9FtpCV5c+xiBtsblVVzpgas3ugytN1FqKN4tm5IwPgFa6QX9x5Y1ZlV?=
 =?us-ascii?Q?lT1hjf6FbxG9dzEbMYGMOg57Cri1ZuXplDGaoxKSsRKurB5mLmxAzsVQ3Sd2?=
 =?us-ascii?Q?VPesh57D1S+df52AbyIYD4a4dk5DJD592sJ5M9UvhZ9ZzbkXxboagg9FvoHm?=
 =?us-ascii?Q?vpae3ykMX57tMbqV9WtnW1Mr/hnNjuYgXDvQd5TUajsZbOwwTJ5iIVf6c9yQ?=
 =?us-ascii?Q?HlYCsg0i0JA8trDSzNcqg5Uql4bPUXhGG6mGYLjzkaES1hs0WKEetjDgOoO6?=
 =?us-ascii?Q?pqyb8zpEs9iebL0ZITkJ05FRBFZA/XAsAAc16uPFrx5xENAJ1ZTDRTrHfc7P?=
 =?us-ascii?Q?or6rZeHOh3o9dvENJLYqO85KpTWwQGmPVRyXA8wQzWLC9xaKitvEbD+1Y0/T?=
 =?us-ascii?Q?2KEMDakd4QCYjtWuXaH6h4P1pzIhhK62668jzOA1zvmUk6XvLXUo/ClsjOKL?=
 =?us-ascii?Q?lBX8oLSu/UONNLRSWxY3rIqd2E7bwlXaSv4EIlWJ3HloP83nYLd9+kXSW0bI?=
 =?us-ascii?Q?LD8PyZLZA+qExVJvfXeGTbZgzg1+pEfX7yq6fYMmSTSXxyobH4OOww8IABPx?=
 =?us-ascii?Q?Pf9ypG/Tx7BNSUby41DsItpb3eord5F0t5OQAtQb1BaP2F/19b3aQGm+EOwM?=
 =?us-ascii?Q?rs2S8pJmsiq6OQ3sM6uIrSjvTauh+qjhQUa1A6WRedCkynZd0pJ4eeO30Jhj?=
 =?us-ascii?Q?bu0iyItl/SLvJPrI9m2INABcZxUk+hDcgN3/2uLihiKm/KGBcZFYyCn1JlMY?=
 =?us-ascii?Q?6UQ5dWWs1LXr7CHNHHFbN3IJ8hA9SPHc4RzRNAuwmL8lbm1N7gXxjD6rxNsN?=
 =?us-ascii?Q?ftifs2jn879XQRt5d4jzS6V95N0H5GCXHH8EWAPEXox3MFumr0PeBUfF9MFl?=
 =?us-ascii?Q?Qx1E9BfMv/7tMmasG1/BXHhj6Q/T+NMonz8Z5VbRbxXnW0H1hcGuKlNGsNWn?=
 =?us-ascii?Q?Qv4rOKRahBXahO+wKpvm59sba10oURIAvZPnPWLblGRXjqr4Ed8f8OFgkWfK?=
 =?us-ascii?Q?gVWapv8vp6QcMgRJSzhDYHHJhNGen52qxFywVyrECLlHUr1H5axpO1NrsYia?=
 =?us-ascii?Q?Nj868HHbm4qXN8KZdVmgY5m+gL/nVoPexVJLdx+CnZm28vEY8ZecGoapVG+X?=
 =?us-ascii?Q?5ExgFAXS+8c4ZnnEXjO8UF8opjGR6pEKKfUiJkd9mRp3azv2+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GhkNzrecPfcHYeSBNSAvFaQvWxUn8t5AyP1bJE13Lp3BGrUSwqlaqMmvgPXK?=
 =?us-ascii?Q?DqOrvkVq5yUo4C4ZAl7TFXdPaDQGtQbnX0Qk9N9HE0AS94lKpPbASbvOCT8A?=
 =?us-ascii?Q?Mo+EQR99lsX0S/loUbZSyi1L9Tr8nZFQsGqG+hg4R3yYnCiwUlT42IN8K6gS?=
 =?us-ascii?Q?rMzO7/4I/wlTZJEKwf1Szdtw3DFjww9F6+2c0o6bTsmRWtP04W9xgPM82MY/?=
 =?us-ascii?Q?Cg+Ai7vd+mizDBnuQNf6sK9JbOUuTIl93TUCM8RYQFhp44ArhYH219+fOCt+?=
 =?us-ascii?Q?gHe8le3OrhorFGzHg6G0S/lWcfCYf4w5jRtoWXgIvwbZVkgqacuH+aJB5Rr4?=
 =?us-ascii?Q?jQ3J6DM/+3eprHPRGrF+s8sig4Bvcn5IRg2i6HtF6tD93Mi1XA1lg/icGaZ+?=
 =?us-ascii?Q?+wR/T/sukltNZkkXudZ52U/dBIA187HU94BqgxnlvkN6Di4lXSkbgGxvxXy5?=
 =?us-ascii?Q?q8RE0XFTXetAe37+2a73bliWO9xl9jvl2uPFsF/ftaGu9J9HFvt8cClqmzJf?=
 =?us-ascii?Q?N6JNW9VBPMB1QzG92zw+YMYsXT/fjfSFinb6ukxyhZd8JDiIQpfTt00y2Q8K?=
 =?us-ascii?Q?a8R6pLVaU/juJ51sR05Ck0SjMDrZVnLOoUGJGGGQyMOlbbJA1JC69RVGSQ6A?=
 =?us-ascii?Q?IPwYGkkJ1pIv7aEDduwWBEyYEAjF8GLP6v8rQzGE/N1D1zCuhfWX54jwwdPi?=
 =?us-ascii?Q?oIzVjsLlMKzeDSUfgk8qGwByLwZH311b6IHSlr/HgOOvFqBtsdefmJOfn6RR?=
 =?us-ascii?Q?Vu6DOs7F3qfBZ35qwdHiczYvreyaEA2MvGH87eDAt615tjjzV7wb3gWKYUEZ?=
 =?us-ascii?Q?fYwXQKwJzUr4gGwG5OEGcBvEqIpWxEnyKcIamQET7FGnoy7ilEjMFpw/iGAl?=
 =?us-ascii?Q?4XPUCWlHNUZSQRlNaM5YrlWOfetUP/wUngVmzxyj4Hwv1NXMKuJ7oWKn+vNb?=
 =?us-ascii?Q?u6KizIgsPESBRsAB3DT0+v9tDn7tWL6ffWJyuC0lHevUBfwXZi0hOS3Tleju?=
 =?us-ascii?Q?of014jULt4mNafxy0s7JIWKgn7EYnK69FpqZDZ2BOQeP4AUysqqvecYAlHZD?=
 =?us-ascii?Q?BQHudB555CyC2dwoIRePQTo35LdhjtOqOoPGusNneWdh4zSuObSQN5Bc3cfU?=
 =?us-ascii?Q?W4IJsmgUtcynrVG02+fGGhvErItGi/GoPNW0KH/YuyzeoSPQKVvTD4spFGGl?=
 =?us-ascii?Q?OFLwySMyWADwJbBg4KRuVxN1PSqWFEM7D46D8s+u2HGeezXfE05nanOPK8we?=
 =?us-ascii?Q?PoiRg64gaKjjoDdce2iGtXG6zY40K38qOq2gl+n8SOG3mWUecycCiE5798fC?=
 =?us-ascii?Q?Owx6T6rGgsTXytU2vtQnKAVCmIHr1FMtADwiJ3RGB2aQBQK/tBgsf5pRkjhl?=
 =?us-ascii?Q?6OCD81Do9vr3RcphWknKiv+OM9fQjD4Rg0NPm6d73CliQWk8QVymbo2Rp04B?=
 =?us-ascii?Q?9SyyzjSaNdKk8uXlAbTDSn2Pexj15F39p52QpVf78vFTsswQVwPmeHhfCR80?=
 =?us-ascii?Q?nsk8U66YkIGQ/mWpaGdcz6XSR6Hh+6HqahVQeSnKqQS6gKS5kCi3aBKhbYKO?=
 =?us-ascii?Q?5H6ZIo9aKaWry9ute/FZ9jN8po402vT5goo2e6KaACSNVMEjYY3lqQFoJWu4?=
 =?us-ascii?Q?mF44xaauSqF7hT6OgrWaAX4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532a004d-db86-4be4-35ae-08dd4a01f3a0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:20.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTn/AsQ3vlU+I4k1/KXMzoMYC/BgyACfSYHXt7uRzWPGUVfEhXsP0mA/CCQbgGlpyw3HTFmQRbNiBItYMC05LNethpujqxRZakpwcJHif6My33vM3rPJ42B2SVjmot0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7101

The goal of this update is to allow the driver to simultaneously
support EINJ and EINJv2. The implementation follows the approved
ACPI specs(1)(2) that enables the driver to discover system
capabilities through GET_ERROR_TYPE.

Note: The first two ACPICA patches are to be dropped once merged in
ACPICA project, see pull request(3).

(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1521
(3) https://github.com/acpica/acpica/pull/977

Note: This revision includes an update on patch 5/9 to avoid
ambiguity between EINJv1 and EINJv2 error types. Also, it includes
an additional patch to fix sparse warnings triggered by test robot.

Zaid Alali (9):
  ACPICA: Update values to hex to follow ACPI specs
  ACPICA: Add EINJv2 get error type action
  ACPI: APEI: EINJ: Fix kernel test robot sparse warning
  ACPI: APEI: EINJ: Remove redundant calls to
    einj_get_available_error_type
  ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
  ACPI: APEI: EINJ: Add einjv2 extension struct
  ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
  ACPI: APEI: EINJ: Enable EINJv2 error injections
  ACPI: APEI: EINJ: Update the documentation for EINJv2 support

 .../firmware-guide/acpi/apei/einj.rst         |  41 ++-
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/acpi/apei/einj-core.c                 | 324 +++++++++++++-----
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 include/acpi/actbl1.h                         |  25 +-
 5 files changed, 298 insertions(+), 96 deletions(-)

-- 
2.34.1


