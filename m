Return-Path: <linux-acpi+bounces-11909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88676A55B0A
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB9F188B4BF
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97391FFC70;
	Thu,  6 Mar 2025 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tW/06XHl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2114.outbound.protection.outlook.com [40.107.223.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B617B418;
	Thu,  6 Mar 2025 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304922; cv=fail; b=MWg6E1nGf9CriDqxpAXQhLE3RJOOyPtwSd2JtxD/4uQZCZSCQkoxWKCbZSw4zqJroUdNmdSzg6wLnYkHU/Z3RaOh1UD6+H2LKt8YEhMla3moB+0TqfqINZm0eJ6XG+FUKYhcY7ZJ5TIOffO7Mja56T3SZ7XGwWPzmb9BO02alns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304922; c=relaxed/simple;
	bh=CMVoGId5f2YzOknTvQvRG9dcGB+plnHqp1/8zR8ODVI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=C4NJs+8wJ0zVGmGnspYJ49bWGppvHNIOMMQVQGOsA+x3hr92EN1Zgc18uYrH/pkikumoGmMGZIFrJqAol6kS1EZK6LCZpVWYgUmw3BYjKIk93UN8fYURK60mjANreH0w5BVT7K92Rq0S6mPiU81HX5tJ5U3HAop2NE2O88ztgUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tW/06XHl; arc=fail smtp.client-ip=40.107.223.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7kkl51RYoSQRKyMTwUUtSLRCXM1nutempJPYnAFraK84hMdNJC4nezkgkBuvsvq0MgFEyzyF5bSuDJ4g6RRHX+XROw4PTYWy1w14NVTDCHmFeUjoso74rW8RHddOw0PwxdF4xG/G7w7OS+PWtWKFaOHRIoYqL/H40tG/jhFdjXWIdqnooAwEdOhEOT8u9la6jWLsmh2667hizZYrPhVvVZUmeVW1a0XJuxTSbj//z7DHh6/nOvhVYKGU0e41JqiAz2AiFLqfvXTwh6P7y4vYAIbVTtHs5zAZCRY4ltWXwPLdOAaVxGPyX7kg5FeVpbywD3Fk9tDdjRiVZQhFH2T7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F1gn/cdXuTtGd+ya0HlTGn6K2ZkAaLDEk/dwqLfPAY=;
 b=wNjIp0YaU/UW7NU5uBquK2JTiTzNzdPGznDl9wadTZIQGv+2yYkqPubprOP9kJH0/6U1g7oIhypak/WvoVsLuej5pu7z3nvGMlgqv5TxEbi2B0XhR9PoRq40zbEvd4TOcgNaeRqT4CslZZ34KhAv3KGTIl8ep63A7N+tjvqElcI6mVYpLNeFBj7S5rDgBnc9O1Ks+LNYmSZkLrDZzFDhLYXTU7aApHC1AuT1AFfJXPUhWvcVXKyAF5Jt8Xm3U40lpLba9zBz2cA1w3d5FmsbMRTl62oAntql8b+GEvlM0mrLkb5o4wfzs+1SLzLejAMLvzl4mMBXzdjLzSvteeyyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F1gn/cdXuTtGd+ya0HlTGn6K2ZkAaLDEk/dwqLfPAY=;
 b=tW/06XHlssz0HKfcRv/X+qniuSoRmBOZJkyDcwPY7FMyKfP7ABhj6U82NpofH7ayeJBnGOMpbApO3QMiEQmFGfFaZqUCgE74NlGGp9dkzrS4jIrO+pyVjvSCDNmahf2J19qcAUPbUxcdFdcgDae1pBIgWK3DWOGS/hWv3HfLJvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:36 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:36 +0000
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
Subject: [PATCH v4 0/9] Enable EINJv2 Support
Date: Thu,  6 Mar 2025 15:48:01 -0800
Message-Id: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DM4PR01MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: e868e77f-32d3-4075-42f5-08dd5d0969ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUd2Vh5jBuUYDULT+FsOS0g9tbB+d/G4ZuC7WMVktNKnCsRRPFWizFQtjsDZ?=
 =?us-ascii?Q?LbXpkNNA7ECN9xR1XXoWbtGyrtFa0yK3NkroV3dxxlqKxD9dOnRVuRb6zsUE?=
 =?us-ascii?Q?gZdKV84v8OoMHLDPqykFxIt+LzvhT+dPde2f3DAqtLKOsxu0iBfvY1XGbS4U?=
 =?us-ascii?Q?kjKv0I9oV2IfWO7fBalx+CxTIvkHUKFDBtBcSuqfPC6sI+2VN/kzwYp+hNyJ?=
 =?us-ascii?Q?7Qy7XIWYZdt+2o2OA2v7cJiIZ1tKZlgYaomQQI0jkpxo7V4z3t1puDz+CfHq?=
 =?us-ascii?Q?SiWCQkQQx+Hz3PJuJ/JWhh2DEnQockklTk4bcV/vVyOwS5T9MDb5HP8GUigM?=
 =?us-ascii?Q?TTeQ0tnuFumP8aVhEvprZEtlAYFJ7ysJejam1zLwUc0N3gLMsNPSwtuG0CfO?=
 =?us-ascii?Q?HM8fN0VtoJmoRFZ0RdlDpQKCQ0vno53QilYL0BQf0Hc8c5fJshOivykVSW0M?=
 =?us-ascii?Q?ZF4qLs652yhqCpWNuLmWeUEJC5qlVwM1K7vHJtVst25QgBJFJ1z6zFv7Mrs0?=
 =?us-ascii?Q?HfkTovijjriq9F5o2uTCEES2D3WmwEv0nTAzR6L5gwxzhLhrmCDUkaR4yeJn?=
 =?us-ascii?Q?foEHLq33xMrRtK/6ODg5WqBkCfuuvEV8Vr5h3IPJ75J2Y4O2YpK6IOeK6Anm?=
 =?us-ascii?Q?9hcAHqhyrQFW55IliYNmrLBOlBctkYKZNyhd9vBOhdtUB6cB6XxDQjyiCJdL?=
 =?us-ascii?Q?ssMAA+gze4Z9eai2He1dL92K2J7FzVTky2goxs/VBitJWch6F9OK5AusekTH?=
 =?us-ascii?Q?5/gZVE8WyT75aj5EWegQP6MxnZcDlpPqt2snmjwcFkEM6dR9mg+DfRm9tGkX?=
 =?us-ascii?Q?fcGtn/g5dbQ5qxX7d8sr7rMLRk/1On7z1xueaAxgaegi2vnOZIes2U5KCPdd?=
 =?us-ascii?Q?pBIEoYUxtk3veQKnD8U1iIPg8dhKfT+Y7WJns5mydhejb20uMkXzeZkE+vlf?=
 =?us-ascii?Q?69H7bZI5w/qRGQtbCv2ZOFEKhv7MQQWwtGR5RDA1q2FRlH3X1W5Xk7Rrmhco?=
 =?us-ascii?Q?vz4Hwkg8uyl1iLrc5nKsoB0qZ56Pf60rJVy11MLsuYIS16M5Sq2LmzYyTEPV?=
 =?us-ascii?Q?cdttFIr6rxPwiqaYkzUBhAL/QkI1+3aPeqo+OY4XMIRq8T6SZnLAsGyAX7ur?=
 =?us-ascii?Q?C6DJZngvmE4ZTG15B3v8fZHfV16TdqVcZ1mR4gpkGW20kB1MMv60rcgjk/XY?=
 =?us-ascii?Q?VhT3zzg8cFVDCwh3mX6upTZDk6OYDiDEEY+lkv3yXopKFHzWwi4F+O36zVCn?=
 =?us-ascii?Q?2ht+9fJ9E+h4X8HmV3WHyORBUiReGWOdR0eC1ub2Gg71180NyYedxYIunjHh?=
 =?us-ascii?Q?H9BLP2eeZfRXVsYqa/hQPw0a5KjWKq0uoS1lD/c8FyyJ4hlu+j/TDqNIF65u?=
 =?us-ascii?Q?b19/Gvkpc/e57ablbsQ6oxBEXa+8I08p5w2uK61/RzAHWTJAKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ymMfegMFCiZIfpx2DR1KyEc4BE4p/+GHq9eGT2/tjAaFfQYLBnrexbytmFr9?=
 =?us-ascii?Q?4IL91KR1jU74vHcQXl1AOsIepnB9i09TS2a04tDPGH9R6QUABCEaiFCY6ZdF?=
 =?us-ascii?Q?Twk/vPMo/zeorTgaUAsEEy5BAGFYyl8O81NX5CCaZk7xtpWXjsAOhhhUVK4d?=
 =?us-ascii?Q?/FvaubyAK5mKSsR52bM1R5ZPo7BsZ9n3qzibYziTbL0hLqHhpNPSP5z6pwXe?=
 =?us-ascii?Q?pKXqmKwf4ce4AXKbNwUJSqEb6PORDjXII8t/F24tFoR9WJ/bjLhggVmK3WJJ?=
 =?us-ascii?Q?NjcowHZf+PfAHxhUEi/p8+BEhhpUvdfkFQXHh41+wNh8hFZBIoLLFRX7JVhV?=
 =?us-ascii?Q?jRM8/9P83yrneh7mEwpNWs07ferBWYu3V9yyr3WJ8zIjkdF336yUwESplvKW?=
 =?us-ascii?Q?B32C2TL0G5kwaRwUlxpQjiowH8lClxJHOBeRttBlOcVWQHbp8AAMJdQlH+ZC?=
 =?us-ascii?Q?fElLlHMRpKHCELNbldzDroIeP6MfsBZ1ByxpF99cXD0wXyqdOOQSSwl4WYv1?=
 =?us-ascii?Q?H6SoeIRCmJ9hVfZuiKAStxFBx4lb8BJaJA373Af+0w5XD8dkZYYIPxHzBnIb?=
 =?us-ascii?Q?mKeIPfcIsfALaiC1Qx8z8acjMut0mYsdJzeOUNEebunuQ0OHqJRjuqC6U855?=
 =?us-ascii?Q?0ZJvMeBKUdV7btMIiZ5AnGp/3K7BmtjlasXcH2j8jRNiVlsZlUoWHH4GXR8J?=
 =?us-ascii?Q?DsPZBcma2D4fGj2ny1J90colAVoPCAyh9sPjmVTNgfJJdgL+8vFSSI3wXalP?=
 =?us-ascii?Q?lerd3J0/CqmfarDFLyMoovpUJMy8YIt1ZKQNFXVNOpORv8wG038hmkOICVYX?=
 =?us-ascii?Q?jJatbriNlNr8+XS3dF+TyEu4diPakvMBrD8wU+OLrPrhMAwJFJl7IkxWL0LM?=
 =?us-ascii?Q?e9gbudcIitXKLjHYY45dyjGsDDL6Q3f2vPkz+oAW01lOo+E0sd7RYY+RJXUU?=
 =?us-ascii?Q?I2KvnRX7kL4VzqmDpoTG6nQRQihj37lRKBcbLDcyxMDbt9V2SmJEw91Um19q?=
 =?us-ascii?Q?42R4+XvfFfMLwabBpdPkumqTEpZEjXsksm/pSrOVIDShw29KPPzjv605SnOK?=
 =?us-ascii?Q?Izx3bcIwT9jPsvcZ1dd+5RBLYzp3YSPSlwR2QYXTZTdvSdg1a4pqa2AR7UTE?=
 =?us-ascii?Q?4I5XAmNCgcme1czEyuDzQ/8wu/jboLY6aM3NI5h1hOWM1BtnxfIpMjWT0nRj?=
 =?us-ascii?Q?7e0eWglSO1/g2I8EsWkO0+gjwNv1ch7IoyNcJAT534UgAUxNB56aDQjuVbS0?=
 =?us-ascii?Q?QupvJojIN/05N0b0PuU9HejoJCX5bf4jdA02LwtbP1AeU1x23UxxeeHbCi3S?=
 =?us-ascii?Q?1wRoHX/4mvT1makg01p8Uc2/hnxX26PHasYs3RVZBs4d4kl8zA3y6Tbd+sWN?=
 =?us-ascii?Q?vSFZTbx6QZ/OZnikjFnq2bmXs/0NGpNF0xg6SzYZfQnw9GXk+m+L4VMJSzri?=
 =?us-ascii?Q?Jv0ETfmJJIES3PR5xYm64nNOIZOLmKqEgqwX5n0196hm558R+t1rgR+APM4/?=
 =?us-ascii?Q?jzPyTnJV2ilkFKcgT+9dRF2OaeZnP8hQwQbp16JsSpEMZ661dNsNdx6a8/gj?=
 =?us-ascii?Q?qi3dGoghZMZym96sy6LpBZClFlUA2fJJcbFFFz4OVN/5YH/LTKVrSjvp/hTj?=
 =?us-ascii?Q?njyaD9Hzrhf9Vz34CB+Nufw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e868e77f-32d3-4075-42f5-08dd5d0969ba
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:36.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Dcm16SsVTYm3i5wW3OlhE389hDtrf6+e1EbnxgLdjCl2qsu3O4GRfxMOJ75zOkCxjeOlKQ7YELLP3TYRV2oElRRyCcZCkN4Kf4BdfF8+KHTRdFr8+ZOqK1HpmNV3Apw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

From: Your Name <zaidal@os.amperecomputing.com>

The goal of this update is to allow the driver to simultaneously
support EINJ and EINJv2. The implementation follows the approved
ACPI specs(1)(2) that enables the driver to discover system
capabilities through GET_ERROR_TYPE.

Note: The first two ACPICA patches are to be dropped once merged in
ACPICA project, see pull request(3).

(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1521
(3) https://github.com/acpica/acpica/pull/977

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
 drivers/acpi/apei/einj-core.c                 | 322 +++++++++++++-----
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 include/acpi/actbl1.h                         |  25 +-
 5 files changed, 299 insertions(+), 93 deletions(-)

-- 
2.46.0


