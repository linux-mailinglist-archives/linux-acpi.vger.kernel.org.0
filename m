Return-Path: <linux-acpi+bounces-15545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D52B1C600
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 14:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB13A4E314C
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 12:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA24A28B7EB;
	Wed,  6 Aug 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aquSsBJN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013026.outbound.protection.outlook.com [40.107.44.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F4276049;
	Wed,  6 Aug 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483926; cv=fail; b=r/qsdo0jarrSsSJLFdArh3z1wWbKqC5cRMINdj7osjemekQh08zicY6F4uDIbrPOg3pcERPkV+1NdmaRyK0BM42psFqNTncdNbrEIlpD+lmQc72rn5NlUjsf4GFv/dfUQMU9fFZ+/nwhTcYIJrM0ymIG5hwkvHJhx+QCC/vM6hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483926; c=relaxed/simple;
	bh=sd9PcexKU3C2FebksceI+HkQXhev7x981RUCWEDR3HY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z8aDtgKoiWogqlCsSF1UhzZR2pxevEjmWTg2Tpiu6LxFGEz8o2Qq6P3R+RoZbIsPRRH9aIe2u04oMvtpmNmHc0dHw93jsWp9iE52i/NeyGxbzqQUYCNtKlFCY3t2TiweY781S5Gf31svLlU1jWX0XVXrzmxSYyyrS1ReexWONVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aquSsBJN; arc=fail smtp.client-ip=40.107.44.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJWFVAvj+NmezKOlw3+ew6/BPV1HlKEJu23aO7tgx7wb4MqLqmYh5tEkXQJpZ2G4XofFE+uBciTdhtQ15s7szFe1zBDuEtBiqoaWBnEhZwldVcuD+nr6GR719rpfiuZjCSwNBCXxs1y/IrYotzFrhczywim/qSw840Ktobs0nW3/r0BXyHmNkNV5Nww4eH2ArWz96d2ZsMGOWkQIrG50kAZ7g3PMYKjySDzgJ9bFhM/DjMnecajnn1jCAPI/rd9xQJezcv5sc2p93fCNXZDl22F20AmNV5qeAWNYJFxuOZYjVpcHRZlBTAcSCxyrA+tQlabJSm5HDwHV6RgTmSJHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2AmL6FbxrocuLmsd1i/Oie+AD5XXUr1UyNhnl7grWo=;
 b=wsAMtq6r2WnFDn0M0yb+WFJS8WcpzYc/xCFXT2h9tRxz2YIBUDy6luQJb4xw7m43vKO+gg3lm61g/X4mYT8FnMu7Yzamb2uHMnMVyc3GO5aiiqkvqqSt8l1Svi/7D9zQ0/Ux3vLYxFWh5r7NC4PDNLrJscDS7HROZyTDt7M1t2+dufdKgoXFo0CmsxHoHLy7uK+PmNzzCrIeKHDDKtphiiy6i5mmAXG9yKq7Mhwgy13cO/bVbvf0XAGpl9x62R1O03CXexKuGyLSlE45lnO88BZKFzt+kPiYUOUgVycFJa5BPXpeSLqVDwD/TbKr488ycT5R4FEUBzQw6lKffw4BJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2AmL6FbxrocuLmsd1i/Oie+AD5XXUr1UyNhnl7grWo=;
 b=aquSsBJNCigkPCWpJI9qjlwH7FJpUuuxl6A/ma5FdAymX11hwtD0YxLWV/bAM3BvLwZJXptQ/Dneq+PAJWRZSbxp6FKoPKg2i7IMg2BeX/yOctz5QxMwx7M//7LEFNNWfDsv1cDolDLg43sKU7Nd9h6RIs65Le0mS8Ha7k5kcf5VOmp/WnewTUm6m2oF4DBzfaP2SrTYGrb4gVdvdCS786jBDtbMFbqAUTrLbFZf4MPZ9hEebqWhaD//bjm3tlE6l3FcwDcFdSngJdGz7cxWmQE4VAwhkfVNL4gZ9u8tbX9r4Pis8bl5lchjmRGgKjI942/Fj2E+XJhmI47Jfv9HlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com (2603:1096:400:32f::14)
 by KL1PR06MB6111.apcprd06.prod.outlook.com (2603:1096:820:d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 12:38:42 +0000
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263]) by TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 12:38:41 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA)),
	acpica-devel@lists.linux.dev (open list:ACPI COMPONENT ARCHITECTURE (ACPICA)),
	linux-kernel@vger.kernel.org (open list)
