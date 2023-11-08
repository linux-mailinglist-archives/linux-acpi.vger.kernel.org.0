Return-Path: <linux-acpi+bounces-1355-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0957E5930
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 15:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B60CB20F39
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64D92A1AB
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLLvN3zb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CA3199A5;
	Wed,  8 Nov 2023 13:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E97CC43391;
	Wed,  8 Nov 2023 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699451849;
	bh=oAMyGLNvlEk2Z3kcyrMLZHtZ2K7CmXV47NgxDhyFDAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TLLvN3zbeCodFityx/4ypnt/Ii/fLaigJHu+596F82grUSxrOKhUp5VnJ10ovHhGv
	 TQVt+OifIzv1INb3RTscv+PKfnTR/VZ8VqSq7/ZL66e4nDpmbbBAPs7YOBrYmZnGlO
	 qF/ZUayfqAma1ZWC5m63Ga58DPZ99AmzuijezXivJABvO1R0GUBdOomF7mVGJ5DcPD
	 SatYDtXoRSRvA2oZRCgQjl+dEgpfDW1nV+g1uZLgS2hEEu8CerEmr+rFNBtjpTaqsv
	 XzS65rJj1xOOVKWSPvaaJUKjsWRz/XhhvcYjMSAefJnHMH/E/5ioxrSdzr1Td/5o/U
	 AmTn32Jy6Wjfg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-507ad511315so9991958e87.0;
        Wed, 08 Nov 2023 05:57:29 -0800 (PST)
X-Gm-Message-State: AOJu0YwHrkJ5csqhd4zb3ihEruA5yGxTE5EufmxkrNjMbvsscjqt2ms7
	3tpZxYznzF8FEarKSW2IStkf1vUk1rc6Wtq9Cw==
X-Google-Smtp-Source: AGHT+IGuwHUp+aEG6CZkAVv9OagCbfM3Ciyh9iJ50ppoxMFJJ3ItGNnVmTiHOsiB5o//EA7YPSpGzVzEkTMc7343V6w=
X-Received: by 2002:ac2:5397:0:b0:507:b9db:61dc with SMTP id
 g23-20020ac25397000000b00507b9db61dcmr1259652lfh.48.1699451847501; Wed, 08
 Nov 2023 05:57:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
 <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
 <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
 <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
 <CAPnjgZ1FrdGKjGAxUbkQoL2vHwhC_2Oa2KT+0cm25dQAuAjxAQ@mail.gmail.com>
 <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com>
 <CAL_JsqL+X1DatsGk_Cn1HsbG2GV9AngFWXVysWTiNRu_d9tDqw@mail.gmail.com> <CAMj1kXHfh40wxerZGjOn2JJ5Skm5C--Rz2jy8p3XZ2UXKGjw+g@mail.gmail.com>
In-Reply-To: <CAMj1kXHfh40wxerZGjOn2JJ5Skm5C--Rz2jy8p3XZ2UXKGjw+g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 8 Nov 2023 07:57:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLpea+FU4gXpaSUSeBP70szJ+mRjJtFei=QW2VoHCFOuA@mail.gmail.com>
Message-ID: <CAL_JsqLpea+FU4gXpaSUSeBP70szJ+mRjJtFei=QW2VoHCFOuA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
	lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
	Maximilian Brune <maximilian.brune@9elements.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
	ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>, 
	Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
	U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 5:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Tue, 7 Nov 2023 at 19:07, Rob Herring <robh@kernel.org> wrote:
> >
> >
> > All of this:
> >
>
> > > On Mon, 16 Oct 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > It is not specific to EDK2. Imagine this boot sequence:
> > > >
> > > > - Platform Init (U-Boot) starts up
> > > > - U-Boot uses its platform knowledge to sets some ACPI tables and p=
ut
> > > > various things in memory
> > > > - U-Boot sets up some runtime code and data for the OS
> > > > - U-Boot jumps to the Tianocore payload **
> > > > - Payload (Tianocore) wants to know where the ACPI tables are, for =
example
> > > > - Tianocore needs to provide boot services to the OS, so needs to k=
now
> > > > the memory map, etc.
> > > >
> > > > ** At this point we want to use DT to pass the required information=
.
> > > >
> > > > Of course, Platform Init could be coreboot or Tianocore or some
> > > > strange private binary. Payload could be U-Boot or something else.
> > > > That is the point of this effort, to build interoperability.
> >
> > [...]
> >
> > > > Perhaps the problem here is that Linux has tied itself up in knots
> > > > with its EFI stuff and DT fixups and what-not. But this is not that=
.
> > > > It is a simple handoff between two pieces of firmware, Platform Ini=
t
> > > > and Payload. It has nothing to do with the OS. With Tianocore they =
are
> > > > typically combined, but with this usage they are split, and we can
> > > > swap out one project for another on either side of the DT interface=
.
> >
> > Is perhaps the clearest description of the problem you want to solve.
> > It's clearly related to EFI though not the interface to the OS. IIRC,
> > "platform init" and "payload" are terms in the UEFI spec, right?
>
> No they are not. This is from the universal payload specification that
> is being drafted here
>
> https://universalpayload.github.io/spec/index.html
>
> but the UEFI specification does not use this terminology.

Then I'm confused as to what this is:

https://uefi.org/specs/PI/1.8/index.html

Rob

