Return-Path: <linux-acpi+bounces-8910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFBB9AB8B2
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603321F2436C
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD321CDA16;
	Tue, 22 Oct 2024 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kJqOB1pU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8716F85E;
	Tue, 22 Oct 2024 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632884; cv=fail; b=l3DFVEzTMLfO+FwDx2Yy2U4CdsJ7poaNGKnVpyoOdkP0r/4EsKMJlOpCzP03xewmX3WMCJwakGb8Vjo4c+71Ywe8UPAPAqMeFLQoLFJMa4RLLByuWIGGqIUMACI6C7SVqcu4PD1n4NAsXm+DlpaS+YJl1fq/GpTSpHQP3hMHxsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632884; c=relaxed/simple;
	bh=+752GiSR4mqDFePyAJesv0/vUQMlb+wsszJzs3i1GXM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QMvq8v6OZ7PM30MhXFwxp/glwXIpEI/VN+F9S5RMeEYCWzS1TsFpAnmr1LTMwd0BMCiPMFseHAlv2iPgvx0ryslcpEVC8c1TsErnhKasOIcIo6T5bmJYQcfrbjfk7NxOk+GBX8DEHuzMCu7n3QjZZwFhRXHd3jNpKMmOh87gXgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kJqOB1pU; arc=fail smtp.client-ip=52.101.62.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaa7LYZkWcTNUVQgrlxfqkyUpt/9Xe4FE4FNAmZiLtPfAPQb6fl79XTuU2tR59JIV4RI8AhQ/lfIc1CGy90tM73522ehQCCuQ2rNeSpFZ/C5G6CcQ4fDwwqso8tAtumgDrm+xyzXhhnTIVCsvLSltvWl88evaqTWmzjuC/+EIrhAhtDEOiK5xOsnSHMrLlWPFzf/sMvrukaEuqhoj2hj5nEU71mvPL/JTWQbN6LPWYA1iI7kxAiZndvojB3GzWgLLd27aZZvJvRAdRp/ocUqd/MMW13GZFomCvrz1+4L1lpxby1JNld+zhxA68bZsQgx0eES3nRYzGXe0a6cPiARpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pY1eAUC5LB4b8uJmFecZHzW5GFbYq3kQc9ot4v1TdHs=;
 b=NXoIJNa5PAYrrOG7uB+wJK78lpfMJWV1HlUEr/5za9Z8S80kQqohroMZMOoTP1ls80dCK+ya57pJUROJvvCR44LLqHpyloi+EWZu7aJSavta3qhElo1EXGEiG/V17s3dBwYQieuUdVG1gMtWVAujOdkKEzA/Jv534lLTCmoYfW+wsqxi1T0OxaxsCHYkgPfjvZ9/6yF2CwGhSm2XFn7aIBk4qJPbLUdf4+SGuc8yXZUFzCV2UzDH3L5xefiFxdf5jpPo+7KD4QPA4dB1MvmIBQwmWH4V3yQdAmn5/BrSpJXw51CgppMSYu6OtY6UlHCey2nbVePMw78J3JuY0vpnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY1eAUC5LB4b8uJmFecZHzW5GFbYq3kQc9ot4v1TdHs=;
 b=kJqOB1pUcSaQwtj0iM+oo+qwkTAyJ26QuJVy7ut/RIhpjNc8wW+WFxP01+fDzWqZNpsfnX2/HpcYSucZdH45P4Q48zrlsQKvyaDXMlx7qh4vb28V5l/5yvOWL692tvgqbnFGybQgdcd+MVoDJsKyNyWgnaSzhhhgCA6cZ6BrD2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8991.prod.exchangelabs.com (2603:10b6:8:21b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 21:34:39 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 21:34:39 +0000
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
Subject: [PATCH 0/8] Enable EINJv2 support
Date: Tue, 22 Oct 2024 14:34:21 -0700
Message-Id: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 4f54d7ea-232f-4981-7ecc-08dcf2e15590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m66hGIZXSYOfH5SRKqirxNWx+XHXzER7fUkamQw4BGLennFRxMC9TwVptgE1?=
 =?us-ascii?Q?6ZZY+kgXkMsPZWx7xIVZGPZbiC3dMEqd6prJ3rPOYQTQ3kiNCzvDcpv5FeDj?=
 =?us-ascii?Q?avI4v2rwqfqIED3FMW8Vz2st1goCsXmwnp3szwjJPWD3HaCO5szENAsr1+74?=
 =?us-ascii?Q?rxarmbfQIeNmK0V2dhhyzRMsnO2tUnoApF732JvQoI124XI6OGhMiwFF6HDY?=
 =?us-ascii?Q?H8k0PB0bbXZ8iK6LB/5VT1WTT1B12tMUPVimwTKlH599aeZd23VfCPii8mDe?=
 =?us-ascii?Q?/1oFSiBaosk9CFw3xc8ZU28zXdxfWMRztW80CuSSaR1E8alAU5K8O0Ip5HgZ?=
 =?us-ascii?Q?iB24ChRevVeAqGU52ZmVEF0EjOYnecTAn8PgV7ViD2UbWOGSoeELZ+2LcF2l?=
 =?us-ascii?Q?gPcdEQVQpz672hmPoj3mTvtex9QC/UwsIDc5knQKRa4n+eQhV9/nIUMwV0Zk?=
 =?us-ascii?Q?LKQAl6IGrSd3MwFx2I1Y6vDqiIL84SP/o2z8ekLRU8sk9qG/ZfZBtobSc8MI?=
 =?us-ascii?Q?arYzW3WiAh//GoQwyktTqd+2tFHBvgNnkQ1Ty03k+cevCAuYGKJ8IBq3EdaY?=
 =?us-ascii?Q?Qr3mhR5tyGkeU0qAB5QKaQ2mba9iQq6B1FrWEmz07dR1Thmo/9gsPZUY72R+?=
 =?us-ascii?Q?78kbvYzcLxjGsKg9kbu4IjgTX7Ed4nOjUqSVp+dTqG06nYDUXpHkefSZf1/k?=
 =?us-ascii?Q?OqI+p4bEh5Nkg6bSIe0soFNVKwIpK+FDAeI0YfbVxsRB8ihNQSk5i6NVuRn3?=
 =?us-ascii?Q?LL9Sgko529V1CWDNd/sAqYTGn1yZ9sIgt6lHGi7ObKrMhUS5Vp6Ec294TA1f?=
 =?us-ascii?Q?JuepnCvEt9Quge2TdzatQmjPXGN2NPT5JqrnwdjFga+kiyEVNJacdWzYeQyf?=
 =?us-ascii?Q?LolBH3+04DHP6mI7tqLu4onurjC+baZF6B+811V0iW8905Dlavpi9e+Fqvvw?=
 =?us-ascii?Q?AUmw80CDDOqJk1L5I67cbGAN7gPwN7d2V2e3SU1kERNYAASUHJbr9k9N4Jf3?=
 =?us-ascii?Q?FZ7IDNjlwlVCCVtWC3HnguRPmaG6lx3BvkjzM8q8OGyy6ZEgh+vm3mzoemoQ?=
 =?us-ascii?Q?/7C7RT431f6VGycrWYHQlD39FTNUKXRoefkI4Iloyd2eaAw8eXuULCtOdCUc?=
 =?us-ascii?Q?QLp9AdooAewmChdeCYQa6V9wRgSIO8SUUzmRB4MbM7YowkAoHt2a4pViEkWW?=
 =?us-ascii?Q?wRx0EaoX2hgH8OkMQsfpSh4L9DlVvqxXh4TTMFrQ2jysmrE7HyELThrmw07l?=
 =?us-ascii?Q?7USuwXLlhH4ZccdUZl+p5dXsFVjpZjDdhYMBr6IqC3k0tIBtekkR+SOuOGlY?=
 =?us-ascii?Q?dvNUZBpkCC+wFifTPM5AB71sBmgIa8dliDRqYSY0H2TLYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQtyTMGC5f6dH9LCkjyS0biBKrilhmfkDGvdOn+rgYlTy+AR1Ws/usg/WRr3?=
 =?us-ascii?Q?fxHz/kIz/57xze9kWX1zVB6L88ymG9v1VXGXW4xQwV9QO2EywjacCko8aza0?=
 =?us-ascii?Q?GJzBhJljnJt4EvBOotbdbrsA16bDapOKow/LQzjqji/HZPhQABhBuqTZvx+C?=
 =?us-ascii?Q?zCR8p8MvBpLELGHCvPlippjSGNrCqBrd1JEJAB0s5F6fCgZW+ebeH8qVISfB?=
 =?us-ascii?Q?6ff02Ucd3N3Z2osn6kjCaVDlXH+LDDhoZ4RTyEHMdvmV5Gwh3ex9aBb4UHa/?=
 =?us-ascii?Q?/gyx1jGdMINClCTFikQbqf1BU6D0FxdZGb9YZ6Qp9Bytpi3UuDuoZVHm52Mk?=
 =?us-ascii?Q?+zdR8COMdcO4csvd3yJ5CnQ683LgHhoZISgidPc3z78W0nBUBu73PHeYKMjS?=
 =?us-ascii?Q?CbSsIQTIJJtyvvIVbJzKaqXrI+3HbSoVMTITpp8V5txs2C22VsmcQLSjxRcS?=
 =?us-ascii?Q?jl8Qz06U9Z3NW4bXb02/kO1dfaPXfMXE37DRWtjKdpHqMhgkKT6rqRFo6ave?=
 =?us-ascii?Q?2SLeuwEAMlBpq/Pxma8PZs0wTDsZEDMxF+Blcn8EuYPu4Hj9e8fGG1Z8JYC7?=
 =?us-ascii?Q?Vgo1YhvTqWLJObFstXtZ5/oKCrjN6PFeUK0iar6bI1IszESDOevJ3q3AG30w?=
 =?us-ascii?Q?+psPU77p5b4DjpQugKkCcxSg6+vaUnp3nj/czaMXJjofafKPRk1k+b1uDXUJ?=
 =?us-ascii?Q?l5bL2sWt26AWk6uHSWLfxE/AZlMZq++pamaTanogIMauxPK9XwKKNAqlJWSQ?=
 =?us-ascii?Q?MNe9sBFvncJ/v1+s3yHISMXNyfuY8pvcKUjZDJrgkSDAUdWn5mazXKOSVDXK?=
 =?us-ascii?Q?H8Y/r9OjoBt27yh23/stDEKd+tpZBc4j07UHoJLaY+Zf3avOL24XIbOxVzwQ?=
 =?us-ascii?Q?tULCwF6M149OqFMV4iDQFxyvUrS3NL+thB0XlaBL58p68E8B0qaTNs/DFl2K?=
 =?us-ascii?Q?VkUbGRxBGrm7hb/YCfruHMDB/Kzeud4TWwyzIXFB3AJucAq1Ezp5YGsYeyHw?=
 =?us-ascii?Q?C+fU6Uyh7th+/oaY4cs8cSFZjSXzTXbt0eDnKVNRg0rMvgJwePLaIPoxEjuN?=
 =?us-ascii?Q?MA0R96PYz+27UHo2kC5z+UqdtT1IiFMMWMeQ/ZD8LwXCBN8uPBvgdEzngOoc?=
 =?us-ascii?Q?wt6e/Trhj78+C5GKyMCVGQDaA8JdA8aVA0kvSQDduNi4as4q6FWgPG2nMMDv?=
 =?us-ascii?Q?HUnmhqz+njuieqa39cfGNxcG9iH4bneyvmqsXXiE4bk0BomSyFfJsTC4PTDc?=
 =?us-ascii?Q?6H8smS/tXoVjshJQKsHsJYny/jqJcGM/uXDcVttdaRAHeYXSIjDZdtYj5BhJ?=
 =?us-ascii?Q?Au1iMpZHwYnrWgqgkMGd+t/XFoi8euIkn5VJt/I0Swj9O7OcmPkKS/Ixx1K5?=
 =?us-ascii?Q?woMDVH2McaEO2lTAi6uxQmZsUdaxFAoMSK7afQLtA1ReQElHcE8ZzFKNYIyY?=
 =?us-ascii?Q?w2UibY62n0EbaF71ZuZ+fi/eBCBOHW5xf8Qhtpo3+LfguRJInlZwWfL2iuj1?=
 =?us-ascii?Q?pB0DnltPQQZ1LIUkr8cKiDDejM3GzuJfZXev0E2CoOpkxH2Zf9aQuKj+JnZD?=
 =?us-ascii?Q?nAEW6G8hj/N1AugkaXeI/tYjVgIMc/hIkCRe4X+lBCo70anHVl/v7P5ePEpu?=
 =?us-ascii?Q?xbmlsiugfR6iDTHWHn9buus=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f54d7ea-232f-4981-7ecc-08dcf2e15590
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:34:39.8219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNgi6bd85QdXmbceyaVblmkeLGaW1rjGcXb8Ev3zlAnA0CSdcfTpyE1NWpqki/AQmwOOujPPhoxc6BFKeRr1l0XRqgg/+l5fPAbeiTiI2oBkXkIofcnI/3nw0TIfyKZa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8991

The goal of this update is to allow the driver to simultaneously 
support EINJ and EINJv2. The implementation follows the approved
ACPI specs(1)(2) that enables the driver to discover system
capabilities through GET_ERROR_TYPE.

Note: The first two ACPICA patches are to be dropped once merged in
ACPICA project, see pull request(3).

(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1521
(3) https://github.com/acpica/acpica/pull/977

Zaid Alali (8):
  ACPICA: Update values to hex to follow ACPI specs
  ACPICA: Add EINJv2 get error type action
  ACPI: APEI: EINJ: Remove redundant calls to
    einj_get_available_error_type
  ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
  ACPI: APEI: EINJ: Add einjv2 extension struct
  ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
  ACPI: APEI: EINJ: Enable EINJv2 error injections
  ACPI: APEI: EINJ: Update the documentation for EINJv2 support

 .../firmware-guide/acpi/apei/einj.rst         |  46 ++++-
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/acpi/apei/einj-core.c                 | 170 +++++++++++++++---
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 include/acpi/actbl1.h                         |  25 +--
 5 files changed, 205 insertions(+), 40 deletions(-)

-- 
2.34.1


