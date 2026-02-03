Return-Path: <linux-acpi+bounces-20842-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHxnAOZ8gmnAVQMAu9opvQ
	(envelope-from <linux-acpi+bounces-20842-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 23:55:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A5CDF703
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 23:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDA0A303CEBE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763B369201;
	Tue,  3 Feb 2026 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mw0MTCFD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455B2E06D2;
	Tue,  3 Feb 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159311; cv=none; b=Y0Hp0MaAIMkUzdxJYVwlF2tY9Kw4ZEbvOXKZ5ftXAA6LEbUP0ksknPa6ZVXObkURFjIrWa0qcTRD4AMCklljbguAamhcl4moz8AdZtKO95+WUnkciZdz+LXiJ/BATizHsRhJ/I4FShdmsO9soAsxKP8/c3+ow/cDhuvJ4ZHl4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159311; c=relaxed/simple;
	bh=Qzrta9Sd0cgNDuLNfiZQ53XV6yWxvOb+4VbhX7i79Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZEFqZN5pnny8bEk2uwErdMGspub4YLoXDyJABjXFCzIJQr33CUSxKGzFadCaC9ilJA5bR0A/424NsMXEOsNp3NHsvmsCbeG0bXKgC5iJNSm+AedBNsthLYXo5xg7yUrXwurXRWTw+01gdl9X5cP2Mb1W4ehhREnxyET6S/tynqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mw0MTCFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7A5C116D0;
	Tue,  3 Feb 2026 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770159310;
	bh=Qzrta9Sd0cgNDuLNfiZQ53XV6yWxvOb+4VbhX7i79Ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Mw0MTCFDecAa9aIQdJAiN0XNz52glejnek0RFgFTsruoPkwLPOp55B8vbzgkNZUSf
	 pR4jT+IiEB/AT0yu7w22irnmI8p5QZcAohsCs9LrXM/qrgpGInNhnUuPPW1ntsmI+c
	 Crpkik8bjD7LfCM4pzmuRiIpgQ9ovNDs/8FxiatOfbewiyGN3C6Der35NwwHcPDL9R
	 zG8p/N9scAWfcwg9ihaFV58smDvjokC65O2s8sL7enOcUu+DtpLGYfc7OkJ5A2awpA
	 ttlHSFKE7O1yGrd9KAovj9r5eXYl0anOcNtO2+fKy5GxxjQuV8QqhNZsYOUjp9f4it
	 4wjgjHeR7Y4Qw==
Date: Tue, 3 Feb 2026 16:55:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: APEI: Avoid NULL pointer dereference in
 ghes_estatus_pool_region_free
Message-ID: <20260203225509.GA195397@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23A877C77DF26B7C+20260203021233.8178-1-jiawenwu@trustnetic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20842-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79A5CDF703
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:12:32AM +0800, Jiawen Wu wrote:
> The function ghes_estatus_pool_region_free() is exported and be called
> by the PCIe AER recovery path, which unconditionally invokes it to free
> aer_capability_regs memory.
> 
> Although current AER usage assumes memory comes from the GHES pool,
> robustness requires guarding against pool unavailability. Add a NULL check
> before calling gen_pool_free() to prevent crashes when the pool is not
> initialized. This also makes the API safer for potential future use by
> non-GHES callers.

I'm not sure what you mean by "pool unavailability."  I think getting
here with ghes_estatus_pool==NULL means we have a logic error
somewhere, and I don't think we should silently hide that error.

I'm generally in favor of *not* checking so we find out if the caller
forgot to keep track of the pointer correctly.

> Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/acpi/apei/ghes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0dc767392a6c..e81c007464a9 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -236,7 +236,8 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
>   */
>  void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
>  {
> -	gen_pool_free(ghes_estatus_pool, addr, size);
> +	if (ghes_estatus_pool)
> +		gen_pool_free(ghes_estatus_pool, addr, size);
>  }
>  EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
>  
> -- 
> 2.48.1
> 

