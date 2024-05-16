Return-Path: <linux-acpi+bounces-5853-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6748C7066
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 04:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678EF283EA6
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 02:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2815A4;
	Thu, 16 May 2024 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E3ylK4wl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAADAD35
	for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715827486; cv=none; b=EWwyM39tbTrOE5KbDCznvLhSDAkn2Y+t2oW6ORz/TvahZogTATRQF30Xjo+kZsb5RG7YWrX4F6Aal5FbMX+KN6ZacyyaB6M/FEVfCxWJQEmDc9DN5Ag1BHdt8lL5RY20Qy0OszkB7yVZhiaAVi0Fjz7jf47n1Maenl8k5cPWh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715827486; c=relaxed/simple;
	bh=kGxOV3wnS+g16tgOJzMj1a3n3g/6Jdh9v3a/SW6PknE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxURrzKWtDJ9rFf6/5h3dfGIkYUyIeS5HcC0E1SaUCTafg9KlPyO326C5JzTXieaEw3ZfaBBqInCLABdPO1sWDmwQyeNvjnbGZ1g2WqxaJRZIZYaVZmfP/BphouK6izM4iwscqrom0Mjzrl6i7vuPv9Zq5QYdUgyw+dvDwqJdoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E3ylK4wl; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b27c5603ddso3639277eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 May 2024 19:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715827483; x=1716432283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGxOV3wnS+g16tgOJzMj1a3n3g/6Jdh9v3a/SW6PknE=;
        b=E3ylK4wlMkAJDRK7xCoI1Av6x/shba8g7TrWaNGkNKy6wThCQstM4FMvIa71aheVnI
         yFULiv2hJ9xJun6Laj9Xa5kKNAt7+k3OJDnR3Xk9UL4i4Bd+iMcdQ/1JrqAAjqtvYyJt
         bWyogpCt8J3IO2nVOeN4dUSUMSdsnE8JEnjS+s9Nru7Ilxqk6Ry3878N9TodUevRlUjl
         OvGC0eHCWaIJu5RmA8waJsCir7dBUVZ5eQOXlI1DCGduQ/nWTLRe8wB0wnsXMj4OHeA5
         kGfLQ9abG/ncy6+dINvJjJNEez2Yh6BW2pgKyApyY9AAwQsXGTWnv/QN7v7QYAuqHmCV
         hhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715827483; x=1716432283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGxOV3wnS+g16tgOJzMj1a3n3g/6Jdh9v3a/SW6PknE=;
        b=rN9pqX4C+Ha4z63lOquKC1XLiWH7ce47VmzO6k/0mP5wWva2DQeng5y5B3mEUr2XhY
         GyUt9LMMUekarjwj+r9vEmry9VAUnb34dLOxyp3BZru4JN+dsY8ZOQSDbdDjhc3WZ4qI
         KgEUQB8Q67fJDkk5xppbW39f7Y9KjcGmwo/CT780Cpg3Zd7pSnYIesOku2EvQ1E3r82C
         lUXD6i8dFt0CjwV0oddCMUUxOIlR6YIMAoWGTDSRtGLLtTGSJZ9ZG3RP5MINlHXZhnhu
         9FgeCMXytZMjqx3vRK9qaFZuJsx3ybOVGdI1pDLooAeXN0st/Bh57bPWZpawy9Tb00qs
         qOBg==
X-Forwarded-Encrypted: i=1; AJvYcCV0XPZzXtzi/IapklQl+NoPP19ssS4q9hArNHGFpQQImqPrPQrVIofxRLjZ8B0DfucV5lZekLsfQVrS1S5VzpiGNHltXI0dn1kZ+w==
X-Gm-Message-State: AOJu0Yzb78dAd5fXiAe4Vbuq+au+L9OG+2x6JNVKRivcWJMb9wtEsha0
	Tj7SRce16RaD563lVVzByAuNQsAtY8XpGH36AAx2c90b8Ga2Ef2dm02WiKcLlHSLJoNBvzImqyv
	FGN+csQzRNK6cAjqrU1zKr4lT7omP4zRzHnGHxw==
X-Google-Smtp-Source: AGHT+IE+AorXjKiDhK6gFlMN5F8GI0I/gxP966lZSFfLKOiXPDnBZKxKMe4kgkVyKv3bdhlJJbDGdmSOXBhj6AdnN88=
X-Received: by 2002:a05:6871:1ce:b0:233:60e7:52bf with SMTP id
 586e51a60fabf-24172fca296mr22838572fac.50.1715827483168; Wed, 15 May 2024
 19:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509073300.4968-1-cuiyunhui@bytedance.com>
 <20240509073300.4968-2-cuiyunhui@bytedance.com> <ZjzrXnOc5AAost4O@bogus> <CAEEQ3wkHc-EaRPKLivZoxO6jKXv9bigbYhacWouL7+KbgbwWpQ@mail.gmail.com>
In-Reply-To: <CAEEQ3wkHc-EaRPKLivZoxO6jKXv9bigbYhacWouL7+KbgbwWpQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 16 May 2024 10:44:31 +0800
Message-ID: <CAEEQ3wkpKHryCcNXpDXCi5tsfz2ryc9y_7JbvREg3D2MMic2ng@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, 
	sunilvl@ventanamicro.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	jhugo@codeaurora.org, jeremy.linton@arm.com, john.garry@huawei.com, 
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, tiantao6@huawei.com, 
	Conor Dooley <conor.dooley@microchip.com>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Gentle ping ...

On Fri, May 10, 2024 at 5:09=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Palmer,
>
> There are already related Reviewed-by, Gentle ping...
>
> On Thu, May 9, 2024 at 11:27=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.co=
m> wrote:
> >
> > On Thu, May 09, 2024 at 03:32:59PM +0800, Yunhui Cui wrote:
> > > Before cacheinfo can be built correctly, we need to initialize level
> > > and type. Since RISC-V currently does not have a register group that
> > > describes cache-related attributes like ARM64, we cannot obtain them
> > > directly, so now we obtain cache leaves from the ACPI PPTT table
> > > (acpi_get_cache_info()) and set the cache type through split_levels.
> > >
> > > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > I am not sure why you have not added my reviewed-by as I was happy with
> > v3 onwards IIRC. Anyways, I will give it again =F0=9F=98=84
> >
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > --
> > Regards,
> > Sudeep
>
> Thanks=EF=BC=8C
> Yunhui

Thanks,
Yunhui

