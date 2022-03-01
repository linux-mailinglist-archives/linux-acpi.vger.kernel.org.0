Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5904E4C95EA
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 21:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbiCAUSn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 15:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbiCAUSO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 15:18:14 -0500
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9FCBF8;
        Tue,  1 Mar 2022 12:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1646165840; i=@lenovo.com;
        bh=cO7P5D2a3xQTdSIhBdrBzqYfquPAeS2b0WHhKWBCErE=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=OqGx14fwY8CMNSwG5Yo+cTBJ8RAbmzZ1GASn0ADCbQpvz8YsUJ8keK1oES291TDH2
         2Co/Xp+HdPMm9+T4Dxy8/7rlP5k/IeNV6twHGtcer947c0aihvcoQnL+NfNwuLiu1G
         M8zvxNV0Mh41zl6EIsO/IOIXye7dtSCBDpLs9ts+Eemt3WK2zP6GEIKsjHzAg1B8Wn
         L3NZX7QyRKmHyQCNWjWSO215Qb45e3muLn5UEslKzwfWWeHhvv181cCGlGrH1QLQtV
         trxoKqDJi5zK4kSbxbpuVFAMKzvdWmOPmIyRat6jmc+fAOK6rZFRPWBLs37tgSlcVA
         /vKRudrX8fUuA==
Received: from [100.114.70.208] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.us-east-2.aws.ess.symcld.net id AD/8D-01896-05F7E126; Tue, 01 Mar 2022 20:17:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRWlGSWpSXmKPExsWSoV9joRtQL5d
  kcGsii8Wb49OZLJbv62e0WL3nBbPF3C9TmR1YPDat6mTzeL/vKpvH501yAcxRrJl5SfkVCawZ
  C7tvsxbMt6vY8+0rawNji2kXIxcHo8BSZol1Jz+zQDiLWCW2vjzICuF0MklsuTKdHcQREpjLJ
  LFk4wtGCOcAk8T1k0eZQRwJgeOMEt2H1jFBZDoZJX68OgU0jRPImcAkMe+3CETiMaPEk7vLoa
  qeMUrcm3mbFaSKTUBbYsuWX2xdjBwcIgIyEh/WeoKEmQVKJDZsfs4GYgsLOEo8mHyNHcRmEVC
  RWH5gCxOIzStgJbHiyw9GEFtCQF6i+98fsMWcAqoSZ7oeQx2hInH/wRI2iHpBiZMzn7BAzJeX
  aN46mxnClpA4+OIFM0S9ssSv/vPMEDPlJA7M3Q9lJ0j0/HvEBmFLSly7eYEdwpaVOHp2DguE7
  Stx9chZqHpdiTPNp6DqcyT+n57MBDPzVO85Jpibd268zTKBUWcWkvNmITlvFpLzFjAyr2K0Ti
  rKTM8oyU3MzNE1NDDQNTQ00TU31DUyMdVLrNJN1Cst1k1NLC7RNdJLLC/WSy0u1iuuzE3OSdH
  LSy3ZxAhMQSlF7l93MPat/Kl3iFGSg0lJlDfBWy5JiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTv
  +RqgnGBRanpqRVpmDjAdwqQlOHiURHhZ6oDSvMUFibnFmekQqVOMxhxXtu3dy8yx+OqVvcxCL
  Hn5ealS4rxTQEoFQEozSvPgBsHS9CVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrx+IPfwZO
  aVwO17BXQKE9ApWz3ATilJREhJNTApCXN9XTYz8dfkLpZ5q88IR+/13Xv661zJiDADDukPOTP
  e/3i/liN0mbitamAE6zf16SbHpCfvLj/5e01XxjHzjYkTPmQ0nBYJUt6YbFYsrOQfdMzy0Aw5
  wfclr99UT7675eOT0L2rj06tfX1i2/q8OWqlvvbqGs61BbfuBf0oKeFvWmPcmOVmMyPi7enKR
  XPY02TZ7p2cc2ntwmcTowVOW1kK+pfzMp1J7sl1WfAk6Mq+B1+kJ9m9XX2oLSvy1X6tza4/N7
  e8rP21MNQiMVDNLu7Bg+1ZuSovLiY+mKtvecVXNbxSPzX9WEXxDP1Xnf9CZf/fT4u9dN1Z+ou
  2ocTkp7IXbj9csOPTh3VfrV45KLEUZyQaajEXFScCAO+ZJoxOBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-12.tower-715.messagelabs.com!1646165838!32282!1
