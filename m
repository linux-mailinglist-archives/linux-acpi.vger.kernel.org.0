Return-Path: <linux-acpi+bounces-18965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7053FC655F0
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 60B652AD69
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052533D6C7;
	Mon, 17 Nov 2025 17:03:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36833CEB7;
	Mon, 17 Nov 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399015; cv=none; b=P0y3JrZQ/F+7kWvtUdNh5bjNR+wZxYL42pP4TGz5KGc3uisfJT3GLYJj36fxFbYS3QDs9YKUq1Fl1b23ri/Iw7WRcQBlABHNLYN3NU7Z3A9b4IbY4izyxrbnmmr3RZPtTaWp5xDVj/WL5osJbKbykyNDz36ceojG6oMjB44KEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399015; c=relaxed/simple;
	bh=ucWQydty9o0LyCaztzoBzlJ3gVnbJQs2+czmYXNEdmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOtlga479hT25HwzJWegbwU/rYaDLJIbzqynMN8TuNtT057v3ROddkMcxRWgOGBZNvded/9Z5jfUdAjy3OqUokAoSn+P1fcWMO2SRWgOKomm0NcPC9r44dAWPnXZVjIMxFipQ9e7QhVmEzV0kpkZ5ivWQHN99IVj67+AzXz1CIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4337F168F;
	Mon, 17 Nov 2025 09:03:26 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02CA83F66E;
	Mon, 17 Nov 2025 09:03:28 -0800 (PST)
From: Ben Horgan <ben.horgan@arm.com>
To: james.morse@arm.com
Cc: amitsinght@marvell.com,
	baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com,
	bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com,
	catalin.marinas@arm.com,
	dakr@kernel.org,
	dave.martin@arm.com,
	david@redhat.com,
	dfustini@baylibre.com,
	fenghuay@nvidia.com,
	gregkh@linuxfoundation.org,
	gshan@redhat.com,
	guohanjun@huawei.com,
	jeremy.linton@arm.com,
	jonathan.cameron@huawei.com,
	kobak@nvidia.com,
	lcherian@marvell.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	peternewman@google.com,
	quic_jiles@quicinc.com,
	rafael@kernel.org,
	robh@kernel.org,
	rohit.mathew@arm.com,
	scott@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com,
	will@kernel.org,
	xhao@linux.alibaba.com,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v5 34/34] MAINTAINERS: new entry for MPAM Driver
Date: Mon, 17 Nov 2025 17:00:13 +0000
Message-ID: <20251117170014.4113754-35-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117170014.4113754-1-ben.horgan@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a maintainer entry for the new MPAM Driver. Add myself and
James Morse as maintainers. James created the driver and I have
taken up the later versions of his series.

Cc: James Morse <james.morse@arm.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46bd8e033042..ec9b2b255bef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17463,6 +17463,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
 F:	drivers/video/backlight/mp3309c.c
 
+MPAM DRIVER
+M:	James Morse <james.morse@arm.com>
+M:	Ben Horgan <ben.horgan@arm.com>
+S:	Maintained
+F:	drivers/resctrl/mpam_*
+F:	drivers/resctrl/test_mpam_*
+F:	include/linux/arm_mpam.h
+
 MPS MP2869 DRIVER
 M:	Wensheng Wang <wenswang@yeah.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.43.0


