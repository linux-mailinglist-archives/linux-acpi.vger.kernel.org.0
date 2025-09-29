Return-Path: <linux-acpi+bounces-17404-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A0BA8BD3
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6467B8EF8
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62352D3A93;
	Mon, 29 Sep 2025 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="g1tlegCa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477BC2D24BE;
	Mon, 29 Sep 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138696; cv=none; b=uq0saSaHoEGQDEZ/Ykg345NFnrlL2TQw4+xX1PCyTc/mAmk5X7leejNLPmIn1RL1tYypnm6zqXPtLDmzMUZn0UlKLGXJ7N+NgthP5P8xSAbuT2wb6lDQwPfY+rzDo69/GwLVEBUb7fBJbLz1hcSkYz4oqcIH3uXfip4d4O9xeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138696; c=relaxed/simple;
	bh=Yaf6dNuFt5lIq8e39M5WY9B2WGYRI32WGU0Xc5rRTsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QM9d1jm83qzmozkMEbuTxbcDJg4VQrq5SNlkhJWhkyjawYq2hTgMXf3nf2NrJ3PU+tadKM3HM56XDhTy94iteHDpKfTh3c1obnbjtOnnTjk8Tx8bFHzKqsENVJxcMvRgegZOxp1GvZZPcASfA9Z8ALbNtWevyORcx5n8aEuW/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=g1tlegCa; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from canpmsgout10.his.huawei.com (unknown [172.19.92.130])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cZx1806pKztTtH;
	Mon, 29 Sep 2025 17:37:16 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=usl1A5YQGbBV7KNyPDhS2T7EliJ0GyMwWERUQPE/Rhs=;
	b=g1tlegCafxivMZbNC2fqKQeLcRs5YY31AP+r+Ewh+SzcRwlWSpW1Ws5IZNNxoIfoeLRv9lKjM
	Lzamjy0iHAXA/CKkWgaeJnmWh5yZNpdsDP9fWg+SLu6Id7t/yifnnkuudHIc2cQgx3Q3nO8+K6I
	0+es69FMna640AlHvUaJ3HQ=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4cZx1p2Lghz1K9j8;
	Mon, 29 Sep 2025 17:37:50 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 241A51800CF;
	Mon, 29 Sep 2025 17:38:00 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:55 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:54 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v1 0/9] ACPI: processor: idle: enhance and cleancode for cpuidle state
Date: Mon, 29 Sep 2025 17:37:45 +0800
Message-ID: <20250929093754.3998136-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

This series is aimed to enhance the verification to the validity of
_LPI object and LPI state. And do some cleancodes.

Huisong Li (9):
  ACPI: processor: idle: raise up log level when evaluate LPI failed
  ACPI: processor: idle: Return failure if entry method is not buffer or
    integer type
  ACPI: processor: idle: Return failure when get lpi_state->arch_flags
    failed
  ACPI: processor: idle: Move the initialization of state->flags to
    acpi_processor_setup_cstates
  ACPI: processor: idle: Add the verification of processor FFH LPI state
  ACPI: processor: idle: Do not change power states if get power info
    failed
  ACPI: processor: idle: Remove died codes about the verification of
    cstate count
  ACPI: processor: idle: Redefine setup idle functions to void
  ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_dev to
    void

 drivers/acpi/processor_idle.c | 102 ++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 49 deletions(-)

-- 
2.33.0


