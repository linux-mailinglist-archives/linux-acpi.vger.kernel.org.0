Return-Path: <linux-acpi+bounces-20978-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDxvANIpj2kPKwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20978-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 14:40:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE031366EA
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 14:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C6D30459E8
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 13:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC2235F8D0;
	Fri, 13 Feb 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK0SxqN7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972B35E553
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990023; cv=none; b=Dp6s1pQuSpmRPTtOi12lIP1yavH7vl3T/KODbs/VIOz4poIKRrobc5ALr+3xOTjEH+I2NzMCXvp4zTgmZdfFLfIZhpcNi1E/YtlNIzp24BbcVCYuaIMkZX2d3s96ENqcZqbW/HKS/tGpOYjfwFgBHnquaBQj/Nmne+XMV04Zfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990023; c=relaxed/simple;
	bh=7MY1B1UvCrSA3CucaXSszMAkbqV8VVdnJQLaeVMJJEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BruOpg0JkBZnZazaW2FxOPYeLzsH8cTzRq3eOTYqISeUBdKDXHWMwgUMzGJfzdKvVxofeKqaaJS2IotQGdH8BGyd5O0RzC5Wi2Qkpg2HEtYJAIWyPUn5oVLf8jxdn27vrdPjPwh2Xu5/mE4VdkEwu2YLrVCt21XGbDxssTeXMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK0SxqN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D1EC2BCB2
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770990022;
	bh=7MY1B1UvCrSA3CucaXSszMAkbqV8VVdnJQLaeVMJJEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qK0SxqN7uhf6x0JWJsEoOs4rWCTmI3MSohJVdIJQaNQaAtP9+oOLBvwtelIlchnBj
	 gsXzcF/AAL9og+tMuh3oyG3e/+05SakJDwvhF0Q37tjUybIkL3ngNt/PVrPIkKpZ+y
	 gUm9ahQBKcGKGMHrxF5+xUmBKu6ioNt7k1ZAFKg+WuP/yf44d+5Ic1hugfTcZVZ6Zg
	 FbLpfXysqXNgEfx80pcnfyF25Hvk7Ji68BHhjYS2PFInzmilBo1uks2HMRnB9c1B8t
	 wWiWktQpVjZHXOTOHMbgocbwnrOHkJbwwD1wYkIDuZ7RqRpA3hmt6Zjb8mQdrGCDCJ
	 +UHfYmrXOM3tw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45c8e85deffso311677b6e.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 05:40:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUee6fe1o4zHtExtSarALC3nUGfFZOj1L6S79XFGK8uBBYfNEc6GtFcKKlIsZVT7fj4l2fFn2B8+maX@vger.kernel.org
X-Gm-Message-State: AOJu0YwySGviyPG0dTVQl23OhmQ9o4eIONWrUU2r6xCn5MterMT/jwU4
	mqYAvPpbHLXxzc1n9qwDd7qtRPu0Nr9wDu3BMmZ8gH+CVTyDZvqCI6KHuXiknxEI7wDnaxqzWYz
	KQLe8BF4XG3Ft59ONkJv+EI3zTHnLuqQ=
X-Received: by 2002:a05:6808:3507:b0:45e:d128:168d with SMTP id
 5614622812f47-4639f254eccmr771419b6e.57.1770990021866; Fri, 13 Feb 2026
 05:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201130334.3107-1-sef1548@gmail.com>
In-Reply-To: <20260201130334.3107-1-sef1548@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Feb 2026 14:40:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jtroqWSwjF3KQsmVLPYEE4a59-cxg5ZV1BAGmJtf-Q_Q@mail.gmail.com>
X-Gm-Features: AZwV_QjRfNwroLEpmaWTExdQL-bTxgB5i4BtjRUWwxg2WPTNiln1lUbMSVduiKc
Message-ID: <CAJZ5v0jtroqWSwjF3KQsmVLPYEE4a59-cxg5ZV1BAGmJtf-Q_Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] nsrepair2: Improve sorting performance and add tests
To: Nick Huang <sef1548@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, paladin@ntub.edu.tw, kusogame68@gmail.com, 
	ceyanglab@gmail.com, n1136402@ntub.edu.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20978-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,vger.kernel.org,lists.linux.dev,ntub.edu.tw,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6EE031366EA
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 2:03=E2=80=AFPM Nick Huang <sef1548@gmail.com> wrote=
:
>
>    This patch series improves the ACPI nsrepair2 sorting implementation
>    and adds comprehensive KUnit tests.
>
>    Patch 1 replaces the O(n=C2=B2) bubble sort algorithm in acpi_ns_sort_=
list()
>    with the kernel's sort_r() function, which uses heapsort to achieve
>    O(n log n) time complexity. This improves performance when sorting
>    large ACPI package lists (e.g., _PSS, _TSS) while reducing code
>    complexity by leveraging the existing kernel sort API.
>
>    Patch 2 adds KUnit tests to verify the repair functions in nsrepair2.c=
,
>    covering:
>      - ACPI operand object creation (integer, string, buffer, package)
>      - Namespace node creation and NAMESEG comparison
>      - Package structures for _PSS, _CST, _ALR, _PRT methods
>      - _HID string format verification
>      - _FDE buffer expansion
>      - Sorting logic with ascending/descending order
>
>
>
> Nick Huang (2):
>   ACPI: nsrepair2: Replace O(n=C2=B2) bubble sort with O(n log n) sort_r(=
)
>   ACPI: acpica: Add KUnit tests for nsrepair2 repair functions
>
>  drivers/acpi/acpica/nsrepair2.c      |  87 ++-
>  drivers/acpi/acpica/nsrepair2_test.c | 854 +++++++++++++++++++++++++++
>  2 files changed, 916 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/acpi/acpica/nsrepair2_test.c
>
> --

The ACPICA code in the kernel comes from the upstream ACPICA project
(hosted on GitHub) as described in
Documentation/driver-api/acpi/linuxized-acpica.rst.

Changes to that code need to be made upstream from where they are
picked up automatically after every upstream ACPICA release (or you
can speed that up if need be by sending a Linux patch based on an
upstream ACPICA commit).

As for the test part, I'm not sure how useful it would be given the above.

Thanks!

