Return-Path: <linux-acpi+bounces-16772-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C92B55761
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77F8AA1ED9
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE9B33A010;
	Fri, 12 Sep 2025 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPSL7+RA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5733A004;
	Fri, 12 Sep 2025 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707603; cv=none; b=UFtJwP7rJCllIrWL8gliQPC/k8haiUl5PmPQ0oBlVpVs6dXgfrpqGofXsBARb1aDzC84W0ahkJgFyTD+4knPfs7YGRi6/PlDkVhEO8Mft4ASoLVp9N1gON8uWDffKmktzjNKlDxLjqwBR0tzSTCCndX1D6w8jwecUxmXsdCzLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707603; c=relaxed/simple;
	bh=RgVSKugvqzF05Z0CgkFjUYMPAGb5SCWbFpAKpje7JEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owJ3OkUBYO/qD7INaiSCpJTl1jJZsRkT4L6E0nbzNpqk07DToYODDTXWdu+miZHsXPlOP58MhR6/e3PWBc5eFWWb3Q0TNFDkt2fnWCgX6SqU9Tq9xqMw94xKy9zCc4+qK7+U6PEk+/2meaSMABV8f7FEbJr77UTOK/WHLq0BoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPSL7+RA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41BAC4CEF4;
	Fri, 12 Sep 2025 20:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707603;
	bh=RgVSKugvqzF05Z0CgkFjUYMPAGb5SCWbFpAKpje7JEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPSL7+RAD2SqO5zEBPnW4Y7yyLPZ6evaXkc+gCaVJgw2wsScqn5Zjm8u6j8HWDVVm
	 iQqS1QvY2J+OAJ7yjGlB1cvsjBvtuMdmbzs2F80gT2cUDYzA4vZpUh2CqN2bwIWDb7
	 kN5W0Z4cYBUBt9qlxnTJWQ8zHypCtNWZb4oa7wcOHAZ1MdTtvJkW09cbaJuqp3HnOS
	 sF5eRXy7/uV3r+3peZ6CI8wadb9R8dC6JUntvOXJpppLH2FcFFYjr+cpRAyH4L7oCK
	 8zyY0bGitRYqUFME9jDpGQ82qva4cjzUqyeT3cvDWcpfPfUWnwPAmmCyue+kcQTAmU
	 wThUm9vErIymg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 08/16] ACPICA: Debugger: drop ACPI_NONSTRING attribute from
 name_seg
Date: Fri, 12 Sep 2025 21:59:17 +0200
Message-ID: <2252228.Mh6RI2rZIc@rafael.j.wysocki>
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

From: Ahmed Salem <x0rw3ll@gmail.com>

ACPICA commit 4623b3369f3aa1ec5229d461e91c514510a96912

Partially revert commit 70662db73d54 ("ACPICA: Apply ACPI_NONSTRING in
more places") as I've yet again incorrectly applied the ACPI_NONSTRING
attribute where it is not needed.

A warning was initially reported by Collin Funk [1], and further review
by Jiri Slaby [2] highlighted another issue related to the same commit.

Drop the ACPI_NONSTRING attribute to fix the issue.

Fixes: 70662db73d54 ("ACPICA: Apply ACPI_NONSTRING in more places")
Link: https://lore.kernel.org/all/87ecvpcypw.fsf@gmail.com [1]
Link: https://lore.kernel.org/all/5c210121-c9b8-4458-b1ad-0da24732ac72@kernel.org [2]
Link: https://github.com/acpica/acpica/commit/4623b336
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acdebug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index fe6d38b43c9a..91241bd6917a 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -37,7 +37,7 @@ struct acpi_db_argument_info {
 struct acpi_db_execute_walk {
 	u32 count;
 	u32 max_count;
-	char name_seg[ACPI_NAMESEG_SIZE + 1] ACPI_NONSTRING;
+	char name_seg[ACPI_NAMESEG_SIZE + 1];
 };
 
 #define PARAM_LIST(pl)                  pl
-- 
2.51.0





