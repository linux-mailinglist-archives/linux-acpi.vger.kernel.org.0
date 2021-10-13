Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75D42B361
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 05:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhJMD1H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 23:27:07 -0400
Received: from mail-eopbgr1320099.outbound.protection.outlook.com ([40.107.132.99]:6608
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237289AbhJMD1C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 23:27:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm4kKyD6nNR8y5zthhnpn9Kh6vTo7BKphP8ArnBZiZ4wdkcAFiQptFjanooHZA6o8rlKwctFQchIMJC50oDowoQpX8A5kfTfO9TldstIK5MYlHTBS5k7Gh3iUXdcZn0Wvgp0L3O8JwQH8SGftHsokeu0qtwOvAFuyoW8o4OJSG5GZd8pn1OdM4wpviyNk8huA/ZcZ8GRMo+V1Js6JPdp8+9ozRjQn2MVBLAZzPZBOBKEUe/6+qVV+Qm/47T0Gni3aIW6VXKSS8iF2T7qEeB0KqXIE1gjuEAUbzYy74dyfcHz/qaiZGC8MWAuPzvcw7LRX9NO6MXid2ZfZk1zHAPC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIdOid3KHZ5mSPXmYepT+86Rjr2PCaqdU3MFIisT/U4=;
 b=bZAO7MoYQavZ1tCiRzxvQ+cluG68qZ05uLZAi6oPkhIer87IFHZzKeir5WpA60c/kOhE2TXcZK7vnGKipJOqyvo4pmP846wgs5KxqOROWBiSL9Kdht1QzZ0YfvCFbmDVx9UwbwkOLTAaMTGGRi1/RjwgmhZw1tqz/gvMqFFeiQDFS0GNaAXRrkbk9nOvA9BSFm45rZNoGGruGFM3hIqU3rA5BkTzZ68yd5iWpQ44YziVsaagTYhTn3nHDV8974NyVN20DMvKmD8JKyKTGbOeNgKDhk8/uyJ0OO1IZGHFqbzrQ6cCj3icsRruhLjTNxZk4fzoAK9Gn0+f+Q7mvdJoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIdOid3KHZ5mSPXmYepT+86Rjr2PCaqdU3MFIisT/U4=;
 b=DjE7DqPH+tgvbzhkjqsU9V7CAtUX8Jc2sRRbdfxlEI3dN6mKgYCr+VfL2BCduO3zqFDjBJzjwyFK2hqixkMHw/cSKHXWe+GUnmwUD5XUAVFCK5dmrYLw+XzYXRBoTikPJ6PQJeHQdUGdXdo71nVQGh2dCGIyLhoiWNn01xWvfLw=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3387.apcprd06.prod.outlook.com (2603:1096:100:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14; Wed, 13 Oct
 2021 03:24:58 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:24:58 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] acpi: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:24:50 -0700
Message-Id: <1634095490-3799-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR04CA0050.apcprd04.prod.outlook.com (2603:1096:202:14::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 03:24:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e88d29a5-6ca8-4394-73e8-08d98df9087a
X-MS-TrafficTypeDiagnostic: SL2PR06MB3387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB33874AEBC46FD219DC436A0EBDB79@SL2PR06MB3387.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:225;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlY/Xta6U8WWSv4eRyeccxhD7DyF3oUJxMFuYp4ZFTMTLom/LudzdoRrxOjWgto/V8Zkh9SoTl16rOMwOq+wfVXXDXtNJtSv0nz5h4YFijNPLVfnSGo7fiQOZXD5MlW3LA1uLfGV5+Yq61RU/jbxWSSrFdU2vKxLLkByJqm4y0nAyRh8ONg774mW3tXLFJpxZZmqtOV05XNhwl+8L17uoc1KgFgTkKX9CZR87Q7ZxKyy+lb0wt5MAsP2hs0HzEG4aqSbUvi6w8xJM6gmcwo9LiOWXo406yMOE91QdvMor51SN8GCKW+qpfNKH7REEFC0/zMXavqmiBF63Fv2M/hD8q4eSXl2pXRo1/U8/6+f9GCVYbXlZpo/JAlYYAsX/lGy9tpCZlkqrrzE7Wwkze1of3amhlN1tG1pkR7kgZ25n4rv0zaJzXEa2DNwl3gOjW34EQzgbz8fiyixFuavH+3mXLpyNObsE6kbUICZ7yEo8bJAlBzaVt1d2UbpMHA6kaiVJ5m53r3SdICDxld48CPJICv1CLWhKG/pbUVFslUmKM5Qr1hhANouBoCdQ0G6+95rFDb+sT+LMS5u5e8LLfKs71eWbNDXlsprwBPC1graWMReh9RqzaryQjMcUgfR+YxHjsne0w0TqVEX8+8UlESjgXSwZUv58hZzsiL47varBeMgaMpYj74vZfLhX+y79eUFNnxPFFya3BhbY8Zxoavt6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(86362001)(26005)(6486002)(316002)(38100700002)(5660300002)(66476007)(6666004)(83380400001)(4326008)(6506007)(38350700002)(66946007)(107886003)(110136005)(508600001)(66556008)(2616005)(8936002)(2906002)(52116002)(8676002)(6512007)(36756003)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1k3dpCdCcoY1E4OtDP6r1t06nkowiXMDXqMAZS6CUBiTxr/tuTHhCr2nIS4H?=
 =?us-ascii?Q?W9rKJU5F52hRY6YZWw4H+ZBwQxsaeC0kvaiQPR0JcwrdoUiUCOT6LsFJR52s?=
 =?us-ascii?Q?IToOa8DaqExTgmh6xeN1viwL7BNmqFe3z6AeBuO8r5MeR89OF/WUbowjKuCw?=
 =?us-ascii?Q?1HMCE/G+G/nP5lx19nWr6acTI1TTPx/QSCLNd+utzMjQGUVsWmcghh2wEqbA?=
 =?us-ascii?Q?s6cRXxQ9+FRN4PXFr3ctt091hC+SmaFPu0BlvJK/5xu0zUxFtMirv2ivv1mq?=
 =?us-ascii?Q?PBT88tprWH5UbsMWPFDAFT400alfoHA48r5EMcStZbuq6eHCXncohh+BwS4V?=
 =?us-ascii?Q?OjPLb6sJe3JsBNrERETrZ4pHYArMN+zSdaywAOVpgJn+Q7XQf4spd1hu3mK9?=
 =?us-ascii?Q?hU8NZ4X2jupYh1Q328Z9vbLIIIgxOA8N2LIhWyNSxq38mMPXf49gAESI61ym?=
 =?us-ascii?Q?wW2WLD6qg2ZNLa5FOQeu1dXTW6oH370bx9i3u1TlG+vnG6EfKPRMfD+di74l?=
 =?us-ascii?Q?klT53Qio3fS4juTYWybCDDAzeTx1cc9LFm4W0I9Mgd8e4yNjit8Z8X0BGb6x?=
 =?us-ascii?Q?nCHWI6wnB6Yxr67+4EPz4Sz8xIJ4Bd99+YC3DmjuHx1tNqcXiL0X8QkpkA55?=
 =?us-ascii?Q?vWmwUrKxGohls7pTRTvPXIBuht73dWB3AsrVJ0oJc+/oOjKV3yeVFHiJNMhI?=
 =?us-ascii?Q?CqRQR+BUjjesm8gZambD0rI4fNkxlKiO3WaKtiNnR9emKOlMY6aiavWXbGy/?=
 =?us-ascii?Q?IuGPdv2IQ0tipteqNAVysxcdlOYw963FwCssr4QngNGdiBwcIM4pwCxnuHmi?=
 =?us-ascii?Q?T3gwpT+m1GsTmG8spMmbGS/FDRiuM6eLBgW0NPrmAlHi8tJ+X/LePAtgwYae?=
 =?us-ascii?Q?fPCmPMDe2cVe4P0u3CbuE3FT0NE2lDEBnTyIewe5LGabw6VyWE4/lrkvhe8d?=
 =?us-ascii?Q?qqwy7J9RDPHKSvxY6Otld2p6INFKYE8pIRuIxkRFWD00jlZuZiT+RtgzZvpf?=
 =?us-ascii?Q?xyS3wujrQAGavgXB1Am2dN7JFDEJui7nvBVfkfvrCzbjiw97EecT86J24e/2?=
 =?us-ascii?Q?LmkRakafHVJKFSxCsN5XNjfq46uIBGMDds6HwX3VIeN6tPFgh03kkBqDlVqd?=
 =?us-ascii?Q?WXOGNKpsDbbrK/NKkLN4WW9jAPIigRvgRP1lsMLHfv33DaNrRkNM+K2LteyW?=
 =?us-ascii?Q?p9O7otcuEdDQLD53H42Cjk021Uct9vOriHfcz+fpDW8mrTtWK1WTcJe/Q8Mk?=
 =?us-ascii?Q?XAD9nRyGCxNenDJuWVdphrvOmuOHPCgRF4PJbcphcnmLGUeSb3S7hGHarLwf?=
 =?us-ascii?Q?GX4eZBwZnhE6WDtdkcK4XYVP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88d29a5-6ca8-4394-73e8-08d98df9087a
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:24:57.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn1ZfRRhAv1ghsVj2xx0KmPbCaOnnESXEUuarcL+AQsQ6KHzd97/Rj1FWZ2SOc8XVEWbAgTCtxy0INT/O3z9GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3387
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the coccicheck warning:
WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/acpi/acpi_lpss.c | 2 +-
 drivers/acpi/dock.c      | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 894b7e6..9c437d4 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -748,7 +748,7 @@ static ssize_t lpss_ltr_show(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	return snprintf(buf, PAGE_SIZE, "%08x\n", ltr_value);
+	return sysfs_emit(buf, "%08x\n", ltr_value);
 }
 
 static ssize_t lpss_ltr_mode_show(struct device *dev,
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 7cf9215..c8e9b96 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -492,7 +492,7 @@ static ssize_t docked_show(struct device *dev,
 	struct acpi_device *adev = NULL;
 
 	acpi_bus_get_device(dock_station->handle, &adev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", acpi_device_enumerated(adev));
+	return sysfs_emit(buf, "%u\n", acpi_device_enumerated(adev));
 }
 static DEVICE_ATTR_RO(docked);
 
@@ -504,7 +504,7 @@ static ssize_t flags_show(struct device *dev,
 {
 	struct dock_station *dock_station = dev->platform_data;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
+	return sysfs_emit(buf, "%d\n", dock_station->flags);
 
 }
 static DEVICE_ATTR_RO(flags);
@@ -543,7 +543,7 @@ static ssize_t uid_show(struct device *dev,
 	if (ACPI_FAILURE(status))
 		return 0;
 
-	return snprintf(buf, PAGE_SIZE, "%llx\n", lbuf);
+	return sysfs_emit(buf, "%llx\n", lbuf);
 }
 static DEVICE_ATTR_RO(uid);
 
@@ -562,7 +562,7 @@ static ssize_t type_show(struct device *dev,
 	else
 		type = "unknown";
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", type);
+	return sysfs_emit(buf, "%s\n", type);
 }
 static DEVICE_ATTR_RO(type);
 
-- 
2.7.4

