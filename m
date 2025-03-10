Return-Path: <linux-acpi+bounces-12002-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86EEA595E4
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 14:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0EB188F321
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 13:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A77F227E90;
	Mon, 10 Mar 2025 13:16:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F53374EA;
	Mon, 10 Mar 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612576; cv=none; b=gZz1+R7SyBcQlYC1J2+ErDXO2HOP/rg6BYgTX/9YldEyJ1GQPci6S6LOMeXmrKD8KbaccvXzFNQl40vqVIKErGapaRMMgcYuecmyOX3e3kvJK0x8DNNO0q56xyuf89NRytYbFRxctAmGMYDkcguTfIj9HUArog/vdxxFLZFnNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612576; c=relaxed/simple;
	bh=+pe8nMgc4fByYrl/J+ifCMz86M7Dbvi7gJXrq56sYKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohoWH1wvDHKIrlSdrwgbg4osXR1N9hiKkYBV+mSTcySi+VZVYj4VOVI2JfjKQGyaZCSM0EZJNg9Oa2Cra0/7pI1P1xBug6HHHP4A0GwWzItW4cEYKNF5zO7AYxVZ9i0L8YhiSE1GY88Ij80C4EMUBX2yi78Zg1Y271aNPELMNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86b68e51af4so1571739241.1;
        Mon, 10 Mar 2025 06:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612572; x=1742217372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bwMEAH7Tb2p80rG5YQFDISiH+2UdxhzZVsTz2rTT24=;
        b=t7j3P1PB0LMPauR2TSwADqFHF9kh9wqf0O/5vcm8YwCCZVhPYYIZB0Jtyg3sIJdf2p
         9e+R7ZSz+LiTDryi37ZJUQ5QyCNUMMA5+PCv4pWcbb1TH73i2CbyZPfddKLUWekJ9t5V
         v5cwmaCPuynNkXFJnYFS9lva0/tj5XvxRn5NEUFvsETGugrNEjs/P30E9sE5s41ZU43p
         AO1LGmXuSiMYLQZ07WpSG9v2Qxdkf8CLs9uJPVkNdZKNsjzDzqwUF5+MwkzXny5CJqXb
         UN1403kQAFCTp5HYe/KyT4o5wlRwx2K9z65CUm0xgc/y9lRrFJxVZcty5y6VxRIppSnn
         C9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCULVEHMV3HQRdKtqoTXhnGRgMra/mieCmSS15UgAR9muZae4NDcSq3+PS0/Czjiy2GeGvPVdCFQVsPkSw==@vger.kernel.org, AJvYcCW3iqEwe7AonyEAwR1kdMfa2UwTRXPaViYdnPiB4q3DuB5LgQoXKHROl0fo9/QyqMJOCFrnWipqvVfx@vger.kernel.org, AJvYcCWBjew7Qg5f6ogFrgSqhc5wmOG549CZnvGJD4o6dycVGDqylq90b80CwZiw4SLcHyewyt1LXa4V0vrS9eiyXMBp5SU=@vger.kernel.org, AJvYcCXKKES9M/K57Cy43q03UUatKTJvB5cA1Llar/NBtdQDjqJnfhVqujtFRVLUpO4jrQ9kdGhWmhuNa1G58Hcf@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrhOCrPM9KepIGIUuIkslSKiof/Kd2YUn4ENNfxikrg/GU0jF
	uNcaAxVaJCcSPL96Oz6IWnhqFEHkZ/fS17UL8QlMLg+5D2tDbC7td2bYcge10sA=
X-Gm-Gg: ASbGnct+F+ohhZFG9dMs666/wzZII150jggJ/0ugx73GzoTm8UAfAtmRZ00h8MuDNnO
	rbmI1Sa6M3sy5fsJNg393FzohleJRI7g4bIWTNEtZHZ+OTte5DRS4UTpd2W0qrQQapZ7NMBFDzz
	0aLpmMQQY4AiuhqqLXehqZHUXxEwVJLTOXraL7TmbprlkH1dbGMNZRJOFleDHCpqMaydx74uMVz
	wDSSzwKCWf3gV+3uss4T7xklP1zj5JMd2+CCtAfE+v14Kziv0/J0fwmv7w3orrJP9Ps+F6OGODH
	qban99AsFUmO8a1swglXzju6DgNMZ1ZEmZBSVeMA3wbmDy8HaYmUQRr8uqH/i6fsArZC2pWrAOR
	GvizaZuc=
