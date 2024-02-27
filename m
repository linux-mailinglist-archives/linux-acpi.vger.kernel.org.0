Return-Path: <linux-acpi+bounces-3978-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C815386998E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F076291A11
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5103D14532C;
	Tue, 27 Feb 2024 14:56:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F1145B0D
	for <linux-acpi@vger.kernel.org>; Tue, 27 Feb 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045782; cv=none; b=gjvBB3uSO4+IZt2bt4+e5Ir+KF5JertellnEG4g9gUZ53WxhyTfcAS2oPBgcn51twpm+x5f124M2vJDKdcx7r4KQIoH/miV5mfjZWzuYfj3vuIrMeu96ga9E8AWlGtAPEGIJfUFQRLOdumiIWDINJ8c0t9H36bgNt9MoRfAX5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045782; c=relaxed/simple;
	bh=Jk1T6r9mQnr0B6pkkaoJm7XFVhNnKT0KeobPZ+Cb2AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUQXY4dE6gpwiSOvC7/2ftEPqg56UPcw86z5YapmjB8/BHG2tAdMcWm2VGU2rHSWZu/ELyqqxFB97Hf7V/LnkakqTDh461d7lghx1p6CmSlZUxwqv59luAsQAclvpGSiGnqVd17VDUvPw/8mtBU/hLsPrbIT8j4zZOK1bXH1SrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bc23738beaso296978b6e.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Feb 2024 06:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709045779; x=1709650579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Tnt08hN1cvC6bh1cLykPIHibezGQupGO3q6UALLMcg=;
        b=tCvNV3z3VIalP4UtPyVii7TcR1YW76BcfIJyRkO0yNxr5sIcvhj0bDByomub1q/lVG
         TcR1DpeZ/wmlsleUxSdchRgJU+aS+cR85EFd7yOgRxlEpQAjuLHRwqcZ166jGYO2hmfT
         86vw0+FXRvHtBfE+w4OM9C6/feJBdwcT8R+hKzsQ7USoYnEXO9zBWHJDUHPovdrqbPWA
         VQIjFozBaB/JaEG9h8yiQThgIoE7xITXrmq84z8KUDGEIHVYPU0JM0k1k/sd+8MJilQY
         q+Z2NOtK63264A3vI/iL/g4H/v6zoBSVJBErmT1/C0WG6aBDj6ANLPMl0eGZNg8j7ELX
         mfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW7CtNNf8xGu+FLudAlnYfjj6eSOr+kdEggJwzQvVbMyoto7aefYWu7QOH3lwYn7bsJWBvcoY8n12UTIzxVGjsZ9XJEUZOlhN00w==
X-Gm-Message-State: AOJu0YyG9GoHtVAT9khBNPNqhGdzrRJ6L07bG6kNOfM0STHryKIs0qrW
	DOow9uZgjmkEDQNtv0JM1/ZLqu0HddkS5oeRLWXJQSrsjCU74ql9ArVNJ5TR+HXvCIpxooMIVXO
	CQlPrVSrQJCWvpt1S1dSE02vSA7s=
X-Google-Smtp-Source: AGHT+IEhk4k12nHmeBRQS6mQsmW82Pl98GYwBap0g7+ZU3vymfBUte5krzJ4BDTNL5grDPLOw+4t5PNf9Qi9DsF7l6g=
X-Received: by 2002:a4a:d74a:0:b0:5a0:6ef3:ed8e with SMTP id
 h10-20020a4ad74a000000b005a06ef3ed8emr7619798oot.1.1709045779384; Tue, 27 Feb
 2024 06:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120173053.49597-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0iW_B72o8EMbZaH_x2SOHOvqnieP8EsK2A6d93GRDYtBA@mail.gmail.com>
 <20231122174913.GFZV4/GUKci24sp1oj@fat_crate.local> <ix7bttqx32bv4hajg7szijtosi5vn43nxduun3fwevccjqrjhh@qrbjvcsuddoi>
 <tfmuzubr5p57qyv2pye72yzs6fjdyxubcqkmhih7ndddqcifgu@y4psjmr4rbz6>
 <r2cobeovsufkoryiszm56gu2pwgevjxcoceg5am6j7va4r7su3@7arj7wav2d5q> <CAJZ5v0jJX-6L9f_TLe-cv2MNnZVK7au=drbKCn-tEWEagY-9ZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jJX-6L9f_TLe-cv2MNnZVK7au=drbKCn-tEWEagY-9ZA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Feb 2024 15:56:08 +0100
