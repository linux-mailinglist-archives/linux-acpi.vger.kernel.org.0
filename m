Return-Path: <linux-acpi+bounces-12710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5929A7B23D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7AF176D82
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DAB1C84DC;
	Thu,  3 Apr 2025 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hwfCC+HH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022135.outbound.protection.outlook.com [40.107.200.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBC19AD90;
	Thu,  3 Apr 2025 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722035; cv=fail; b=iZXblXlx9v8q5kms6dsz9bP2Vo+oQhHaMt+LNyDSOYxoj0BZXm4P92iA0Ry17YVBLCHeFAiKqXIU090bk2RXl3eamelWMt4KXdSpz7m9s4vIZAQFidOD/CYA7Nw3TXj7fyIwCVFyTPIzf4J2ZjzMl0af1NWpHBV/zEu9PtCrBjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722035; c=relaxed/simple;
	bh=XdwpV/RIg6W7cHKcz0fn9ki8bHW3NKhukFuaaWGCAnw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QvUEE5L75a7Kj2xN+Q6FJXUQrzBy9L9RjQCd7pK4mCHkzhi2KvmO0cLQEOrmdDde073d7ZEjiczKSgaRnxb4UivxqI40/34fLx1z6cFwoxy9XD0PP3z4vZVcGKYpcUV9mBATL9IkS3JP8+F0Ym/9uP0r3BMQ6BBLeVY9rPxcun0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hwfCC+HH; arc=fail smtp.client-ip=40.107.200.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGPXHsF+2Uu70YZzEb1rTvjWVV+x5FLCg2poA082qXVI53IxLzyXJ6qpzWNgBrV2c7v7tjErYCh9fw1Jy6gAJCAzjlJt76B65yzQLvktA4Of0XvKq6etjq9HM1bFF6MwmxBXQeYDqODOVwlqeuDbro/ZWkQcf3KlcIwKjBiXxOol0PFTZjmm/MjSC+8gQ2k8jF9FQgd2TbhDDzPM7K1c8x43qCmRuJv1OSwoJY/RuqxaKPrYGs1YEQ/vrvGe43WpNqyGOSlbuPSkrf86GY626piUtPZm21/x7Xr6HcE+GJyKvDMasKzwHueAm2n5zzYRTOjwNM25wRrDPr9x/myUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/bFi7FqAc8qVjM33WzETknG/puFm0DWTD2P7SInBZ4=;
 b=JfoROh3xn+xBSwC6k0bx2bi/bM3lPa4XPEkBT3rH6uEdiysc6CoRLiBxisoYt86PL6+wZtT5W40fvayeJlUvaj3zGgCP3dhhXFdvrkbKHsE2wYRshToVMAKbgPjN3Ui8GbYoLOBAOfrMGh35xZ2JFVH8gcpS0WZIg72CoVmuZ6GlJ8kRU3tNZD1robsbvpDc+9eCL0SOZypoMoJkXKu2FfCNtbfMzrqctuwdys9Brzjde8rZ8mT+Pi8a2bHUmj/Xk831of3mgVtIC5QAg+OVCN0nVIK9fsYbK+FSl2d2t5A2+i3w1uEqr73chGAc8l5PBIB87KN4uaa5F3iBMhfVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/bFi7FqAc8qVjM33WzETknG/puFm0DWTD2P7SInBZ4=;
 b=hwfCC+HHd7Xg69kkHf6JYXbAJuQkhEK1FrF1iiLCnassgXV18ihk/sDa9cJFAsxmJbW1HJqMrTCCIZWP+Unetvy1PD4lV0h3Ra75NLykLrpEgildzR9Vh7HBhEkm4OCH1/NU/n94NVeWy7vZuf/56m9xEkju/l98EGwUzht1bZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:13:51 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:13:50 +0000
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
Subject: [PATCH v5 0/9] Enable EINJv2 Support
Date: Thu,  3 Apr 2025 16:13:30 -0700
Message-ID: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BN0PR01MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 596b0e06-6bdf-44e3-a749-08dd730531d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lVnlBqYf2dBHLgsV5xODniZ3yhYUBYsMiXOYqN7uo02NSvVku5MjuUf4iDEC?=
 =?us-ascii?Q?zSV86XY+yZpFyJTR41Hwphu0zcdGcpakQhcP6Nj1zlw/WIvYHG7TyKoUO8vP?=
 =?us-ascii?Q?wLXJ8XtziA6/3Z2xZsDP55LFQdiYfhfz1bjQ3NJWeIZBhVmiHbS9Cia93Nv8?=
 =?us-ascii?Q?VJjCrO0YBeVGao5afr6QD3Bz8peSGWlA2NDbOUgRsp66flVDAn1UZ7z1h8UV?=
 =?us-ascii?Q?9dz6AqbgoBtQR8oOchXgUI+Cw9dHPhsRQXIvu5f8CV2qA1qV9z1eX1Zyzmyz?=
 =?us-ascii?Q?MCREZen4z25sIjJKorDdUGGT567dUXho6g9JWjNg3y4uA2q+vLboedDOLhqe?=
 =?us-ascii?Q?UsI2ddCzd+FsldFchjZHNMVvWX17HpEp+r5JHe0MVCBqtq6uKxOyyGCyLGyg?=
 =?us-ascii?Q?8d0eN1P/t2//UmSrDwjqMvY1srM+Xl0iQwyD7bk8id1Ql2yLnp2/cmWCK+kS?=
 =?us-ascii?Q?0Fjz2GMnxUh9YjVPaJsqAcN1PN/LRPguOqLoP+iWU/m7XTKjB3v4/2qBbz9P?=
 =?us-ascii?Q?32e2ufKm3JdYt0O/dfAiaSCDqDpaCMIMcP+WpToppiz/9X5knAa4q8F0xhig?=
 =?us-ascii?Q?nabGT9LyRFr1MbwXm2dH90YmNbQBAdE6ELWpkvF+apyQG2CKVuMMdtmc4Hn3?=
 =?us-ascii?Q?y34TOWeIpVaDh5WraewxNpvaK76pPa4e1g8bQpAO5KY2wNWLmBmAKF/8bHcG?=
 =?us-ascii?Q?duGr//BT/ywtu8yBTAsloZsQE6foUegSB5a6UIkZ1r1sYPpGNHXwZSU1Zep4?=
 =?us-ascii?Q?4GsONhw/xzO70iUpBxbDZ3EUXQC8fV/4CpGg81yD1B17hL+FAt1ShipuUU2D?=
 =?us-ascii?Q?59ffDwsv8vE2OXeYrjzINSpjC2ddNESQESuv0tviEQPD/R6mahZ7gvOBQiKZ?=
 =?us-ascii?Q?aj8UYEtyrOffM1tpoPIn2jvU1Sd5XEfwepNO4MKVL97sCo3JoWe9fmFVluaF?=
 =?us-ascii?Q?4emPceS+Zqwayv/eaMZYYJgzUqWQM5YWUpnE6+wFC2EwHd36IUvmq8fGOuWB?=
 =?us-ascii?Q?gBn/+8P1D9fZy4Iamp+FNAr0pGFuA/zVeba+B1twWh66feBoPBCsVZTXNHNy?=
 =?us-ascii?Q?U7zhk2Z/Qrn5lm/nwxgSuhZCscOYt8k/Kdsj88+6O/kpKapgb2cQoTDXjxFx?=
 =?us-ascii?Q?t4rbksBupYI7WAOdC+Jgw/DZPcn6EViC6PuWNasOiJOA8oqEKiKdV3yf3SdB?=
 =?us-ascii?Q?vU8+H0v8oVflQ1su9Kih7VABARQyLnWmSWm6rMHFO+StWwn9VLfDUvZphnzW?=
 =?us-ascii?Q?L/NWr9/IGdOJZGGq3X5AC6g2xay5TOT6mLg5kOhDs4fzRaHI6y1DMLv7hUEj?=
 =?us-ascii?Q?dMZiewUVutwA7xqUToJOo1HpPAy5YD1DDVsgLM0dpiGOUmhmQIg61zd8jGss?=
 =?us-ascii?Q?ZrCVBrnSWq64jxqQQYAq2E3j1F0wDvYXdLZJ1ma8Zdm7By3mCO6tRwoFNsZ6?=
 =?us-ascii?Q?rkWbyKAt71caa62cpxwRkfEYqXIZsGsm/mT2uLwDmEOmSAKrRpLurw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rq2hJJvUk8un4XXuFJKT5fTLfy5/yL1C+kZTnIy6IFw6kv5jUZ7SP06jcdZs?=
 =?us-ascii?Q?/1CKdWG3kbmtihW0zPge/JJsbNJnpRPT/YYfld79100epOEcuk++ZXXeCrAb?=
 =?us-ascii?Q?V7NETc5d/4aiFA4m6Sq71q1kA6f/MFomJ5uj/SEoZIN/HZ5q9W1gOOTR0MLU?=
 =?us-ascii?Q?QxIqgGOQDbP64ho9KyZian/CtP7WtoLCkJuAHiTiSF/TJPXODbVLieVNHF9v?=
 =?us-ascii?Q?VbSXn9C/0dOJ1NJVqQh8FvWan07A3Hj2/yRRjas1W46Lx+ARKXEVSUngO+WC?=
 =?us-ascii?Q?bA7EF59FOhGQ2lSgaW+4AmqagHVN6BbnDYfuX0L4toDVTsrMNcgEpSHmsi+g?=
 =?us-ascii?Q?x8XNSZPydoAp8i0y8WyBXqU4e6QnEMxLy9Ess+0feOtZVRfxaDWn1eyo4rmK?=
 =?us-ascii?Q?9zXM4rT+Z7NSM8TMpvN0y2JXof53tgd6oJgIONvHWEjEVpo3fdagiKQKa+Z7?=
 =?us-ascii?Q?2RslwVZEx0Q/O84uyyG3sAJRjk7rRiVNegFBiheErR0LUfK0cuOKwwda8nNA?=
 =?us-ascii?Q?ndru6Ys5svIdplsDhvm45MafBnrAHbv3Eh68ZvhtoTR2d6wtIdpZ913OlgeP?=
 =?us-ascii?Q?MxuSA5BPKedhxvwI/hZQSUgXUFDkNoJIfQ2F6tbQtwtkhnB7/yv63ZWaVoZq?=
 =?us-ascii?Q?jSyS3AK/dQ3qWyHiKM8T6Iv8Gbbkxxs8UaLryc8Db6w67O7tUUs/cM34Q/wQ?=
 =?us-ascii?Q?sVzqnleOO2Eo3yPgIBbtWBpVTpYu1MU0zABnOz4OOl4wgtfWWwJCH01nslwq?=
 =?us-ascii?Q?sfgKMtd7+EhEe2W24oTE0xXfSCKbLeAPJkJXpJhuRbH5ZGsmaRUCaTZQuQEB?=
 =?us-ascii?Q?qbzkt3TqqZTUo+3Hxq1GIIjz/4WE/x8nb1JLctj/tsUMY9ndXCqOXgky+IZl?=
 =?us-ascii?Q?FEzBUw0iVt1n2v6cYbCCnBDfhlqzD5712AZQR9/VwIbSuWWPfUURZB48wlyL?=
 =?us-ascii?Q?PZUwsZPoiA0G7ylu9Qp8IOcS5szzNURWEjvVREttQMtvHSAjHe6m1qgISMZQ?=
 =?us-ascii?Q?zt1nleYZtCc0sZJWgovn29QM8BOFTwpsxN0I6SF6aIYX5Kv1u5Dg5ZfHbMK3?=
 =?us-ascii?Q?8TfjWMw5x/lpGUMSNjuoQf2ji5+8YWjm9opf8I0ggfZEdlEOzr4CKCOpemnb?=
 =?us-ascii?Q?WpxkhwpRrh9DzmnJejIHM5y/B4k6eT5EdM7GwOc6shaa7RU6JwR9CA1z5orB?=
 =?us-ascii?Q?LPrXYDEWPgEG5V4H4LwJr4g1qCvBKmA4SOh0XqVWrGyNVziNhCUu6UwaYl9N?=
 =?us-ascii?Q?6F1jDfKhmfXHIdS+BDd6VJlGC6aFg0pyq1wed11ZaHUGbPUPdLho1RCr7dAH?=
 =?us-ascii?Q?faPF7kLd8ANzsmC+fjS9vaepooL8Xocu+ZYsUb4wf0zECMK0v+FtYJENDxu9?=
 =?us-ascii?Q?31lu7i/tnGkQoN+ykT1WUjP2DpZkppOmrcjuaXW2v3kO10X7eJARlF5Lfmnx?=
 =?us-ascii?Q?7Ve+cOhAU8oFD/PZ45KwXlqVFddNuJ3AfVEn8rSvFo77NOGO20mRfEVIs2yf?=
 =?us-ascii?Q?ZPs3xlGUr+Wr99wOCMAofF5Rfk6IFmtNCbrs1jV/ZJzLO130sMTmXR43BQ1y?=
 =?us-ascii?Q?F2El0NJJgXRyUIGQppfwgpBgjCG89+Kpl7HOwuCD9N5W8ZZE6Mg7BFqeZnT9?=
 =?us-ascii?Q?B2hcijUyadSis0ZcFT+qQZg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596b0e06-6bdf-44e3-a749-08dd730531d1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:13:50.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5QNeXfPF7o/oVs2mZnHX2jPbKTB7b3v/U4sXbvM9LCHE1HN99uGiU6L5yK1I+KUwgGt3JkOm2EffhhbyLeUkYuCdeiPRsvrbKe2mKRBLRiMNxNpybPgCSLAptGQ9sPk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

The goal of this update is to allow the driver to simultaneously
support EINJ and EINJv2. The implementation follows the approved
ACPI specs(1)(2) that enables the driver to discover system
capabilities through GET_ERROR_TYPE.

Note: The first two ACPICA patches are to be dropped once merged in
ACPICA project, see pull request(3).

(1) https://github.com/tianocore/edk2/issues/9449
(2) https://github.com/tianocore/edk2/issues/9017
(3) https://github.com/acpica/acpica/pull/977

Note: This revision includes a minor change to the user interface,
where users no longer input component array size, instead the size
of the array is parsed by counting lines from user input.

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

 .../firmware-guide/acpi/apei/einj.rst         |  33 +-
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/acpi/apei/einj-core.c                 | 322 +++++++++++++-----
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 include/acpi/actbl1.h                         |  25 +-
 5 files changed, 291 insertions(+), 93 deletions(-)

-- 
2.43.0