X-Google-Smtp-Source: AGHT+IGWrgaTcuRoRn5yEgZmzyybev0b5x8Pgfkri+MWcuiq9g+56xaQ0aMAe/Ds6Y7so3QX7LZ2mA==
X-Received: by 2002:a05:6102:a54:b0:4c1:b001:b53 with SMTP id ada2fe7eead31-4c30a65e00bmr7130200137.18.1741612572572;
        Mon, 10 Mar 2025 06:16:12 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fbca4f0dsm1953416137.21.2025.03.10.06.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 06:16:12 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so1617846241.2;
        Mon, 10 Mar 2025 06:16:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7bS4SNYBFIDCLQzyaCt9+rVecXwAtEP3CFAQXCYj672PkPZSKFT4Ak0TcmEDrRMHHM+QtamChMj1wxpxS@vger.kernel.org, AJvYcCUyfVV02FlPf1N7Cu31Jvh4mXvAWJY7Egi4nDxOpicFaJzB92g1tFhuxal6T7wQjsdyXH62kBoFa5dF8aGZbcly920=@vger.kernel.org, AJvYcCWMAklpG8RKLlce+oKS/RE/hZ5nVZzsj6pwdA4cYb8V0VbKmYjdEHr3bh+hP+p4AKgRB5iGKA0fysiD@vger.kernel.org, AJvYcCXYULFZRpvku56HBjE350JYXjrdIBn5v9H5n3SmTh6OVjuf9GAR5hxyLo+sJX52hBBiQPAzHlcgeCCmPg==@vger.kernel.org
X-Received: by 2002:a05:6102:3583:b0:4c3:6c4:e174 with SMTP id
 ada2fe7eead31-4c30a65d92emr7228931137.16.1741612572135; Mon, 10 Mar 2025
 06:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
 <20250109-dt-type-warnings-v1-2-0150e32e716c@kernel.org> <CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com>
 <CAL_JsqJNgxLgvB502Bk=5aMeP2rY6KVL_FykeSyN1tsDRXi9cA@mail.gmail.com> <CAMuHMdWZsQ9UbwVub=36P_2DCPEN0aORz9FxCbivKkOyeWkuww@mail.gmail.com>
In-Reply-To: <CAMuHMdWZsQ9UbwVub=36P_2DCPEN0aORz9FxCbivKkOyeWkuww@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Mar 2025 14:15:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHsTYjamDkyoe_CwJhXbf7LpAPk+Dazd4wChEmfcuYPQ@mail.gmail.com>
X-Gm-Features: AQ5f1JraxfzSSZiwFZoSk4-gLUnOHP6AW4upV-5J6BIK6IbQAuD0VMWwpRICbuw
Message-ID: <CAMuHMdUHsTYjamDkyoe_CwJhXbf7LpAPk+Dazd4wChEmfcuYPQ@mail.gmail.com>
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

On Wed, 15 Jan 2025 at 12:20, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> On Tue, Jan 14, 2025 at 8:19=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> > On Tue, Jan 14, 2025 at 12:35=E2=80=AFPM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Thu, Jan 9, 2025 at 8:42=E2=80=AFPM Rob Herring (Arm) <robh@kernel=
.org> wrote:
> > > > The use of of_property_read_bool() for non-boolean properties is
> > > > deprecated. The primary use of it was to test property presence, bu=
t
> > > > that has been replaced in favor of of_property_present(). With thos=
e
> > > > uses now fixed, add a warning to discourage new ones.
> > > >
> > > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > >
> > > Thanks for your patch, which is now commit c141ecc3cecd7647 ("of:
> > > Warn when of_property_read_bool() is used on non-boolean properties")
> > > in dt-rh/for-next.
> > >
> > > I have bisected a failure in secondary CPU bring-up on R-Car H1 (quad
> > > Cortex-A9 MPCore) to this commit:
> > >
> > >      Detected Renesas R-Car Gen1 r8a7779 ES1.0
> > >      smp: Bringing up secondary CPUs ...
> > >     -CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> > >     -CPU1: Spectre v2: using BPIALL workaround
> > >     -CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> > >     -CPU2: Spectre v2: using BPIALL workaround
> > >     -CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> > >     -CPU3: Spectre v2: using BPIALL workaround
> > >     -smp: Brought up 1 node, 4 CPUs
> > >     -SMP: Total of 4 processors activated (2000.00 BogoMIPS).
> > >     +CPU1: failed to come online
> > >     +CPU2: failed to come online
> > >     +CPU3: failed to come online
> > >     +smp: Brought up 1 node, 1 CPU
> > >     +SMP: Total of 1 processors activated (500.00 BogoMIPS).
> > >      CPU: All CPU(s) started in SVC mode.
> > >
> > > Reverting this commit on top of my work tree fixes the issue, too.
> > > However, I do not see how this commit could impact CPU bring-up?
> >
> > Strange. Perhaps the of_property_read_bool was inlined into some
> > special section before?
>
> I re-added the old inline of_property_read_bool(), but with a different
> name.  CPU bringup starts working again if I replace at least one call
> to of_property_read_bool() in arch/arm/mm/cache-l2x0.c:aurora_of_parse()
> by a call to the inline variant, or even if I just add
>
>     pr_info("xf_property_read_bool(np, \"wt-override\") =3D %d\n",
> xf_property_read_bool(np, "wt-override"));
>
> to that function. Note that that function is not called at all on my plat=
form.
>
> This small change causes quite some reordering in arch/arm/mm/cache-l2x0.=
s,
> so it looks like a layout issue. More analysis will follow...

The assembler SMP bring-up code for Renesas SoCs lacked an alignment
directive.  I have posted a fix:
https://lore.kernel.org/r/CAMuHMdU=3DQR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-=
OjqA@mail.gmail.com

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