Cc: liaoyuanhong@vivo.com
Subject: [PATCH] acpi: Use swap() to simplify code
Date: Wed,  6 Aug 2025 20:38:20 +0800
Message-Id: <20250806123821.381002-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To TY0PR06MB5579.apcprd06.prod.outlook.com
 (2603:1096:400:32f::14)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5579:EE_|KL1PR06MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 40162892-c295-42fc-b8aa-08ddd4e62c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fInlk/W0nqK1Pw7Vku/5uNnBc2dklpxgtiBRxFXEopuCylWG6zuKM3CJVs2J?=
 =?us-ascii?Q?WFU4u61Tf3NF0T4zN2+GjwFhkPxAVChRNzJ26Ka60/Ekl58B0X80MfmoERfw?=
 =?us-ascii?Q?T/kDPwl6Y+Cu6v7m/Wt+fDiNCQKMgUK0M4r4yqO+x85xj2AW7gt8EQI1waC4?=
 =?us-ascii?Q?qgWJMshIGZ/+iCx+Xx6GTnBYCXUWr61/B4iofB7H7UBjojwa8EMN6sCWICsE?=
 =?us-ascii?Q?ux1sriA71Kzd1/rQv4d3PU3tQJiC951ylOhjLDk4HjcDakQ1Rh+7Q1vdYHPt?=
 =?us-ascii?Q?Um24ZdsuIPXrkkYCR6fvsipcRX8LdiBhcnO0Cy+Srl8uoZ+7uIqwJ9aaF+tl?=
 =?us-ascii?Q?JExBeu4pzlev/V0ys0ZvQlGpnYa0ksr3BxKxUUsLgDpMI4lRON5dG1NhsiU/?=
 =?us-ascii?Q?Gu1sHnlzx9mbVqB0ah6Q+S13S9TCs9Y4bgOKCHUZ64+W1t/0tZHBhhLA5HDd?=
 =?us-ascii?Q?lXGHNFqM696whoiW576F7FhfE1gaBxh9wx38K29NCU38uNBO+8js7/op/l6W?=
 =?us-ascii?Q?b5pYIHhuC4xSSZBI1jbwNAk1fz2suLNjjHs82CVEtU04L8fVINnAaR/7lG7z?=
 =?us-ascii?Q?cKkE8NWZ9oGQWFDWjLI/X8T0eWbH0K1ImCezfmSzqwtGt7vA9lphNrONqSLb?=
 =?us-ascii?Q?/kxunxCCxAH6lRVXvtVGDcqBSmDn5mjny98WVpAYl7DgRt8P5Hcv1IeDd6P0?=
 =?us-ascii?Q?Aw1sh48iwkYWKZB7ypFD6vMs3uR4G6xBIO/tcA/QUU7Xvh9M5sStwoblVjT4?=
 =?us-ascii?Q?aAg94b6IzGgIXZO0OybVslbSYzs1l4kI7634EKLEFOFjfGfHkYHWyqa6EN5e?=
 =?us-ascii?Q?dCltJqcotFvOioF+73PRxw4+ukuXBu+0HwCtcUIx8UN5R99+uxromiihEDOU?=
 =?us-ascii?Q?aLw28MTzB0R7oyE2Fp80GB1hZv3taIsEPWbNU2jQR4BZFkOckmUvzb1TeQEZ?=
 =?us-ascii?Q?tZkTG01lfpqnrxSLaJX5xK3DMZpECNSa+c7NPZII4WcYd7+dh875lVG52JJ3?=
 =?us-ascii?Q?foeaeK8QDCUT6o6Au9Bk4KX6j5beONBp/pWObZTH5Na6c44oKuInYzHElGRG?=
 =?us-ascii?Q?PprcUuYPDwoiIvzqy8ch6TFChhpPWMAGzCREiUJFC+wRbz5eUahvjdkb3GUd?=
 =?us-ascii?Q?3Bqvw/6QBrQ/dmqQoT8r0gvBu1u3ypqimewnELdQTrKEgnYA45S7E9Tw59Z7?=
 =?us-ascii?Q?29LSnXdb3iRrslRDe8mDAwmx5MpYzvXbqd1IVNgz1yRGVxJi2lVf7uMUb8sm?=
 =?us-ascii?Q?f3MfBbuUio+6nEIyI+/6zMVgLcnCjC8NvDcDSIdHfYiMEh7b8iXs9TJdl2xL?=
 =?us-ascii?Q?P79kpPjaa3S7wnBGFFPAmMQNPc/l7APPCFtAzNbS0Y9xBF+OdHw+gwkken52?=
 =?us-ascii?Q?VboZK3ubM+08K1gukzQS6vPmGiOfR/vgCB5b1ErWqaNJ8b5+2FubP3L7ieCL?=
 =?us-ascii?Q?mwKAuFyi44Tqf97zwfZlcFRQi9fCSwzNyBFSAlSjkjjZ891Y+G1J7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5579.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7+JDOl96XIax+6lGLOGH8YV3sRZF4tUY1K3SF3yKvbqw0hmR/7uFUzpZD7S?=
 =?us-ascii?Q?si2t0FssjJbJncqhpXcYNov5bdsn2mLqVv5Obzdl8IQeHrXcfn6rF0hOo1kb?=
 =?us-ascii?Q?3Yb7NIsB1YI4El/M1vkECszkKo+EdPZ75B//s3RSdpvJsvn0NfNokUMsm1+B?=
 =?us-ascii?Q?U3S0QNgPL8NBD17OdmKKIhIpwJOlGY92osmQuOPJHdYWaFvVbpA2wckfaQKa?=
 =?us-ascii?Q?xDmhtPCHUt5Mjfdq6yh87MCRGQk4V9iX8kqIxGIA51kE2WmaDx/2xvlgmY+K?=
 =?us-ascii?Q?dmJnH+AgUkQIES3mL3VTeWXUXclzwlDoSPkyaoaxFqsuO4EWFktYJLJgeeT7?=
 =?us-ascii?Q?YN/iMwXbrrk9vN3+rb6Jya4H6cKJ5h5RHQ1jaUXTOih0wXqSvNOr9Fib7owZ?=
 =?us-ascii?Q?KxEI/24yXiDcqf7wCWdX/moY5fkSwAUMUWYQ8/u56AHXQmlvYAWo8E6oNTIj?=
 =?us-ascii?Q?n2HVbo0GiMVp0wiaV3dSywthOBUYqi4oYGpDZ8+eQB2XDwfRguuUt4E6q+RM?=
 =?us-ascii?Q?yOYnjv0U6wefpFO6BkPqtuI5urIhrX29YFBTBYtXyQLLDmdaqvJcGHSDQqzu?=
 =?us-ascii?Q?LPBXc5NVxTWlAto13g4sf7WI1BUgC0G6S0m+4vHLW0nXJhRPB0/4wHMsEhuF?=
 =?us-ascii?Q?oeF2XMgNPi+lwTssoptJwTMl/b2s1P6XA8KDUzgwoIW1W9wOB5OK8iYFufDK?=
 =?us-ascii?Q?PSOHLVDYEivgSqZOq6tBc5ZWztT7ozsZ5YTSYOJR9GlAhChvMRULx0ui4ijB?=
 =?us-ascii?Q?57tUijztsW0yzX+T/UthHEEh4afh3qs9UY/uUlcNR2kXaGTQN+rCjvSPOl9A?=
 =?us-ascii?Q?Q1W9F3MyOvXtl1bKmI9fZWNGL1r6PXXEnvx56M4+X+sS1UmRMeQKJ3HXzhN/?=
 =?us-ascii?Q?Ju+PuKLFqD/HHV/E/v4csjgnXxN2rRCFRi0d8vhwnH7HcwmJV+eh8WL73NTd?=
 =?us-ascii?Q?vo5eFU87orxOKoIq01HPMDYgKCWwJrwg1Ye1bzW09lbAGzB2b0e43k5R4Dbj?=
 =?us-ascii?Q?q5cncCNelZA7Wj7YeAtGYpKvz7P7621bONvkZL6e1LYSXOMiFLqw7+yE4QiK?=
 =?us-ascii?Q?OTNnVzr2onV40uVbJmR6v7cLfPFLNdWPa8IGSCMuJIZBG2kLE9Gmis47gyHb?=
 =?us-ascii?Q?GpJ8VulpVVABhvG0WsiFKbc3nqhCG3V2QPTWlQt944y1fIVi2Z+B3wuKbfCL?=
 =?us-ascii?Q?+La8/JkCYZSW+KbDEXclULyf1uxR6EJLIvTt2BzYhcL6MX+2/LMizdjBkuIz?=
 =?us-ascii?Q?S7aKY+z7wMV7F/ixdibXt8Lq9bTlTQ05rWFVqNugrcGhRtM+rwJ1mxhdj7vO?=
 =?us-ascii?Q?JVJF1Rc6AGdn2kv4aTXTb+gA214kZ8yzeoSzYO9nY+/rHrYsJb/b2i+f+j24?=
 =?us-ascii?Q?mLMpVnE1MdzLBFO8SP+aNQeV0QfN5j6qbWq35Xa+Daiqh2gfMQC1Pq6/EGwB?=
 =?us-ascii?Q?/np/1apghVo+uykI+QAV+Oagx9/CDtVRxZaRVB0UkMYUg+9+ZgGH7/DPUmM7?=
 =?us-ascii?Q?JFlz4h6O+19xITUQMlnpEpsChXlVEY/B3FcfdKD0714OhVCjoh2A33QyM/n3?=
 =?us-ascii?Q?X0E1104wnEhSqMigDSMCQEO+q2w4qKnVlXSc/rFt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40162892-c295-42fc-b8aa-08ddd4e62c9b
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5579.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:38:41.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuS+8BD2/fVQwlvIZprsmCr+nHccU1xwA1l+SUL2LVmg7cDJVxzj2jdN/2fAeEVd/9Mc2n52VRwXRZ3JFvv1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6111

Replace the original swapping logic with swap() to improve readability and
remove temporary variables

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/acpi/acpica/nsrepair2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 8dbb870f40d2..e3df5968165b 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 {
 	union acpi_operand_object *obj_desc1;
 	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
 	u32 i;
 	u32 j;
 
@@ -891,11 +890,8 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 			      obj_desc2->integer.value))
 			    || ((sort_direction == ACPI_SORT_DESCENDING)
 				&& (obj_desc1->integer.value <
-				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
-			}
+				    obj_desc2->integer.value)))
+				swap(elements[j], elements[j - 1]);
 		}
 	}
 }
-- 
2.34.1


