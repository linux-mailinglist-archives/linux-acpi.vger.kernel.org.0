Return-Path: <linux-acpi+bounces-10199-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D238C9F8568
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 21:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ADF1896EC9
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74CF1C4A01;
	Thu, 19 Dec 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVqcUsyP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FA1BAED6;
	Thu, 19 Dec 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638491; cv=none; b=qF20LY8fM5r8y6azg0wNVA5kp/AwYthlplxU7S7TFd6r3rewAHNiEbmijDplStApTBo8nt2uFH+7ptcS5HNX5f59TTn8iV+3ZO/3nbhpUAvxz7fpMtaBIovusMUJy1U4AJwsSGAf5tStgs1q3prg5SBXO2e6WTzysTUPPryXtk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638491; c=relaxed/simple;
	bh=f2Hlnq9e1EB5di7doAZcDX5ZS33Kbs1dN/4tWjTAktI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAz//cZfb1GxP0qlnlWDHa9KaKXvX7CaGG5GEmU76Rjvam8fGSl8JUfqnYl5DaumSHEu+DB5O2YpPHafcZa5GolnUsVB2+bfm7gg2DredLx15wYyI2kV6fkH5RtBS6DWsf6Nvn1v5AhagkeBqZ7n6r1iBG5PP9Az8YufH8j/GbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVqcUsyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172E0C4CEDE;
	Thu, 19 Dec 2024 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734638491;
	bh=f2Hlnq9e1EB5di7doAZcDX5ZS33Kbs1dN/4tWjTAktI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LVqcUsyPVmTKKn98AMAqD/YviR0i8jwPFml94YkNyH/Y8iEpADCA+qOiJdHowYxur
	 GIOoHiD6JPMNqSLLYO8NUyMSl8izIOo5iFWqpIKKxsSG6cV/bCs+qwhNQozBKQbite
	 07VeaC/q7nFQtf0lSvxRnj/DhbrmXozc2bktZNZgH0l+LutGd0PXYb6j/g86LwEXcp
	 pKD8kx7J/BqBmAjN0hJsMWZ8w40W+/lytWUdCZpJsSQ5hMrwSpiYB/bk+E435oqEGX
	 mg4L9CXAsjupAWvmkhcbRO3cnSfKvnSALfqG3u+pUcVeMtaqVBxK1ypzoTnUlFVSLa
	 JQlo6s6qG0OqQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eba50d6da7so298309b6e.2;
        Thu, 19 Dec 2024 12:01:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbOMzFwkr9etNilcgIaoa8fLygviiS93tGGdZClGuN9EWgVs2g3qSaIf9jjxcZZKTXWRihByyHO6+UqTal@vger.kernel.org, AJvYcCVzdT0hGcd6aTT9EzUA1tKPX61nwJ+wRLY0ghcoZRKH9UUhrR0QIh34w5enWE9gheLGjYQa9vGSwAVoHBk=@vger.kernel.org, AJvYcCWFHtLL/0Oa/RtW2VZAWzlpPB4/mdfmUaRqWbs4JXYcpxKmoeObFrqqBNhMnZN6CjkzKDtrUB/Omew+@vger.kernel.org, AJvYcCWGZDttarA/G55jXwkm/7wpqcxhucKjEWcFqExXAsx+SD4snmTeNqL7DQbx2KyekLSDtUPEFMePyOJg@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrMPtkC9jH00MiP3A0EwxXQXu1bRxgsIey20BvvTRMdJME8XR
	Nm8GMzxDhID3HP4XBj22hCYcN7/Nde4Gk+dBajd9N0Scjp1TMtxEj5US27nrsLkz0ffQAiG4mVv
	wxtYqVzZGvckziP0ts2/dTI8X0qc=
X-Google-Smtp-Source: AGHT+IG+XCrWxF4+D1PsFPOvKXa6qscgdzNXDN+M+vXcJicaKSEjGqWJwu1mYEfkqI43fGH7eDXlon7lWUHfoVI8t1c=
X-Received: by 2002:a05:6871:6308:b0:29e:57ec:34c3 with SMTP id
 586e51a60fabf-2a7fb431b82mr118496fac.32.1734638490258; Thu, 19 Dec 2024
 12:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
In-Reply-To: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Dec 2024 21:01:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hE6-QDOE7PcCAfSU78mjmQqo2mjXf+nBeaZ8eD6rffzg@mail.gmail.com>
Message-ID: <CAJZ5v0hE6-QDOE7PcCAfSU78mjmQqo2mjXf+nBeaZ8eD6rffzg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:17=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.=
org> wrote:
>
> We want to be able to compile_test the ipu6 driver in situations with
> !ACPI.
>
> In order to do this we had to add some conditional #ifs, which lead to
> false positives on the static analysers.
>
> Let's implement some helpers when !ACPI in the acpi headers to make the
> code more easier to maintain.
>
> To: Rafael J. Wysocki <rafael@kernel.org>
> To: Len Brown <lenb@kernel.org>
> To: Robert Moore <robert.moore@intel.com>
> To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Cc: acpica-devel@lists.linux.dev
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Changes in v5:
> - Remove Fixes tag
> - redefine acpi_get_physical_device_location() to return bool
> - Link to v4: https://lore.kernel.org/r/20241211-fix-ipu-v4-0-4102e97aceb=
6@chromium.org
>
> Changes in v4 (Thanks Sakari & Mauro):
> - Squash the two ipu changes and merge everything via ACPI
> - Space after ;
> - move acpi_device_handle to avoid fwd declaration.
> - Link to v3: https://lore.kernel.org/r/20241210-fix-ipu-v3-0-00e409c84a6=
c@chromium.org
>
> Changes in v3:
> - Prefer static inlines to macros (Thanks Rafael).
> - Link to v2: https://lore.kernel.org/r/20241122-fix-ipu-v2-0-bba65856e9f=
f@chromium.org
>
> Changes in v2:
> - Add helpers in acpi to avoid conditional compilation
> - Link to v1: https://lore.kernel.org/r/20241122-fix-ipu-v1-1-246e254cb77=
c@chromium.org
>
> ---
> Ricardo Ribalda (7):
>       ACPI: bus: change the prototype for acpi_get_physical_device_locati=
on
>       ACPI: bus: implement for_each_acpi_dev_match when !ACPI
>       ACPI: bus: implement acpi_get_physical_device_location when !ACPI
>       ACPI: header: implement acpi_device_handle when !ACPI
>       ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
>       ACPI: bus: implement acpi_device_hid when !ACPI
>       media: ipu-bridge: Remove unneeded conditional compilations
>
>  drivers/acpi/mipi-disco-img.c        |  3 +--
>  drivers/acpi/scan.c                  |  4 +---
>  drivers/acpi/utils.c                 |  7 +++----
>  drivers/base/physical_location.c     |  4 +---
>  drivers/media/pci/intel/ipu-bridge.c | 29 ++++-------------------------
>  drivers/usb/core/usb-acpi.c          |  3 +--
>  include/acpi/acpi_bus.h              | 23 ++++++++++++++++++++---
>  include/linux/acpi.h                 |  5 +++++
>  8 files changed, 36 insertions(+), 42 deletions(-)
> ---

Series applied as 6.14 material, thanks!