Message-ID: <CAJZ5v0jXr2c4GXVQwzvFfOAHh=YPucSM2HHAWbK1EsgUJGQTbA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, 
	Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:25=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Feb 15, 2024 at 10:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > On Wed, Jan 10, 2024 at 09:34:53AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Dec 18, 2023 at 09:47:10PM +0100, Uwe Kleine-K=C3=B6nig wrote=
:
> > > > On Wed, Nov 22, 2023 at 06:49:13PM +0100, Borislav Petkov wrote:
> > > > > On Wed, Nov 22, 2023 at 04:25:30PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > On Mon, Nov 20, 2023 at 6:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > >
> > > > > > > The .remove() callback for a platform driver returns an int w=
hich makes
> > > > > > > many driver authors wrongly assume it's possible to do error =
handling by
> > > > > > > returning an error code. However the value returned is ignore=
d (apart
> > > > > > > from emitting a warning) and this typically results in resour=
ce leaks.
> > > > > > >
> > > > > > > To improve here there is a quest to make the remove callback =
return
> > > > > > > void. In the first step of this quest all drivers are convert=
ed to
> > > > > > > .remove_new(), which already returns void. Eventually after a=
ll drivers
> > > > > > > are converted, .remove_new() will be renamed to .remove().
> > > > > > >
> > > > > > > Instead of returning an error code, emit a better error messa=
ge than the
> > > > > > > core. Apart from the improved error message this patch has no=
 effects
> > > > > > > for the driver.
> > > > > > >
> > > > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de>
> > > > > > > ---
> > > > > > > Hello,
> > > > > > >
> > > > > > > I tried to improve this driver before, see
> > > > > > >
> > > > > > >         https://lore.kernel.org/linux-acpi/CAJZ5v0ifb-wvyp0JR=
q_4c1L6vTi_qEeXJ6P=3DPmmq_56xRL74_A@mail.gmail.com
> > > > > > >         https://lore.kernel.org/linux-arm-kernel/202212192214=
39.1681770-1-u.kleine-koenig@pengutronix.de
> > > > > > >         https://lore.kernel.org/linux-arm-kernel/202212201544=
47.12341-1-u.kleine-koenig@pengutronix.de
> > > > > > >
> > > > > > > but this didn't result in any patch being applied.
> > > > > > >
> > > > > > > I think it's inarguable that there is a problem that wants to=
 be fixed.
> > > > > > > My tries to fix this problem fixxled out, so here comes a min=
imal change
> > > > > > > that just points out the problem and otherwise makes ghes_rem=
ove()
> > > > > > > return void without further side effects to allow me to conti=
nue my
> > > > > > > quest to make platform_driver remove callbacks return no erro=
r.
> > > > > >
> > > > > > Tony, Boris, any objections against this patch?
> > > > >
> > > > > SDEI is James. Moving him to To:
> > > >
> > > > I wonder if you had a chance to look at this patch.
> > > >
> > > > It doesn't change anything for the SDEI driver, the only effect is =
to
> > > > have one driver less using platform_driver's remove function.
> > > >
> > > > Would be great if that patch made it in.
> > >
> > > I guess it's to late for 6.8-rc1, but I wonder if this patch is still=
 on
> > > your radar?
> >
> > I'm a frustrated about this patch. It already missed two merge windows
> > while it's (IMHO) easy to understand that it doesn't change anything
> > relevant for the driver. (There is a resource leak in this driver, the
> > only difference my patch makes here is that it's more visible than
> > before that the leak is there.)
> >
> > What must happen to make this patch go in?
>
> Well, I will just have to take it without an ACK.
>
> However, the lack of a (responsive) ARM reviewer for APEI/GHES needs
> to be sorted out.

So applied (as 6.9 material), but I'm going to remove the record
pointing James Morse as an APEI reviewer from MAINTAINERS, as he
doesn't even react to responses to patches sent by himself.

