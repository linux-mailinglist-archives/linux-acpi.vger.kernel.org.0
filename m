Return-Path: <linux-acpi+bounces-17998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA91BF13F2
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC887425591
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF732142E;
	Mon, 20 Oct 2025 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bupIhxnQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1390320CD3;
	Mon, 20 Oct 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963417; cv=none; b=MhZB0r5ttuwsjC1dFiiGXjSL/T8L16xbUArxT/MHCHusMpBwzI2DDhf9GmJ43Ge+JToUjfqgEQEmmmGHzNOxTsw2T+t/+eLV79umK6e0Bwqo4LFazgS5C5+X3mOvUqN+ENhU/joMBsirDvCuFLPE6wzhiP4vZM5xkYJyrkcq20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963417; c=relaxed/simple;
	bh=KFo9i6r6U/JFUE2elWOLNVjZ2iw4+N5AISZt4DbS7Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duls5C4kwLDL/fchG/UP2MhfwMlhYmaD+oHzd1wwtx1BvZod9A4N+aNitTgbMqHKAXH8MkVSp1IL5VHECTQ5OGZdrtudXUkgLBc+leMUjXR3zRQfqfPi1RCMW++k+xT0ckVJaI+srwu5HEMNH+CaxSQcr1bbnsRVhuz3kLxJ/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bupIhxnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2297C116C6;
	Mon, 20 Oct 2025 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963416;
	bh=KFo9i6r6U/JFUE2elWOLNVjZ2iw4+N5AISZt4DbS7Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bupIhxnQIKiXor6iYFfK547TwX0NFDQhvmyIW0bHc4SADgKdCPYduSw+HL66ASY4G
	 t7ycP3Z63Ogk7tZudbD4I0QcMop9dq63ScqLdnrF46tTwHBy+1D5RzlhH/B4cJfZ0e
	 +YvTEaILplNWiHmC8/t+ncceUGIk2VFnkiIr/g72K+djU4pr88qPu1Qog7Wmqake/c
	 +Hu4Fksc2Wpf/NSZeAImKwvWLy3Frrmce1aNfGdRZ87+Rscyb6y8kl9bfbk97MBW1O
	 3qlKaihHY+ThXQb000EyLJE+UQ19bDTmtp7WnO044o4V91uKwFw4oYhJVQDnOcS2nw
	 ozurH7CJ2LC7w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1j-0000000FUu2-0AXd;
	Mon, 20 Oct 2025 12:30:15 +0000
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
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v4 25/26] irqdomain: Kill of_node_to_fwnode() helper
Date: Mon, 20 Oct 2025 13:29:42 +0100
Message-ID: <20251020122944.3074811-26-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020122944.3074811-1-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com, ruanjinjie@huawei.com, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

There is no in-tree users of this helper since b13b41cc3dc18 ("misc:
ti_fpc202: Switch to of_fwnode_handle()"), and is replaced with
of_fwnode_handle().

Get rid of it.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Will Deacon <will@kernel.org>
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


