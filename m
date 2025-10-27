Return-Path: <linux-acpi+bounces-18258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF4C11378
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 20:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740BF18906E3
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 19:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909E3303CA2;
	Mon, 27 Oct 2025 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJYILTyz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56B2F5A1B
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594062; cv=none; b=kQtPqRfkbkRJdtr6Pw1svwMkkM+FokkZphl7RB8rBVN5YvJ3mLJV7FD/g14JhcO+ARTf2i5kEcZNamN+g8aQo6yO1n/wPZ1ezx6U3I9Q1cFBuKzeQxtUs4aMXMGt2r0eUDsWErCNeAK/G9zFtKf6vv929lAesLqsVBVoox2npWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594062; c=relaxed/simple;
	bh=MDpco140EYHJnzIZmyl84zfrZwv8MADjK5W7/0qLrKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T55C5wXvItBmhHdzEkcpc2izdAwkaxLVKXzQh+3yAJxZxo/FnJmJn6mtvmiGvjHyzAPX5AHenDDllz43yKIVky4Ll3MC+YkhRhF2/l4L8WoZFaNyXLwWKtSWAnAAkRAyjNRsQKfXrm2p8FHAymvEtW0J1yx6CUjjphvWGId7x38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJYILTyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A1BC2BCB1
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761594061;
	bh=MDpco140EYHJnzIZmyl84zfrZwv8MADjK5W7/0qLrKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fJYILTyz/7h4rPMWRJhk0Rh2VYt8AZbDcwYbrHYurq4DYgQD2DjPdh5HG+uugxNTz
	 x7123G08554Cc8iPNAhfoL4mt+w84QCzMYcuJXLeHw9T7hqcI80G9yvsEU7DG1eAqV
	 uF/5CNPpHF3Wn9ainrxPwPeKtHzWVGMkHpK54ffaQs11h96kBKRkKyYr3hGpIoC943
	 2hNlE+fjZSvAs1gs+QKGHrTgY3zYsTZ5GvIE/6H/JYXxrUzHDa8rpENbARsdWxOLzw
	 xH/51dw73sdp0Q6jaR1ItvYgyDnByyCROPri4W9fUXd02TUiNr4tJSXuKq88n9Wr9M
	 2yVnINmGG+8kg==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c28c21aba1so3940924a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:41:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2kCKKEiKvhTRSEgWM28eAUbUr3f9TCMl1hc0DDa+EuJUAoVO0CEwhZUEAfvw5KUSiBwXw6RMB7k2d@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFsDoMzVOn9wx+BIWo3qWnJyY/eg1ipmIu66z3U9qL/WmXT+X
	uBSX1jyYl0d/6VCBtyWaF6zQIi2Rh0BOpdP/K91ZRzBdz1JZEQxAOANZNrQWpyqvUpJFZcX09wY
	nMwonFYLhxzI7Ic2D9vNs8PtmnDcSy5c=
X-Google-Smtp-Source: AGHT+IEBgYaGMef3W1iGMJpqdA0ZG8CMABKhFKsCxja1XTApdIIjx+hlUQbv+lCioaXAiOzYpoDeh9fqTixQ61UktBo=
X-Received: by 2002:a05:6808:1986:b0:43f:1c5d:8db with SMTP id
 5614622812f47-44f6b9c8228mr477987b6e.6.1761594060621; Mon, 27 Oct 2025
 12:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
In-Reply-To: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 20:40:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h22pPnwPnkbd5HfP02aTbiK22nHCGtGKn1eR2KDM4Yhw@mail.gmail.com>
X-Gm-Features: AWmQ_blpJP4rFQ3BH0tPZYsDJPnselHHXgoaG2rNNVBgBQ9UQYhzqXwIRJ0dTXw
Message-ID: <CAJZ5v0h22pPnwPnkbd5HfP02aTbiK22nHCGtGKn1eR2KDM4Yhw@mail.gmail.com>
Subject: Re: [PATCH 0/6 v6] Make ELOG and GHES log and trace consistently
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Tony Luck <tony.luck@intel.com>
Cc: linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Xiaofei Tan <tanxiaofei@huawei.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Arnd Bergmann <arnd@arndb.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, Xin Li <xin@zytor.com>, 
	Will Deacon <will@kernel.org>, Huang Yiwei <quic_hyiwei@quicinc.com>, Gavin Shan <gshan@redhat.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Li Ming <ming.li@zohomail.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Karolina Stolarek <karolina.stolarek@oracle.com>, Jon Pan-Doh <pandoh@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Shiju Jose <shiju.jose@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:26=E2=80=AFPM Fabio M. De Francesco
