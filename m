Return-Path: <linux-acpi+bounces-6450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57190AF3F
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9471A287B0D
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EDD19FA64;
	Mon, 17 Jun 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4ATD+7L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A819EEDC;
	Mon, 17 Jun 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630468; cv=none; b=pv81uiRLOc9bRx2Wwx5o6RB6OlvIf3lE/YCLvdd0FtKz9mQVI9KrrGUojEqLljIIrlg8bI6RIFvOBGLHGvlHSLVs8CmB3HK0Xi308ixMsqtwEIhgA698N1fKz3dPVFQ1MCm4RcRagA0iQ4MFN/K/a7iKSwWuHXgrfHsgnrBxcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630468; c=relaxed/simple;
	bh=3yUnpElq9u7aPprB66sDbl2RJ/X8Tv4IQRyVXd8wZi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2JayCfezPxDOC3E2LWHjZ+A2R0BiBxHLxpKESVDna6qSfgz5vaYYk/o8xx5hDbgtO7Y4tuaJYieei/6WShlGpqMpgCN9846pia5Jxy5Kz0DSJzFVen8sBtIPymxyZHsoS+9DuQmyWq2YOQlOBgN9EiN+rLkPGU5KlbVFgyxp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4ATD+7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56BEC2BD10;
	Mon, 17 Jun 2024 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630468;
	bh=3yUnpElq9u7aPprB66sDbl2RJ/X8Tv4IQRyVXd8wZi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4ATD+7Lay/3mIbsRu49zUktvifBvKu+fmSxw8VYWPGrGrJ6blWjVAVA0mVivx0So
	 VI94ROIYHTS2r6cu/pEL3/VesRrTJXQDs/1awfuXgqCaN9/ojHAnl+hxniRB4d5+kY
	 Chv7sVQolW1W+7Zpizbv9atzQbXmnrg9uhNj4SKNKdhH89CPW9KYOjgSCwiqPAtwqy
	 /6yTJfcy7Qlg9P4YxsvgbBlZiEsDG0IN4CBA1XR4hSd/Fz6lig6+oyC36K8IzDG6gE
	 308kg4G4e6HsEpxZaWbdhj3G/waQwI5mfOcI1bS/zuFhN1obt2NGlpBRSFibGN/+uz
	 rS3F3HAhov3oQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 12/44] PNP: Hide pnp_bus_type from the non-PNP code
Date: Mon, 17 Jun 2024 09:19:25 -0400
Message-ID: <20240617132046.2587008-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andy.shevchenko@gmail.com>

[ Upstream commit edcde848c01eb071a91d479a6b3101d9cf48e905 ]

The pnp_bus_type is defined only when CONFIG_PNP=y, while being
not guarded by ifdeffery in the header. Moreover, it's not used
outside of the PNP code. Move it to the internal header to make
sure no-one will try to (ab)use it.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pnp/base.h  | 1 +
 include/linux/pnp.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index e74a0f6a31572..4e80273dfb1ec 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -6,6 +6,7 @@
 
 extern struct mutex pnp_lock;
 extern const struct attribute_group *pnp_dev_groups[];
+extern const struct bus_type pnp_bus_type;
 
 int pnp_register_protocol(struct pnp_protocol *protocol);
 void pnp_unregister_protocol(struct pnp_protocol *protocol);
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index ddbe7c3ca4ce2..314892a6de8a0 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -435,8 +435,6 @@ struct pnp_protocol {
 #define protocol_for_each_dev(protocol, dev)	\
 	list_for_each_entry(dev, &(protocol)->devices, protocol_list)
 
-extern const struct bus_type pnp_bus_type;
-
 #if defined(CONFIG_PNP)
 
 /* device management */
-- 
2.43.0


