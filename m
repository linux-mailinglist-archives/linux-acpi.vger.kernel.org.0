Return-Path: <linux-acpi+bounces-3882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8414860767
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 01:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D57A1F23DB7
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 00:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B17372;
	Fri, 23 Feb 2024 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2vMev0v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C576181
	for <linux-acpi@vger.kernel.org>; Fri, 23 Feb 2024 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646674; cv=none; b=CEsAX7vHumg1JGARkzFS46inpzO3/GD0P8GR0+nJaYR+31Y3tezABP+zd10wK/9YFNoUYsF8PaHzpQjs3C+ZG1/uLWY757RQHyVgRHzY5m7iC1qn98cgNKMgL8forYgY51n2OilMMWTHmkKVV283auSmvYUUubwvfTW019+bMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646674; c=relaxed/simple;
	bh=9pP5OlmtAIgm4P1Ua4x74MyvoK9EL4bdQqglBk/+A9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUV9jG8LC7zZijhQHq6Ee01wJRNaQTLr/Cb5sMvvz4cJ1I4JFmDoD4IQwkvzXDdUvhCDmoiUFGaasuw1TWeHyhHxg4PxvVt8GmEVYabZKl8/Q9Y+DolXaAct0TF1MvnAK29vBOQd+BmVrsNAhXGJkDCktFK8tlSieHy0Tq0p9/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2vMev0v; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42db1baff53so51291cf.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 16:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708646672; x=1709251472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4XV+6evrAtbe6Ax9g1oW9X84h/Wj2ygEaesXkyr4b8=;
        b=D2vMev0vrQHJXk/hljFc4iMPZHQhj+ajZQFLkai3mm0BR+TqPYbCLlUZ6gESe81LMO
         gNIkHVjjMvyUU87MFZj7zXJhM7px1FhulgKCjeMRhGnzsQ6/VRJahT1ZSfOX3Fvv4SpT
         lRcX6l5M/pMexV2D5DTqh6vX5qcWsrLDFpBEmFTlSyTkloZ+oMjOWHENp0Z8Qcf0lb1r
         FqT7OV3HpMwk6w3P3/+5vo7jgp52mL5N7IA1IYVADBTFQ40b+Hy42STmQpWaCMLYUqMc
         QQVy3G4HYfK1NqD4S6GY02Z7Uez7aL2+7FQRVsjt3ErSL43PT8D2DQonAzt6/rvbJ2Zj
         ajvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646672; x=1709251472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4XV+6evrAtbe6Ax9g1oW9X84h/Wj2ygEaesXkyr4b8=;
        b=Bbc4lzNFTozncLFB5CHngfnIwvFQ3JaVIxP4saDvL5Vr2EVB9WZoKuqwXm+R31ElhZ
         Cz5NAhnRcvG08Wv2AvpcAaYbe74HWcIc4NZyvzRHwnMCUqjLYNtOsEgXN5WJkAfrIRho
         4qFEWPjcor0L8QuTX7KcaeYqa4LtFlWbUEjj8G1Gj+gT30x94yRE1i8EfcW6wOMvGNP2
         wYQ92GxZ8ZKsWl/4II2wVDKEiqNAitq3X1kVGp6rps4LGuzh05in2ON0UDGxjS3qCL7I
         x/TRbWX+o/dRDrXH8i4dLFgVyB2jjmAfgx8O4aNsxslMewi/hviOXymq/i8biWElTNVa
         hjIw==
X-Forwarded-Encrypted: i=1; AJvYcCXoJIUYVRudbgg8BYQYQnqljSnbI/RVoKTdbaTPiyNfUM8cFI/xUWfomCiFkVx7ncIHoUOJYL1pnSyX4DJGVVGEzGpX/weLJwlJDw==
X-Gm-Message-State: AOJu0YwgtMRQLecZrndeFTIsfEApP1YzzTJWYnGLhw3t5L/9HIoI5GDN
	4ls7Tb4m5ZUnvF3RowGDibMj0SgljbPZf5O1sNjkJL5CFiZOwVK+5rewkhaTqP+R6sdbb6ZWLCp
	+c/t1FlVdyRXCYhpABzKt+wIt2ZGIQUZLc/Cg
X-Google-Smtp-Source: AGHT+IGCEYReALWj0ivUpsTKXkYKdTcTd5VH39dy3gtqxDZ6oRtzNfNSG0nCQX3TRFOJh+JYmcLTyrQlRALpAFmJabU=
X-Received: by 2002:ac8:6206:0:b0:42e:5b91:b081 with SMTP id
 ks6-20020ac86206000000b0042e5b91b081mr205656qtb.6.1708646672198; Thu, 22 Feb
 2024 16:04:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221233026.2915061-1-saravanak@google.com>
 <20240221233026.2915061-5-saravanak@google.com> <ZddNAHqwCNR5MZc4@smile.fi.intel.com>
In-Reply-To: <ZddNAHqwCNR5MZc4@smile.fi.intel.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 22 Feb 2024 16:03:53 -0800
Message-ID: <CAGETcx8-fz7ijTJcBLMWetrZRfvS5GGGOBBoFM7an6qDtZ1NNg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] of: property: fw_devlink: Add support for
 "post-init-providers" property
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, kernel-team@android.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:32=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 21, 2024 at 03:30:24PM -0800, Saravana Kannan wrote:
> > Add support for this property so that dependency cycles can be broken a=
nd
> > fw_devlink can do better probe/suspend/resume ordering between devices =
in a
> > dependency cycle.
>
> ...
>
> > -     fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np=
), 0);
> > +     fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np=
),
> > +                     flags);
>
> I would leave it one line despite being 83 characters long.
>
> ...
>
> > -                     of_link_to_phandle(con_dev_np, phandle);
> > +                     of_link_to_phandle(con_dev_np, phandle,
> > +                                        s->fwlink_flags);
>
> I would leave this on one line, it's only 81 characters.

I don't have a strong opinion either way. If I need to send another
revision out, I'll address this (if checkpatch doesn't complain).

-Saravana

