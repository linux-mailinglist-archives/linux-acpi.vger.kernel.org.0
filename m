Return-Path: <linux-acpi+bounces-16764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B8B55754
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EE2A081D5
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55929AB12;
	Fri, 12 Sep 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2a8Lcrf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F618FC97;
	Fri, 12 Sep 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707581; cv=none; b=PeIFIkv9QkIfVXg4jwKx4+EjivKxfaxQJC9wl2SIsg2MNff/0xBclaKLc51rvPCxI015S7XLQ3ChPNGmb+Y+MGL/s4nyx2QgN7gFeAlf5XdoHlQeD815yTYDhHB5BtWTjzolo+26r1BKMyDonI9IiHM62Y8AQmzq2h1VcMAqPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707581; c=relaxed/simple;
	bh=IuBHjL73ZskqapjpJTBNcNowJv/7joUhld3OQUr1nNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnMG9mslYLEvn8bHU1+A26uh8SZ0X+OlYkvthAKfmbUIyM2rdHgzHY0oDMvzMlpt66sLKRqk4E65+6HjiRLx39IwZGR94g+DySs+DaFeP/Yqtzb37yH/hPgUbwC2jpHn9CuFfF6wMFDL/lnun24fxbVxp8rolu82IgLycPTgNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2a8Lcrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD35EC4CEF1;
	Fri, 12 Sep 2025 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707579;
	bh=IuBHjL73ZskqapjpJTBNcNowJv/7joUhld3OQUr1nNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2a8LcrfRhvD7f9VZDhCWEEIzaQNPoKm+MFmD1lOFPZxZHCP1763r3GEmz534dbGl
	 L9BwNSxsx4wtPPTPEKKj9jfMpeY0a/UzsyR0/xd5Bw/1W6fAQxUeHWCgnCYNRv9cn7
	 79Lbj6uKb+83j6fVT9JwsBZpWiev6TSy3rRTbBBEd5s4VmPA8tovFs4VRSUEFtzJzn
	 +rbtEA8oU980vubUz2JifrpYZJYXJ0Q3voFpzulNkPclPrgr/qfXxqweMZ5lkGLgE6
	 Iq80+uwxQdcY1LQWmjeiaYgzfQoCG38HqArOMF8r23XUmi6bFm1Jf05ryVORPseSNl
	 dDSa/tJzOSs5g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 16/16] ACPICA: acpidump: fix return values in
 ap_is_valid_checksum()
Date: Fri, 12 Sep 2025 22:06:08 +0200
Message-ID: <15565189.tv2OnDr8pf@rafael.j.wysocki>
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

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

The function ap_is_valid_checksum() has a boolean name suggesting it
should return TRUE/FALSE, but incorrectly returns AE_OK on success and
has no explicit return on failure, leading to undefined behavior.

Fix by returning proper values:
 - FALSE when checksum validation fails
 - TRUE when checksum validation succeeds

Link: https://github.com/acpica/acpica/commit/479ba862
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 tools/power/acpi/tools/acpidump/apdump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index bf30143efbdc..7a6223aa703c 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -86,9 +86,10 @@ u8 ap_is_valid_checksum(struct acpi_table_header *table)
 	if (ACPI_FAILURE(status)) {
 		fprintf(stderr, "%4.4s: Warning: wrong checksum in table\n",
 			table->signature);
+		return (FALSE);
 	}
 
-	return (AE_OK);
+	return (TRUE);
 }
 
 /******************************************************************************
-- 
2.51.0





