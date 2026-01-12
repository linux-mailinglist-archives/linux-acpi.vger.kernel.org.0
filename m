Return-Path: <linux-acpi+bounces-20216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DFAD1537E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 21:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7D213011A46
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A397A326D65;
	Mon, 12 Jan 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyNRPxak"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3C334685
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249682; cv=none; b=lNSqpMMg08ME9PK5I0LgZc/8ahs2stKQoSASEXMedGlHY1F/cOz5sVPd7DOlSU5JbJBWtpajYJym4Lf0H0/QypKo4M7kn6kTOOnnq/iP0yakYxoK0obH6HQHvMlkzJOn6PxASte64wKGtJw1RgUK9dOF1/xUzPQNEN8Fe9wA3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249682; c=relaxed/simple;
	bh=NX4FeUCr2hMNZbqZPfMxSbN5HwqdGsXr2Qri/N2w4AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKy7w/tYQ2e12LhSzShmaqGrSZb4CrMEYw0F2KzimNMLVb8uLIgYQJ+JbRJGF/FoWoABNJhYf+lCSkEL+0+aKV8q/nkjmx9fpq2BFuQ075WIeydobE2MucU14NG7unkE3OzL6Y0T5FqOHNzYllWfQHr2usrchRtuLa80tDe60EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyNRPxak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B982C16AAE
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768249682;
	bh=NX4FeUCr2hMNZbqZPfMxSbN5HwqdGsXr2Qri/N2w4AQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kyNRPxakD8+9JeRMt+NXdp0LiNkDX/cqVneUchMpouC0kpiCD+G1irg4Bwsj6vBmO
	 KgEJLJ95Fhpn83RxiEPINH5xGoa9deOcmpPwHt3B188mw1KmdzGNczE+P4ypwM7Pr3
	 JIc1xnnLP6CHRSBvAwhbEKkwq0CW16bomQ9gVKppoWjIfLYfAvbj9WCCI1jtMRL/9H
	 X9khbRQ8hMRJevUR2GlKLlYQ6/5gmkKj1jb4024yFL0Q+w626Lu36ZsoqwD+CDFx6l
	 A8mlwmQYauzCjiLfwkUONvY+nVIi/3pzSuNIUaqu7ig1X7J7TO3csBKWlaQhuakbLw
	 M8H5sXLL1t07Q==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3ffc3d389a8so3474638fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 12:28:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5h5WZdsOlviLyaehTecgayejNPx+LOIGLZ29mI0PCl9sPhPFTX850KxKSjfcwHoxo1Kntm+pLjkad@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtJ8m1IGYaHZra43ki1NwL+9113DNehtRLkGEy+DdOMIiSoGR
	5+LnauVQNo8PqPQ4vXHEWcLLWHM2NWPfGJbVzFHRZ8XtO9/5GgG+4Mu7ExsZnoeQPp9NueSlE88
	YRk6dJuXt9GJXS1Qm5wPbkexZguS9UVY=
X-Google-Smtp-Source: AGHT+IEWvma6Uybv+Z3yR34AWMQ2tnAA+rt6oOZSb/31jWQRmBKbESSLmSwacwCaNrwiQRs2qwnM1u7xBFP6LzYtBdc=
X-Received: by 2002:a05:6870:16cc:b0:3f1:49d6:ab16 with SMTP id
 586e51a60fabf-3ffc0ba919dmr10617799fac.45.1768249681184; Mon, 12 Jan 2026
 12:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12824456.O9o76ZdvQC@rafael.j.wysocki> <23340716-847d-4360-8c63-7ee5410dd43b@gmx.de>
In-Reply-To: <23340716-847d-4360-8c63-7ee5410dd43b@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Jan 2026 21:27:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gdeSpbFE8g_bUmK4YPttAgwOripp=emezvUhd06aAREQ@mail.gmail.com>
X-Gm-Features: AZwV_Qimk8iwNnwLQlX1h3kVUdHshE8H_Gps8VFIjYlnASV0tGLqOL13GDTnUMk
Message-ID: <CAJZ5v0gdeSpbFE8g_bUmK4YPttAgwOripp=emezvUhd06aAREQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v1 0/3] ACPI: video: Convert ACPI video driver to
 a platform one
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 9:19=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 02.01.26 um 12:48 schrieb Rafael J. Wysocki:
>
> > Hi All,
> >
> > This is a resend of
> >
> > https://lore.kernel.org/linux-acpi/8617910.T7Z3S40VBb@rafael.j.wysocki/
> >
> > due to the lack of feedback.
> >
> > It applies on top of the ACPI patches in linux-next.
>
> I am somehow unable to apply this series onto linux-next. Can you send a =
new series that
> can be applied on the current linux-next?

It should be there in linux-next already, sorry for forgetting to mention t=
hat.