X-Originating-IP: [104.47.124.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20271 invoked from network); 1 Mar 2022 20:17:19 -0000
Received: from mail-hk2apc01lp2056.outbound.protection.outlook.com (HELO APC01-HK2-obe.outbound.protection.outlook.com) (104.47.124.56)
  by server-12.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Mar 2022 20:17:19 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzDf02i+0vlvxUadA9vnPvQv8oTtBKEOYu2ujrs2eKfTpyMHVxNK9SQmCwR/Pxv2jfPdsNoyKke7E8qVX8QUSSOzrzE/ddb5L0t3/QcUPsMO6eC6fJoz/Qbz4onstePDh+Y8zHRAYW0ZAj2gc+aC7446+XBdxh5CEf1CwxYPL3tXAlmdc7OSR1VKOBNazjGuXshX8+9h7oVVQrmN+hoK6oKq3HjUdmft3UAbmsVzk6+aWp+TOf7r/KN+gQk88Vco6NOokr1D7fLc/MCfSGoqq3wuK7Kt/ZEoTuhAUUuvy0BpQfcG4R+iMixJpGGSyJN8AsJWlbzRQQKZFL7CrveFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO7P5D2a3xQTdSIhBdrBzqYfquPAeS2b0WHhKWBCErE=;
 b=GT+Q3zkHE5fskDuOx4i00Q0MaPmjI3uh5RrR+EIBiK+Fg5XzrhZ4QfWzVQ0VH305MqU1y4Iug1TPQU+SL11RK2YIrRzqXaEcQudvkWWd7Fy5Hy3vE7Px0r5mC9hj25U+R39bzvn2B+4IupuIPZ0EXWd57G8+JnLXdwJx6/pmuktEdfCznkGI92sgS8HEdq80KlUPal8VVF1QJ9thXig1iG1E8+Men4D9OXloAODRbrhOCndtt66AkutsIkpiH7nDkigoGtx5C9aaHA9tdrCnB9kIbZy7yhRmEZ25C3GB51GAd0vpcGjOnhigQ6bI3U6OuALOYL9V3Psft7iTkkPk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) by SG2PR03MB3083.apcprd03.prod.outlook.com
 (2603:1096:4:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Tue, 1 Mar
 2022 20:17:16 +0000
Received: from SG2APC01FT0057.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:189:cafe::23) by SG2PR01CA0197.outlook.office365.com
 (2603:1096:4:189::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 1 Mar 2022 20:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 SG2APC01FT0057.mail.protection.outlook.com (10.13.36.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 20:17:16 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Tue, 1 Mar
 2022 15:16:23 -0500
Received: from localhost.localdomain (10.46.55.3) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Tue, 1 Mar
 2022 15:16:21 -0500
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linux-acpi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: [RFC] ACPI: platform-profile: support for AC vs DC modes
Date:   Tue, 1 Mar 2022 15:15:54 -0500
Message-ID: <20220301201554.4417-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.46.55.3]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ac2e79-544b-40d3-cb71-08d9fbc07b2b
X-MS-TrafficTypeDiagnostic: SG2PR03MB3083:EE_
X-Microsoft-Antispam-PRVS: <SG2PR03MB30831851FB6064A1C6BD9615C5029@SG2PR03MB3083.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLOirdLGAXxSwM3mvcKicF8gtp/HeyHaH2h/7ZuBG9F0KcAqAqDAVdIxDBAHEZY8vX0kT5iIxYiARQg8fDUazP2Ig5vTOazJsiAYiFPl5K8b2cknD3zgwQ7PrqVjrKh800CwJ3OZMCMpEMVPUL/HAgDeyYiys643ZN9rCQG2sGhJUHFAG7gjsKJi/8Psf/sagEF2bTT+vSuIlzS91ATYe3delaWFl+VI5ZU7zN4uvpi0ITT3dTJFcLdRwKU3RFPDyvoOWufsz32GBHQU/h4w0SFBTpJKUk+5jySZa8NwV2oTTHHQhbwgT2DkJNm4R34L2dNQ7aE/aadOTshTGFQ0SvoJhjdzvqWncFQv91FwDn3OryJmhoFGqdk9kJDRMIs2jx1rQZPQSiaxtiBD1BWHoZqDHNjKWTx/FaPVlTwchAGIdbui8Q3JGUZhLb5ToUET+VeeYGURgzcGxuT5+5doTg4Ea32QwkdaemTHdpJS/VX/FaVXqSVOrcx3g2cALhYplyCWRc9B6LVN64hn8oP7cIjYvWgZfTrw4RVcEC9NDHginSwziyCuRHdeuRtTkhiVsfKomO6NFqN1LWAXv7396Bucnkclx1rc1jRcHyvy2GwtHf2NbT/HkQZQbc4/29/h905Eopi6Z+CHhlClmGaejc9fDnUiii12inCW8fdyd4fkC13aVpGRjNXAtdgVhYa6bIaQvlxAQEQovvjWetPDnw==
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(426003)(83380400001)(82310400004)(26005)(40460700003)(1076003)(336012)(5660300002)(16526019)(186003)(2906002)(2616005)(356005)(82960400001)(6200100001)(47076005)(36860700001)(7049001)(6666004)(54906003)(37006003)(4326008)(6862004)(8676002)(70206006)(70586007)(508600001)(36906005)(36756003)(316002)(8936002)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 20:17:16.3240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ac2e79-544b-40d3-cb71-08d9fbc07b2b
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0057.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB3083
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Looking for feedback on this feature. Whether it is worth
pursuing and any concerns with the general implementation.

I've recently been working on PSC platform profile mode support
for Lenovo AMD platforms (patch proposed upstream last week). 
One of the interesting pieces with the Lenovo PSC implementation
is it supports different profiles for AC (plugged in) vs DC
(running from battery).

I was thinking of adding this support in the thinkpad_acpi driver,
but it seems it would be nicer to make this generally available for
all platforms that offer profile support.

This implementation allows the user to set one profile for when a
system is plugged in, and a different profile for when they are
unplugged. I imagine this would be used so that performance mode
is used when plugged in and low-power used when unplugged (as an
example). The user could configure it to match their preference.

If the user doesn't configure a DC profile it behaves the same as
previously and any ACPI power events will be ignored. If the user
configures a DC profile then when a system is unplugged it will
automatically configure this setting.

I've added platform_profile_ac and platform_profile_dc sysfs nodes.
The platform_profile and platform_profile_ac nodes will behave the
same when setting a profile to maintain backwards compatibility.

If you read the platform_profile it will return the currently
active profile.
If you read the platform_profile_ac or platform_profile_dc node it
will return the configured profile. This is something missing from
the current implementation that I think is a nice bonus.

User space implementation could potentially be used to do the same
idea, but having this available allows users to configure from
cmdline or use scripts seemed valuable.

Note - I'm aware that I still need to:
 1) Update the API documentation file
 2) Implement a disable/unconfigure on the profile_dc setting
