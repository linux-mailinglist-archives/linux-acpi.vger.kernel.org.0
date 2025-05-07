Return-Path: <linux-acpi+bounces-13571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1BAADDDD
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D5B3A977E
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A372580C2;
	Wed,  7 May 2025 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plzHwW51"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E41233145;
	Wed,  7 May 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619164; cv=none; b=cYEK9qEn+1cqpnRcsXjiL3lfSOQAy27TpX53mlHwkVR1yJZHBCa0+TzxoCGPvgUNTtcX+ef0xP96+V5lFJ76a7T+2m2Q4RSCxdeRFClDIySkYx1RowZVEmJ49e/zbSVKM8kAGzGH61HJsF4n0iPr/q5JHEyoJursHptRzZnjNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619164; c=relaxed/simple;
	bh=rMNcVWyizpvr9pCeVtXrkYPIJwohU5epjZ6h8slHQlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsYYnyyOsBx7sFHw0hNnIxiGyaj4rz0xZJ2Ymcq1u7Oe6RfLtGGF6y/2BAHAFcVLJsL+gzy7dMrLXnZLjNAn+q0cKDRWmZB6cW5ks689a/gujgqJ9vlDVCfQdzjrSLcem1xdTM+STwqbqF0iGeyyrXdbhDexJK5OilxcMVBr7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plzHwW51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93638C4CEE7;
	Wed,  7 May 2025 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746619163;
	bh=rMNcVWyizpvr9pCeVtXrkYPIJwohU5epjZ6h8slHQlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=plzHwW510uASisGKfCbRnZKXKusT8SHLLGS9YeXw4M3VTEhaxn3RiGs40p63OJK84
	 iQ3uB9M5zq80QtE7cOHFqKSnvY2GWHikroKbWZF4yb3KhdnbbzQY1YN+WP/uc1mMyl
	 HgnWQbo9Zf1BLue8P8dSMjg/HnX88Kmg42EVZmyGNPCAstWt4/Ny22HsTID3qgqYmq
	 FIzeTFc8gSwiwA9R8mB/P5/uAhVXBw9yKKLo/JS6Q25d3Jwe0gfyEO72PxEKgTaTXD
	 CKGIjKTbv6hk7TwA8ENgizR4fO7HX37QjJYmeChZw02uKwZh6wB+EvcRk1C/a0eOb8
	 Z20Z92MXpiEJQ==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72ec58e45baso4398994a34.2;
        Wed, 07 May 2025 04:59:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSKYDr//huQ+hh3EmgrT8FRt7pztaul/i3B5xmgKti+wun1pwMVloi0PtlXApwuqvV2UR9b7OOq6oFo0cU@vger.kernel.org, AJvYcCV9htlBgbC1iqptGYzm4R5zJ5XPC1N7jQFdP6U6ADqJfhPLqKhrBHmGhh/lgj6r5ny4ydDVoTAgqAb9@vger.kernel.org, AJvYcCWueQMzv44ayK91Jc+xMjNLf1kFyYbP3KXSDY//E+SfV7Lox3knIk09OTeDROeP19qfE6Epikyk@vger.kernel.org
X-Gm-Message-State: AOJu0YzEziWclOkdqvJwOOB2ppCDPcZUcLZmU8gMvv/hpUaaFKdPSATJ
	A8m7UrQK1UJgwPItk0cejuJ1lRTS/YS7J3jYPA9C8UvhSJ8McrOygu9/LAhfIhcQUcelj7qWNcQ
	z6cEEN9/u9TWsiuPmpLIUSQKNFc8=
X-Google-Smtp-Source: AGHT+IFQ0rnuQoFb844+kgJStSDvA/qPO+oOSqmCxZhuZGNi8wWvpNim0B2eq1+jsmFt7rTsMyHN73YANujP8kYHYWs=
X-Received: by 2002:a05:6870:46aa:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2db5c08281bmr1892495fac.30.1746619162927; Wed, 07 May 2025
 04:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-draco-taped-15f475cd@mheyne-amazon> <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <35895e57-bbe2-4ff9-b1d4-4b70e28ed8a1@arm.com> <20250507-argue-rant-9f48ba38@mheyne-amazon>
In-Reply-To: <20250507-argue-rant-9f48ba38@mheyne-amazon>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 13:59:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gTRcivKKVOx8YhrPyfXJBwL0x+zay9wXrWeod4Lf_Kwg@mail.gmail.com>
X-Gm-Features: ATxdqUGtNzluXM9CbDzPKfcLxiAeEkWEA0mvdrc4rPN-g20JpiBsi9_eupPU8jU
Message-ID: <CAJZ5v0gTRcivKKVOx8YhrPyfXJBwL0x+zay9wXrWeod4Lf_Kwg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: Jeremy Linton <jeremy.linton@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:53=E2=80=AFPM Heyne, Maximilian <mheyne@amazon.de>=
 wrote:
>
> On Tue, May 06, 2025 at 03:11:20PM -0500, Jeremy Linton wrote:
> > Hi,
> >
> > On 5/6/25 8:43 AM, Sudeep Holla wrote:
> > > On Tue, May 06, 2025 at 01:13:02PM +0000, Heyne, Maximilian wrote:
> > > > Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> > > > sizeof() calls") corrects the processer entry size but unmasked a l=
onger
> > > > standing bug where the last entry in the structure can get skipped =
due
> > > > to an off-by-one mistake if the last entry ends exactly at the end =
of
> > > > the ACPI subtable.
> > > >
> > >
> > > Unless the firmware has populated an incorrect value for the header l=
ength, I
> > > don't see how this is possible. The table_end should point to the add=
ress
> > > immediately following the last byte of the table. None of the headers=
 are only
> > > one byte long, so what am I missing that could explain this apparent
> > > off-by-one issue?.
> >
> > More likely its because the sizeof() fix was merged without proper revi=
ew
> > and is wrong because the type isn't actually known on the object until =
the
> > header is checked.
>
> I agree that the type might not be known at this point but the condition
>
>         proc_sz =3D sizeof(struct acpi_pptt_processor);
>           while((unsigned long)entry + proc_sz <=3D table_end)
>
> would make sure that there could potentially be a node of type
> acpi_pptt_processor because there is at least space for it. If the entry
> can't be of that size because it would go over table_end then it can't
> be an acpi_pptt_processor.

I don't follow.

If it is an acpi_pptt_processor entry, the original condition would be
sufficient (assuming the correctness of the table header), wouldn't
it?

> Therefore, I don't think the sizeof() fix is that wrong but we just need
> to adjust the while condition.

The sizeof() fix is correct, it makes the code work as designed.

> Alternatively, we could at least make sure that we can safely access
> (without crossing table_end) the acpi_subtable_header to check the type.

Yes.

> But the current approach seems cleaner to me.

Why do you think so?

