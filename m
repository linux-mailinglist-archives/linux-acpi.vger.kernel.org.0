Return-Path: <linux-acpi+bounces-13508-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C998DAAD03F
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D96E16B4B9
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75C221577;
	Tue,  6 May 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="okcEpIoP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2109.outbound.protection.outlook.com [40.107.100.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A89221555;
	Tue,  6 May 2025 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567511; cv=fail; b=S42HmXAFy5eHqvGpSZs/rE7F7NkOdLC+g1s7YADTAr6XDp9Y8osNGA0fLA/fyYbWsGXeAKw/U3WlsXxRNPSphHIneOxe8ivKLWitRiJk+QgHUF1mNBTYIRCc4d8Bj/urWdJUowO7Ar21Oz1791rp/dST00J8xBuX3t5LOZUAFac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567511; c=relaxed/simple;
	bh=JdS1KwRLjDEBmDmYx5gYtXXYXbGQi27WZFw6OIUiujs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XB7K1SwH0isCRoQDSYNzSt3TKCh53zf3e5VGgl5o39Jx7JwzN5xvNbNGKXX8bK/57MMbdd8ECtahYiBphHhXniuiXLLf1MhtQxX/9bLQrYpjATWb1sqfU8zSxpEQS/0sjoTGmMUknr21yH4Pu6kgqXlBaK5cLUyyCj7JEKySbNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=okcEpIoP; arc=fail smtp.client-ip=40.107.100.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkjJCznL9YOscUfnkj/X7azB83gjYamb0eIFVxa10Se1zpj+DYJGP7cA30z2kXF+PJeEB6bytH7/ZfN5nJ9u5uUFIm2l4cURNIhC99AKId6bGQJP8u1EJL3swDjoUHfcv8q9OKbDKbvbD+SZFwDRS+hmTHok+Chr6aNa56KhfovGsXAGSjQlM+FMJ8iXY0cJ0YZFJOSzzPwWwfk2MN86NNwWeyraM6jueSBVwR948J2Qy0ot6FNvaoe5kUBO9RQyHPV9W5ZVyr2bfq2tgBi5ZVnVwirq28WXy5EZZoqXOe3YrGyPzjQW1srVs+TfsUPApYIdN16XN8f+PZ8jEAxt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWY6oO/baMfr57bE3MgWZkr0g+68HsVSdDA5xv8F+tA=;
 b=syhcPBzLisTsU2hQmJDAJnpVTZyYy3EJNmNT7eDdGIm89TR5bzQseRNejzHO/GZPWB857u1YlW2K9bKG3r6+j8g1VMlOso6AnLJZs58PIQk4N+RSj7FQ6UxnDvkXCaLAEpDDLiUb6ziaXb9cYPCcH30eFurlTMHIxlCp7ht6Rm2uLCIVYL/3nC8Qxds6EYFTV2krWPU2S0v45sAi0VcvV3WxIlagPLy0uU6rMxZ75F0VOTd2SWOpSCIihkVtxOElGonEcvDMGqAmP8Lk0SM0TzUyrJwleYh5blP/gWFwDOak0z0NWT5i2Gww2vCp7lJyhaQgeNuXlA1MaYkU680O5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWY6oO/baMfr57bE3MgWZkr0g+68HsVSdDA5xv8F+tA=;
 b=okcEpIoPJywABfnGaygwkxw2yZQAxdPNpvFA64zC62W2dcgybLZ9a3bSTRmAmoeuZhjPRbzTql/b3gKuHfp0vLvy2l2p3f654Nbe/12pOM9EokWwv/SPGBcvr5U2JNeiwSBJBStZfxk8dvoQ1N3ZVMAst1d4Iy4wsOkSm9zAsGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8717.prod.exchangelabs.com (2603:10b6:8:214::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:26 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:26 +0000
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
Subject: [PATCH v7 0/9] Enable EINJv2 Support
Date: Tue,  6 May 2025 14:38:04 -0700
Message-ID: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS1PR01MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a28fd9d-9809-46f0-abe8-08dd8ce65581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qEL1afcOojph0vM1iRH/A1PI2/1itExqz2zrl/iWEQ4QLS4fLJgeFXzlOKrH?=
 =?us-ascii?Q?lv5gG5PAPvJj2vvcoIs8lvPcaFh2iOMEdhIs5DGjBljaJ7xjVxYzBv+9wc9I?=
 =?us-ascii?Q?GJv4tGCZ3o+Sw4ZntK/1rJA92CJVWU89ydSsYiGXUaZ2BEDCZCzEnb92Bs/B?=
 =?us-ascii?Q?ct8d6GyZDOwH7oE2bI83LfkUK+tw9ZEjvYLbpFT/gJLfCn0KfbMA/ZWxeQsW?=
 =?us-ascii?Q?LJP5LoyE38cf7HTi4eCC6qUCCCFiwZCLuivLd5+eZkbQRGJg3gScaRB4xbEJ?=
 =?us-ascii?Q?6qJjbYtQ4orkkZeGwObFvA4YyKMeVgjIWY3wLt7F/PthFpPb9ukAk35oiLcX?=
 =?us-ascii?Q?KneEE5rifyi0vRoSwIazVzp8DBUBzc3qvnNEgpV0N2CrDf/ctz5CnECKzc5w?=
 =?us-ascii?Q?Wo+lrp141VgzV+TOViVEbHkBZjCa1RArNOuQEi/5cPqfXeRuDm4dv3GJ030G?=
 =?us-ascii?Q?GJEacdiZ0wF9QwRZcLvzasAl9eEOY3ntCmParNf8qPskiX+RMTuUFuH6fZEl?=
 =?us-ascii?Q?BaP+YwrMaoq8Yyf3NNowDm9t6c/TN4IGQZO9PWWSe4Ng68r0zPYYCF1HUchQ?=
 =?us-ascii?Q?ClLD/mjPC/lLr0XtWeTXkkZ5XWHedHtwhgFc4kNktnQXZ4Psm4+jpZ+PIstw?=
 =?us-ascii?Q?JxuonJfyx1eX3eB5/k+luiukvOZPvYLZJoC5M1UdRcXaBT5WvO6WuNfNA8hX?=
 =?us-ascii?Q?kEPtnPGd5u60pg3g7uG4FKegnRMrxHL6mM0w25kCqqzlmvAcWR4u0iG0pBQQ?=
 =?us-ascii?Q?7W3l9QvslelrCHoNKKEJ/K+uZwVCcKJ92bQcOQGn9yXotDAqOP34FBrMkOeO?=
 =?us-ascii?Q?DzSL1s7EhCd824/mIcgJjAXsFpJeSuVImNeq8fvR1njoohFhSzbqAfsyLAnp?=
 =?us-ascii?Q?Q2dOgZxvEcJKpWuD9MCASGZ61zlYkRePZq9QuXxyhf0I5iRKJbptjXpUYFy2?=
 =?us-ascii?Q?DFxYm3hnWJdIubMtXxPOBe5rlJbOkj9/jHlF1bgZoE8vb5y+oGid7Bk6HaNF?=
 =?us-ascii?Q?HCFo53aaGsE9JJt2uVnSDMycqJ2ArAVx1GqnvOxPTh41uGFqfSYAIqxY+0UA?=
 =?us-ascii?Q?G389lfhJUXwjdjy5osTNSgLM48brOm5cm6p5HJlKFHwZwyroaV4/QQm3JhLv?=
 =?us-ascii?Q?Aa2Yqn41lsR1tgz0RmAZ3JmoiMW+oxv7yfIB06+YHCGQ3zFSrc0TZ0VStt8L?=
 =?us-ascii?Q?PlWsLkpE431Z5CzdnziIH9uCaZOoQ+o2Q+ZnYKHCZYIDjCg/XOBB1R17uyS/?=
 =?us-ascii?Q?lZJkNnLmi2ixx/e3zHWTBTSbgSP1iESwkOj/iILs954uvA8v4DTN7R286kSH?=
 =?us-ascii?Q?oBmeKK8K0zODQqxpWpZHGDmgv8ACACEall1l2PvKpdBkkRoObSecRRuXj+id?=
 =?us-ascii?Q?SmApDVpmz39l/kFPdyN0IKexWlliY6U0o1F8ht3Vm7YUofE3UKEr2ZF6sxR9?=
 =?us-ascii?Q?U/ZfuxWkjSpY2kPUfRkYqYd12gsqsygoWqW6xQELI4oduy6///WF0nmS4Nk5?=
 =?us-ascii?Q?EyTeWBpeZqU+ooibGULt4PbYUQpNO4QDmV5S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XCZj4buYzWwsC7Hw8os99FtYWn0/VEYNf5XL8PXqtNjOw8epM8SligIedbXU?=
 =?us-ascii?Q?1WcdiB3DBXQnpnGSWt3w/cP/86fBZ9XPvdmbbEVeQUodz18jrseoioeNuAyQ?=
 =?us-ascii?Q?t0IHCb8sqlWVmpAc5zQYvvfS9IY8WYtcRyu4xbJPg9ktm1F6HRCcVdwzC/LI?=
 =?us-ascii?Q?ipvu+Z4BJEMav6a04TOwp5HBDvPwbGljPDx6YnA+FSq1Vr1CbL2Bvj4ihazO?=
 =?us-ascii?Q?EBaNF84WG6vIMS2bI3m5kD9VNl1nbLdniYUcq/VzVJ42Tfpmsplq1ysZMlsb?=
 =?us-ascii?Q?tJqoxo9sOUK5mbIc9xKfmsWDYU+KddwDr+TGWrNeOlLDSvt+f1SaMeHJ0rcj?=
 =?us-ascii?Q?vmxslHFXJQ6Tx8tGGym2co2JTlbDsG+AKCJGbFrXZO7zFViYLUnUFOk+GuST?=
 =?us-ascii?Q?EEU5Bxjs6c+SVumbV/ceuoYmRXj+12yZSsqtQqsCZ3mnEvmgXHxQGVs+cwud?=
 =?us-ascii?Q?keDQP7ZDPzKmbbdIwTkV5q07tR+xiEFxIeb0htVDrmjbhw4np0u2L0iLe60+?=
 =?us-ascii?Q?6pO1pGjHsYpXz1f9cg/iBXD2dG3KHnDbg12MIvdjx4pzbZkizW4cB9bdkKRy?=
 =?us-ascii?Q?HjVGWZGXbo4dKYBDUJO7X5lxuApWWWWSOR/ri01Ub9J/Z5IvbC6kq4nnPNRW?=
 =?us-ascii?Q?3jPrG4mYgEx5ejyf9Rf0CcUFiwn2EcrpyZrTTbSRKlrHvGBTGP4zg6/5FdcD?=
 =?us-ascii?Q?LIe05GfklYdZaGEKy/c8ylc6f7lXxubT6t8sYsVBHKhn8qGZqyQGv45k8B/D?=
 =?us-ascii?Q?IKgxk+3jiqXMwZE4bMmE7nW8tUgeGCXWu4rHMn+1d4+WDpv19F8VOPKXnsRq?=
 =?us-ascii?Q?G7tAZ/V57qlYYnLl86QnmHZHH5XepPk46+CBEx/MkdMYef/agKoH3wiZe1bB?=
 =?us-ascii?Q?fLcyRSIDfxEsOYk4nVMuTdBdonrV7+FqQgTMj/mYLxzQpUy3tB35LSG6I+0q?=
 =?us-ascii?Q?AJ06kZi4el9ES4gOVspCabk+ULUtLDtFi+oi5RIZnsPkv8JPhTu2VErqKL7e?=
 =?us-ascii?Q?mDEi5BdRjf1hIf2Oju+tvEp+WnnId4zMWbfZVDHfmvxUBQwrbq1naRYJhW8W?=
 =?us-ascii?Q?wvEiFxUMFZHajYdX+eJa3ZdqgT8Hpkf3fHCsh8itbuu4/r2oPvHtNgGKaZM9?=
 =?us-ascii?Q?mEdtX+RV0R7Qcjb8rAfJOeVG+281NHnANfif5ugmleo/416gczYqopIjRSLG?=
 =?us-ascii?Q?HT5goETs2/OTIq4n2Qu2BykFBGaGdtuAmvavb2AHLZvteu7ObuvJrnQOmIdn?=
 =?us-ascii?Q?rScx19iTwBODqsoJ1w3wxhT38XXG5qdQ1YnAfKuXY5qbVihtyPt5itbLhn1q?=
 =?us-ascii?Q?zcrpeCNFdJyoc4ljwb1lneIBJypfIsnLXe4K+yHGakds03wT60KguE5W2lPB?=
 =?us-ascii?Q?lhNF4yFo9lxsSEOqk8+MuRrPX6iPQNoq0S6yt0VswDvgoZxBzGUHSm1ZaSaD?=
 =?us-ascii?Q?YfGEz5XbZDC33ARgn2ePa/MLXSIw5sdLYvLgePZ0KKJZhrxgK+icyn+wW3Qw?=
 =?us-ascii?Q?DRW8UZAJwnrcE7SJ5AXAHvLf6MF/6iQ6Ipw/6LnWns+6o2ov+pCQRPHm3l0h?=
 =?us-ascii?Q?tPWbJvQIs8x73jU9kMjLGUrpKWQ4fjShNgSGqnwT4afBudAJQN7271h3ixTT?=
 =?us-ascii?Q?mTqoJX8pj7bYthBRbPyJOjU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a28fd9d-9809-46f0-abe8-08dd8ce65581
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:26.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xi3QdI2O8dQdpCsMM1lPlysBk0RM8UeKxjbYMMA49i3rG4OrgY4Q2LM0p6Ejip8uuPx87cSmSpFbkGsmdmzxLV2beC5b2R2D15Fvmw540DmcjV9yTNdRsvzp59mZDoTb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8717

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
V7:
        *Update component array to take 128-bit values to match ACPI specs.
        *Enable Vendor EINJv2 injections
        *Moved component array parsing and validating to a separate
         function to improve readability.

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
 drivers/acpi/apei/einj-core.c                 | 410 ++++++++++++++----
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 include/acpi/actbl1.h                         |  25 +-
 5 files changed, 379 insertions(+), 92 deletions(-)

-- 
2.43.0


