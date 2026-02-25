Return-Path: <linux-acpi+bounces-21175-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFhbA4Fpn2lRagQAu9opvQ
	(envelope-from <linux-acpi+bounces-21175-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 22:28:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095519DD6B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 22:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8858A301AF6A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 21:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6B6314A67;
	Wed, 25 Feb 2026 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iETtShfk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B695313E31
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054906; cv=none; b=fDP6VPdXuwu6Ej47dQwJYsXsKX7gVyLGgCjN2K8x6nwK+1hlrng70IySmD/Z/5XYwht3pSZIWYww06kpj1dG6b6z5TIrIRYC/JEcmR5q94YXIE8uo9dSRjYBUWM7fEemSB6mMqjcpo4qhu4bC0RxXbGy2q16NNkd/TAtPmCb4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054906; c=relaxed/simple;
	bh=WgVE1N38Q0IJ0mq4OkP4/CC2659nsW2oNrHn/t5bmBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGBWwLB97vasI3G45u48kPiWjtfS6vTAf7ye3IjC0fTM2HGA2L5TYWDlqCzJaqBpipayQP5opwW4V2VJI7s9HUkPmF9FbyDWwx9IopThOoEtZz8wYfWnPPrq7GtvwQ7O4aJfW5Abj98SrLpDUhVNknu8ZS7YQFTKXrUIgJGuHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iETtShfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DECC116D0
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 21:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772054906;
	bh=WgVE1N38Q0IJ0mq4OkP4/CC2659nsW2oNrHn/t5bmBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iETtShfkw3DD8GnCnoOBsq15ZSV9kR5w0abFL8UijC8vuZaG5SZzW79Dah2/ne3gX
	 w6lGWskaxF+GzsW0jtMo8cCqYZkJJ7Wk2+rArASEbo2xEgpSd6FoWDUVcUALoeYgIY
	 Ybn4WVuiBLJakv4g5f2PK18HraP1vJ1HWKUvFHrjowCMYQ92yoLeEW+aqIP0NM2KKD
	 mKhRxuTPnaqLplEeTc6NvsxTw2BQxFHKa2RA50CZUCF0YUunxSug9hsh5KbIiKW8j4
	 YU3KCdV0JANBGa54k9tmjetJF4owl5+O3w29eNlfsqcvTaTnbH+9OcvmJ+XLVJv36T
	 iyITAUdjbydyQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4bd4db87aso33947a34.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 13:28:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7PX9PYXfxInEF2YOEqvWwZolNvWN0gRfNvK4ZsoVi1tuDNuv3mVlXSoW1RDKn5yKIt3KGOKDxS1zJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZ0VjB2cHtrlseZ2vPMrgO7svRS+cpz4pNtCJzeor+UJGxZBS
	gLpbhdUY8r0f0AcXS+NiDR1qNXkHl6fyQan+QeylcanqWrd8f6wDzKkPs9zNnEFl2RALPaowRAc
	Ia4gQSi7Fx3+16yiuWZl9C8XIQWQR69w=
X-Received: by 2002:a4a:ee83:0:b0:678:1305:bf2e with SMTP id
 006d021491bc7-679c44c20d0mr9056961eaf.38.1772054905207; Wed, 25 Feb 2026
 13:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204212931.3860-1-W_Armin@gmx.de> <c5d23d8a-8f58-48c3-90ca-5d1a46964280@gmx.de>
In-Reply-To: <c5d23d8a-8f58-48c3-90ca-5d1a46964280@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Feb 2026 22:28:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g6w_2+4oUytzxHtAhsJczK9pe84ZfXPeOcjKqU0k_GkQ@mail.gmail.com>
X-Gm-Features: AaiRm51OuF29b5A9KFKStZFiwB1PeK3lhJvrMty2Psu1IsvLLS3suytT0_LTM3w
Message-ID: <CAJZ5v0g6w_2+4oUytzxHtAhsJczK9pe84ZfXPeOcjKqU0k_GkQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: OSL: Poweroff when encountering a fatal ACPI error
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21175-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 7095519DD6B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:06=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 04.02.26 um 22:29 schrieb Armin Wolf:
>
> > The ACPI spec states that the operating system should respond
> > to a fatal ACPI error by "performing a controlled OS shutdown in
> > a timely fashion". Comply with the ACPI specification by powering
> > off the system when ACPICA signals a fatal ACPI error. Users can
> > still disable this behavior by using the acpi.poweroff_on_fatal
> > kernel option to work around firmware bugs.
>
> Any updates on this?

I was about to apply it, but then I thought that I was not sure about
the Kconfig option.

 I don't see much value in it TBH.  If you agree, I'll just apply the
patch without that part.

Thanks!

