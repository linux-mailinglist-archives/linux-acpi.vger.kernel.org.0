Return-Path: <linux-acpi+bounces-6567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F100F9125B7
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 14:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872FAB253CB
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605A1552E0;
	Fri, 21 Jun 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRpj/cf9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A10153835;
	Fri, 21 Jun 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973431; cv=none; b=r2Rs8RdGcVtjPYsB3EFKkvtj9vNy6Sh+MHek+pMUIpwSO+zvipnvr3wQ4JloQL1poSfiCthyiL8gdBJJfvrBUaRXDtv3aYL8ga4T/3IlAx5w9OgKG6p/JUADPVbsYK9Mv8OP8NwsN0i+fQMCnil4FejQjSGJIpxGfUFAp7e4DNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973431; c=relaxed/simple;
	bh=dfAf4n5zBsx+imv+loa9ssfMA5UD+vIQUx1NK297QuU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gTOvXNN3qbj1DHel9txlpY02+3U/vNBd+SCjCtdr21iKsOb8O0FVEII+xLeSSDT4uMvw4nX2fsQVIrFui6XqmUvETPEIRCPLY7ftOndkk07LfzLAPuVnwWUF/eHKtIeGkA5huRxJP1XbFCyQzO0EYiAUvXB9ameWir0AXejKtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRpj/cf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BDFC3277B;
	Fri, 21 Jun 2024 12:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718973431;
	bh=dfAf4n5zBsx+imv+loa9ssfMA5UD+vIQUx1NK297QuU=;
	h=From:Date:Subject:To:Cc:From;
	b=sRpj/cf9RhYo3yfzLEw8eVCFG53aRIJezpB8o/NYBl9S6Mol2EmtBa5VTrqH3BLU7
	 INgBjrLJk9Q5KDoVxVN4J1rlLLhWDW8jSdOk9IYc8KxdIdmE8s5A0BRuT/XZXc3ZZB
	 je3DJLLb7GxJrF8zKHwc/fpXeXnjCfPuaKyyl7RyRGUcbJLbka2+/6rN2M105ZLY81
	 SJ9O6t7qcuBKRntbOyz3qg9XpxoQ0aD/Xdppga3BV2uS8KFFqgC7HtihdOWQ4fCweX
	 2i/YBah9W17+9Vv9nX3pOvUtQuzU+7V6Q//YhgYc4Yt10QO+1FQrM6DvW69/Hxmzzc
	 qqIdTpB3ikpUg==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7009a3976ebso41160a34.1;
        Fri, 21 Jun 2024 05:37:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF5Hg6TLpzK66QWMaVzeupX5ZvgF5IpzFiRH4QCkhvF6SOqLCeeldyDKWDU0afGPKjuL8+lDdsFacpSdZXqtsR5gztYlirO53xllPAyNpGuDJ2XSUqhiL8TZ7sJ/PtC7aflmC2YeMKMw==
X-Gm-Message-State: AOJu0YxTIxhQysMztlk+44jJisi9CTZttKFBTiQaoVVV/V3phrMtaUnw
	IrBIdOBFJ9lgHrzHxKmljzVlxkqkadJ6VNHGbM1tQvNYBUjNwxuMw/eotuY9NUzN9iFq2Ou/OPb
	zmgTo48xwM9P9L6H2ip+7SJoWsfk=
X-Google-Smtp-Source: AGHT+IHNCFPtqPAAzOCR2CLR1rtu6Ka+NEYQjHYSykg5gQz5SdIJ6OdifqEO/OuapdZvKNi/i+e11lzAnqbcszdhvi8=
X-Received: by 2002:a05:6870:1714:b0:258:4ae8:4aec with SMTP id
 586e51a60fabf-25c94d411damr9008077fac.3.1718973430228; Fri, 21 Jun 2024
 05:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jun 2024 14:36:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0_idYr5VhHc_Uy6h2PQBf7ekFVAygUOOKiui1QkRUSQ@mail.gmail.com>
Message-ID: <CAJZ5v0g0_idYr5VhHc_Uy6h2PQBf7ekFVAygUOOKiui1QkRUSQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.10-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.10-rc5

with top-most commit 096597cfe4ea08b1830e775436d76d7c9d6d3037

 thermal: int340x: processor_thermal: Support shared interrupts

on top of commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670

 Linux 6.10-rc3

to receive thermal control fixes for 6.10-rc5.

These fix the Mediatek lvts_thermal driver, the Intel int340x driver,
and the thermal core (two issues related to system suspend).

Specifics:

 - Remove the filtered mode for mt8188 from lvts_thermal as it is not
   supported on this platform and fail the lvts_thermal initialization
   when the golden temperature is zero as that means the efuse data is
   not correctly set (Julien Panis).

 - Update the processor_thermal part of the Intel int340x driver to
   support shared interrupts as the processor thermal device interrupt
   may in fact be shared with PCI devices (Srinivas Pandruvada).

 - Synchronize the suspend-prepare and post-suspend actions of the
   thermal PM notifier to avoid a destructive race condition and
   change the priority of that notifier to the minimum to avoid
   interference between the work items spawned by it and the other
   PM notifiers during system resume (Rafael Wysocki).

Thanks!


---------------

Julien Panis (2):
      thermal/drivers/mediatek/lvts_thermal: Remove filtered mode for mt8188
      thermal/drivers/mediatek/lvts_thermal: Return error in case of
invalid efuse data

Rafael J. Wysocki (2):
      thermal: core: Synchronize suspend-prepare and post-suspend actions
      thermal: core: Change PM notifier priority to the minimum

Srinivas Pandruvada (1):
      thermal: int340x: processor_thermal: Support shared interrupts

---------------

 .../int340x_thermal/processor_thermal_device_pci.c |  3 ++-
 drivers/thermal/mediatek/lvts_thermal.c            | 12 ++++------
 drivers/thermal/thermal_core.c                     | 27 ++++++++++++++++++++++
 drivers/thermal/thermal_core.h                     |  4 ++++
 4 files changed, 38 insertions(+), 8 deletions(-)

