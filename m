Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D31F819D
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Jun 2020 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgFMHlG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 13 Jun 2020 03:41:06 -0400
Received: from mail-db8eur05on2123.outbound.protection.outlook.com ([40.107.20.123]:4832
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbgFMHlF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 13 Jun 2020 03:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0YrE4558HMw6dm/T1SRsEJ2ramwGXdIhNyzRYhPc2OKAulFtcPFfrSmRusg7k1xCKtvl5d1KWQ84BKBs/woQmByaM3AK/JEG4l4zkEzhmKxk3+RwZkzAByXcZBfCNqwXRy/D01jqZIv+EzpyNmERhlIQTjrRA8tqjdkIbtHg4inq2CEzn8t3YxPXva+85fpm+hOBDKLlenloiJ1Q3mYPDHkViaG7qzR0byAuRtCvSTpSRigEVSNP7KMKNMGSJ4/RHBIXrr99fvqO0HvYGrtRQLu3s2FHpx2UDjqWCsBswKwFKYGSE4jDSVdc3hkVdA2FhE47UVbGPPeNZbcZ67puA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/9soN2ZSarYhD+X725uTRieIjVYbjX7XO2/rKgKco0=;
 b=L/4z4swv6IPoZabyDAKoKeDREbEnT6fLKRX3ypB7SUk4fgsWF1yrmvjMjPTzBqzI02dgPc10i4OscQpN7HuvdBiBTDilRaF1DtwwajeKm7ka45MWvnl2/hC2I7KY0DGSGA6bd/MLUBUOt9lKyywyjtRyX/rCPgjV/pthdSDyDugBFuFdaegX/vos7biSbzMNqrNyRto3zWGrF0/nVuxfcJDlCA05bLHiONA0LdJECx84r4lEyfkx1h5IWN2i/SotUGfFxQBpJ8w66u/7F6bqIZSb7WbwDyQw05edxZUP6MYvAshJf6pB8ukUhWHagBh9oF1Cvw/YZJ76AEKbTGhesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/9soN2ZSarYhD+X725uTRieIjVYbjX7XO2/rKgKco0=;
 b=rQU1aqhwLoTkBhdrz7RNjfBOYRcL4dNLmCfEgJYr/lrB4CXz1ifLWAbTqKUcFOAlLSCAZfl+umD2r89n+iVsdMnRTioZFOeb0TGNI04KTkHWTRYhqny3xhsxBAVVSV7lHGCrI90nOEWJejBk4CoknO44KQzuX8ksbmCQQDESs+8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB5141.eurprd08.prod.outlook.com (2603:10a6:20b:e6::26)
 by AM6PR08MB3288.eurprd08.prod.outlook.com (2603:10a6:209:47::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Sat, 13 Jun
 2020 07:41:02 +0000
Received: from AM6PR08MB5141.eurprd08.prod.outlook.com
 ([fe80::9c6e:e0d8:57b1:4cfd]) by AM6PR08MB5141.eurprd08.prod.outlook.com
 ([fe80::9c6e:e0d8:57b1:4cfd%7]) with mapi id 15.20.3088.026; Sat, 13 Jun 2020
 07:41:02 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] ACPI / hotplug / PCI: lost acpiphp_put_context in
 acpiphp_grab_context()
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Message-ID: <83d51ff2-a359-9a67-10d6-53c9c2287bf8@virtuozzo.com>
Date:   Sat, 13 Jun 2020 10:41:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:200:89::18) To AM6PR08MB5141.eurprd08.prod.outlook.com
 (2603:10a6:20b:e6::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM4PR0202CA0008.eurprd02.prod.outlook.com (2603:10a6:200:89::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Sat, 13 Jun 2020 07:41:01 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a82be18-2896-4554-b9f4-08d80f6d1f06
X-MS-TrafficTypeDiagnostic: AM6PR08MB3288:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3288563E35E436A7BAC7B920AA9E0@AM6PR08MB3288.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-Forefront-PRVS: 0433DB2766
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1soZXxbVwakKFWAZnY0s5aKboUZD9pA/rmgxUcN8MrPLLdtOIaDBZkRbnaeviOlEQbH3Z58ZH12i0VaXUGw+lrL4KvJLcIH+xZF9Q700yOswvkQ4y4Hhgkkd5hrCxWnYWXDLEXlOABdIOFnjRoXt07hBaTqEZ6b8a3S9jw8gr8YBT/PBAF89/5ONINIrw+SMcEIbfoJGy0v7Yj0lTvBNz6R9jiiMA7EL5yUwdyQ6OEQcIdm7t//AXiLFoLf5ZtH6YCjpk9p0RKKMQMFIPp8jqLklAM4fsKBJwmkKt3Y9Ba1W0J3LlLUNs/IiAC8B8a04MQh8yhXlwjk2B2UOdAFdZ0baJHt9wwIQnTg1vTV74JZdB0YO3zNwsamZk1TUAn5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB5141.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39840400004)(396003)(366004)(376002)(136003)(66946007)(66556008)(66476007)(2616005)(956004)(52116002)(6916009)(478600001)(26005)(316002)(16526019)(2906002)(6486002)(16576012)(54906003)(186003)(8936002)(8676002)(86362001)(4326008)(31686004)(31696002)(36756003)(5660300002)(4744005)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3uMa1FqC9dEy+q9knz7KzrnLKSLMEvrXZng8ogL5WZ84u7Xg8eENrvL1hn0s9KrxxlI5TIiecT6esrebveBYSkFZXd+rTFUJc/u6wsIeWZisJXbQDUzAgxE42qBAgDkqEP0oayp/+qwUa+EVtSw8BtHLVT5GtxrkXVXqE6HPMipE4MHXg2nwR+C58jxGBWh0rUoRWpbX26nvG7hEf5Y+5Y5Kkw+JWM8GquGfvkim4Qvh9nmLsVioZOecDTnY0y+0PqbsirRV/K8WpfZOUfqVfyu5Z2xdnNwDkJloWotMjwCdMRMmp3VBokfiLjw25jX2D8FZimH5YUiDh+XL6dWVg+P8iz2Hk93f7NQxsfy8TbwZgbOjgPBOA8MVd1QVBIXvJUMltO0s0w9geccjRTspFa/1jLTLdcJ43mz97cuwiNjUGV7blmweqbAcGunk2Te+2unkbRqLFKr317LkpuqLgO1w37HWVu4d5nis7LL9xJs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a82be18-2896-4554-b9f4-08d80f6d1f06
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2020 07:41:02.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snI35c2lVnDPNJ2oxCVmHJzulb1bfFf77gkZt8MqDxzlsxLyFhW33uzHyG2zwczVVxIN+7CaHTaK06rO1tQufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3288
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixes: edf5bf34d408 ("ACPI / dock: Use callback pointers from devices' ACPI hotplug contexts")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index b386995..e49ec95 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -124,6 +124,8 @@ static struct acpiphp_context *acpiphp_grab_context(struct acpi_device *adev)
 	acpi_lock_hp_context();
 	context = acpiphp_get_context(adev);
 	if (!context || context->func.parent->is_going_away) {
+		if (context)
+			acpiphp_put_context(context);
 		acpi_unlock_hp_context();
 		return NULL;
 	}
-- 
1.8.3.1

