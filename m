Return-Path: <linux-acpi+bounces-17197-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30699B8F880
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA1E44E1D8C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19133054D7;
	Mon, 22 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2O1utI3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969C2EFDB5;
	Mon, 22 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529730; cv=none; b=d5vOk2uMCZvqhleS2ue0BjdWje5e8v3aSC2phXUxntV7LQysbb+SzFrtYWtECZaG4mIa29kb+kGvFikfw8f+mBaatozfqZu7JWLxpwnSpJnMeBTfxTTlGL/GlfIAlmgbyRz/tyZ3TwXc10q1jwNwGlmEUfH1q6jSAw/3HkxVG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529730; c=relaxed/simple;
	bh=Fx/E7oy6R/UrfCZVgp/oGljSUU8nvVLOsITLcZjwrgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7wA1MiFitFLC4fsSZCMo3Y9vzbBIcLZ1n/JbfRt23nGscO4nP2mWd8BhYl9Z9kOXCE7StXCUlsqg9o8Dlg0WxsiufFhu0s52DU7ed3g2QZTV9sHMpXdJytLasNPjjfzLy/oOlTooa5eWyCRnrDAoTN6EiCqeI1jdIu2pYGzYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2O1utI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9780BC19421;
	Mon, 22 Sep 2025 08:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529730;
	bh=Fx/E7oy6R/UrfCZVgp/oGljSUU8nvVLOsITLcZjwrgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2O1utI3K7Phivaz71zscKCxzb6JQLvDE3hoXpoZ2VOBu+OMSBRmIDU3O+/Doaabt
	 EzxvHROHbgcjvuw9uR09gVay4VfmVtwnYve4G6B6eBBHOdacySxILiN2IMOgA8cpz6
	 FGN3W/1+eocopJ6rARZT2hg6j9LZfiHctgX6X/HZzCjzXm3WxjIiVg4SUGPxfPCxsA
	 2lTs2HpweaDTeB5YIcPDV1xAIkg5Uoc6Stl98SjW6+Eh9L28qW23WYIY/YElg2DwT2
	 kyBSu7u/d1qDUqBdCY3SfE2M2o7e44O3Il+/37J2ABOfT/s7CrnetsbvfyhZ9vWRtH
	 AvzG3fFhaAV7A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bui-00000008Kds-3VXl;
	Mon, 22 Sep 2025 08:28:48 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v3 25/26] irqdomain: Kill of_node_to_fwnode() helper
Date: Mon, 22 Sep 2025 09:28:32 +0100
Message-ID: <20250922082833.2038905-26-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922082833.2038905-1-maz@kernel.org>
References: <20250922082833.2038905-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

There is no in-tree users of this helper since b13b41cc3dc18 ("misc:
ti_fpc202: Switch to of_fwnode_handle()"), and is replaced with
of_fwnode_handle().

Get rid of it.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 9d6a5e99394fa..5907baf6099d9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -730,12 +730,6 @@ static inline void msi_device_domain_free_wired(struct irq_domain *domain, unsig
 }
 #endif
 
-/* Deprecated functions. Will be removed in the merge window */
-static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
-{
-	return node ? &node->fwnode : NULL;
-}
-
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
 						     const struct irq_domain_ops *ops,
 						     void *host_data)
-- 
2.47.3


