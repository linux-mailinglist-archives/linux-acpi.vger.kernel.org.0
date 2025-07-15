Return-Path: <linux-acpi+bounces-15166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA3CB05B86
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 15:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C29C565DBF
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A3E2E336C;
	Tue, 15 Jul 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrQPHGxm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA741991D2;
	Tue, 15 Jul 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585632; cv=none; b=On+Cv6LhtrN3qVCFfV/LUhIx+FECDGCeyK1JgHle0j9H+y0HjQNaQ4IAIZb+Ux7AMSZiheX0tYQCBwK7WY5QDTJbZ+WszORfQEeydO1iVYpcGjKvt9Lz8VeY3zJOnWXXq985BstqFxgXOQ68GkUQ9d8Q9VueBRsB5cqjJBsVdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585632; c=relaxed/simple;
	bh=GiiQrNSfIN18Nm0LlMlytEGfkMtV/5hh2debKrjaslI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WqoraRM8wzoDjgfmxUYPJkagrDVaiPBXeZnsvCHoozbVCscqdMCD9xYL76t5DUhIeqDKajRGUZMoGm4liN0QVK7Wcw2KdUzTNP//tvfLBttYF24SsOws4rzrOiIhVPGWWMIiMLM1T98tGw2AzIZ/XA98iKooUp7RedH+XtEu+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrQPHGxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B5C4CEE3;
	Tue, 15 Jul 2025 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752585631;
	bh=GiiQrNSfIN18Nm0LlMlytEGfkMtV/5hh2debKrjaslI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZrQPHGxm3S7GSJC8WkXhaJ03fnq7DSja70zwegO49ygawI1kwnl1UrifAVQyNjF1O
	 AlbR9Wpw5pKuJirQ8o2xppMIIXaDXgLyhtXIPYSkkZCCtg+Rp7ZikH6TprIyV5FATw
	 vgpwXA4vHyrVWGDx4uYLtr8iHv9DnuUGhQ2PuOO2zWrRm35jLb7KqySaugXwoIZq3k
	 04MWZrsOwzaTxnE350YWoOV+NuPrAHzMtcQwTeY5dDzi5ut7mbPgUpBJQSpofj0TIL
	 Ihd1oSVYQA91nHppBhdqxjdJCTDhrtARhIMrhnzl8480HTlcBMFcsvWMQf+xyXm+g3
	 NgalbFHKjzM6g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v1] ACPI: APEI: MAINTAINERS: Update reviewers for APEI
Date: Tue, 15 Jul 2025 15:20:21 +0200
Message-ID: <12722151.O9o76ZdvQC@rjwysocki.net>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update the ACPI APEI entry in MAINTAINERS by dropping the reviewers
who have not been responsive for over a year and adding a list of
new reviewers.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The new people in the new APEI reviewers list, please send your ACKs for this
change, thanks!

---
 MAINTAINERS |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -306,10 +306,11 @@
 
 ACPI APEI
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-R:	Len Brown <lenb@kernel.org>
-R:	James Morse <james.morse@arm.com>
 R:	Tony Luck <tony.luck@intel.com>
 R:	Borislav Petkov <bp@alien8.de>
+R:	Hanjun Guo <guohanjun@huawei.com>
+R:	Mauro Carvalho Chehab <mchehab@kernel.org>
+R:	Shuai Xue <xueshuai@linux.alibaba.com>
 L:	linux-acpi@vger.kernel.org
 F:	drivers/acpi/apei/
 