But I figured this was far enough along that it would be good to get
comments.

Thanks in advance for any feedback.

Signed-off-by: Mark Pearson <markpearson@lenovo.com>
---
 drivers/acpi/platform_profile.c  | 130 +++++++++++++++++++++++++++++--
 include/linux/platform_profile.h |   1 +
 2 files changed, 125 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d418462ab791..e4246e6632cf 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
+#include <linux/power_supply.h>
 #include <linux/sysfs.h>
 
 static struct platform_profile_handler *cur_profile;
@@ -22,6 +23,51 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
+static struct notifier_block ac_nb;
+static int cur_profile_ac;
+static int cur_profile_dc;
+
+static int platform_profile_set(void)
+{
+	int profile, err;
+
+	if (cur_profile_dc == PLATFORM_PROFILE_UNCONFIGURED)
+		profile = cur_profile_ac;
+	else {
+		if (power_supply_is_system_supplied() > 0)
+			profile = cur_profile_ac;
+		else
+			profile = cur_profile_dc;
+	}
+
+	err = mutex_lock_interruptible(&profile_lock);
+	if (err)
+		return err;
+
+	err = cur_profile->profile_set(cur_profile, profile);
+	if (err)
+		return err;
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	mutex_unlock(&profile_lock);
+	return 0;
+}
+
+static int platform_profile_acpi_event(struct notifier_block *nb,
+					unsigned long val,
+					void *data)
+{
+	struct acpi_bus_event *entry = (struct acpi_bus_event *)data;
+
+	WARN_ON(cur_profile_dc == PLATFORM_PROFILE_UNCONFIGURED);
+
+	/* if power supply changed, then update profile */
+	if (strcmp(entry->device_class, "ac_adapter") == 0)
+		return platform_profile_set();
+
+	return 0;
+}
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -77,9 +123,34 @@ static ssize_t platform_profile_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
-static ssize_t platform_profile_store(struct device *dev,
+static ssize_t configured_profile_show(struct device *dev,
 			    struct device_attribute *attr,
-			    const char *buf, size_t count)
+			    char *buf, int profile)
+{
+	if (profile == PLATFORM_PROFILE_UNCONFIGURED)
+		return sysfs_emit(buf, "Not-configured\n");
+
+	/* Check that profile is valid index */
+	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
+		return -EIO;
+	return sysfs_emit(buf, "%s\n", profile_names[profile]);
+}
+
+static ssize_t platform_profile_ac_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return configured_profile_show(dev, attr, buf, cur_profile_ac);
+}
+
+static ssize_t platform_profile_dc_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return configured_profile_show(dev, attr, buf, cur_profile_dc);
+}
+
+static int profile_select(const char *buf)
 {
 	int err, i;
 
@@ -105,11 +176,50 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	err = cur_profile->profile_set(cur_profile, i);
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
-
 	mutex_unlock(&profile_lock);
+	return i;
+}
+
+static ssize_t platform_profile_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	int profile, err;
+
+	profile	= profile_select(buf);
+	if (profile < 0)
+		return profile;
+
+	cur_profile_ac = profile;
+	err = platform_profile_set();
+	if (err)
+		return err;
+	return count;
+}
+
+static ssize_t platform_profile_ac_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	return platform_profile_store(dev, attr, buf, count);
+}
+
+static ssize_t platform_profile_dc_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	int profile, err;
+
+	profile = profile_select(buf);
+	if (profile < 0)
+		return profile;
+
+	/* We need to register for ACPI events now */
+	if (cur_profile_dc == PLATFORM_PROFILE_UNCONFIGURED)
+		register_acpi_notifier(&ac_nb);
+
+	cur_profile_dc = profile;
+	err = platform_profile_set();
 	if (err)
 		return err;
 	return count;
