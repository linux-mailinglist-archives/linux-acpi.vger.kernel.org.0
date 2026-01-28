Return-Path: <linux-acpi+bounces-20743-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCq8Amt0emmE6wEAu9opvQ
	(envelope-from <linux-acpi+bounces-20743-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:41:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7CA8B6A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 249F13005668
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9C37417D;
	Wed, 28 Jan 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QehcbacJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F636F43A
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632869; cv=none; b=Sep+HbH6JdLb/Q1NJnTWIhBwcOowyQpbvu9tZSJ+6xWezUERxlVRMwkIUac55YEtotNhRQ9XfCZCA4s21yw7amF5WQYd/g+kPfeKt6Hr0sM/oSzVF2/0kZYQGXpLHyzKJ18m1TA9LPvGt1o0j7GGMUhhPW94nsy6ULm0p0zX8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632869; c=relaxed/simple;
	bh=UPLplZzcZSYphbcqdHdZEyXc5q2Cb9HHm9EOZUzWpj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRQ3Dyv8XaMGnNfLa+AHI3DqRSNLq5yOriJWXtvQTxbtPOMu336c5DnwDKi4/ZALeyBLlvoWucRudhECyyy4a2kZk10JMLJioz8ISwCAdmuFGCU0VTor5UjUze59KjkCRiWuYwxbxOPGYQFhUAvexEtFpLRWLdZQcI6uxImVX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QehcbacJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B41C2BCB0
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632869;
	bh=UPLplZzcZSYphbcqdHdZEyXc5q2Cb9HHm9EOZUzWpj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QehcbacJy0FP/Q8wz/EYrYcqK7x3MSAZrzqCT+2NSSDNlaQFTSFAWRGGQN5yaSm/W
	 1rhBvLamw8ob/hPCxbZOw1yfrl/Zi/1UUkEkDGHaPTiktTKM2MyrgXvzs42Xxk3WNk
	 00/NW4MTqO4SwCT4OhSbZJxPOpl+VOz9Ul7nyGOOkPhe1p7l4lNR2FKnN5RTPVjgR3
	 aqrfsfwM9/rx7xuokn5/7OuMvv3P8dkDzaY/UPUOrIaCdgQur3voMKWYE5eXkRJPCv
	 +wk9sZ9cYrRc//3BRGJCBw5cRx16gSN+PmW5riLCAWRzMJfzFOTxGN6RIR5d+bUsmi
	 XhKUWv/LKK9dw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45effa36240so250066b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 12:41:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5htJGllhuLNMZDE5g7rG6hC7GUYkyO5XeTQx5DqmAvUcPN0G16jQWaK/ivRIOiaLnNs/sPrYwv4zZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TF9xv655ATHY9DiRpFPpYfMRgRLIOLWQue84H8YZ3yUNai5g
	fWVflwvEBlbwy/nra0UgAwul/fQpfRfSSO5GneVSQKZ4AqwOm+3/xY9q9fUvXfVN0ijuwW/b9Eq
	LTp6eQFCNMrI7Z8d5nZ8GgFq3NogS2g0=
X-Received: by 2002:a4a:eb82:0:b0:662:f39e:efa5 with SMTP id
 006d021491bc7-662f39ef127mr2822816eaf.79.1769632868386; Wed, 28 Jan 2026
 12:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128025216.12564-1-TonyWWang-oc@zhaoxin.com> <20260128123105.GBaXoBiSoIJnE4RF66@fat_crate.local>
In-Reply-To: <20260128123105.GBaXoBiSoIJnE4RF66@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 21:40:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0goSxh23WQd4wB5Asw3=06xhLfKFgFwM5f94Af0wBaFDw@mail.gmail.com>
X-Gm-Features: AZwV_Qg7lhDDGG_lG9kmLFjCMMdYkhVwa7HyZZzMHImx1zh3yatYCeqz71SFpas
Message-ID: <CAJZ5v0goSxh23WQd4wB5Asw3=06xhLfKFgFwM5f94Af0wBaFDw@mail.gmail.com>
Subject: Re: [PATCH] apei/ghes: Add ghes_edac support for __ZX__ and _BYO_ systems
To: Borislav Petkov <bp@alien8.de>, Tony W Wang-oc <tonywwang-oc@zhaoxin.com>
Cc: tony.luck@intel.com, guohanjun@huawei.com, mchehab@kernel.org, 
	xueshuai@linux.alibaba.com, jonathan.cameron@huawei.com, 
	Smita.KoralahalliChannabasappa@amd.com, leitao@debian.org, 
	fabio.m.de.francesco@linux.intel.com, jason@os.amperecomputing.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com, 
	LyleLi@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20743-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 77B7CA8B6A
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 1:31=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Jan 28, 2026 at 10:52:16AM +0800, Tony W Wang-oc wrote:
> > Let ghes_edac to be the preferred driver to load on  __ZX__ and _BYO_
> > systems by extending the platform detection list in ghes.c
> >
> > Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> > Tested-by: Lyle Li <LyleLi@zhaoxin.com>
> > ---
> >  drivers/acpi/apei/ghes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index b49a5da46788..f96aede5d9a3 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1897,6 +1897,8 @@ void __init acpi_ghes_init(void)
> >   */
> >  static struct acpi_platform_list plat_list[] =3D {
> >       {"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
> > +     {"__ZX__", "EDK2    ", 3, ACPI_SIG_FADT, greater_than_or_equal},
> > +     {"_BYO_ ", "BYOSOFT ", 3, ACPI_SIG_FADT, greater_than_or_equal},
> >       { } /* End */
> >  };
> >
>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Applied as 6.20 material, thanks!

