Return-Path: <linux-acpi+bounces-11844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A472A50544
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FB91883500
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01282253335;
	Wed,  5 Mar 2025 16:39:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B7D1C6FEB;
	Wed,  5 Mar 2025 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192745; cv=none; b=G8CXQUmXcz2xlzYjFTA65FDwlpCN9QBvnfHwyYNfg6Le+ZeQV8Q9luTiME3kjxUY6l8qeeiLsHlCeV0F2Bo5OGAefH6JBx/x3a3vq/dfPxKkjo+hnnNonDcue13oQerE+jCManJTRGRYH0VDqK/Mj8P5bWcvzRIaTC+gdsOU7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192745; c=relaxed/simple;
	bh=u7IOglKs+EyHqGuH1VZb2e5m2zCVGlEZYh8pGjyJYA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6TgymWkpYI3q2z8rRptMZUM4N6Z0kUL2pkBTrMrgFL7VMTxtX0J6EbiyhJ0Wo8gb5PR6CQOK63FY/IfivQXB9ybSyuwqWUOpqIyTqRO9Jgp0HOEYL1FnmQ7ef6qJMOTojpylSenpRqKCz07ZBDJQ3MEjLuEnxp7qK8MYxNtaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 894981FC7;
	Wed,  5 Mar 2025 08:39:17 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 219703F5A1;
	Wed,  5 Mar 2025 08:39:02 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:08 +0000
Subject: [PATCH v2 04/13] mailbox: pcc: Return early if no GAS register
 from pcc_mbox_cmd_complete_check
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-4-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=u7IOglKs+EyHqGuH1VZb2e5m2zCVGlEZYh8pGjyJYA8=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4fZ6fdf+KECuKLt/Z7eiJPtCHzqYSSOa+iD
 1uh6RheShaJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HwAKCRAAQbq8MX7i
 mDWlD/4sL2iQEquO9LaTH/+dIxXIsWMw3la9ywEN4szrwY1s+1AuFbzueDBQ9rLQkbqO18ycCFS
 fD75wZguLr/tc1AGsjGhZpWVcJwakpPmOPJ72UdbvnW8qgnskzG8D5vw0B1/3Gq3Kubb7Xuoa+y
 eKeh9OAK/JdFhEIewaOZhYICQAQZMMOu4/ASOZ1lDzx4gWug6XMqYxKZ/JpsRq2FcwcfX2Sr6/L
 XpmUUyXFq07zsN8BgLzg8xW+TBZVU+cf1hn31XHZiUUJw1jJlyAPonCNZwXNTdokeJvaBO2Xwnw
 ZUzI/1EQjTAwWMoMtzvEFT6a7k/hOPH7NmO4utD2VawvzoU/uJ6DGOTlGA8vry8KaRoMHsrN84L
 +S8pzii3Bavw0uNPK5FQmlZIIghSqXq0CYOrjp/Vjq2/zNS/k3OwlO6Mnhinz7Knyeink91nJhu
 azgmU9bhUfwdqxBhK4XKSkGLKJh+tRCiyyV7sHKtCDpyfDcrlM5++PiBWd4yeCmud91NqcW7aqa
 fAZrvq1SC2So7uJiYGTmiZjM7RdSmduwBKz0P+VZxqCbDGl3L+IlpLgAsskEzvZKaaPaLux9VW6
 lvAwYnaKIILHVr5Pad7KmDsKL7S7u7cxKVpiXmg7nnTv+Jh35rkWvgHRyAaQR0bQ2yEMUqmGsbf
 eg1hYUA1rNTnfwg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

pcc_mbox_cmd_complete_check() accesses pchan->cmd_complete.gas to check
command completion status. Even if GAS is NULL, pcc_chan_reg_read() gets
called which returns success doing nothing and then we return.

Add an early return if pchan->cmd_complete.gas == NULL before performing
any operations.

Acked-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 42dd405482e407cf90e66917a46fb8e350e0eeaf..5a9ae67f5c50a3e43d30aa368c31c80b81db01f7 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -245,13 +245,13 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	u64 val;
 	int ret;
 
+	if (!pchan->cmd_complete.gas)
+		return true;
+
 	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
 	if (ret)
 		return false;
 
-	if (!pchan->cmd_complete.gas)
-		return true;
-
 	/*
 	 * Judge if the channel respond the interrupt based on the value of
 	 * command complete.

-- 
2.34.1


