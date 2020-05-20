Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBCA1DBADD
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 19:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgETRN0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 13:13:26 -0400
Received: from mail-mw2nam10on2131.outbound.protection.outlook.com ([40.107.94.131]:52672
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbgETRNV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 13:13:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdRjfK0SuYZQn1T/0d38O3urrLDl8q33jrJq0v1A36d2XaoKc1eQEVZEYH0wpXTWZlhc29ciPp34hrP23tSEdrgeV8XD4FjFI/xuvQipg1EjXai/552nuTQuPpQOH51o+Hw768e8VnR2PK3TLDJNXtU8jQFWL+UHpCjVmWpUVT/LjC3CTrUIl9QUxbrVTu4LeEay56oGl/vXt51B3oHsTE+y2AUMOIzpWnn1D/FjM6NhrGaUNZkyAxWxinebSGHOF4jxoIZW4DLIDlQ52VmApO6+RBmwaFZ0I9EKadw7W7KdraOoudg7CKAybQBbLeBZjpZg0pDuj5qSE9MgkKiToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WENrl9nfjP9FJdafxG3aKM2i7jya30XQF8Yj/HGtyWk=;
 b=PgypsH6FKmevzGaGsK87F/SC4LRF+AniecGwwAQjZU9vru4lIb9SvcBtNKwgXBKABxl+TS3tzHYS17crLQOEjT0u8lU8IahZRACP/UFiJw74F9MHxT4SENuE2mA1mozeAcOpnvsOUHj6zbY3titgDXtWfttmlduyvATW6qdCDNuxb49UdkF8PFbrMx+ruZO+jmHmqW2u+wjv3qRWYG9U0R1xIqfGeVq5VS+RZD7NhWQmn13xOclTMLIgL7UZRKXVQx4ey1G8WmT3x9uLQPjlTKJBgFDAFsWeiKVRYdz71xuIb9k0B87x8dqP1i3CS+L9M/fAOARz+QKoNrkq2Ym2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WENrl9nfjP9FJdafxG3aKM2i7jya30XQF8Yj/HGtyWk=;
 b=I4eSfLbl8s//QLDLZWumiNb84hwghk4mvgdWkyUaTPrLFr/JgwmJYU7y3MlXMOORWigbl9JQCLMk8JgOJ1+BRoW+bX6J3RFsmifUSGzxgAlwKEeOjO1GKSHpLhfRehgD/Xle9ul30qlhjdgvGwE1/TRTMlgD6BB7bYwfLBqWYYk=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB5333.prod.exchangelabs.com (2603:10b6:a03:127::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Wed, 20 May 2020 17:13:15 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 17:13:15 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] ACPI/IORT: Fix PMCG node single ID mapping handling
Date:   Wed, 20 May 2020 10:13:07 -0700
Message-Id: <1589994787-28637-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:254::13) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BY3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:254::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.8 via Frontend Transport; Wed, 20 May 2020 17:13:15 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b8a3b5-99d9-46da-7b96-08d7fce1156a
X-MS-TrafficTypeDiagnostic: BYAPR01MB5333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB5333A5ADD9B14CDA31B803E8E0B60@BYAPR01MB5333.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/KqEewnTk2P8hKH4FZRdKQokBQbYC2EDWUMBaU73wntm1ELJ6epWdHWQsrcFm+q69HPfImiuIK0rins/xeOEr2j6xUTP2YvEPR60FG8tC+LAOTlV4gInTOEUlWd/FlGlpwAl4E5hJsUIqhFoOnmcvOjuFxTQojKc1VqCKq7Bbaw7smou1YvSYyfQB9FCgkslQYCYW5jVkcW9obNtbGU5sKf0zkLSX/bk9sBkaNygcdxu97WqlmDfoizlaIPiYm0CZFsRxvu/4qpHvwqpIH6nLanCX2x7CEuuHW6kfECILBvkAn5wF+UVeTPWL71rX6l3T3DrmG4l/2810R8xdF9OlCqG02I8EITEN7geJuOyFLd9qpVmaEzXCpVgtHSCxII
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39840400004)(136003)(396003)(376002)(366004)(346002)(66556008)(66476007)(66946007)(5660300002)(52116002)(86362001)(109986005)(4326008)(478600001)(2616005)(956004)(2906002)(6666004)(26005)(7416002)(16526019)(6512007)(8676002)(186003)(6486002)(6506007)(54906003)(8936002)(316002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: sR89Fbdc94eFdHBahJ/6b860c6HfWhup5sNa0R7InerdYaafAW8Dpk72//504qn6VmDqAYUDFHV+yXHQFFvKErcCUH7cyznoXfuHC3nrCGrodzWNda0dRHWisswtz2zZ1zM8C/J1YvayyE3WPaMuXleiwWs/cJwV0KRRAmqjTyOVVFIJbGaxM7D0YE9OjzYkwxE8LZQM/WwMXkRIMWsGnCXLITJdRpHOE83hWVjLEjoEGcjpPRTb2m0xillOWzQcbbi2NkTJQ+DFOh9/KkZoZDV8z2xNf+QR07PELwQl4ur5dMtVJDcI9kMS/nsETWMI0qFUvRuUNPuAQk4VgDU4ASpYPNVgkt27mAQ0frefa9IJIv09tiUXSTatmRCqgrWbG9a2wc44XHUKqvAdJe6oZsxQRbCjKsjizX1XW+062Tcglb27MJoLtxEFRl1j8eo997NuUMUMrcUl+TzUFW/qK8TXTVpMH0bnacLlLVzFxsM=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b8a3b5-99d9-46da-7b96-08d7fce1156a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 17:13:15.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V78J6wMR8LocacTieVbsvR81AMi1z25U9Sps6cM4+ySKcT9j90rpcbBrjO8vUpcSXnXmc7+SGPRe9vHAXl45iTdmNC6/eynqZVuka8lIGsSy1QrRCJpY+oiSj8fCsEpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5333
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

Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")

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

v4 -> v5:
- Remove period in the title and commit references.

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

