Return-Path: <linux-acpi+bounces-8481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A49892E7
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 05:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8A6284B60
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 03:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560221CD0C;
	Sun, 29 Sep 2024 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="GaAn7lwb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B0229CEB;
	Sun, 29 Sep 2024 03:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727580187; cv=fail; b=CBsYk6+lhi1AWHtPT2f+YGnIrmKR0SpufnSm+p7y+OOaRDY3A/KWq7hXZQ2FEbprVENVtQD2K/niS2Jj92AzkYR2EOstkEyjrLeI2XLRP5dKS8fdvmLhAJzt0OscEojiZ0HnM1Kih1oMqk1fMHs0mXLdKASwci1veA6afWdMnTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727580187; c=relaxed/simple;
	bh=Rm5P8YcjkPuhJIpofUX7f3G6oWwtMce042sgTg6T1cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lR7NXZUVOY3cf3t+tsFTv8kKIA4JkwJOpW9KRXRjHwqAZuPmcmbFU24mVb5Y8uMa7AQc75OcH6zQXaIZ1uU1zKCbUcpu/v3X0eIp+865dV3GhzCdqe0v34mXv7slDb5OJs/Zx4qvMX2I8YEX1SUGCXDG+m9VDMoqZ/t2azYERuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=GaAn7lwb; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSDj5JI0T+qeenp8fx2fncDkj6i6sBEs4ccogkviG1toY6SAZGCN+XtQ/On3fgmWfVi0n8DZYtvGcVwnE3XGMGoFvwu/GbrP6i5y8qVVIdl/EKM0PkHq7FfrEzUFo9vje8C05dZeGaJ2T//oxPfhZK2Vh0TSgRr+ejSEPdH2WqctTEZ9Q0eLsj/iqPEWYzyeeG5AezbLPK8JieXWEfYVx7qy4RNormIiddM0JpnVKaaEMhmt7vj1nIj9nXB7U9ZeeR1Dp9FNp7mr9X1HqRDFEG744HVWt/aHt1O4qiXOk/Jdz3RvAswPh2+sPlXASC20x2szwKLHtxZL1gxpEJjqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nDLp4RhZWLg/5gYmDLOnZmVQfCj7QwFuGlOBdEZH2Y=;
 b=s2+psY1GmCm9ZJa7ruMoEt9xLqKXH4pz60hL6XBIm2uQrOKs5edjtZDhdbNba0NTK4Ei5ytQbIaOH3TSEyYtxK/tM/EFn9WPycmbwKwaDL35QTLVNSpzwjvdybJT8RKZ9icVzKpjSA8jSADDrWj3QZq4c9xlEwhndkFmZS2sSa74TXmLnYcfTJ2QwQf2JZbHx7NkNgM8+ueu+wo9tGgEQfnZs1pqKBkY590mAen488/r3abbsGvAHm00QbHB/rvTJVDpnKsfGlj57nq0DZEafvVMjfFQUhEcA/Kum9TqNxV+emskm6aXctcGpyDUyXJPIadfawXumyTFVKU/562RXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nDLp4RhZWLg/5gYmDLOnZmVQfCj7QwFuGlOBdEZH2Y=;
 b=GaAn7lwbfLZswarNIqhcrch2lNbBXCTBG11r1+KS7z8IpjZiRqax3ZdGY34nVWNpdKd07vRbertZxVgsoluv0hStIER49YUUcLPLSpEAFA9ppP9OPWHY+URhzWFfxcFaZwOjpQr+MqvO+v0+uK3cCti+ygIKEIn+5VYXAVxt8ITLwgVctPw9NSye9h1ERXZNQMxtCq4QYWseHwok/VR0/0G5Ry29LUPEWSi1FvsHIY7F1sQwtiC1D1H76nfnPJlX5nByhr/q1gNdqt+ZONEBndxbBiW8dC5M+z39bwjWVQk8jkA5ucEwnUTFjF9Zpj5EKurp2VFLdmI2qAQbZkiZEQ==
