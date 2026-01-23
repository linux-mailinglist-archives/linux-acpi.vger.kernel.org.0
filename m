Return-Path: <linux-acpi+bounces-20592-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJuHNznJc2mQygAAu9opvQ
	(envelope-from <linux-acpi+bounces-20592-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 20:17:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BA17A117
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 20:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F5103002D11
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 19:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA92B2147E6;
	Fri, 23 Jan 2026 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5vkftOj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C41AA7BF
	for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2026 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195826; cv=none; b=DEt+VRPbvwqVqAMqw4tLNTDWyE5zYTMlivnvqymHUby7PKnN6esJbvbPphZgjGdbeM9uTdxLY3rXTwP5Gv8uCUVWg3ffCv2e46aiEa8dWNtBLnU2qZx6m0zYzr3mT59swOneDb4mRc+XaQ/C8LH1I/ofMd5qirr0l6Etnc9K0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195826; c=relaxed/simple;
	bh=mNV2qABb6j0tq4GAx5D+hClmWpJtg9XLRiYnkwu+I/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv3D7OgrPL1pQ9dxcQq3OKcx90uckoPYgxL2mbs7mq723Uv9513hMmYjmKBIuqjQeyUFVILsH4JpXHsWbexE7On5C5JvszRKMKZp34EjY+dsPEF/QGeQLV+AEhDVWEZSA6yLes7NdPxgO7MrXCQGUgZZ/zNyyuC1juYcV568+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5vkftOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DC6C2BC86
	for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2026 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769195826;
	bh=mNV2qABb6j0tq4GAx5D+hClmWpJtg9XLRiYnkwu+I/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P5vkftOj/R0zJUjxeHzLzhV6N9y96dmwCTC+/tVn/yhEQiq8rZ1fAbq6zZx6l8ksj
	 c55zYcsOWNPHN+xAXF0B1zDmkD+Pjp/VyWjefL7moWa+NgcAZB4CK6ZxowPfPagVRF
	 mERTHRrtTkL0v5/PP06zJDpMM9FdUH1MvCrGCC3gfE4NLvknv/wJDpXdvfavgkqId+
	 1NPNgaDfSFtQrJXi4NJrYuhLbQdQ7YZIQgwkhREIBMMkkndjJyyRpvNpwj2kODQkfB
	 x0MKLDdVh/h63cZP4ur/4S7fL2d30lU0mlG7gGRcN2bwF5A2zdzaxXMU31Eaj8b7QY
	 DEJo7OkgxcTyQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6610b45598fso1182805eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2026 11:17:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlPdTSo+UaWzXriI+g93FeOIfMGcduaDymX76yDQofVv6lY2r4XjROBZXPVIULZnJYaaVh1IyeaSw5@vger.kernel.org
X-Gm-Message-State: AOJu0YyPnhxULWx0uUOFEoOkqxOPRKK2TRetVChYpdRMLcNGz5k5L61r
	mHb243MHL0i2RKkPt336QkNtGGip2eR9PJolFZ8FETZeqI9K+XvFT0AgXARSQao23WCREXXU0AR
	/IdGfBcIk+i7fObOQo6FOfTUqLr1LWtA=
X-Received: by 2002:a05:6820:f06:b0:659:9a49:8fdd with SMTP id
 006d021491bc7-662caad7d80mr1675999eaf.10.1769195825317; Fri, 23 Jan 2026
 11:17:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121085105.2282380-1-andriy.shevchenko@linux.intel.com>
 <20260121231520.GA1221379@bhelgaas> <aXHYuwPiC1KAceZm@smile.fi.intel.com>
In-Reply-To: <aXHYuwPiC1KAceZm@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Jan 2026 20:16:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h2QO9BmCvzpJ0dBjs6gtnvj6m6pCr3fhQNADgkpmK+6g@mail.gmail.com>
X-Gm-Features: AZwV_QhWooXHMXW3DyGLOV99PRnxQji8lLi4H9PQg4dJMEDLI6-oLfq-P0xitp8
Message-ID: <CAJZ5v0h2QO9BmCvzpJ0dBjs6gtnvj6m6pCr3fhQNADgkpmK+6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: PCI: simplify code with acpi_get_local_u64_address()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20592-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8BA17A117
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 8:58=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jan 21, 2026 at 05:15:20PM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 21, 2026 at 09:50:49AM +0100, Andy Shevchenko wrote:
> > > Now we have a helper so there's no need to open-code.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Thank you!

Applied, thanks!

> > Looks like most drivers/acpi commits capitalize the subject line,
> > e.g., s/simplify/Simplify/
>
> Unless Rafael wants this to be done I would leave it for now as is,

I don't think it matters that much ...

> but I will try to remember this for the future contributions, thanks!

... but consistency will be appreciated.  Thanks!

