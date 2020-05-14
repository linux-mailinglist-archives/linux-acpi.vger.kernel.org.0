Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC721D237B
	for <lists+linux-acpi@lfdr.de>; Thu, 14 May 2020 02:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbgENAMR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 May 2020 20:12:17 -0400
Received: from mail-bn7nam10on2120.outbound.protection.outlook.com ([40.107.92.120]:65056
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732871AbgENAMR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 May 2020 20:12:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcGoiDRn6oHz62lpOmjwhnFE3fAh+I/gaHXU7iVhYMJ4UuGlE+Jz56B43uJHt2GE458uO51ljAqPHvcwAD88j3bs4gXURvgLemeXMh5RWhdT6oczuZlNI7TTYXheg0M5DAkrFvwvkgNIbt+8vg/hcmCZHHDmF8uWmu/Bmw4oKBByaM0ELp/FPC72bQUuSVskY15+6LPNc4UKdOlio1VeDh9NniwwagESt6Z/flEb4oufIyfbd1xEJuSIgs/E4SCVrcmIO/wJYYHcvuCSHIuqLO3k0qUxWt5vnckZTGhR727fAelDL6gWIK08l7aC2rpCaahl5JpTDPz+pNpoD7Ey8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx2jdNqVOv0BSQ94JD5tkM39/gGO37pcIhnpr6euQtA=;
 b=X7p8jz5xpaTcpP0QE+hK8LbdZi3nW/ju2v8JEmjcWAWo9t/zJhHhqRWpSFTDyYMcCojgRUOUQUTw3kp6AkvVu/elAg7DE1eIB6sGt6rG/azc8uTeLGtnMWbJIMQG/6ifhXr/sHDPsP+2gdiQN21B97+36TRZbIUgjesKEj0Bei+k6VqEfINaLnrcSLtGH1aROHxhgOVAp9sV7WV31uKCFytdoOf+/TSdxbL0q4RPCb8PPVw0ZwoF4sYWTROjya4HDA2QA6n4Zqc6jyTGYN5g1SvCti87WjGt86N5qmVKKOWQ2P+UbWVpsS/aujJHbJCBS+iUvIDS/ihKD1S7qoi9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx2jdNqVOv0BSQ94JD5tkM39/gGO37pcIhnpr6euQtA=;
 b=vgZM8K823F5ee0xMVTOBCrye9tmhwQAxh3csVrj0WQLUmcgRv9mdgSmJJE1Av7xRmKdM1JRu9yK4Paog/GGyQ2VHEBJEbqw8OhwKftuJSCJUjAkDKIrTFKxiUJ0FS0t5QHQzZk9QpV7rqeS5ylMCkqTtS11X1f+DEyoqlPDVTFk=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4359.prod.exchangelabs.com (2603:10b6:a03:a1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.29; Thu, 14 May 2020 00:12:11 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 00:12:11 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Neil Leeder <nleeder@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ACPI/IORT: Fix PMCG node always look for a single ID mapping.
Date:   Wed, 13 May 2020 17:12:02 -0700
Message-Id: <1589415122-5899-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BYAPR06CA0005.namprd06.prod.outlook.com (2603:10b6:a03:d4::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 00:12:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 377d4864-272d-488a-d57d-08d7f79b72a8
X-MS-TrafficTypeDiagnostic: BYAPR01MB4359:|BYAPR01MB4359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB4359C072EF6B9A06EF794F2AE0BC0@BYAPR01MB4359.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1PqXy8f5ddNgqN0hQdGrRq3HtfjG4PZt2a6dceg6uIy+2Y1guonlHfNw1rVhqaHqfcEECoCnIdbFgoq2a1HUXxjS2ExnIj4RLmo8ua1Kd4VlIsuLS/RRHGU83oLGxbdgWk/gawAPrUshJSW7dWT2wYa93qz6S+v6RdIG+fz6t5GjJSDPMYKVCV0uAYQ9+HSurrnviZBDkqrNyuuQBH88NtNDjYzv/rBAGDPmW5jzm0asH8DwpUa8v7eQdkSupV1v4xSclCCJrEMzXfkTJsdl7Lf52Tl7vMY1EHOI2be/NtiI6FYpvvlSt5ntZwnGKOyQQhST5LU8SBCgcEmtGr+Z8NzOnO3oxIG6lGMAarsn51tPeK0nVweJafoQNIT6DPnyjB91vOqlcr7C3eQCLIoRZyKBdtqBREf4VHO0t3CTt4Z3qNuIhe4szeTUOKEcOiRoMWhk6GV14N42rCdwTqXY4AoiGA1MiQJcPbslZbzkLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(39850400004)(376002)(396003)(316002)(66946007)(8676002)(6512007)(16526019)(2906002)(2616005)(6666004)(186003)(956004)(6486002)(8936002)(54906003)(478600001)(52116002)(4326008)(66556008)(26005)(109986005)(7416002)(66476007)(6506007)(5660300002)(86362001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: B2IYuX9ryQaWnIy6Ir+f6APpfPT/97FysWgSykQeMW6IKe5scmvnZ5S2IHymuGRrn+ZUvGA/2MzIuSyKLd1Hy1u3bThqM67L0D/NqWPj5nb6M3qLfm71F3ePeTiKC6JzeFEx6sPvY6g5LKmaKt4ARpcnBn4MjfvxU7LAA6hQc899evzv95uui7cB98y738hS1h4GeRdPRVonfPeLQ6J2Zg6k73slA0SjcEAW/eNS95lCu0Rl0cZBPK8O3NpaZfNf5WOILLEN7180IWqLFydXEpyPOlNO0tTyvkdMdTXwYDlc68rAeydg5vOnWhDLFEMRVmMRUddw1tllH3wiaPXPAPH7cSxIpiewlKuZOmLYdqMLZI6Kg8LYDIrh+ME1h/xzn0eE+2mJi//H5oI+TqvpL7QOOaIl/ypg7wgx2orW8oZClCknPWICMtsO8RHG+xfo6+zOZmhrAu3nJun6q0yZKKKpyFBQo70LFJdu3TGTZ+E=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377d4864-272d-488a-d57d-08d7f79b72a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 00:12:11.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0ib1MDl/qd0hQKmOocKr0dhAA7D4vQDvITkPxd24HQezSDngWvcRHer5vr0QJ47xuiE1aodx/pQnGt833vSS6aoUSqjCh6vhYaJMS4e8AoAd22be9BAt5fYYzrlwHJe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4359
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PMCG node can have zero ID mapping if its overflow interrupt
is wire based. The code to parse PMCG node can not assume it will
have a single ID mapping.

Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")
Reviewed-by: Hanjun Guo <guoahanjun@huawei.com>
Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
v1 -> v2:
- Use pmcg node to detect wired base overflow interrupt.

v2 -> v3:
- Address Hanjun and Robin's comments.

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

