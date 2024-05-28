Return-Path: <linux-acpi+bounces-6026-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619578D178C
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 11:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F20286E18
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55525155C8F;
	Tue, 28 May 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijPY4OqH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020D13D89B;
	Tue, 28 May 2024 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889989; cv=none; b=L9SjFhrVd3KXG5iRAFYQ+cqvOrFJKdNPO04vmDWTnqKJ03ixQYiVoD0qmgZm3Plvp6fIsSjXmrs8HuUXYAfW3b87ToyCv/zBawvZgNT/cbY4UsWsib/yoJAZeJSHuWwDXvarPU+x41xmEoIsCzyGYB5O/eyktelNTffc9AtcbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889989; c=relaxed/simple;
	bh=w7VJZ0cKWwjQ3VbY/fJF02GZdaxEQ3KlxTZ+whkRYsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9yTkJHLvXl0Orc4fq8H5WMwJLm3JcJMlKkzzAhvS22Pp8nnyOMVAsyx0phVKKHrOn9Ewlu3gU5G9wCIhv12H7M8r5XXiPbRiORS5yxBx9xfS6rtR+0euf/qpnFQlW4csrv+I4axVrJt/5BGqmCTFihROSzFImuZXVfccEtezxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijPY4OqH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5d67064885so89014366b.1;
        Tue, 28 May 2024 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716889986; x=1717494786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7VJZ0cKWwjQ3VbY/fJF02GZdaxEQ3KlxTZ+whkRYsQ=;
        b=ijPY4OqH68KPSIH6pYFEYNkCr+Uw0bQ9gjWa3u/bba5hf5eEAiaMTc5LK1/3bV7noN
         5DprflwHXvEU2SGCYzXtTmosWJCCMQ5o83VKwoe1genwiIURqUIu1tnB5P9IdrtGgjNB
         5nBJlWmd+vveYimx0SWOJfA4RAMS3uXIZM1T0GrG8DDYToN8YRvmm1bO+ECUYkad2rgH
         9eiKdewV22bzKpKsN9+m5on1+xWpTJOqKPdprcWuzYpU8aaC07gCv3ptEpD7A8AxplFD
         phAuB4Whd9FdSUKX2P3A8iDIm/o+KJQ1nEhc1bHyJVjHx5vzbM64Nbpy/ugymzJLlQ//
         ysOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889986; x=1717494786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7VJZ0cKWwjQ3VbY/fJF02GZdaxEQ3KlxTZ+whkRYsQ=;
        b=A8rAlw5Foy1C7Vx/e7O4IVM/MPKloawgKvN1nRTeLgkrA5KfQmUfbeQ6FAOOhrCgSN
         FxDKjq2OwIJYuLnVgsD1NhjJb5T1pqhTX0h1dXGzFYta1Yd+wVXzTOWRi94zwJcFinF7
         V/D+6RhGvZYkKAl8MNPGyP3BT1o4clFzQfmC6Hrv3/qPEM5f9Ls3CXPtqhAM/jgv2rit
         64Ft0dJSOLfPegFnnp5HpOZko3FohaGp4tB9tC6AI2hVyxi3DUDN1tYxZ5WcI54Z6zug
         Uonn0eQc6ccEmwtbLotCAkFqQsXMUV1MVsOkW+cSXfVRQs0wfaj7R3Qy7i53CXSlC+Hc
         9Myw==
X-Forwarded-Encrypted: i=1; AJvYcCXj7C0ZoUiplYf1StWLH/4MI7PNJ2a1r3e5uNr9QfjASCM+9PiplBlHcmW72bkh8Mv2yTtsWpAUZ8BkN0u/SZTXigG+z86j3TUmMrWEgm7pcKuOu+B/GF3mSAYmfdRGVSDPzlLgDkNADg==
X-Gm-Message-State: AOJu0YznddAb6xP3kOKUyzYxzKgL+sCsEBc7pv1y6BDiLB2AOdXnZoX2
	CbVDCdwuNKFXSYfcctoI8ShYWc4lrInu+W4rLhn7T9zCLMFAFRq2pDHZICpvAYE8G8Cekh0QhE2
	pSYn7Y6uNe80QSgHPoLFdcHLc1Sk=
X-Google-Smtp-Source: AGHT+IF8aVYcQYVGlXYdgjNwO2xeFVRdGHyx9scEp3Sd4m9SUmEO4DJP72Uo1Uf/CGfjFcj6oJY/ORHS3GuzC/ZLq5E=
X-Received: by 2002:a17:906:3505:b0:a5a:5b23:c150 with SMTP id
 a640c23a62f3a-a62646d591bmr1222043966b.41.1716889985903; Tue, 28 May 2024
 02:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527202424.1430103-1-andy.shevchenko@gmail.com> <CAJZ5v0i8N-SuKyzm1o601G-G9Jis4uciu3gxO-08GN-X-z0LUA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i8N-SuKyzm1o601G-G9Jis4uciu3gxO-08GN-X-z0LUA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 28 May 2024 12:52:28 +0300
Message-ID: <CAHp75VeOX3NqPxFWduRAXGhw8zDA1a4E1jk6L3DzvfjKX-KjVA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PNP: Export pnp_bus_type for modules
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guanbing Huang <albanhuang@outlook.com>, 
	Guanbing Huang <albanhuang@tencent.com>, Woody Suwalski <terraluna977@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 12:42=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> On Mon, May 27, 2024 at 10:24=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > Since we have dev_is_pnp() macro that utilises the address of pnp_bus_t=
ype
> > variable, the users, which can be compiled as modules, will be failed t=
o
> > build. Export the variable to the modules to prevent build breakage.

...

> > +EXPORT_SYMBOL(pnp_bus_type);
>
> Why not EXPORT_SYMBOL_GPL()?

To be consistent with the rest, but in any case Christoph suggested
something else, where _GPL is assumed to be.

--=20
With Best Regards,
Andy Shevchenko

