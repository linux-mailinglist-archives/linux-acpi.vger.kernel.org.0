Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A33B23470E
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgGaNhZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 09:37:25 -0400
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:4769
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732960AbgGaNhX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 09:37:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdc3w9HGqlF6cHS6To6Bjs7Ea7H/SwCwBE0qXFXlwelP4ozvCP1VgZXF91YRKrMS7qPjXu+NdvOw2KA8N1po0p7WE3OtMt8JTryODjivCUCONqn0qTqlTRY16R17cxt7kxf6HHXOnEqSclts+ob33eHJ+gjEuLloQPRjU2EgDkbAjTZuW9M1HNngPyGBpmTWkoRdArjxO3+DsrMJAob6ZEoPnZotXoTf5/xwgjmEUsNQ3f3SSfOAboTdQnSSSX4FKDJ90fdmITISu5+RGEPLgmeQetRisren874LyCE5uV2Bhxo8kNw4ZR0sIqBCq5oY1TBzE+bTPAy6KuEb4K2Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn85Wiauar3poXs7cSoMvgrcXdVDOE/b8d9C0hrUyfI=;
 b=DcwczakMT42QVDsGmnmN5rqIY7BOutwd+Gw5E6Hf7TjvZpXPBizTbVO/7tNHtX3SnWVCdktoDZUB51GyNH/SClIm99zABr/bkdST0iPxtA5xSPblZSX91eB6jzI9WShv/gTuc909p17J/zgWJ4dhJ5CuOmynK3PtLLx4f54uWZ630JQzE6gsPxS3LeEcmm5aMo7kTkBD2eRvDWpNmJgz3fEI3owWWoA6JhFRbXyDAl0aF+uzLf4E7b53151mOhkg+WWALpb/GPU+jRucm3x2rYk9/pDcqiWhL/nEjlOcxEofvFNSerSEoufLBr0PA+4q6yePd2y+P3XEQr8/hcmxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn85Wiauar3poXs7cSoMvgrcXdVDOE/b8d9C0hrUyfI=;
 b=yYLCQF+9fgvMSgAPCb5oeuMe0eyFro8YHnNBVjbLb/O8jOW73VrBeX/0HHf/FiZIj/y05c/oowcMjR6ly9Ii+8YpkwCyHZn1gly24YGMZMqCadXJYw3kJ9FCRXsUghKb9LnMLgeLhTPGDFdlwYem9q9WBEdSYieC5XDLqbwyp8o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 13:37:20 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 13:37:20 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org, rjw@rjwysocki.net,
        lenb@kernel.org, mturquette@baylibre.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rahul.tanwar@linux.intel.com
