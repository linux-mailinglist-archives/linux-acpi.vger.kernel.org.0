Return-Path: <linux-acpi+bounces-6383-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AF1907C96
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 21:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADBF287B74
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95614D281;
	Thu, 13 Jun 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwtqLAfg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F814C5BA;
	Thu, 13 Jun 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306872; cv=none; b=CgwE2dSnEOQDRVxiOtCXMqROG7xh6r4sKpNPgXmJPW3+Z9MZ3NaI/N68XR0RT2AsGQuG/6lw5F9bK1Q7IzxqpkNOAI6yO0LXcS1hF9heFfgo2F+9pXm/j0HYV76VjdYKmZS9oDGlj55VdrsB4IdjKRileOvGbZvkxpppq+9Bz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306872; c=relaxed/simple;
	bh=0cna6WAuI6dAbkB2W/5JVPHrsBSinuZTm6i0oIaQP20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuiE+2PDalLru8yL74B00zJ0KcapVv+CP4JhgHYAbgLLRTNDrWNfW+HEh2CKWcJps999OHROo3GwdVNb34fNc1qKPKAlxJq+3B9NimiQK5DIs+hI0V56y+QKSrmKOUYLYE1Yhq+P/ksLWKte1xWgmrFIGArypTPNZFvMpRpipxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwtqLAfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4ADC2BBFC;
	Thu, 13 Jun 2024 19:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718306871;
	bh=0cna6WAuI6dAbkB2W/5JVPHrsBSinuZTm6i0oIaQP20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hwtqLAfgwF1Wd94H+uDkjjIljtXfKa6R0vOo+OBH09bm+KbIB0z06WAR8XC9Su5t7
	 P/07uxyLSAC5xcAwXsC5vsCHKXo4yJATXPG4ryxYjck2/n0n3qT2JjQze8l08/odG/
	 XgyEp3sgNLRq59KmU9IDWzNT9d/UF0yYS4glnV+n+EizrTV+49EkmYaM1nDutzOPeg
	 mPwb3ESYoSr7TRMHunQYD9MqrrWlla6u10ltjt/eK5iZug0Sz8+jJycoSGMoRBkcDO
	 wAv+YzZGTF439w4TYjtwsE4i0iTCk8CY1JaWh20BZhDs4Dx4ECb2xykem94DV3dSEu
	 n7dRog6yD3WEw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25075f3f472so224064fac.2;
        Thu, 13 Jun 2024 12:27:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFo0koAk8umrxpNs5lNpNZ6rdBNNkO1PBlGP7ONj+XIqOJMwkF31ZJ4eLgI6UVayZa4gu+fvRD+5ctOsm90K7jPDNjO5LhwM4yu2JK4pVQxx/2xa1q5bgr8LuCy9VNp74+/+Rk6plBTw==
X-Gm-Message-State: AOJu0YztmoooQa/JAguhONXm/30KOntyqnOBmsniaibx8vG/li4A9SaA
	zQ9nLe49/p3XbkFmxgP0yHmy+P306AX1gZXtgjRgCRlG2EiFCWdq7LuGprlLbOp+41pI3SesXFo
	MDrY+en4BYxrrlrDY25+Ncr6GfK4=
X-Google-Smtp-Source: AGHT+IEQo4Qv/FsnbKkDqpZ8sxZoT5kIzoQXHKb2Z63ZBtf62AhHqi/37gOMe07Dr0X7eForQDfPk73nGXQq5M4kaOw=
X-Received: by 2002:a05:6808:1807:b0:3d2:1b8a:be6f with SMTP id
 5614622812f47-3d24ea446f0mr562688b6e.4.1718306870665; Thu, 13 Jun 2024
 12:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
In-Reply-To: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 21:27:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMLzWGLODi23od6wm6PGKYeTW3Nqqgi5kQNpRFYEH6cg@mail.gmail.com>
Message-ID: <CAJZ5v0hMLzWGLODi23od6wm6PGKYeTW3Nqqgi5kQNpRFYEH6cg@mail.gmail.com>
Subject: Re: [PATCH 0/5] ACPI: (mostly) battery: various fixes
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 9:27=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Thomas Wei=C3=9Fschuh (5):
>       ACPI: AC: constify powersupply properties
>       ACPI: SBS: constify powersupply properties
>       ACPI: battery: constify powersupply properties
>       ACPI: battery: use sysfs_emit over sprintf
>       ACPI: battery: create alarm sysfs attribute atomically
>
>  drivers/acpi/ac.c      |  2 +-
>  drivers/acpi/battery.c | 26 +++++++++++++++++---------
>  drivers/acpi/sbs.c     |  6 +++---
>  3 files changed, 21 insertions(+), 13 deletions(-)
> ---

Whole series applied as 6.11 material, thanks!

