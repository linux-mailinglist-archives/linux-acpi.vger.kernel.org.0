Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25491D59F2
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgEOTZM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 15:25:12 -0400
Received: from mail-co1nam11on2127.outbound.protection.outlook.com ([40.107.220.127]:17505
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbgEOTZL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 May 2020 15:25:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVp7q8ciQiq5qYjk6frTtXyTljlvSvj49cfdg4MZmVYxmLEreHvbf4iDUKL959F6FCEor7x0ZWEu1yXJIW8yNVyGKEEZvOGj54akCq6CD0kNXCTtczUslW1IYb+Dk/gHYVXCdly6/mV5wx37rdtlO552z6DPDXyTjuJN5TPb4cPmCWnyaHPgA2dGcBmOw7cGcsTWcvSod/7nokJrirzgKH4xAJBmKQlcw9AIYb/R38GNCsH22dvEJ71zwOhl7jNHd/uMMLapGryJ4+nzTxjZyFLekiG1wwbStLGNgyoKJYA/ezQRsw9BFec0od8OGqhI87aWnwhw3/EpoIbrMwmEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OgmjdGF6wPU3xIv5703pTeMeMlxOsvo5ko1SpqQv4w=;
 b=hCL3xVPGzWEZZ00xSDo/dU4NmicbLtIzIthT3l+BwrgxZoPZC8JoHrcqDXBHHTq7qkV6MOkuZLdxoVc2uFvkhcU2zVFyPlieWONjGB+2q8V5EWbXcupHwD9RZ/phdGGwdozIxzgJePnNjh79Zvba3PYkidd5qxs0wsL4euJJ0G4C11cfBgnJli/H7+yq+y+MrJUCBZpEEZnrhyV+Nrj4qxw+0gfK6voRaKYTi1ZzvxNYXe27u1tTUws1mUurmYYTy7d5fdoewZz1mVlh9fhDvpxeCPtICxt264Zz01XbTacpdKNZIBbIQg2bBMu9eigc7EFvoqTmovNo03GUtzJJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OgmjdGF6wPU3xIv5703pTeMeMlxOsvo5ko1SpqQv4w=;
 b=ICAlGijx9SzyihYJRmx+nznplHVJhmwkTJhQwC9zXPbHOXmQv/6ieRtzfdKKgCxLvoJfRLtTJf2SJwR2Ada8oWd7jHqSk2Fp0b6Nf3iozkNbS43VpR3auInUP6rcMJLZxq1Ef/GlXUWv1WyJMgzrgbkT3Jvbcn3K3n50S8fQCtI=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4133.prod.exchangelabs.com (2603:10b6:a03:5f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.35; Fri, 15 May 2020 19:25:09 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 19:25:09 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Neil Leeder <nleeder@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] ACPI/IORT: Fix PMCG node single ID mapping handling.
Date:   Fri, 15 May 2020 12:24:46 -0700
Message-Id: <1589570686-5780-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 19:25:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25de0aaf-faf7-4ea2-feb1-08d7f905ae31
X-MS-TrafficTypeDiagnostic: BYAPR01MB4133:|BYAPR01MB4133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB41330246EE05BF334790C37CE0BD0@BYAPR01MB4133.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ve5j2odSFQStkdnDD427HAJfe7xXrOzhh+eX5o+rZj/qVtPOwbUd2hgYDXUp4BfQm1FSK52FEdM7iQmrTTClorKOjno+07TeuquZDuMpvzmerVAvyMeK2rFRO6KMrulrnBCMorG1zvfQGLzkWiAq7iSlEyQwdtb/Gwl697EhmW6owvq94867AJQJn0im5JXiVv+DKXfl4w+em2SAI6LWu8NkDBvMh9gXfqESWHZKoh9tNpkMllhJrsWmSszTGFtlUXfuKPYc5piOZr/VIh1y445pT+LeMzBxOh5f0y9qC+niE1dgKg+ZFoYvp+nMF9LMolnsuAwXcRIenh1Seerr0nsLCPieuVSrsF3rg8MfcDjxvJruELDbd7y/bYbLCEVngqSmiXLandO6q4ZeeXTW6esi78VojM91SfUXkRdlktAS7LqTH0LA6GbV5OjDgbeAOfCdGH2xOsfw3Cheztf5dAAJl3W49cSZxIRFS2plr2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(39840400004)(396003)(66476007)(66556008)(6506007)(66946007)(2616005)(956004)(6512007)(8676002)(8936002)(54906003)(86362001)(2906002)(52116002)(478600001)(6486002)(186003)(316002)(5660300002)(4326008)(6666004)(26005)(7416002)(109986005)(16526019)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: SZT5G/jjNtWL1vTY/TvZq4i18sOSTAxAXV8zBbzoTwUYGud8+DHQuK7vjPqK2CjDkoPU+xR67qzdV0woqyn9tiDJJBBJM/UndkpTJ52sTBxQhLw2BRi8q0suBAX9bWBARTP9oYLWOW/1pkVzzg12KO9Xy3tb5aM41Jda38h3FCBl4VCCMk4nH81IH0LeHwVFGIf5HrUI4tnD2xBGjXKzEbQLjVytHetBt8hthkIJMXgtQqkpL2GgqON7kTFMhr02CMauC3FTwbpRziADHxTopE1CyOXZ5bonyQa2fzRoWt/EGAP+38vYu8D6YQQhpCRROD7qAOwFsDk4Ygg7Ccmai4wA/KSyOGY4JP5wmAYjN2DeZojQXXAGgHOhX80laAoCgA8FxIlyoVYJTPOyVQui1iHg+9nocsBbYme1DwNtEUMnsJuEGW49wAGy45LViuwcvgh26BTA3Ys02sJRKJ0+Yoghp70C85PPgL4VuDgDXaM=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25de0aaf-faf7-4ea2-feb1-08d7f905ae31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 19:25:09.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6n0mAt0v9FUeiMPKM4KayAElpsXtHckuSB17w3IXkyeT/A3Su7SWOqFs8LBoKJj/Z0+frPTT33NO5Gp32IJxfYmFNDWgR3heWVCFY0Lz6AjRoLJeunkcFEKuWZ+r1Aew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4133
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

An IORT PMCG node can have no ID mapping if its overflow interrupt is
wire based therefore the code that parses the PMCG node can not assume
the node will always have a single mapping present at index 0.

Fix iort_get_id_mapping_index() by checking for an overflow interrupt
and mapping count.

Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG").

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Hanjun Guo <guoahanjun@huawei.com>
Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
v1 -> v2:
- Use pmcg node to detect wired base overflow interrupt.

v2 -> v3:
- Address Hanjun and Robin's comments.

v3 -> v4:
- Update the title and description as mentioned by Lorenzo.

 drivers/acpi/arm64/iort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ed3d2d1..12bb70e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -414,6 +414,7 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu_v3 *smmu;
+	struct acpi_iort_pmcg *pmcg;
 
 	switch (node->type) {
 	case ACPI_IORT_NODE_SMMU_V3:
@@ -441,6 +442,10 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 
 		return smmu->id_mapping_index;
 	case ACPI_IORT_NODE_PMCG:
+		pmcg = (struct acpi_iort_pmcg *)node->node_data;
+		if (pmcg->overflow_gsiv || node->mapping_count == 0)
+			return -EINVAL;
+
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.7.4

