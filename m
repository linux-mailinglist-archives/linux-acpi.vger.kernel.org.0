Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF0A1D0341
	for <lists+linux-acpi@lfdr.de>; Wed, 13 May 2020 01:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgELX4O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 19:56:14 -0400
Received: from mail-bn8nam12on2112.outbound.protection.outlook.com ([40.107.237.112]:54752
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbgELX4O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 19:56:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI374Tu4EBjxJWx0t71a/nyVlu2RMbhoCuZikt38c5MF90xXZ+hk+gN2qWY8I6zmAdjVZFAiZEiuRprNgVg0D4IxUgpCS4CAFqcO21ha3yXweriiThJRlkThA2m8pzn9HQ6glqkSYKl6A9zUFNflf9AxNLSvQ4MFqO5HR7w6mV8tOvJHahLGYQsvUsxWpOLLLWXf4MGWudLN/EReK5DT6IRYMDEwDUSSrr0QjvSahpXi3NWjK4Sy0WOjcOENDzL86QnJ/8CTFUQD+KKhG122nLRPkQDcePJJlt2Kj093olxXpJou+OMr1xQsg1xjcBbQTUvrlpMwP03qzFFmJ4NsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi+mvriKrHdXCtzGusI/raAWcPX1KK+A2npRlQxCM8M=;
 b=Dt67R9DoRsUir6yGFJavnkjAhTb41ld3k39f7+j+u2CNqZoHlOEAwZN4anKgBn6P0pwnaMvwHLmzLp/3WVD2pMk3gNPt1HNfPwLbKhy5NwgjgUC7BpBX84yHMk+LoWjOYLayF/hX+Q6LkdRr6VBxrtoOko5CC7lxaHako5wP8JeteofCuQQq/DClHbIXjpRVc1oAVEx7etPj7hBrmGbPndsoBmi/oLIUo8lvLWGSHnIaMdB+/eyqcLX8wHK8x4KdtvkGnkMaw+z0ORDV0adCDKZazpeQOnfj3QDwFd4dgvlTmhmZXWHXSyFW7Ie8HJMglN34prYChIYeNnhFipUGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi+mvriKrHdXCtzGusI/raAWcPX1KK+A2npRlQxCM8M=;
 b=P3miKNoWOi7shMOt1+zUz364qa5z1F5TTFfXDJRI7dfUJWfN6Tra9nfvaxskAkiU7TuC7EW0acBVhJfAyHFH/qArGsIaKxObLcE4yEiLumET14JbqlkHvsrhTujOPLmvzCY/6KMN9y7aIUYUpniouf2Tl25hU8IRyvo42l6LoTs=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4470.prod.exchangelabs.com (2603:10b6:a03:a3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Tue, 12 May 2020 23:56:09 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 23:56:09 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI/IORT: Fix PMCG node always look for a single ID mapping.
Date:   Tue, 12 May 2020 16:56:00 -0700
Message-Id: <1589327760-5464-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::49) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BYAPR11CA0108.namprd11.prod.outlook.com (2603:10b6:a03:f4::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 23:56:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9646e35-e9a3-4389-80c0-08d7f6d00aba
X-MS-TrafficTypeDiagnostic: BYAPR01MB4470:|BYAPR01MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB4470043D943312C8E874F4B5E0BE0@BYAPR01MB4470.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrkyULwcnOqwaBimedbvL37OHbB/q9N24Pw1qVyuk8lcuO55LciY+YyBlKtiFRTVs6Effp2fYaWAlEqjAzmqzsRBGCvofgrAEheRezATJCyr+XZm7e0ImD/vFDx/CYO/0yyYL0YrQPtooWuO259JqzApizo8sphSCFUG7KqutgT+topn/c8tzCrY/TiKCfmpuW8lBGCCwD/3Gmaje8UKwrGeuBBvW/wj+mPHUzq6arbE0PTh4qNGQYU8MKKPDy/LnIbN0Cp3NTaIeHmv8dGetykZ6CeSAjmvmxhyTxLIjTTvtGgNlbuB5ZgWSPGWFPlVaspYPojaFVUvpBUqo4yQFgUZg/aQy74gRHWNbF2XvsLF9GMnPR7r5U0i5meaZSeHl9kccadXvLoXaSSICrYTcFeeFlxqQmPkAaS3GjvlS5MdQ9t2Phw4Mlm3iDtLGUu/h9n4R6EUbIz3F/GCV4Ze4CWLlxQiv3tRnTUyiY2RbghJAYnVOqwjZMl10GspZvuG+or9TMLt02iaum7I9XE2ITeOWtniydTkh6sg0IJf7dw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39850400004)(366004)(376002)(396003)(346002)(33430700001)(8936002)(6506007)(86362001)(16526019)(186003)(52116002)(6666004)(26005)(8676002)(2906002)(33440700001)(66946007)(6512007)(6486002)(4326008)(54906003)(5660300002)(478600001)(316002)(109986005)(66556008)(956004)(2616005)(66476007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OgpZQbnge20v7hxFuHhE4VSY8ZJWjqC+uDuHREnzYPBWElLjjtIQKR3Plb5T7wdzpgAIX+vMgsxpuvCpoJ2bvGIWFGtNYha3YILfSuZmkMa4Tkic5DutImvWZdZq9+R4W5yhZ4AQzJ/T+FT54XmsNjzmFJeFMxSVqe930iTjgvpzlTx6YsvPZBOZHAud7k/zzs203e6yMQalVDPVVOmvEMYRYvaMEuPHf3oTBPd7qEVxSA7GeiZIrmdBX7DXfD+q4mJt/n/CbujoEryCN4nsaVhJq1w/advs0jVXoTH4BFno5o2LJtJdmKPtPsrlUpole9uRT2nZ6wcVzI9uIyIarwKeTXj2ZejmdKTrrSpdjmChm4fLyGX8NDcvL+eMZ+GSEP8Mk8LnfrO60Qyx3IagE+1G2RFPGZfAZbI6FG7NkdDIIWOcPZ1JjKzYMaV8pri4gFCtdqjL2rHCjwaJ8ExCkts/NP/EpshYFZBLFU+ohws=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9646e35-e9a3-4389-80c0-08d7f6d00aba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 23:56:09.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCZseUeoiUG1JMdsxqjzTA1PCHZwETxmCqg6q0fgGeQocgh46dRZPwgxp2wvAyt4Rw/Zfaoq6LFVGRndDoKSk4TzGdt9GWMCHDBpoZBk660OTCdYdQD3hAxZGr2hmyK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4470
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PMCG node can have zero ID mapping if its overflow interrupt
is wire based. The code to parse PMCG node can not assume it will
have a single ID mapping.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
Changes in v2:
- Used pmcg node to detect wired base overflow interrupt.
 
 drivers/acpi/arm64/iort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ed3d2d1..11a4e8e 100644
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
+		if (pmcg->overflow_gsiv)
+			return -EINVAL;
+
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.7.4

