Return-Path: <linux-acpi+bounces-10079-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53C89EC6B7
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8E218888C6
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D31D63E3;
	Wed, 11 Dec 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4+wwgNi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD141D31B5;
	Wed, 11 Dec 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904901; cv=none; b=fGLAnG/PZwStm0ODl8l9zE91f9p/Ssp3jeWQxJF16PpZn9OmoAtpgxINEFP+Z3JoYrAEIduGnzheErW7TBNCpghw1lHfBeAFTG5gHa5GAPQDAI3vMzLjuSrh6vqah8BX+AlHZk88CIDf4d/vFxe8xhnIqLl8XBFUwVuUZTVfrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904901; c=relaxed/simple;
	bh=OZKCHU/pdesGjb7/BWoBPfGjp7Xwwe+OZIygNrVP4z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8TaH+vVOYzkDI9uvWQpWNziMsJ8ZvIcFQVGveOjGuLLVhRlE6Mg2+lPA9uZb7vc3CRl76rXmeDlRuyz7uSLgd4iHbcVd+2ttkT0Ew4/rzodOhkzlskk4eSCf80BxF2Tt2FbPiNrRhYR58OzbogKFGLYV+0WKdPJQekiAasD/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4+wwgNi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so10088395a12.3;
        Wed, 11 Dec 2024 00:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733904898; x=1734509698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05XXHLAL1GWs9/FdDgMkTRmUvgatN3ljXIIVcYbLoys=;
        b=e4+wwgNih5at2jtAWca2quPkuc6ijp3EM8AAb2P+gI5Wy7aI8yixVqfUpeoBqD92Et
         PS7R3Rw9ZuOq18DYD1tSf+mWMl2Ofw6DAFAk47qP+ofCjqD92zpXAjcpwrvl0shpf8wD
         3No1bjDCBgTP7fZrdu/gNp+KkVcm8DUMm19sII8Aqf9FFl5hqWzEfLmBodCepUcGhcQP
         DGLLpY7kT8M7lemxtYfgepr5c01NahwTTm695PKds5il5pfaUMyUu+aZ4duzl+yx4sl8
         zOlz5OThJvOLOGOk81ldd0ou7SUNh6EHOLtWrhy2AO/T1uWS7BrjSVblQW1mCo80FikT
         4Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904898; x=1734509698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05XXHLAL1GWs9/FdDgMkTRmUvgatN3ljXIIVcYbLoys=;
        b=mFsF2+aKY5E3L12gkO7WhoQ3tJgcXul80svf7J1kPo50XHEOAUKs/WdxAE4USv/4gI
         QpuIw+bksqojeoAbENWgY8a8xEGjddT8RTMsB+ktwojRWvg5C0e3CMluZnE+0COx/QUD
         ixxcWwXCQxu25nENB6iOhOMzkyXXwOueSc6ETv6m/sdbL6Ksh3QdZtHVccZ3tdw3GBxR
         5g0lDnjt/Tp3lzEjmctEa7ikIFJjYE5KBr+T3QUPuYc3uZGU2z0Vov8Sl5i9NQfLURkR
         wtu+4dm+C7vzudpbMMyasXLCnIVb8RYySYxPboqtPpSVFhM30OuYGHKh2MbBtak474Ug
         /abw==
X-Forwarded-Encrypted: i=1; AJvYcCUxipIjYDpkktVtFQiHWVTWQaD0n/HfozeZ/W9fDT7zzSe+kbxC13eJGygie+s8kyLRktbnUjkWHijXxLc=@vger.kernel.org, AJvYcCV3QHsmAO3ENQoq2RjNJeBV/38wF64zX/Ccbe3M09uzzdDgnLbf+5dnoRshOIRKE2GHWyM8cPdtkEAYM3c5@vger.kernel.org, AJvYcCV4xeSX/SagTNgKupZ7U8YBNUJsEdH4PTwCCLveQedtqOIwFfiyK9+rgNiF4GyluyY9g9KePz1yPSYw@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkOzwc8uOwMaeytRvutMICheO278jaRySokeLaZHWmf8pkbvw
	1lF9ocCmtMOFtj8u2vbz/iELld4A28AnEB1Os5dhETy8vNTvCRHL
X-Gm-Gg: ASbGncun6lzjAzabjILZx4g0cYAIUPqMsY2GzGJfhy3yX8wOe1lSjESLM8+c4k2AdRP
	bCyWj0MvFJKtSBhqigliyuL6QU9m6XznWlCs8MN1navq8ua0cNldfjFLdeo8FIPGWh6os2Gh48y
	q9l8pdsB6yKZbDKXbAdaNigzHEEODMxS/HowEnm2NWA8Xgto9WZmD2lXwZVnjyUdxR5s4pgePY0
	6K+n7VPB4ICWO3Ag3vBFXcTtoqru99ZACaGuBMVnOVekDrY6A==
X-Google-Smtp-Source: AGHT+IFsenM32FRUt0A9qhL2Wv9XuhKKZYu9aGb2En7SV5Vb6M5lSX0nBPskTbG1y2SOMxIxowZ7ZA==
X-Received: by 2002:a17:906:3089:b0:aa6:92de:ddae with SMTP id a640c23a62f3a-aa6b115bd48mr177853166b.16.1733904897999;
        Wed, 11 Dec 2024 00:14:57 -0800 (PST)
Received: from foz.lan ([95.90.158.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa675581337sm546245266b.120.2024.12.11.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:14:57 -0800 (PST)
Date: Wed, 11 Dec 2024 09:14:53 +0100
From: Mauro Carvalho Chehab <maurochehab@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
 <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
Message-ID: <20241211091147.717e53a4@foz.lan>
In-Reply-To: <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 10 Dec 2024 19:55:58 +0000
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> throws the following smatch warning:
> drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> 
> Fix it by replacing the condition.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/pci/intel/ipu-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index a0e9a71580b5..be82bc3e27d0 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
>  
>  		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
>  #else
> -		while (true) {
> +		while (false) {
>  			sensor_adev = NULL;
>  #endif

The better would be to just remove all #if and handle ACPI compatibility
with COMPILE_TEST inside acpi headers.

Besides that, t sounds that patch 2 makes this hack unneeded, as you added
a false check at the for macro:

	#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
	for (adev = NULL; false && (hid) && (uid) && (hrv);)

Please place only one set of subsystem maintainers at the To: line,
directing to the one(s) you expect to merge this series.

In this particular case, the one to be added should be the ACPI
maintainers.

Regards,
Mauro

