Return-Path: <linux-acpi+bounces-6479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7246A90CBE9
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 14:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A72A1F21884
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7164F15250C;
	Tue, 18 Jun 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0szao9E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292C13AD1D;
	Tue, 18 Jun 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714194; cv=none; b=BCuPRGT2v6az603NCuB6HfM5ou9FkrOCl/IFpZfRIPtt1uQVlqfHj9BSu2Wsi0iq8Hvh5g3sOZbk/9462DXRVwsEi9huSNlnCcLwNh4EIp2v1Xp0F3yf1uWODyV5ib1dMUcs6sWKfmtr6CRcKF3k6Wr5nRxjavro15q8KWshIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714194; c=relaxed/simple;
	bh=3yUnpElq9u7aPprB66sDbl2RJ/X8Tv4IQRyVXd8wZi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGQIL5g733Tt4oDy5XlFyQXcFZWkZa1crSO3oCy8Va2w766almGB8Xl5tMTj1B/Fad5i7bA9N9We0QmEhPhs4AAu72vwSFvXaTlEoKzgtwakTIOaOB0dQcfDbVh5Xl0CaJbCq7H42OpLsWu2DJ6HHn+Y3tq+OlhpTpq3NYaHPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0szao9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF9FC4AF50;
	Tue, 18 Jun 2024 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714193;
	bh=3yUnpElq9u7aPprB66sDbl2RJ/X8Tv4IQRyVXd8wZi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m0szao9E1e9Jx7sqomOR4u2/N8kv58eACPRGj0D3azEulY5bQcWoT3fF5Hdmem65f
	 XL2z6IrpJcuo60NE67nuenIpYwptZrxyonmk9XrC5ooqat1Zl83+OSXesObRuWj0X6
	 wZXhd3/ItWI0klYp50gxVGZT0iSSCmEItciZ7LX2pEOs1/3qIOHwR2Qhb9m/cIW2Fl
	 IQGuaRI2m1Ez+VGR8/K2XTk4eUIRknmo6SVogUvaHlh+IxgT0yTFNu4sacd3HJK/hb
	 PBfiazE+CmsjtAhs542hz4HkjJ9ZmJU0KYVWIJmj/Hdcwv1mJaC1CCJDza0RIkWTlx
	 /dybUF3Phl38w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 12/44] PNP: Hide pnp_bus_type from the non-PNP code
Date: Tue, 18 Jun 2024 08:34:53 -0400
Message-ID: <20240618123611.3301370-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
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


