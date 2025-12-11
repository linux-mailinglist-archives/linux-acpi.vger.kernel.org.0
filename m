Return-Path: <linux-acpi+bounces-19560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ABBCB6FC1
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 20:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8551301FC01
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 19:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CC2DE70B;
	Thu, 11 Dec 2025 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB4qOH+9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2222BE051
	for <linux-acpi@vger.kernel.org>; Thu, 11 Dec 2025 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765480289; cv=none; b=fZkLeTv0aNtNWFSnFrm3QdzRNOgXJu4wagMoQZ63BfAjOnFvlau0VZ/W+i3Bmjem1nEQxo2Qrz45CPSAkBbvPnn+jsXNyagYT3lei9SzySgqPoVW4aTYPuHzJZiXTh9oI8w00YRJTavubXu3TsH40uNhE5YtDCkx27T5ernC8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765480289; c=relaxed/simple;
	bh=KMiBewgHctJLXHmyHW03C4RmwjOt6YS3yWi/cifLCIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyzOnnqS5eqayw6D0xBxmVR7v4j1YQO8VC/9Oc8+zmdWmRkKcFWuaX5NkcxWw9eGe/fwIZY3tkRSt8zbdkv8eIBDisA1h6FPc4ZGjKTF9JqumNR4oyYY6VrKctBQ5aefCUDQRTlE96dbV45ZxNkEhE5q5uMrEghgZw21+cSmHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB4qOH+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BA4C2BC87
	for <linux-acpi@vger.kernel.org>; Thu, 11 Dec 2025 19:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765480288;
	bh=KMiBewgHctJLXHmyHW03C4RmwjOt6YS3yWi/cifLCIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GB4qOH+9tvVe2k00EjJo6o2FMHhXL7dx2NRFVnYoi+KGzNxD6LZsB9LJYotJkVvF8
	 zdPCWt7vtAGDUZF5+zvpxFrs0nqXb1vVZ4hdTlBP8fWrfM24uR9tZ7rLVpS1h0H8lf
	 kzA4KSYBMO3tZ+lYMHCLXI2grQ6sPYt+ecTYEe+Fb+7okPbn8Pim2efF/ZkVeAi8Y4
	 Rxk8Y7xSy1F6MYYJoAN1TZOfOlCvPoK0rQqMDIkk6kEYaF5FeZy5eaTkXMl2MotW/5
	 C3dDHBnpPKAbA0XulJqAkOdYtFZ8tRe2v2mmeSX7NjjCDJr+bhUInb8RQOrZL6hjxF
	 PKM284TX2MO9w==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c75b829eb6so315611a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 11 Dec 2025 11:11:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+LY68v6XcHvOAOjRsyjtI7BeKtik9QOHm/gCgv5/EY+Go7T5CbDQf6GQ6Jm+HyVSIoOgQ0THaIrNI@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9kxEdRHjhJCpWXJGOCIHq4xo55zaEjNHDi0sqoXQFyVJDJkT
	8Fbce7Lqi0eSjL59Wp1htsk9U4PTpWd7C+P/B/Q6cSDhl9y5RZ4B9jPkdp7K0njwF1DlaUGAns0
	dwMWv3cwXMTkrS+V0PqBlwzoaqvrnIXY=
X-Google-Smtp-Source: AGHT+IE4gT4K/DVbShJR5+FOBwlkLAtnvHuJqYAPLnPHRe0a8K7KDPNSBmuIIVGkAIkSjV/ndG4kAnPsIfZy1/8nUco=
X-Received: by 2002:a05:6820:4cc1:b0:659:8350:61b6 with SMTP id
 006d021491bc7-65b2abc0bb7mr4041632eaf.6.1765480288171; Thu, 11 Dec 2025
 11:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5066996.31r3eYUQgx@rafael.j.wysocki> <2028345.PYKUYFuaPT@rafael.j.wysocki>
 <aTsQKAJF5hpOixIR@aschofie-mobl2.lan>
In-Reply-To: <aTsQKAJF5hpOixIR@aschofie-mobl2.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Dec 2025 20:11:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hWo=75tVGVZa5ARC3Nwtb5R_DR6s-V1X_e79S4E2RucQ@mail.gmail.com>
X-Gm-Features: AQt7F2rXNnsgFmv31s6uUV-q-25TB0-39LelfYxc82xAQH4IX0mBpDelNn3uQ_U
Message-ID: <CAJZ5v0hWo=75tVGVZa5ARC3Nwtb5R_DR6s-V1X_e79S4E2RucQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 6/6] ACPI: NFIT: core: Convert the driver to a
 platform one
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 7:40=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Thu, Dec 11, 2025 at 03:22:00PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > While binding drivers directly to struct acpi_device objects allows
> > basic functionality to be provided, at least in the majority of cases,
> > there are some problems with it, related to general consistency, sysfs
> > layout, power management operation ordering, and code cleanliness.
> >
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the ACPI NFIT core driver to a platform one=
.
> >
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
>
> Changes sysfs layout? That means it changes sysfs paths?
> Does it change paths defined in Documentation/ABI/testing/sysfs "What:"

No, it doesn't AFAICS.

It changes things like /sys/bus/platform/drivers/ for instance and the like=
.

