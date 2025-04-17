Return-Path: <linux-acpi+bounces-13087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2814A91566
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 09:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E69D190449F
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69C2153CD;
	Thu, 17 Apr 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kcg77EO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NB8++XD7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kcg77EO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NB8++XD7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2581E1DEB
	for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875464; cv=none; b=QeddKfsGxJi/oxyP19kMdks2NONJrjVnxwn4yfvByon7IB9WBXZ0ZlkK7nZ2YpRMERd/AYDWhzqpgKMc25fWFt2z0CMBMRqLVT9aEUYyB0UzUpKW00K8VIhl5HZHl1kp6s8JShWqcxlmJVHRzX7KNdWmWAlYb/RcD1t48NizQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875464; c=relaxed/simple;
	bh=5Up4c2ec9bz9tNPVJsSQs5s0U01bmRiYXnnnXA1OJnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unxoRNPxq3o6YYFNq03TNygaJjX73AZs+QqDNsQBItwJRUfKDN6qE0RCnPni6xciBZfFkyUlHVbORkBsmAqJ4rx09Rrv2XInhFlJZpz/UxUNlP1QjjBdoj57SexJHJ3hYWmZfphBRcO7zh2ScMMBPQxE7qILxOA92lb0O9xi76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kcg77EO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NB8++XD7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kcg77EO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NB8++XD7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1A651F391;
	Thu, 17 Apr 2025 07:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744875460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY/upZ4RRyv+Af/uq37XK2KMVfUJ5EV6Iwrz5O78PcU=;
	b=Kcg77EO3YAvi3HHRtM1Cey2oVHNpiVx3hiYEP98iylnJRFWwPUHIb9H1mI1smmR8ybJJxo
	FjJXvkvqG2nDpcBaW5HkZOe34jdpT6Qn/xFVHhX54UaOXXjqRLj9GYGueNHKCdNkwCyx6h
	hn/5k3YjS56pBH7tWTpmCh2tEgg4dGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744875460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY/upZ4RRyv+Af/uq37XK2KMVfUJ5EV6Iwrz5O78PcU=;
	b=NB8++XD7+6MTY1UqStY6otFYnkHR3M/lSsdJ6i/cRggvxxLI3slt0egetza22uxF/YQhPJ
	4cW9TVm7SUKrOXDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744875460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY/upZ4RRyv+Af/uq37XK2KMVfUJ5EV6Iwrz5O78PcU=;
	b=Kcg77EO3YAvi3HHRtM1Cey2oVHNpiVx3hiYEP98iylnJRFWwPUHIb9H1mI1smmR8ybJJxo
	FjJXvkvqG2nDpcBaW5HkZOe34jdpT6Qn/xFVHhX54UaOXXjqRLj9GYGueNHKCdNkwCyx6h
	hn/5k3YjS56pBH7tWTpmCh2tEgg4dGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744875460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY/upZ4RRyv+Af/uq37XK2KMVfUJ5EV6Iwrz5O78PcU=;
	b=NB8++XD7+6MTY1UqStY6otFYnkHR3M/lSsdJ6i/cRggvxxLI3slt0egetza22uxF/YQhPJ
	4cW9TVm7SUKrOXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2EE6137CF;
	Thu, 17 Apr 2025 07:37:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y45ZK8SvAGixUgAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Thu, 17 Apr 2025 07:37:40 +0000
Message-ID: <7a2c79fd-cad2-4685-9da2-a12f089be13d@suse.cz>
Date: Thu, 17 Apr 2025 09:37:36 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ACPI: processor: idle:
 acpi_processor_get_cstate_info() cleanup
To: Zhang Rui <rui.zhang@intel.com>, rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20250409005026.1932637-1-rui.zhang@intel.com>
Content-Language: en-US
From: Giovanni Gherdovich <ggherdovich@suse.cz>
In-Reply-To: <20250409005026.1932637-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed Apr 9, 2025 02:50, Zhang Rui wrote:
> This patch series does further cleanups for
> acpi_processor_get_cstate_info() on top of
> https://lore.kernel.org/all/20250328143040.9348-2-ggherdovich@suse.cz/
> 
> thanks,
> rui
> 
> ----------------------------------------------------------------
> Zhang Rui (2):
>        ACPI: processor: idle: Set pr->flags.power unconditionally
>        ACPI: processor: idle: Remove redundant pr->power.count assignment
> 
>   drivers/acpi/processor_idle.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)

Thanks a lot Rui for this cleanup.

To the series:

Acked-by: Giovanni Gherdovich <ggherdovich@suse.cz>

