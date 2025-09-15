Return-Path: <linux-acpi+bounces-16967-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C23B58622
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 22:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB6624E02B1
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9528D8DA;
	Mon, 15 Sep 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypwdwx/C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F61DE4EF
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969003; cv=none; b=F4gkkCxT3uAmeMhzobX+yWpxPr4oRVdC3jii4bckJyNFt79ptxrL3rtqskFoBJKm8+PoR1BW1/2go3WKlz4tt66ZthZ6Kv0aRsBFtvYR8dv/szb6v0aHELnsaHHtmK5liBWbMQMJHLNx1KW25Zp+wo5BfI7s7XaVCyoeLK21X7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969003; c=relaxed/simple;
	bh=NqRAt4gI9f72mLXjY+kqXbLbYla/p/cdspWGOn4s0xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTIP7pWpMXNRQhTQkl9Rt1DZU1e7umIF60WCJIBSYe9wP5xVtpn0MI6ru5TcBG2rXew25bT/MhJbtDIBQH38+900DO+Uwu7X/ZWa43i4sRKWRDCi4OSoAYpBZ0gEP3vlffy2ft8yeJMl64DYOiTmE8DkE1xAbR617iJVrLgmpbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypwdwx/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F46C4CEF1;
	Mon, 15 Sep 2025 20:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757969003;
	bh=NqRAt4gI9f72mLXjY+kqXbLbYla/p/cdspWGOn4s0xg=;
	h=From:To:Cc:Subject:Date:From;
	b=Ypwdwx/C7PQCfKuWRU/pvxWD7fBkRsSmxwg5cMFoEup0Mv7KYgMlhNAtqtp+59vfS
	 u7mgR8YxAUttrDUltmW8+QgMUau2yvC77PPZ2qItP3b0bzyRGJTaE9otTSfePh6JkS
	 2mkit1YkENg6hZ4Ou9tRroaI+ILRPk25veHTpaxzO6U7ZrENBaHEocavyc+OhENeWT
	 SdidzcmlLPiQDDZPmJZ/ozg8uArA29HqiaAfiDsBNSYnM0mP8olQZHx2QU/vr0eZZF
	 XytNbmeEQ+YwBG8sjUbrN8kKYkAFtumargYQ2AD2SuGFUoUpiziVhxK+f5Y+FwHITp
	 H45qUBdHxs9xQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-acpi@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 0/2] Add ACPI C4 support
Date: Mon, 15 Sep 2025 15:43:15 -0500
Message-ID: <20250915204318.696058-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some AMD systems have introduced support for ACPI C4.  Systems that
support ACPI C4 will enter CPU OFF at ACPI C3 and VDD OFF at ACPI C4.

VDD OFF is a requirement for s0i3, and thus if C4 isn't supported then
a system can't enter s0i3.

Add support for ACPI C4 to the processor idle driver, following similar
semantics of ACPI C3.

Mario Limonciello (AMD) (2):
  x86/acpi/cstate: Remove open coded check for cpu_feature_enabled()
  ACPI: processor: Add support for ACPI C4 state

 arch/x86/kernel/acpi/cstate.c |  2 +-
 drivers/acpi/processor_idle.c | 10 +++++++---
 include/acpi/actypes.h        |  5 +++--
 3 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.43.0


