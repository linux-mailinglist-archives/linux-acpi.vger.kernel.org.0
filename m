Return-Path: <linux-acpi+bounces-12621-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADE4A7827B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 20:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D354F188F742
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 18:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9638F1DE2B4;
	Tue,  1 Apr 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tnh25DIO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8A/I2243";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tnh25DIO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8A/I2243"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C31F09B8
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533633; cv=none; b=RpsNS9zmnMjZOr1hlmZqY1UZnF2dt4Fx79D9blXtWnm6xwEp9Glnk+DhMJXKq75Pq8zKR34l9rw4/w4f1jbeuV7M3uvzo5cmd+Qm2Pke968ijOgUeyWTx2rd6lvRzgrCaV3s2I5w7NtiTIfv4qVqMlxz+vrEGfjs9kL9zZGsg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533633; c=relaxed/simple;
	bh=heqNyjvA9uGAnz29bWAyOedN4AS4qurH6YzH2fF2COA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm9N7zVZ+4XEOBCRs94QLs0ReqI/HkftxhU8EjWPMAACD3sDZXqvu2OJ/7vQUYsL4i3uNNcMUniDpR2ddCgh7qdIgaVrzLB0hqiXYaawLRcjQ3g4dOmBYnRB2MO2cJLs9YXxTZwhtcdadT3lKxATqmLRc2/z59POmDSHID6IE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tnh25DIO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8A/I2243; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tnh25DIO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8A/I2243; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92E24210F6;
	Tue,  1 Apr 2025 18:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743533630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nR803xm38t00s8Uk04qRbIbe//Ye+5t8z2qfY1LQwI=;
	b=tnh25DIOM1ZJvm/WC78xWIr/1HHcJWPEUdZpIZ1nqXOIhKjIbrr2qSr/JDO9jf3rnU1XZY
	6mWFCuQX/08q4oH78MWelRoqzb61KgMj4fISb5wJtLIOqFH2APmQ71wG1Bu4M2f4jtuQKi
	tXZVlBWN/1kK1xz8s54ZqnoY4geRXVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743533630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nR803xm38t00s8Uk04qRbIbe//Ye+5t8z2qfY1LQwI=;
	b=8A/I2243KWLse33QR15t1Aj/IoifNLH0/AXQjFt9AFIQ68OzoN/N29FcTcPGXSLCfgvt/7
	UFOtC4qjKARyk3BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743533630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nR803xm38t00s8Uk04qRbIbe//Ye+5t8z2qfY1LQwI=;
	b=tnh25DIOM1ZJvm/WC78xWIr/1HHcJWPEUdZpIZ1nqXOIhKjIbrr2qSr/JDO9jf3rnU1XZY
	6mWFCuQX/08q4oH78MWelRoqzb61KgMj4fISb5wJtLIOqFH2APmQ71wG1Bu4M2f4jtuQKi
	tXZVlBWN/1kK1xz8s54ZqnoY4geRXVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743533630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nR803xm38t00s8Uk04qRbIbe//Ye+5t8z2qfY1LQwI=;
	b=8A/I2243KWLse33QR15t1Aj/IoifNLH0/AXQjFt9AFIQ68OzoN/N29FcTcPGXSLCfgvt/7
	UFOtC4qjKARyk3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B7D513691;
	Tue,  1 Apr 2025 18:53:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XGLpBz027GcPOAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 01 Apr 2025 18:53:49 +0000
Date: Tue, 1 Apr 2025 20:53:47 +0200
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
Subject: Re: [PATCH v8 0/3] memory,x86,acpi: hotplug memory alignment
 advisement
Message-ID: <Z-w2O8O9MGJ1Ok78@localhost.localdomain>
References: <20250127153405.3379117-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127153405.3379117-1-gourry@gourry.net>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLj6zumtikrrmnnbmzkety5zmd)];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Jan 27, 2025 at 10:34:02AM -0500, Gregory Price wrote:
> v8: nits and tag pickups
> 
> When physical address regions are not aligned to memory block size,
> the misaligned portion is lost (stranded capacity).
> 
> Block size (min/max/selected) is architecture defined. Most architectures
> tend to use the minimum block size or some simplistic heurist. On x86,
> memory block size increases up to 2GB, and is otherwise fitted to the
> alignment of non-hotplug (i.e. not special purpose memory).

I wonder if something like this could help us in improving the
ridiculous situation of having 16MB memory-block size on powerpc.
 

-- 
Oscar Salvador
SUSE Labs

