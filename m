Return-Path: <linux-acpi+bounces-13599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6E4AAE62D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A5A171A25
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1E28B7EF;
	Wed,  7 May 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOmvey8V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9E215197;
	Wed,  7 May 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634372; cv=none; b=TwdTe6YzX4L+IW0vLQqUPkjd4IH3964bRMxKqQOdRB7vyCIFi3vZg3aU0GQxQy/RzFhkGEqOpLr2D79+AGKcvQolo3BR2mOTFo3fs9AUOn0NFi+PSuFokF9CJtNTri2/wbqEwCDh+d5EQMl/HIB1oBeTuUwqX3i9FV4akpJHXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634372; c=relaxed/simple;
	bh=NgV9gb3MNcWqBiGv30nVf8yM/e0HQuZamzPRZKopGGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqlcRTCbZdZJWo7xReDSpnIxsCmJwEUGn4lJjepBW33bcWw+j8UQgV+l8tdTr+gE5WNnrMqneshSbjstIfiCnpdUTGfL5MEF5w6Z6M9r6c8wmP6YszP8Y8dPeY80jA7CDtbSPuDN2ji02U8TJSh9OSOR4GRkznv5JTcRyKhSCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOmvey8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C214BC4CEE9;
	Wed,  7 May 2025 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634371;
	bh=NgV9gb3MNcWqBiGv30nVf8yM/e0HQuZamzPRZKopGGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lOmvey8VjmjQoujhNZkrb14agia0kvhIP9ruSrUvMM5ASWt/Zn8KlrQAwtOqHjeal
	 quV7IRSqlaV9dyn+bCcDYjbGxE9yscC2A/PlQC0QiwEuEHF2rX1h2v6PTw4chrjhfq
	 fECSiGDc7hmDbjrrCfsnaps0CtXVxViZKKQs6BsyD8+pMRcAZ1oKA89QHWw2QK/PVq
	 tIe/H1YnEcVAtuIksL9m8xYvXzTN/IqGKbkK9sDXt9eDgu7370Z0DPpKoVUVcRVHoi
	 4/S6fXP5P2PkDBYehvT8qsSwLERwBYybVcl1sFWd7mG6D3BuwEYA9WPPYjZsTigxTP
	 HOU0Vl5JDpf+A==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601a8b6c133so608898eaf.1;
        Wed, 07 May 2025 09:12:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTgU2Y1iahtQF7JkvNVNBYBKhBX6kLYKZ5/YaRIuDyJPHodLUod1QXo2K00gRH/IF1HogkJ8FNjrN2@vger.kernel.org, AJvYcCVVQMSWlUJz01Jc7GjYjtx1MwntFp4Tx39iTADb5+R+H1Vx3lhVEqUc6+P2boM8fY7NrEm32weHmt2c8uJx@vger.kernel.org, AJvYcCVxtJOdoYYVUEtuAyeugql8NGGa/6ZVo95Pt3cUJej5w7FcJzV8N6Jyi++oT6Zm5341Zi/Szj14@vger.kernel.org
X-Gm-Message-State: AOJu0YxLg2+cLXbjsOBkF6Qkgp2JIEbhd7P0dXr30gOGM8xnyErIJmjk
	fMHaMIcrJR3b5BUNrN5QbJnM0fyr6D4jFZU6OZs1XrAJV6KRP8sxPNQsm/0cdjNzXAVEmv15yun
	kPDJl/s8ykPaHD+NLoO4C847s2SU=
X-Google-Smtp-Source: AGHT+IFm2G7vMhkwbbCVl7L4A5NTpNVPjzGsw1lgYvvaLpUxiMXb372fR+bbyzJEB78MqSgLhSYc5SbazdWLqRY5pyY=
X-Received: by 2002:a4a:d18e:0:b0:604:ac85:abe2 with SMTP id
 006d021491bc7-6083346b675mr58870eaf.3.1746634371080; Wed, 07 May 2025
 09:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-draco-taped-15f475cd@mheyne-amazon> <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>
 <CAJZ5v0jvWXDQQ++4wmWJ+i=jds+MZ68bRB9+26WM4tAPHFxALw@mail.gmail.com> <1911d3b6-f328-40a6-aa03-cde3d79554de@arm.com>
