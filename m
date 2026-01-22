Return-Path: <linux-acpi+bounces-20567-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO16Lr5tcmlpkwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20567-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 19:34:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F186C821
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9943730D28B3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477F334C05;
	Thu, 22 Jan 2026 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qevJb6v4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546892E6CB6
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105082; cv=none; b=kMTLHlJq+wSXjHvcs18pXNcoZX0MIns2Ug54VdkFQMA109/YO9TAwjBSV4m75ZDscLr9wGfz9ouhkUxZxSmtyId5vvC7ISkC4MCQ2GpRJ0MogbBT6WyT+NSR8TI2BGHRJi80hc05rgbtQa8HJk0NlUIa2oB+ysNeROvW3PzZlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105082; c=relaxed/simple;
	bh=50jCvLfafgTJKlBx4TNcRE0GswXckD99GJHX693Wj5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvojQ0WufYslmp0kK0adWIsxPp+FTnw8Z/28gYS36yXhKMjXPPGCvS5eN3QKVFtbfC1pOYXi97J0cbrkinVUgp5qflK8AhMrIDS3lYtyPuK+4KyKSC8A8UnJSCSLYkFjCXUAhDzTj2/GM+LtYQRRJ2MgID8zSOsONufHle6kNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qevJb6v4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C532EC2BCAF
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769105078;
	bh=50jCvLfafgTJKlBx4TNcRE0GswXckD99GJHX693Wj5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qevJb6v4nzA9Q43KN0+ShIyN1tSVYdTDlpm8Ni8vkJcqlbCCviQsbsqk9TsRyJoBg
	 axhQf9skPrpQVEFJ9NtodEaTsy1SssNyGWtdUGT9nr3blh4yy0kddbOaGVEyXD3esl
	 DVxuRxlglN0OcPYBa1darK9+sFe2fRqvudDt4/EXLm7pr7TCv3kvVGtMR6590rXAdy
	 3k0ZyWFujyQSkqtBCalcHpr2DWES2MGkTo1o8zl/wtvklljd9jPNfJXp0DKQLc/peu
	 CVw8Cg98ljofLnDO4xnZvjFA5VJ2E1LmjzBbrCkfZoFlInMIu49QrQfLA1cPUghCu9
	 CS8oCrnlAUALA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40438a46d7cso737489fac.2
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 10:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1R3StPxgzGMKMCuguVLhbuakY9BQnJpuf7Mj2lXr0V3ThBxO9EoKJidZMjbXNP2csmqQa1qJAtIIm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Y8JlMnOPHjJWuR0bL+CnsAMQSlysXZc1Zd2BXV/q/UVacK9e
	hk81+/aUThR079VtAnzBQkZZuFWeGLJcpqxAh9I6dczMkbbfYOFVT497c7nR8l2xf4AwBMeclSi
	YNLK7XQ7uVj2Y8Sb43kXVJFq/mLOJ0OA=
X-Received: by 2002:a4a:e90c:0:b0:65f:6c0f:fb25 with SMTP id
 006d021491bc7-662caa50dc2mr300656eaf.0.1769105077740; Thu, 22 Jan 2026
 10:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
In-Reply-To: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Jan 2026 19:04:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gL3MzhyS2SOELsgztdakFU984UB+TKaMA13kd+7ssj_Q@mail.gmail.com>
X-Gm-Features: AZwV_QigS_IDqY8zG8-OjqcAGJs0e_wILXZ8LUPsakPf3visMH18m-JhadZCIt8
Message-ID: <CAJZ5v0gL3MzhyS2SOELsgztdakFU984UB+TKaMA13kd+7ssj_Q@mail.gmail.com>
Subject: Re: [Proposal,Question - refresh] ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, 
	Jan Aleszczyk <jaleszcz@redhat.com>, Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, 
	linux-acpi@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20567-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56F186C821
X-Rspamd-Action: no action

Hi,

On Wed, Jan 21, 2026 at 3:43=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> Hi Andy, Rafael and others,
>
> (based on the previous thread [1] - now involving more people from
>   networking and DPLL)
>
> Thank you for the insights on _CRS and ClockInput.
>
> I think we have circled the issue enough to identify the core disconnect:
> * While the physical signals on these wires are indeed clocks (10MHz,
>    etc.), from the OS driver perspective, this is not a "Clock Resource"
>    issue. The NIC driver does not need to gate, rate-set, or power-manage
>    these clocks (which is what _CRS/ClockInput implies).
> * Instead, the NIC driver simply needs a Topology Map. It needs to know:
>    "My Port 0 (Consumer) is physically wired to DPLL Pin 3 (Provider)."
>
> The NIC driver needs this Pin Index (3) specifically to report it via
> the RtNetlink. This allows the userspace daemon (e.g., synce4l or
> linux-ptp) to see the relationship and decide to configure the DPLL via
> the DPLL Netlink API to lock onto that specific input.
>
> A generic ClockInput resource in _CRS is anonymous and unordered. The OS
> abstracts it into a handle, but it fails to convey the specific pin
> index required for this userspace reporting.
>
> Since ACPI lacks a native "Graph/Topology" object for inter-device
> dependencies of this nature, and _CRS obscures the index information
> required by userspace, I propose we treat _DSD properties as the
> de-facto standard [2] for modeling SyncE topology in ACPI.

If you want to call something a "standard", especially if it involves
ACPI, it is generally not sufficient to talk to Linux kernel people
only about it.

ACPI is about agreements between multiple parties, including multiple
OS providers (Linux being just one of them) and multiple platform
vendors (OEMs).

To a minimum, you'd need commitment from at least one platform vendor
to ship the requisite _DSD data in their platform firmware.

> To avoid the confusion Andy mentioned regarding "Clock Bindings" in
> ACPI, I suggest we explicitly define a schema using 'dpll-' prefixed
> properties. This effectively decouples it from the Clock subsystem
> expectations and treats it purely as a wiring map.
>
> Proposed ACPI Representation with proposed documentation [3]
>
> If the ACPI maintainers and Netdev maintainers agree that this

So long as you don't try to update the general ACPI support code in
drivers/acpi/ or the related header files, the matter is beyond the
role of the "ACPI maintainers".

That code though is based on the ACPI specification and the related
support documentation, modulo what is actually shipping in platform
firmware on systems in the field, so if you want or plan to modify it,
that needs to be based on something beyond kernel documentation.

> _DSD-based topology map is the acceptable "Pragmatic Standard" for this
> feature, I will document this schema in the kernel documentation and
> proceed with the implementation.

Kernel documentation is generally insufficient for defining new
OS-firmware interfaces based on ACPI because there are parties
involved in ACPI development beyond the kernel that may be interested
in the given interface and they may be able to provide useful
feedback.

I, personally, cannot really say how useful the interface you are
proposing would be and what it would be useful for.  Even if I liked
it, there still would be a problem of getting at least one platform
vendor on board.

> This solves the immediate need for an upcoming Intel SyncE enabled
> platform and provides a consistent blueprint for other vendors
> implementing SyncE on ACPI.

And what if, say, MSFT come up with their own version of an interface
addressing the same problem space in the meantime and convince
platform vendors to ship support for their variant instead of yours?

> [1] https://lore.kernel.org/linux-acpi/3bf214b9-8691-44f7-aa13-8169276a6c=
2b@redhat.com/
> [2] https://docs.kernel.org/firmware-guide/acpi/dsd/data-node-references.=
html
> [3] https://gist.github.com/ivecera/964c25f47f688f44ec70984742cf7fbd