Subject: [v3 4/4] clk: x86: Support RV architecture
Date:   Fri, 31 Jul 2020 19:06:04 +0530
Message-Id: <20200731133604.12512-5-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200731133604.12512-1-akshu.agrawal@amd.com>
References: <20200731133604.12512-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.179.42.211) by MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 13:37:17 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.179.42.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 916615d1-edf8-45bf-167b-08d83556d94c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3257A9F27E2D8C0D7C14F6B7F84E0@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djyR0lS1cQmiagkTJs16QVFchfrhNyRVOiTg3SFiNm8PUuYYRQyzsWjsSIFvTm+rcRqoQWvV0mFn7Gu7Jnj86E42LghImcmXwn3DXmpdaQQs71j+5FOGSftVD7eTX+BQrMqJYi4hU6QkkOS1ievMtD3XCZE5O012OrVz39XiV1EwCw3iiIEB3nzPXlUildpOOSp+dYMTDr8vh3Su9ZW+bJ57UH6eow9YhG8Ds+5cCKDx3/FHNw4nIBTdYzi61EJXi7eP3isalL2GXWyTjM492kPvPOdJ/nuZnQuHs/cg0fP8sQy5QjOiiix+icKGG4iEOMKWUckgXgduUN/5RqDWKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(66476007)(66556008)(66946007)(4326008)(44832011)(52116002)(36756003)(6506007)(34206002)(2616005)(316002)(956004)(186003)(26005)(16526019)(37006003)(1076003)(6486002)(478600001)(6666004)(2906002)(8676002)(83380400001)(5660300002)(8936002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oSlsZYx0SwrmXSAwT5SBwxGOS6BjSN+0psxKFS91+27C4ZjvY4qrv6ZMuepl2e4OVCU38pTQgKEPogYjDqzOLAj7mLtgRxjHeFnxA0AWF41PZDX69XOeqgqio8B4u1tdIkwP9z4b56KMtkopVVQSOKMyXvW/+wVQuq3z2RtMAc4hGVFPa6Ob135Ai30w/Tv+q/Gdi1CfrkWU7RJEYDaNlROLmjzFC7WZU9zGYSmpigIXsBY2tlt8AEe5IUYuyCbqt/yQI34iGSG/U6+/Tg7y+qiCtlLzdbMnJYZuCqd8G2MX34r/GjpoHywSnrH3qsOsZMovSFpsmPspW1DDUnpK3AchPm/i9TeG2Y3LVvpdAcjHAUWQz1g3Xi4hCyPGTeV8at7acCu0TX4drKnOO3FcA6Nf6ahUkrlzQiXDqavWn7OSJa4Ig6eTFYb3BIEBQsafX5ha3Jq4f19BlUsknv7sq0aAW2Kpo1VPlYf7wDAVJh/gu5Ra31QWPs60fFGx47EIzglEGzS1Xve7yIIdHKzSLftfviUuOniiaVw231+A6RTmU54GqVQfeplKmz7FbQ45sJA/n7EBdyPX3IaqgyFjMETKXz6DPnCtn/4+AUwvfR9KjTOOG5hdHYMtCbDwp38PbgHPcj4LrPchoiYnSNwSyg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916615d1-edf8-45bf-167b-08d83556d94c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 13:37:20.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZ549pTZWoESQ4i0G8/Ionq36cQNS3zIJ+o5+Myl8SnGETQF6uZYAs1+JI2EUt9500Rn624YV/2I3dY6Y44Llw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is minor difference between previous family of SoC and
the current one. Which is the there is only 48Mh fixed clk.
There is no mux and no option to select another freq as there in previous.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
v2: Consolidated the loops in remove.
v3: Removed negation in condition to make it simple

 drivers/clk/x86/clk-fch.c | 53 ++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index b252f0cf0628..8f7c5142b0f0 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -26,6 +26,10 @@
 #define ST_CLK_GATE	3
 #define ST_MAX_CLKS	4
 
+#define RV_CLK_48M	0
+#define RV_CLK_GATE	1
+#define RV_MAX_CLKS	2
+
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
 
@@ -37,33 +41,52 @@ static int fch_clk_probe(struct platform_device *pdev)
 	if (!fch_data || !fch_data->base)
 		return -EINVAL;
 
-	hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
-						     48000000);
-	hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
-						     25000000);
+	if (!fch_data->is_rv) {
+		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
+			NULL, 0, 48000000);
+		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
+			NULL, 0, 25000000);
+
+		hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
+			clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
+			0, fch_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0,
+			NULL);
 
-	hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
-		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
-		0, fch_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
+		clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
 
-	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
+		hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
+			"oscout1_mux", 0, fch_data->base + MISCCLKCNTL1,
+			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
-	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
-		0, fch_data->base + MISCCLKCNTL1, OSCCLKENB,
-		CLK_GATE_SET_TO_DISABLE, NULL);
+		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
+			"oscout1", NULL);
+	} else {
+		hws[RV_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
+			NULL, 0, 48000000);
 
-	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
-				    NULL);
+		hws[RV_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
+			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
+			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
+
+		devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
+			"oscout1", NULL);
+	}
 
 	return 0;
 }
 
 static int fch_clk_remove(struct platform_device *pdev)
 {
-	int i;
+	int i, clks;
+	struct fch_clk_data *fch_data;
 
-	for (i = 0; i < ST_MAX_CLKS; i++)
+	fch_data = dev_get_platdata(&pdev->dev);
+
+	clks = fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;
+
+	for (i = 0; i < clks; i++)
 		clk_hw_unregister(hws[i]);
+
 	return 0;
 }
 
-- 
2.20.1

