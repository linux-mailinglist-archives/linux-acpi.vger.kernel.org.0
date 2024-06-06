Return-Path: <linux-acpi+bounces-6231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B5B8FF142
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 17:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F10628461B
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF9197A8C;
	Thu,  6 Jun 2024 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6iKZoLG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A4197A6A;
	Thu,  6 Jun 2024 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689145; cv=none; b=DpT+tdraZ07tBvqeMqDHOIa3+ij5exnuycOtY+ODEUbNyqtg2xD02hLxRIB0lV3zF/s5TPxTW6SnsUI5ox46HPZyQR2OAroJ/Yfrah9XOQsByBSE1nuDDLQw7Wv/35ajSMPhADpLYN6EjVOddJJiFBw2QOzzg/xRDR+qRvKqqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689145; c=relaxed/simple;
	bh=B0gzbgaSuheVLjZ6z4399Ms0LLsT13io/dXJxMyevAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdblO1m23sOmAKB+X0Own9KDAlox1c/VlFhLT++75J340iZAYlrBqkMtZcQdYYfjLe3bMeeh459p3BjUeW3V23e4LgnqtPNgDTqXeeIu0GRxbIvHFvVoWHgKYmiQWYQZ/A11yfv3slwoTF+dVVD1yxXmUw/x927BiiegxOKsZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6iKZoLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BEBC32781;
	Thu,  6 Jun 2024 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689144;
	bh=B0gzbgaSuheVLjZ6z4399Ms0LLsT13io/dXJxMyevAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d6iKZoLG5xjosNXqnWzoSwauFUTMjtMSXhhgGZjA8jdFUFfklAPPOhyM/LJ5Uca9k
	 g2hss8xqi82tdL2dkhW5L7d8Ho35qQ7hr8ItVvNxTrgsaxjbd650i30WPgUQzI90L5
	 h7LzUs24WA5p3Tz03q0XaGPQP3xtUZdZyzsFSjciujXT5aZCNZQsdjiqR135tBqu5T
	 iNaQeJrzkv9UCtZOKGNGQLdYsqiGINPcC9QsTHQ3Ts0Ykl1oWgmis0JpFZNpy5BcuI
	 F0i9JyM/UtYvctlZvXeHxSwytg9gpT+0UtoVOau1AZekZAF/XUivmqgSQrfLhsbm1r
	 M4pge7r4vTOwA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ba77a212adso45521eaf.3;
        Thu, 06 Jun 2024 08:52:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdIUOHvyP6Eq8RjYd+9+B8LjJZuhGikDh0uCHzH4vUDqfcr9itFOgWCwK22TMoNiCUwi+tWOeFeoaNgJp2O9/QIZGuVpDSEhtVtEICGXd9A4q5ooI2li71RuU7CRzBUwIB+MrtXkR9j1k+p+whcyqTmpAjS6odvFA1aqIFOcBg31s+
X-Gm-Message-State: AOJu0YzLwdiOlBVY4n9w0H8h6l1R8Zbh1rGBekkgEI1kcdAo7gb7/+9q
	zDBwsuNi8I38sKZs6ZW+EvUv37+dqJ5aJGiiMSX2OBKVe1QZozhjzQ2FxkxdN//ReH2enqZHDTj
	jv0chNnHkc2ZU1FaX/1d3TnZbEaU=
X-Google-Smtp-Source: AGHT+IGclzzV4LP00AKgRX+YX360814VS1Gz/p3bccBW1V61pUfSfhzXYg1bb/W2vE/W8b1XVxiuF3JbvT/hfHj9A1E=
X-Received: by 2002:a4a:3442:0:b0:5b2:8017:fb68 with SMTP id
 006d021491bc7-5ba78d3b4c3mr6253102eaf.0.1717689143933; Thu, 06 Jun 2024
 08:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4569763.LvFx2qVVIh@kreacher> <5f93f034-f781-47e0-b8ce-3c8407a709f7@linaro.org>
 <CAJZ5v0hkOvYL66D+tCRJxbp=XqV59yeZ0dA1Kxoczkcpe5X9sA@mail.gmail.com>
 <CAJZ5v0joTyOcRU0FyaHEEYEbiPbbNSFzW3P7eJJ4MM5QdhQR2w@mail.gmail.com>
 <90a9df3e-153f-4972-8086-13c21a574763@linaro.org> <CAJZ5v0jurx=TfT2GHCeMt7xhTFRQwpS_H6-fDss=bt+HodvBoQ@mail.gmail.com>
 <3ab5357f-9577-4985-b09e-b686e66b7b5e@linaro.org>
In-Reply-To: <3ab5357f-9577-4985-b09e-b686e66b7b5e@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Jun 2024 17:52:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jjrerXYm8k2eHY5NnG3UXuKeyyr5wbQ+UXBs-6OuQqMw@mail.gmail.com>
Message-ID: <CAJZ5v0jjrerXYm8k2eHY5NnG3UXuKeyyr5wbQ+UXBs-6OuQqMw@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:46=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 06/06/2024 17:15, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> > OK, so arguably the driver could set the initial state of the cooling
> > device to 0.  That may or may not be the right thing to do depending
> > on the thermal state of the system at the moment.  Then it would need
> > to wait for the governor to pick up a more suitable state for it or
> > leave it at 0.  This could address the particular case at hand.
> >
> > However, should the core fail the cooling device registration if it
> > gets an error from .get_cur_state() to start with?  It didn't do that
> > before.  Indeed, it didn't even call .get_cur_state() then in the
> > first place.  Moreover, the current state of the cooling device is not
> > even needed to register it except for the initialization of the debug
> > code for that cooling device, so why fail the registration of it?
>
> Indeed, the simpler way would be to not register the debugfs if we can't
> get the initial cooling device state, with a message, so the driver
> responsible of that will appear and hopefully encourage someone to fix it=
.

OK, that can be done.

