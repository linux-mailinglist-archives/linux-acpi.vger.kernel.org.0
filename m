Return-Path: <linux-acpi+bounces-14961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DEFAF6964
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 07:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9513A4E5CF7
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 05:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F4628B7C8;
	Thu,  3 Jul 2025 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oRfiQrSC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1242A9B
	for <linux-acpi@vger.kernel.org>; Thu,  3 Jul 2025 05:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519807; cv=none; b=O1yMGXlrI2SuykJ3Zfo7NDPkH9H6QzpRFcO/Iiya67D6K0bPjsowZpfrvM7cKWNh1gGCBgEKZXHuLE3tM8RVY5pIDydSzXimfDcMBt10+EUpxioj44CP+5mnuoGWaopKJmg0qrNdST/0s1UxompFaQm8Hmani4aU6j7zhSuqJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519807; c=relaxed/simple;
	bh=5++AYJL1rr9Zw2k1O8YtBYT6eG8XMOCdu/Bm09aDZf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StRa5Zo6kA4N68bwqgr+MgNd48a7o2oa0rRWDzoTGeGIb9n2K7Ubu1QcG9yz177eUl1tr4wLjT6yU0IakgHJLERbMQKbdd02rhxizidOeqwkMBROH1JbmDfUk6wHC6qZC5sRvTFEugdH3Pp+tX42cZWbpek8oBmAeokJ5ysCs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oRfiQrSC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32cd0dfbd66so41316901fa.3
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jul 2025 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751519804; x=1752124604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQGz01tJhAAGwav0P9s2fsB1+wOe9xwJQtDO+Z/F508=;
        b=oRfiQrSCWdmS2Xci+ljopcSLoXTlFX6BHwDiCehpGj/iF22bL35oYl3/s3bhmNgKM7
         OgknSu1hW0QJEWadauQzqv9h8/umdsowBzyFRn5KGgMCeaKHmIp/gXWbv+KdUTMUYtWp
         hSlSMH+0rLNGtGsynGN+oqFQIPtvqKEfarWi7/cPUWuvov5VOPi/33WJpDW+pW+StPsp
         ewADEh4nvd40m5VS/F0y7OvEvGgLKcIgmY67urGTHYjJLYrNXd1wR/PQCAWCfsRIRSHU
         9w6WfWHtUQnwol2pIdy3zwOUuQOWrQRhira0852RDQn1xeBBbjX6udCD4HvR6sX8nH4z
         fUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751519804; x=1752124604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQGz01tJhAAGwav0P9s2fsB1+wOe9xwJQtDO+Z/F508=;
        b=XLSKUDIkBJXNqnQtFXbnuTi+x/m/OcTnybWOPgtajtWeiQNkDX926i6R2VYFuLfz5v
         8+qAKXSAykXeKxhGqV7n9CfK7kdph081O3t7nYh4nhgnj047Nxh+1XMk/Oochg2TEeWJ
         kYBfzPxtz9/jhW8n/rPerZM5/HM9cccVWK+BJ5Z8fR/axiH2cw7G1r2764LwzzwPCGMf
         tfQrpnnNwaXQXieskHEpahs6zEoqRajbmlZgipWaIrXYHZu4xwyyY9OASzhlidGqBJlz
         1JE0UpZ864Ssyy6802beWOWCrBPUtqwk2dNkmNIo62BKuZKUd8Zq+vc1TKjNKQ8ULMO2
         Gh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDaFGENbmUjSCebRKDzF+pIVqNeLEtMzJVbkgP01vxNVwJnixjolnysGnBj9Agdi9Kf98LDM5AzJ7/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh721LxHp7uroy7+LcFJXsYgICZhtPj6KFMJ+C/XK22EzVG3Dr
	JLDmj9zhdD9lyDrkeuVsC8m+wGHmyUforMOrUiIRHlis1UxknlTAOQe3XHxg4NgIcLzf87qnOmV
	LpchaXMODdKEokxHBcN3yCt0h4HpMKBYUCGqbovUHdw==
X-Gm-Gg: ASbGnctEy8aaL9ZQT3BqHdP6HvMpjvEEAerT2GpI+FH8L5/7k4kcn5hcXZri9PLcvs5
	sSerQoFBp7HontGeRG4sBMFnchsmpDA4Jq7jogWI77regUTW97TKMPB2gudMNJPwgSY6xSvQ9u5
	B6XevomVUxlDAiqIEb4n4nYq2FQHaAHTjAmcneV4TAyQ==
X-Google-Smtp-Source: AGHT+IHYSiHUidLGv4dXFytFZP2Nt0HvbdpSFDn7lYujOZRVAvsZkPmjzani3yVgvf24c1Q3Pz34/X6Np9T1yBQoZbA=
X-Received: by 2002:a05:651c:1116:20b0:32b:4749:f929 with SMTP id
 38308e7fff4ca-32e00084c44mr11819561fa.30.1751519804242; Wed, 02 Jul 2025
 22:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-4-apatel@ventanamicro.com> <aGUg3h_vigc6mq5a@smile.fi.intel.com>
In-Reply-To: <aGUg3h_vigc6mq5a@smile.fi.intel.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 3 Jul 2025 10:46:33 +0530
X-Gm-Features: Ac12FXzWllMhgTE9HbRqxwe6piDDOSlScwKPfW6gr6Tv5nNXJiWHPlUH56eQbZc
Message-ID: <CAK9=C2VxhC6soxHtmacedbeCU=rFi84Br1RvN2uPcBKoLhRaJw@mail.gmail.com>
Subject: Re: [PATCH v7 03/24] RISC-V: Add defines for the SBI message proxy extension
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 5:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 02, 2025 at 10:43:24AM +0530, Anup Patel wrote:
> > Add defines for the new SBI message proxy extension which is part
> > of the SBI v3.0 specification.
>
> Actually a few nit-picks.
>
> ...
>
> > +enum sbi_ext_mpxy_fid {
> > +     SBI_EXT_MPXY_GET_SHMEM_SIZE,
> > +     SBI_EXT_MPXY_SET_SHMEM,
> > +     SBI_EXT_MPXY_GET_CHANNEL_IDS,
> > +     SBI_EXT_MPXY_READ_ATTRS,
> > +     SBI_EXT_MPXY_WRITE_ATTRS,
> > +     SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
> > +     SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
> > +     SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS
>
> Add a trailing comma.

Okay, I will update.

>
> > +};
>
> ...
>
> > +/* Possible values of MSG_PROT_ID attribute */
> > +enum sbi_mpxy_msgproto_id {
> > +     SBI_MPXY_MSGPROTO_RPMI_ID =3D 0x0
>
> Add a trailing comma, and you might want to drop 0x. I don't know what el=
se can
> be here, esp. in the future, but some kind of the description of this in =
TRM
> can shed a light on what is better pattern to use.

Sure, I will update.

Regards,
Anup

