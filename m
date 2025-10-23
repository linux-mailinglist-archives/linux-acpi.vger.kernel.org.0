Return-Path: <linux-acpi+bounces-18151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC2C0135E
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 14:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 828AB4E6E2E
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19A2EE60B;
	Thu, 23 Oct 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg6i0stA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02828726D
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223680; cv=none; b=h0I2V+XUwTtT0L2HoP0rGxzcEkaN0JwKeB4W3WbcWTMCTw2eXMigyPfiDq8wiaT1JZngnw1c+Gz3dmxfb5/ZFtPpasmy+JGtb9oIoFv/uSMOpicttYGnyZ/8i9Bqa4bRppMExU7qNWXKqmTCUKNbfay5sJxBbvsky3LNOvR3pwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223680; c=relaxed/simple;
	bh=8h0XP/0sMRuhHxS/we1DDP/7uz69ISwczcIYmzNmu/c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LonefkJtTnw+615qZ6sYQq8XkmRbJiPuZuESFcy3nTq2mDoYuvIUfiazcKegShHOy6pnodVBUPsY6r67NyidMhZlIq4UtiXbhSM/SFXWdZq3gfXbMMYdI66Eo2LMOPhXQu3o3fv51vJlxh+B5YYZKhsfxIQ4NSKfRgzzBMWfF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg6i0stA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D244C4CEF7
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761223680;
	bh=8h0XP/0sMRuhHxS/we1DDP/7uz69ISwczcIYmzNmu/c=;
	h=From:Date:Subject:To:Cc:From;
	b=dg6i0stA9sNKkS3tpb3VIq2A38k2qRWOodxoH+dwcgBkcr1fBiD3wjx/umlliDU+4
	 zU//LJm36F1ehG08LpUMZKnS/1oTMutq0X7my11ElzQnEBqBHw+XR/5PZzsMe3G9f8
	 37o3tOi/PeHitoG4eJ3IgWZ+IA+JVZyUnrpZcRBvo729XlocOLlWNfg5Ykbs+EjhEc
	 8gtFaI9rGetiqeFTS+6FGKjAsPpDhKREZb0neveN2sD8T+f7J+O7degHgrHUnJi24s
	 gBfPD/SC+Oj3AbWZCkMyOd5BUmpuCdmKZ4qC5ie0vWKpxHhO1Mq7tGq6Fu69KujzYF
	 ROIC8Xp6fN0zQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-651c77805b7so354379eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 05:48:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YxofkJd0mLFKfoY8HXuQwUvMMSadsJ3RFltpzwYR1bEGvYLGlLQ
	glgvu8OxkCIvNcD98kj6b+PsB9WMbyxX6EMBgmsbjMNyw56ij7xeuy5MiPJKk7BEWtBnSt4VPib
	iOAEpB8FTj/ND2Uuz+dWeo9IQ4+HtfnU=
X-Google-Smtp-Source: AGHT+IHodaO13aXv0g7rcjqMi4Hpki4TcmzAYCEgD19urHV68p03rgICN8PiKYIQ59+tpCSaNLPB+HqQJZDprjQsW7M=
X-Received: by 2002:a05:6808:d4b:b0:43b:6639:7307 with SMTP id
 5614622812f47-44bd41c9cd4mr958049b6e.23.1761223679475; Thu, 23 Oct 2025
 05:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 14:47:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jjEjzcjVnToBjO7pnYbv18-e+7Wp_m+EjOx=3LhaF5Xg@mail.gmail.com>
X-Gm-Features: AS18NWA9P5-uDDPq1EQxL7kJ5BN9RyG7kqKsReis6e-UD9uMWZ0HeORP6H4UJvo
Message-ID: <CAJZ5v0jjEjzcjVnToBjO7pnYbv18-e+7Wp_m+EjOx=3LhaF5Xg@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v6.18-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc3

with top-most commit 114cbd67db825bfa42bc6c34875fc8409e5bba72

 Merge branch 'acpi-property'

on top of commit 211ddde0823f1442e4ad052a2f30f050145ccada

 Linux 6.18-rc2

to receive ACPI support fixes for 6.18-rc3.

These fix a fallout of a recent ACPI properties management update and
work around a compiler bug in ACPICA:

 - Fix a recent coding mistake causing __acpi_node_get_property_reference()
   arguments to be put in an incorrect order (Sunil V L)

 - Work around bogus -Wstringop-overread warning on LoongArch since
   GCC 11 in ACPICA (Xi Ruoyao)

Thanks!


---------------

Sunil V L (1):
      ACPI: property: Fix argument order in __acpi_node_get_property_reference()

Xi Ruoyao (1):
      ACPICA: Work around bogus -Wstringop-overread warning since GCC 11

---------------

 drivers/acpi/acpica/tbprint.c | 6 ++++++
 drivers/acpi/property.c       | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

