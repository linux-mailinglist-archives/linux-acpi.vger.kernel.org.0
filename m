Return-Path: <linux-acpi+bounces-769-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7297D0330
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018D1282204
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD44A3DFF2
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovci2yKX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57064354EC
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 19:21:20 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96522114;
	Thu, 19 Oct 2023 12:21:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d129e2e7cso71415a91.3;
        Thu, 19 Oct 2023 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697743276; x=1698348076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HI2GVWsYasNpFkCUuFSfyfrgfawERt55U8XyVGdh4SA=;
        b=Ovci2yKXiQ1jgKsGCoSxXz/PI+mDEm06VI1sUUvZnF+NsvhGIrnqeITtc447fue2jr
         IyPjwX8XurfX3a/HeEFoe6wsfGokRa5foPqJcHv1517tmN59gIFLGWPn1jzY/PUdreLi
         PsRpsfhqlUxHoTooZtNKiLp/v7TctG3owlFMdYSSx9S+r0f9vFUaMTAPhXzKCSPrI68x
         KopxamLzKwDSFdzN2mkwiJkbrbTHCadHQdMKhIgJ0InJ0/8mME1jBfDaRqRKpv3eQIO1
         3eDvjvS8zJVqQJgSQ17ok66JiMGrx51jaLFwWpuGV7WVILTjIBqXp25HElmDEAc9BQc3
         62Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743276; x=1698348076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI2GVWsYasNpFkCUuFSfyfrgfawERt55U8XyVGdh4SA=;
        b=OfBkBkiLWnyYvv3NwEQhBg2u+3wI5hhxy565wZICSohErGw28WF8iEStbxx+PvNjnA
         GGpwQB77Mj5TIygFPHCtMF+JgMgBkJSBCVM6qslmQZSfFj/4FALCrivaiu9JVYt/l1Nk
         5e4t5a9OBEu3KyvhKiz0IxIrX2dNw8Tb3Yb/Od6Ml8mH61jpi6iZTf47PaKVDmSoGacY
         x3gPBQ5vtFvjXROg4bqm+xk/au+mfKATT86oL71qIrxzv+zJ+vqx8C/mgSVdGym8Xvek
         u/5Kpn0dW/qy/mkiOkStmc7OHgPe9+QAXgxWw2IBCknRPiPyB+pMjqyMJwwkwrGAHmqz
         TX9Q==
X-Gm-Message-State: AOJu0YxmnjT5UXcqfyx0jSq5elfkgd9h5cvRIid2ru5wmGkSOPqrYPWu
	16IUi2ZPu5NMzKOgrNPK4+ZNnElT52s=
X-Google-Smtp-Source: AGHT+IG6uLhIiISw4NsI2oZ3knWAOF7551FfjEQY1Xf9H8/u/9rkw7UwL9aAGqUk9V7ANx7JwR5qLA==
X-Received: by 2002:a17:90a:196:b0:27d:8d42:6def with SMTP id 22-20020a17090a019600b0027d8d426defmr2975229pjc.34.1697743275856;
        Thu, 19 Oct 2023 12:21:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c4c4:bbd9:2220:727f])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a7f0500b00267b38f5e13sm134133pjl.2.2023.10.19.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:21:15 -0700 (PDT)
Date: Thu, 19 Oct 2023 12:21:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Hans de Goede <hdegoede@redhat.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 2/3] gpiolib: Fix debug messaging in
 gpiod_find_and_request()
Message-ID: <ZTGBqEUzgGCcZP1B@google.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
 <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>

On Thu, Oct 19, 2023 at 08:34:56PM +0300, Andy Shevchenko wrote:
> When consolidating GPIO lookups in ACPI code, the debug messaging
> had been broken and hence lost a bit of sense. Restore debug
> messaging in gpiod_find_and_request() when configuring the GPIO
> line via gpiod_configure_flags().

Could you give an example of the before/after messages to show exavtly
what is being improved?

Thanks.

-- 
Dmitry

