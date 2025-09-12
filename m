Return-Path: <linux-acpi+bounces-16766-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF6B55758
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FD517B60D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D652C21F0;
	Fri, 12 Sep 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9m57xbe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DC2C17A8;
	Fri, 12 Sep 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707585; cv=none; b=isz+NuyaWilDXXsZcBvroDpZAgeWW78wHRS2ErF5z8xxuWolAQfLh3j1QD8Dw/eeFAjVSN+6fjZ3NL+tXozQKGjgWcKSTUVFwMFm082DoCKTol6ILurKLA5u7e1Uf7Mzy5q2bbPFh/t/8t7XJj/x/MaWoyIKQnGcfSawATuPJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707585; c=relaxed/simple;
	bh=XYpLkteFdoDpeT5rfAMq4oBiMXtz5YzY5ccGb+Az4SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHlJ39M/0/3TE+DFjYhsIDcgHOF/VuhEyxeYbKhWgROw3ZwHX1LLKsGgm2Vv/D03kQym9w8ChtIgzLPspv4WduOQtfWyLGX9FwTgf0jZIG+bOeBjMRZzS/Au4erNJ2Lwg/OJwr0dnyoPT92//mVbCwYjh/XVzAb2zOwRjJR8uGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9m57xbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEFEC4CEF4;
	Fri, 12 Sep 2025 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707585;
	bh=XYpLkteFdoDpeT5rfAMq4oBiMXtz5YzY5ccGb+Az4SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9m57xbe7nsfgG6PNaGF1PtSj6LY/4jnP24me5r4IQmdJsI8G1bcYeg36YcUEe2SY
	 ZyWNlrRx6i+SNvBjcXliCwOuW6B9h0QyiUccfY9AJWX6mzYse+oKE1HoHm5ZrR/BQR
	 +Ay5DzWlM2OdVJ3PFmTw1NY1sOW/kkGMWCrRSEAuxHmjia0CLoekDYhRa4cDwHiaj6
	 jVUQeK4y5TDdCeaN4rP3sSpJp9zB1EJjiR1k+sT8xx0PYpcgJSEkDHngehtzWwPW3q
	 tjNd+7UIaRIDDILZPMbyrkg2Sm6baCI2KQ/IvzraMmRMvLYwIJP6hhetyO61HWZC15
	 to8paHtFMFM+Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 14/16] ACPICA: CEDT: Add Back-Invalidate restriction to CXL Window
Date: Fri, 12 Sep 2025 22:04:04 +0200
Message-ID: <2032933.yKVeVyVuyW@rafael.j.wysocki>
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

From: Davidlohr Bueso <dave@stgolabs.net>

This is added in newer version (3.0+) of the CXL Spec to support the
HDM-DB coherency model.

Link: https://github.com/acpica/acpica/commit/a6886da1
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 99fd1588ff38..0b4c332df25c 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -565,6 +565,7 @@ struct acpi_cedt_cfmws_target_element {
 #define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
 #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
 #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
+#define ACPI_CEDT_CFMWS_RESTRICT_BI         (1<<5)
 
 /* 2: CXL XOR Interleave Math Structure */
 
-- 
2.51.0