Received: from BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16)
 by SA2PR08MB6762.namprd08.prod.outlook.com (2603:10b6:806:11a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Sun, 29 Sep
 2024 03:22:58 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::fc) by BY5PR04CA0006.outlook.office365.com
 (2603:10b6:a03:1d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25 via Frontend
 Transport; Sun, 29 Sep 2024 03:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Sun, 29 Sep 2024 03:22:57 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Sep
 2024 21:22:56 -0600
Received: from BOW36EX19A.micron.com ([fe80::82f9:2375:13a4:3273]) by
 BOW36EX19A.micron.com ([fe80::82f9:2375:13a4:3273%8]) with mapi id
 15.02.1544.011; Sat, 28 Sep 2024 21:22:56 -0600
From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Srinivasulu
 Thanneeru" <sthanneeru@micron.com>
Subject: RE: [EXT] [RESEND][PATCH] EINJ, CXL: Fix CXL device SBDF calculation
Thread-Topic: [EXT] [RESEND][PATCH] EINJ, CXL: Fix CXL device SBDF calculation
Thread-Index: AQHbEPtEY1W2r1rvLkaX5a4eMlA7ibJuG3dQ
Date: Sun, 29 Sep 2024 03:22:55 +0000
Message-ID: <4f77d31e4ea146379247288557892819@micron.com>
References: <20240927163428.366557-1-Benjamin.Cheatham@amd.com>
In-Reply-To: <20240927163428.366557-1-Benjamin.Cheatham@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=26f1b6d4-5230-4137-908f-3519c065936f;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2024-09-29T03:21:46Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
x-mt-whitelisted: matched
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SA2PR08MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d49cd05-aae1-49d6-200b-08dce03603ec
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jrZBxv7LFo9DtTpD5b+uvNzUTIlCvvk6H4e8KJ3yKjlqwePcqg+/iOI/eWLo?=
 =?us-ascii?Q?TK4exWYnGgSIY9Gcv2cL8YIQlk9nyN6RbKUHVLKB5hlwGkvzRt83tO8LBIwd?=
 =?us-ascii?Q?zDbmTsy8GJ7zeFltDxWO9DCTkCs+BE0XecYV2K1kb+ODGuSBEmo21pVEhDyU?=
 =?us-ascii?Q?Gt1Ec49oZCFS1rQzYjQAimiuk9iS+G4+a/L9FX4da1N07ZcEjuC4/YLi3kgZ?=
 =?us-ascii?Q?kJWU+e1IQXWvP9jHOpMdDWxhmg/MAbk7gw+iA1EQYB0tCjEdNrgnTvRrAc4L?=
 =?us-ascii?Q?OBEXL+x39bM9sepvoA8DVdQEL+pGroIL7YQ7IKa7QlX13XG2YwdtugapWqHh?=
 =?us-ascii?Q?guTt6aSmGkm6UpYzBjwwf1sUyk8tqwTeGhyy2CyOqQWkiOFAxjGgNCLmcrCo?=
 =?us-ascii?Q?kLeB6WFTLxms3S0ZnDzFcp2G8Qbdk7hS3CK9st9O/owNB9RDxuf/d7p/wRAh?=
 =?us-ascii?Q?gYCj0fQharAk5qnh04ymozoIOwLJG5uw/OL46NUTz7NHlXKUuifFBEvCv1KR?=
 =?us-ascii?Q?C50h/uKG82uRVkocB5z7/F7/iHCBGDmoYvHhan9GtZFeS8P2duw5gTPWjNdH?=
 =?us-ascii?Q?Ot66s+iYp38na97mHYl5eVv9yCCrM3T2/M4gCiLHpWhjLkcOd3L271nTe7mc?=
 =?us-ascii?Q?wCGL9JOrv0BfbkiW1gWygV6AVmBb05VPHiJ2JsypGhYFivYpAn0WWYRRbPCy?=
 =?us-ascii?Q?QGfO8YznJ1fsormPfo7QneJI09654TUtwxQJL5W0wPBXHHM80cG2dKt1eLu1?=
 =?us-ascii?Q?OA3TdLjugWiKtTj8MpOca5BJ0sJmn185Dl9SMJSikan9oiIhDkzH497AneFO?=
 =?us-ascii?Q?fsQoIeODRApRbC8T/werRH/JOSGtemi2CKdV6W6UYLs5beBPX7YhFburdK7x?=
 =?us-ascii?Q?P2Oss3B+XPJx+3KQpgWTjuHHAEvsSb0VBBiL6ceNGHGiMm/iQZIEshGRNJ8J?=
 =?us-ascii?Q?rjLm70ij+38SOd/hZkqiZXpUqkvuYZlDsGtgML5yX4U7+21nJVo/usaWdMP0?=
 =?us-ascii?Q?hRo7dkIGysLI3XLgiXio0yqavUjrV+DbgfVv8eCmVVdpGXHV8B5yZLr98XNH?=
 =?us-ascii?Q?z7hkEG1GLdh/IiztZs6a+CO8UxdJG4hKBsLH141MerWm11y0/C1/r5jYWSP7?=
 =?us-ascii?Q?Y/Jbt42j7J1y6q+fO3e6J8NNXco+ftmY4uYBToquuWaafbakzouB2CYeM1I3?=
 =?us-ascii?Q?dvW6TZtdeGEC/DMOBI4wChgWXQ3Sy2AMwskKlfomOw5d+5GlgH9LpgMc+22A?=
 =?us-ascii?Q?/rKW8TyxTW/odppQ3sjWinLCgfY9ePlSVbJYIbXT6+mHp6jH94I6xd/avJVe?=
 =?us-ascii?Q?Wv19INsg1pc7xdFrJIHa50ViujpwnL/IPS+mxS2DFanPWOUc30HKGaynSSeE?=
 =?us-ascii?Q?sANxnnI/dYGxhOkBCsfCGAGtHYKp?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 03:22:57.6398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d49cd05-aae1-49d6-200b-08dce03603ec
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6762


Micron Confidential



Micron Confidential
>-----Original Message-----
>From: Ben Cheatham <Benjamin.Cheatham@amd.com>
>Sent: Friday, September 27, 2024 10:04 PM
>To: rafael@kernel.org; lenb@kernel.org; james.morse@arm.com;
>tony.luck@intel.com; bp@alien8.de
>Cc: linux-acpi@vger.kernel.org; linux-cxl@vger.kernel.org;
>dan.j.williams@intel.com; jonathan.cameron@huawei.com; Srinivasulu Thannee=
ru
><sthanneeru@micron.com>; Ben Cheatham <Benjamin.Cheatham@amd.com>
>Subject: [EXT] [RESEND][PATCH] EINJ, CXL: Fix CXL device SBDF calculation
>
>CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you
>recognize the sender and were expecting this message.
>
>
>The SBDF of the target CXL 2.0 compliant root port is required to inject a=
 CXL
>protocol error as per ACPI 6.5. The SBDF given has to be in the
>following format:
>
>31     24 23    16 15    11 10      8  7        0
>+-------------------------------------------------+
>| segment |   bus  | device | function | reserved |
>+-------------------------------------------------+
>
>The SBDF calculated in cxl_dport_get_sbdf() doesn't account for
>the reserved bits currently, causing the wrong SBDF to be used.
>Fix said calculation to properly shift the SBDF.
>
>Without this fix, error injection into CXL 2.0 root ports through the
>CXL debugfs interface (<debugfs>/cxl) is broken. Injection
>through the legacy interface (<debugfs>/apei/einj/) will still work
>because the SBDF is manually provided by the user.
>
>Fixes: 12fb28ea6b1cf ("EINJ: Add CXL error type support")
>Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Tried this patch, working fine.

Tested-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Reviewed-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

>---
>
>Resent to add linux-cxl list and Srinivasulu to CC
>
>---
> drivers/acpi/apei/einj-cxl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
>index 8b8be0c90709..d64e2713aae4 100644
>--- a/drivers/acpi/apei/einj-cxl.c
>+++ b/drivers/acpi/apei/einj-cxl.c
>@@ -63,7 +63,7 @@ static int cxl_dport_get_sbdf(struct pci_dev *dport_dev,=
 u64
>*sbdf)
>                seg =3D bridge->domain_nr;
>
>        bus =3D pbus->number;
>-       *sbdf =3D (seg << 24) | (bus << 16) | dport_dev->devfn;
>+       *sbdf =3D (seg << 24) | (bus << 16) | (dport_dev->devfn << 8);
>
>        return 0;
> }
>--
>2.34.1
>


