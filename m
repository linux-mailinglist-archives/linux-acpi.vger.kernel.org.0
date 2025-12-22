Return-Path: <linux-acpi+bounces-19787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA99CD6F77
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 20:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F75308B963
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AAF33A9D9;
	Mon, 22 Dec 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyPoKjIE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592132ED45;
	Mon, 22 Dec 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431638; cv=none; b=qEkai/mAzmZBHpG95KjBrTWwCPa7ssJ8mmI+LYht53SqmdQlTKsekheg+cQNOGBMfw0FlSQTxcIN+0bvioIRaKNuov/Nu18Z0mxU+rkte9+U05vkuMXIjv1X4Myig5kz36fKunMkEHLyoV0dSrm2q69b37J+aKNvSKUQCfN/T6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431638; c=relaxed/simple;
	bh=wurUB8myqKBQJeVKY0XgWaG6MW+UkrRpqo/CDYpjtcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJ9DbE1fszk25efavGzDYc5YrU16+aqYzF0qhN09GSXBahGbnAQ/EnWtqiWDI/F2nxc8MtsIBGMyWWpbEQlL7Lrg892LsthOw4p0Ls7XNvFOqS8w8//2N4dmzgXgPhiJXl1QDbZyND3LeUzpsk1qELvKq1eNpyTu7zJzEXPqXzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyPoKjIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1710C4CEF1;
	Mon, 22 Dec 2025 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431638;
	bh=wurUB8myqKBQJeVKY0XgWaG6MW+UkrRpqo/CDYpjtcg=;
	h=From:To:Cc:Subject:Date:From;
	b=QyPoKjIEdA6cNGwWMQPDhV6OME1/SdvLOYb62uqbTPEx9n0IkAar+Q0JwPm1SEI6n
	 r3IPPKvPGAkn7SQypBL2cAgtgVhRRKCEZaGcIeJAJChbV83jNFjAR/w6tcPtISBF4L
	 zTX/PgSq71b6NBmumvh50U/dKdXSEj9+4y4zJY2teamfpMHiG39oVuk9yiireh646p
	 A6fzRBSWDBFcTPZuwoL+lpvAXih60xrAtVx42NRw1qq1Wh7GHiRRiaF8otLG8nuxeB
	 oNgFU8SjXD4AHPz0Wm03K9IVQVmbXS1wHc4vpSOAqsnW9AtJOynPeReikINK4wpIIZ
	 /rdpuz+WjWANQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2.1 0/8] ACPI: bus: Rework of the \_SB._OSC handling
Date: Mon, 22 Dec 2025 19:58:23 +0100
Message-ID: <2413407.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is an update of

https://lore.kernel.org/linux-acpi/5049211.GXAFRqVoOG@rafael.j.wysocki/

and the version is 2.1 because I've already posted a v2 of the first patch:

https://lore.kernel.org/linux-acpi/5967663.DvuYhMxLoT@rafael.j.wysocki/

which is updated again (in a minor way) is this series.

The original motivation was to make the _OSC evaluation more robust against
platform firmware deficiencies related to setting error bits in _OSC return
buffers by mistake (which apparently don't affect alternative OSes), but
since it can be argued that the current implementation of acpi_run_osc()
does not follow the specification exactly (see the changelog of patch
[1/8] for details), this is now more in the fixes territory.  However,
all of the patches except for the [1/8] can be regarded as cleanups and
optimizations.

The essential changes takes place in patch [1/8] this time.  It fixes
the error handling in acpi_run_osc() to remove inconsistencies from it
and follow the _OSC definition more closely, which also addresses the
"robustness" issue as kind of a side effect.

The second one reworks the printing of debug messages from acpi_run_osc()
for clarity, like in v1.  Patch [3/8] splits the _OSC evaluation code out
of acpi_run_osc() (so it can be used in other functions), and patch [4/8]
splits the handling of _OSC error bits out of it (for the same purpose).
Patch [5/8] is just a by-the-way simple cleanup.

Patch [6/8] introduces a new helper function for handling _OSC handshakes
in a generic way that should allow some code duplication and unnecessary
overhead to be avoided going forward and makes the \_SB._OSC platform
features handling code use it.

Patch [7/8] is a cleanup on top of the previous one, and patch [8/8]
updates the USB4 \_SB._OSC features handling to use the new function
introduced in patch [6/8].

Thanks!




