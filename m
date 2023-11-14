Return-Path: <linux-acpi+bounces-1489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364FF7EB7F3
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 21:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E595E2810FB
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A32FC2D
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWLa1hMy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBC35EEA
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 20:20:28 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B01F9
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 12:20:27 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7b91faf40so70349977b3.1
        for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699993226; x=1700598026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgIMZhFr5ANe/opk6rHwzR0Wea+pDhCr2RohibRDeJI=;
        b=xWLa1hMyV4GkraWAjTec9cGgpPWb8aSNmJiasSPrt3Rt+M9JKl576Blah5TuiuOst3
         w2dBB2EPP6+IY3vGnnAzD/51PVayZWjXcAcLDrS0pRirkcszuNK1vflEraOQmdu6a9oq
         Cso8icxUt3nwyAFp2bFm5XmSjHyam/ghZlmGlwAJrfFxYM/H9fjxno3sEwhftGirz0b1
         dXFyo9Tec+lOI8E8tgQZ6GbgLx3AueGj64QM5gsrcnA0QcXqingsSWwhRKLZUSN0lZD+
         oh0+zgWALo4RIVc4Ov7cIRt9U5Art/qu42CPUDyKN0zvCvwXG740jvrhh/w29fySJL/K
         jkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993226; x=1700598026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgIMZhFr5ANe/opk6rHwzR0Wea+pDhCr2RohibRDeJI=;
        b=hpMMVkdODgSyCCjekLgU3M2c70iACCYf7ZnAscj7iq+WrVikz32TvFllD9m3IronMM
         EULUrbQFDERN5090S2cCRom+Nf1ZUdBFJL4mIkxA9XkucR+2An6765wHV1trQIB0RXYf
         Ag6Dp0U8NhBFSlB6Z9HzSeolFc8kFQkLs26AJlbblrxXkJpgJs8olrxiMBj894MdHLR4
         8b5HzVNWgrgrJ1iUappjdID7C6u0+eXDdGBc2zAo7g2WIbqJ+hkkYX0vXvXDSsK0j+W0
         wkkD0JR546PFoMK0wWcC+DxZ8t63YtqaYdEWmbxM7AEPAyN/VueeB2HoL8bgLKec6K5K
         YPeg==
X-Gm-Message-State: AOJu0Yy0nIsKTtfKiw+BGHFzrDOTig9rtfIs9DRYP77VPpAuHm+4wtgp
	M56xqohu5OB3o/gLDzeI3eiJRVEo+7WcFET0uiwZoA==
X-Google-Smtp-Source: AGHT+IHDLBa3i08U+nLN0OG3yu/iiLd302obDuxMCccsocWSzYdESyvlcJkxV2yuKipJLTHkRfWr3hMnsJhJHv5hRTQ=
X-Received: by 2002:a0d:c505:0:b0:5a7:ba00:6dd8 with SMTP id
 h5-20020a0dc505000000b005a7ba006dd8mr9813769ywd.8.1699993225750; Tue, 14 Nov
 2023 12:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org> <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
In-Reply-To: <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2023 21:20:14 +0100
Message-ID: <CACRpkdYUzYxV+NY=mymXP59mt9msTUvSXM__f+4qRM+_xjX0Nw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To: Sam Edwards <cfsworks@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 7:09=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> wr=
ote:

> I am not an ACPI subsystem maintainer, but my understanding is that the
> files in include/acpi/ are copied verbatim from ACPICA, so any change to
> those files will have to be sent to the ACPICA project and wouldn't be
> accepted here.
>
> More likely, we'd want to do something about the circular-include
> situation between linux/fw_table.h<->linux/acpi.h.

I agree but I have no idea how to fix that really, should I just send
a revert instead so the authors can get some time to figure it out?

Yours,
Linus Walleij

