Return-Path: <linux-acpi+bounces-20573-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PuLAPOMcmlJmAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20573-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 21:47:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1096D88F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 21:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53B32300DF72
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 20:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D1523D28C;
	Thu, 22 Jan 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPKsc5UB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5D2773C1
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114851; cv=none; b=qsBrlorWPcTHLdZvWycBPxRNNZtthGLJZwTnDbP+7f4z7Rpdk81YpfrKkelyqSVW5wPe2nUm3QUPad6CKDAUTWjHka84HoWx6+4IeLV1zwMEHvoaF/jtBRm9gAPWdrMI+0GOoYk6npuHEl/D5Pav5PY1LRYRg1mDt2jAOkp7OSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114851; c=relaxed/simple;
	bh=SX3wCqreKPrkaNADkd11ic1CkdegvIyIq3n/UmcATsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FA548YU3fzQas/Z4UNW+wrOwm1KhZ/wRtQG3y1snKuzuD3ft4fuN4RoUf/b7HybELjlrbyBRd3yGG/zIJNMPFZggN3os5RdiNGU/eE9LqNtgFlAvZQbWZtN7i6EpxG7xQY4sTdaU5vKrYIYEatisG4UAXC69Y+DROn9HsruuJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPKsc5UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA51C19425
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 20:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769114851;
	bh=SX3wCqreKPrkaNADkd11ic1CkdegvIyIq3n/UmcATsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tPKsc5UBc2wzyf4h/i6tFbEGXK5Sj0Hy84Yb3YiCA9aAksBlKiXhSFNYiVyFzZ+cY
	 FEY5bLWIG29Wewn1Jxgn4DxgsH5109VRN8/oEwioHXxEQx5z66EPsUK9gazDlVOm6o
	 PL5TxqyyCDUiXwhG5N6TXQA51aE56v+XLTvTOfIIvvqv4s3X+oFhVl5228C4tmekXP
	 Bsrm6KqhSF7PSthQ52zK9nlyoY7Js8v65gUXqoimNnldEL7DBUU/PfDFa6uw0UcEQZ
	 aiXSvaAt0/nz+rewCRgT8koc089n/sCR6XFZY3ABAZ3wU/k7IdD4KUNOVPqA4ZddcF
	 Vr6fdB+inkf4w==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6611ca93e45so730869eaf.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 12:47:31 -0800 (PST)
X-Gm-Message-State: AOJu0YwrBKC6S3HaX+TGj0ohOzo5bIxbQUvgtBEwNf1jKObYTqolQN7U
	ty9Sk9zCnHKFznxBDAJ1jUQaNx1NXI5IZyuDD5EdiGCRF6pM31gMXw0Bvybfj95ZucCYVYu+j/x
	eAje57h5LhM0he/wGgmOzV4W8nbc3kUQ=
X-Received: by 2002:a05:6820:4b0f:b0:660:fbc0:fc9c with SMTP id
 006d021491bc7-662cab5218bmr457743eaf.46.1769114850087; Thu, 22 Jan 2026
 12:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109001619.37532-1-soyer@irl.hu> <8643ee12-2240-4d28-ba5b-32c08f597af3@kernel.org>
In-Reply-To: <8643ee12-2240-4d28-ba5b-32c08f597af3@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Jan 2026 21:47:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i=QA+A7nxquKoDtKVNBRGRZAzGOQGs-KHH9d3xkrmN6Q@mail.gmail.com>
X-Gm-Features: AZwV_QhGDM8CX8FB3jg3k2lj9mjb9m4bxo9jVylVwbL-laa464lWflDJ_JNHAcw
Message-ID: <CAJZ5v0i=QA+A7nxquKoDtKVNBRGRZAzGOQGs-KHH9d3xkrmN6Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: s2idle: Remove dead code in lps0_device_attach()
To: Mario Limonciello <superm1@kernel.org>, Gergo Koteles <soyer@irl.hu>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20573-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D1096D88F
X-Rspamd-Action: no action

On Fri, Jan 9, 2026 at 5:19=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 1/8/26 6:16 PM, Gergo Koteles wrote:
> > The rev_id is always 0 for AMD since commit
> > e32d546483a2 ("ACPI: x86: Drop quirk for HP Elitebook"),
> > so this condition will never be true.
> >
> > Remove the dead code.
> >
> > Signed-off-by: Gergo Koteles <soyer@irl.hu>
>
> Makes sense, thanks!
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Applied as 6.20 material, thanks!

> > ---
> >   drivers/acpi/x86/s2idle.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > index 6d4d06236f61..a095b6f4401b 100644
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -459,9 +459,6 @@ static int lps0_device_attach(struct acpi_device *a=
dev,
> >                       lps0_dsm_func_mask =3D (lps0_dsm_func_mask << 1) =
| 0x1;
> >                       acpi_handle_debug(adev->handle, "_DSM UUID %s: Ad=
justed function mask: 0x%x\n",
> >                                         ACPI_LPS0_DSM_UUID_AMD, lps0_ds=
m_func_mask);
> > -             } else if (lps0_dsm_func_mask_microsoft > 0 && rev_id) {
> > -                     lps0_dsm_func_mask_microsoft =3D -EINVAL;
> > -                     acpi_handle_debug(adev->handle, "_DSM Using AMD m=
ethod\n");
> >               }
> >       } else {
> >               rev_id =3D 1;
>

