Return-Path: <linux-acpi+bounces-6382-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE49907C86
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 21:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58961C2594C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAC156C5B;
	Thu, 13 Jun 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjEhG/TX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024C14BF92;
	Thu, 13 Jun 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306528; cv=none; b=r6MMP0YqTSN1OKZHLkvWDiIV5PwXY3NmS5NK7xOLKK0ZWiKKJI5kXctyEJyg2Pq5y/eivAh4uEJ0+YRR3iZ1wRFlcyPJCFKsbJl+RoA8fH/uw+F1wM1uzuoyOFVacM/NhLPNbVn1pw47+qFELG30rN2Kl9c5+9XCqLPkXt6+x2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306528; c=relaxed/simple;
	bh=WunVx8UIln3kgFEhVvAZCi7y9BEcxfNzwmdzAtyElU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHWegixMp/7YJde5DRl+YdV//VGKcwyldUkYhdIps92d8pCvMamYRtoace4ASlJim6K3CTZt7HiZAATC+omdPCuWSwVBvIdLq7a4thL7YolVbFml4Lq6fcjUinB88ei5jZVtv1YMwmxQv8xHjj5Qp16ibFZcbDSjoMfiuF9bAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjEhG/TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8154EC3277B;
	Thu, 13 Jun 2024 19:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718306527;
	bh=WunVx8UIln3kgFEhVvAZCi7y9BEcxfNzwmdzAtyElU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sjEhG/TXAP4A+FBZU3s37UZhMEuj7iV8C08VDnIOvi/Z3OcPwrk3NMDdnuSqTLUvT
	 +INzqbYrIaiFBzz9W93oWV1EilejwOVfSj8y2ArVAGyF9yCBzXEdFSsz1GlXY6wvOC
	 ldb5ZE5CrtkVbCxl3jAwQbIYKY3D7dyXyDgEyU8lIjWR0Yh1g+xzL608F/7D55oqBh
	 1MAorj5n7Lf4N5L95fwB4Hf46g/lgj9fHR2Ci/ZPHlI4cdBQ65EA8XnVfAHesCsHNe
	 9fGLM5uxhn8LUs1F7RVeegENJgoonG0ox/E8T76PRCCPqLVqtLBCc+IsB0zbcv92zy
	 1DewC20rulbmA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5bafec9ad2eso70827eaf.0;
        Thu, 13 Jun 2024 12:22:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRIi5wJpsdQZJUhAKOiF0CHtut9vr8DbwVAiHVG8NuRutc+PittE0tFr0LrHf7mUbMYTDGwmM8GDN+fNQL7czu6x6s5CLS2VUIozazXZPYuRxuKXeRrQAirPlXGJ0LjkHNCOynXbpuww==
X-Gm-Message-State: AOJu0Yxlp/34RDTDyHX4Ahr1d3kGmVKCQpQvUbfpxwsCyQNFKx8Xp/f3
	w3d3OUx28MDNNIKf53cpO2SoqHGc1XmnERvYj3oJhS2X/0lePougWpLpmvN3VUxJa7h1fb7VlR1
	8hHv3besVOi9iCVM9YqRSh+Nqq5w=
X-Google-Smtp-Source: AGHT+IHjO4Zw6aLSf61D+OQbRz46vtDs69ireUI/2TTxEeJBQxANKpy6BcTwr8LZ2cNEP1FqGvAu/XydowFHn/NoBLQ=
X-Received: by 2002:a4a:b1c1:0:b0:5bb:815d:e2ab with SMTP id
 006d021491bc7-5bdadbff7demr610924eaf.1.1718306526766; Thu, 13 Jun 2024
 12:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606205712.3187675-1-andriy.shevchenko@linux.intel.com> <179d5111-5cc8-4a17-b735-84f02e0144f5@redhat.com>
In-Reply-To: <179d5111-5cc8-4a17-b735-84f02e0144f5@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 21:21:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hG3FB0YiXkyx8hRruB9JGk5vH92zNA43+yCmpKYj0=wg@mail.gmail.com>
Message-ID: <CAJZ5v0hG3FB0YiXkyx8hRruB9JGk5vH92zNA43+yCmpKYj0=wg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ACPI: PMIC: a small refactoring
To: Hans de Goede <hdegoede@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 11:05=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 6/6/24 10:54 PM, Andy Shevchenko wrote:
> > Use sizeof(), dev_err()/dev_warn(), and regmap bulk read
> > where it makes sense.
> >
> > In v4:
> > - dropped controversial changes (Hans)
>
> Thanks, the whole series looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> for the series.

All of the patches in the series applied as 6.11 material, thanks!

