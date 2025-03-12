Return-Path: <linux-acpi+bounces-12131-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7E8A5E46D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 20:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E873ACEE1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 19:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062171E5B66;
	Wed, 12 Mar 2025 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5SC42jS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2C1CF96;
	Wed, 12 Mar 2025 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807895; cv=none; b=mQ4EIj21VX7x9yOfk98BfYd9/a2t3rD02/gPb8R0dSZeE64dVRPvZFKsiWn+YMyq7RFW7gNhrfaSu1hRkRtFTDEIifesX740enaZQmdoWgNYTyCuKGodIrwjnsuvP7v6GJMKWR6+Mqf9OCEXq+BfWMrbZHHu6n7vfZJi6jBAGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807895; c=relaxed/simple;
	bh=CaW1UxJeoHSqP4IvGnDB6JVA17m5sPB3095Cb0mMJ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVvyf69FPaKeuGtiPiZQzVktk30gXZ6MMJ763KEET6nE5SX0onFp0YWGN1h09CfbnR8wVKXFCTuaZ/ghKIunExl/hhTvd0AfMTTfUhKKFGLSca4kehUA1XpDOAsn4UFqsjcYeS3PSFnUtmZMoxyrR3cDbMZ6vnzGITuZ5Gd3Xak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5SC42jS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48034C4CEEC;
	Wed, 12 Mar 2025 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741807894;
	bh=CaW1UxJeoHSqP4IvGnDB6JVA17m5sPB3095Cb0mMJ14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T5SC42jSwOSUQOOJtN733Gaad9jXxutkSjOf6jR4w20P0D0w5LVX7+8h5ZlaPOF3g
	 uAhdu4mtMOXb31o1nAVVVmhtPDjC6ZQNGn+VIwjASuJ5B/ri8ul+Q7cvuqoIRxrML6
	 ytOqmt00NUHEwubcFLHyidQ/2HjON/pIG/zz/0b+FmkE4VY9RAQXoboEg3eTzUdBUM
	 SAbH1LgNI0luEHfKC9hGSUDgxKrqGL0fSk007iCOSq8n292wEnlK/jZsJAgTjCB9Wa
	 BbrWGZPuU2mz+tRENNeDiGoUc0S2qebDyKLfVleRb3KmgeGzqlSJDdFyXuKh+/GB9E
	 V8XRDrosSDCOw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fcd61e9bcdso76738eaf.0;
        Wed, 12 Mar 2025 12:31:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1Wu/Mi1PdcI9cm0CIRTEsDQfjurkbI5DOng1oyRdKbRkPZJiSFUywm5K6Udt1Jz76bIixsRUJjJ5Jt3V1@vger.kernel.org, AJvYcCWd/VKOVspRWvkbOLCGCmOx42oo54wC3N8kjxYXqiMb852wkAl2d3tNQabWBMukauYpHjKmwF9wKaYaUGtW+KU=@vger.kernel.org, AJvYcCWlro4KU4bJH99Pk40YlaJvNz+wCaNYpaV8yDjL7w6yAnHOLo6fpbU79rjwu+Vun6cS11YGn6OU/fOx@vger.kernel.org
X-Gm-Message-State: AOJu0YyZx/vrVafQsQHPiMeUCWSYv727vsbct4zuoLAQRwWtcftKG4CT
	fc0sXNmT3CnKdzcBaUFcgaFujkS3gbXHcnsbN9eFuLqK47T8AuhGUhPG1qC6FmE2mX6V/BBChov
	QwMwO+qHVwDIb4obl3uTLUIWWcLg=
X-Google-Smtp-Source: AGHT+IF0pW0O/4HHSdM+DXVucPScSwmpd7T5iO006EAES0raj7w7pX7ZxaICM4YXWVZK3dXMFGCE8m1/YDhpPgHYbWo=
X-Received: by 2002:a05:6871:8a8:b0:2c2:50a5:1248 with SMTP id
 586e51a60fabf-2c2614d4a3cmr11732507fac.38.1741807893527; Wed, 12 Mar 2025
 12:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com> <20250312-ivo-intel_oc_wdt-v2-2-52d09738cd0b@siemens.com>
In-Reply-To: <20250312-ivo-intel_oc_wdt-v2-2-52d09738cd0b@siemens.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 20:31:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iBcxGcqp88kHN64WddvmC-y6F1XaFeSNHFYuQnayg7dQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr44D1Wr5VQ4K2HGOBGF9RVoswaW7uPrnG--zzPI5KGQJHviiTHGkiNH5U
Message-ID: <CAJZ5v0iBcxGcqp88kHN64WddvmC-y6F1XaFeSNHFYuQnayg7dQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP
 device list
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
	benedikt.niedermayr@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:46=E2=80=AFPM Diogo Ivo <diogo.ivo@siemens.com> w=
rote:
>
> With the kernel having an ACPI driver for these watchdog devices add
> their IDs to the known non-PNP device list. Note that this commit is
> not a complete list of all the possible watchdog IDs.
>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>  drivers/acpi/acpi_pnp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e=
32963a5b29d2587 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const =
struct acpi_device_id **matc
>   * device represented by it.
>   */
>  static const struct acpi_device_id acpi_nonpnp_device_ids[] =3D {
> +       {"INT3F0D"},
>         {"INTC1080"},
>         {"INTC1081"},
> +       {"INTC1099"},
>         {""},
>  };
>
>
> --

Is there a particular reason for this patch?

