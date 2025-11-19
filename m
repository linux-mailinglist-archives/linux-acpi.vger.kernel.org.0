Return-Path: <linux-acpi+bounces-19108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD8C6E799
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC386386E46
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048DF36404E;
	Wed, 19 Nov 2025 12:26:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E3364042;
	Wed, 19 Nov 2025 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555197; cv=none; b=HeYrK7VLpcHFN1LMmUyn9RWm7w5zQgPK6JdckokujVrGEhu6BNjpZqJczOUZsxEsE2PEqsPgvV0/yhdnoknOHBzlfnvDYhwRLk6OAySdq/v6+fMH0aRZ8zvsCpgO9vFfZUOp2LVuWlENSN4x8Hp+8t0y+2EzoXPHcA3bmoWetCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555197; c=relaxed/simple;
	bh=xutAoHwAMc8wBkrVhYAWzFdveOsaBR5gWS8lAxRbYGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyh8Dho1LBTtHy5sbKdKEyeeZzsB42+LoDwCJ9CcHn/gdtLj+SaqBcHoZCNiutNWx02mRYhtYCYXr/s+diaI0lsNZMV6LRn/IhAMdgxxBiV5W1DRR5/CAqEYiNhIlSqvn1uTZ33U8Ihr2nixC0yIRyZ/SHAhWqTPpaikUM2EHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52BD61756;
	Wed, 19 Nov 2025 04:26:28 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C85C43F740;
	Wed, 19 Nov 2025 04:26:30 -0800 (PST)
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
	reinette.chatre@intel.com,
	Ben Horgan <ben.horgan@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v6 34/34] MAINTAINERS: new entry for MPAM Driver
Date: Wed, 19 Nov 2025 12:23:04 +0000
Message-ID: <20251119122305.302149-35-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119122305.302149-1-ben.horgan@arm.com>
References: <20251119122305.302149-1-ben.horgan@arm.com>
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
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v5:
Add Reinette and Fenghua as reviewers
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46bd8e033042..52a3ea4946dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17463,6 +17463,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
 F:	drivers/video/backlight/mp3309c.c
 
+MPAM DRIVER
+M:	James Morse <james.morse@arm.com>
+M:	Ben Horgan <ben.horgan@arm.com>
+R:	Reinette Chatre <reinette.chatre@intel.com>
+R:	Fenghua Yu <fenghuay@nvidia.com>
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


