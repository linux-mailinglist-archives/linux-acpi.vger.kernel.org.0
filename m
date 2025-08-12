Return-Path: <linux-acpi+bounces-15624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6C5B23942
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 21:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504352A8583
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDAD29BD92;
	Tue, 12 Aug 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH+HZvs4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E212C499;
	Tue, 12 Aug 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028194; cv=none; b=e9kOhIVhN1og8Y4suXz3OjwHMCNjK43WAJ1VrYQtmlztlS7UA0GB7qUETstYZoKsdbOjWDE9Mn5zFQvLYs0N4l/1WaGEEaBeEmEOuM13ud/xknJLTy3+eEK6ke30f+c5Jr8OfPB3//dSepQnZcsquaSnNzwhBrf5sqL9grQ6Q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028194; c=relaxed/simple;
	bh=s2p/sTnK+HKS1ffdbIHQ+H3N8RmwFvpmZuRncBeoMsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEqxRTnlQrQr6iIj8swwMc3haL7LXWyeNMqhTD0lx6ySSnvTlpnkrWVBwBhrP/o1FwTX5uGpSMQEht64yKJNrfzOU1mI8TLr02n/6rle/gb5KfUsAvd2J/J36IT9/ZFbOGaEl6/fqwzjOqfSpPJo6uS1rY5Eg3r8B6mFSOz8W/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH+HZvs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBE1C4CEF1;
	Tue, 12 Aug 2025 19:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755028194;
	bh=s2p/sTnK+HKS1ffdbIHQ+H3N8RmwFvpmZuRncBeoMsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nH+HZvs40t/5ZzKOB3aWkbE3LcJgniwXOBMzJ6tCwbLFcv9RCubuuJgmLe7y5EPTI
	 9+q8ota5JEbbzDju/P33lGBq5kHt8HjNf5MI00bL+fuIgEf7to7E2vzchSdCCc1+HX
	 OEyxvnWg+OzGFVxp9CtpsYdCJ5WfF7Kvh9VERiK3l5DH4daiBv/SBNFynOf0QdJNYK
	 +cbAoY5wNd8QU9Z+QEiXIz2lj7LkpjqsM7sTv5hCyBObiU8P3Gj3TdSTtaf9m4CwI6
	 08+DEfRRPTS3MCzT8N+07q+B5LMyCtoPKaLHFD9x8vOcr4/eE3ZIyKGP9axbAXMmsl
	 fK31TojnPqY4Q==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6199bd72532so3553336eaf.2;
        Tue, 12 Aug 2025 12:49:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUd1kCFGjye1M0RVoA1HLTFbciN1RTxu1s3T6PaI6spbZ/u6tiqzoq8ssaq6aYFyE7v8p+7OZG8@vger.kernel.org, AJvYcCW/8MYHfK+iE5GZvIG78TEdqEcZWRwJ6VQqg/fjxSzcMNmTSp4pjoC4Z/+6N2XrxR6kGtPxQ3X30D3Z@vger.kernel.org, AJvYcCWViIU4Vtpi2+ltHCqn5KOACgrwDYbiB/SbLqt8j8fk6s4l2C8OUdwQjtDyEQSPlUMWAkFLOuPTvTHcslsn@vger.kernel.org
X-Gm-Message-State: AOJu0YzypSxn++XT9y9yxuwq+YGQqMIeoN2BRZSvQldhkFepRbkLF5Z1
	Cgo1JB4v7P3hsG0ADHmhTImbOcuE4d4vgWhB6PNxezoQzZ1CW3PZqIz+GiLCe0cw3kvei8P60Xu
	fmIvuyDzt8CgOFhs5Na1GNdgPgEjLNLY=
X-Google-Smtp-Source: AGHT+IGQ9RJLQno5xCPQDue/Pm9p95NKW7jlFbnxFgVcGsyQ6lYFx1UCrgMfuj55E6cwZf7OJ93eny6Tqc8E5QXmgNQ=
X-Received: by 2002:a05:6820:1504:b0:61b:931a:a9a5 with SMTP id
 006d021491bc7-61bc74fd3cfmr116337eaf.4.1755028193608; Tue, 12 Aug 2025
 12:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729062038.303734-1-W_Armin@gmx.de> <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
 <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me> <2025081246-raft-tattle-642c@gregkh>
 <4e610854-d84c-4a59-9f83-422eafb40d6e@gmx.de> <2025081227-humpback-garden-7a4b@gregkh>
 <d51317d4-92da-4617-970d-6a63236aec30@0upti.me> <2025081250-subsoil-tropics-91a7@gregkh>
In-Reply-To: <2025081250-subsoil-tropics-91a7@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Aug 2025 21:49:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4FLDqpQytS5H0OGWwZtdgbAppRwyGfrfyKzzbDqvH6A@mail.gmail.com>
X-Gm-Features: Ac12FXxD7CI2bT0l7PwES-qRCiVwUZDreIeNyj5BS_IcK0vTEg9G29sE83O_G0Q
Message-ID: <CAJZ5v0j4FLDqpQytS5H0OGWwZtdgbAppRwyGfrfyKzzbDqvH6A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ilya K <me@0upti.me>, Armin Wolf <W_Armin@gmx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 9:33=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Aug 12, 2025 at 08:56:55PM +0300, Ilya K wrote:
> > On 2025-08-12 20:10, Greg KH wrote:
> > >
> > > Please read the above link for the full details on how to do this (hi=
nt,
> > > Fixes: will not do it.)
> > >
> >
> > I might be missing something, but doesn't that just tell you to CC stab=
le@?
>
> It must be in the patch itself, in the signed-off-by area.

Well, to be precise, it must be present in the mainline commit of that
patch and whether or not it will be there is entirely up to the
committer.

So adding a Cc: stable tag to a patch is a hint, which usually is
appreciated as long as it is accurate, but the committer may still
decide to not include it in the commit.

