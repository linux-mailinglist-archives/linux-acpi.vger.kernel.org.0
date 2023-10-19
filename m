Return-Path: <linux-acpi+bounces-767-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687B7D032E
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 22:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1383CB210F0
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 20:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7309038DE1
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCGTwJVb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDE32C64;
	Thu, 19 Oct 2023 19:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44054C43391;
	Thu, 19 Oct 2023 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697742957;
	bh=czcO7pul0pidk9X5haDsczOJ7Z/4f1Lehio1PveG3/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BCGTwJVb38aVHGQ6jIWqezw8ESZczOnhpdBcnCLqhiHM7FY0ZjWcbdgszxbVYEKxa
	 602a1McW7vib3FMLaasVsj5Yx3t2jY4YM67lvjiD5Q1j03rpIawNYo4+uSVSv521b/
	 1o0L5ePmESFgFgyYdOxZrPUqzft4TctM1t1p8lfgcUNnAAKCwwTeCmBn9WKCMDqHEY
	 lAkVgxgBFBdRQ3D2rtiyvrTD4grU3ZKXStkkuA/fAyV4hfYmxJk98dBvEiPv6xsc+/
	 zRTqLvY9yF9InhrDv/LL5MSkoLS+73mb5RHujiniGlKWuEYFeALFk8gkvst8zma+nM
	 Mis0QQBtozfPA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so6151494e87.3;
        Thu, 19 Oct 2023 12:15:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YyYfdQ2B/J/AETjAaBVGwY2F79Q5yOJGQURNU1k7qnp9e5Q/CXp
	szwWxR3B223LqajaK0uWI0oxzDOtrc17aEFlRA==
X-Google-Smtp-Source: AGHT+IHaK3/fQu58LwNVXyEcMTjvuZkQtps1qGk5hQ/5nVuxeS7lpPPatdI4JWkX1iBzto62YR0/Tk8NJlhYkkCMeFc=
X-Received: by 2002:a19:380a:0:b0:507:a624:3f35 with SMTP id
 f10-20020a19380a000000b00507a6243f35mr1957100lfa.41.1697742955464; Thu, 19
 Oct 2023 12:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
 <169756785858.2487391.2620832432762980006.robh@kernel.org> <ZS7VrxX6If8Afl5R@smile.fi.intel.com>
In-Reply-To: <ZS7VrxX6If8Afl5R@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 19 Oct 2023 14:15:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLsdjiAYupw-U-voLWGaJoiUTW49PJJYXAhG1podivP5w@mail.gmail.com>
Message-ID: <CAL_JsqLsdjiAYupw-U-voLWGaJoiUTW49PJJYXAhG1podivP5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] amba: bus: balance firmware node reference counting
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hanjun Guo <guohanjun@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Peng Fan <peng.fan@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 1:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 17, 2023 at 01:37:43PM -0500, Rob Herring wrote:
> > On Fri, 06 Oct 2023 17:57:31 +0300, Andy Shevchenko wrote:
>
> ...
>
> > Applied, thanks!
>
> Thanks, I hope w.o. patch 2 as it seems it can't be enabled on non-ARM
> platforms due to some strange MM APIs.

Yes, just patch 1. Isn't it just the driver with the error that can't
be enabled, not all ARM_AMBA. I suspect there's a more portable
variant of what was causing the error, but didn't investigate more.

Rob

