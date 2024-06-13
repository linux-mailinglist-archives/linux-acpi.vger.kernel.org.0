Return-Path: <linux-acpi+bounces-6372-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4DD90716F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E8EB213FD
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B335384;
	Thu, 13 Jun 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u/CcFr7R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA9161;
	Thu, 13 Jun 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282215; cv=none; b=ehCVCdNIjzJxydp9bzYVgGpgKjxksN7mgyC2eqa7f13ykXKqWeWUBlfwJjGgW5ulerr0QZOoWTL0z7zj+vq1BjGRmGiuOEyXdWDbUghNMagmKtnWIuBryUOFiGhKE+ATYDq4kzu9KdFq0M7Lx7KYb+Ej8RIl5SICDorLwaYkAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282215; c=relaxed/simple;
	bh=Lmm6tXZTC3jIXcaeCEEA6/VnvpVEp8ej1EHFZPnras8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s29GCX9WeIuv1x8k7F/cXyoPTELVD2QH1tIGgM4iA5FSHPo3xCTL010BzZ9EfdqVNjraajjAvpWsLMSt3rQAJHXj378//DMTGakQNufWOl+qhKYhQPv+lpWG5MtxppNSRVzEixDI6qU6TWN3xRJwQ3T8ni08iu45vtLvQT1k+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u/CcFr7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0997C2BBFC;
	Thu, 13 Jun 2024 12:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282214;
	bh=Lmm6tXZTC3jIXcaeCEEA6/VnvpVEp8ej1EHFZPnras8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/CcFr7RwuSDJy+zhhOm7Q8n2xy5ztaLRtei9DJSLtLt4wv3dO4EIV8OVflFUTDfb
	 z1AaDGsF9YaBEP5a1sgqjKC75vZvl6FqvMNwdE9JLRWTv0q5r+g7uM0cuSoPWfH0sT
	 noqGzhKf4d+nRaRIG+v8QVzqjOMNwsWFLuBQqOms=
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
Subject: [PATCH 5.15 201/402] coresight: etm4x: Fix unbalanced pm_runtime_enable()
Date: Thu, 13 Jun 2024 13:32:38 +0200
Message-ID: <20240613113309.983930117@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 26d0d4485ae99..3f5e9400222e7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2022,6 +2022,9 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	ret = etm4_probe(&pdev->dev, NULL, 0);
 
 	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
 	return ret;
 }
 
-- 
2.43.0




