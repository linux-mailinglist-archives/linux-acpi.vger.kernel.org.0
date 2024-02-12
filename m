Return-Path: <linux-acpi+bounces-3391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA6850E2F
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 08:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3128284DAC
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE0B79C0;
	Mon, 12 Feb 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cZqZ4/zH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C7748F
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724307; cv=none; b=Mgi4PuEBynBLOBAWyIXNT9bVgeRbs7ChveTeycxOg8VCzY2WN3PeHlG+I3/miBdHtsQhma3MyVJ9YDitXwNKIFHx4MoVgqEb3V5rnzwEEn0KYxX69dOzFyKgRGUSkwLdF6OS/d4KCM1J36xJjgbZ3Jg19AIyPNLswNOO/UlcVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724307; c=relaxed/simple;
	bh=GmPMC9cxelUl9DkJoWhA3pWIyFQPb/CAwZB3pmldXmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMRT8RipYY06Q1bPf6eTFWw6B+bIlnr/O0MBGjapjFC1Yxnqe7koO+oaAEc1uiw4Fya1ZKgnaB2T/lb9oVVMSlzeXp5YVtYywIJ557RkMtTG5H+18aPIXARwdpvevn/ID+zTr6QeH2VQwVvnUivbzrCCZiamhdnF2caiZJo84pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cZqZ4/zH; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc75c5e3151so1644115276.1
        for <linux-acpi@vger.kernel.org>; Sun, 11 Feb 2024 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707724304; x=1708329104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32Tou1Qp7IHz2vUBn/orM1Ce9D9jIM2Uhi50dr+N0wA=;
        b=cZqZ4/zHhjUBPsjalbF8k1PByyFoQ7+r3W0OYKlQ+dankmBsLIOfi5mmyPJKcxklNC
         BwcqcOJrUevK6ilmqhOQwdM3rM5oV7mibPRmSTLgTaiATHLL+ul77uI011EnDQm1Xghc
         haS07zUzO7ggn+QO6At6Z1Eaf1LOHr+y6xPnvBdTAux3BPWGss1dBtxf2WUO2stHwN0n
         9rP1O/zref189vaOVDrCVW3j30DG5pCXaQwOYbr/UXoesKLZwu+VEDyImWc9HRmC3q/4
         /l4zGXhFGVGrUdH3t8FmVka7m08nlomYB0x3fJfkdVhgbS/4NqiY68OfFLWs+WkljmHa
         mQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707724304; x=1708329104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32Tou1Qp7IHz2vUBn/orM1Ce9D9jIM2Uhi50dr+N0wA=;
        b=iK0gCnuBnxTZBbwL1O1WUa1F9rUs6xbzXPw1rvC/RzbjTC+LqV/cDUaweH8hzuVvso
         6dGP4VsvKML59RQjxOHe5ESNtTCi6Yq9q18T/c8rvd6y0FrFZ/GRMWKTH3Zw+ZNAWSdH
         Nzb+0FS9EiSWSt7AuJEA2cqruPELcczBohg3CNAkk9IY8HRarSU4LwfSLRP1lYCtLMXc
         dzLZCKNL78zCRtVzE0jEQ23xxzP6M/bzxKT6adqMWRZEjv/8rjFaDwIZFWSGKN6scHui
         l6p0cC3JQ5O+GXwOic2qaM+9RCdLc8ZrewH+40Z3N8ywMD+K6gMKvQmgOSLvXhHen5sr
         CKww==
X-Forwarded-Encrypted: i=1; AJvYcCWJjAzwEUCBr7oaHwxyhodzPoqh8spJuyJVO91jB8us4vaqC6Q8tDCkK0eQ+z7mN/TQYWlN6G7dmsSqf+4GgON+F5B1Z8NMEuonuQ==
X-Gm-Message-State: AOJu0YzofztDBazMBbxmsBvHeDSTPyvgd8vzAah6yjFwaO7ABgzJWA/m
	FRsgvtXFeaNHQIEOwVLMhw/8GCcG8/dwN93ZLlQhe2/eOhQuUFfaCFcli1Q2HWyOYsUPL6tGDj0
	xaT5/bDYRxgefr9VOJhobhgd4WmH/Ae+eIvUM9w==
X-Google-Smtp-Source: AGHT+IE6AG5BEdtTJzi6l5A68kuFhQmg8n9q5XHQsKliHkA/T/Qxpbz63K3q91RHDtMrz8uf2Pn7vG7JAxgOpAoBFxM=
X-Received: by 2002:a25:7412:0:b0:dc2:645d:163c with SMTP id
 p18-20020a257412000000b00dc2645d163cmr5445571ybc.6.1707724304704; Sun, 11 Feb
 2024 23:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211192540.340682-1-jic23@kernel.org> <20240211192540.340682-7-jic23@kernel.org>
In-Reply-To: <20240211192540.340682-7-jic23@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 12 Feb 2024 09:51:33 +0200
Message-ID: <CAA8EJpqyT8E-hhUvxbAMPcDPmq+LMCxc2p96=XYSSO9kcuPJiA@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scopd()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis <tomislav.denis@avl.com>, 
	Marek Vasut <marex@denx.de>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, 
	Marius Cristea <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>, 
	Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Feb 2024 at 21:27, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
>
> A slightly less convincing usecase than many as all the failure paths
> are wrapped up in a call to a per fwnode_handle utility function.
> The complexity in that function is sufficient that it makes sense to
> factor it out even if it this new auto cleanup would enable simpler
> returns if the code was inline at the call site. Hence I've left it alone.
>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

