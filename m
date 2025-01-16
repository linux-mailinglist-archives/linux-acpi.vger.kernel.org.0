Return-Path: <linux-acpi+bounces-10725-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD6CA13C8D
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 15:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E673A77B1
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0022B5B1;
	Thu, 16 Jan 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAjV77mP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465635968;
	Thu, 16 Jan 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038693; cv=none; b=aVqMWnkZkYNr8cm8ib8SXhRYwSBNa7RMHzLOUI97x6VoSiAbKw6vgmtukpjL+QOVtmScamLX6nOLHevCDaWMN72W0EapbYmR+MJua0ZNsr2pxJeh7U2lK25CkyWnlCvWfYUYX81A+Ts1VSpsKhinyL/3fz7KdtV3BFkXyKS/Kjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038693; c=relaxed/simple;
	bh=npsApPA+hljWDarBnVadWNkA2hwrbtGy8vO5AcZrcGE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A1KrGatxYfT/KYlbG/bR/e87OLjQLMugAl/4ugtOcz5DEw7QJWHjgt3S7X1AYymmCS13yFg53IxsnWSUUOfcIOZ/xlQMXwz4AQ5QtOeGZ2SVOrIGzPZJpmS1I+sR61m/4hz9hgBhctqQKOVQsXQ2X5cJvaU5Hhk4oL4VyYRT0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAjV77mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A67C4CEE2;
	Thu, 16 Jan 2025 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038693;
	bh=npsApPA+hljWDarBnVadWNkA2hwrbtGy8vO5AcZrcGE=;
	h=From:Date:Subject:To:Cc:From;
	b=NAjV77mP0RQN/PPou/YlCkYAslFnvek15auAmiZFUhiHPJfPKCFE6xA8P71CMLpal
	 KlNn8xzrhZGUNMcdbffX0CE8rfveIcxCH9JoFWDl1fKAdJVGXaqKa/ABLlwYb3BfDZ
	 IXxt+zKSi3Gg8hZQFVPezm+A1nHvb2CMNKWNctadTwt7OYdmIzMjlgvLOrjFrEUCvY
	 k19YcHD5i9m1Ri6kjXHWKGLUzUsw4oZV+b9k7YCE0GobmGPYuChV+HBS3vppMX5jLS
	 ajExZDdmzwT++dQVmYsFGRS9oFHLyS4vxf/uo59ib6VrcfTUaO20fgIICDYs4JFRyl
	 kaBmuC+BODjHg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29f87f1152cso544878fac.2;
        Thu, 16 Jan 2025 06:44:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGlZl5tGLompbN8Je17usafLy/ICilPaiAa9Uttbr1rutM5HQtQU21IFl61N/q+twwBeNs1MuuRkpBuIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySw42svr5P45cGXVg6J4xnKkq/P2mrre514r5Hmv4rfppAphVX
	ncDiWkV8Oa8cA27LyziRaVSAZvzqEm2+Ig03PS8XNsc06cGjDFuwbrrjfpJrQUKXbvkwZGhQlnq
	eEr5wPqa3zVSDUTT8z8sPHuivBK8=
X-Google-Smtp-Source: AGHT+IHiEioe8tcJmluuNegziPgyxt9jEJ4pWYHKKW5JPwXCcbFIWBdQaNSiDrtDmZL7+jlhA35EAuJ9lODjrv6DYRw=
X-Received: by 2002:a05:6871:a587:b0:29f:f4af:dc34 with SMTP id
 586e51a60fabf-2aa0654476dmr18543554fac.7.1737038692198; Thu, 16 Jan 2025
 06:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Jan 2025 15:44:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j7Kf_zWjB0kv=b=V9DBKoodGap5_-QimbZzz=WZnpkpg@mail.gmail.com>
X-Gm-Features: AbW1kvYXLvNPwV5CHojfvK8k0C5HHCJPD6R_9QTdF3e6ShV3qMVit-RzoA7jP8g
Message-ID: <CAJZ5v0j7Kf_zWjB0kv=b=V9DBKoodGap5_-QimbZzz=WZnpkpg@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for final v6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.13-rc8

with top-most commit 14578923e8c251091d2bb8a2756cde3b662ac316

 ACPI: video: Fix random crashes due to bad kfree()

on top of commit 5bc55a333a2f7316b58edc7573e8e893f7acb532

 Linux 6.13-rc7

to receive an ACPI fix for final 6.13.

This prevents acpi_video_device_EDID() from returning a pointer to a
memory region that should not be passed to kfree() which causes one of
its users to crash randomly on attempts to free it (Chris Bainbridge).

Thanks!


---------------

Chris Bainbridge (1):
      ACPI: video: Fix random crashes due to bad kfree()

---------------

 drivers/acpi/acpi_video.c              | 49 +++++++++++++++++++---------------
 drivers/gpu/drm/nouveau/nouveau_acpi.c |  2 +-
 2 files changed, 28 insertions(+), 23 deletions(-)

