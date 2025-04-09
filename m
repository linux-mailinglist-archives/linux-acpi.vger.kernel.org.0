Return-Path: <linux-acpi+bounces-12898-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11EA82560
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F1C7B3FE2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8F2620CD;
	Wed,  9 Apr 2025 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyEH997M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B126157E;
	Wed,  9 Apr 2025 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203269; cv=none; b=YfQzCgfR7iDQaE7I0qcXs0O1zX8rR/vOxq3BQfkDl91d50H7yZqpD5g76t69fG1XkUPZqjeXpozemBS3/fsXwD4JAygpooiIKnVtf6vc49odqSPWZmzZKOMJ5tCauknpjTAh172FD7FYxUA4oaHbIzwyv0jWj5HDOp5MrbThtVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203269; c=relaxed/simple;
	bh=5cjw3hniuS5c3kOgjuPKIqsfz6OH0LbiKTbZY3HNO0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SljSS6DnuTcNTNMV+aALUts3f2Er/jWvb3SvX+9urUslyFnTBwBiRQA9HJc5sM6Zfc08l9JHrZ3n/pwJ5QgzV7d48yV5P71UhvDW1PpyCs6w/td19BQlJpLUsNBtnxJgKAVPj/CqQ05ZFm1qzLltnZN98TaEpg+Gt4m9RzpLKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyEH997M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02B7C4CEEC;
	Wed,  9 Apr 2025 12:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744203268;
	bh=5cjw3hniuS5c3kOgjuPKIqsfz6OH0LbiKTbZY3HNO0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lyEH997MDF/YGs2ecKpNMIJsYSl91ea8N6V9wcZTLxRIZFukKbGKbHs0uZ+WOSogx
	 AHQa7KRuR7fZgwGGUWjrjLhZYBpIFl8zY+ARByPxvnk9aow0yZykZ5MKic6vlv4nXN
	 RtCObxO4P2ohETRUm9ov3VLel70p7G8BfnD9pHHA7ZMrc0nFpVb8vAaEOV1wJBg8UP
	 zwYj2OdRsUwvSdQ0cI7OwF95gZT1Wfkjh3EpOKeD65mNk2kZXq9+FCLEMFeS8N0MNO
	 dx8lMkwSb4z8bskzphfMistkgRbxwfXArc8dHOvkPn8WboXAiHNPZJhfu9W4iRrtMB
	 p6QwhwNNJXsPA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-60288fd4169so3402310eaf.3;
        Wed, 09 Apr 2025 05:54:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwQBpVg3oPtS4m0vnX5biOr72BixlKPnpfvpMpRO4Jvocplox2wdr+KvYk7UphQpD9/j7U9iNBrvqjjAol@vger.kernel.org, AJvYcCWevv/QoFDK0xjK6TVGSSH3QtvsKd9BypPCo2PwtXZbdNcimHzauPeaJfqXK06z30qDvAFp9Buoz52p@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtedBG35jzOwJX6a+x/GNXoENAEQHPFGqJwfBrkkmVam6eIH3
	VlIYmXC7EqQkI7wICYSwKy4kmGYhJy8tsAFHuAxRlWwmYkjVlK4wZ6ApNI1/5vYRuIkuU8CjX2B
	ZXbKOaIHdin+Qi0OEwjw9cXmGJxg=
X-Google-Smtp-Source: AGHT+IFVhR+NI8Q625FD1y6jfu8AWqdmxMqx5ND6/p58CuOaU4O4cuOfkDi0Tts9pcEs8NAdJFX45dy//gA9DXkrUxM=
X-Received: by 2002:a05:6871:aa03:b0:2b3:55b3:e38 with SMTP id
 586e51a60fabf-2d08de0f73bmr1518549fac.21.1744203268071; Wed, 09 Apr 2025
 05:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328143040.9348-1-ggherdovich@suse.cz> <20250328143040.9348-2-ggherdovich@suse.cz>
 <b29519a2da5b85f484b0f402062df2b58ec38afe.camel@intel.com>
In-Reply-To: <b29519a2da5b85f484b0f402062df2b58ec38afe.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 14:54:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwzoqg939Kx2pwRbKo3CS--tU=+w+1cpHL35gd=3-yTQ@mail.gmail.com>
X-Gm-Features: ATxdqUG3ZYhJlSIdVt73T05FStiWHfkpSBrgWK4bhFvJZAI83WDC-7ULwh4-Pn8
Message-ID: <CAJZ5v0iwzoqg939Kx2pwRbKo3CS--tU=+w+1cpHL35gd=3-yTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
To: "Zhang, Rui" <rui.zhang@intel.com>, "ggherdovich@suse.cz" <ggherdovich@suse.cz>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 2:54=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wro=
te:
>
> On Fri, 2025-03-28 at 15:30 +0100, Giovanni Gherdovich wrote:
> > Since commit 496121c02127e9c460b436244c38260b044cc45a ("ACPI:
> > processor:
> > idle: Allow probing on platforms with one ACPI C-state"), the comment
> > doesn't reflect the code anymore; remove it.
> >
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>
> This is a standalone cleanup, and further cleanups are posted in a
> separate patch set on top of this one, so
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied as 6.16 material, thanks!

> > ---
> >  drivers/acpi/processor_idle.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_idle.c
> > b/drivers/acpi/processor_idle.c
> > index b181f7fc2090..2a076c7a825a 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -482,10 +482,6 @@ static int acpi_processor_get_cstate_info(struct
> > acpi_processor *pr)
> >
> >       pr->power.count =3D acpi_processor_power_verify(pr);
> >
> > -     /*
> > -      * if one state of type C2 or C3 is available, mark this
> > -      * CPU as being "idle manageable"
> > -      */
> >       for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
> >               if (pr->power.states[i].valid) {
> >                       pr->power.count =3D i;
>

