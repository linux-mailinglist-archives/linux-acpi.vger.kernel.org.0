Return-Path: <linux-acpi+bounces-5921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CF08CB522
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 23:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5451C210CA
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD4A14A4EA;
	Tue, 21 May 2024 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Cx1i347i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D9149DF4;
	Tue, 21 May 2024 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325860; cv=fail; b=usy97NkI6hrFFkp7vV+r9e7WnykC8tI6GcydqdvfU1u4eld+F5c3ngqhAURP5HVnoFcGcHtLwB9a4qlB0MHKEWFNWCakFllMHyYZRmwu7WC770rZzS05Ln1Z4HqunW0weRAS6tUMZ5mSth1WigeJ4ZNuKrzP9bs7NtP8+0qG/kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325860; c=relaxed/simple;
	bh=7M9o6B4FwI1ZECcsNLZ9Dw/9ldoUVu8DqMM0XmT0UZU=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bkFaiUrQzLMuclkhcQWabUJVrbWoeZoDHZNLfuJCz3oDTLWAtScrl2OgzewrrQssS5Dt+GreYjPpPbQIClAnRbvWCBhd0iGaitTki6+otSwFHi+E3nciUUn6rt62Hfbi3HkGzq4MlYm4SUDZ6m1vXLjMY4Orha49YI/RqQeTLr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Cx1i347i; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKNNH8KJlKEX7VGsbzIVKnrA0ODbmTNQNYVsOhxB7/lw3ZOMIe0wu0tri0U1UWbTd9KiNiuLBr79LNgyFRbCkQOHH3PVwM2qYYc2QIzcBIoFIYvUQFq+X4rTyxvAPvxu6Gi2on2deKoMJWO6wKqmEJLW033B20noFSFmWgHWGiZVd2jvykOoBOucI/k5qoZe2lYS6wyP6l1dOlnc/X3ATFvgmwxlwwurViEEsxjdBoHvIP59q5A6vZ58NUAyzAmvCpSjV7FvD75HwYKDDFxIPM84paEv83+tlz6DTcIsHGzk6IVyEvmo2+rvzvySRI38XNBLzPr0J/zEVwyAFmQ2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4guYLmmXcaOch+gq00IeAjlBGFDS28PJ2QZLWCv5oA=;
 b=joNtey9K6uzidLVLurlwHO2NfagQP0kf/1br6oHpkp9wU3tWDNVVN4glneKcfb/umfL5cZExxeHDHrto6OxWhJi0wCA34FnJfNBzPAcxUhAf5doox7y1aZ4/vKDT6z2hJAeHrRKl65sTI15ISc7LCb6ZuCrkRES3DIFpVU/pJw6wEaMZCbqCHWpB5jahh8rwOnkz8VNTjmVfcjHRocBYXWS8lpg0G2yDR2ge4x4qGtb07luEHZC2Vu3dPqJZNN3JkRbxcVETUJgLg/fLxupAj+1PtM6Fb8fOSljqChVKPtYSJbgDNtFiD9hJRnbkWf3g3mBZt7U7Zrc6FuJ4rpfq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4guYLmmXcaOch+gq00IeAjlBGFDS28PJ2QZLWCv5oA=;
 b=Cx1i347iIBGwOlg2Fya99XFevVElGU1sK6ni5dpK5OjBC6PC7H/XXiRMfMpljHrTy91X1Ag6JTWoKe7rih4O5NwHSJwUt+fa5XxmoE1JRCNf/+MZSV/F8h6U1EPe6SyNkxRan39gp8m1pTBNUdhA/vhr2RJYSS4wiKpRFyfyQ24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW6PR01MB8627.prod.exchangelabs.com (2603:10b6:303:23e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 21:10:54 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:10:53 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH v2 0/8] Enable EINJv2 support
