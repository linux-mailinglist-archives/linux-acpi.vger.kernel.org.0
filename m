Return-Path: <linux-acpi+bounces-21567-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKpdI/0Xr2nHNgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21567-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 19:57:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC3B23EF58
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 19:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3725830180AF
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE636165F;
	Mon,  9 Mar 2026 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB388eVL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24727467F
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082454; cv=none; b=IhM2OyzgmKJIzWFwZPjYV1C/58vy9IR5NidmuhyPkesr4JyHh25+uRtCr/pB8q1fjocsfZLLmR6OzKJhk69UhtMV3P5bhKS0blblODgF4Kp1lIcWYG5ebmvOcJ/hwo6S3GAJhpIAHI/XU2elmIwhQRtOdr2Z8PSjZVBIKjpzD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082454; c=relaxed/simple;
	bh=3Y4zutod5x/Bn7XxYias+h3PaC3h123Q65BXDeLPTMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zfb9zDmG82xpgyiXwlrkYJ8IE57tY8c6AG85agzpv0AWfV6AplyqoAo7SRD3vKBlgrOkSoQuQYjSlyKl/jULc88BcG71TeQ+jLe4K3JGwonoFq2AHoc1bkQ9JQGCCvP4DLWJZNXvHYJaOhVIKr7iW9rBCYRMxL6EZgmfIKxb7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB388eVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E919C4CEF7
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 18:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773082454;
	bh=3Y4zutod5x/Bn7XxYias+h3PaC3h123Q65BXDeLPTMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EB388eVL15LAoYOBdrx1a5sybLbkwa3mw947FMQMT/tqycstzltd+BHB4p/7u4+Gh
	 p3XmRIztPSHWFs08ahQGur06Fs6p+2/Pj8RGAPJJdzhcRQUS8MuKm7IDL/AW/7wquj
	 7aF8XuoIyzuqtmC4MTEUU4RfcOat/X56zByBCKPCyHlawcH6RLNYk+9gyOyvDgMSwh
	 exMSWTq53XPKW1IsoWHzeXOo+dt+CpTSSvSu29DU2WakHNX0zMjTshflfbybVFypXa
	 ohDpyRSQXvloMhsUb8VsNhVM5nu6nTRbzXJyztAZDVJGeMrefJluhOM7wJM2PaEv4g
	 QTtiEz0KeKafA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d75371d873so984037a34.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 11:54:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyek1Mq6Qb1B66qQzsciDKS+kz8mfHZtjkYCZUxBDAIQKZZKCT4xLyhQkl7RUotTuErkeWXtNxTTAt@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnru4Sd1QzSvE+QSJqhEpV9sgNjN4NVbxq9WY7mezFtePx++m
	nHNTdmCfJeCr+P4D/VtclWAbyULDVWwOGll8lNOU7qUyngbDIhm5zkKCkf2oZ535fagpfuYuIyH
	MfUTdVrnRWrNc03e4CVGQwQFzPsA5/9c=
X-Received: by 2002:a05:6808:6544:20b0:466:f3a2:dc37 with SMTP id
 5614622812f47-466f3a2dddcmr3254667b6e.30.1773082453425; Mon, 09 Mar 2026
 11:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215002608.54934-1-contact@jingk.ai> <20260305213831.53985-1-contact@jingk.ai>
 <20260306-fine-golden-koel-dccbc1@sudeepholla>
In-Reply-To: <20260306-fine-golden-koel-dccbc1@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Mar 2026 19:54:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iTO7kpBLaue_gRpECu1DW_KcyYjTSrTFD_WzOVNQEuYQ@mail.gmail.com>
X-Gm-Features: AaiRm52Z7jc4ywI3BivcmXq17Dd7bTD-ewyZwNNdJIhXtjfC9dNX_o0AjguhXIM
Message-ID: <CAJZ5v0iTO7kpBLaue_gRpECu1DW_KcyYjTSrTFD_WzOVNQEuYQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: idle: Add missing bounds check in flatten_lpi_states()
To: Sudeep Holla <sudeep.holla@kernel.org>, Jingkai Tan <contact@jingk.ai>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DDC3B23EF58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21567-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 10:18=E2=80=AFAM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Thu, Mar 05, 2026 at 09:38:31PM +0000, Jingkai Tan wrote:
> > The inner loop in flatten_lpi_states() that combines composite LPI
> > states can increment flat_state_cnt multiple times within the loop.
> >
> > The condition that guards this (checks bounds against ACPI_PROCESSOR
> > _MAX_POWER) occurs at the top of the outer loop. flat_state_cnt might
> > exceed ACPI_PROCESSOR_MAX_POWER if it is incremented multiple times
> > within the inner loop between outer loop iterations.
> >
> > Add a bounds check after the increment inside the inner loop so that
> > it breaks out when flat_state_cnt reaches ACPI_PROCESSOR_MAX_POWER.
> > The existing check in the outer loop will then handle the warning.
> >
>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

Applied as 7.1 material, thanks!

