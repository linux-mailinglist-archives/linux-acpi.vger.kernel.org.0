Return-Path: <linux-acpi+bounces-11374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42361A3FBC4
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 17:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2A2867635
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1C1F3BBC;
	Fri, 21 Feb 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeFnWvVY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F061F1506;
	Fri, 21 Feb 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155449; cv=none; b=iPFLDU0kCILT4mrn6JsXMWJnmjgct6oIMQpXhKkYuGgKGo3tdgSIDCIG0pT1CHH6nN0eZJixEc3EPKtvvd7SqWMpAndXoO3d/faUqdTmC0bv00NrsaikOkuoBVzgZC3ZsLX+m/3vO14vK0Pjk56Hww/MuSsNvQZoz0aErsScJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155449; c=relaxed/simple;
	bh=739odh34bcM9h+m6IMaljlp2W8wK/OpxowHnUoF4iWY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e1bfSReOxuV4O/+R/X6XeVsNs22ThoeAbr+hX0V7ZV9GSzOIxL0HC3p6vxtquaGjLoy+Gq0LpdgRbeYNDqpoP1s35tk4gydw/8MBYcG89m2dKCpjjcnmUFOft5rjKc/Je5gDqV/yh7pkVZnY/27VE2WXBzDvBj5lNua9BWo3JdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeFnWvVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2016FC4CED6;
	Fri, 21 Feb 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740155449;
	bh=739odh34bcM9h+m6IMaljlp2W8wK/OpxowHnUoF4iWY=;
	h=From:Date:Subject:To:Cc:From;
	b=BeFnWvVYVofO9FFGCPKknG16r0ADEKUHWLvfDbSeFtBNML+mVBRp8WKxL6k5yeekJ
	 ixzJmAxzFMTdwNE7cLOJSKvL65lIDNX0IcP58YcjH2f0zZaIdXAB7VmGvYadq+Hl3D
	 RrgHv6w93u4jkBIQpNU5hYv06hkDQ6xVMYEqOv/ub5R/eoVTJjCT0/xOraT0kPaLmD
	 n1GmegYZU8I0puol7pH2o0BI1Wkww71qJzqAvYx04iVgG6jBC8DvYOmLM61K2tlHeB
	 ujFPILaGvoHUBYezqCOkYxMWViyjT6ejPXjgY2gXMOBwjA2e1X7laAybgfk3TsEqQl
	 79WKzKX8/D3Ow==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fce3e43159so1621295eaf.3;
        Fri, 21 Feb 2025 08:30:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVSMf/Li/X27zdx9yQ60MmWDI6qZJxOGyLJCK3CAeZmQus+DPjDZHKDPcUGLSKPeD5XcAEW1sqSpYjeOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5ol38k8bNuSk+iQvqGXavNNPq9rdIFhcoKblHZnO0moeZaoT
	Lm6HtWZKskcDOyTp9hNbhbjxAF7bbOCk4vqxN0r//fkYGdeZsAyRl90GgWBLgY+fh+OBvQgbQBU
	eKZUt668PHIB2kKMSL0T0OizcyLU=
X-Google-Smtp-Source: AGHT+IHjAIrw5KXvd/qt43GkWQrQtfQNkSdoUWXKFTXQTlaniatgJN3dsMgZRwBIathZtxDK9a9PxRgJMBhMUtXzLrA=
X-Received: by 2002:a05:6820:1612:b0:5fd:50d:49e4 with SMTP id
 006d021491bc7-5fd19648f16mr2404402eaf.7.1740155448458; Fri, 21 Feb 2025
 08:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Feb 2025 17:30:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hzMUGnqx=GfLUkVZXsMMqqguMV4S7Bf0z9EoPt4AYFaA@mail.gmail.com>
X-Gm-Features: AWEUYZkmAITJ6AyyT22nBx1Z9q6UGq-Qmb2sAVm9FBqQm0zlo3zo1jeICJ7HieE
Message-ID: <CAJZ5v0hzMUGnqx=GfLUkVZXsMMqqguMV4S7Bf0z9EoPt4AYFaA@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.14-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.14-rc4

with top-most commit d403120cb9d4787b283ea202b2162f459d18fe9d

 ACPI: platform_profile: Fix memory leak in profile_class_is_visible()

on top of commit 0ad2507d5d93f39619fc42372c347d6006b64319

 Linux 6.14-rc3

to receive an ACPI fix for 6.14-rc4.

This fixes a memory leak in the ACPI platform_profile driver (Kurt Borja).

Thanks!


---------------

Kurt Borja (1):
      ACPI: platform_profile: Fix memory leak in profile_class_is_visible()

---------------

 drivers/acpi/platform_profile.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

