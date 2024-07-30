Return-Path: <linux-acpi+bounces-7154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056D94214F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 22:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CB0283B77
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A47F18CC0E;
	Tue, 30 Jul 2024 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUilL7LF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574E18B479;
	Tue, 30 Jul 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370122; cv=none; b=QbQ9Y1cJqgBAhuZZ8bFVS/SNBkvsp1UqbLRzv9Npsiwnc8mDz4Av8xe0g6n8l+KYSVo54CNEla4n2PisGrYLoU/wNSxOyji3dFiE+hrSDXdE3q690ggwsRjzZAXSKCoXT4g1ED/5T5yrsU4PIDiHgwD13MA3UzZwOnbluZz+GB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370122; c=relaxed/simple;
	bh=h0NV6t5QXTqcZqsM+OT8qbKeJU6QTMxqsY11ZyrJlks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ9J/lhuUeR0JvFAyYP4pYXSUIsspwWaxA3cbZ/B6svk1mIbQ1QsMF+GHpK76t6Lhjn3bAjXjZtD2Zk/XwTWpwHY5Cfhd5sp9eBoGyohfWEtuwL80ONgfFTICQwCVcgd3SE+ajDUaUuwRTic1SsiLNM6SeDsN20yRBILQ4FIdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUilL7LF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso466410666b.0;
        Tue, 30 Jul 2024 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722370119; x=1722974919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObcydJx+vB/NhNmYBIqRcu/qYc3jNCZPZ3qG/kjECDA=;
        b=IUilL7LFJs/TKOky4KWoAfU2Gax2a53FR3IawppD9U/q9H4v2IHRL8lWsOpdaA3WGI
         IY8CQL8li3b69JvhyqG+bVdqPuzlEomifhILDkpPAJYx+g1U9Yvs6TGIQV21hNumd5ex
         6Btt7EDSaAoL8QIJTPOpzEz72OHGOwb+kNGVXaHhelmYmv1u+y4GCDuK/CH61TB1owLS
         fyq7UWJddO8pCP4f88ZdUKwpUFzmnn4FQl3v28EEN90Yuyr06TxTVS0XbzrcXR4LlPyc
         3X6ZnrwvpAmjSNj7KaN+KfuXqy+rGvqQP4AZbVK0GFU+CfEdQ1fcd23MDTpyOsU6zqym
         uFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722370119; x=1722974919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObcydJx+vB/NhNmYBIqRcu/qYc3jNCZPZ3qG/kjECDA=;
        b=YAcSMMDXXvkoIiZHGiVWev1ndfU+YLD/l/6fm94HF7Cqn5JUpL2zj4y9fIQM/dSQZk
         KvqMx4fOjgqL45LCPPdznYc2v7aUGjv1QUCvyPkR7Ih0Ug6gnmYZ1XxqtGYrC20V7pyY
         FuqDa49H6EW1UnTZlW8dZgofQkUneJzGKxKKEmoo+YtN3TY+PyICCHD7xTH4w405hqkz
         oqR4r/4HfsaPS4VJGY6vO7vkmtU5zjTgrTN0DaRhRJXIL4/o3eS4RYTxhUXgrCImwNxB
         Xry4c1hII9rQOCtMo+hwNihXOOda4ZECpQDdI0/t/gadZG1avMoF+0bmoGTbWfXjc20R
         9fHg==
X-Forwarded-Encrypted: i=1; AJvYcCUWNJc0fJ4UuIllQJ44xtm5flqjnigRqxLdhXWzgyXViIzO83rG8ALCoq1w6GsviEdwDu00eo3UpqDdEOwAMM0qjaFHY+VrD1qmkDscaKv3H4BeCjXIF53CBghcxeS9Dl79EewqGrbRvA==
X-Gm-Message-State: AOJu0YywgeOF33/VkcAYxoLXbb9UMZwIBfpXZ53DE4jhCGIgP0LbJL5M
	LcOhBDs9c+NYP0rsSEwS77KP68qsBpfeM7QBhNjktidQXTV7yx6TlVcIeRttRKworraj5OihgXB
	ugnRu5g8m9+QrPIW1FOklQRFomdc=
X-Google-Smtp-Source: AGHT+IFywArELRtrFVEn+pIHnoIWf3LnPPCOKj7ciEMd+clptmEM5/FTsVq7yhJ8E9hVnneNXrTP0olyCHFqLkbVViU=
X-Received: by 2002:a17:907:7286:b0:a7c:4095:ccb6 with SMTP id
 a640c23a62f3a-a7d3fff71eemr964807066b.16.1722370118393; Tue, 30 Jul 2024
 13:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705113434.17249-1-amishin@t-argos.ru>
In-Reply-To: <20240705113434.17249-1-amishin@t-argos.ru>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jul 2024 21:38:35 +0200
Message-ID: <CAHp75Vefw5FB1mK8v-FJ5MBeSo_N9fgiAFPdYw2w_OCX5UxrAA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 1:36=E2=80=AFPM Aleksandr Mishin <amishin@t-argos.ru=
> wrote:
>
> In tps68470_pmic_opregion_probe() pointer 'dev' is compared to NULL which
> is useless.
>
> Fix this issue by removing unneeded check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

...

> -       if (!dev || !tps68470_regmap) {
> +       if (!tps68470_regmap) {
>                 dev_warn(dev, "dev or regmap is NULL\n");

Now this message is misleading.

>                 return -EINVAL;
>         }

And I dunno why it's a warning and not an error level.

With all above being said, I would recommend to update to

  if (!tps68470_regmap)
    return dev_err_probe(dev, -EINVAL, "regmap is missing\n");

--=20
With Best Regards,
Andy Shevchenko

