Return-Path: <linux-acpi+bounces-21565-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBWyGPUFr2knLwIAu9opvQ
	(envelope-from <linux-acpi+bounces-21565-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:40:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB93723DBD3
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A06BE302BE20
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7102EFDA6;
	Mon,  9 Mar 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLlwqiGJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2241DC9B3
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077820; cv=none; b=uXkMxxzMwWN+nl5fBMTeEWlpEFy24nYSmM+aQMpAWUc2kpWFQrib8gDEMQvRJcHH45138/u5Xc82sHAyfdJJp7PyxuUeEpaLAg7ozRV8e5/xuKGriyEIg12sMfebUvMXrlB2TlFVU5LXOxNKq4kKB52IhghN8oimjNCi7ZpKCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077820; c=relaxed/simple;
	bh=sp52K5CxC0heARXZZlFUbwDwC09Wac5M/iyh1+X7w3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKIlvm8ZGgBEpGSxS6kGK/wrQnxkjt0s/DPw1nOT/8yOpbSisXQ/rrMbGxYAKgVSIa7j09rFlcFOxeo43NU5axIoyu6si5jqKqiVW3JlhxYEIcnD2zLHDtCzRtp6fffu52Jd2FXbL50pN+gnWV4bYX5YCGqklkFL9jutCmrW1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLlwqiGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786B5C2BC87
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773077820;
	bh=sp52K5CxC0heARXZZlFUbwDwC09Wac5M/iyh1+X7w3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PLlwqiGJTVL/y/DHi1By4P3UoPkTJFqj/3Be7bvN0jzWaS1XKIAypWiyhJGsmDhMA
	 au2Xg+WmqFnbe1nrN3J05QJRNPK80V5qdnogy65Xvar7D/8aOMg5+niQI3mEu3kWU1
	 gJBo549hPtDjmGpO0tt/VDWebjxzt1BCgGLb1gF7nYZWdXC1HE7pj7q4vUb3lo7P4S
	 m8Ohtd1vyKLV8IJpBHwk8zEWGJJ8YTijzGuoSqtgpQrAEn563HXIXmWvrotDjunwQH
	 f3Yjx99lLvL6EQUTbSaos+EDDJrWcrMRWffbV0edm8tX+J1rAi2H1jnqVVWMPiE8uT
	 LfI8x3MjsRTyQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-417400afaeeso655493fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 10:37:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMdF1Ucr+Cmt6/XRzCe40y/g2OU1IdfpSzSS4XbOod8d5G6UEJ47q0yiN6Ol7Dieb2YikQJDpqNVNn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj21mBs2RM41wG4SG81abFrIRJjH6EL+AMvs6dosdGnZGD8p5R
	LuOTuK7znRIVYAeM/74nIFi6q+Z+GJXtiGAdiXflqqZGoT+o/yi53UBgr9jf4w3PpQV1mk9F6OS
	6Iqc3Ly1RISv/3hfhwsNr0hHI1vI9LAs=
X-Received: by 2002:a05:6870:2043:b0:417:6f:9679 with SMTP id
 586e51a60fabf-41756b07c3amr226162fac.19.1773077819519; Mon, 09 Mar 2026
 10:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215002608.54934-1-contact@jingk.ai> <20260305213831.53985-1-contact@jingk.ai>
 <cc7f4a69-750d-4541-b7d0-4e5f9446ba6c@huawei.com>
In-Reply-To: <cc7f4a69-750d-4541-b7d0-4e5f9446ba6c@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Mar 2026 18:36:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iik3xrAi8y9_KOmxcRdY0uHpQj4Dx_6P296diR6x6i=Q@mail.gmail.com>
X-Gm-Features: AaiRm50tTeAJ_Zp1Ino-wiRdocqPYIVy3xSCqBDoo-9sEF3CoILgbpIdPAhogdw
Message-ID: <CAJZ5v0iik3xrAi8y9_KOmxcRdY0uHpQj4Dx_6P296diR6x6i=Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: idle: Add missing bounds check in flatten_lpi_states()
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Jingkai Tan <contact@jingk.ai>, rafael@kernel.org, sudeep.holla@arm.com, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BB93723DBD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21565-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,huawei.com:email,jingk.ai:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 2:04=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com>=
 wrote:
>
>
> On 3/6/2026 5:38 AM, Jingkai Tan wrote:
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
> > Signed-off-by: Jingkai Tan <contact@jingk.ai>
> > ---
> > Thanks for the review Rafael.
> >
> > Patch v2 as per review, flat_state_cnt is now checked after increment, =
and the warnings are left to outer loop to handle
> >
> >   drivers/acpi/processor_idle.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idl=
e.c
> > index 81f372c64074..dc4a24560d1f 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -1068,6 +1068,8 @@ static unsigned int flatten_lpi_states(struct acp=
i_processor *pr,
> >                               stash_composite_state(curr_level, flpi);
> >                               flat_state_cnt++;
> >                               flpi++;
> > +                             if (flat_state_cnt >=3D ACPI_PROCESSOR_MA=
X_POWER)
> > +                                     break;
> >                       }
> >               }
> >       }
> Above "if (!prev_level)" switch may also need to this check.

That one is covered by the existing check AFAICS.

