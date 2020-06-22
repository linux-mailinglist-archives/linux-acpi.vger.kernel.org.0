Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13560204455
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jun 2020 01:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgFVXRs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 19:17:48 -0400
Received: from mail-eopbgr60104.outbound.protection.outlook.com ([40.107.6.104]:33030
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727061AbgFVXRr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jun 2020 19:17:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM/dsXmPVnX4xYch0chzI3EFDAGxN42SZ8lafpPBjnwo4rSJk+TebZkycdgjcI3Bw55rYJbamVTvPdzM2xhFQlYeNyUwqQwvveB6exFSq2z8cBDrw6eUfbSAxVLJda216+ztItYbTN+xe4pbo5mheKl8nPfHK/28o44O2V2aLihBqhckznLUJtH6XRtp1T2pV8xT1dsmMECQsFnwKlt+eH6nABLUQ3YlGCDKEJyfQpnXkFl23Ttb2N/jLyTOrcHX00brtdSWLSUc57w2LhxdmoEh6vEslZQNAgGrbJOIODsI8eiH5AcIE5KxaJFouU82BMKQ4kfzIGZpP1UYjCBnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEBlqsgc0HSB0ZzPs071Mx1X0L4NqvgYFyEzmBRnSfY=;
 b=D/iyWniYd4wj1336g2TgPPkgxOC5LC4aEew/YslmKipy5ZFthVIR1c1x6GeD0xOykpxBotnEjf2S1ZD6hTvLk4k0HhzJsMCAEF+qK/gYkZcJpSHfzvu4KYDy985vobxPrwtZDJFl2aKxEWC6bs9hVFObIyp5CbQXU0+vpMU1DAu8wAa1btiAX+rjJS4LDfBwwCvEmQKCDduSYlHwwC+Z3XX/SqBezjqtzVBAGywjpuqYynFNqY547BbGzq3kKCxrK541Hti3GI++aXpLQl2UEGO93SxCdIV1+oEj5y8Jmm3pNaPODW7JeBbug7jOy6HPxTivWgo0gKdTpA+fCv/3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEBlqsgc0HSB0ZzPs071Mx1X0L4NqvgYFyEzmBRnSfY=;
 b=Tn/SMj+x3ZwTMisxmDsUZNdG7rX6c70XhkZfMC5PpbQJRb4pC249K1EP3WEZNQh8RbnGsv5nXZjdasdPs5P1g2/jdlhTK1mcK55trEUYnc+QP+YWyAEFyl5AhAjo2l4w3lgPlINJyQfoN+R77nzyxQ4v9M7bipTY7xDdSTbRIx0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB4033.eurprd08.prod.outlook.com (2603:10a6:208:133::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 23:17:45 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 23:17:44 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] ACPI / hotplug / PCI: lost acpiphp_put_context in
 acpiphp_grab_context()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
References: <CAJZ5v0gQD_T9WmoF4gv-eDpmKto4_c0pJGiy_7FPiipSGOTrQQ@mail.gmail.com>
Message-ID: <d41ead67-f66d-43fd-7a4c-e4d92adb52f2@virtuozzo.com>
Date:   Tue, 23 Jun 2020 02:17:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAJZ5v0gQD_T9WmoF4gv-eDpmKto4_c0pJGiy_7FPiipSGOTrQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::42) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR07CA0029.eurprd07.prod.outlook.com (2603:10a6:208:ac::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.13 via Frontend Transport; Mon, 22 Jun 2020 23:17:44 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ab9c616-6010-4570-6206-08d81702780b
X-MS-TrafficTypeDiagnostic: AM0PR08MB4033:
X-Microsoft-Antispam-PRVS: <AM0PR08MB40334A3A456F2DB8615776A2AA970@AM0PR08MB4033.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IujXTecP2NblBgDAhYvmqleqph2b+MuMUAY1FfnrNEXRMq0lyZH0vip8R4cOFaAD82Yr76Dcn9aN4fJDhwU1iFnxTw/S50qQNd2Y5YkJ4wLWAdIuzX04DO+8g8XhsnkDgmltVPye2S6zSx6RwP9mEslSLnd2hezV2erDpjQlddMhemw+4cYuIiYPmHcqINyWB+5JR93KAbrxBcJbUQzMkLdn+11imSxIKbQO6qfzOMKcqLUHGBVjnDW/6zothj5kRnHN6wmU3zWny6yW09uGRNewvFSgNgles3zkA1Cka3Dct4iqTVOmGf/CWhKMjZQ8dbpyzWXbSjGwYNgTTQcmONOtRNQW0y0eizXZIikk6kPC2CKd2ETEDlFHfoVwOA6J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39840400004)(136003)(376002)(366004)(396003)(66946007)(66556008)(66476007)(31696002)(83380400001)(5660300002)(2616005)(86362001)(956004)(31686004)(4744005)(2906002)(4326008)(26005)(54906003)(16526019)(8676002)(52116002)(186003)(36756003)(6486002)(16576012)(6916009)(316002)(478600001)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7mpdRbVHsDUXYcT2D9pQYZgH/Up5Fy8m0zHLTzUSicq48hYa+D+BC5c2Y7uwCKYAb9tTsg0ztS3mre9DR+28TneGbxUz7LaKnY+MzJuHfhMGzRd0VAg56Mf7e70hxpa8PQ7NB1/7fC78fjV0pa1VhV7MjFv6gREkONZ3XIgB94zByrZUK4qh5Q/WYv3XZYeDKK2IF+VjsIvgJ2SeBHJfoDNidZFNMXpMLQhNU7XW+ur2an54Zu63VT6YeFUWNWULGnxvEk7MieF7I7hTr5+c1KODcwDrOGizdgTurU+0EWeIHipAwQyYjdWBIonJvhGmSY5QlajuXsE2vHzhsCU5MG/elxnDAMqUlC8YorDm1znreo1T746klgbo3bgDqQMgePJAxUYhGSqb+9sXcz70W/k6LRwgytelhNmv62vJNcDMtc4aZRduZ4aBVUr1Y9ZuUveKoj8C53eie7BLwNLmfWGAPS1DfJCJrxlWMwhDS8o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab9c616-6010-4570-6206-08d81702780b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 23:17:44.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AohpakW1ZXTz/37aE1pTj8UkCGYj8hZzEsxTGdNFlDbIX4PpPrvD/FGkJvhsnFCjF6wyHA0X2HOZMd7BS6YDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4033
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v2: followed to rafael@'s proposal
Fixes: edf5bf34d408 ("ACPI / dock: Use callback pointers from devices' ACPI hotplug contexts")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index b4c92cee13f8..a0923a65e636 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -123,7 +123,11 @@ static struct acpiphp_context *acpiphp_grab_context(struct acpi_device *adev)
 
 	acpi_lock_hp_context();
 	context = acpiphp_get_context(adev);
-	if (!context || context->func.parent->is_going_away) {
+	if (context && context->func.parent->is_going_away) {
+		acpiphp_put_context(context);
+		context = NULL;
+	}
+	if (!context) {
 		acpi_unlock_hp_context();
 		return NULL;
 	}
-- 
2.17.1

