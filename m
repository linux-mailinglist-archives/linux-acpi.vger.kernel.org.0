Return-Path: <linux-acpi+bounces-20299-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFDAD1EDBC
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E839303FCE0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52B39B480;
	Wed, 14 Jan 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZxQDHOP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697239A81C;
	Wed, 14 Jan 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394514; cv=none; b=ADvLuKQ0qQ3TKo2gUbKDT6V4r9v6vYGZnY7BO8WItBZmxjwvCT/vy+pmLRen4ekEaqywwursv1HOAoMk0OXmMCUZ7LkYdXg6hlxOtFU+/l9tYkZ1/oqbdHqL/CUGiCjmoOoFO785LgCUfBvAIGIsf3ykNkyhvvLIZhigX6DxL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394514; c=relaxed/simple;
	bh=SDJNf8hpOkZD5A7qBSScNEJBf/xxkI1GcGJlh9Tt6Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4Hc3CQAS/0ctfPXfMrFTC91zSnBTqom3UADKPZ90UU1BWLBJFkGpKOkA4S2XiINwVh3Cn3uAGglL0MNXPAppbOcTEeGQDQydzCDwJuOIA1uDOgp98DpxANsEa+fM/+2K+A0Ahs4HmT5/MV8y7mg486f3QP8QOqOqI2P2jMBvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZxQDHOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60FEC4CEF7;
	Wed, 14 Jan 2026 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394513;
	bh=SDJNf8hpOkZD5A7qBSScNEJBf/xxkI1GcGJlh9Tt6Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZxQDHOPw8EWA/qmtwhh3VQN2+qxoU6bCC8Q+emFxHzFAUYxuDGFJcvoYQ4+05UEQ
	 y3Fsw1Q4q0FzbTuKWUptYP6gy5UVSwAEi5z4UjEYs1J7LBb53buhb95zFLHAXHHYTX
	 /550nC8IWz19oCLalanXa1TEOEQdUnkXoAzoDbd+npGv6JdKHe0eAuy4UrA3uSdq8U
	 ze3y2v9jcT5TKU4mTulmBPZvzCGVyZZ55rspMxaOi4owhnHSewqxmE4C0fkbCBpuZF
	 udzLchtzl4d6ttOe26WYvvHFjwCmVrEnMfbEsBYjlyaKsJexI/dT2MaTSYegYqDBvY
	 tJmXZMw0/yssg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 18/26] ACPICA: ACPI 6.6: Add _VDM (Voltage Domain) object
Date: Wed, 14 Jan 2026 13:32:55 +0100
Message-ID: <1921526.atdPhlSkOF@rafael.j.wysocki>
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

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

A processor voltage domain is an identifier that specifies the voltage
plane associated with a given group of processors.

Refer to section 6.2.10. _VDM (Voltage Domain) of ACPI 6.6 specification
for more information.

Link: https://github.com/acpica/acpica/commit/d0dbb157646d
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index da2c45880cc7..5f70b196e0aa 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -587,6 +587,9 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each (var Ints) */
 	PACKAGE_INFO(ACPI_PTYPE2_MIN, ACPI_RTYPE_INTEGER, 5, 0, 0, 0),
 
+	{{"_VDM", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
 	{{"_HRV", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
 
-- 
2.51.0





