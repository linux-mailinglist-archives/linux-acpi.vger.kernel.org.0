Return-Path: <linux-acpi+bounces-10681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01671A12261
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 12:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF516A8E9
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855491E9910;
	Wed, 15 Jan 2025 11:21:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B025248BA4;
	Wed, 15 Jan 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940063; cv=none; b=SN/OC5zov+7t5Wuw/2tHu0xNkQrlLsDK/QecgYn5EHunyrYarQLPwm/CuwLxLmUvNQRvBcmbYCIxoQYR/0JlvXTFVZVZ7hH6yR2WiBC0Fb/VQ7mqgvQz6qM7mWQ5YoK6AsujsDoHvlB2jSZrSFMyqP6gUFX/DVrkeWY7HWkDJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940063; c=relaxed/simple;
	bh=4q7AQoXdmqySymJdCDliApq+zz2A+4/RlXQo13HdHac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXJHZNbwJsF/ai2bQ9nmleniTxFQ959D9u91EthNahqKCvysyPbqd55hrtz2fE0SurE9PS6JdGDUDut6JG7TOBeQJ1k18pfGZj4qcxP5pu2HZ84S4wa8OmlgMLxG/K54EZpO1cPQ+azR7Ybn19BwjomIywvVAavwEkChccArO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4b60c221587so3195552137.3;
        Wed, 15 Jan 2025 03:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940059; x=1737544859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqvtqUh1LHeQpHXN4IBNM8PORr3tuNK9976jM9larZM=;
        b=b9hvYN1oFyATMml9mpwaISjaSXKAqzqkFMskBfyC4anRobaQUukl7wA2u7cUG3VGl+
         5CuIjJVEO5nNL7suxIHFmF/jwa4jDByXnNXFxXzB2CmZSgS18s4C4UWBim9PWeFe36AW
         LlEAUMbpiUwGk1sTtrYwU3WnJzgHUSAXJae5a19upT4MCvz/j+FQ6j+FuTYfn5cZuXmN
         +xrFOunhGG4PkMIDmu9rLq1SZy1unQCdsnFPUiLQNHOwUBK3qAjVK60qlkpghKFXD6Pl
         oMCDoMe72Ze7xX0JhAQKIwjZfzuR/VOgUuNOuh4hmgYpYCfpFScBjzLnOEmCx33hanm3
         AJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLJ2DFouvLOcIGQ71QDKMKvp6n3CB8Dz+PGGNIWbI2nbBtUHzdSgBdVTctJipHXjnExcMAAi1fhxDu@vger.kernel.org, AJvYcCVPRii3gSaXbqnVcAwzcKPjRKtCL3iVwLdRKkQJfQ9pJNiKKn8zi9/RcC5squRog824LOkzY4EGE5qzYat1Pk8hUS8=@vger.kernel.org, AJvYcCViiqw9kDThbUJegLSfQK0xU3Ffj5H8m+lhQSgHyzT7v3AMpcPlwVxypu1EdOXghx7Lk5wHsm3xyFJuwWE9@vger.kernel.org, AJvYcCWflM5CN9Wf0vvpuhqWVLhizeDVwG+nwCodG2dklp2O2e+HoT33mnXq23itEjC9gQENRScDEiOffQWIIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0bFzWI1sAdyTWzcEiWjEHinyhHbrRjClgSnKj6dSmyo8RYN9
	U1NzJBPBSnZwAYD0RweHhiNu1ROTDTcsrgYb5sYMX4XCthBbvryK7Er8KPv4
X-Gm-Gg: ASbGncsCAFqPj+XSQ7Po8CcY3FvEVQeX1MznNeVYB9hI2U/13PEI5XmX35wWcMP+FsJ
	R47ftijWNLsrRX8aKjVVyNd/6xovPlY0zxbazb5GH1Dd6OQdnmRt+TtMqZVDzQ9emfHZAT+tNcx
	kp/R4toGQiJMYobFdnze8DbxomMEcBdvC1rWHqgWJzdL6r9EOtCRAeIsskFfZbctdqeqGLftZ/K
	Ef4IooXoUijajCRgWoRajAutTZZvjgnA5wWetNKA8v5vkxVVw4XbWhxEa0Y2SFVS3f4HUv1udFK
	xkAVKjcMKg5wmsdS5U0=