Date: Tue, 21 May 2024 14:10:28 -0700
Message-Id: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|MW6PR01MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: aba7d3da-f48e-4f65-f6a8-08dc79da7fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48OaJ4mKZ55cd5K8xLgCFLTDs6nbd0gso/dEFEbCqfe4qgIJsdWETaJLmaXY?=
 =?us-ascii?Q?hQvJ31VCJbKXnw3R8dJlDwHgPIiOd4YG+Uzgpss+dkvtKsJFaWlv8OC0A5ml?=
 =?us-ascii?Q?vtcgobr9qwlqj+LHUgFjg8g4epJAokAaks/tVpRea+yLP00jgQLzc+MvNtWT?=
 =?us-ascii?Q?Al+XjqRSduEoPKe+q/0P0qUCIbR4jRYD+kkzEeJQ35dJiq68AuMvTDN7a1fm?=
 =?us-ascii?Q?VsRe7V6FgEwv+vgmyNF17JDDkyUMyQyy8Q3BkLLPNTBWVQyjTtecA0aPAex3?=
 =?us-ascii?Q?C46EEqmkT6nuFFc51e3BvG2H37Hs9gQTR0S98VUSKBK5STuMADhEtQX4PV9b?=
 =?us-ascii?Q?uK7czv0GRRIHLkUiZEO2GML3eAhYd4DkpptwqdDxJPkviTEGURvML50ACxcF?=
 =?us-ascii?Q?pYnhLqAObCWdK0pZQcB+A02prSHrbiaRNGmFAlsNZgdaVhYRxj4BYleJiQ6+?=
 =?us-ascii?Q?ActMFmZTFJvaWxg312M4c08TnBBvxd3fwgkiHWyW0FxmqTyipLrUvUtXxHaB?=
 =?us-ascii?Q?Y7a8hmhUMz49m1FJOBtaNzUzg3rKtT2dYDmKlse2vXVvGLgetYIYVMove7PF?=
 =?us-ascii?Q?LCmcQsj8sqrLNJZP9GnTQjN/h+0/6RyYlFD722mlikskwqBkkCM2R9Gie5cX?=
 =?us-ascii?Q?eZEky3BgbVvMXjvJzENady/9L6lDCi1OVh6oTWruxRSB88iDDu7lbeDm9OTf?=
 =?us-ascii?Q?9PCwdhmEQVZzfj2lgmY/WZs8vF9+QMv/A79vbxz8k/rHqjpXL7jXl1df7KTa?=
 =?us-ascii?Q?qgwfzwrqfzUo6yZkpqAMA0Djk6JyQd02ltP38hAbi66CKXko+1ccimoe3voy?=
 =?us-ascii?Q?+tYFd0sBuVOMdQb2LRGjJTUkWjGco5bZhkdmJUgn9Gdk8FbowNh8NM5oIcU8?=
 =?us-ascii?Q?FfhlLx54PXSuSVtTATOzX1RL5gI8qXWEcfU7vI00sUXYJ4U/Ox3JizrvITFO?=
 =?us-ascii?Q?t+pn27tTObQ/WrO+Iv9/2xySBDDQ++JcnGtNIe3sFtzDTdlVM2XZsm/ybD22?=
 =?us-ascii?Q?EBhIqTzBrSrYRJ/72wWnoNyQpVTeBblbYJ0e8+rj3KO5skD5X2ER+YslFq25?=
 =?us-ascii?Q?jsGbJi09QUJ1fh+m+uDUt8lxUYr60guEOZqozsOHHEks884uSGZfMR1MPBXY?=
 =?us-ascii?Q?foiqMcAxLljGg8Pd99tEcRYfbcMHFIUaVapJoPtPJH+CC2rua4DzXkYbDjpZ?=
 =?us-ascii?Q?ETcrNo9xTiBsYFMm9iQczLpJ+R1qZdYSuiqFu7q1RNi550V3gA4PYikSeh2e?=
 =?us-ascii?Q?4j5UBCmB4OKXEkMVI1hkD6w2ITDkYJoHfPRO4YFV69tp6bilibqtHW1CiYbt?=
 =?us-ascii?Q?vgU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hfJhicWS0WN1Dlnk1WfIJjzfkoNyQU/eFbjqkvVZevX3RtDrAZ2c2fNdOLQZ?=
 =?us-ascii?Q?ftUWJB9yVDmwQd5dGB4lrVTJJ/blC+uAltAkEfzyCCGX3jwivJHrv6JRsqHv?=
 =?us-ascii?Q?MnZXFCrwPc0zhM1aZBfaxmp8oJpZDbxNRZ6yclNHPcHviBlh1Gt1pCV36Wa2?=
 =?us-ascii?Q?0cqf3B+d0JpjwBAlpA5MdFb0NTuqNjRBL3pKNH9KzzwCay41k2PO7VZwa5WP?=
 =?us-ascii?Q?DpQKCato3uhiBqsI4nZBXghEa+UcRlwbwTaHti2TVN+e+jE1dVcXxgQbUNDI?=
 =?us-ascii?Q?/ZZyA8Zsp8Aw45cc8w/7O0i85WnQLGDdzkMDi2b6cXuSpKJiEjYErJ9kdtVr?=
 =?us-ascii?Q?502y/FhHslYzrgEnAwnJgRPOIlgpVUZaNTJBjpB6TblCHUluXa9rTHCctBS5?=
 =?us-ascii?Q?VsWc/DsAxjzakY/4F35+7BRXz8L+nqfxf1IpS8gEiaaisUYfk5goYs5UtyEx?=
 =?us-ascii?Q?fc9XaZs2BE6o4WIq82PxYVQxGe9jf/CASK7unqLCMvtTLLR4DJnuCXy+Ii63?=
 =?us-ascii?Q?sZDT9QNPzDI8LGPc68us8I7R6U+gjs0mdR7xw6d5vI+ja+0L/Wdi699/pJc+?=
 =?us-ascii?Q?oSPRLcg8hZqrbFf7LKe2zqlw768nbXyEAvvW0yuBO2lSkfEZTTH+CWREFxUh?=
 =?us-ascii?Q?vD7LXbomB28KkY2wuD3Z1a723TL3l8uHXPisfWmvSFnVeDiMVSVnesePvQaR?=
 =?us-ascii?Q?QAfzW1DhSwoWYV+UzW+Xn/YtIBV6jRIxw1XDartqsLyxYNxZiCMQuvxb5iUi?=
 =?us-ascii?Q?v96FsflftuEqTyl1+uazP02eApg41Mehypgiaf7f40QAx8Ws3m6TFvcymMBR?=
 =?us-ascii?Q?9jO8NkOzD3vEdmObNY0eWcqTZ8g9h0W7X7bP4jqy5Ub1RI1k7gqMbPciij2b?=
 =?us-ascii?Q?m1SwIfD3uYAKCtrxsJ22B6+FRXW9lzq8Nm0Xv/VmwAoqAC1jTK0DcFsxPTT2?=
 =?us-ascii?Q?7Mhnvc41iWTkAdkp0KFV+MiDqCCmelgx8EsUfKaFC3TO5Q9Ma8HA/Jhz+kxW?=
 =?us-ascii?Q?145w3cQReJTAsFJxCBk+z9emPHIKG1NEhLcc7zdxlUUROMrktR3h0Y2PI3+d?=
 =?us-ascii?Q?q8JspWtNzg6VQ+/U5rl/z4OzTDHxHOffE7205QjNGhGvm9Sb7axHXtgTIGej?=
 =?us-ascii?Q?nWcCoC69bMh0nd9o+kitRT4wGa50tHQ9eIV9Zd/GqWLp6UUzwHIlIIpB3cIT?=
 =?us-ascii?Q?BjCtInq0fggoSWZbIOjjW7LMGnlQ3N3lh+DpNHgVXwlIBO8RBPiHsman03HH?=
 =?us-ascii?Q?cQtDOfmFr31J90mGOgjjZVw3punALLwf4dC/mrdKakNFK1LcCc0ujZFbVaOv?=
 =?us-ascii?Q?T4INThMxd/QDLuQZ/kIeptNKtRIVMdM6MTVGihMLnB2+Xbx7wopXgAKT0lKU?=
 =?us-ascii?Q?qo3TQ0rbI/HUrOxVfWhOKkql/V0q9/6hpLucPtpKRzu/BIkcYFuAwS06z5//?=
 =?us-ascii?Q?ooVphSo5AliV/P2zoCn69jGwt7WPXWVXlUXinX+JBUvf1d01Vm/p4GofCbsv?=
 =?us-ascii?Q?ztOFSSJRNDQGVWahcmhLGMSW0bcbfgUDeAttWzSSlIVFgkiQhxFMjHAyVQL0?=
 =?us-ascii?Q?M05FiU9kkbFM4RDT5ijw/iDc9R/UXO4kl47K6LdV3puLwk0dnUZv3rYDj7nA?=
 =?us-ascii?Q?iwlzl+f6tSIIi3fjDexQ0Xs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba7d3da-f48e-4f65-f6a8-08dc79da7fb6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:10:53.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMDqd8m5WkKWuIyzKHZVEW1lGdMFntnC2bm1VN8R/XuGPz8a9eDXH5Mzgy7KWyrN5cAAEt9JULHAyIsiadIEFdKHkdsZuQmQrx2XW7wOqFCTJ61KVlzb5yG/LaICRtS8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8627

This patch set intends to enable EINJv2 support. The goal of this
update is to allow the driver to simultaneously support EINJ and EINJv2.
The implementation follows a proposed ACPI specs(1)(2) that enables the
driver to discover system capabilities through GET_ERROR_TYPE.

Note: this revision includes new updates from the last review, where
some changes remove redundant code as well as converting decimal
values to hex for consistency purposes. This revision also includes
CXL error injection updates.

Note: The first two ACPICA patches are to be dropped once merged in
ACPICA project(3).

(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1446
(3) https://lore.kernel.org/acpica-devel/20240514184150.6285-1-zaidal@os.amperecomputing.com/

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

 .../firmware-guide/acpi/apei/einj.rst         |  51 ++++-
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/acpi/apei/einj-core.c                 | 177 +++++++++++++++---
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 include/acpi/actbl1.h                         |  25 +--
 5 files changed, 214 insertions(+), 43 deletions(-)

-- 
2.34.1


