Return-Path: <linux-acpi+bounces-2587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1154081C212
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Dec 2023 00:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AA21F2522E
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Dec 2023 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD8B79485;
	Thu, 21 Dec 2023 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fyDSnKZy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820779460
	for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2023 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbd7248ac28so1221685276.2
        for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2023 15:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703202381; x=1703807181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C5yx1D4sy7Cq5xnSJGT/Y8ISb8yXl+5GPlJ3CTgBqlQ=;
        b=fyDSnKZy0Tc6WHuq9MNrw2Q9bKBZMm8Jyf0nItmRhcYRD50M70EgPaHX6fW0/XQOsK
         EVM2mzNXKR++YEYmmPwqDqE8y5IGTowaDbeSK42I/ha+7MiMJaZ5EbwbRICQR/ap7TOF
         nqbqWxw8iYyM1vAXPCR4Um0pxfpadvKm0RLTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703202381; x=1703807181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5yx1D4sy7Cq5xnSJGT/Y8ISb8yXl+5GPlJ3CTgBqlQ=;
        b=m/9h0teYEBXeMsxRq3qnQnhwRayv9Td5+5uYJ+B0gXHRxelLk4cQRGEjTyBJpyrzX+
         lrePUTJkV9pNYk7KX21YSZFIi9V9qLdD1+Emh6UC47w0WlqyRpa1psxjUMi1iqLBWqZN
         29976mB+pqRQ6Z3+RhtbYDe5wXqIDTyuBEVNX+e5hEZFQW5qnsfoYK7QmF8wrxs9EKRn
         iQzCuztFzQ1/O4HMRBUyr80/6/3UxZ5bHbS5ebKGUGZuJzxBu18El3tgyurhnWeRdWMb
         mAMA6QFntA2fQd2e6Ea7XruOnORaushb533ILg3A8dlggg2lIWqHmcDZSqOFCka2GDNd
         L7qQ==
X-Gm-Message-State: AOJu0YwTVum8Mad3+v8ZJshJ9bIPWe8O5wQOan7wOk8pgEnkUbmdk2f9
	lX3bh+Jsrr2brjPI7CCR6CzZsNA/9za/LO7FauUSN0GD5EmPip9v2j/yUB2sNg==
X-Google-Smtp-Source: AGHT+IHQuqPUTWtpvEWWlBXrPZ7P2rJCDTvZXPGIY5MnJ0dX/9smRrJ/j9aAo6gegLAC+pvb0F1tQqld2angQtN2hv0=
X-Received: by 2002:a25:8387:0:b0:dbd:c3cf:2433 with SMTP id
 t7-20020a258387000000b00dbdc3cf2433mr366468ybk.84.1703202381711; Thu, 21 Dec
 2023 15:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid> <ZYRD9Y3Y_jd1NBs8@smile.fi.intel.com>
In-Reply-To: <ZYRD9Y3Y_jd1NBs8@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Thu, 21 Dec 2023 16:46:11 -0700
Message-ID: <CANg-bXDLC_+mxFU+dHyCx1K=HKTwwGw+r__6_++Co2-viTbsgQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/22] device property: Modify fwnode irq_get() to use resource
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Raul Rangel <rrangel@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Daniel Scally <djrscally@gmail.com>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > -int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
> > +int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> > +                         unsigned int index, struct resource *r)
>
> It's perfectly fine to replace ) by , on the previous line, no need
> to make it shorter.

That puts the line at 115 chars? checkpatch.pl allows a maximum line
length of 100. I can bump the 'index' argument up a line and keep it
to a length of 95?

