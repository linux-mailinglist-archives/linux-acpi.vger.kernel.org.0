Return-Path: <linux-acpi+bounces-10644-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A164A11108
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 20:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992791690DD
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 19:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA4E1FAC29;
	Tue, 14 Jan 2025 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA/DwNmt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DE1E495;
	Tue, 14 Jan 2025 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882371; cv=none; b=JNhjsSHkfB+hSyNXz48mF7u41N4API5OB1bxnyis1zEODR9aG/TgECdmN8hMRJJqkb6X6YmL1aERgGOMd7PtRJYsu3IfLyZ9k4niwTqh37cHVOPHkK6k6UXtYLfJsybKIk7JO3o0U9hs6B+mGXS7u/vXiFSQwLdNuhOfoZ6XV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882371; c=relaxed/simple;
	bh=wNLwRm7wdLk3dPZc27yM2BcjsFJ/mz9B1AEvKrW/Mew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhT7ak9PpjewsQu0ofM4T0BR6xvWF8cLs2Vno9A62BZKufUgEP9+eSbsTIs1clMThukLFzLwJKgLUArboW7+rAJQezviEqs1/wx4qgx0h6mwGZp6e6idL1jrDDazt9xD2GfwFVp+iEmtLxD7SWj4hchrJ/BDXvW0szaeh0sQgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA/DwNmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B525C4CEE5;
	Tue, 14 Jan 2025 19:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736882371;
	bh=wNLwRm7wdLk3dPZc27yM2BcjsFJ/mz9B1AEvKrW/Mew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mA/DwNmtR3D9U0pQCiHx8tJbSXsG1hQfT5nSFwUSY6whNEklToPrqR9Mjy5y3QqHY
	 cmrIyE5fGjVV4CdOeK6/9MPG6W+H8COEw7SijLRvkefqw0xAapdP+iA2hZzOUAFvza
	 ctPL2h2GIvI9MSot4b1MSWv4YcQewf+0+Cm166xdMevQPjw5crmUg2vkVAKS62auTX
	 RPZrFR+PpyB566h/1RKWjhPcf25Nz0hNffrQNDcloz+aabTTV5G/VkYiU6+uukFre8
	 B3/fmGUn1EK1Ur5P0j63te+q9zlSy/HWBnnmmZiqqMSdCeymelgLUBcfVCx+YhFPif
	 fNZaaHTqlV3Cg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54026562221so6095970e87.1;
        Tue, 14 Jan 2025 11:19:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUedc3zw2O4AYlk3GKV+gtjbnTx1nm68tZAKZeX/3Bed2UPM45+Te3q8wlthB6bn/PcVw9yzYpWM+ZuMs3F3ib/TmY=@vger.kernel.org, AJvYcCUst1aP60v/qPeLj4zIW8Ntke3cQSwUeargy+LP5IngOJR3Cm8jCmUUNtsaJS+blkfaoj2L7ui4iF0bvQ==@vger.kernel.org, AJvYcCV9o8rfSPONNj+GexIzQBYplsraZaXA2W84em333BAUxqxkEWStiiBMzbxt02yyTVXiCOQDk7bkA4HXQsMt@vger.kernel.org, AJvYcCWWPuW6I3wxntKJlS9Az2vj78R2DuLvaUsL4g9qiHY5XfaMC76qY++FwwBNQuEPQQ6R59+AMjwqy1cE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7RBe8UPCWBgC2x0E6+JMblYkAkWa2z9g2mkxyQQ4k4RPQkZr5
	xmk43nEhwhjUZiq2j0bRkf1D+D6p5jlocXznZb/KxY1PaitkG6m74DUqfJGKTvqTSD6i3Ch7LTP
	3jmJkrXI2sGvUKiszRFoKCqu3vw==
X-Google-Smtp-Source: AGHT+IEqG4XRMZtJ9Lh9dvBKs52ZTxH5d0ZfeXBNi6+PJGqugNVSMiC1ZnxvngslJflsTGxzuDYG0LdAxMk3LbbH0So=
X-Received: by 2002:a05:6512:3c95:b0:542:218a:71a with SMTP id
 2adb3069b0e04-5428454b727mr8309688e87.26.1736882369482; Tue, 14 Jan 2025
 11:19:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
 <20250109-dt-type-warnings-v1-2-0150e32e716c@kernel.org> <CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com>
In-Reply-To: <CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 14 Jan 2025 13:19:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNgxLgvB502Bk=5aMeP2rY6KVL_FykeSyN1tsDRXi9cA@mail.gmail.com>
X-Gm-Features: AbW1kvbPnm-ogWlhAdqQreKVNOX-GaPyfXDzQRi47HZsT4PBKy3PkLZG42wEY4E
Message-ID: <CAL_JsqJNgxLgvB502Bk=5aMeP2rY6KVL_FykeSyN1tsDRXi9cA@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: Warn when of_property_read_bool() is used on
 non-boolean properties
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 12:35=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Thu, Jan 9, 2025 at 8:42=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:
> > The use of of_property_read_bool() for non-boolean properties is
> > deprecated. The primary use of it was to test property presence, but
> > that has been replaced in favor of of_property_present(). With those
> > uses now fixed, add a warning to discourage new ones.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>
> Thanks for your patch, which is now commit c141ecc3cecd7647 ("of:
> Warn when of_property_read_bool() is used on non-boolean properties")
> in dt-rh/for-next.
>
> I have bisected a failure in secondary CPU bring-up on R-Car H1 (quad
> Cortex-A9 MPCore) to this commit:
>
>      Detected Renesas R-Car Gen1 r8a7779 ES1.0
>      smp: Bringing up secondary CPUs ...
>     -CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>     -CPU1: Spectre v2: using BPIALL workaround
>     -CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
>     -CPU2: Spectre v2: using BPIALL workaround
>     -CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
>     -CPU3: Spectre v2: using BPIALL workaround
>     -smp: Brought up 1 node, 4 CPUs
>     -SMP: Total of 4 processors activated (2000.00 BogoMIPS).
>     +CPU1: failed to come online
>     +CPU2: failed to come online
>     +CPU3: failed to come online
>     +smp: Brought up 1 node, 1 CPU
>     +SMP: Total of 1 processors activated (500.00 BogoMIPS).
>      CPU: All CPU(s) started in SVC mode.
>
> Reverting this commit on top of my work tree fixes the issue, too.
> However, I do not see how this commit could impact CPU bring-up?

Strange. Perhaps the of_property_read_bool was inlined into some
special section before?

Rob

