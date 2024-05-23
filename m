Return-Path: <linux-acpi+bounces-5955-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906168CD049
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03151C22290
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECCC1411C2;
	Thu, 23 May 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMNTzVWf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5A140391;
	Thu, 23 May 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459839; cv=none; b=eJgZiUkZGdGdsR0VDQgGW2b44g8YW6QhN3ptnGbkaV3JsEc0NIOVIs8oK5OcA2sWk3k/xNF1chF+cZjyDt+IS8bRi+vvHZYXwpPPB3Ihk6lMbxOgaoraSVc63gEojyZQ1J/7it8Hbc/UzIqyqFtTj0m4gIPQEZDUtTLLm7Jpo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459839; c=relaxed/simple;
	bh=YcgIXnUjA3A+yAuyQ7lW1dHLA/JXl+adaMB6ljYV6YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mathzqrsxRnKEge3/CfCEhyglq5rUViP/Nc8OrizvLii7TZ53QjpLO6Us7qMEJIzPUx2dEe9CVV5f3OPI347XzauFDcsha/ZB5+mkWbIRmbfvJtHpne6OxY/5YRVnAHOs4q6OabKwHEPdbnJ2/qCN8d+3fK2hS373m3cO5xLpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMNTzVWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AED6C4AF0B;
	Thu, 23 May 2024 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716459839;
	bh=YcgIXnUjA3A+yAuyQ7lW1dHLA/JXl+adaMB6ljYV6YQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lMNTzVWfQKBowUNH7mlcQHwNvD3TG3rCRKr8XUJpPwX+niLCfJg6dPM6dkHVblvNs
	 JxWEbbVHuHr6hdzh9zMh6eG8CCcH+ZhP0ru4vQHMc3oN+Gy2kPZaC6KcAcMRMAtHDy
	 Agh2ozRjiKK7vem1dqBGXCJWJqL5znZdcKPi2BUEde9RjqgU8Sc1d6TCyvh6kEfRov
	 REauqcb1Ug2+HWF7ulCKXJMIo41k7dO64SV0xqc+VkQYIN/TMJwrL/rIUfD4kBF+KI
	 GJZmyaJZw4gwTjfVh0auMNyqNg6GMtiIqbEM9rSVqTrEDe00CejirHK7NvVS9eUq8s
	 vkHQEj/FzzDrg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b27cc76e9aso398370eaf.2;
        Thu, 23 May 2024 03:23:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW75g23Dix1V6tJ5lCuzovbmj6hj2mYJ15Ua/R7L1iF369DFgJhNrl001EoEWTl5fsSFddTXIb4p6nrY2zXODSkggdwYVSCStrhByQrPxb0r+eR3BzgH5zKo1qdpyJK2cLrZM4dKTHa1HLyvp3+sQvnO1rkBVizmmwK4GRQ8DYYhx5b4GkERgYyr3po6DFc5DCWuJeIPYvNnD1fKmFhiTIsOGxYvA4/3zw9Bg==
X-Gm-Message-State: AOJu0Yy+WdKhZoBqEuX0X8pVQ9/NHvUGnvZJ6TkCqX64NIWbRvazRxEi
	uw4Ki26s/Glsh06H0lNR+gqCVwo+liAv8zWlYDj1ZF/7WK4tl8AIOX6YYsQGRBEB1qo2uvI3BSh
	XqAm4p28ddPhH/sgesLbcKmQ5I0I=
X-Google-Smtp-Source: AGHT+IGG+qfSUk1ztfEIIHV9KTP6u2pnoBFCuOj3pNpozeuvpBsumicmoBJBQMLLvEz+J+tOY+YDRkBUfpPPHSSIc9U=
X-Received: by 2002:a05:6820:2585:b0:5b2:7d9f:e708 with SMTP id
 006d021491bc7-5b6a2df34f2mr5280979eaf.1.1716459838366; Thu, 23 May 2024
 03:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510201242.3886-1-W_Armin@gmx.de> <9d3f6b81-c53f-4ccf-9cb7-d997ba8957c7@gmx.de>
In-Reply-To: <9d3f6b81-c53f-4ccf-9cb7-d997ba8957c7@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 May 2024 12:23:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0juG+uJoE=TytF5fffWCVc8JEYi3e7E_jM+zzQVKphsdA@mail.gmail.com>
Message-ID: <CAJZ5v0juG+uJoE=TytF5fffWCVc8JEYi3e7E_jM+zzQVKphsdA@mail.gmail.com>
Subject: Re: [PATCH v8] ACPI: fan: Add hwmon support
To: Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	jdelvare@suse.com, andy.shevchenko@gmail.com, linux@roeck-us.net, 
	linux@weissschuh.net, ilpo.jarvinen@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:03=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 10.05.24 um 22:12 schrieb Armin Wolf:
>
> > Currently, the driver does only support a custom sysfs
> > interface to allow userspace to read the fan speed.
> > Add support for the standard hwmon interface so users
> > can read the fan speed with standard tools like "sensors".
> >
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>
> Hi,
>
> what is the current status of this?

6.11 candidate, but not applied yet.

