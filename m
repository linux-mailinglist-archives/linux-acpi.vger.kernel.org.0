Return-Path: <linux-acpi+bounces-6258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0256D8FFD98
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 09:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144B01C2218C
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE5015A872;
	Fri,  7 Jun 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnKM38Bz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEE715A86A;
	Fri,  7 Jun 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746957; cv=none; b=bzl3WNSmCrwldf7oWugK0PMLd6/lWb/zEvkt0cMfsns8s9uowotkUINmZdOpMah12/3lCX1Bqjin5jzs1HzVkF3zSX8u6jN2oIY3N8D2vclRP/yX8dOtJNSjHjFK6sENNaAB3qkD66z4OruzVVSPbef9I0uOnckxLq/6XnVHvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746957; c=relaxed/simple;
	bh=uI/QJseRNnSAiLO/gbeFRBPFZN8DhNI0NiQg672psP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcSxi4yqmCCW1WT7aHCsJrdj0nawY1NwNGETdzie621t9DmUQzEaEkAUhYYwwbPbRZtLwkxMuLnvB9m1rAMaGgE0UffdV5kHkOqbizpFi+Zp5qcRcLj+ligZKTY07JsxDKD6B2gATJMWsZ8OmSSHTbC4KSUcQ1bcG48XB96ijn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnKM38Bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF011C4AF07;
	Fri,  7 Jun 2024 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717746957;
	bh=uI/QJseRNnSAiLO/gbeFRBPFZN8DhNI0NiQg672psP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lnKM38BzIFCaHOTu1Urb9ZdgpVJwzVYDejLv+egWOQawEGwuRN7upL1pZonPWPA2s
	 ALMisDedRP90znGc9OKPwg0UuwqT0NNcJ1G+JOgK9gR8jVGUrMXnJC7vEErXM6Dp28
	 0dE41acEs+4h1qJmzw4Pj5IonpjTUPIJ9IWOYn+FGFTAG9bxv1ZEGbbaqvga4vvpKu
	 frkA6AweTp3qCPy+Ak4TYE+LoFuWFdVOUM1QxjrkhxFpLtMqk59qF09DK9pD8hsma4
	 6rlplAOeiTS2wkiO1Bkk3uoRixrAhMiVeo+ggG6y3XkHJb0uzpwqSouLP6bKm0Net1
	 hsvSoD1s8Ws6A==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b335681e82so273071eaf.2;
        Fri, 07 Jun 2024 00:55:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYwkkohh9Gh4E6M5eBgQhIqFyj6vaLyWOP/mpoSm+bF3Z/nBdiY3HG5CGOhg7yMK/5WFkPJRu12/Xlwz0BszKrX1yTtusdSyS/fh4JdeHhac164K5G5foQF498I8gPDEDq1mrbSHgCI+GOuCjZWTmXxpmTyWMol3GOn9qZjtS3ZrE3d2lb
X-Gm-Message-State: AOJu0YyALNT3RvVUDMnOWLFgCSA+h9Nfjamo7egW/LIPyZcl8AxB+AHB
	l4Qx1LcvjCaw3Gf1PmFOBa377G3MxIO6YCY6VZ2SX+gsu4djC3DnvtBmH+gtBxGHTcoNM+tYTEB
	MujjE+diSyfsB78glj14LNdZNdk0=
X-Google-Smtp-Source: AGHT+IEvrjNzx6O5y/0sU9VeobXh56cdEvsv6pP4P2j7KZIrqGPsUL26GPjlnKSeIbjU+Z3fWr4/U5NUyIxtbRJC+gs=
X-Received: by 2002:a05:6870:58c:b0:24f:ddd5:a21d with SMTP id
 586e51a60fabf-254649a6f97mr1862748fac.5.1717746956049; Fri, 07 Jun 2024
 00:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com> <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
In-Reply-To: <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 09:55:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i1NxGHMKskP7W+hAusjt=5jYYWTF2vgJPR0gnrNTgFaw@mail.gmail.com>
Message-ID: <CAJZ5v0i1NxGHMKskP7W+hAusjt=5jYYWTF2vgJPR0gnrNTgFaw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
To: Hans de Goede <hdegoede@redhat.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Genes Lists <lists@sapience.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	laurent.pinchart@ideasonboard.com, wentong.wu@intel.com, 
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 8:12=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi,
>
> +To: Rafael since this was Cc-ed to linux-acpi but never send
> to Rafael directly.
>
> Rafael this fixes a crash in 6.10-rc1 for some users and is necessary
> to make the cameras work on the Dell XPS 13 plus 9320 .
>
> On 5/28/24 7:09 PM, Hans de Goede wrote:
> > Hi Sakari,
> >
> > On 5/28/24 10:44 AM, Sakari Ailus wrote:
> >> Ignore camera related graph port nodes on Dell XPS 9320. They data in =
BIOS
> >> is buggy, just like it is for Dell XPS 9315. The corresponding softwar=
e
> >> nodes are created by the ipu-bridge.
> >>
> >> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >> ---
> >> Hi,
> >>
> >> Could you test this and see whether it fixes the warning?
> >>
> >> The camera might work with this change, too.
> >
> > Thank you I just received a Dell XPS 13 plus 9320 myself to use
> > for VSC testing and I can confirm that with this patch 6.10.0-rc1
> > works, including giving a picture with the libcamera software ISP +
> > 3 small libcamera patches.
>
> I forgot to add:
>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.10-rc material.

I've also added Reported-by and Closes tags to this, but I'm not sure
which commit exactly is fixed by it, so the Fixes tag is missing.

