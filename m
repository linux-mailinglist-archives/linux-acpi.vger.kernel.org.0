Return-Path: <linux-acpi+bounces-8550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFFE98F904
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2024 23:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056C928271D
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259E1B85FA;
	Thu,  3 Oct 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIhrxgwH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB7748D
	for <linux-acpi@vger.kernel.org>; Thu,  3 Oct 2024 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991495; cv=none; b=q6iWcvlFaW7LriIPJfa0HFm5d8TwL4wt1gJIMgVdpZQRYhGQ7MSLy+XCb3/u/6kbW9KA2rLyU4m4f39x4VVc+oNAIRaE+OynPGXsQe2d30HuimqH4p1UqTP7cch6ZmJE42DtVGJBCmnq79hkOsCxUqrw7t+QOkcltCZ75Sp7yRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991495; c=relaxed/simple;
	bh=/QJELql6ZGxKq1+b2fvQoOEmGBH3v38jarpB8mRF9OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVWSOoqxLOSy+pZy5PY4tJO40YycKTk8SZ9HM/7LUtXWW50isnzqSuQoo84JD7VYmLIReMC/wNtTg5cPaaeInCM/MWSGnEm2Fn7FeE0uM7PYnyqrdDTp27oqPIrlsGJhMJ/l3F3KWdBd9iVQfB7tDOJHn++Ykr3hT7aUyqZLS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIhrxgwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B817C4CEC5;
	Thu,  3 Oct 2024 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727991494;
	bh=/QJELql6ZGxKq1+b2fvQoOEmGBH3v38jarpB8mRF9OY=;
	h=From:To:Cc:Subject:Date:From;
	b=aIhrxgwHol8KNWQqp+CnMF+z3EC23mQ7+uUwkEbol3JPoYnZ1dREbOfcfNzsdvU+u
	 ESM31PIF7bX2w3F9b+/fH4VM4Z/2360wLgxWEx4pe42yLMVwNXYF33Xi7AFMcCvK4a
	 xdeDWGKX2OOXXLGBxW83FQ4VJr4PE0aNUsbjIZLSbatV2HFdjZaSamXNYIiwldv+TN
	 oMN29l3kmQQCXqjVNFIjYfNIzU2AIsd5xFcb0+GfAculRgpZvFV4sQG7YMsVS2fgW1
	 F1EgSbrP3kI6KucVpLV9ERvLtCRNCmdr3QijxjegM8qSpJjKH5lq9Jo5WjNihVmRb+
	 KcNAQop8X9sJw==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-acpi@vger.kernel.org,
	Perry Yuan <perry.yuan@amd.com>,
	gautham.shenoy@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Detect max performance values for heterogeneous AMD designs
Date: Thu,  3 Oct 2024 16:37:57 -0500
Message-ID: <20241003213759.3038862-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

AMD heterogeneous designs such as the Ryzen AI 300 series processors have
multiple core types that can reach different maximum clock values.

This series uses the CPUID Fn_0x80000026 to detect such designs and to
correct configure the boost numerator that is used to calculate maximum
frequency.

Mario Limonciello (1):
  CPPC: Use heterogeneous core topology for identifying boost numerator

Perry Yuan (1):
  x86/cpufeatures: Add feature bits for AMD heterogeneous processor

 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/processor.h   | 13 +++++++++++++
 arch/x86/kernel/acpi/cppc.c        | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/amd.c          | 29 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/scattered.c    |  1 +
 5 files changed, 74 insertions(+)

-- 
2.43.0


