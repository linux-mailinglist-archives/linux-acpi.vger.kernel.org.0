Return-Path: <linux-acpi+bounces-20655-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF0JIsmheGljrgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20655-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:30:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E884A9397F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A50A730276A9
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2617346E44;
	Tue, 27 Jan 2026 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kvUA/aqS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD48346ADC;
	Tue, 27 Jan 2026 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513358; cv=none; b=iut+VidOwtBlwqDD3f12/HcXhmZNulSDm9Vq0dWj8bHtDRXooMcFW5o1Ct2lRwJn4IhWivrVNxuefvNxSseH5K/6kots+39mpfqbN3cEeQPCjNWixaMclln409AFsUjTMVDjya6WR35TMAu7zeo2SoEb+6CsvNNlO0/9Y5YeaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513358; c=relaxed/simple;
	bh=4ROMPFyyGKtJJ4qpPCHoACycTRePBdDehvxavUgSn+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRufMNESwyualPSPBi0kgCY9L/tgOB0SLBaYJ7RuncpIbMJ5Y+txZV6eepcxfucdDq6kRFVubu6+nUGAtLQwCvrkkXGNwljnzjft8D8Wzs8FzShamS6icMgq+hVk3wUVCjCIDL09HRmsIHzfxfDY0Vansjw7xUSUVHJ71ai3ZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kvUA/aqS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EEE7340E01A3;
	Tue, 27 Jan 2026 11:29:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id S3UfYdbxrZGN; Tue, 27 Jan 2026 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769513349; bh=wSywaDQXlo6mKMnwa/g1FyJdUR2LE3VM40rDWnYe2yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvUA/aqSmLt+jE+czkpIZkB8/Htyh9CtpjBsnnrk0LtCLErnndrGBHErooFI6le4Q
	 lReNSFm2lpu8zKAxKpz0zdEq06OJe1yBpWzMfukHkrP6Uo4fDGYuSu40XesvfsXXUR
	 3Zm3N7DRtApPcH0a5f/uASwQKd3/QuJVb+z40FqAatGfXtuW6Pn8rpbVnzZZQIZQ0X
	 +UcQVgsadvssCIBzaJ77XI3i/XdSY08Re8oCjaan1FKK5HSorWrhAjLCJ/qlOEucWX
	 vSHUUxLoa/q+7y185dtU3CCqFANeUb9ZsTGr3FpkgbDn5KBeia4PJLIrTRVRExVLXR
	 nUKXd3MHQ7B3rR8hYBikvZRQ977KGPGXx317PIecxhXdTo7m95/+ILO2JfRgXMm3NC
	 66tCF1wEnoBOutcb5+2k5idFF99xwpj4Z4VtT+DqW1QJxHRjM7qBoh/9saIVVL9MlR
	 V6uM4ms0FJCDwM7qgdekX031Ckuzgj9f6KDoatkf3fJKgXHeu6U/NgumijodocwK+X
	 yHHM4zbkIBBPmTbtpKQ0dFNIIUXKjE3kG1YLNFr2fEd9oEOoHaVqL19xy6yvPrD56b
	 b/bEjkUBdLbIjXMdvITM9tDhNYjagTlCWjKi6fI2PUdo+GPhSPNO6pLfWx2YpTUG81
	 pj54i0J7ABQENJOQDccB1CSE=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0145140E00DE;
	Tue, 27 Jan 2026 11:28:50 +0000 (UTC)
Date: Tue, 27 Jan 2026 12:28:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, tony.luck@intel.com, guohanjun@huawei.com,
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org,
	jonathan.cameron@huawei.com, Smita.KoralahalliChannabasappa@amd.com,
	leitao@debian.org, fabio.m.de.francesco@linux.intel.com,
	jason@os.amperecomputing.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com, LyleLi@zhaoxin.com
Subject: Re: [PATCH] apei/ghes: Add ghes_edac support for __ZX__ and _BYO_
 systems
Message-ID: <20260127112845.GAaXihbb0LzZQqJfBB@fat_crate.local>
References: <20260126103313.6966-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126103313.6966-1-TonyWWang-oc@zhaoxin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20655-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zhaoxin.com:email,fat_crate.local:mid]
X-Rspamd-Queue-Id: E884A9397F
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 06:33:13PM +0800, Tony W Wang-oc wrote:
> Add ghes_edac driver platform support for __ZX__ and _BYO_ systems
> by extending the platform detection list in ghes.c

This is not "ghes_edac driver platform support" - this is forcing ghes_edac to
be the preferred driver to load on those.

> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>

What does that second Signed-off-by mean?

Looks like you need to read this:

https://kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

and the following sections.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

