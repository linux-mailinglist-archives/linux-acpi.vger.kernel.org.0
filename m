Return-Path: <linux-acpi+bounces-12618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB174A78272
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 20:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180A8188F75A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289AE20D51E;
	Tue,  1 Apr 2025 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E+oDfZsf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G35VPd6b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ay1v0lcq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7wMfy/7g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F520409A
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533466; cv=none; b=fYZHiBOggWeERtxn9JtEor66lqb0SoDJtxT36AANi0IoCW05+p32q4Sh5xQMPvvolaTrjWfc3+oYShb8dukGjJWUDwVEQGN9OpfGIKDnGXTirJHUQCvBLNczCUWn5pIaQVCDw0lxMzt4owiD1jezPDkuZY1xXV6mymLvjMMELEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533466; c=relaxed/simple;
	bh=TEICr26tBhx5S+unNiIpTnJeoGUVdpVtzv2OobeaN3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBsVAUnFLOzc5iEFQlwjVNlAjzbVvB5EGwwNXgckXY4O5xA5J42RtkljO6V3vkw72bd5GGunmZemgWDPLL/OMqLYMfNzVzJMvy4oTN24yvhgbGyygggT3qFt4FgQNnO4p3gkAcRBcyRaBGONX/+R173Gz2pqQcHh1oklZXMZW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E+oDfZsf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G35VPd6b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ay1v0lcq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7wMfy/7g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 445DD1F38E;
	Tue,  1 Apr 2025 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743533462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgLvZWFccS6ZmcEVuIPinkJEFuZ2TK3fnyrCg3NNOQk=;
	b=E+oDfZsfZWWRKXGFJncV0D32Piw2ISFz808YjcnnA7OKmEkoWmNdlRzPQeDcTT6HwXlzH6
	5LjKgIn8Hlqtl5nqpEJ31yEKRhOfx+R3GZ52NVpI+1NoMFlhDMOWofKEq3+iatU+C1O3h+
	6KvnjT/KVSNbkGsRwMsvLFhm84Zqhl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743533462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgLvZWFccS6ZmcEVuIPinkJEFuZ2TK3fnyrCg3NNOQk=;
	b=G35VPd6b/V/eu0MmsOtfVjHRISxfELoAIKzoUDlyRJQ1F4CB39jiOWcwFWWst4B/cN9Am9
	QiBGVIjb4P/IU4Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743533461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgLvZWFccS6ZmcEVuIPinkJEFuZ2TK3fnyrCg3NNOQk=;
	b=Ay1v0lcqOWDScU1YfWx/KBrj/ztb4RndGgYU5o6WaYSm9DMvsukMH4Afup4Sq/cJJLioX/
	uB4WFlGx+GYiJW/sP+UEqsHW6uaGTimXgYalkBAen5uZb7A/zrvKEeW9m7WWb/0bLJm03E
	xEOo8BtaGCl49mv2OFFc0y30D9BjRCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743533461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgLvZWFccS6ZmcEVuIPinkJEFuZ2TK3fnyrCg3NNOQk=;
	b=7wMfy/7gfAv2hkWVvZUapVVxGxcyFtS/ajPKMFoc6BPT4mp2yDyRhn++y43mvQHYhuNC6f
	bHwcC4q2pN4vrlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD65313691;
	Tue,  1 Apr 2025 18:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dX13L5M17GdBNwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 01 Apr 2025 18:50:59 +0000
Date: Tue, 1 Apr 2025 20:50:50 +0200
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
	Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v8 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <Z-w1irf6ry2J_2PL@localhost.localdomain>
References: <20250127153405.3379117-1-gourry@gourry.net>
 <20250127153405.3379117-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127153405.3379117-2-gourry@gourry.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLj6zumtikrrmnnbmzkety5zmd)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Jan 27, 2025 at 10:34:03AM -0500, Gregory Price wrote:
> Hotplug memory sources may have opinions on what the memblock size
> should be - usually for alignment purposes.  For example, CXL memory
> extents can be 256MB with a matching alignment. If this size/alignment
> is smaller than the block size, it can result in stranded capacity.
> 
> Implement memory_block_advise_max_size for use prior to allocator init,
> for software to advise the system on the max block size.
> 
> Implement memory_block_probe_max_size for use by arch init code to
> calculate the best block size. Use of advice is architecture defined.
> 
> The probe value can never change after first probe. Calls to advise
> after probe will return -EBUSY to aid debugging.
> 
> On systems without hotplug, always return -ENODEV and 0 respectively.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

