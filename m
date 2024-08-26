Return-Path: <linux-acpi+bounces-7833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD7695F803
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194711C22345
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 17:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA13198A16;
	Mon, 26 Aug 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXarxCNz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCC19885D;
	Mon, 26 Aug 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693126; cv=none; b=CYE2cT2UYlkDEQ5hDLyfWU2i6tm12C2mTksAdRhgmB/B6ct12bT6J1vwKVWLY9PQdZUpsC8dv69oudnhmtKF1ByXNn+0y8T17PXYjHH3HcppARgkFontP2o+9pO6wAFDw7nBSsrRrq5+1maHspmdbHTgHfrrY0FvO7K1j2fJ9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693126; c=relaxed/simple;
	bh=Qvoeu6U35kaE3UwWqbZeFPf0X7+CHgQGK1MtVW59ByU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4A3tw80WVASflT77kAdpfiopP94b5p4hW5Kyd46gH0jPlz6qBMHR/0OaDIFHe8yc3HDnsR1V8weKbvk5H9A39GIUhQpuzwEie6D2/6xL8giwUfox2OZUkKtojtRu05sBqxl9CsXr9piDn5ytg2NZYsLvqFRvl40TCX+I6diQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXarxCNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC90C8B7A3;
	Mon, 26 Aug 2024 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724693125;
	bh=Qvoeu6U35kaE3UwWqbZeFPf0X7+CHgQGK1MtVW59ByU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rXarxCNzoV9Ktp+PqPk9qOGbsaZM6EaQDSfTrSlWB19n3eu3SEGDKT4PH8FYR+5sh
	 xHizp4lrGFHEIcc4Wxoo+PPglGPofhhZ7iMjN+8wa/KeqVzBcld/JxImPa/M6sQ5D+
	 gyWKamm3m6v9j+Jd4iA/GqqS1EBJcR3IKIbqz2RGPCDPDZ+vC9Akkx1s29Qd9FNhLF
	 s0DxJFduYszzmCW71ZJnZ+ykFgzgoxS90iWwT8CcsXSBtGTQ64CNqT//S4VA3HIDjf
	 jD+TGaz2373EaAk/uhzaxPF+8mhlGgK3fFZ+TmOxC2b9ZL+ZSw4vViUgBlhhauqyS1
	 34jm866gRvAyA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27020fca39aso3988451fac.0;
        Mon, 26 Aug 2024 10:25:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVy5hFdCgXGRre3L1CuB01R+6UDvZx91vHspnqkBRb3nQhTtE5NeVdDqzJg0DkBTj/8iUAoBkQk0Ek@vger.kernel.org, AJvYcCWMDk6oqjFNA84VY564tSJvOW6ynqXFprbRXwLhWChCaC6IunCcqzCUa7lyXtMFccoayRkhv2S2lxeuA85x@vger.kernel.org
X-Gm-Message-State: AOJu0YwhD34ph9uvfze7nT/6mvq/dEBAUJnep7eoPGyvJVNlJQlFjvmD
	H5gmgFh9U8P722sSOa0QAcIxFjwdO8oOYyB8Q/SaZzGIOu9jjPgOENU7mP8NWdVHINVB2CXa8eG
	d39+tPLMxqMnwhqJfmnQqtS+HnCY=
X-Google-Smtp-Source: AGHT+IE1Fi9RSg1vS188vY2+eUm0PsWqo7nnlZiQW99GIuYXUoV8jYV5SNGwyoRY3ooq3muQFlzFvRdR1/UtGto+ed0=
X-Received: by 2002:a05:6871:151:b0:270:4219:68fe with SMTP id
 586e51a60fabf-273e63df560mr11934679fac.1.1724693125157; Mon, 26 Aug 2024
 10:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-acpi-video-quirk-v1-1-369d8f7abc59@chromium.org> <5145dd51-d095-4185-920e-eafb33219e07@redhat.com>
In-Reply-To: <5145dd51-d095-4185-920e-eafb33219e07@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 19:25:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJ5+USjDpSY1zKwboiqGm=GUL1BRBTasvND1Tp99R4fQ@mail.gmail.com>
Message-ID: <CAJZ5v0iJ5+USjDpSY1zKwboiqGm=GUL1BRBTasvND1Tp99R4fQ@mail.gmail.com>
Subject: Re: [PATCH] acpi video: force native for Apple MacbookPro9,2
To: Hans de Goede <hdegoede@redhat.com>, Esther Shimanovich <eshimanovich@chromium.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:25=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 8/6/24 10:08 PM, Esther Shimanovich wrote:
> > It used to be that the MacbookPro9,2 used its native intel backlight
> > device until the following commit was introduced:
> > commit b1d36e73cc1c ("drm/i915: Don't register backlight when another
> > backlight should be used (v2)")
> > This commit forced this model to use its firmware acpi_video backlight
> > device instead.
> >
> > That worked fine until an additional commit was added:
> > commit 92714006eb4d ("drm/i915/backlight: Do not bump min brightness
> > to max on enable")
> > That commit uncovered a bug in the MacbookPro 9,2's acpi_video
> > backlight firmware; the backlight does not come back up after resume.
> >
> > Add DMI quirk to select the working native intel interface instead
> > so that the backlight successfully comes back up after resume.
> >
> > Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.12 material with some minor edits in the subject and changelog=
.

Thanks!


> > ---
> >  drivers/acpi/video_detect.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> > index c11cbe5b6eaa..2d377414f873 100644
> > --- a/drivers/acpi/video_detect.c
> > +++ b/drivers/acpi/video_detect.c
> > @@ -547,6 +547,14 @@ static const struct dmi_system_id video_detect_dmi=
_table[] =3D {
> >               DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
> >               },
> >       },
> > +     {
> > +      .callback =3D video_detect_force_native,
> > +      /* Apple MacBook Pro 9,2 */
> > +      .matches =3D {
> > +             DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> > +             DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
> > +             },
> > +     },
> >       {
> >        /* https://bugzilla.redhat.com/show_bug.cgi?id=3D1217249 */
> >        .callback =3D video_detect_force_native,
> >
> > ---
> > base-commit: d9ef02e56f0fd3668b6d7cb17f9399ea53f12edd
> > change-id: 20240806-acpi-video-quirk-f1c9f01f07d9
> >
> > Best regards,
>
>

