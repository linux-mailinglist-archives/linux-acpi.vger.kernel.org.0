Return-Path: <linux-acpi+bounces-20448-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCO/KKWib2l7DgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20448-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 16:43:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1F4678D
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 16:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A51EA72B124
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CCC42314E;
	Tue, 20 Jan 2026 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="E5P9yd56"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E33421F0A;
	Tue, 20 Jan 2026 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908808; cv=none; b=R9jar1O7pkLiEECfRlpY8hANrREcqBhqDFZBIbpZ/pgOhzeohjYXu/wU1+T+edbiCwb7VMGBWiidQyCcLuHu4LGelfjAdi5NvKwzAephG/Ymts6QhbGtuXZOyuD7/rKTq8pal0j5dojM2Gwk+XgtuTZiREesCewMr1v/29gWs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908808; c=relaxed/simple;
	bh=y0W0n0Lw3gczIXlTj8dAoL/B1n8sTL641ifUA7CJEEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oh8u0uzzGSkBiNKb23hdqtEWqiNYCFQ8nNhfoA+kxnh0FwA3wF8au1TF2F2gFZu0jaLN/YxTLGHibRnqSkSkgv8nIiu1GaHbyltYwAJA5EdVBu/uWUlXRwTUOXSp2AS/WHSVbmRTb2BYJSNSBSLUj/CZbV9ea6vtwm0soQLHir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=E5P9yd56; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DyOLv7w7OXgCFtESbOrDmyGVRZ50go1fYG4fT1pS1Ys=;
	b=E5P9yd56brvp5ibX3ywidpWKWOJRASJWxp/wqbQ63sjHvYsNAlLJ+kDOAGb2MFRtnpBMg6Uu5
	m62NMrSMWosXybiZ6QfWJWD1zDCEYdmasmGpPhwB8PX35caTtChVbjpKekphcmVmqxq9sFoD6I3
	s5Uyw3YA6IsvZhslYQzzS3A=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dwQ8z2X3vz1K96j;
	Tue, 20 Jan 2026 19:29:55 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 838F240539;
	Tue, 20 Jan 2026 19:33:16 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 19:33:15 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <catalin.marinas@arm.com>,
	<Jonathan.Cameron@huawei.com>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <gshan@redhat.com>, <miguel.luis@oracle.com>,
	<guohanjun@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH] ACPI: processor: Add acpi_processor_start() back to parse _CPC tables before CPU online
Date: Tue, 20 Jan 2026 19:32:42 +0800
Message-ID: <20260120113242.3843463-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-20448-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 38C1F4678D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, if boot with maxcpus less than NR_CPUS, the cppc_cpufreq driver
will fail to register. Because it requires the domain information of all
possible CPUs to construct shared_cpu_map, which shows the CPUs that share
the same domain.

Commit c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use
same path for cold and hotplug") removes probe() of acpi_processor_driver
and makes acpi_cppc_processor_probe() only being called the first time CPU
goes online. This means that CPUs that haven't yet gone online will not
have pre-parsed _CPC objects and causes cppc_cpufreq driver register fail.

Add acpi_processor_start() back as the probe() callback of
acpi_processor_driver and call acpi_cppc_processor_probe() in it to make
sure all _CPC tables will be parsed when acpi_processor_driver registered.

Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use same path for cold and hotplug")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/processor_driver.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 65e779be64ff..c8b4daf580b0 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -33,6 +33,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
 
+static int acpi_processor_start(struct device *dev);
 static int acpi_processor_stop(struct device *dev);
 
 static const struct acpi_device_id processor_device_ids[] = {
@@ -46,6 +47,7 @@ static struct device_driver acpi_processor_driver = {
 	.name = "processor",
 	.bus = &cpu_subsys,
 	.acpi_match_table = processor_device_ids,
+	.probe = acpi_processor_start,
 	.remove = acpi_processor_stop,
 };
 
@@ -162,10 +164,6 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (!pr)
 		return -ENODEV;
 
-	result = acpi_cppc_processor_probe(pr);
-	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
-		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
-
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
 
@@ -192,6 +190,30 @@ static int __acpi_processor_start(struct acpi_device *device)
 	return result;
 }
 
+static int acpi_processor_start(struct device *dev)
+{
+	struct acpi_device *device = ACPI_COMPANION(dev);
+	struct acpi_processor *pr;
+	int result;
+
+	if (!device)
+		return -ENODEV;
+
+	pr = acpi_driver_data(device);
+	if (!pr)
+		return -ENODEV;
+
+	/* Protect against concurrent CPU hotplug operations */
+	cpu_hotplug_disable();
+	result = acpi_cppc_processor_probe(pr);
+	cpu_hotplug_enable();
+
+	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
+		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
+
+	return 0;
+}
+
 static int acpi_processor_stop(struct device *dev)
 {
 	struct acpi_device *device = ACPI_COMPANION(dev);
-- 
2.33.0


