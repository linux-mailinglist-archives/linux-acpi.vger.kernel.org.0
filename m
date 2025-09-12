Return-Path: <linux-acpi+bounces-16765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C7B55756
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6637A7C76D1
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACF2C027F;
	Fri, 12 Sep 2025 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYjde23S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6342BF3E2;
	Fri, 12 Sep 2025 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707582; cv=none; b=eqclWtiHaTclT2lkUcDmhibiopdRt06+O9fHuq8NgBoIgCqiTzNh1kzSsuli7bVyihlZOwQe7mZxuujhNCwH9qnhErHzhVSWWByuNa06v5PiSxIH4nGqM+BFZdk9hs7ocRlZAs2PHKUN2NOMqQsmDudDMmcQjg2k7V+h3xZfUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707582; c=relaxed/simple;
	bh=3lVCi3Hgco8kgX+7WxusQkLjdmANtfmlxdtUfgc5MgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owak/cUfPjQ/i//4GqjhFAzhX+7GfFEuXJKvOYdaXlOab4t33i9mYylnx1hYPocb5l1pmV6dt2r0FSwEPVBImEKC+Y8aw2q4omClgaWqz7vhrWCMrXoKa4C9NlS01j/FkSR4rlZ1l7wbec3gnxMHdyr1UuXpYkQZa18aUe01VUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYjde23S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB2EC4CEF4;
	Fri, 12 Sep 2025 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707582;
	bh=3lVCi3Hgco8kgX+7WxusQkLjdmANtfmlxdtUfgc5MgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYjde23SDNznomxnoY6vlXIN0zPCbo/UM129n1NCiyGJ6TJFsQgYNsGlqdI7miYue
	 Zou+nstm4DizWN6gzZUEVP0qGmfl2U+NowAzLnsJVw5b4Im6WT8ZIaOlLTTrefIjTC
	 V1QDvWeaH0Y90JF2IzPF+ISEXX1SzxAEc65ZmLEUS1Idsj4nXl3YRO/aylgEsOZqTF
	 K7PdRpX94qJWrh1tG1In7h7yA9VECcpGv+ZHuBSh0Rz5nBWSfXB1EXSf8v2xafmHDV
	 wPuCE23nlN1e1He+VNUaKaetNBglUUoODqC1UicLZn6RQcDCzEfQ7Z5gQtIhRL4wXP
	 khPtH32lATbaw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 15/16] ACPICA: ACPI_TYPE_ANY does not include the package type
Date: Fri, 12 Sep 2025 22:05:01 +0200
Message-ID: <2275341.NgBsaNRSFp@rafael.j.wysocki>
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

So add it to the list of acceptable Arg3 types for _DSM.

Link: https://github.com/acpica/acpica/commit/6eb81e7c
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 76c5ed02e916..da2c45880cc7 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -450,7 +450,8 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 
 	{{"_DSM",
 	  METHOD_4ARGS(ACPI_TYPE_BUFFER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
-		       ACPI_TYPE_ANY) | ARG_COUNT_IS_MINIMUM,
+		       ACPI_TYPE_ANY | ACPI_TYPE_PACKAGE) |
+		       ARG_COUNT_IS_MINIMUM,
 	  METHOD_RETURNS(ACPI_RTYPE_ALL)}},	/* Must return a value, but it can be of any type */
 
 	{{"_DSS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
-- 
2.51.0





