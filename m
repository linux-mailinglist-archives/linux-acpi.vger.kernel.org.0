Return-Path: <linux-acpi+bounces-20485-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLQNMgyzcGndZAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20485-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:05:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F9655B2A
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E81F60863A
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 10:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7046AEC6;
	Wed, 21 Jan 2026 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwPwvmUV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF3227E95;
	Wed, 21 Jan 2026 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993051; cv=none; b=HomLhrlY+e5nInzqCoqg3E6UxfVDtFeT0vB7r1pTfObnxsb/pdGPiA9Utt2D/SVuacwY+90rtnbGpNenAiEoJ6zJCpPzXAyVqrzEsbnoa4pD9E7hVJUhX6PWHh6MvvgyLFK4+fNJd4NDZbmqsKy8czHYjv1wZT2pwlXioJEh1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993051; c=relaxed/simple;
	bh=5P/Dz4zGB39RUC3qzDnTz05zg88xu8PNygS91jV43AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMNUE8leZ8VjDjZFnVy3zd8DA7aYAsbNUeOw+RoTPWeLLv1zLkFnzCPlEoKyEss+r5ncy5P3faoJ7mbKSVDaW5jKmYGKc0ezAxUhusvsIeowKKRG5UNi+tupKX9syYhwycU3e6hp7WdevMAVT4FKWhOxWiOWXz70UVS/3+W23JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwPwvmUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52842C116D0;
	Wed, 21 Jan 2026 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768993051;
	bh=5P/Dz4zGB39RUC3qzDnTz05zg88xu8PNygS91jV43AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwPwvmUVwTal0S1t2Ge7QqazBzWENjTkkQ8Tbi7li5RS8Bjd8cn4rjduf1mR6ChNh
	 1uRu7uYmYWDYw325mPfR8oGRoIb6qL64uBsJW8YA3A8WX60rbNZsWO9QVzwW/IkIJc
	 Qsu5TUnAd1DVXAWT5LloeB44yBV8wfqnMxr6fn9kP3CpiC2BPSF1auWijHMLRChVq/
	 XWfe7xA4EiTKVnYiDRwMntMKEiKh4HdAvmeWPhPZ0LIXsdG0HTjw2QpqDPB9DB81Br
	 VlHIzT99oheIsOWrsO/XycUCdLQS5IebBnj4ajkc+wEdz6gRNEzGdgV0kwgR309+a6
	 Rvvct60Bx0NjA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, platform-driver-x86@vger.kernel.org,
 Azael Avalos <coproscefalo@gmail.com>,
 Matthew Garrett <matthew.garrett@nebula.com>
Subject:
 [PATCH v2 2/2] platform/x86: toshiba_haps: Fix memory leaks in add/remove
 routines
Date: Wed, 21 Jan 2026 11:57:26 +0100
Message-ID: <12823935.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <10789244.nUPlyArG6x@rafael.j.wysocki>
References:
 <3026924.e9J7NaK4W3@rafael.j.wysocki> <10789244.nUPlyArG6x@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nebula.com];
	TAGGED_FROM(0.00)[bounces-20485-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 78F9655B2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tuesday, January 20, 2026 4:44:23 PM CET Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> toshiba_haps_add() leaks the haps object allocated by it if it returns
> an error after allocating that object successfully.
> 
> toshiba_haps_remove() does not free the object pointed to by
> toshiba_haps before clearing that pointer, so it becomes unreachable
> allocated memory.
> 
> Address these memory leaks by freeing the memory in question as
> appropriate.

Actually, this one can use devm_kzalloc() for allocating memory instead,
so here's a v2.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 2/2] platform/x86: toshiba_haps: Fix memory leaks in add/remove routines

toshiba_haps_add() leaks the haps object allocated by it if it returns
an error after allocating that object successfully.

toshiba_haps_remove() does not free the object pointed to by
toshiba_haps before clearing that pointer, so it becomes unreachable
allocated memory.

Address these memory leaks by using devm_kzalloc() for allocating
the memory in question.

Fixes: 23d0ba0c908a ("platform/x86: Toshiba HDD Active Protection Sensor")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Use devm_kzalloc() for memory allocation and drop the rest of the changes.

---
 drivers/platform/x86/toshiba_haps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -183,7 +183,7 @@ static int toshiba_haps_add(struct acpi_
 
 	pr_info("Toshiba HDD Active Protection Sensor device\n");
 
-	haps = kzalloc(sizeof(struct toshiba_haps_dev), GFP_KERNEL);
+	haps = devm_kzalloc(&acpi_dev->dev, sizeof(*haps), GFP_KERNEL);
 	if (!haps)
 		return -ENOMEM;
 




