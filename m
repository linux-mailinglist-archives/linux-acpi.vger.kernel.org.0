Return-Path: <linux-acpi+bounces-10902-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23705A29B04
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 21:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA237169A1E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 20:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE78D20CCF4;
	Wed,  5 Feb 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD2Hkmpw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970F846F;
	Wed,  5 Feb 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786691; cv=none; b=EscZ1l9ynqQwX5tGiNHoNzA4J7I2x+gS03Bmnx/zC6dS7fnHfaN3JCv7fQCYBhBZ6Y2t4cIp+jTmLMR0yBLweoVyGG+/dJ315goUNpww3WZ7FATvnX42S6uzEu+zhKimnjBRX/4LCY0Gj9EzX+D+NRqirjZt3MPDcD8i4THL+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786691; c=relaxed/simple;
	bh=3apj/wCpVFcLqgGoWp9oW/QY6Fy+q5CZ6CsXsbyvSMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reolxNkEFyiIxR/9y8RzQvcbxSYSaAUU2uHxZxMEM8Kx9c8U+OPuqMr2IgfJekO3/iwjBKj8eyTS7KRmPTcNluXZ/tyQ2QtLaE9DFZx9+3KcTtj4p5nHgFWc143uYkmZSaJjnVnXPqJEwUqK0FtIeQzpP+331/Cgxy5ROIkgOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD2Hkmpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B3EC4CEE4;
	Wed,  5 Feb 2025 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738786688;
	bh=3apj/wCpVFcLqgGoWp9oW/QY6Fy+q5CZ6CsXsbyvSMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WD2Hkmpw1aBZ3KfeDNnRzc5pb0R2SQXG63U4CDkSg8wMu+pCD5ZPDu8M9/+2kbVQA
	 oePfvOcV9FxfX8C1GSG1BXhXR50FDUApGFnywxu+3jBCj2KMN1XFGKlzvDMqArq4wJ
	 CbDrWN5ogLa+287Sv1aZcotEv2fEP9dwbB+O1XE7tYAVLWoAZdiVGeB+2e+9opVRxu
	 b2o7s03lnbV6l4gQisrBijsCouBBtur1vTUCqvFZKUNAQuwQ+RvITPDD82ou6LdZ3N
	 tYI8YNclNq1m+ORggvMLWwv6VrtHUI1lUFyEvcV1nCiTHWNePHKKDk6uBfPqLtHkmr
	 rUDffFL3nR07w==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ee1be3d496so92322b6e.0;
        Wed, 05 Feb 2025 12:18:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpvb1NHf9NHswrW1dpNvA/pWjg2lRR9q36JEwDqNd4O+vDvEaB3WmkkqergHoPOfejdMUstRTWKsz8Bfi5@vger.kernel.org, AJvYcCUxA5laqEQRzDORYAbNGTzzvzGe+ZnNZSrI82pgCOvBWMfIjOilRlHXyb+KqZc2udyO3LHsoFjV@vger.kernel.org, AJvYcCXHQa15a0NV8z8ShfqzmTVKR4Q6F4Pgz6oE5w6+vF2E1gW6yE4zu40u+bKv1wBnT1EZl684dkv7WbQN@vger.kernel.org
X-Gm-Message-State: AOJu0YyBY6I7SpKA8P4cnidkBGtdS+/Xt/PBqBp+mjtGjIKRHFB1Mor2
	fosOHKKJx6AhOWiKt718+2UjBPdIK6lio4dl1Nr4Grha92MpQEBG6EZg8THC6MP3NKVu1/OntlL
	YoxKVgzxU/qFQniVwpb4QE7InMZ8=
