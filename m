Return-Path: <linux-acpi+bounces-21425-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEK2GbKiqWl5BQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21425-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:35:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E707C2149D8
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C370302D5EF
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2B3B8BA1;
	Thu,  5 Mar 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjyMxvF7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548B43A875B
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724878; cv=none; b=MKr9vYxdpIa6MEhck+k2734f27hBR2114mhmPpMI4B14JLUCE1ypPFuZUAajO6A4Z1uifFxbMdXBV5HlnYfX43Xdp5Od1I8OUdAZCe6v4fxVh42SQ4sPo/OAs0aRl5HmHEC6/Q/09hK5o79uj2vgVx+zDrG6XL4wewWj36cuuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724878; c=relaxed/simple;
	bh=9hh9U6WJqNUjDRK7TNGkwZFj/DP05tvBSPzoFLXQ/V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd/X5HbAC0yeX0pZlkRDSsKgXbpvmeh5gAYU8ebT53cZwZgVrHeOqNH8IsffsHKsOHXvL9zdVE+VzDm0hwD+575e80F9b7TzmRZ6fbi8BVvCBuxLC4gj2axT383Gg/Y9ettKxydDBAJUTfvw8HOX3+w5N091YIAFBmRB1mNgGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjyMxvF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13324C2BCB1
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772724878;
	bh=9hh9U6WJqNUjDRK7TNGkwZFj/DP05tvBSPzoFLXQ/V4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZjyMxvF7QCrFn4BZVrzE/dh0S2/F7Gp+ttPbAg+Eg6GPedbqlWrWIPBeB/fh3v+pO
	 v6KEHVaJX7/fCVWDjrg8A2ZhaqXFV07cQ1bMVB8u/JODa2Yjfup3bTG0xkwdyoHH3i
	 bS3xRwtn2B7DWYT4BZ6wiUls9uHJ97ZxgCNs4d8Jyv1CfZoU6SlyOQg4Ps00cNs6Cl
	 36f2XAgprvt+l2Fg5x9df7DeXpEoao+UVXWmWJHL7tkCL34fdVqx8X5CYH8zcQ9PMt
	 ig+t3tHQeWZsaJoiITayjIikldeBQC+DRnuQD9btysq93n/wW+Pu1HBwjikaBbnLlG
	 kJxeXh0bD1KkA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so1275337fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 07:34:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyV9ZpT9gFs4LZyA72nJQYr7bNjAHIUbDIcS3QwBZDCxXi6z2+Sx74AVBB3735Ahu/HafXqIOU/WyH@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBZyodmYgRGOnKlcOXKrOcrejbgv/MJALMuky0Nq/C4zMCXvi
	F6jwZ3uRFh8Sx0g+DJT8F//ZQINNjTH5z8v/tGmF+rud8wtqrh4l7vBMJxfDxJuti70jp1ZSyDt
	UHUSNAAFwftp3Rpf1EFDWCfWEIrDoUKQ=
X-Received: by 2002:a05:6870:171b:b0:403:fde8:ee9d with SMTP id
 586e51a60fabf-416ab595545mr2938234fac.17.1772724877099; Thu, 05 Mar 2026
 07:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki> <2553054.jE0xQCEvom@rafael.j.wysocki>
 <aamgGkgfFh-cQNfF@tzungbi-laptop>
In-Reply-To: <aamgGkgfFh-cQNfF@tzungbi-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 16:34:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jYk+RQu5RKUUh4caUE9vPQDgK1ss8B+=-HfPLZP6RsyQ@mail.gmail.com>
X-Gm-Features: AaiRm50SwplyiOcaEfjRV5S0tH-LmdmZpdT-zLanw85kKgXZF6PCWHO8erx6-L0
Message-ID: <CAJZ5v0jYk+RQu5RKUUh4caUE9vPQDgK1ss8B+=-HfPLZP6RsyQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] platform/chrome: chromeos_tbmc: Convert to a
 platform driver
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, chrome-platform@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
	Ravi Chandra Sadineni <ravisadineni@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E707C2149D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21425-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 4:29=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> On Wed, Mar 04, 2026 at 07:44:26PM +0100, Rafael J. Wysocki wrote:
> >  static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *=
data)
> >  {
> > -     struct acpi_device *adev =3D data;
> > +     struct device *dev =3D data;
> > +     struct acpi_device *adev =3D ACPI_COMPANION(dev);
> >
> >       acpi_pm_wakeup_event(&adev->dev);
>                              ^^^^^^^^^^
> If I understand it correctly, I think this should also be changed to `dev=
`?

Yes, it should.

Essentially, this needs to be the same device for which
device_init_wakeup() has been called.

Sorry for missing this.

Do I need to resend the series with this fixes or would it be
sufficient to send a v2 of this particular patch?

