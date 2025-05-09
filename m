Return-Path: <linux-acpi+bounces-13666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E03AB1E57
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 22:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A871189D86A
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84225F79A;
	Fri,  9 May 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv0NjCB0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123D78F39;
	Fri,  9 May 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746822230; cv=none; b=D423SiVFe4z9sWqX4Iap3grzvDcWYdW1N+PkkY7pz+1KCMZtD5K5AkHITEUtNBiGwbA923hFVgnK55u7TzSrBJ/LaboVgIeVcgtRs1qAvD3hPYWBfe5liLuTsn+on9eU4Th8scAxjUfsNLNgNx2uFurCmx6WvoTlrT8ggMIeMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746822230; c=relaxed/simple;
	bh=aYUg2+hUS6gRYV4KOfnd/+I9Ac57eN2wWuzrH4/Yu6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CekwaPdA7G+XwwKsr80hGCq1K3d6NyN3pkZZlzYlk+2fPAzF0DcAb4rY5ecEq/R1SJO5PKSwZ5KVtm47dpAql+zTegVmS8LfTPhGabOrVs99dFpUqqhtnSyhiivzf1sBu7IDnjttiGvOimYtYxMsOWp4jyUvrsPq8WGE8yvLrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv0NjCB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E204C4CEEE;
	Fri,  9 May 2025 20:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746822230;
	bh=aYUg2+hUS6gRYV4KOfnd/+I9Ac57eN2wWuzrH4/Yu6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uv0NjCB0rN7Fk8rxFl5SPB8458ZUFWvwMdiGX3dhEPCW5R8cvR7OqXXqGM9hi3dXH
	 m8KUDlXL5ce7g61/BczaJdKB5HvMqRxwLIg/RD40nxezG/BBIXHijuCf7AceipjvWn
	 JZlOP6Css3/u15QBumwUwYZB2GO96C7iMxRKWf/qJ6TJIm/bRr+anw41YwxhUBS17G
	 AvLYXuumza5LdEzOpWeQtVdbx1Yr4+baAGnPo7O4VtSZZyT27KPNWxXv/44CI6M6XZ
	 PYvIwGfs8OyJlH2U2P8r1HBJlHJhlrhUhsSfzVb7Vl9253gnRBogoYyMFTSx1i7U1W
	 fCnZ6iVnyJ34g==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-606648c3f9eso758671eaf.3;
        Fri, 09 May 2025 13:23:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAZJyOrZQBsQ+/6iVXIGlpsKItDDc8pTJNKWQDS7tlMEA5au4adQKLTOsk4jK+uogcbgSVK/52kQr7@vger.kernel.org, AJvYcCVlyWnZsK1P6m+ltUhXj/zYsKMQCoEET3eMs4odX/hpYwusUMrHrocxhyOYAmfG3UGuUPSuyiTSJNGAJquN@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOXyc2CShoZ8t5sEAwtxR6J9XBmcKLG8vmnOgVOQsHCMUlIDr
	n1zQ3Ji2U4hxwBEdrq/alj6eDsDyIzk7GQuD8z1Hf5s80YZAZxYo1ExREqCnqAcg/acv7TL9dTo
	xFWZpYg0AIS0tmTdU5Ham9V0nzC0=
X-Google-Smtp-Source: AGHT+IGlLMS7WX8iOt4rSK/Yu4qopuzc9SljhCNqzH1O8eImjPCKMhg3sEZ3Uc5HR92eeoUdo9i1cY/rIDLyeSDGfJg=
X-Received: by 2002:a05:6820:1b09:b0:607:cc1a:572f with SMTP id
 006d021491bc7-6084c0e419fmr3010485eaf.6.1746822229397; Fri, 09 May 2025
 13:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508111625.12149-1-wse@tuxedocomputers.com>
 <CAJZ5v0g+_8LT6YKSuOXHtxE-HLCZ2hxKuT2514HgQ45xyWy76A@mail.gmail.com> <994476b8-fdc8-4123-ab39-de8f1629c27b@tuxedocomputers.com>
In-Reply-To: <994476b8-fdc8-4123-ab39-de8f1629c27b@tuxedocomputers.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 22:23:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSvd1RhZRx9iZs=zNaiUcxEhz+41285iecMBRjeHV0tw@mail.gmail.com>
X-Gm-Features: ATxdqUH3L6rW9T2GO73D9JtHuRfr_pFQkvaudi7Z1NMAc8vefNy7i5qqXWk2bVE
Message-ID: <CAJZ5v0hSvd1RhZRx9iZs=zNaiUcxEhz+41285iecMBRjeHV0tw@mail.gmail.com>
Subject: Re: [PATCH] acpi/ec: Add device to acpi_ec_no_wakeup qurik
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 9:49=E2=80=AFPM Werner Sembach <wse@tuxedocomputers.=
com> wrote:
>
>
> Am 09.05.25 um 21:21 schrieb Rafael J. Wysocki:
> > On Thu, May 8, 2025 at 1:16=E2=80=AFPM Werner Sembach <wse@tuxedocomput=
ers.com> wrote:
> >> Add the TUXEDO InfinityBook Pro AMD Gen9 to the acpi_ec_no_wakeup quir=
k
> >> list to prevent spurious wakeups.
> >>
> >> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> >> ---
> >>   drivers/acpi/ec.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> >> index 8db09d81918fb..de45a5b59effd 100644
> >> --- a/drivers/acpi/ec.c
> >> +++ b/drivers/acpi/ec.c
> >> @@ -2301,6 +2301,12 @@ static const struct dmi_system_id acpi_ec_no_wa=
keup[] =3D {
> >>                          DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP=
 ZHAN 66 Pro"),
> >>                  },
> >>          },
> >> +       {
> >> +               // TUXEDO InfinityBook Pro AMD Gen9
> >> +               .matches =3D {
> >> +                       DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
> >> +               },
> >> +       },
> >>          { },
> >>   };
> >>
> >> --
> > Applied as 6.16 material, thanks!
> Forgot to add cc stable but i guess i will just wait till it reaches main=
line
> and then send it manually?

I can add a "stable" tag to it, but it won't apply to older kernels
anyway because the table has grown recently.

It's better to send manually when it gets merged I think.

