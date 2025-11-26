Return-Path: <linux-acpi+bounces-19275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90901C88DED
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 10:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2635231D
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D846303CAF;
	Wed, 26 Nov 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0jZqolv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C93302159
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148227; cv=none; b=iRPAIypj6e/fXRxA5kJTZnHKETLrQ5sbDyXAL/FZAKiFpPYtxaCalgzLfM/2u6Nnunpman/KN9T95IdYcGTxn7RVby40OuaVyXf80pSiIVLNdPkT79tZVhBPQChGd2UJn3G957q2v4S5ElgvGl/iEs6dDRnfc44Kwa+wYSgmqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148227; c=relaxed/simple;
	bh=1Gh+v9gZlx4T+2vP2/a+CEj14Wm+hS7qirELQBW3q2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr9fE3t2WbMQOaWaXxk7iu344KjUt9cCBsemD2LpSrgPZdA0FS+z6NpDvYPbowJUv8i0kRLyBT76QSJqv7zC4OQ9J4gqLCbA/8UPf+oMu5EoTa5t1aud+i+WGFFJiX3grqktlUaaTC4Mqcq5iKkwA4s4sud/1vW/kmU0IyPsgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0jZqolv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA91C2BCB2
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764148227;
	bh=1Gh+v9gZlx4T+2vP2/a+CEj14Wm+hS7qirELQBW3q2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y0jZqolvA7hXFfMAw3hJ7asvZznjTxeWPgdjxIsFuK7HKMO4Aup6xgMuchtbnJrWK
	 xwHhJa5s00+VgaGP0ML7tieVIDbVQF+iwIWSKLuRdn17r7ZCfmOGkDvaz5chhKzg10
	 6nuZs180dCROf6d0BqFD4aQrPkytxlHR4p3UdXOoYlzcUKG7y65OdDl9AqZWj0YoUy
	 yoPsX6VqQHAnD4aQTu5svKlJ0TOQMUtEl97rI5l/4ARfHFMSjCpLQ4gBbxMQy16n5h
	 WNQsEGuhpZqW72YAf+JKsA029R4llEpPHQZ1GKjiJ8c5kBmdrVYOY+MXl0Kiucajop
	 ciirWL/s93zAg==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6432842cafdso1855467d50.2
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 01:10:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+p3HPGKx0b+DI2G6beQem0VbBxVfKqI1KoQ3JiNB19hLoOSI32H1PwK5Koe3GorHEfiLz8ovue7b3@vger.kernel.org
X-Gm-Message-State: AOJu0YxLB2UVS6Bp61J3EYAj5gEw2lYQd72zqlKaX2BkUFs7Ct76NPjr
	VSSl2cpBSxzukL/ojOHuTHxmPgCViie8rvwjJ0jETDesEYLa9YXjax8O58GPhPpWbOgecULxZcI
	6dJuoiCEH/Gnk9HPwNsCpzydNNNscmf0=
X-Google-Smtp-Source: AGHT+IEn+dWU8mxRAWLhMi7GP0Lw8+OC8N4aZc4Hh63NWSD8PewoKHoDsfkyUR8ez/7yCP4Jhv1U4PvoktYwLmnE7yE=
X-Received: by 2002:a05:690c:48c8:b0:789:552f:b576 with SMTP id
 00721157ae682-78a8b490616mr155805427b3.15.1764148226208; Wed, 26 Nov 2025
 01:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125023639.2416546-1-lei.xue@mediatek.com> <20251125023639.2416546-3-lei.xue@mediatek.com>
In-Reply-To: <20251125023639.2416546-3-lei.xue@mediatek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 26 Nov 2025 10:10:15 +0100
X-Gmail-Original-Message-ID: <CAD++jL=h4ZEgrjgGOfgFyAXBM7EL91ZD-La82UQ7GPOXv8h9WQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmlrwKgRMkbTd5MLDMlxjKIz8VWVRw6PHOOri4KCmVC5vDi2iUqAwHA-0o
Message-ID: <CAD++jL=h4ZEgrjgGOfgFyAXBM7EL91ZD-La82UQ7GPOXv8h9WQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: mediatek: Add acpi support
To: Lei Xue <lei.xue@mediatek.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Sean Wang <sean.wang@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, yong.mao@mediatek.com, 
	qingliang.li@mediatek.com, Fred-WY.Chen@mediatek.com, 
	ot_cathy.xu@mediatek.com, ot_shunxi.zhang@mediatek.com, 
	ot_yaoy.wang@mediatek.com, ot_ye.wang@mediatek.com, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:36=E2=80=AFAM Lei Xue <lei.xue@mediatek.com> wrot=
e:

> Add acpi support in the common part of pinctrl driver. Parsing
> hardware base addresses and irq number to initialize eint
> accroding to the acpi table data.
>
> Signed-off-by: Lei Xue <lei.xue@mediatek.com>

I'd ideally like Andy and the ARM64 ACPI maintainers look on
this. (Added to To:) and CC linux-acpi@vger.kernel.org.

I'm not aware of the best way to deal with ACPI in combined drivers
but things like this:

> -               hw->base[i] =3D devm_platform_ioremap_resource_byname(pde=
v,
> -                                       hw->soc->base_names[i]);
> +               hw->base[i] =3D is_of_node(fwnode)
> +                       ? devm_platform_ioremap_resource_byname(pdev, hw-=
>soc->base_names[i])
> +                       : devm_platform_get_and_ioremap_resource(pdev, i,=
 NULL);

Just look really quirky, I think there are better ways to go about
this and sometimes the ACPI maintainers give some good
pushback about the firmware as well.

Yours,
Linus Walleij

