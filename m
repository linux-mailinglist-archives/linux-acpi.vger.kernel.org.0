Return-Path: <linux-acpi+bounces-5728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7AF8C25C6
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 15:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92510B22801
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A32812C48B;
	Fri, 10 May 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOBpZjwW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777712C461;
	Fri, 10 May 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347873; cv=none; b=Vqv9V5XXqCkyME12niwDGNxgL5ckXmheTOpoarbIgDRq0XKHnTMlVwpR0e04oqIFb43i/fRXoccpVWYQ2DC9O2On/lrLuXZ/taL/QJ9dQFilMmwM9jiKyhdJhuUCPKz24GxS9iosoNdrJlCoevK3o+6oMUGe/BEe8gRxsbDEHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347873; c=relaxed/simple;
	bh=PgyBavn/j3mxAvoBKUfmPryJchWsxnf16J829mjjMvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaAmSgDcPiSyjNw4Vu95ylHKdXNSYCJcCZGgpIgcEWXfopCraiTi5jeRp+xgSAKgZsXmvSJLQmehRljcv/oVuNiB8C+uJKhMwG4PVaEYVVIc55fhbqQJk1SIfPwQ0vCOx40xM/jtGFoZEg3UR4P1igheLkIr59LduqaBZB41O6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOBpZjwW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a352bbd9so347942366b.1;
        Fri, 10 May 2024 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715347871; x=1715952671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgyBavn/j3mxAvoBKUfmPryJchWsxnf16J829mjjMvk=;
        b=kOBpZjwWXo0MWgFgxuyCWw6rTK4p2DIx2SHn/EosxP4vAZ5ZhnlUAcTtEVl/ypVGSd
         4J4YPRMCzVxaJ+ZdEl1j0bDFur3KGE4wL1Qp7xrq1uI/rgUvlsp6qP/s9qzkNFHbmQjo
         BHi620w0ppzOXTFVKYNYRPLxlE2efd8shEScX91bsnOPejOdvSWgH4RzsgQol+zJ/7c6
         S6zO2m4tgbtTJ0SBrSqYjwk7PtCRCvhbZsA+bRr3wrH9EVF5H6FTTvfY+d6khIyS+klM
         E/AbfzWET4KvHYZunT1PDj85dxCz/Gxw7WOLEHq26YUCeJqZOHNNbq/7jaYLIVgEbCaQ
         E1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715347871; x=1715952671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgyBavn/j3mxAvoBKUfmPryJchWsxnf16J829mjjMvk=;
        b=GB4j0DpWHBuObBQDSVmtX145kJaic1fEZHmSpF/TiJAcEoR8iuXfFwZSSBrpC1J+fu
         xJ7huTz/yS1u7QhUrYgB1zufsby5LiB+JBaziRpbQU/Q+2zLBGyotJ+x1kUpPg0GPe8F
         VMTqXmkCtJbTjGbwDYDRSUB2DlJUmDnOAkpvIOkfertbGnMXDp01X6EgOXLPOoBf9WeC
         mIK5HsECsoGFcOlxOj0k9Xg1eFrt3fm6onVRsoq4g3Qd5IyGCuHSfO0oABYAxFrQu7bd
         U72paQKMBKGI3DR73oH6rrxcN5Un949WP9UMM99+9zzBJv8+6V1QOytkP4eNxU+5qB+G
         PFcA==
X-Forwarded-Encrypted: i=1; AJvYcCUOnnnyAp7jnzx7f4o8Tf7RtaGD9EdgHyjf/EQkzFTqas8Hjy1wagW+6LQ5nPyV2TiBx4fWdAgIX63oIfX1ZJqd0Z/vWekKc9erfuYlnvhqMlovs96HxlioEtktdhCGt9o/zSADjSyi0xa1/ZUwQWspLyHcp8+KaSiaZjkcunBfu1CAEJ57J0jHA0OYqZh3A4AYt+H0C5SCcJq5Wf9OQXamsjAoIjQ9vLxb4A==
X-Gm-Message-State: AOJu0YzfMlUmwZnqJAA5QwengVv2ecjp1iYdKwbW3m1qGtjsQ5OtJWPF
	ls7A6wsg/wv+ojLnA2P6LpR+hFitzcKv1RS9LuQEGiJ/ePsvqnCMx0HKOKct/BX6hZvPJsWo2cM
	+7KTlpXfbYPR1C7MFmjBFldJmROE=
X-Google-Smtp-Source: AGHT+IEEbIILPLMb9PE9NImGn83g3es9clSLPHPLOeo7rUd5AEgEyvnIKS76k3EUVXg1vR3NxbtWpoJELhzo1ohtfhg=
X-Received: by 2002:a17:906:548:b0:a59:a01e:825f with SMTP id
 a640c23a62f3a-a5a2d292a95mr208409266b.29.1715347870312; Fri, 10 May 2024
 06:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509221947.3118-1-W_Armin@gmx.de>
In-Reply-To: <20240509221947.3118-1-W_Armin@gmx.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 May 2024 16:30:33 +0300
Message-ID: <CAHp75Vd9JZxuDGYm2drSYun+h2CAU+Lb4BEFq3LnQYBKpOfyMA@mail.gmail.com>
Subject: Re: [PATCH v7] ACPI: fan: Add hwmon support
To: Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	jdelvare@suse.com, linux@roeck-us.net, linux@weissschuh.net, 
	ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:19=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Currently, the driver does only support a custom sysfs
> interface to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".

> Tested with a custom ACPI SSDT.

This most likely fits the comment/changelog area and not the commit
message. Also would be good to put there the link to this custom SSDT
(like one of zillion of pastebin sites, or GitHub, or ...).

I was under the impression that Guenter gave a tag, which is missing,
but no, he just said it's okay to go. Guenter, maybe a formal
Acked-by?

Some cosmetic related remarks below.

...

> +/*
> + * Hwmon interface for the ACPI Fan driver.

I would use hwmon (as it is an abbreviation based compound word which
we know in small letters).

> + *
> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + */

...

> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/limits.h>

+ types.h

> +#include <linux/units.h>

...

The rest LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

