Return-Path: <linux-acpi+bounces-6525-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB990F478
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 18:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5319D282D11
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A681315530B;
	Wed, 19 Jun 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARNAc89C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B839137747;
	Wed, 19 Jun 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815916; cv=none; b=A+1ky9l+c3hCkgdybeblzc2mHy8zBshvRwoDTA5GXawPnOJXEFIn34tvaoMZ1ZXjfO0enu1z12JUp34+Xd/Ul7L49ptGkQR/DJqM7xDUU8AgUzYqylLa2lbhgfGp61OI2gTJnzogUsxIB6UihwMb6xYpDDWjuqTAndaTblWhMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815916; c=relaxed/simple;
	bh=0hRC+aN168lB3O16MluqJfrv70JlOC7ygRKhFsS5AgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nwvu9RUyohJmVEj0ZmDNemzzBujtsvQiWrt2a8aqOUduLPzhFVLVrzszXPZHOsoFsWdCLPUhzwU+x+0aRGz9S8s5/e39ptp9AYTyHPnA+I93wewYQJRgROoXf+RMUsEcYRV27E1KjFYbepGy/JX22bNqqo4Abss3fLdt06/2xBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARNAc89C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBF1C4AF08;
	Wed, 19 Jun 2024 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815916;
	bh=0hRC+aN168lB3O16MluqJfrv70JlOC7ygRKhFsS5AgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ARNAc89CXPlB3MiBDhH/qvcAA/KnhJBcWhrR9yUk+G8UqmqsWjkrXYwt4VAhFZy18
	 GqpopHoDZWNsGxycoyjlyv4cf+hl6D8aesss4NYCk9vdCBKUiK70ZvxRZ3+MzWGmjO
	 dqnzW+hi1fCPlRX3tNbEFxTIkm81UtQXVwU8gv+0+2VkCFfMx7/mz89CXcuWOhQXTb
	 qr9bPDjLAwvWwSnL6pfLdpZbSAY2RAuxoQWL+FMiH58e6w9q9lNqXAy0vPArAVe6QZ
	 fmKcoZlrK4Dl2/u29CUyb9e++HVw+/VxfATVifsNMr1EdMfdbRYEiWB35F22M1R+If
	 5wSusthsHs1sA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5bad7941dcfso385728eaf.3;
        Wed, 19 Jun 2024 09:51:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1jvpxkfo2wlhfYLQXukgk3S1USXlp7/Vqn5Kj8b76A1pH9GhAy/MljTal4Aj3/H0j5Z7lp7fOfsvpe/DxWVqDeBXxW5rAjVyn55nwtlJs4qp3jCxfm5ZwfM6OK7nHOmaDzE3bdZsMSQ==
X-Gm-Message-State: AOJu0YyAUCrzQxADSarFaPYBLkAhFVYhdh76YwyDb5ZRdcB3l7xixUAr
	+EUcHdNhloo0Px2uBhGaHkjdihcMwZOE88vB0GjsvsM2KfJE7FMfF/Uz2nvN3+B3YvoMeZMaHc5
	nwj2QVZIEQ3lAqR8FgMuJmugQ61s=
X-Google-Smtp-Source: AGHT+IELAl0orCbC2ZXB70g47mhyMh7Tjxaf1M9kGgYI8cJQCU5MQkdNn4J1p6XqgxgT0so4eVDtWs64y+7XBQywlRM=
X-Received: by 2002:a05:6820:162c:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5c1ad88a98fmr4155264eaf.0.1718815915363; Wed, 19 Jun 2024
 09:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
In-Reply-To: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Jun 2024 18:51:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iDiCiPqq-7Y0KmFmgtrC6-wg+JJ3EcNy5gd=vF1sveiA@mail.gmail.com>
Message-ID: <CAJZ5v0iDiCiPqq-7Y0KmFmgtrC6-wg+JJ3EcNy5gd=vF1sveiA@mail.gmail.com>
Subject: Re: [PATCH 0/5] ACPI: sysfs: manage sysfs attributes through device core
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:15=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
>
> Simplify the lifecycle of the sysfs attributes by letting the device
> core manage them.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Thomas Wei=C3=9Fschuh (5):
>       ACPI: sysfs: convert utf-16 from _STR to utf-8 only once
>       ACPI: sysfs: use device lifecycle for _STR result
>       ACPI: sysfs: manage attributes as attribute_group
>       ACPI: sysfs: manage sysfs attributes through device core
>       ACPI: sysfs: remove return value of acpi_device_setup_files()
>
>  drivers/acpi/device_sysfs.c | 229 +++++++++++++++++++++-----------------=
------
>  drivers/acpi/internal.h     |   3 +-
>  drivers/acpi/scan.c         |   6 +-
>  include/acpi/acpi_bus.h     |   2 +-
>  4 files changed, 114 insertions(+), 126 deletions(-)
> ---

Whole series applied as 6.11 material, thanks!

