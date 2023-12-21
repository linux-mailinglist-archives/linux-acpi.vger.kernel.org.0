Return-Path: <linux-acpi+bounces-2588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A381C224
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Dec 2023 00:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AF61F24EF5
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Dec 2023 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE50E7949B;
	Thu, 21 Dec 2023 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGYQOHbT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28E79460
	for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2023 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e74b4d5445so12954797b3.1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2023 15:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703202746; x=1703807546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f4uDw1WRa5SG6czjbnHQWjQZqqBhTvomA48xZ5HM1C0=;
        b=JGYQOHbTu5Gxz60wEAoJB654AtQ8EeAk4+j6KhBmg1QHmoRQykAgBS4pAI6KhlK9yx
         /5wMO3ua50bhBqZGBzZcw72fd0xF8YJg05FTo+/sB7c3cMJZBuoQ4idgRr8F73KhiuSS
         7gleeIOqQW1qoWd3/xqyl3JcuKBUySOtzOpF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703202746; x=1703807546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4uDw1WRa5SG6czjbnHQWjQZqqBhTvomA48xZ5HM1C0=;
        b=rJYQVMxDbI7lO0PofcfW3PrRtMnHGoR/d9ZGp6woWEG39k4qK6bT+AIJWgm5FZC7ys
         JbNRpeTEDoMfeL4cZH8x7EU4hyD5l0G+BAg9hICMfw9smcNPYEqEFlL+VOrn7gwr/9Cn
         w9I4bzJ67a6pKFC+qY8j7DifYxBa+n2G1OBFVplpMKXFOenWXdihh9RlawzduZS2/tlW
         8hK25LaH3dqR1oiZLjwPQATwIui5acva9CmoUiy4Zmhu3ZUPNl6iMhVMaC0wj83cGHMU
         ngLWPTs6IZVIUDRB7BZ7hsBHteuAmr1MWhd9J84OPOktKqK6kTALS9k39oGVXMvEopN+
         fS+Q==
X-Gm-Message-State: AOJu0YyULa9Y2jKbLKcLKvh7JCOEdiootyJdFX6U+V/1YB8Ej7C8QNWn
	V20QhdS8pAyZEBTQJS8vA86touGaKkAYEHkY1k5erYWhrrPn
X-Google-Smtp-Source: AGHT+IG96IeFRHAEMgt3Wqqj3SdhdbJwAuHf3E0l0lDeoWxWb2boVBsBUrO5u3oIhl+2lMoELCJ/o71NhaoTJPqm+AU=
X-Received: by 2002:a81:6f04:0:b0:5d7:1940:53d0 with SMTP id
 k4-20020a816f04000000b005d7194053d0mr557320ywc.72.1703202746631; Thu, 21 Dec
 2023 15:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid> <ZYQVdE4esAZbtMrn@kekkonen.localdomain>
In-Reply-To: <ZYQVdE4esAZbtMrn@kekkonen.localdomain>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Thu, 21 Dec 2023 16:52:15 -0700
Message-ID: <CANg-bXCshpg5=rRiaxbjdEeD3VNsdV-cKxu-nCqT7K_f8wJodA@mail.gmail.com>
Subject: Re: [PATCH v2 20/22] device property: Modify fwnode irq_get() to use resource
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Raul Rangel <rrangel@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Both acpi_irq_get() and of_irq_to_resourece() use EXPORT_SYMBOL_GPL()
> instead. I don't see why fwnode_irq_get_resource() shouldn't do the same.
>
> With this changed,
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> In fact this should have always been the case for fwnode_irq_get(). I
> wouldn't mind changing that, too, in a separate patch.

Sure. It looks like fwnode_iomap(), fwnode_irq_get(),
fwnode_irq_get_byname(), and fwnode_graph_parse_endpoint() could all
be updated. I'll add another patch with these changes unless there's a
reason some of those functions shouldn't be GPL'd?

