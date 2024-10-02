Return-Path: <linux-acpi+bounces-8531-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9498D3BB
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 14:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4CEEB20BFF
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31FF1D0140;
	Wed,  2 Oct 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t24nMT7F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7D184;
	Wed,  2 Oct 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873679; cv=none; b=U1ofpUGK8MUG7CQE6mFiGywocaDLY71bVjPAWm8nwzTQBqSZLA439zr+DXgPnlrEweGoAv1m7yea5eyfKVYTEUNei2FsC+a2bdcxT3CQZSn1OfhjdxwbLo3HQtyAtngo2o++o4ypJGKCI6NhUbUwC5x7FiTVKKCOW+kOdKpXFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873679; c=relaxed/simple;
	bh=c+wAjhCZ+jlBB/VqO0gk7PUe1MNnyar6veIrcBrct0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpDXQE5dR7FYAjGt8cqaq9wnr/vSVPQkWscgeyRw+zJCShFztLVE4Rr008izjkMMo7qU9Gz9CXFX7/zYmdvgb1m1k6ChkRcJnK/rnNpLDsYKg10onb/qyzJkg6DEQaQ+s/0SYi9jmNpqGOq7D+qYzMwVrgAvKGmXF/jBHwBXicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t24nMT7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1511CC4CECE;
	Wed,  2 Oct 2024 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727873679;
	bh=c+wAjhCZ+jlBB/VqO0gk7PUe1MNnyar6veIrcBrct0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t24nMT7F6fPEwXev0pH1eTD5C9fw44MCfbUzxIAOmbcKz8fzIJ2c5bPIYhCJwNSB0
	 IPHRAe3NykkicoVCtc7Mn0R9Hg8eUmCXX5cKaB1b4JppzklsEuVBzy56lK0Ip3wegQ
	 HC50WinPtlDhyxqdrpPO5gqOXV8we/68TB/GBXgcUJflKaEK/PaRplFD6PikO2A5PM
	 8t8eAo2tmmAZZUXp1msrb06xgWnCzAJJ3x0LI0aq0a2L7GFleQzNzyqEQRZAW98SuX
	 y6bPc4Ax+sekksr0ByQEA1TogcCY4uMzg4KC23ZL5xFE+FMzuYCFE+s9ucLzmM3xVV
	 ILrbIgXK2QGBg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e1c63c9822so3464685eaf.0;
        Wed, 02 Oct 2024 05:54:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUerqxjfeq6O+UXS9pPqVym51QlJqwpp9JtPw4xnIWMLAlXGwZiB0vyOIkGVe/Ndh281v26E74wLfFr@vger.kernel.org, AJvYcCXNmDDmVq8FtkfsZXayrymw+H8WB2/3iZt+3tIJ1NR4zRbYVsZpz0NIwMS87iRHZQg1eyoeN6SXaFLQhtVnwciX7n7jsQ==@vger.kernel.org, AJvYcCXZDOWagQbFXawgUHdoc6+BCMKje8kh7SDO9w2VfwWGMBHIg0ZHsA04zCJrTvT+9/rBwAHiqKPfiyEhMQli@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+GsJtvvHmxkvOZejn1zM2qpxbuZxLKQFYdnPRRfs2uJMapY6
	8BvlRuzXgyBELNk9HwFsmz1Yyym9PclS0sZ1Sn03mK3378xNUMKLLm3BxjRCbM0ZkFoG716Z5aY
	dMseHyZKDmkBmVrBRAuVghCsv1EI=
X-Google-Smtp-Source: AGHT+IGFASMXHX70zhnSBgOAUZLNd58qCMfL2R1+D7W4ucw0787y41ikuyApNjYHzRSC5jE2fwmoFEHsQM7em8Jshx4=
X-Received: by 2002:a05:6870:aa98:b0:277:fdce:675c with SMTP id
 586e51a60fabf-28788c23b46mr1686707fac.15.1727873678422; Wed, 02 Oct 2024
 05:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001212835.341788-1-W_Armin@gmx.de> <20241001212835.341788-3-W_Armin@gmx.de>
 <CAJZ5v0gSYp5Umo-wsKvQ2Nff7YZ=_3-4bzG3TnKqMpHvxCmR5g@mail.gmail.com> <ab75a39e-94e2-4b1a-9406-e05ebc816b03@redhat.com>
In-Reply-To: <ab75a39e-94e2-4b1a-9406-e05ebc816b03@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 14:54:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jDFpzKRv=M=6nmyYON6FtEnCsO9K86HO9jKDraAXTYAg@mail.gmail.com>
Message-ID: <CAJZ5v0jDFpzKRv=M=6nmyYON6FtEnCsO9K86HO9jKDraAXTYAg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 2/3] ACPI: battery: Fix possible crash when
 unregistering a battery hook
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>, pali@kernel.org, 
	dilinger@queued.net, lenb@kernel.org, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:35=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi,
>
> On 2-Oct-24 2:08 PM, Rafael J. Wysocki wrote:
> > On Tue, Oct 1, 2024 at 11:28=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >>
> >> When a battery hook returns an error when adding a new battery, then
> >> the battery hook is automatically unregistered.
> >> However the battery hook provider cannot know that, so it will later
> >> call battery_hook_unregister() on the already unregistered battery
> >> hook, resulting in a crash.
> >>
> >> Fix this by using the list head to mark already unregistered battery
> >> hooks as already being unregistered so that they can be ignored by
> >> battery_hook_unregister().
> >>
> >> Fixes: fa93854f7a7e ("battery: Add the battery hooking API")
> >> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Hans, are you going to take this series or should I apply it?
>
> AFAICT the patches don't really depend on each other,

OK

> so my plan was that you take patches 1-2 and I take patch 3 as a fix for
> 6.12-rc# .
>
> Does that work for you ?

Yes, it does, thanks!

