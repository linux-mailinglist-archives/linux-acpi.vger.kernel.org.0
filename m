Return-Path: <linux-acpi+bounces-14544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43F5AE6875
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5939D4E1D6B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1452E11A8;
	Tue, 24 Jun 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="BwmiRiQ5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC02DFA46;
	Tue, 24 Jun 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774604; cv=none; b=D/R12fg+YAZ+rwpkgyXF7y7BUN3FCcZwNIyS6MBdK4pnZTJi2QjhxnnaNN6xC9C1iNQYI2L+InAqjv82Q28s/w+ss7oLQtjzQiNec5gzIm26+SMOfCyfHulE5w7OAVCE9tF1R1P+dmEEsbXshZUhF7JrCcnntWCUdsnWuWutt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774604; c=relaxed/simple;
	bh=QySNGEn+z7q6xrGNdmdgwcdRl64BoG8RShihdAdvQ84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7YC/aiOu9F5Pmyo/PB7BxcWBX9qxd5OKICMoli2aLRquxrmHfve3MPl4rKk3eGsIxMNlmBCRSzJoKsepDhq9aLESaHWsw6VHUj6Hj3xshw3E2uXA24hWrrtlDudTUhO+oONITmsH2xfhq53rm/Nl0L55cuGfErwe3XHfc+ikEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=BwmiRiQ5; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bRRp80z34z9swN;
	Tue, 24 Jun 2025 16:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750774592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOB+KWj4K3uiBKIu1Zg12zTHSz73MTm6NuU1DNkS8ag=;
	b=BwmiRiQ5DPb88L1bZT9xNSIhUKq+5c8llet+J2eGabC0TL2Nk7Xru+zRNTbAs7LeQut6BQ
	f5MYSfxo/Rbn3WZ73Fh6Vom/ECXeSggR47dL3TtzpPOWWZOfP7o5DP6GDQa0bUHc1pA2/r
	w0ZIzf7uN7IU16fMUeA2y5SWxVGDD84JktE2zo7PoZMR2FrnjnXqQ0AJopsyefQoIrmNVG
	mWRSb2Gt/1b5plXqft2bRAQO6gJdAokb87X0XC+VzmhchAVrUAGwpYiQwFE3ho2oB5Q6dG
	qnQ3ToOpAKME4tNm1/rg4XR7P3ho4OfB2WueYwCZo+Da7DcUTdHwrYUtJcPkSw==
Date: Tue, 24 Jun 2025 19:46:25 +0530
From: Brahmajit Das <listout@listout.xyz>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, lenb@kernel.org, lv.zheng@intel.com, kees@kernel.org, 
	rui.zhang@intel.com, len.brown@intel.com
Subject: Re: [PATCH] ACPI / sysfs: Replace deprecated and unsafe functions
 with sysfs_emit
Message-ID: <jgk536vpai32yf4ozjx66pah2nvi67j7cnbs4wlfrj5vsetg3w@sgd6huslhtk2>
References: <20250624133739.25215-1-listout@listout.xyz>
 <CAJZ5v0jSk-NrovSq5En6qOureQXFbCsJLChorbgYXQdYfa0m3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jSk-NrovSq5En6qOureQXFbCsJLChorbgYXQdYfa0m3w@mail.gmail.com>

On 24.06.2025 15:46, Rafael J. Wysocki wrote:
> On Tue, Jun 24, 2025 at 3:38 PM Brahmajit Das <listout@listout.xyz> wrote:
> >
> > acpi/sysfs.c has many instances of unsafe or deprecated functions such
> > as sprintf, strcpy. This patch relaces them with sysfs_emit to safer
> 
> "replaces"
> 
> > alternavtive and better following of kernel API.
> 
> "alternative"
> 
> 1. Have you tested all of the affected interfaces and verified that
> they still work as expected after the changes?
> 2. While the replaced functions are unsafe in principle, is the usage
> of them in any places affected by this patch actually unsafe?
> 

The previous patch's idea came while I was working to remove strcpy from
acpi/sysfs.c. But I guess this is not a good way of sending patch and me
being a new comer didn't help that I didn't completely tested the patch
before sending, even it was meant for RFC.

I vaguely remember a tread by GHK where he asked to leave out old code
and only work on new code that you've tested. So I'll follow that for
now until I've learnt testing my changes properly.

And again sorry.

I'm working on a patch that replaces deprecated strcpy (which according
to kernel docs) with sysfs_emit. And looks like:

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a48ebbf768f9..7ce90998ab97 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -181,10 +181,9 @@ static int param_set_trace_method_name(const char *val,
 
 	/* This is a hack.  We can't kmalloc in early boot. */
 	if (is_abs_path)
-		strcpy(trace_method_name, val);
+		sysfs_emit(trace_method_name, "%s", val);
 	else {
-		trace_method_name[0] = '\\';
-		strcpy(trace_method_name+1, val);
+		sysfs_emit(trace_method_name, "\%s", val);
 	}
 
 	/* Restore the original tracer state */

I guess I'll keep this, instead of replacing every instance of sprint
with sysfs_emit blindly.
-- 
Regards,
listout

