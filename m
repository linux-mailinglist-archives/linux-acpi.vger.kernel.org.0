Return-Path: <linux-acpi+bounces-12620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9162CA78277
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 20:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449A616CF3C
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234320DD47;
	Tue,  1 Apr 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XA1VC+XR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b7ek/4lp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XA1VC+XR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b7ek/4lp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650520CCCC
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533548; cv=none; b=DBLkdp6cih7YsoXF/uGUJN30dfqycPfSpXj1gNMoQq6Nm6EFXE4JGvbaKJVVr2lmPZyrBkc+fs1+9eumQ8leJX2Zv5CCgUIkK3u3M92qfkMdh/7W+aVBJdsq1By8LBEQibCmpLfEnagJQ23OX0t4HBiHlgNSoyxsqAhwMWR+Orc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533548; c=relaxed/simple;
	bh=pFnQswiPkgtNRZfDuG/Kug6xFt04tv2HRl9t0WGoij4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0ni4F/Jywq9yvwKLNfoIN7gJXjm2qM4z88ERzExIIMXdZ9AF8ttHDyv/H7AaTgduZ6CaFYHtPxo5dJLeJtxZ2LfEHHgFCQqTCIA4wLU8Gj+qGY5shl3UAK5EnIvA+3sREM3uPrvZTqu524gXnSkYQAKMYlWDvJgfG1Sv6L5WDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XA1VC+XR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b7ek/4lp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XA1VC+XR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b7ek/4lp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8095421189;
	Tue,  1 Apr 2025 18:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743533545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCXGIomXZfzWxlFPktvX+t1g4QdNt6RtmYSweHtogYE=;
	b=XA1VC+XRAymxh/GYqKgjnOOSGV6YlsjpDbef8xX88NAwZ+WsfngMP6T45waK1sKiClLAUX
	e57BRBwR/QlS3wgrqGmNbJIh/CW5Re/eieXyBLm+XKtVYr/AcblD1i7vLKhNMgY2Og2DZM
	2Jpnkn23n6P7yxsRIkGEr/gjSuZAbLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743533545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCXGIomXZfzWxlFPktvX+t1g4QdNt6RtmYSweHtogYE=;
	b=b7ek/4lpD6DlKB5M2ykrpaTRMVEnGWjjwLISJHGl+UYQa5DOJkS5POY6A3xshHlAtkTRZj
	yE2qQFf4yRpOVhBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743533545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCXGIomXZfzWxlFPktvX+t1g4QdNt6RtmYSweHtogYE=;
	b=XA1VC+XRAymxh/GYqKgjnOOSGV6YlsjpDbef8xX88NAwZ+WsfngMP6T45waK1sKiClLAUX
	e57BRBwR/QlS3wgrqGmNbJIh/CW5Re/eieXyBLm+XKtVYr/AcblD1i7vLKhNMgY2Og2DZM
	2Jpnkn23n6P7yxsRIkGEr/gjSuZAbLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743533545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCXGIomXZfzWxlFPktvX+t1g4QdNt6RtmYSweHtogYE=;
	b=b7ek/4lpD6DlKB5M2ykrpaTRMVEnGWjjwLISJHGl+UYQa5DOJkS5POY6A3xshHlAtkTRZj
	yE2qQFf4yRpOVhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 108FD13691;
	Tue,  1 Apr 2025 18:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uCVZAeg17GeYNwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 01 Apr 2025 18:52:24 +0000
Date: Tue, 1 Apr 2025 20:52:22 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-acpi@vger.kernel.org, kernel-team@meta.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, david@redhat.com,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	alison.schofield@intel.com, rrichter@amd.com, rppt@kernel.org,
	bfaccini@nvidia.com, haibo1.xu@intel.com, dave.jiang@intel.com,
	Fan Ni <fan.ni@samsung.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v8 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <Z-w15qSwQYz-oJF6@localhost.localdomain>
References: <20250127153405.3379117-1-gourry@gourry.net>
 <20250127153405.3379117-4-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127153405.3379117-4-gourry@gourry.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLj6zumtikrrmnnbmzkety5zmd)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email,samsung.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Jan 27, 2025 at 10:34:05AM -0500, Gregory Price wrote:
> Capacity is stranded when CFMWS regions are not aligned to block size.
> On x86, block size increases with capacity (2G blocks @ 64G capacity).
> 
> Use CFMWS base/size to report memory block size alignment advice.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