X-Google-Smtp-Source: AGHT+IH8lr3G9HtJBfMoyXeJS0alXYeOuqAOV8HvcurRDeD3/5okQ7pZLWVYAHz3KgttINL9+YNyoNQVu8Cqyf0jmEQ=
X-Received: by 2002:a05:6808:309c:b0:3e6:618a:7b83 with SMTP id
 5614622812f47-3f386773c3dmr508871b6e.2.1738786688166; Wed, 05 Feb 2025
 12:18:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126022250.3014210-1-aubrey.li@linux.intel.com> <CAMj1kXEe_Foz2G4GbdZtbaB9azHoBOW_E97wgTXoNAcZSykwaw@mail.gmail.com>
In-Reply-To: <CAMj1kXEe_Foz2G4GbdZtbaB9azHoBOW_E97wgTXoNAcZSykwaw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Feb 2025 21:17:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iqkXcE+3U72gNAskGt=wzpb-wU5JgZCNfkqpriS5ERHw@mail.gmail.com>
X-Gm-Features: AWEUYZlQNzbrUiwMCPLB681uzvyx4mRWhv3VPPXn72eMYbk_1cYBherxjf64Uds
Message-ID: <CAJZ5v0iqkXcE+3U72gNAskGt=wzpb-wU5JgZCNfkqpriS5ERHw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PRM: Remove unnecessary strict handler address checks
To: Ard Biesheuvel <ardb@kernel.org>, Aubrey Li <aubrey.li@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Koba Ko <kobak@nvidia.com>, 
	"Matthew R . Ochs" <mochs@nvidia.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shi Liu <aurelianliu@tencent.com>, All applicable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 5:23=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Sun, 26 Jan 2025 at 03:08, Aubrey Li <aubrey.li@linux.intel.com> wrote=
:
> >
> > Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
> > handler and context") added unnecessary strict handler address checks,
> > caused the PRM module to fail in translating memory error addresses.
> >
> > Both static data buffer address and acpi parameter buffer address may
> > be NULL if they are not needed, as described in section 4.1.2 PRM Handl=
er
> > Information Structure of Platform Runtime Mechanism specification [1].
> >
> > Here are two examples from real hardware:
> >
> > ----PRMT.dsl----
> >
> > - staic data address is not used
> > [10Ch 0268   2]                     Revision : 0000
> > [10Eh 0270   2]                       Length : 002C
> > [110h 0272  16]                 Handler GUID : F6A58D47-E04F-4F5A-86B8-=
2A50D4AA109B
> > [120h 0288   8]              Handler address : 0000000065CE51F4
> > [128h 0296   8]           Satic Data Address : 0000000000000000
> > [130h 0304   8]       ACPI Parameter Address : 000000006522A718
> >
> > - ACPI parameter address is not used
> > [1B0h 0432   2]                     Revision : 0000
> > [1B2h 0434   2]                       Length : 002C
> > [1B4h 0436  16]                 Handler GUID : 657E8AE6-A8FC-4877-BB28-=
42E7DE1899A5
> > [1C4h 0452   8]              Handler address : 0000000065C567C8
> > [1CCh 0460   8]           Satic Data Address : 000000006113FB98
> > [1D4h 0468   8]       ACPI Parameter Address : 0000000000000000
> >
> > Fixes: 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM =
handler and context")
> > Reported-and-tested-by: Shi Liu <aurelianliu@tencent.com>
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime=
%20Mechanism%20-%20with%20legal%20notice.pdf # [1]
> > ---
> >  drivers/acpi/prmt.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> > diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> > index 747f83f7114d..e549914a636c 100644
> > --- a/drivers/acpi/prmt.c
> > +++ b/drivers/acpi/prmt.c
> > @@ -287,9 +287,7 @@ static acpi_status acpi_platformrt_space_handler(u3=
2 function,
> >                 if (!handler || !module)
> >                         goto invalid_guid;
> >
> > -               if (!handler->handler_addr ||
> > -                   !handler->static_data_buffer_addr ||
> > -                   !handler->acpi_param_buffer_addr) {
> > +               if (!handler->handler_addr) {
> >                         buffer->prm_status =3D PRM_HANDLER_ERROR;
> >                         return AE_OK;
> >                 }
> > --

Applied as 6.14-rc material, thanks!