<fabio.m.de.francesco@linux.intel.com> wrote:
>
> When Firmware First is enabled, BIOS handles errors first and then it
> makes them available to the kernel via the Common Platform Error Record
> (CPER) sections (UEFI 2.10 Appendix N). Linux parses the CPER sections
> via one of two similar paths, either ELOG or GHES.
>
> Currently, ELOG and GHES show some inconsistencies in how they print to
> the kernel log as well as in how they report to userspace via trace
> events.
>
> Make the two mentioned paths act similarly for what relates to logging
> and tracing.
>
> --- Changes for v6 ---
>
>         - Rename the helper that copies the CPER CXL protocol error
>           information to work struct (Dave)
>         - Return -EOPNOTSUPP (instead of -EINVAL) from the two helpers if
>           ACPI_APEI_PCIEAER is not defined (Dave)
>
> --- Changes for v5 ---
>
>         - Add 3/6 to select ACPI_APEI_PCIEAER for GHES
>         - Add 4,5/6 to move common code between ELOG and GHES out to new
>           helpers use them in 6/6 (Jonathan).
>
> --- Changes for v4 ---
>
>         - Re-base on top of recent changes of the AER error logging and
>           drop obsoleted 2/4 (Sathyanarayanan)
>         - Log with pr_warn_ratelimited() (Dave)
>         - Collect tags
>
> --- Changes for v3 ---
>
>     1/4, 2/4:
>         - collect tags; no functional changes
>     3/4:
>         - Invert logic of checks (Yazen)
>         - Select CONFIG_ACPI_APEI_PCIEAER (Yazen)
>     4/4:
>         - Check serial number only for CXL devices (Yazen)
>         - Replace "invalid" with "unknown" in the output of a pr_err()
>           (Yazen)
>
> --- Changes for v2 ---
>
>         - Add a patch to pass log levels to pci_print_aer() (Dan)
>         - Add a patch to trace CPER CXL Protocol Errors
>         - Rework commit messages (Dan)
>         - Use log_non_standard_event() (Bjorn)
>
> --- Changes for v1 ---
>
>         - Drop the RFC prefix and restart from PATCH v1
>         - Drop patch 3/3 because a discussion on it has not yet been
>           settled
>         - Drop namespacing in export of pci_print_aer while() (Dan)
>         - Don't use '#ifdef' in *.c files (Dan)
>         - Drop a reference on pdev after operation is complete (Dan)
>         - Don't log an error message if pdev is NULL (Dan)
>
> Fabio M. De Francesco (6):
>   ACPI: extlog: Trace CPER Non-standard Section Body
>   ACPI: extlog: Trace CPER PCI Express Error Section
>   acpi/ghes: Make GHES select ACPI_APEI_PCIEAER
>   acpi/ghes: Add helper for CPER CXL protocol errors validity checks
>   acpi/ghes: Add helper to copy CPER CXL protocol error information to
>     work struct
>   ACPI: extlog: Trace CPER CXL Protocol Error Section
>
>  drivers/acpi/Kconfig       |  1 +
>  drivers/acpi/acpi_extlog.c | 60 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/apei/Kconfig  |  1 +
>  drivers/acpi/apei/ghes.c   | 62 +++++++++++++++++++++++++-------------
>  drivers/cxl/core/ras.c     |  6 ++++
>  drivers/pci/pcie/aer.c     |  2 +-
>  include/cxl/event.h        | 22 ++++++++++++++
>  7 files changed, 132 insertions(+), 22 deletions(-)
>
>
> base-commit: 552c50713f273b494ac6c77052032a49bc9255e2
> --

I need ACKs or equivalent for patches [3-5/6] from the designated APEI
reviewers.  Tony?