@@ -117,10 +227,14 @@ static ssize_t platform_profile_store(struct device *dev,
 
 static DEVICE_ATTR_RO(platform_profile_choices);
 static DEVICE_ATTR_RW(platform_profile);
+static DEVICE_ATTR_RW(platform_profile_ac);
+static DEVICE_ATTR_RW(platform_profile_dc);
 
 static struct attribute *platform_profile_attrs[] = {
 	&dev_attr_platform_profile_choices.attr,
 	&dev_attr_platform_profile.attr,
+	&dev_attr_platform_profile_ac.attr,
+	&dev_attr_platform_profile_dc.attr,
 	NULL
 };
 
@@ -161,7 +275,9 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	cur_profile = pprof;
+	cur_profile_ac = cur_profile_dc = PLATFORM_PROFILE_UNCONFIGURED;
 	mutex_unlock(&profile_lock);
+	ac_nb.notifier_call = platform_profile_acpi_event;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
@@ -169,6 +285,8 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
 int platform_profile_remove(void)
 {
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	if (cur_profile_dc != PLATFORM_PROFILE_UNCONFIGURED)
+		unregister_acpi_notifier(&ac_nb);
 
 	mutex_lock(&profile_lock);
 	cur_profile = NULL;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index e5cbb6841f3a..34566256bb60 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -15,6 +15,7 @@
  * If more options are added please update profile_names array in
  * platform_profile.c and sysfs-platform_profile documentation.
  */
+#define PLATFORM_PROFILE_UNCONFIGURED -1
 
 enum platform_profile_option {
 	PLATFORM_PROFILE_LOW_POWER,
-- 
2.34.1

