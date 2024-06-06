Return-Path: <linux-acpi+bounces-6221-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559AC8FE8A1
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 16:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D80B21CBD
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F31619753C;
	Thu,  6 Jun 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVBhg3Zk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0D197534;
	Thu,  6 Jun 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682917; cv=none; b=qnQFLd7+cDq34KkDtR+dTAH6jkJRlyV+vs3HCFnNJM1dehvh1VAnxlyFmK+ReJqTJJykDyipsjm6q+Z4CiCckawJfUyPKYiyvPqxQV00y3SnU0sa5N3HYxveYnm4ogUSuc9rm2kZVrn0iDNsmVhvg78Z5JDXro8zyUZB/vQ3kd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682917; c=relaxed/simple;
	bh=gwBxuAl9XIkvDtF0BsEAr+TUf8kHo5riTQFuFZ/JSvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9IlFuVE5BveXPXtofvLHVQwkVKLDPMIxYT+2PQfxjc9lT+ZZgryIwzFEYxnr66SAvbnO6yiYHoqGct8eybLysOSFiksRLBGcf4c9OqWirnPfOgF0bJBtwmBngUsV/vrV8CJUY+07HKxQyWAa31r/MAZohb85vlFADuTXYahH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVBhg3Zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CFEC2BD10;
	Thu,  6 Jun 2024 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682917;
	bh=gwBxuAl9XIkvDtF0BsEAr+TUf8kHo5riTQFuFZ/JSvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVBhg3ZktcEeOYyMg3lI/0HzlGFkPkEiEwiJaR49lvwWi1lydP6lp+f29/xAYerdC
	 nLkUPnyrRdnu9+qima359zv/47qlkjLJnoP8ZAPUEn+1kgpmzgrb5wMCIIbX8cmJl7
	 10JAjY465d1iKnZ7pZNZjBRd/VcChePEjAtqH2JY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linaro.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 049/374] coresight: etm4x: Fix unbalanced pm_runtime_enable()
Date: Thu,  6 Jun 2024 16:00:28 +0200
Message-ID: <20240606131653.457872907@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anshuman Khandual <anshuman.khandual@arm.com>

[ Upstream commit caa41c47dab7e1054f587e592ab21296e3a6781c ]

There is an unbalanced pm_runtime_enable() in etm4_probe_platform_dev()
when etm4_probe() fails. This problem can be observed via the coresight
etm4 module's (load -> unload -> load) sequence when etm4_probe() fails
in etm4_probe_platform_dev().

[   63.379943] coresight-etm4x 7040000.etm: Unbalanced pm_runtime_enable!
[   63.393630] coresight-etm4x 7140000.etm: Unbalanced pm_runtime_enable!
[   63.407455] coresight-etm4x 7240000.etm: Unbalanced pm_runtime_enable!
[   63.420983] coresight-etm4x 7340000.etm: Unbalanced pm_runtime_enable!
[   63.420999] coresight-etm4x 7440000.etm: Unbalanced pm_runtime_enable!
[   63.441209] coresight-etm4x 7540000.etm: Unbalanced pm_runtime_enable!
[   63.454689] coresight-etm4x 7640000.etm: Unbalanced pm_runtime_enable!
[   63.474982] coresight-etm4x 7740000.etm: Unbalanced pm_runtime_enable!

This fixes the above problem - with an explicit pm_runtime_disable() call
when etm4_probe() fails during etm4_probe_platform_dev().

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20240314055843.2625883-2-anshuman.khandual@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c2ca4a02dfce1..06a9b94b8c13e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2213,6 +2213,9 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	ret = etm4_probe(&pdev->dev);
 
 	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
 	return ret;
 }
 
-- 
2.43.0




