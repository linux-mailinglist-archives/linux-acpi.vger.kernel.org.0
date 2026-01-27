Return-Path: <linux-acpi+bounces-20641-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YELGN6BpeGk1pwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20641-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 08:30:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 576CF90BCF
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 08:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3A1930067AA
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 07:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E026982C;
	Tue, 27 Jan 2026 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSCBeS4D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vpd6tUbX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSCBeS4D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vpd6tUbX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477024A078
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499037; cv=none; b=J7V/amuBYFBoeYUhZbQ46f9tdgm8G2E8Z7svNkGGv1TADtCZnSFA5geQ86BMUQXUQjflxNwk1J/7yC2mHDt7fY3rBqeN3ib1N+lKeqIwfMh0QJB5RQjCaTtYmo4GYZszySlQXEKmlJRKOECnhnpNJDVFtJwrS7csl727B87ngnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499037; c=relaxed/simple;
	bh=/tlF0qpjxkjcAo75X8yPk1jutjNRUNTQzbswh7afmqI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/YLHZBF5tBrizq7XzlFyZ1K34bizw963IBfcGyXuhEgx04xCz5nqZHeAA8XG6rpAxUABQE0zvVZljose51JWmrRQD7Vvg/yRQMHt1FUJ9PYpiw5u9rdAHarVZq57UvBPR40uk/1Z4IHjEnSyGT2/9AuKEBdc/EyqhU1/B9r7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSCBeS4D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vpd6tUbX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSCBeS4D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vpd6tUbX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9400833769;
	Tue, 27 Jan 2026 07:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769499034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYKzOnVrupxhzXKWPZL7mjv2UMNPeqUIY4E5ULDHLI=;
	b=zSCBeS4DDmZfLPHK/5pqsgBKRVqx52nvcuA5F2SDLaE/HV4IOgDSeJ68QaBgDCXHLFzCT8
	gB9+hzevRUSjijFnKQrwSaUgbCneWjsJxOrHxazWQtdQvFq4hdH1no+Me+r6COTLKd5ErL
	br4ff/NUNrD3HZYYZHmmWkXrHjpHThQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769499034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYKzOnVrupxhzXKWPZL7mjv2UMNPeqUIY4E5ULDHLI=;
	b=Vpd6tUbXV7tTOAP4lq4PXYq8lhNGp9Zjbv4jher7SaBuiddWO8kMIHIE+asgswcl9XsR+C
	0jhxS6wdO0D6E6DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769499034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYKzOnVrupxhzXKWPZL7mjv2UMNPeqUIY4E5ULDHLI=;
	b=zSCBeS4DDmZfLPHK/5pqsgBKRVqx52nvcuA5F2SDLaE/HV4IOgDSeJ68QaBgDCXHLFzCT8
	gB9+hzevRUSjijFnKQrwSaUgbCneWjsJxOrHxazWQtdQvFq4hdH1no+Me+r6COTLKd5ErL
	br4ff/NUNrD3HZYYZHmmWkXrHjpHThQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769499034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYKzOnVrupxhzXKWPZL7mjv2UMNPeqUIY4E5ULDHLI=;
	b=Vpd6tUbXV7tTOAP4lq4PXYq8lhNGp9Zjbv4jher7SaBuiddWO8kMIHIE+asgswcl9XsR+C
	0jhxS6wdO0D6E6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3170913712;
	Tue, 27 Jan 2026 07:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHO5CpppeGlmawAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 27 Jan 2026 07:30:34 +0000
Date: Tue, 27 Jan 2026 08:30:33 +0100
Message-ID: <87h5s7pl5y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: gongqi <550230171hxy@gmail.com>
Cc: rafael@kernel.org,
	dmitry.torokhov@gmail.com,
	Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ALSA: hda/conexant: Add headset mic fix for MECHREVO Wujie 15X Pro
In-Reply-To: <20260122155501.376199-5-550230171hxy@gmail.com>
References: <20260122155501.376199-1-550230171hxy@gmail.com>
	<20260122155501.376199-5-550230171hxy@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,amd.com,linux.intel.com,perex.cz,suse.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-20641-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 576CF90BCF
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 16:55:01 +0100,
gongqi wrote:
> 
> The headset microphone on the MECHREVO Wujie 15X Pro requires the
> CXT_FIXUP_HEADSET_MIC quirk to function properly. Add the PCI SSID
> (0x1d05:0x3012) to the quirk table.
> 
> Signed-off-by: gongqi <550230171hxy@gmail.com>

Applied to for-next branch of sound.git tree.  Thanks.


Takashi


> ---
>  sound/hda/codecs/conexant.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
> index 5fcbc1312c697..2384e64eada36 100644
> --- a/sound/hda/codecs/conexant.c
> +++ b/sound/hda/codecs/conexant.c
> @@ -1123,6 +1123,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
>  	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad/Ideapad", CXT_FIXUP_LENOVO_XPAD_ACPI),
>  	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
>  	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
> +	SND_PCI_QUIRK(0x1d05, 0x3012, "MECHREVO Wujie 15X Pro", CXT_FIXUP_HEADSET_MIC),
>  	HDA_CODEC_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
>  	HDA_CODEC_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
>  	{}
> -- 
> 2.43.0
> 

