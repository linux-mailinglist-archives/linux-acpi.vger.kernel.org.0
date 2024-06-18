Return-Path: <linux-acpi+bounces-6490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DC90CEB0
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A601C208EB
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6739F1B9ABB;
	Tue, 18 Jun 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUMSkd+B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D71B9AB6;
	Tue, 18 Jun 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714585; cv=none; b=MM804pCaWT88OwwcC6kjU/skFkQor+a/dtlLMFEKR5j2EX0RQj4+p1PHkK/dfj4OqtRBC5uk8nePDCYOBhwl6EhKRcnyJjdD1MDC/V5VZwKdj54kojLLnqs7mwZTaouO3qHbYSohMU5KKsHJAJn1EOFGAWZzckRnYi4YwGfweWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714585; c=relaxed/simple;
	bh=W3cbnYQ/eEHVdfJULh66GP6lhxsfzrBzxB40bktSZbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj0HWvQQoFhmbqmNlkkO6UNTEjEHWQG9lNr3tC2PdIKOs7X0w7aDQTUSfUHHAcMpTp7E/TrV1OyWK5bWNBC7dmhRJIcCckUK4K8O5KOKul3L5+xLLAA+C+a9xaU/gNltxBjZIDj+UFJFlSVNMPynnGmkWniFMBy/y1DBUdYxqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUMSkd+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485C6C3277B;
	Tue, 18 Jun 2024 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714585;
	bh=W3cbnYQ/eEHVdfJULh66GP6lhxsfzrBzxB40bktSZbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUMSkd+BuP6NbwRzqTLppheepsf1r/mZid1iGasRTJj88cmzN3RQEoHWfX1/zmY5F
	 vcAKpqGohlfe6/z+aujBCWAXfOKS+ZSonNihJ3LMaJj25/JzJItfH63tgbGQpCXmLR
	 7RfZ47rZmsYg/M4cJEyIs+ZvjRdoRgmzDiSNPvP7huuCcX5SG2p94BPdxDNI8V6dvm
	 gispOAfI+X0oGR+f1hgkrOkAJpUIoW+UkPUBdpTw8VtDJ21VEy1pMq9mfr1uRL5KcL
	 /lNt2aJSyicKusI1IQY4ipCf6nslGZXYkcQOVndTjyT+Vi5j94MD9SxppIUoFDFRix
	 ASvm7LikCGbdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/9] ACPI: EC: Avoid returning AE_OK on errors in address space handler
Date: Tue, 18 Jun 2024 08:42:51 -0400
Message-ID: <20240618124300.3304600-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124300.3304600-1-sashal@kernel.org>
References: <20240618124300.3304600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit c4bd7f1d78340e63de4d073fd3dbe5391e2996e5 ]

If an error code other than EINVAL, ENODEV or ETIME is returned
by acpi_ec_read() / acpi_ec_write(), then AE_OK is incorrectly
returned by acpi_ec_space_handler().

Fix this by only returning AE_OK on success, and return AE_ERROR
otherwise.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 43a8941b6743d..142578451e381 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1328,8 +1328,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 		return AE_NOT_FOUND;
 	case -ETIME:
 		return AE_TIME;
-	default:
+	case 0:
 		return AE_OK;
+	default:
+		return AE_ERROR;
 	}
 }
 
-- 
2.43.0


