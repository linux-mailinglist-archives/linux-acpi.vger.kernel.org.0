Return-Path: <linux-acpi+bounces-7939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693979630B2
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 21:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE6BB20D9E
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 19:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636441AB523;
	Wed, 28 Aug 2024 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq58Vbp9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D11AAE19;
	Wed, 28 Aug 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872030; cv=none; b=oreCLpnadGpxzW9OHHd6IisaaxX06Q1pBvaH+WNBspmBsk71PsLv62vXOT1qmLt9jOib/dchXrgOo9jSL+eTJa6vfwxW3YkXDvf9NhwTTvfjJD1KNCHVDAPFV32hBv8i+C8kCPdOuEoJG7vAwYbQefdGba7veTdgpg3zHCluN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872030; c=relaxed/simple;
	bh=HjKq3StBX94hw4M7AOGIX3XHXN2gq4bMwsiXnPva3LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NL6BCSUtpK24yizO3pfpPWoUt1tvVzzvXNSMucMw73IA+bDjBG7aeVKgtFEoIl/AufDYWEOPOiPLrOPnx0IKgu9J/MyYlGgCCbPukEK5qAss82ZZBsV3rzAqw2WtgyPRzMP/qrqFn0Px7bxsnT6zmeNyYErAGmxFtzV/lKOn+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq58Vbp9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so895472866b.1;
        Wed, 28 Aug 2024 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724872027; x=1725476827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjKq3StBX94hw4M7AOGIX3XHXN2gq4bMwsiXnPva3LY=;
        b=Cq58Vbp9cfo4Fd5Ep0X39hCPpdQxCYVY/8vqF9sHzzNGRi2OnIDcYPdE+Jlzt3/OOz
         URmlwtEOu32Cw0tPgAkaC4N/kMKjpCGykZdZJAz41zfxpid3XKkxd8Haadn0pyCxG4Ig
         D227chqUj6x+ZJ3QLZv6B6AVK+zLpTeDZWG+lOxdflw9f2u5sb05vXt5thHJYP5L/tjU
         31FoC4WqRy38yO9Eff2Y7pry3uc8046Xvn7t/ewITaQZ2ptaoiS0GA3+ddKmyFRhZ/79
         xOgZqQ7SzqgJowgv22/KCaWX2+2Zm8a5xqYmAsS2U28xgR8i/SZdRC7Tc4lKCJkWrJBm
         8Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724872027; x=1725476827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjKq3StBX94hw4M7AOGIX3XHXN2gq4bMwsiXnPva3LY=;
        b=Nk13wU+atQkEALDtxdHiBoiqH20xq0qgzbs5UXiMzLtgXD7Sy++8DjnGtfLtWsyo9f
         Zh+joY6tjzafvbGKGqGoCm7NrKfULk3LCL58yfZnOMD6jZU3Qg/tQcoAMS4NA9B6g8ta
         IfDwNyXVaGjnzKZYqMx2E0QaKN7BfEz51cBmEDnxhn0lnaA5k9qmSkvVoZVKN7E0yrSp
         q/nApQHAcQy7Hu2J53dfWafbnqFDgOgV0TC/fg6/oG6aR2iW0VxRwGwO/FaUUbSOk65K
         v7+TNdW016s19JLd2QEzveCelsxCRq7DQl9eqSVTmzkGDTvKYiWOaJlASPNaCtA8xg2e
         2CJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVDLBAyZk160oNi1Q9eshkSh+MlXTZYyJc/MTeAMsPc/jwWp4nNmnRtgYcjCPJbM54vVnJu2yk26Z2@vger.kernel.org, AJvYcCUnyGXP1rmXN5/3d+GbcWDc8/Nd3bfJNpAl3aHJgsWVmGKmrMYEulxounwCOacBjKmbj/JEC5pziCCLgVa6vS/GUjUhYQ==@vger.kernel.org, AJvYcCVtckanUpogLDAxlFSue/yZiCBBKrO/l91cfknfZSX6RKJSndE34h5IVv2c+/5XU3Y7Ybr3ElztFJRgWsr+@vger.kernel.org, AJvYcCW0WOYOPX0DjJT2/YEbd9ssxhYdwkhNLWCh1k1drZl/ULxVn2yY8XUNGjrJu8NVAihNuWcVhLWTV8nerQ==@vger.kernel.org, AJvYcCWXkTBQT1S99/1pxYy3Ut41g7wb8FlcIO+qA0374kgNVcjIQ4J9thxmXgWTDu3hM0sVkYTWAv67FX+gbvBG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ICaZ6WbfIxK+L/6DQDGaKqBiV5GTMYzxaJvGkwS4bOX6P7hG
	omAgBWI5X45MvMzxpZFhkCj3lzTORnlYkUHivsbyvvTu7mhx1XsmxHcntRc/7McvNE2MuLLlpzA
	6lg6IbYYggNWsXY4q9ZA0IhkifovfIDr3
