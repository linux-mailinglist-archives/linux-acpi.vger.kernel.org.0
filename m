Return-Path: <linux-acpi+bounces-1144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2957DE5FF
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAC01C2040D
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03A1B273
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434815E8E
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 18:01:38 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5FFDB
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 11:01:37 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-582050ce2d8so10771eaf.0
        for <linux-acpi@vger.kernel.org>; Wed, 01 Nov 2023 11:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861696; x=1699466496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mapiw/yUgyBFbA6JcB8ebVWjGu9xA5twSt60npPEBos=;
        b=jkLoVVfeobRH4X/KWlo7+XBchE9nRFbpz8Ba7JHmQ9tdiI+kuL2UCO3ArGCGMWO+GF
         G7QWbOHrGn7xRLRHpBSjNOWQNwSsO1DzvJ8Y8zg9EpI+jfwjQGEFp7+O0QQqbODkGtLP
         YpfYl572pkueuBEoZrBQ8ZGb9UBXspzQL0rp6CAAtKU+pcPxBck7cX09g4ZYysnpTXzW
         TooHVSmvp43ZB7MgHz7D+Gxu2BA95Y1DRZGsWmai+ate/BxzLlsv+gbWDtWLK3yTxiHO
         n7IeYinGSd5wLdQQW4ri0YeUFKYoYgGwmq/I9oKLsqoXT4bGXgEaFd/nY5ZUma7dpE59
         BrqA==
X-Gm-Message-State: AOJu0Yy7UAQdYULfopcpELiICgpBLX0S5VdNHIXcHbe7/upextarpwk2
	nahIhNuRhuo8Blbmm2+tP+ui+sAy4XQ04+c67ggQwpPj
X-Google-Smtp-Source: AGHT+IH4c2Wv+WUb/NyGI1nPdliL9peur5oTlBZe9qs8alr3iEEoVAuO9O4FyPx4DVC8zj5nuOjxExwijjaFDF4eL1g=
X-Received: by 2002:a4a:d8d1:0:b0:586:abc4:2c18 with SMTP id
 c17-20020a4ad8d1000000b00586abc42c18mr16479935oov.0.1698861696153; Wed, 01
 Nov 2023 11:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
 <ZUIfp43KYDvpdife@smile.fi.intel.com> <ZUIkOov2eykf0n1v@kekkonen.localdomain>
In-Reply-To: <ZUIkOov2eykf0n1v@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Nov 2023 19:01:24 +0100
Message-ID: <CAJZ5v0jDZTet5+hbCGq+Dd9SDvJ+kiepjHU-yuq+zb5_uWcwHQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Make fwnode_property_get_reference_args accept NULL args
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 11:11=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Wed, Nov 01, 2023 at 11:51:35AM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 01, 2023 at 11:07:34AM +0200, Sakari Ailus wrote:
> > > Hi all,
> > >
> > > The of_parse_phandle_with_args() accepts NULL args but
> > > fwnode_property_get_reference_args() does not currently, in its ACPI =
or
> > > software node implementations. Fix this.
> >
> > The last sentence assumes Fixes tag(s) which I can't see.
>
> Oops. I realised this is actually changing code added in DisCo for Imagin=
g
> patches. It'd be better to address this before those.

So how exactly does this affect those patches?

