Return-Path: <linux-acpi+bounces-18419-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A535CC2A9A3
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 09:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E34B3A4EA2
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 08:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8CD2E1C65;
	Mon,  3 Nov 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="OJ2UWY1D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321C2E1C64;
	Mon,  3 Nov 2025 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159372; cv=none; b=g5oZrllIIvKiBBWkblflB8pIey+QRJ9M5+Ym4JHGdOki0a2st53W/VbOESRJLybi0nC3ZSZ71rpDBeoPqKBzyJxHbo+E2PjJXLWI/DfoxVvrJ5zcQ3vM1M0vNtftvMIwPj2ZrdblvCJ2lsogriKui1GFJ8qQ6iBEgk3VcOMVxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159372; c=relaxed/simple;
	bh=ncg3K6j0LrOldr2S29bxiaWY8UEZV6BFKeCYvAlxb/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R/ECZNqpd2QddW237tK6F33sndLHJ42NexjReolzSMveFW8DgILFGEf82iQeHTWaHOLz5Tvaha9FKCeSWQJf9kWv01oEJvN2lTsLgXVOoqsqnuiGsaFHtEIXcGl48kKp2K5+HuxWf0UEuqoejuic/ZHf1Yca8GxCash7JAHsjs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=OJ2UWY1D; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x3n/1h3nBRhlOnHt+O1zE6ig3y9h9rJ09WqLGAv9Uas=;
	b=OJ2UWY1Dgok0vv1T0zrlWv8b8GOnQTHgg9VKxAG4pVQi+AcdxYaQU3HZYIKgLJRIjSPZ5q2nc
	oN+trpoMm7CwjWCnMpCneeiwv1aTxQZ4dam888T2PxD0ezJy8wcrRFhXa/oTS47Aea603xCRAjz
	MVe51xe0LLg3w0uWNMDQKHk=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d0Q6H4mB4zmV7V;
	Mon,  3 Nov 2025 16:41:11 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id C7520140277;
	Mon,  3 Nov 2025 16:42:45 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:45 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:44 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v2 0/7] ACPI: processor: idle: enhance and cleancode for cpuidle state
Date: Mon, 3 Nov 2025 16:42:37 +0800
Message-ID: <20251103084244.2654432-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)

This series is aimed to enhance the verification to the validity of
_LPI object and LPI state. And do some cleancodes.

---
 Changelog:
  v2:
   - mark the illegal states as invalid as patch 1/9 and 2/9
   - disable cpuidle of all CPUs if get power info failed in power
     notify
   - drop the patch raise up log level
   - remove the patch applied.
   https://lore.kernel.org/all/20250929093754.3998136-1-lihuisong@huawei.com/

Huisong Li (7):
  ACPI: processor: idle: Mark the state as invalid if its entry method
    is illegal
  ACPI: processor: idle: Mark the state as invalid when get
    lpi_state->arch_flags failed
  ACPI: processor: idle: Relocate and verify
    acpi_processor_ffh_lpi_probe
  ACPI: processor: idle: Disable ACPI idle if get power information
    failed in power notify
  ACPI: processor: idle: Remove useless codes about the verification of
    cstate count
  ACPI: processor: idle: Redefine setup idle functions to void
  ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_dev to
    void

 drivers/acpi/processor_idle.c | 85 ++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 35 deletions(-)

-- 
2.33.0


