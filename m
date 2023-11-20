Return-Path: <linux-acpi+bounces-1623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF97F18B4
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 17:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84451C20B71
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED51DFCC
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNEPf+HK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E603A4
	for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 07:25:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2802c41b716so3459538a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700493946; x=1701098746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST028Kw+5opFnctTC026fdT6iYVhh3htW2mHBCbv3rM=;
        b=TNEPf+HKlYZ8A7VjdjLqlMf50cwFlug5NQnOQ72H+1lcrh/Mzc453QDWCbeYVia7bf
         LhfbKopGZeNT1AbTvXj25RGYoa+C56y+KbjGqnh0YrqyNVyoEu+C0xS4KEeq6YXMgXm7
         2nDS7y7U0AVRPU6idh06HdpJh/6qag5NBqYSQ/gz1GW6IyaW4o4/JeX+voc1vVV6JkZq
         RThnJ2I/LxA8FiVS5SNj8jehwLhuoS/eF/QSSBKExYrSHN9+7Vl4oQJr8O4uRIgS6UoZ
         mAU/Kr7xhcy2qGbr7JCJSEaAoOaNxj87Zk4TCxfoZj6bU3dBLEk4NkOYMmLyRO7yQ0B+
         RanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700493946; x=1701098746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST028Kw+5opFnctTC026fdT6iYVhh3htW2mHBCbv3rM=;
        b=dTT6kcxaqA/GdP6cWCOh1RF/GYByaP1+zKyP9RPcJgWG4pxq0Oat72cJA7WcIOLIeP
         8BbX6T7jUi+SsitWhHmNXfVUxIOtwT52TF5PhIKVnzQk03QybUJve3tDT/argjUbIDEh
         YFfME16oVmLE4a+q6+v9q2TY8I5bA9mJdHMitm4TxBPl+5Sg2fHug9nIzlq4EM13FnTe
         lZrmI+HzTW49WTZ1TpZkh2cAlcWKxzNSQlGLTWSEbu+3Hp43erLhN5s8ZKGVRjkgRyD7
         kcT8ZMSsMZsl6sncJrHtFR6ltmV5A+t2A+7pl+msmhAPHPXEftXkjpPZA8DaEurJ9syo
         eptg==
X-Gm-Message-State: AOJu0Yyx2qv4RBBAEqjmqdO4j3MwHI/r2IhjBZySi+iV1S5fiL9zFrep
	WY4ZO0sebWB6cgKgpOJT0K6oCASut3p5cD+bZryxfw==
X-Google-Smtp-Source: AGHT+IGZ24BmTxFlV8ARS0eiBOVZL6XuY7FDIhzbJcGWCamZieGWAK8UG+n6P3hSBpS7YfkOpYF8HB8uorYNx0Elgz8=
X-Received: by 2002:a17:90b:4f81:b0:27d:d36:763b with SMTP id
 qe1-20020a17090b4f8100b0027d0d36763bmr5505892pjb.31.1700493946018; Mon, 20
 Nov 2023 07:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
 <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com> <CACRpkdYUzYxV+NY=mymXP59mt9msTUvSXM__f+4qRM+_xjX0Nw@mail.gmail.com>
In-Reply-To: <CACRpkdYUzYxV+NY=mymXP59mt9msTUvSXM__f+4qRM+_xjX0Nw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 20 Nov 2023 09:25:34 -0600
Message-ID: <CAPLW+4mT5Qpo+B7fSfiG1qRVr4cSvuWhArpu-3kbFtSukSV8_w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sam Edwards <cfsworks@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, Nov 14, 2023 at 2:20=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Tue, Nov 14, 2023 at 7:09=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> =
wrote:
>
> > I am not an ACPI subsystem maintainer, but my understanding is that the
> > files in include/acpi/ are copied verbatim from ACPICA, so any change t=
o
> > those files will have to be sent to the ACPICA project and wouldn't be
> > accepted here.
> >
> > More likely, we'd want to do something about the circular-include
> > situation between linux/fw_table.h<->linux/acpi.h.
>
> I agree but I have no idea how to fix that really, should I just send
> a revert instead so the authors can get some time to figure it out?
>

Just want to confirm that linux-mainline and linux-next builds are
broken for my ARM64 board as well, because of the commit you
pin-pointed. I vote for reverting it and letting the author rework it
properly. On a side note: I'm surprised there are no bots or automatic
CI builds out there testing the kernel builds with baremetal
toolchains. Can't believe everyone's using Linux toolchain, the kernel
is supposed to be baremetal project.

> Yours,
> Linus Walleij

