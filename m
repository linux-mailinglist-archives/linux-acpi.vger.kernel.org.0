Return-Path: <linux-acpi+bounces-12942-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E87A842D5
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 14:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BA11B81669
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 12:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43769283C9F;
	Thu, 10 Apr 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5QRr4G2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ECB2836A2;
	Thu, 10 Apr 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287500; cv=none; b=k8FFn1RJtXnDgvSeOaIk6gNyNG9f6IeHU0C5tRgo56o82VZGBRh/RBLRV1OLF+0rtSrD4OLB9gr4g2crFh49KXkUQEu2PynkNcK8qzuv/RmCD25V50YeysZ6wQZIgfy9TZBetOC3v7iMQavDHiAFT/C4CV2JXBEapVf9DvIf4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287500; c=relaxed/simple;
	bh=4BVqr/XqDb+5NSo2+kH+wLgC8NV6iDfBNUktuDeuLM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3ZcookXffmxUbh9iB9MvpZvcjJV/6lB3mAyV0lKwmda260dhG9sz2r7j8ysYggPGPFitkZuQKX8px8AJlNroPUu6n/EysDyXpHs4UoGLzkOE8y/O13J2DFQqKF2O4Vb3eThpq8vUgRXIQO/JgDZ7sjLwgE4Wv5IPBbH16c/ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5QRr4G2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882F7C4CEDD;
	Thu, 10 Apr 2025 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744287499;
	bh=4BVqr/XqDb+5NSo2+kH+wLgC8NV6iDfBNUktuDeuLM0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j5QRr4G2ubW5NqayzbNJX+yW7XLsESRkHL7uXk5gbOX/JevG4n0SfQhCMGgNtSJ5k
	 E4C21h3/a89V77XUsARO8V71AbSX1cI2+nYSLLJH9g9DIyVhgUpscmnDU/XZADY6tr
	 U0kbdz6GUWc22HjBaIeGq+UvlPhBq6cDKXtndq19/m1A78NrdjQYGv1cHCcPigIyLl
	 3uj7Mv6OvV9Vegy98LpCaZTK72YlXShRQLJDm8t9HntQu3YNzkXcIwy5b6n1ZL2cGB
	 LV9LpOT9untQLNvsDd9WhSJp2c1yLfUKox97TstaMRdoTbwAmfpfYDWiaOAJIjZObU
	 bA+XfSDUd+Z6Q==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2d0a742df27so567006fac.1;
        Thu, 10 Apr 2025 05:18:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHt3IQ8JD5JbgRya9ucq+KPkI4IMejrFk9xaO/jC2JzIfdUfw6FSDHBaZvlOh4ep8gxdynJ/10Sig6@vger.kernel.org, AJvYcCVOS60nOjrSUoh34bcu0xzZ49dwmBa4mdVf339PI72ctOwbT3KzKUG2KVNV11Eim/Bh+5W0BOpKQ18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCiOkZGq0SCdYx8Ty05ZPm4fcWWYqsQnVNgZoBclnhUvVRAjk6
	z05vu9pUUwZwZ0/++bc3whokIvZGwy+cXGdXFwecNmqBL0gkARIwg6ipCVN6al+vnU7XTRiaqoZ
	fg2vH6QGYp9NxrQrGPDQvPosfZtA=
X-Google-Smtp-Source: AGHT+IE6fIsIEe6iWpAOXTcBIN3kqZDFmJ7NTX3K8WTxkXdzD0ealEYHCmAWMTdQ5dL+KS3cl2QAYT1grmTIe97QB6I=
X-Received: by 2002:a05:6871:788a:b0:2c2:1c01:c111 with SMTP id
 586e51a60fabf-2d0b395d0f1mr1280480fac.2.1744287498871; Thu, 10 Apr 2025
 05:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202504101132.pgiDBR2Q-lkp@intel.com> <d7d99d34ea030d96256531cf09d21d5c6ec16433.camel@intel.com>
In-Reply-To: <d7d99d34ea030d96256531cf09d21d5c6ec16433.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 14:18:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j66twBjA0fV+NBrQvG0ciLDhcggA72OedJwkSCtjho8w@mail.gmail.com>
X-Gm-Features: ATxdqUEbSdG9J9QT0i58HoFYL_4SZJPzRda9B8OYaRJYC79AbA7FRCLfSzVj2do
Message-ID: <CAJZ5v0j66twBjA0fV+NBrQvG0ciLDhcggA72OedJwkSCtjho8w@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 44/56] drivers/acpi/processor_idle.c:464:22:
 warning: unused variable 'i'
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: lkp <lkp@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"devel@acpica.org" <devel@acpica.org>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 9:56=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Thu, 2025-04-10 at 11:51 +0800, kernel test robot wrote:
> > Hi Zhang,
> >
> > FYI, the error/warning was bisected to this commit, please ignore it if
> > it's irrelevant.
>
> yes, this is a valid report.
>
> Rafael,
> Do I need to send an updated patch or you will handle this directly?

I've fixed it up locally, thanks!

