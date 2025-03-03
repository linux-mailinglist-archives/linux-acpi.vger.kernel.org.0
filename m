Return-Path: <linux-acpi+bounces-11705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FDAA4BCFE
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C39D1894333
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DDA1F4CA3;
	Mon,  3 Mar 2025 10:53:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E61F4612;
	Mon,  3 Mar 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999212; cv=none; b=BAx7WJS2zpaiJ+eqviDU00xls/mXGbYJBdIr/lbBLTNvCPaUljjLCfhwdwRq3g+OKOIBcLl5yJHIXhEF5CDqaGJxUv/b8naCykDR2tyAQWT++bCN36Pi103WHfgfHji6vd7fChsXcK04+CjuD5+lmkfTj7sXLGNRLGrpyTLOQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999212; c=relaxed/simple;
	bh=O8K+rZOv1/Prumcjvh4fIrLAL9Wzi6vTqYxlPROPsC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIWBL2sdqhR6cNKz2f8k5artyDjCHOr58P1ZWzyLFWPY12z3TRghgRkM0glgChzRQBeMV/v8yD9euXj96JeL7MW2/bTcQiIT2W/c14WZgCehKd9TfFJZCMKKHtNYe9f1/JtT/I880dippXuO4Bh6WrCyB6djgWaUGUxV1Prn4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C2F201B;
	Mon,  3 Mar 2025 02:53:44 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57F153F673;
	Mon,  3 Mar 2025 02:53:29 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:39 +0000
Subject: [PATCH 04/14] mailbox: pcc: Return early if no GAS register from
 pcc_mbox_cmd_complete_check
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-4-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=O8K+rZOv1/Prumcjvh4fIrLAL9Wzi6vTqYxlPROPsC8=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYohO+Y6RtnbnszCpmHOp8UFVnodS2rsHRvYM
 HTmA3B9HtWJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIQAKCRAAQbq8MX7i
 mHIvD/4vfequNLXQsT0Ebinanwzr8OlF/wCGk2cGB1OiydeQsGkbOBvPoCfxpEZhH6b7LG4WUIT
 yFEOMkEKFjns9ebcm+uFinsMnY88q4HibgxCxEGhaUN1jNMrvSvXjAzPp00wPQySLghHdlAQ/Iz
 3L1gizJt+y71i/tDp5rW8iB+lxExyu4hylHyzkX3i6lk+J9mHJVnSVrYcArcZHzNC9KUm1Jbheq
 Bu7vi1YIy75IT9X+3qAKtUTx6Lo0BL71Lfw9UOP14cEu3LiP+n4K/UXG37W23YcB3s+JeV43kJG
 Sd5QvxVWwHkh6ClRdwnzsz8qbRnAF3lEEtRdNdsZndmoPAJwVqlnHeYdy+kndtlsUvK6+6honR4
 CTdqauqTowjYp5wxwYz6/7qgWreL5yU2zwgNmRgam/sWJn4aXrbM96nsAQwn4fASuXnaeUlwr/m
 4Z0/w6207EKxkvGDnu21Tmm31G2t0l6/ndHfqTgxnVID/saf+kWx0tsx+BDeB8LGNXzm0wcPzQX
 VOZ25vMo8lP5ptJhQ6ihXmseviriBpuPMrCThMPfCaty7LEv9Xc/MPVNM0FI1WjVfVit2/1JXkL
 soagGw8OQozYaLdtpcPhh0UqeLl65SXkvrZykj6cIMvoX2qQ3a511VmsNlRby4VKEmkVk63GP8r
 bhj1hkLsIXjlabg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

pcc_mbox_cmd_complete_check() accesses pchan->cmd_complete.gas to check
command completion status. Even if GAS is NULL, pcc_chan_reg_read() gets
called which returns success doing nothing and then we return.

Add an early return if pchan->cmd_complete.gas == NULL before performing
any operations.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index c87a5b7fa6eaf7bcabe0d55f844961c499376938..98c99f0e24c4a654a8f4835063f5a479a433c9a0 100644
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


