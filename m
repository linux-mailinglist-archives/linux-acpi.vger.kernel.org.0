Return-Path: <linux-acpi+bounces-1778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA097F5A13
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 09:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E97B20D61
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1181CF8C
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywYR/1HX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632BE1BF
	for <linux-acpi@vger.kernel.org>; Thu, 23 Nov 2023 00:18:03 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cd2f1a198cso4380677b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Nov 2023 00:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700727482; x=1701332282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvQyz8WUbCXXcHlGWxMEoDuZxvoCOtrHTLLemanVJpw=;
        b=ywYR/1HXWq4++wDj5eemMv/6QtWRWPoqX9MM6XzyU0G4LrwZ1Fsvlz7iw04FroAMLR
         +/5bpq/ZR4zRxG5l0Jed9gsT1AdGk0FNNDiXpM+hxrWgA30ciDNBVzE1tsrcF37vrFTO
         Gm00lmlKs/g7i5/KsyCZz+RvVhaxPbBoSGSA0pQ7wbTDJgrFFu5ttBNKI65aJORL35RQ
         6q+uN5V+LqstUGbeZ8nqYJpV8j3Uln6cU8E4JLUQUg583LYTZoGOJmkkv4OJeJ+idlIS
         Jh3y5fuFc/oC5QHaEAtc7Ba0gtpXPqZxafEUH4WVBy9EAI1QNDRK4Rr2xNc1Pav2Xh/Z
         r6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727482; x=1701332282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvQyz8WUbCXXcHlGWxMEoDuZxvoCOtrHTLLemanVJpw=;
        b=WKNLjehPbADSIyhYmqy76RdUw488An2ITtyO3wvUAgHYoPFqSPyNY+lJRd1/YelClX
         SsWdA1ePIMcPerZSeYFr8IyvnYLsQna9DEIlqB0jAZvZMxyASjKkELXHHJ10YJwObhHp
         +85mHgXTUQrwSxUNBd8L/i0ejUT7tm77pWGS4bijEQqvFcPI4TH/nyuJwwpuwU7AdAbj
         luHK/+0kLPRmXoFhKWRNxdt4+oGcbG1A9FzN8hb3K4QWwZ2y7Y3thLkwxh7ox2x9QCCa
         /Z4y+smXIJdwHsYjGBrQ/iTwDJTAOQ7KIGfqS6AT1YsSgk+5l9wRFAiEy9UGRibmvia/
         jX/w==
X-Gm-Message-State: AOJu0YxNV/HnKq74DaBZqDhFmCOCvdacfAVRxPQP7oVnbsNFqchO5keJ
	HAICsgJJP2wzaKnCfOhyb28ExF4kr/WcspPsrOyH6w==
X-Google-Smtp-Source: AGHT+IEwql/FgZ2i8ySsNVBR/Nowgs8VsmzDvaDcvugx+PF9f25ta/GIkylxpBoLVtMa8WZ+CpZvXGDmbeZBOafDiZ8=
X-Received: by 2002:a0d:df0d:0:b0:5c9:e7f8:ba03 with SMTP id
 i13-20020a0ddf0d000000b005c9e7f8ba03mr4532566ywe.4.1700727482614; Thu, 23 Nov
 2023 00:18:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170066723324.2477261.2506149141979712937.stgit@djiang5-mobl3> <655e7361d6ce_b2e8294b9@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <655e7361d6ce_b2e8294b9@dwillia2-xfh.jf.intel.com.notmuch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Nov 2023 09:17:49 +0100
Message-ID: <CACRpkdYjEgsyCznNwkSaStk+DMtjH3_oGeX4f4BJzpo5eXHm2g@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Dave Jiang <dave.jiang@intel.com>, rafael@kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org, robert.moore@intel.com, 
	Jonathan.Cameron@huawei.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, cfsworks@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:32=E2=80=AFPM Dan Williams <dan.j.williams@intel=
.com> wrote:

> It concerns me that neither linux-next nor 0day robot exposure reported
> this problem.
>
> Does ARM32 require manual compilation coverage these days or was this
> just a series of unfortunate events that the build bots missed this?

It's not just ARM32, I saw it on ARM64 as well and I'm pretty
sure it appears on any bare metal "none" compiler.

kernel.org host "nolibc" cross compilers (Arnd makes these):
https://mirrors.edge.kernel.org/pub/tools/crosstool/
and those WORK, because they use the kernel minimal
libc which defines __linux__.

So a "nolibc" compiler works but not "none" compilers.

I think the test robots all use Arnds nolibc compilers or the
compilers from distributions so they don't see this.

A typical example of breaking compilers: ARMs supported
"none" compilers:
https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads

Yours,
Linus Walleij