X-Google-Smtp-Source: AGHT+IGYzYJZG7E9ETnEzC8H10RpiiV3h5C0x38Xf6GmVcfkNytGNvXBHM+pdaWW6SlDFggj27f/kKMygSvqctEhX88=
X-Received: by 2002:a17:907:980c:b0:a86:7adb:b327 with SMTP id
 a640c23a62f3a-a897f8d5200mr29640866b.40.1724872026595; Wed, 28 Aug 2024
 12:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <20240814-topic-sam-v3-3-a84588aad233@quicinc.com> <ZszrjQChQ2aS5YjV@surfacebook.localdomain>
 <d08d41ad-edcb-48ad-a848-53edc45ab8eb@gmail.com> <CAHp75VcbjR8HQqPASLFEGiyYLfTFQDa6Ri+jFy+7Q1xz7gY39Q@mail.gmail.com>
 <53a56539-1d95-42ac-ad07-1b689702b2ed@gmail.com>
In-Reply-To: <53a56539-1d95-42ac-ad07-1b689702b2ed@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Aug 2024 22:06:29 +0300
Message-ID: <CAHp75VdsksKPrj-CwmR4QLBrm_FfaG4aZys-_jnee_L=3ZnRPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/surface: Add OF support
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <quic_kdybcio@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 8:40=E2=80=AFPM Maximilian Luz <luzmaximilian@gmail=
.com> wrote:
> On 8/28/24 6:56 PM, Andy Shevchenko wrote:
> > On Wed, Aug 28, 2024 at 12:10=E2=80=AFPM Maximilian Luz <luzmaximilian@=
gmail.com> wrote:

...

> > Yes, and software nodes for DT are quite strange things! Why can't you
> > simply fix the DT to begin with?
>
> For the ARM/DT variants we could do that. But we still have to deal with
> the x86/ACPI ones here.

So, then fix it there! Currently it's an abuse of software nodes
inside the Linux kernel.

> So for me it makes more sense to have it unified
> and just deal with everything in this module.

I understand the desire, but DT is DT and ACPI is ACPI, they are
different despite having some common APIs in the Linux kernel.
Moreover, DT has a validation tools and everything, making that being
a software nodes has at least these disadvantages:
- no official schema that must be supported and users are known of
- no validation done
- bloating of the Linux kernel binary and hence memory footprint

> Also, if we consider that at some point we might get ACPI PEP support (I
> know, far fetched right now): With that, ACPI on ARM might be feasible
> and then we'd have to manage the same thing in two places...

This (PEP) is something I have no knowledge about. But I think it's
still orthogonal to the software nodes usage.

> And lastly, the EC subdevices are quite contained and I don't see them
> interacting with any other components in the DT, so it's more of a
> stylistic choice where to put them.

They are still part of hardware and DT describes hardware.

--=20
With Best Regards,
Andy Shevchenko

