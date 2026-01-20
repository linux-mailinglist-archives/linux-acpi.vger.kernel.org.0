Return-Path: <linux-acpi+bounces-20444-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM7RIdl4cGktYAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20444-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 07:57:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB55552769
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 07:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92DDA50B0BE
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7BD40FD86;
	Tue, 20 Jan 2026 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="IjKExCGt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A723A7F45;
	Tue, 20 Jan 2026 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908185; cv=none; b=S5SRcEXVXpUjQ6nlbNM/4hyWygcDonSQ9LZGzvZ1pNs7HnZYs3C0Ey//l2yXWeuVTl6r26+2445d1iWb85omx0ZkCkksBydOah7/XLwQ+oMKJaqGpBy/GZO69597NwUcL56uuIIy2kiAR9tlZA4l8hBhRfS0NjVNjzf0fzi7sV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908185; c=relaxed/simple;
	bh=jXlrROuPSPIRaMJeAldn0T7YOJLf6YL+pMY4HmGsgLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tyJwkdcTBWG1Xwvv6pKvLReYcfjfBg6mJePQyAkwEL8GMB+cvDgq4dJkoQIYTktTMpaEa4110rrvq6eXuDENXM5cxplXFriYq7kiDMtTsPxcn3m7Ed7DOeukesRhwaJuFrN3FgENRwyVKnDczVpWXSteGgGIwscDBSIZan9u+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=IjKExCGt; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FSf1tJnyB5ww8wBQ2L9a1143NNGjycQUEJKz8g8aBLs=;
	b=IjKExCGtulNVaE5ELTLTXwymDePGDQD86L+wF+SUbVVKTr2d+HqvyGM1rpAM9NrcNWPIDqQTV
	IoJBGGNjjOljDxFdcdlOuMa2B9fJxIVxZwY1dluPrGOmxLzhwdPRIU7jND32+qQCX9lIQFZm9CW
	KQXm6fBWBj4yqiZD7Xjwuzc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dwPx533nMzLlSZ;
	Tue, 20 Jan 2026 19:19:37 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0936740565;
	Tue, 20 Jan 2026 19:23:00 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 19:22:59 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 19:22:59 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>, <zhangpengjie2@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 0/3] ACPI: processor: idle: Enhance LPI verification and some cleancode
Date: Tue, 20 Jan 2026 19:22:55 +0800
Message-ID: <20260120112258.1595164-1-lihuisong@huawei.com>
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
 kwepemn100009.china.huawei.com (7.202.194.112)
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : No valid SPF, DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20444-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BB55552769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series is aimed to enhance LPI verification and redefine
two functions to void, which is a part of the series in link [1].

[1] https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huawei.com

---
Changes in v2:
 - reorder patch
 - fix commit log in patch 1/3 and 2/3

---
Huisong Li (3):
  ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_states to
    void
  ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_dev to
    void
  ACPI: processor: idle: Relocate and verify
    acpi_processor_ffh_lpi_probe

 drivers/acpi/processor_idle.c | 40 ++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

-- 
2.33.0