X-Google-Smtp-Source: AGHT+IGSBq0ARD5c/rzBt3KlInThGq08Y5qnNGWLD74uDRodXtXSF/moOOB0JHfF+8Te8NboOPDm+w==
X-Received: by 2002:a05:6102:5491:b0:4b1:16f8:efcb with SMTP id ada2fe7eead31-4b3d0ec7051mr25759265137.17.1736940059218;
        Wed, 15 Jan 2025 03:20:59 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b6091da75bsm5053737137.30.2025.01.15.03.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 03:20:58 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85bad7be09dso3762647241.0;
        Wed, 15 Jan 2025 03:20:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvJQf62l19+5soiCLJ8jc9MPy+JV8uPdOpdSVvp5IgFptt9WEQFI4n2Y5OZOHcu+R2RYOEasJmKILwLv6yGcLIuu8=@vger.kernel.org, AJvYcCV1xMnQgzWrE/nbSvb7MuKIhysd5LzOCrg+6x52Tw8sRmpRgnTvqOjMMg4MV20HsUbs54R4Rxm+6d0g+w==@vger.kernel.org, AJvYcCW7I+juVc8Hv8ElPinfKYekKQZFdh7bRzZ6ur7WkmKgCfxYjqIypj4I5qbaWHqUmbTMLpXp+cXj7QatbRqG@vger.kernel.org, AJvYcCWT6IPbzn6u22ZzIx1x8PTCdBtJ1yl+mHdvw8YhdT6eBe9UJJHtN+XwJTVFgbwXzFq2runnF1lJCu/E@vger.kernel.org
X-Received: by 2002:a05:6102:38c8:b0:4b2:5ca3:f82a with SMTP id
 ada2fe7eead31-4b3d0dd08b6mr25382508137.7.1736940058390; Wed, 15 Jan 2025
 03:20:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
 <20250109-dt-type-warnings-v1-2-0150e32e716c@kernel.org> <CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com>
 <CAL_JsqJNgxLgvB502Bk=5aMeP2rY6KVL_FykeSyN1tsDRXi9cA@mail.gmail.com>
In-Reply-To: <CAL_JsqJNgxLgvB502Bk=5aMeP2rY6KVL_FykeSyN1tsDRXi9cA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jan 2025 12:20:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZsQ9UbwVub=36P_2DCPEN0aORz9FxCbivKkOyeWkuww@mail.gmail.com>
X-Gm-Features: AbW1kvZXi5Smb2F45PP21ukpGGJBUJHR6GTKRuyvhrKiJT6HDjTDpB8juhwGWRY
Message-ID: <CAMuHMdWZsQ9UbwVub=36P_2DCPEN0aORz9FxCbivKkOyeWkuww@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: Warn when of_property_read_bool() is used on
 non-boolean properties
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 8:19=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Tue, Jan 14, 2025 at 12:35=E2=80=AFPM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Jan 9, 2025 at 8:42=E2=80=AFPM Rob Herring (Arm) <robh@kernel.o=
rg> wrote:
> > > The use of of_property_read_bool() for non-boolean properties is
> > > deprecated. The primary use of it was to test property presence, but
> > > that has been replaced in favor of of_property_present(). With those
> > > uses now fixed, add a warning to discourage new ones.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >
> > Thanks for your patch, which is now commit c141ecc3cecd7647 ("of:
> > Warn when of_property_read_bool() is used on non-boolean properties")
> > in dt-rh/for-next.
> >
> > I have bisected a failure in secondary CPU bring-up on R-Car H1 (quad
> > Cortex-A9 MPCore) to this commit:
> >
> >      Detected Renesas R-Car Gen1 r8a7779 ES1.0
> >      smp: Bringing up secondary CPUs ...
> >     -CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> >     -CPU1: Spectre v2: using BPIALL workaround
> >     -CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> >     -CPU2: Spectre v2: using BPIALL workaround
> >     -CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> >     -CPU3: Spectre v2: using BPIALL workaround
> >     -smp: Brought up 1 node, 4 CPUs
> >     -SMP: Total of 4 processors activated (2000.00 BogoMIPS).
> >     +CPU1: failed to come online
> >     +CPU2: failed to come online
> >     +CPU3: failed to come online
> >     +smp: Brought up 1 node, 1 CPU
> >     +SMP: Total of 1 processors activated (500.00 BogoMIPS).
> >      CPU: All CPU(s) started in SVC mode.
> >
> > Reverting this commit on top of my work tree fixes the issue, too.
> > However, I do not see how this commit could impact CPU bring-up?
>
> Strange. Perhaps the of_property_read_bool was inlined into some
> special section before?

I re-added the old inline of_property_read_bool(), but with a different
name.  CPU bringup starts working again if I replace at least one call
to of_property_read_bool() in arch/arm/mm/cache-l2x0.c:aurora_of_parse()
by a call to the inline variant, or even if I just add

    pr_info("xf_property_read_bool(np, \"wt-override\") =3D %d\n",
xf_property_read_bool(np, "wt-override"));

to that function. Note that that function is not called at all on my platfo=
rm.

This small change causes quite some reordering in arch/arm/mm/cache-l2x0.s,
so it looks like a layout issue. More analysis will follow...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

