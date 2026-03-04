Return-Path: <linux-acpi+bounces-21336-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEfyJcZ4qGnpugAAu9opvQ
	(envelope-from <linux-acpi+bounces-21336-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:24:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1B2063E9
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE2E132BB33D
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D703D6CA9;
	Wed,  4 Mar 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiLuZeEJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CF3D3D02;
	Wed,  4 Mar 2026 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648230; cv=none; b=OiHCOCA5svfe5R42TNk1WBTqMjYtL9l5XCLCmhnYWHBN/7opSMMPtDwCNZ97d08zVVbUQYG2EPECi+o/UCr2b2Ou7Q9bubVfrOoat11Mfrajhxj8l93jFUZPl3Sj9ZF/K3fJThzNavMAGnAz0Uzpc3GS2bqioNmUz6D50+cXMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648230; c=relaxed/simple;
	bh=pKnu5ghCWORmWsnYXjGF2vIjExr5Er46xm9u06mSHmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bic4+ziolYtA/sAiiWAEyyaLmkxkkPQIETukFoYH0FCay9ExGObHCcIYMuprqLX3qDbXurvezo/s8e+R9Wf66f05gT4HktQcHAFYSIjs3U8xcJHK9gTdXlVhJL/UCvXLR+iYzichnMpwlnaxKlJuTEaLcKIG1bYR2c7T7T2gO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiLuZeEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A47BC19425;
	Wed,  4 Mar 2026 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648229;
	bh=pKnu5ghCWORmWsnYXjGF2vIjExr5Er46xm9u06mSHmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiLuZeEJcafY9KOp1F+a9JoYE+jtLYWKQyDQLEnO61dKa8HAieA/gLcYx8UFn8usf
	 Vva9Mf81dv7wT6Ne1BgUftzg/OSc1hdcNVdLNwa4QtG7PGe8VwStWgdzwwvAQlsCJv
	 5W1CklrdfSaH0o6KacoEJ49yyFgdyCitP1pphpfuB+9dqUz+HNuRV4PIrLweihCwJV
	 8BJdepqtQf63zyMDnS3RV/bm/r8FI+wg1ynvZRdxaCwyrI6h+LjLNPpkx8RPHWY3r7
	 yshag6na8+3nSivrgQmko4J8pfddIiT6hq+Bx4cDvhufBJy+03mXJZVSJTSWXKAoMj
	 adLNM0XygQDVA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
Subject:
 [PATCH v1 5/7] ACPI: TAD: Clear unused RT data in acpi_tad_set_real_time()
Date: Wed, 04 Mar 2026 19:15:21 +0100
Message-ID: <8660506.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5092662.31r3eYUQgx@rafael.j.wysocki>
References: <5092662.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 30D1B2063E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21336-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the clearing of the fields in struct acpi_tad_rt that are not used
on the real time setting side to acpi_tad_set_real_time().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -96,6 +96,10 @@ static int acpi_tad_set_real_time(struct
 	if (acpi_tad_rt_is_invalid(rt))
 		return -EINVAL;
 
+	rt->valid = 0;
+	rt->msec = 0;
+	memset(rt->padding, 0, 3);
+
 	args[0].buffer.pointer = (u8 *)rt;
 	args[0].buffer.length = sizeof(*rt);
 
@@ -233,10 +237,6 @@ static ssize_t time_store(struct device
 
 	rt.daylight = val;
 
-	rt.valid = 0;
-	rt.msec = 0;
-	memset(rt.padding, 0, 3);
-
 	ret = acpi_tad_set_real_time(dev, &rt);
 	if (ret)
 		return ret;




