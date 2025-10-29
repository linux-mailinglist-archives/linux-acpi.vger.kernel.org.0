Return-Path: <linux-acpi+bounces-18338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 030EAC1A8FF
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 14:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 077B058470F
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33E345CBF;
	Wed, 29 Oct 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Yw87f4G0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAA1345CDE
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742546; cv=none; b=MQIQ6wNwSmxmhP11omIoSBgwhaN1x6Q6WzwHE4JHzoKlqKJwfFLxeY1ohKTn6TwTLXzyujW0nYXSVqFaT7OSXzKbcXI21SSscXoII9/VJbyOe3rUA5yg3lzN055zaRayMLndAEGUpTlnvOxIDFSx9hd4vCRJ7YnxTxkgWgGyxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742546; c=relaxed/simple;
	bh=oaiGrX/ykXacoXQRvoz7NUmAFH9tG2T7WIpf9HIZMgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzO8zPGI8BSh5Zqs5BcOBDZAYnS+VBEUygVqWaWOq4YCNN6fBmp2p/5Lm6f/Pz2dPnJ2/M3U0Q1cqhku0v/XFBvYqp26mI1kMSnt6dupM1TGWkEKqHNCz1wSlDfIUV3z2Eu1jcmd6T0FHNFhUiqXlV8b9f4fkd/SVE0sJisYT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Yw87f4G0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59052926cf9so3316826e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761742542; x=1762347342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yNabgZGkHY+Qgm/MWzqFABw0v7t/r2KBAY0H1eEaJs=;
        b=Yw87f4G0Z27eqrwM5JXIVziLcECIZfoLLFzFGBoC9Qr3OGLvudXKDW4x1Jf/RbjE2W
         zUCGeuqgz/ACoBY4J1RxwIEvprs7IIyJXQoAMscWggtUDMhs9O4A7bMmqpSYAGaW9Q7V
         XqadTQ9ElNqzi+P27BbGHQnkhy8u+moJOzzmHqVYIy/h+4v1j8e0N8+WqX882vfwoz9G
         Rlfkm/RVK5RHqPHAX6HBDpi7Q65mctHA5N/Zv7L7bVeOYqzNxxwBs9/wQWnp/iwvzqYT
         m1LcguLENH5pjPIVLoAAbptdpr1/bylGB/6tzPul/UaoYgNeWszzk7Z+hEAds5pnoJ3Y
         SWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761742542; x=1762347342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yNabgZGkHY+Qgm/MWzqFABw0v7t/r2KBAY0H1eEaJs=;
        b=jE0Qb7YGmuonurnMbT0TrQydpriweobANftAqX4PtQ8JXOWoABxpnNjVIIYln4tqR2
         QdCWpwiBUpmR5KUfLLANmPk3uHSXBz5tbLf/r3qQyzHrqBsbuCCqB2M9PrRonLw+1XPh
         HIRP8suGKzLD4y4PyWpHDdpTwGgG2KJs2MZil5V+77F8OHUv1eS9PIOFzxF3S1E1/155
         /NddxCasPc9Tp0h2cEbj/kLl4TlQMgIC9yzXCkp+q7RHBfdDoSRiXrfG+bpSHIhYRMVH
         QnuZPcxfay3VvKUuzp8rX6oXecWoBPrYyx3S3WEq2PAT2IYdZ+Ujsgj7gi4vBNpDGE6T
         kpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQB0NkN3Mx3vBPqX0wEzOOVtc/VVtjPTTXQ2AJ3qjWgAG/JyPKyntar6oIrWX1OsLofKIDJtZrzptR@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXv4Rx1z5y/36ZQKc327018elLGpiRc/gawaJGT6W0e5B6RrN
	DkKFQiPP6e7fXupJkNcAVlTPlZGOow1AKL7CAIhKQ2B0Rqkl8rUgiIis1NU4sOqhK8yEkEp1KcP
	0Akk4Wd2JQ7XbVu2FBN5kMcegCWV5N+z5oP79yXIXjA==
X-Gm-Gg: ASbGncteiOK8XiTv0GADT9zAliKZBzD+5nKBtZyOXLnPl4ug5ONg4sDVvYAbNlMBTKv
	5KaZfs82/9uVyYS8eYUCn8IuW0bd65WDIlCAq2jEZ1Q6iOOllkDqn2Ah9ESoafP5Y2VLHfEJf/6
	pstdTEHfKO8Y8z0lGbaeY1zmrx0LZlrjevK5O7Pk4yLqRes/kDEHOsOj9QpTNQ0eaiuwlyGXals
	k9aEAfESvKPxNkFgD4O21cDaxVTWSXcQFnvG9GAcoV0kymqxyWvpzTMoUfyd7I00slBFciN1itO
	WFSokPOvoup9afAy
X-Google-Smtp-Source: AGHT+IHVSlcZcRFweD/CsA6OtT1TIVhjc5sVUzGgiku4ascUdv/UmnI9MvaJYPGFR/shw1/3ylKd2GmpjO/iAE476gk=
X-Received: by 2002:a05:6512:3f09:b0:55b:8273:5190 with SMTP id
 2adb3069b0e04-59412a3db0amr1107474e87.18.1761742542582; Wed, 29 Oct 2025
 05:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org> <06c7a64647ac78cfc5366a073ec12ccddda49572.camel@pengutronix.de>
In-Reply-To: <06c7a64647ac78cfc5366a073ec12ccddda49572.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:55:31 +0100
X-Gm-Features: AWmQ_bluIn90sOwg9DzJfIRKjPB4JCG8HCRF9jGS6ZP4TOd1qCJlUatPTeG_3uY
Message-ID: <CAMRc=McmA9M6gMzpJ1pgQG2+6gGQ5GgTV6mB_X95WxGCgv861w@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] software node: allow referencing firmware nodes
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:51=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> > @@ -535,7 +535,13 @@ software_node_get_reference_args(const struct fwno=
de_handle *fwnode,
> >       ref_array =3D prop->pointer;
> >       ref =3D &ref_array[index];
> >
> > -     refnode =3D software_node_fwnode(ref->node);
> > +     if (ref->swnode)
> > +             refnode =3D software_node_fwnode(ref->swnode);
>
> software_node_fwnode(ref->swnode) never returns NULL if given a non-
> NULL parameter.
>

That's not true, it *will* return NULL if the software node in
question has not yet been registered with the fwnode framework.

Bart