In-Reply-To: <1911d3b6-f328-40a6-aa03-cde3d79554de@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 18:12:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ii9HLfqfgcp=1qRRX6M1yThf7ZPNkSLVc5GGFhv=N-Lg@mail.gmail.com>
X-Gm-Features: ATxdqUFz_G-xumrMaH9DthfVtj9CaPWWuEm7JWekOadO-oye5lvECoLE0lOwrj0
Message-ID: <CAJZ5v0ii9HLfqfgcp=1qRRX6M1yThf7ZPNkSLVc5GGFhv=N-Lg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Heyne, Maximilian" <mheyne@amazon.de>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:51=E2=80=AFPM Jeremy Linton <jeremy.linton@arm.com=
> wrote:
>
> On 5/7/25 10:42 AM, Rafael J. Wysocki wrote:
> > On Wed, May 7, 2025 at 5:25=E2=80=AFPM Jeremy Linton <jeremy.linton@arm=
.com> wrote:
> >>
> >> Hi,
> >>
> >> On 5/6/25 8:13 AM, Heyne, Maximilian wrote:
> >>> Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> >>> sizeof() calls") corrects the processer entry size but unmasked a lon=
ger
> >>> standing bug where the last entry in the structure can get skipped du=
e
> >>> to an off-by-one mistake if the last entry ends exactly at the end of
> >>> the ACPI subtable.
> >>>
> >>> The error manifests for instance on EC2 Graviton Metal instances with
> >>>
> >>>     ACPI PPTT: PPTT table found, but unable to locate core 63 (63)
> >>>     [...]
> >>>     ACPI: SPE must be homogeneous
> >>>
> >>> Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties Topology Ta=
ble parsing")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> >>> ---
> >>>    drivers/acpi/pptt.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> >>> index f73ce6e13065d..4364da90902e5 100644
> >>> --- a/drivers/acpi/pptt.c
> >>> +++ b/drivers/acpi/pptt.c
> >>> @@ -231,7 +231,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_=
header *table_hdr,
> >>>                             sizeof(struct acpi_table_pptt));
> >>>        proc_sz =3D sizeof(struct acpi_pptt_processor);
> >>
> >> This isn't really right, it should be struct acpi_subtable_header, the=
n
> >> once the header is safe, pull the length from it.
> >>
> >> But then, really if we are trying to fix the original bug that the tab=
le
> >> could be shorter than the data in it suggests, the struct
> >> acpi_pptt_processor length plus its resources needs to be checked once
> >> the subtype is known to be a processor node.
> >>
> >> Otherwise the original sizeof * change isn't really fixing anything.
> >
> > Sorry, what sense did it make to do
> >
> > proc_sz =3D sizeof(struct acpi_pptt_processor *);
> >
> > here?  As much as proc_sz =3D 0 I suppose?
>
> No, I agree, I think the original checks were simplified along the way
> to that. It wasn't 'right' either.
>
> The problem is that there are three subtypes of which processor is only
> one, and that struct acpi_pptt_processor doesn't necessarily reflect the
> actual size of the processor structure in the table because it has
> optional private resources tagged onto the end.

Right.

> So if the bug being fixed is that the length check is validating that
> the table length is less than the data in the table, that's still a
> problem because its only validating the processor node without resources.

Admittedly, it is not my code, but I understand this check as a
termination condition for the loop: If there's not enough space in the
table to hold a thing that I'm looking for, I may as well bail out.

> AKA the return is still potentially returning a pointer to a structure
> which may not be entirely contained in the table.

Right, but this check should be made anyway before comparing
cpu_node->parent to node_entry, when it is known to be a CPU entry
because otherwise why bother.

Roughly something like this:

proc_sz =3D sizeof(struct acpi_pptt_processor);

while ((unsigned long)entry + entry->length <=3D table_end) {
        if (entry->type =3D=3D ACPI_PPTT_TYPE_PROCESSOR &&
            entry->length >=3D proc_sz &&
            cpu_node->parent =3D=3D node_entry)
                return 0;
...
}

