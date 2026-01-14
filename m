Return-Path: <linux-acpi+bounces-20293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3050D1ED71
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51855304EBE7
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D439903B;
	Wed, 14 Jan 2026 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDmEQ7H9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1574399023;
	Wed, 14 Jan 2026 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394493; cv=none; b=NjTivacGLyviPMveSPA3LqsGxurmmwHsexLnrPHs+fFRLU2hGw6tfzJa2KuR8abKDwp0KGFwAYMJtj/0EqYsMnw+F5R+sJgfwK4h8g9F35I5bMHHpzWB6AXqp1m3IUCYittXN1lLqe9fZD7gqpqOs0PRr2lMNx6P1mU2vrsXtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394493; c=relaxed/simple;
	bh=MUq3hqahpSedttl0smZUroyuM0jjIWrczEJxvM4D7HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5AtGGT3s8PzPjc2MYvRnzMdTJzEoH3fBta68eLg6CLJnp/zSv411FVW+7dMEJrBP0yq+9m1YiEoiDGusuxA0yOZUyf/mvwvnU/oVTygr2YTGOaFIvbQsY0qX0rN4UP2gpnEC/zYvG4pQDhEYsRq6FiJ6tSwA9Puf5AW49x6kiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDmEQ7H9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F69C16AAE;
	Wed, 14 Jan 2026 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394493;
	bh=MUq3hqahpSedttl0smZUroyuM0jjIWrczEJxvM4D7HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDmEQ7H9gVxLV6yGKLc1ggRk2yWzmK+/5Mxj6j1FtWcOQ4D7TT2hAnQyn1JBCJ0JZ
	 CaCHzY+oF7462f6kf41cEMajZtf9o1AualbMhDQpnU6r4HveJR/w9OWz89XIkzmije
	 ahWAjoisVTmv1PbJmi3z+HRmDNqHYhT8K+mk6qKvoQ/Mh2TOOlzE/GhQbQrc3CyFQp
	 DiaMH0BzM9lxt3bJ18hPHRxHArebRl7/RdaoLHpiGq1yIntv9HEjzKC/ShK2xINRcF
	 pyyH5AjHjoVJFz7oUJwc42eh3pDjNskcQ3xnUgD+WBYanOEc88SdUCCxRu68FENcAC
	 M6oPEzTGMKJnA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 24/26] ACPICA: Logfile: Changes for version 20251212
Date: Wed, 14 Jan 2026 13:38:12 +0100
Message-ID: <15657187.tv2OnDr8pf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Saket Dumbre <saket.dumbre@intel.com>

Link: https://github.com/acpica/acpica/commit/446be438238e
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e65a2afe9250..49d1749f30bb 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20250807
+#define ACPI_CA_VERSION                 0x20251212
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.51.0





