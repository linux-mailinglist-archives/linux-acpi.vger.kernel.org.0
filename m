Return-Path: <linux-acpi+bounces-16770-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E258B55763
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1077BB9E1
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B575D334720;
	Fri, 12 Sep 2025 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwO1f5+Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3B33470A;
	Fri, 12 Sep 2025 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707597; cv=none; b=U0u8XefWP7kqrnSAN4Wn6ewh8awrSYFO68LHRvLCED5rs65Jg4v0KS9WKQoH1fIsyEtLXd7JuFTn8WQwZm2JLlGAmlTjtmsJMGVAkjSE/Xmgj7yYDlYtMhHvwZwm8HHwLiWCk3y+JdpIlTUogK35MSrd5xhLjuxMn+t1yBpkSXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707597; c=relaxed/simple;
	bh=ZEV5k4lWIarWwkvDxjAHesQzAAuS/N+6kDmCL+8lU3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6n9fmiHg/vY1/Wj/eej19JjuLLaGuefnanrLwWCnh588BcptP/q1HF9qyzy8oO9FBQxOQrSUvCWqMdjzpNx9CYGq97eOqcMJjjSSyho03TwlbEVlcyQ6DXjFm/16TwTA8oRt4ghQBe7L6EsGPWJsRs0arez+z2+aGZYT90iIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwO1f5+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1BBC4CEF8;
	Fri, 12 Sep 2025 20:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707597;
	bh=ZEV5k4lWIarWwkvDxjAHesQzAAuS/N+6kDmCL+8lU3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwO1f5+QCyE2CIDwVTx7H46dwxKVR5cF/xIRlPYHXT2fh4BABTPRcRjr5wBoKs90N
	 zGC+UEPlPedJR+ag+0n0YnAFkt7dWsnCExWD4kmNrV3dVoPnCWuw425+7vuE9KUQI3
	 Kh3atY1zTdZc1Mh/+drSCTsDbRm7wFPC5eIR8ClfX70QO4T567nsFLwWVXjGzjj28e
	 UTv6OQY1WNf575O7MT4oA2Q1LqTIKAzSvIhVKbdLPWJ6VGIyxcTDGldgnOOBi9ZsTr
	 T0kwLzlMuVYYHL6bVINDBPDlPpr+v4QLmzIJL3q5yDDXRXy0ErRQ+Q0sqME9NDVYcP
	 kbIpWGXwUgAKw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 10/16] ACPICA: Update dsmethod.c to get rid of unused variable
 warning
Date: Fri, 12 Sep 2025 22:01:04 +0200
Message-ID: <1912535.atdPhlSkOF@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2021361.PYKUYFuaPT@rafael.j.wysocki>
References: <2021361.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Saket Dumbre <saket.dumbre@intel.com>

All the 3 major C compilers (MSVC, GCC, LLVM/Clang) warn about
the unused variable i after the removal of its usage by PR #1031
addressing Issue #1027

Link: https://github.com/acpica/acpica/commit/6d235320
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/dsmethod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index e707a7036802..b2f756b7078d 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -462,7 +462,6 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 	struct acpi_walk_state *next_walk_state = NULL;
 	union acpi_operand_object *obj_desc;
 	struct acpi_evaluate_info *info;
-	u32 i;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_call_control_method, this_walk_state);
 
-- 
2.51.0





