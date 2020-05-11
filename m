Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7501CE554
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 22:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgEKUYY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 16:24:24 -0400
Received: from mail-dm6nam12on2115.outbound.protection.outlook.com ([40.107.243.115]:27792
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728283AbgEKUYY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 May 2020 16:24:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNhmWni5PMIHhu2NkCc1Fj/KVPQ5VjsIHkQTb5K0gAlz7urm5g4eGE3JUsgR0n0wRHYGnZQolTbVrNlb7IjXVezfBQvzIHmjYCBne6az+mE2eOOfj9g+n4AsOOf5ad2tQYENQ5QQAUW+glNsnYAixhG7syqoHAnHgqxYfHAYBc0Dr6ZTP2RfJVtHVs8eLZA0EiBQDDCRFX2ww4v6nIjHuQQ6nlJB1qYo0kykgIc/I/BrZN3twSqGhG5Hwr9vd0TX7cIYslAsHKZi3Buq/DaTqjSoiDw4lxKSsLEYCK3ogDfAFqhw+XEvIf0d8ynXsKSZ2Em5cxis9Flxw4GqsYteJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq3fJ3RM6kU4R3Uq0Vu4j00iy+yvtu7EhPrqpt6JAj8=;
 b=mMt3h+5hVWaqB6U+fgJS9FO0kTTvDwm8M23/LoIP3YM0kqd3SDpC9Gpm8nS5RigUPC0SjNN8Mg9Z1fGVxrmJk9cJBy/7p0XRqTuczr+Gu/uIfrr6DCSIHesnB6jjidkD9zDZMZ/Cgyy+PYDwBeExtzARZ4FuQ8dB5dYYJF75Dvi2FN0xrhXh0ts/eGtRw9LrtRLUQpWERI3N2WgcpcanMIqr+SmilmqBNvome3BzhZqkbsXOvaaqdJquNy7qLJih3TnKHqJJcDhUtY2gw5OkPBtU1wrgXptjA2goCi0eUe311QDWzVZdg/Z/DOyaWhsgqsAPRWlZkkNL2vPD7yzGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq3fJ3RM6kU4R3Uq0Vu4j00iy+yvtu7EhPrqpt6JAj8=;
 b=cXzlBtFJfpDmmXtMxMti3TNVKaBp14FO6oQ6wguruM0E+xh5R7/9sYURdLIGRWAAygT3xqpKXJTdSn4vQZWQBIGb32AhNglU47NVequiEbfma2YoeYgZ9dyU7AAjGS2DnMUA0L9PudNgX/si9rwK43SviOWVEoMUjhmE1ASfE8U=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB5382.prod.exchangelabs.com (2603:10b6:a03:121::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Mon, 11 May 2020 20:24:18 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 20:24:14 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
To:     patches@amperecomputing.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/IORT: Fix PMCG node always look for a single ID mapping.
Date:   Mon, 11 May 2020 13:22:56 -0700
Message-Id: <1589228576-18053-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BY5PR16CA0019.namprd16.prod.outlook.com (2603:10b6:a03:1a0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.28 via Frontend Transport; Mon, 11 May 2020 20:24:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73cb5893-38a8-4b5b-23f4-08d7f5e94564
X-MS-TrafficTypeDiagnostic: BYAPR01MB5382:|BYAPR01MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB53827A6057E7517332372E8FE0A10@BYAPR01MB5382.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9z1aKXnMNe+z2M+1z1DLtlhHSQtZJwK/jbCPf1w4XRBep8D8LtKSQvNqvSsHQ6duQv9PvYjTZDE3YkDET62RW7DvbRRJtM9K2EReuYJuT+lvwwXRNsnOk9ggyV54zgHNMqbZnhYqf+loZiTTKdP++ebvmfHQQLdOxnlArvJfbmI39K2N+3xpu0U6CfVqBeSCvYtRmVWcHp8abcr0nz3D9jaXFggFxZ0JvOWTAnlb3PRQ6gomdK/u9Nqg8FJr8IuyERSeinw5UjkNIL94Smo8IVLxJ70bYE9UTCYHcQ8qCwjKJZr4Mw8e0Pcx4uHlcvnMAR0J7pNjowYV1qu80prn5Tp9vzksPTl8WBh3ReQSoCHC/KeyAJeu9OtP7tnoZalvd5EzHM25qS8Q//eR/nP7WQ1DyqZAlcVXO455wNRyftXrjSl5NU1tXf7uKsY0tf4JYwWDLfckRHoeXhG9/5hW5lKRt3qJqvhO34AYoKCAb3Dp6+Fko4EvzomH4ULzvxpRXjwJ5ariSjqzl6vOqNEqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39840400004)(136003)(366004)(346002)(33430700001)(8676002)(6666004)(316002)(186003)(16526019)(2616005)(86362001)(33440700001)(956004)(34206002)(54906003)(2906002)(478600001)(66946007)(66556008)(6506007)(26005)(52116002)(4326008)(66476007)(6512007)(4744005)(5660300002)(6486002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7TCl7MPWD3xeFxGg7BUtgHyj0nQxyIr83Oq+UuXxsPqNSsPHN2W5i5UzbVCDIDnJtz4akjFFim93P5YjqpC4viyjq8jORlkN0CaMdM6x6WznIDDxkwAo3gCi+PZVtz+ZsKjGRHiUR1W+qLP5z6hv2Fr+lKmz9gZlLZpl5pN9ftAKxssOHIavgcwRXTZyxye9J/fAlol7DyAaoIPTqIsrtVjhyWOn7jMpbBqH9BRxAjYZmodHHRHyU8RedzCfRzXQGgo8bd7xbh8bVrec/6VCGb/N+QVvRaRKQfhYBrNeLZryNuTI1ej58pIgmVrYgohbJTwVroKvW4hCNVmb9MctTOFaFxzCgz9N+PMLhsM5laRhYgU4Z/IK0OnxKKqSAYxS/NCWeDfpKLbrm0PgINFQJoNENW/JXgxHT4/moSFzSR2nEkMS6WdaO1GFUFPUlr7LBEUubOZ/rVNwcNFg1sdhWi2Ib/o/RoY/VBHynTQbOMA=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cb5893-38a8-4b5b-23f4-08d7f5e94564
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 20:24:14.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOZgATAa8OxObk1HDB4eOhLxvtrKOeLmfUXmiGdE6015AbFJiVKvWms7/T1ketATQUs7/lGO8Btj71g6rdXf4e5oDdscVfolhVOwXgZqOR5gb+xEyHskGeNsp4ctg6Rc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5382
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PMCG node can have zero ID mapping if its overflow interrupt
is wire based. The code to parse PMCG node can not assume it will
have a single ID mapping.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
 drivers/acpi/arm64/iort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ed3d2d1..72444e1 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -441,7 +441,9 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 
 		return smmu->id_mapping_index;
 	case ACPI_IORT_NODE_PMCG:
-		return 0;
+		if (node->mapping_count)
+			return 0;
+		return -EINVAL;
 	default:
 		return -EINVAL;
 	}
-- 
2.7.4

